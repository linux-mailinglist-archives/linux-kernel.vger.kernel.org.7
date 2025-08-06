Return-Path: <linux-kernel+bounces-757814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44B7B1C6FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D375E168272
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E596728C2AF;
	Wed,  6 Aug 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b="T6SsMmXd"
Received: from mail3.ecloud.global (mail3.ecloud.global [135.181.139.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA29C8EB;
	Wed,  6 Aug 2025 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=135.181.139.185
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488059; cv=pass; b=XcHUTcapcOmebh0ZV3MEoXPzkXXg+sowdU35ERleLkh+nZmn6/42R1yChO2maFYQJYTGT5TtfJGhvedPzrZLQ3q+x4UfeTc8gKnpnaRudNS6aaW95VGJgYUKynNci8kZs7Gqh6JC1rv/AZfNdXX78nHvSqJ+1vNM1dVUo3TvR6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488059; c=relaxed/simple;
	bh=iEnVpv6w5MjOwaDwBiXPDo0cqMIX2lN92cBy6+le3w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YdpMzdKIuH05jLT//AzW32djq9Ycl1CIHK+wOU+Z+bvYcpw6wdmcKK9vbmRjpC4Q1YCqO6vJUZml+NHfyDwUwaMfTJtiqYnOyuTM5qAf5cinzhpCetrSXydGqbYhWWYOjeB4RlSwuGmQM8saNhM/MqSQEcJZVp1vTlKiarHJs7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io; spf=pass smtp.mailfrom=murena.io; dkim=pass (1024-bit key) header.d=murena.io header.i=@murena.io header.b=T6SsMmXd; arc=pass smtp.client-ip=135.181.139.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=murena.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murena.io
Received: from authenticated-user (mail3.ecloud.global [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail3.ecloud.global (Postfix) with ESMTPSA id E57A588A57C;
	Wed,  6 Aug 2025 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail3;
	t=1754488055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LjMPDFzW+HuQwFgORsmEAxQAuPPZl/+Yy2R+QuqGAlY=;
	b=T6SsMmXdArAVhx0EftXEdAZ5gkuqBRSD1YqhXjC118h2aXxaPrXUVeDo//Oglo4kjR6l4W
	SCIEKLW9ZbXwMjpguB1oNg0P4NT5oaUaHAn1+Jn9ugN8Sqa7kBjsFph32BVqMejOmUf845
	pO41rBq1RdIX5HSmgGhn1L9+LbL2lAM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
	s=mail3; t=1754488055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LjMPDFzW+HuQwFgORsmEAxQAuPPZl/+Yy2R+QuqGAlY=;
	b=t/H+kgKg95paMjTRTDGYZc+6Qoa4ca/rTRIowxFoLuw8bBz90lu1TJvHsT83uL1lPtCiDx
	Z9B8FcEZ7o6hg7eYkzAmfn6/0RTii5br8+9Y1c6mejQ1rLlv3hF9MHxNOHkBdTFNMzS7vY
	3nmq5XfC6obS2tBloPjNx/DAh89w2mY=
ARC-Authentication-Results: i=1;
	mail3.ecloud.global;
	auth=pass smtp.mailfrom=mael.guerin@murena.io
ARC-Seal: i=1; s=mail3; d=murena.io; t=1754488055; a=rsa-sha256; cv=none;
	b=51xr3Nos65+N+OYQ63o8wcNynCR0dqDSJKcuO30kyaqMW4MmdduovU18RKNp/IxcqlbQt5
	p/KUAImwczQkFofjBT9JalzwBXM5rbAH6NdMprWGoRT3BCmBC9knc23XOv1x35LL/4Md7G
	EomOL2FZCOTFNYNuvdDsmPvlCGgDy0I=
From: Mael GUERIN <mael.guerin@murena.io>
To: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mael GUERIN <mael.guerin@murena.io>
Subject: [PATCH 1/1] usb-storage: Add unusual-devs entry for Novatek NTK96550-based camera
Date: Wed,  6 Aug 2025 15:47:21 +0200
Message-ID: <20250806134722.32140-2-mael.guerin@murena.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Mael GUERIN <mael.guerin@murena.io>
---
 drivers/usb/storage/unusual_devs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 54f0b1c83..7bb5a1d75 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -262,6 +262,13 @@ UNUSUAL_DEV(  0x0421, 0x06c2, 0x0000, 0x0406,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_MAX_SECTORS_64 ),
 
+/* Added by Maël GUERIN <mael.guerin@murena.io> */
+UNUSUAL_DEV(  0x0603, 0x8611, 0x0000, 0xffff,
+		"Novatek",
+		"NTK96550-based camera",
+		USB_SC_SCSI, USB_PR_BULK, NULL,
+		US_FL_BULK_IGNORE_TAG ),
+
 #ifdef NO_SDDR09
 UNUSUAL_DEV(  0x0436, 0x0005, 0x0100, 0x0100,
 		"Microtech",
-- 
2.50.1


