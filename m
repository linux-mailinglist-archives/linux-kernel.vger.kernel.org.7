Return-Path: <linux-kernel+bounces-731254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99165B051CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7AF7B368B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F34265CBB;
	Tue, 15 Jul 2025 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRZYgjev"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8723717C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561108; cv=none; b=K3CBoTTdd51vwljGUJwIVDQto5yT75bP89EiYqUZkteElfggz0PjLgsQb60WxVQ6cXU8QXU95IrpIHb0jTcQwm9BUf25QU90zTVu3PBo5Cgi5D6O2ciIY8CSBJdjLDcJC9/EdBebTeveQ7nEOgrbQlaW7C+w+wpfA8mBlQXn5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561108; c=relaxed/simple;
	bh=XxaeZ3neYhiWIw0v7Yb/IZodIsNiCdwRVdFvM06g4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scLedUhB1iUooCH3KmT96mUnB3uzlkSbV3P4x3glWHGxELxnniVVgdr5giwoPbG5H8tjzXrJVT01wDRW2GSXhM4inHpElPnYeYW1rBj/U6NxbbK2pAYctE7ef0ZFC1lun0AZfobeztBMlFfHmupB8NToKwugQ74YuK8mv2gCiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRZYgjev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752561104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=njsXx1MQHjG0pYvx/jMfwxyJj9N+8fHFUPSJkTCfXcA=;
	b=TRZYgjevgcctzC+EDMY7AX4suRYuslqYRv/A6DDPSG+2kp8wvRn6oJifJPOODzvjNu78dI
	Lp4zaXytj5UUTfGxALMXk3RYhCvyrClzHTLQv6+eVUn2eWrAiJteeHkYAjyW3mNMHr31lz
	CvTuhJgu1033g+8qcm417w7g9RTMBic=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-1uCqUhBMMHO0ow4WRRgd7w-1; Tue, 15 Jul 2025 02:31:43 -0400
X-MC-Unique: 1uCqUhBMMHO0ow4WRRgd7w-1
X-Mimecast-MFC-AGG-ID: 1uCqUhBMMHO0ow4WRRgd7w_1752561102
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae0d798398bso403978566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752561102; x=1753165902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njsXx1MQHjG0pYvx/jMfwxyJj9N+8fHFUPSJkTCfXcA=;
        b=Ti6vRaMguCxqFiGVp+XqDp0Mi4pIWT9+GXOLCjdkrURTodhAGlItGE08IqxSwa7b53
         ox5uHcRWhvQiZFM2FwFPAhsWIQTX0tcHFgcIbh/usC9JtwB/aZqeMt5i0wdRrI792Sdg
         U4l89wvS0CKriVSdjePyH3QfcBmPyZlJuXYuUOvu3VwPu7JSXvSCLOnLI0nndgfyQbg0
         CnKHTRmm0//N7AtOpHUZLhw/ffK1G0nu0Ko7Is3ArMKFmG972m72STTwAh0zq3+6LT+/
         ZuELW5ZOflzKX5S1OrkjWcON1XKOEak5WFbgT40+W48iEhUtKEd5xtrPrigKelytXItl
         lyVA==
X-Forwarded-Encrypted: i=1; AJvYcCVOkGHkyDsN03by7dJbWUFK5wsAqyWexECzhV4QeaDtsgXVmFjRiccl7u0uPmwUzV0EkZA/X1fglSZiMqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75Ud0Df70sM3wkkFhDp+1L4buDHxJ5clW/wa5Q3peUBXVg6gw
	mBrqeVuSACLAW/Wtp0/lvkoTxksJfWCVlNPDLOR+yi6cMb4/5KHDVUHoiLK8y01hKuG9kItWx/Q
	VVelYnYNknPrZXCtukwBeV7IWg3y3YpDSI1Ccfge8Q7Ulz6siqfKTznqWIJ8ZL5frGQ==
X-Gm-Gg: ASbGncvJsCoDo0j0t1FDQi28HmTBiQKba2Nf1JBgDZn1zZgITL8Y0fZrvaOUGaQ0GfG
	MOltW9CENfPdhZrSTBWVKiGI9/UQWzTGzYcop6TW58EXGhJkvj5fQMSFpNIvKHJs/le+lWmR4gL
	Ej1pN2B/wUOl5fYJR59KyTC85TKAaAR9+CejQTPkIi7ffNlkKH5MO+aMCYyXWx5Fwqg1SbXBpNf
	BYMBXcROyEvIR4QfJdqT7V29ux+OkuZ8nsfZi3J9ve3EAT1KdBOPfteFkI0c6cvotom8QLrntc6
	c6v5wY9xHYmNXuBA1s/o1NBKg0PBLyGf00bbc3uXndTuNgmkkKZqHSw4K94YunDwl/Lq3tmzLbw
	6reeocyHK2A==
X-Received: by 2002:a17:907:3e14:b0:ae9:876a:4f14 with SMTP id a640c23a62f3a-ae9b96bb26cmr146894966b.59.1752561101842;
        Mon, 14 Jul 2025 23:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbahyJQ8uPvvKj2Eu2Bjb83oyH09cB9oPzy2+yyYmKgrlH0TrWtXbUYxonD5LHJNMzFi0wSw==
X-Received: by 2002:a17:907:3e14:b0:ae9:876a:4f14 with SMTP id a640c23a62f3a-ae9b96bb26cmr146892566b.59.1752561101291;
        Mon, 14 Jul 2025 23:31:41 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df56esm945349166b.156.2025.07.14.23.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 23:31:40 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: merge sections for ROCKCHIP VIDEO DECODER DRIVER
Date: Tue, 15 Jul 2025 08:31:34 +0200
Message-ID: <20250715063134.100733-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit d968e50b5c26 ("media: rkvdec: Unstage the driver") moves the driver
from staging/media/ to media/platform/rockchip/ and adds a new section
ROCKCHIP RKVDEC VIDEO DECODER DRIVER in MAINTAINERS. It seems that it was
overlooked that the section ROCKCHIP VIDEO DECODER DRIVER in MAINTAINERS
already existed, referring to the same files before the driver was moved
as the new section refers to after the driver was moved.

So, merge the information from the two sections for ROCKCHIP (RKVDEC) VIDEO
DECODER DRIVER into one. This essentially results in adding the maintainer
of the previously existing section in the new section and then removing
that previously existing section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5efcdb5537f5..d044e4f71ae5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21673,6 +21673,7 @@ F:	drivers/media/platform/rockchip/rga/
 
 ROCKCHIP RKVDEC VIDEO DECODER DRIVER
 M:	Detlev Casanova <detlev.casanova@collabora.com>
+M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
 L:	linux-media@vger.kernel.org
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
@@ -21693,14 +21694,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3576-sai.yaml
 F:	sound/soc/rockchip/rockchip_sai.*
 
-ROCKCHIP VIDEO DECODER DRIVER
-M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
-L:	linux-media@vger.kernel.org
-L:	linux-rockchip@lists.infradead.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/media/rockchip,vdec.yaml
-F:	drivers/staging/media/rkvdec/
-
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.50.0


