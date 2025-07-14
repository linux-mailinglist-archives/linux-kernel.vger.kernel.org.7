Return-Path: <linux-kernel+bounces-729581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF51B038A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0693B45DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45323A9AC;
	Mon, 14 Jul 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAV3+5Qc"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BA239099;
	Mon, 14 Jul 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480278; cv=none; b=oDktpWsOXAiazhZWc/AGIpSu6HJHmVi9HpxtYf21mhsMrViMFKlwSTKo0U4wlHjxAhXv1LEXShVHFYaJ0zc2x6fYLT711zofG0f/ByjThbQ/7HUqzKPPnyy7T3eWeQb+w6ThgF4h/UpPD8Nu4ieCBFsqU2rmwGOO2Z5+/W6HqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480278; c=relaxed/simple;
	bh=X3ffU5ZPQL/iK6X7dL3NI0KO+0AZSsAr7S+Y6bShp/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjUM66Z/BvIYfAVMuhTxLgHAXfKBYC7UqJ+ORczjRQwFMELmNhVyTHIMP0B5qIlVmn76Pw+GuMdAFqW+P8NAnxJ8Xm6bSm3Eni1IVTeXAdOIoEt+ro5WmxR6MmjRdsvgnSWIJW42WP50Q4VoOdKLTvKPWgLEzBV7A8//Rfc3lE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAV3+5Qc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553bcf41440so4097239e87.3;
        Mon, 14 Jul 2025 01:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752480274; x=1753085074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6t5fJRCHpoSZ7F8pJt3tQSM8oWBMiBs4n4p924ZYdk=;
        b=bAV3+5QcIVmt/Az2q/EUxJNLRG3yyVsG9MimajcwUxn/nZxjeJALt5CCcvq8WZ1PUt
         jdiVgNyI7PP5JA0fjyY13RUVEHmShA4I4oYzeJWtBH7IRJavzRKyqIWr8f1i87ecsQ0e
         rETeC0NENPX3aj5qqfwNmSfI3rb023ieobqgJkUxNYQkDP8ZgPj3M3VFkbYskgOloCyz
         ownVRvyjPQNu/QL/3eWroxC6nf6l8H/GiTWYTCDJM9a3/pWd24f1p/8H3k8PZ8VWIu2c
         rZZ3XtTkRbJMp+r3OuPPKDmfmGiHk54rNGGW6E2eJyn5hITgEG8e3HuLEJEmsgnv4XDX
         /8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752480274; x=1753085074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6t5fJRCHpoSZ7F8pJt3tQSM8oWBMiBs4n4p924ZYdk=;
        b=ZK9rpH1grguMRtaqISUTG9gzcNif/jNI8cv66I2yzPJT4IhXc1A2k2GT/LLW29V6FR
         9ZfFspgro36iARZ8ODU5sPnIQiqv3VsTI3ERbPnKjWbKGmH3u8ABiV3MiqSlRUD01u+F
         Jg48Srm0KqTZQLDTdsjfkEJkElXN9aNcu/FtMbvsm97VuTpmzZ9FkL1brcFh+WyKfOcE
         Tfdgz2DAXKImc1yfCraAP89LUDctweXeulAkT2K7KoFvx5oyOAOUCv01gBxXeVa2LqHg
         O/5VjWvgRK2e3WqlQwcOQTv+sNHeYKFAau/k20RUIsnf5Ou00Fqj0vPsHe4IxeBJkTOV
         qLJA==
X-Forwarded-Encrypted: i=1; AJvYcCWJTk84R13H9RcHYfmObkJkOWbhPkZbO33CQszoK18Kv8Af5AJN+pYLEUcR3ReghMijUHx3pl1pK2k4@vger.kernel.org, AJvYcCX3/JOzYRfkv4dYIXxZMUcRrCweuBTSWt1h/I18nskodJ+hAHzJuJEdWCQ61drafbtxYe1QqgyiRHNc7PxB@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1RldssOt375EV1h9rcM890VBLyTjKcabTbAqKTEZ3ipKj4Mn
	66MVoYzarIZCib2DXJzEZyL0szpJlZNw1dep3MAevHf3oNB7TqFLolu5
X-Gm-Gg: ASbGncstv+XT/HxAViFPg8Bmk+Avh4mB+lcdkOS19tz0nfcm4xJiZ0U/AFjLpl9hU5v
	DFCD9vd6dqdwK6I0gI34SvJpkE1G6nmWuS10uii/zUy7DeZ6VD9eqRIUlr9qS+he8eZVjWxDNAn
	CPwC9fSI+J0jcKTP8B3p2jEWLjBxW6WBPoOGvFcDj6e3/XstTeucF6eISp/kvAnmFeaYR+EP5h9
	j2Ftsdf7zYaaMWWO4uPHGRDY0IGPy03Hn55W082HGkbjI7mrhpuPlfTaTta4+KGplrxb2krDHrj
	wk+bcLB6Zvu4JDmL+D9eCTjIA18Ktu921A6aIJJEFpRT3+UEbBShrYicmAlobxy+znHvZXaJEnh
	2QPRb0+riyd99X0MfzptiATQnfSgV0L0pPf/DU5BiX6R0sWDbbbNFhV1UQC82d9fI+MY=
X-Google-Smtp-Source: AGHT+IGO+3QtpME4CCrqHVYceKIs+EzxANjanQNgmj5QsH7D8grBIIDUPIbXCvr+3hhKeD3znxuUpw==
X-Received: by 2002:a05:6512:239c:b0:554:f9c5:6b3e with SMTP id 2adb3069b0e04-55a046498e8mr3794634e87.41.1752480274141;
        Mon, 14 Jul 2025 01:04:34 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6c08esm1864385e87.187.2025.07.14.01.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:04:33 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 14 Jul 2025 10:03:59 +0200
Subject: [PATCH 1/5] drm/st7571-i2c: correct pixel data format description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-st7571-format-v1-1-a27e5112baff@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
In-Reply-To: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=X3ffU5ZPQL/iK6X7dL3NI0KO+0AZSsAr7S+Y6bShp/M=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBodLn2NLRJC7QmCcM48VdTkHlG7HKLR0Zzz7Ym3
 1TaJ9VTuz2JAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaHS59gAKCRCIgE5vWV1S
 MluOEADQB0UdULY8BmNpIjqemT9VnYXMEdA6qIDFPHZZx0uqZXCwOZ2axoaN671SPYSwzAEF0AB
 3Vr1XZMvhG3YkHUxMEceZbc7pv2MvE1czli5gsrh4ckp+C9xpoatCbVfpAPcX8T794+/zF64W7d
 Sjo+nin4O87meWMd2Ydu0488b3b+HwyFOeqjweYkCH7gREvMfYbrHXRK+NTkCXBVyZiDSAFYBVp
 1Jq4CBN/sMwLnTMNpCh2UONgDXICZUBHZrzSpRJrBrq7NvD3GE6mSNARe6kU4wTfiThRQk0kDLL
 oBJriXF2L4skdu8Uhn92YgnXwQOpcNBjNwVJA4gomW/tBbKPxfA+SNXJK7i8k3jE7GsLqdvuBlI
 mbzEEh90o7/Y5eqeUHZwYQUEgh+HfpbmW5bprH2qN40AL113ppFnXzG6qP4SO3mHymMKV7oZQ9D
 xQlhEMT6JGEh5cCBkRplL2QWIowpZLAgNMrXj6Jq09Ab1mWePpr8fIRcUpZ8OC6V07UiREAs1Om
 WVnYdH29cwaisTOz9Mpv2BsG8u120tLnE6cALkjbYYCYng/QdJumP/oajR9lGTNQTXqZ4ty2pdr
 EiI7ogUVMDZpFX36AZTMJhSWHMG1JN3jhGbhtlo4WOJqYzDqLXn6cMdu0mrVxmROQ6D32c4dGgN
 ELSEbufM2TmTyZw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

The comment describes the pixel data format as stated in
the st7571 datasheet, which is not necessary the same
as for the connected display.

Instead, describe the expected pixel data format which is used for
R1/R2/XRGB8888.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index eec846892962dce2d0b86c9c5c226d44135f2b0d..3024c94c890497d1ddbbf0f7f81ec4664f48d580 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -382,10 +382,10 @@ static int st7571_fb_update_rect_grayscale(struct drm_framebuffer *fb, struct dr
 			 * even if the format is monochrome.
 			 *
 			 * The bit values maps to the following grayscale:
-			 * 0 0 = White
-			 * 0 1 = Light gray
-			 * 1 0 = Dark gray
-			 * 1 1 = Black
+			 * 0 0 = Black
+			 * 0 1 = Dark gray
+			 * 1 0 = Light gray
+			 * 1 1 = White
 			 *
 			 * For monochrome formats, write the same value twice to get
 			 * either a black or white pixel.

-- 
2.49.0


