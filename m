Return-Path: <linux-kernel+bounces-739085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81060B0C198
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A4416673E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B0228FA9E;
	Mon, 21 Jul 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKX4wnvj"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38166290D98;
	Mon, 21 Jul 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094657; cv=none; b=cT3H/jQmU1nXudHG1bf86r6ldLVIDmu/HXmIP84KLleXh5tO3L8ofCaOIBzHZHXIcTf4JjAs3PP/AqtjsjaBSpVk1cgjH8Fr9OmUQ3cqndJh6PHWLcf2+0/wC+1CMhpau+ILtZqfM7VggILJrXxx7Qhh3kR35rpus+J6G12bv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094657; c=relaxed/simple;
	bh=XIXfugSBmQKeH6uIwZx9ckJkpPo+fuu6lofaI3f2ies=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbQnOGs7PUPQ/XR3aiRRz2kL4kYSrj4a+rSFV/B3SHQRDRQH41Yo4kPiG3ZeA/wPPLMpF+8hGptci9yjMCpxG/6BloerfiajTzUyR6tv+p/qD7d3dmlFW7IlxxSVnp95ltjcd5HodO3dWqD1Tb8NRZVQl+/7EVzGDBCEo/j3LzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKX4wnvj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-555024588b1so4441375e87.1;
        Mon, 21 Jul 2025 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753094653; x=1753699453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCPC3/B/40jAlTbemOzcO7vBZCF5L9R92GLtIRc3FkI=;
        b=bKX4wnvjQ4nC1LlH6I0kXSKsI3LwTkghU2veapPYwb4KkJd5ETTiDS0VvylWBhDbtH
         exiGcj3aif6ZXJ0VCUYcFY6GC48sMDO/F5u4huPiGttE+cK1XqgFsubTzE7Xb/Yhw/Ws
         Fh30fg3hgdSau6OJ5iKsN+Q1XH9wjDx8SNqRDvhGzzJIwUVWFV34GS6wDMbKfgDOngJe
         ETYOkC4OFRKtJz/nC2P2TWWrthtg4+blp0DjbQe91c0A/e/mMA0XON8sLz9s/HGcK9pc
         1av4jS+xLJeYYqBT/1Sp6wyVnI2iVJI6Z01reYpc3FvHGvInfzZhsxq1Gt8EbWVs7aH+
         dsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094653; x=1753699453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCPC3/B/40jAlTbemOzcO7vBZCF5L9R92GLtIRc3FkI=;
        b=djdZZW0NYMw+mBwoaoJh8525Lm62xzAHBwhIWBN1o3LGoeFIM5A82fpIh8sRncUe18
         JDMuH0bFUG2mtk13hGLnW8PXsINkedApMylZU6KOmRr4TJStOx3VvszY29bLr/IeIYOo
         LHhBJjSYIsycc5vgq/owEPgLQmEM2/rYjpcZgIJG0tczxxK0tmaSwMEZY/8VdoweGPmo
         VoWIzTPB68vAUdEU9XUlWxxjNHPglQfng0bdTx1qfaaGCtgVDVOeUlQJ7Kq3P4wReT8p
         qXe/lWpPisAWUuRtp6rVM3ca8ta9wVhEfRD5QGgQjzCfuYBd0UWIzcb0y5Jdvpu22x4T
         Ffhg==
X-Forwarded-Encrypted: i=1; AJvYcCUL1b+V/abKBkC865f2qYDOljAbBGw6qYMJvn2t49aYiPY4ofMjtMcX6dRAOSM+3Z9ZyilDspfVuSpgWF4y@vger.kernel.org, AJvYcCUMpWdb3X696y44tpKvw7q2naYEN+5UdtrWbT8+4v+XeT8aXKeeLKcKjy6WldODdMW0DPz/Gec1AcoR@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1ShOgEwZVZ4qXO4CcYIEO5tJU8Gi+OLJCUoI5BUD94jGfXPc
	AVhNglN5yF43y7dcS+7rANFidHtMcDHFN3MVhcS0Qn4EWJu6Aam0yIhI1R3+l0XibEQ=
X-Gm-Gg: ASbGncsh7c+5Kc5nOFafiA9gSMY//Oxvr58GXfknwoX+sa9u/kmEuZf+jsNWOeISaDR
	FCZiOSWCzBHAEE8l5Q3pVK14ljW/6w2sMOTSKQbflTMJl82GJg1blRvLe8eJ00RfOGDAW/3elJp
	4eGh9cdda8GmIHItcF6b7IveEbJhO6sgR24Fmz4bbo8Ym5xyoRA773k2+ChmIOzW/oyavNWYiX+
	pG/k8z2gxBgUvTm3qdk1xQqcqEesh6aigiArKcmskjL47OPBgHgcKQ1Ez/wpKCoVIDTN+C8JUUb
	r7OnRcnMgrRRFNibydEbRWI9zCK6ZuiLYoKG1E3/V6cMZaqLqOtx6FuIgPSn2DxCN3+oIDM3t71
	lbn/vEZQ4PhDqNQ+22gsmHBKPLaub1vD4XyAmTNH27EY1SjZdmmnNKAKn3TpdVYqfvEY=
X-Google-Smtp-Source: AGHT+IGyeZybIXRYBG+59fD7/AqqBR7UHXGER0tn9h2axe8m3o//fUdJoCEozITZqAu2nxMPNux1wA==
X-Received: by 2002:a05:6512:618b:b0:553:3770:c907 with SMTP id 2adb3069b0e04-55a23ee7fedmr5751878e87.10.1753094652675;
        Mon, 21 Jul 2025 03:44:12 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31db89bbsm1505164e87.237.2025.07.21.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:44:12 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 21 Jul 2025 12:43:32 +0200
Subject: [PATCH v2 2/6] dt-bindings: display: sitronix,st7571: add optional
 inverted property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-st7571-format-v2-2-159f4134098c@gmail.com>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
In-Reply-To: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=XIXfugSBmQKeH6uIwZx9ckJkpPo+fuu6lofaI3f2ies=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBofhnew7GMv2NT+v3oyNgCh5g4eMNJigShe13GT
 gvspkzM0BaJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaH4Z3gAKCRCIgE5vWV1S
 Mth8D/9/skTcbCDfamLf/A6lQPq0n1R3ljI2JNRzOoSpcuZ46YCMGSLOqXbQydXwPmMkcUFhVD0
 KuEnzkAbo+Kos4wnWfFsJH9dOElrGwH+vZqxX2D2tNPdao+SxkL1sIY6Mb6pBUmY/ISjZF89PTn
 yoInDREznwj0erBhPs2DBxJAcyhBnE8ysmqwcSFdrtp+m1/x04mmh8fB45wRsawOc2iQqwjIDpm
 jo2r6Jx9XkYWGPjrNZvu/lgtc002gQ+kCeqYh5D9d/yYwBgyvlDA6BeZRBD27M1krPjVP6aZ/S6
 fyoIRk+Hwk5D3nT4d7wB7vJe79Xf3TVbZhI23lsW+VRecDKkg48tQHAM0ozw/vRPFyuB+/0uk6O
 /aBgPrhIV9YdNw765oHxHIfcbWqsgByeLEcJ8wpCHhchYcJMZgLRk+sGUtNt4cxjdHU3qUBRqUe
 lwyi7vD4obav4HdLl1b5GhlEB19YeGrmABTVdRZ0ZHhfJlKTbuYQ/Fkk7k/jub1ZNFqmPCQEM/9
 fq7hP4RxoiintnwxAi0GKnwn08xfUQZF/orx+oEfKwuPAryWluG/lxE5erV8pr0F5WvmVBSc7th
 zDaX+gy8G+izen9G012TC3Kn2W/TSWW87pQyrlWAMtifDvT46qms85VxPokg/kwMz0KOACTBwkL
 qjVfxbV49T8xHqw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Depending on which display that is connected to the controller, an "1"
means either a black or a white pixel.

The supported formats (R1/R2/XRGB8888) expects the pixels
to map against (4bit):
00 => Black
01 => Dark Gray
10 => Light Gray
11 => White

If this is not what the display map against, the controller has support
to invert these values.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/devicetree/bindings/display/sitronix,st7571.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7571.yaml b/Documentation/devicetree/bindings/display/sitronix,st7571.yaml
index 4fea782fccd701f5095a08290c13722a12a58b52..b83721eb4b7f8d258b4e845f107b056696b8d4a8 100644
--- a/Documentation/devicetree/bindings/display/sitronix,st7571.yaml
+++ b/Documentation/devicetree/bindings/display/sitronix,st7571.yaml
@@ -28,6 +28,11 @@ properties:
     description:
       Display supports 4-level grayscale.
 
+  sitronix,inverted:
+    type: boolean
+    description:
+      Display pixels are inverted, i.e. 0 is white and 1 is black.
+
   reset-gpios: true
   width-mm: true
   height-mm: true

-- 
2.49.0


