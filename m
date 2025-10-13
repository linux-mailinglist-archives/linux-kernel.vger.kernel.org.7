Return-Path: <linux-kernel+bounces-850466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FEDBD2E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535A8189E20D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3F26A0E7;
	Mon, 13 Oct 2025 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="aIuc6Cno"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F70E78F58
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357061; cv=none; b=FZ3Tp6Dntn1vaImGuO/YKHwsrUHGy0a/gGRHaq/QtmPmxXBFWE/1DaqFavVU1zeAvAMLYoot3Ll1PTbo9fe9igrNl/9mWin1rVVZjg0kRf9nMIp0kEhIlCqlwKHqePyjLRMRDAWgkTtvmH+NsbhB2Xb6pNAbCrJJT1HRH+oYvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357061; c=relaxed/simple;
	bh=a3DDS0tBA8IXwVlvUxV7E70mzSyPqw2wxeB4QOkT5mM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SSmwo1kZIR6ZUaoffZne7eEuqcKdC3lmKgrTJrmvtQSejBBHqfuezJExFHiDz3FEnEJBzT8UI6y6WzwoyntWBzPxnRBRgubJVHaWjYnrbY/a7TW0vrwBma6g6QPGLFQdd/C3tpHGEWUNhZyRTijxewKeoTUQv8LTx/SqTedVUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=aIuc6Cno; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1760357009;
	bh=Q/uuLf9js9z/EXs6srozdUWvHnYioMzNmsxpTud/CVY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=aIuc6Cno7iOIw7TOTrh40TuIB3yF4iqY9hRC+lHxNSUA9yVwTyTOLxXPbr80lnvhe
	 wH5gTskltIs8RKGQ5lMqLHotuha6A6P2nChoozUkEYDd9TlNiiMy0JPDkkhDoiRCF2
	 cTp1fNHtbJnqxFbPFKegZohfA6D0mV+BrIXYorVA=
X-QQ-mid: zesmtpsz8t1760356972ta422fdf5
X-QQ-Originating-IP: oZPwA1xsQq7gMSkQyGmfYvOtcJ0uuq61byMdQIn0VBk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Oct 2025 20:02:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12518559955510679892
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: srini@kernel.org
Cc: miquel.raynal@bootlin.com,
	mwalle@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>,
	WangYuli <wangyl5933@chinaunicom.cn>
Subject: [PATCH] nvmem: layouts: fix nvmem_layout_bus_uevent
Date: Mon, 13 Oct 2025 19:59:10 +0800
Message-Id: <20251013115910.702784-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NImvdRhE6fHpuvxFa/QAc6C6ECeixN8NAxG60Gpxd2HH6pntKFYwe4Jf
	rpjOjvIVD/bvgFbHuS6GNSnBs5YHoLq2w2AsO581yXWtZy9tYBwLOEwADRVzbQTvsIgYxHq
	oVdafkF1xyPUS+IF1PN4Ey16PY9B11swcj//wbhwlAktfdIntppFqmrQRhzMFe5/fXupGGd
	E+r6ggcMVQhys7l7qGJRuZbqjSMHU4CZhnQ0XE2wymtD7o3uDdQh7zQJ0dm1DH6aZTLBKP3
	oBFdwpgZVwvZbzRlOeFWCEue7QhdmyywKFs6s8KzdOeWnPkLfu0ENn7KW3IpGViO7KvBFHe
	T+FzcHqIazlcZOFSI0rdXzWAJ28iIUkrsIYhnccXvkx33qO3fYQqYD99FtwjYRzsxaEx1R9
	ahY0XRo5Zj5gaZizcgyysjTKEFH8L1NvCC4d8HXB70CFsj1rIsNVzI9KLv6tqt5688OYLv4
	m0gmdfjH/uuOIF+77N1acnPoI5s/nRLUk4LeEVICq/FIDFghUN1+oakPih7lpt5+XnN6XwV
	WE4/cHI9qcQptifU4aR8+ugEfXZiJJ7otNsg0g1jr/SwtdN+e/u/DCjV1HZ/zk0KP7uKC/Y
	QUXTIDI6/39ScS3ndKHvaOktGFgZXsj39SflTFWO9/NCpE7/kgjAqX2dQx9QnNUfrLUwx8u
	4tahpnTFC78gPKlMqeNZl18o+qVq2Dz00bU+TRXBoV1QOr3JGlkwbWucSDIy9sE18GuYskV
	g6UbRa0Bxgrjmkb0CcXtwFTAVhLWrsCNdL2fxa7ekN2Yo5IlMj1O/DaFCF/tjSV6nfgzIWo
	ayMK386sn5GOkXh/Z19Uh+BoL3J1PPZugwnaqzQ0yiaGwaHe56Zz9yIzycmkHn2LOeddmFR
	Z8Zh3sh6/SusJJhcSdb+HLzIu/ptgBaWawtGb0Rco3q4VPH0nZd26uUEhlwqmLQ3JzVQ7JA
	KXDnisABb/WHMjNTddaiqagtoKPjefZEQsC8OjCAobvVENtXeTeOKxFgmFavJLlAty0r8Ks
	8kFpEQGIGEpwlh6wzNWnX9kIZg3hfldam8uJ+0NULJTVY5kjcaRp0Yz5qdQTs=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

correctly check the ENODEV return value.

Fixes: 810b790033cc ("nvmem: layouts: fix automatic module loading")
Co-developed-by: WangYuli <wangyl5933@chinaunicom.cn>
Signed-off-by: WangYuli <wangyl5933@chinaunicom.cn>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/nvmem/layouts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index f381ce1e84bd..7ebe53249035 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -51,7 +51,7 @@ static int nvmem_layout_bus_uevent(const struct device *dev,
 	int ret;
 
 	ret = of_device_uevent_modalias(dev, env);
-	if (ret != ENODEV)
+	if (ret != -ENODEV)
 		return ret;
 
 	return 0;
-- 
2.20.1


