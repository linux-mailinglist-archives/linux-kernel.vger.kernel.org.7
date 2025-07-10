Return-Path: <linux-kernel+bounces-725287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63903AFFCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5BC586E76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E728FAA1;
	Thu, 10 Jul 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rduY9cQH"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA58928FA91;
	Thu, 10 Jul 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137682; cv=none; b=Mu1ZtAJXZ/aLQRsfT3hX9E9tQHetMh02i4PqcFKgsyNrVTbEhTOptP+SRnrQmo/TasuQ+nvamVukOeCS7zaWErpbz5EjuQJaaceJHww5LwNFniYtxEruYxEDN1639NLwqKXiI565J3v2bQY5L3ihVrwl91xJzC74BNRDn8H96zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137682; c=relaxed/simple;
	bh=INz7KzEfoZWjv0Hj1dr3Xxd3M2v2qBOwSQrKcFMOUQE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tossMvh7YiyIoubwXxQeTMlGjATNrOjoMeVCLxPqzdt+sOn4htEPVUCSljKMQ7HU1ti7SIN7Ph3ZXfFccn1tC5YipipTiFRMAXQovdYzxCZ29PYDMPA41H+Ex3Fe//I7RoTgvQWOPgsddbgoZWV49b5HaW33561uKad5vcAQX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rduY9cQH; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752137371; bh=NQ79ido2IH/sPMyuVTJTLIo7AavKH2feMjmTGujZTlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rduY9cQHGBEEIWF+03K53/W/cVLMWesKK6I5GdGLXH/dJhtXxJTWf8was0rjUGgsG
	 KPz0KFpjeKsKUqIhODkHlsCKQQmezlPgPRPyjrUoCluBLDijsVdQOktRDo4BpX6OUS
	 eKv/Y4s6nerVUfts1VHJLARBjoq2pPADyrTYb/uI=
Received: from VM-222-126-tencentos.localdomain ([14.22.11.161])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id C5DA7AA5; Thu, 10 Jul 2025 16:49:29 +0800
X-QQ-mid: xmsmtpt1752137369tq09sdzyr
Message-ID: <tencent_21B82DB792FE0049B6EF5ECD81285669C908@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTkAiA8k4Bk2x6p8F6TRHD/q18drB1bXeEMCfX8pwVkBrxc4+l83H
	 wPh/SjDJjiSzV8yhAexhKm0iGoPcpwlAUojBo5n8LFD7xAziSGEPlwIUtc4gjVCsV1nFZ7JKPPhq
	 X7pglVwUGeEArumcEm5I97fzxd2f1DTGnQ8EjKzbO65xACbrmXEs7r+mh2ltTy6y6J4Tw+Yhm1tE
	 Lmfpj0e0zOp7WhwN1BUkZbOm0L4TgxFar/pWZ0cK0qE0ggp7kaK+cG15dU9XRyUcWKStOTw9VCIY
	 VCixwuNE1Rq13oHyJZwLhH7xawTDBKTJlKwWsT+BFMn07GJA+VhpKFhf5lwAC4EQ2wTTw3c42XBE
	 zybi3okldTn8mecrHjLJnHr3DABpDakyD/PvESvqc9qROJ8i4yA18X+gY/A+Puj/MqTk1l1h0UAU
	 LGkKZTGTtU9f/dEr4ERkPfA66PGUc15oJ3GnkDKzTeupPs9WdOSYDOy4r5WcM77n/TXEfG8kbT4I
	 J88r5XxwiX9AVyrKNJaD/Wes2203/p67q4FPKwvZ8Ya5p/y7ilIEdC0JT/cZcjn4+/HCrYpTjaUe
	 +WP91ri4kxEcLyDCHKzzMIriRmUq7xGSO+9xZ6ghrTegfdHUglH5L6sp+wD/Pglqo6ewilPWOiLw
	 hMHXAnVeykBOPEH7xuxZez0BWI+bNvc3RFUUhP+xp8x2vMPGLuihnI4Sta73eSEujkfaUc09yKRy
	 fYO/UFyrXiYc/1FErUS+jAIhM/Ipu9Q50Iu2o88fDt8HtcUDhsV7TwAy8lI95oJ1jmqXR6q1wvRS
	 INldyl5ESdYNkk2jXG6Y+QhGu70ch0KpIuohBYKb4BKQ8Z8eu0BWXZzWItPGHmTOW8mJv16X+Sdw
	 6d3o62e8YhEUnh0KDXu/apathSnkQANx/GdsyCnibb5fXfVl75H/kGfggcesrAf9PUs7j2qN7bJK
	 w68KoBANh7YI/st7hSsSvUrv4RWhx4qg/YPvPwX1g9a6HEX6TQe4eQ3g/FauzJLye8FDtfME+UsY
	 DlzcIHZBk01TxvyfyK8T+y6CA1IpBzqnqZPgiFE/2L7aRiUONlT886eSmvqEM=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: jackysliu <1972843537@qq.com>
To: gregkh@linuxfoundation.org
Cc: 1972843537@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v2] usb: gadget: functioni: Fix a oob problem in rndis
Date: Thu, 10 Jul 2025 16:49:22 +0800
X-OQ-MSGID: <20250710084922.169557-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2025071026-fanciness-size-1d5d@gregkh>
References: <2025071026-fanciness-size-1d5d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Siyang Liu <1972843537@qq.com>

An out-of-bounds memory access vulnerability exists in the RNDIS
(Remote Network Driver Interface Specification) implementation.
The vulnerability stems from insufficient boundary validation when
processing SET requests with user-controlled InformationBufferOffset
and InformationBufferLength parameters.

Fix on commit id:
commit 5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")

The vulnerability can be fixed by adding addtional boundary checks

Signed-off-by: Siyang Liu <1972843537@qq.com>
---
 drivers/usb/gadget/function/rndis.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index afd75d72412c..cc522fb4c06c 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -641,7 +641,8 @@ static int rndis_set_response(struct rndis_params *params,
 	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
 	if ((BufLength > RNDIS_MAX_TOTAL_SIZE) ||
 	    (BufOffset > RNDIS_MAX_TOTAL_SIZE) ||
-	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE))
+	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE) ||
+		(BufOffset + BufLength+8 > RNDIS_MAX_TOTAL_SIZE))
 		    return -EINVAL;
 
 	r = rndis_add_response(params, sizeof(rndis_set_cmplt_type));
-- 
2.43.5


