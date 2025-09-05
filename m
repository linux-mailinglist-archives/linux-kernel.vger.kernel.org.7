Return-Path: <linux-kernel+bounces-802515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D16B45301
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A181891EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E028313D;
	Fri,  5 Sep 2025 09:19:08 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2B28368A;
	Fri,  5 Sep 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063948; cv=none; b=qVnvriQg3+fHnGSQHVYga8x5OjDV8rOHk2nShNzB9FnisslkTFJaJDnqdwEHuBN+v36mQgLAu/+YVp2v+8xaYeoCW7DL9VZPkFgC8IxV9sjpZo7fj5i+ORGRByho6ze0HtpwekNR0I4K1pl6i7xcsI+zaU126fwLw3maDRRupYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063948; c=relaxed/simple;
	bh=QJh7UYdMg5+jnupJYbkvvs22KA7iLIX9cXWjiUUeBlg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MKkrlJ8b+IkVLg3nwm64rabZewY3h1d0n+GJfrJNMgItPLXAaJrRTuUEYp+c0QGTib/WyKXJBj9DpepJLDsINzlEGy24Gl6DTIKO3buLbY0S6lw7s7lg/bvwiCIpKfo66LrE0GeInZpG5IQVsVnIylk46+5kYuyI9238KkJ1xDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202509051718479538;
        Fri, 05 Sep 2025 17:18:47 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Fri, 5 Sep 2025 17:18:48 +0800
Received: from locahost.localdomain.com (10.94.16.219) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Fri, 5 Sep 2025 17:18:48 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <nick.li@foursemi.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] ASoC: codecs: fs210x: Add NULL check in fs210x_register_snd_component
Date: Fri, 5 Sep 2025 17:18:44 +0800
Message-ID: <20250905091845.1559-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 202590517184807ad9422a74d1806161ce1cdb36657b0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Add check for the return value of devm_kmemdup() to prevent
potential null pointer dereference.

Fixes: 756117701779 ("ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 sound/soc/codecs/fs210x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/fs210x.c b/sound/soc/codecs/fs210x.c
index b4f51ee7235a..e2f85714972d 100644
--- a/sound/soc/codecs/fs210x.c
+++ b/sound/soc/codecs/fs210x.c
@@ -1458,6 +1458,9 @@ static int fs210x_register_snd_component(struct fs210x_priv *fs210x)
 	dai_drv->name = devm_kasprintf(fs210x->dev,
 				       GFP_KERNEL, "%s-%d",
 				       dai_drv->name, instance_id);
+	if (!dai_drv->name)
+		return -ENOMEM;
+
 	instance_id++;
 
 	if (fs210x->devid == FS2105S_DEVICE_ID) {
-- 
2.43.0


