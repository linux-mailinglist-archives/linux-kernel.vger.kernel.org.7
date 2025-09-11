Return-Path: <linux-kernel+bounces-812353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3251B536D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E463A1883F52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17093168E3;
	Thu, 11 Sep 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="K1m6Yb+O"
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C72DE711
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=157.107.129.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602946; cv=pass; b=cLebh/CMfcdC83q5StnePJvdfxu88BlJQaCdcmb1SBm4iJAQZHxiSoIOerkLIYwmvc6rrWy9H5LsTczoM5yQFugSnspjgqrttTkqSoQ/iEyWyXVkrYNIvvFA80uL3UHs1XGyncabFAoUJ4WTf9fshgHjQYRHOMUgKy+Ii9kbDmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602946; c=relaxed/simple;
	bh=K125TaLnE6rH67QMq7lrta9dH3MpE6K5G4fcAmjnpSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHrS9qjERhpSRjSgEd2DcISDKUPgQz8P/UB2ZCBA+TQm37XreVeLhxPD3/h++9P/CLuXfBdBw4c8V9yhza9Ax2XvFf4bcFU8C1hV9VHYy3ROZCyff3QMzj5wyFdqdN8gkpAfykdAXIb50Caka1IjX3ZlO1baykDjZuj2v4tTzmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=K1m6Yb+O; arc=pass smtp.client-ip=157.107.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id EFDAB109F7118;
	Fri, 12 Sep 2025 00:02:15 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwsIxLSDaWFh; Fri, 12 Sep 2025 00:02:12 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 0CAEB109EFAC6; Fri, 12 Sep 2025 00:02:12 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757602932;
	cv=none; b=Mr3QCbW64naX6jNDyArEWO/7KF3Cg19w/7R7hovUM/8nE6zgHuj2caqllD4VwXZbd3D3bvSNp8qZ7sgkoCsJb0w4aXAOipw/K0scPiFaTTnROcWplBY7it44jd4CINbg4ToPQiXm+gpgymH0dANoKntMmoEUuGpCsWCfS476vjI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757602932; c=relaxed/relaxed;
	bh=5Aqnque0KihRjNKJ4iJ+xBotv0bYet0eDs7kStCnndg=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ZEhbl2wnmYGe84OC3lqjnYD4vqGEWM/KUwXfhSsMiLRKqloADrFcA+vB8q59vCkAj4uYBi8frb14bQio259LFjbHN47sv2yJ04zNjSZRJyslWshuZKUTZDJ5tNo7CoX2HhVvt4A1FrfG5rRJh9QtuDGKFft8wnlQjdS9JyMctr4=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 0CAEB109EFAC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757602932;
	bh=5Aqnque0KihRjNKJ4iJ+xBotv0bYet0eDs7kStCnndg=;
	h=From:To:Cc:Subject:Date:From;
	b=K1m6Yb+ON91T/Hltn03sjqj029wIYB7TOoUEBuLoj/4Ho9+uVuWBDDZKbR/VGMVHj
	 H1F50Qq7zPGxAtglmFotKso7ncSkRJuLpE3P4N1lICTQnJhjIlR8Zgcy+h0aNVWl/R
	 j4so7jhXpLP19JaMT32gh8t4hRtulBrfczm2R+GA=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: rtl8723bs: fix typo in comment
Date: Fri, 12 Sep 2025 00:02:07 +0900
Message-ID: <20250911150207.602285-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Fix a spelling mistake in hal_pwr_seq.c:
  - 'configurtions' =E2=86=92 'configurations'

No functional change.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/rtl8723bs/hal/hal_pwr_seq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c b/drivers/staging/=
rtl8723bs/hal/hal_pwr_seq.c
index 2438931ca51b..fba67a7c069c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
+++ b/drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
@@ -8,7 +8,7 @@
 /*
 *
 This file includes all kinds of Power Action event for RTL8723B
-and corresponding hardware configurations which are released from HW SD.
+and corresponding hardware configurtions which are released from HW SD.
=20
 Major Change History:
 	When       Who               What
--=20
2.47.3


