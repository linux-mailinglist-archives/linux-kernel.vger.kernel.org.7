Return-Path: <linux-kernel+bounces-739086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C761B0C19A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23517AC66F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05525293B70;
	Mon, 21 Jul 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWY2xoIz"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89860291C2D;
	Mon, 21 Jul 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094659; cv=none; b=BIywYf1Je7t376MOGOCFuDKNaz1dSJMlTUH3pqiobYupr/Kg8NyNL4VLLgYO/xanxCeg08ABt4LIGuRt7cm32in+8EScjU7ENeCLPr1+lroBVkbPRcUKJXif1gr0R4yKrh/ycxSHta9FXFMYgO9epzNfdKsKhP7Usn3b7K86gNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094659; c=relaxed/simple;
	bh=pofdZO+wzv4XwsWqba5LTe4zsUx4ThM2T3T7ftsOpsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzgbFQcqPj3uOgB/Nse/cddjJ9p/rba9PUZZplPw++kOngDq23kBZ24ofeX6v1D8HJbUdfWiBvyFu219WHbB/3/JzxPQiM24r7RlkJx4NMYwIm+V8TWY9tgrITIVN05ZvM3ry8lzu3SdfM5nFEH/SDT1oVfUbJMRs4CpBMBmeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWY2xoIz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553c31542b1so3637185e87.2;
        Mon, 21 Jul 2025 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753094655; x=1753699455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxAdZWe4deFkVw4HveAlQFq3r8kE1/6molhjhEtjNCc=;
        b=PWY2xoIzj0k2GRVUwTqRqDaY8BgQwfD+u5TiVEin9igi5bNOKssdGN6mTCRM3iAyln
         XztIdTorkTwOLaDJE8s3R2n4p2//NCS8jyL1EhNstiIvEG0sEdo8Jga5CuV14tIHuCza
         niKrf9EA2yyK9Uz+ZI1MsV/ADcKVqE40P9LPxXejlWzSGc9FhsQJnBG6i4t4FY2AhyWf
         JKevnUwUwmgs18MdxCZ56FyoNy80cikLZyOHoZ1LU1tUH8DPLh1N67p02rYvLvRuuyop
         zNv1KDdcZhQ4LjkCIHAGozZZcubSkOc1mxh7x/brkxSp7LyeVPS/t9UYPsIshw0JKd5Y
         0I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094655; x=1753699455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxAdZWe4deFkVw4HveAlQFq3r8kE1/6molhjhEtjNCc=;
        b=gf5JB8F7CF2DTGa8N3DHHPxoRVpn5mhzD+nIl7DgG6QNEjgrB6vmrsxHyWcX/DbND4
         tT/PYpVqaiB4lPNnWrrw4h+tjQmVZQWrM9LdHPGKXK922kCXKuRk7M0slZl/RbDSN9AY
         wVNRzir3uLIbusBeSYITMlr0vlB7qNtPESGMfE1QFQYxe8THYvV0FPNyRZzyMhJFXoCp
         RDQ4L0RtFz90np+iaIJMIMwwx2O3TbdhRW0M0JWQJKDZ+0c7BmvF3v+EvZs/VbgPUVSj
         jEIOSNFeG7sVrZlDMh1EPJVRSCYnwD0bIaFQY+i0rUYrNHlHH1uZXb74SrQz10lXQhPI
         BepA==
X-Forwarded-Encrypted: i=1; AJvYcCUbWcbkVDLI3R8CO+XgdBaYNRireo5Skeyidegtxz2ljbcit38JgwXfzG9vcmCdoZiLJ4feXNb5T8LPsyy6@vger.kernel.org, AJvYcCXnwYTPDNgQX8ckiFh5ovTfb2t7wiCMaWtJCCD/OzdklTEF2VJfFvC5SDqD7ucPNX+suRzzS7PsFZ8b@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZqvtt4D6Mrbqm3zCYVvR3q303OfV5haGJePwQ3cKCQlOTUFU
	VsPmRIPltx6ABk5xR5nxid72QJhOdP6FNUrh1Jb4IpXVjqqwzSl+pApEhVN9xovuXao=
X-Gm-Gg: ASbGncv1GOHjb19r2tXwVby9UD8rg1Qo9iZrtAR76ms/CL6kAsnkoxZcb4QdUoWihVh
	B4m4LUQ56eEdLyF5u7LNtRL6+oOczSmwA9Cr6W1niu2G6xS2bb4dB63iaB0P/0A/O5GmfIr9r6f
	tB4FX0/bEZV0ZXWqzrBqUA7Z/YYm5UqZstKwST/n+PFixJ7egGPpWqEgC2VLxgT2Zn2KAP8MZOX
	wN0pSj/nEQWp6KqCVn1uHF56JZUsSp069q5BID6jjgUNBC/HNcFneFIolrfcdFXhvz1qCsrc9JF
	uILQJ1lsNqFOo8jpYsFOebKGiUFHNvBzbyTf5OQzwlUcQOF4qHOjNEf/cAthQMXI74LyXQ0J+oc
	Y0KsXuYuxk0zfoxQaHp3egV7g6MqeLVnYBbomlmOV++cZETPj2lJvESnzd2RWOLTHKOvJs5g0MA
	AD0A==
X-Google-Smtp-Source: AGHT+IGYWaCFL8xA5EyMa434EWfdLSheJ3rDLZChUay5GLugk1edqdQ6zS2UsVz48U3bLv0JPWIcIQ==
X-Received: by 2002:a05:6512:1387:b0:553:cab0:37f6 with SMTP id 2adb3069b0e04-55a23f06ca5mr5166596e87.20.1753094654822;
        Mon, 21 Jul 2025 03:44:14 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31db89bbsm1505164e87.237.2025.07.21.03.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:44:14 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 21 Jul 2025 12:43:33 +0200
Subject: [PATCH v2 3/6] dt-bindings: display: sitronix,st7567: add optional
 inverted property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-st7571-format-v2-3-159f4134098c@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=pofdZO+wzv4XwsWqba5LTe4zsUx4ThM2T3T7ftsOpsk=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBofhnjRBHsrqsSV2/fq/jzKaw5WsrLQutrj7Ebn
 19MT6dUgMyJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaH4Z4wAKCRCIgE5vWV1S
 MkKfEAC+ZSML1KYLh3tZHsiCOqR1W2O3/mHSafftlzqaA14RiJnPYhJvXz5qVVWNAuRq1/v9LSe
 yT6nYzzDECSCpoaGtBEMjk1CiOoyy+6O0Hn9mdi+kO/93E/PDBc5sPgeqbKWxLFgvNRd8eHhw++
 S2rOZZKE4vQ45RH0DIPK+pe4o2ZCRjGmC5SmE0OyGUM63cg6Yk2IN2S3aDuHhQZyrv5cxhNTlmV
 cLqB7st8fondSA/XsvDbB8ocDnGCfmycS0Jtg9TUUjZo0ZhKV/DoSRbxVL76jzsTBfhl172DNM0
 hDBfSVm9O3Ll4D2iyrzvGfnGxYExP/akGr3zw8DTRuRH/54I/IYulAtwFJuUK3wYMqeNeSVXj7W
 JNvp2lRUhvGzceRhJVf4pbtBFrtOIlfH+DRCizq8IMig/99BCjlSMukEUoOGnI1ZJxbQLICsdT1
 ZRgYGxNqokdFj3BunFvdfa1/TAWoXqH/QeexWnCZUQFuUjtsjdCcNL1J7aOtn3qsY/2HDF2IESP
 5VIAVR443VJwoEXsSjaE9rGhHNGMabpcif546yvD6ipORAsv4KlrrI3TZTLIgfYtpilvrcwMrPO
 7rgrJIEv6xZO5/0vdFAQ0Ox9xp4k+89m1NCjte3wRPRJ9qWYNtYnT0ivlO6xOVPBB8rgQsMVypW
 PQFH2GN0k2tFiYw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Depending on which display that is connected to the controller, an "1"
means either a black or a white pixel.

The supported format (R1) expects the pixels to map against:
    0 => Black
    1 => White

If this is not what the display map against, the controller has support
to invert these values.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/devicetree/bindings/display/sitronix,st7567.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sitronix,st7567.yaml b/Documentation/devicetree/bindings/display/sitronix,st7567.yaml
index e8a5b8ad18fe01429146b20a0b8237a164a7dd47..2eb6d00b5a25632a1ce121c1b43a92b2a4010fde 100644
--- a/Documentation/devicetree/bindings/display/sitronix,st7567.yaml
+++ b/Documentation/devicetree/bindings/display/sitronix,st7567.yaml
@@ -23,6 +23,11 @@ properties:
   reg:
     maxItems: 1
 
+  sitronix,inverted:
+    type: boolean
+    description:
+      Display pixels are inverted, i.e. 0 is white and 1 is black.
+
   width-mm: true
   height-mm: true
   panel-timing: true

-- 
2.49.0


