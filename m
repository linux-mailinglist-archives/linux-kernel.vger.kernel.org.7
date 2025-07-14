Return-Path: <linux-kernel+bounces-729580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E84CB038A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE67A6698
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91E523956E;
	Mon, 14 Jul 2025 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fevsxjHC"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A0235076;
	Mon, 14 Jul 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480277; cv=none; b=cTpaFgvEUkm9Dmgy0GneDQW7w+GfHd5YS3tPZRXLP3s1z7Lp3Kb+mIHbbw+DzH8+YSRSN7Qmz9OxVmECCwjzllCJdBu82+4598mh3wk+gunshK3ZCjDHIH6zmR6dZ66t6sKImG41uI6c0CzhQrHb7IjLSnKZElDlD8KqFuuFMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480277; c=relaxed/simple;
	bh=VdemDYxwoGsX5z5cbJgVzYaPxYf6yAhH1emKY5iBLU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mdnhi3OkjoOFxY9ZPw9MvoLuNsA++MAfHECpx143jxc8rukLanpHN5I1BFsHeosDLegIp3jq3bxpm/QaKJcZqEumNS+sCAtTrkx0x38Nq79H8PKU/bkp/+l03rAOievMd40GkP+JymTiLHpf6DpVWihRGk3lp2VfwG6HdLAUTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fevsxjHC; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b43cce9efso31837961fa.3;
        Mon, 14 Jul 2025 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752480273; x=1753085073; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jvirFkItcWcQ+NiJlTgNoSlron06gUKLNrK7S9V3Tw=;
        b=fevsxjHCL+Q5M6GYLfDF8t8F2CIfIWQhkkyzHKbpUH9KJ5J5tNSSmDRpWqHorvDrH0
         PLN4dvlHwc4aWFjfq1rtpEhBdTOpZmfo/prm71RTRTDBXADc901QsaLUPjboiihyE6eG
         4XxyXtFbRIuZtW3AZCNqer+pTUq/40hWWVrOXMKKViy1e/rSUBy/pSeXSvHBo9TySK/Q
         3HuHinZXSqgH3jwQOyqFTtqSxTt2aSWjyq97BYjULv3bxvTonZuKkUTY8IR2sB9QRMbz
         KF+6TgK1exGabOG6LlEpkXQ5NBSqQSch1KTYFqM1LRQYBaRJniVQVFLUTIIXLgeI8PPQ
         FJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752480273; x=1753085073;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jvirFkItcWcQ+NiJlTgNoSlron06gUKLNrK7S9V3Tw=;
        b=GXJ+yFFt/aVVbPujGvVHDoesXddDgD1nHWqWW8I3O22Xu1kEbJLBHzRFs8yZcpK6u9
         RlvXPJ+v6p6rxfrH0ghsnwo0BAa9Uc1VQx1tM17mfkwzV9RWDhnt2Dsddk/wJyLxZyVp
         qGJ9VfPl1BH3NhgvCyvmGIflZh29NHoxG4RF6WOSIIJSCfQMftthWP/Ke27OStOU4ll8
         EwoRfC7RiFh6l6XtsCHuhw321FZxYNFBvUfu2gZX5zeT30nQjdMweI3MbLQl9Id/Zapz
         4d9lmb8L0ZK5zmKuckAaKfsh0J6WlhN1tHoIZRzEvlISvCJmqduD7IU6eXgoCiBQTKPo
         DDOw==
X-Forwarded-Encrypted: i=1; AJvYcCV2U1UghAv1FHMlX8Cb4V7/euOU01vKXLRCrrbtLOJIpRnu31GTy9yyokLrLsFDG7KalOM54W/4ZctkDNES@vger.kernel.org, AJvYcCVX0Nv4ZeKY8okwYA4MWsCJdcvRagTcNHpDMP65OYIH81JaaxSj653yialSeQ0AOaw4se+8JWaLbCAw@vger.kernel.org
X-Gm-Message-State: AOJu0YyIOU7uVe2tojDnXXnOfxqSeKUuv1GcVLEUE/0P5UIlx2LYTOL5
	ZCWHsGkC2AJt6ixSLOcpB4e+9fRDj7xk/Xqh0y1McwoLfQA0+LL42dF7
X-Gm-Gg: ASbGnctB4M5mKQ+yYKSre2+mn0TGtfqTnsrS8cxzpk24c/HsfrResGKARrOFprc7mj3
	YdYIx+4+RQd6mlJGZaHVdbdDMIXs1iT/ZObk/JOHNZyUPKtN+U4kp7pio/GHnEz5vLN23iWdkzt
	7Ywc1PBZaMgAPCreUOz6ay1G35uE/GNmM8DOkIy37qm2sSEYO82md6qBWxve+v/RjIzsly4c9VV
	+5vyYIiT3ouu8qFshtPZWwuZcInMUwsw5MFKIVdcUiJ/YClSdgr4pKOBNdGSPHbWU6zELqVRRQA
	QQSboFGedkGzjIh2FMxB/emln5merSSr/pxpvdGqeYOKLot04IAg80D9i0Ah0K9lHCP7qbeqPhM
	m8rzfHWzJrygUifeO3hKzck6QyqGIMMAY9da9MPmU4LJ/1gMyFAqAuH9ApYEawab3yLU=
X-Google-Smtp-Source: AGHT+IFcBts1WbEvyYA0Vx6+vmS1wQaKS3YnZf+cJJKWFxShxfMHga546vRO1hnguq1nUdSfEspuLw==
X-Received: by 2002:a05:6512:1111:b0:553:ad81:4de1 with SMTP id 2adb3069b0e04-55a045fa335mr4273393e87.24.1752480272972;
        Mon, 14 Jul 2025 01:04:32 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6c08esm1864385e87.187.2025.07.14.01.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:04:32 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH 0/5] drm/st7571-i2c: add support for grayscale xrgb8888
Date: Mon, 14 Jul 2025 10:03:58 +0200
Message-Id: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO+5dGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyMD3eISc1NzQ920/KLcxBJdo+RUs6TElGQTi2QzJaCegqLUtMwKsHn
 RsbW1ADFXzxNfAAAA
X-Change-ID: 20250520-st7571-format-2ce6badc48c6
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=VdemDYxwoGsX5z5cbJgVzYaPxYf6yAhH1emKY5iBLU8=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBodLnx1ndHdpvivwvOmVMDh32m4T1vX9zGJbsT3
 OaBA0sUi+GJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaHS58QAKCRCIgE5vWV1S
 MqfSD/9zv7qQdM4bkNmZTisqcBxY9H1KH9Zl62FSQxsz3twUMx0vaRBsxH4WB6NIb6jSMoDFOjI
 z6i6SjjUTWQHxs4kLhqrtk+Li50bEkccKsQq6Xi4XJxhUmbdOxvQA7qwm0RY4ukCeF3D+rXyMzw
 arIdCosSnk6uogtT1R+2dJ1YqO5KCevA5tQs3QUasOQW4UoFjOenbI/u1XWqGaYoUyqWI+kGKur
 sC6/+ApGkFlUAEWkkK6/BB2yqVCyZqv4rOTCXuvBZsuZpP5BmnJnXH5DTs1/vViqSNrDozltr2s
 9hYYpUx4++/YlpADWAn+ItyneENoqHIUJpp2nsjaiw6tbyx+B4LFOLjfgCUYC7ONmkrDBUzx742
 hMzWiIOJPAHty4Vtm6SfSgtxJikv9Rs9/Lzxg8NrIHOAhtkG3aII7NPccTlZz6hjB7l9H+A1jxH
 Wcd8aATsZiSTprkjiLnQ+V2XrpMrsb7Q+3lMAS92lQtLnQ0HvRa2+kdKEFLwgkfwRAoxppFjZKC
 EHOFxNkRO7Rl1BqEToqGotCylW0yPjv+Atg3SzTYra6aXEfiBUp8QvX106OiPVpfUElzb1THAr4
 CGmmSWMCkqZCPFiHAPNuqTRvlBcl9d1zsk6lWPG6mdgaXFfrxwHZ4ThlBHtLeevcFIU9V35ON1x
 VW9agzrZ1lfvpLA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

The goal with this series is to add support for 2bit grayscale with
the xrgb8888 pixel format for the st7571 display controller.

The first patch only corrects a comment of the pixel format.

The next two patches adds support for inverting pixels. This is
necessary as the connected display may or may not use the "right" (0 =>
black, 1 => white) pixel format expected by the supported formats
(R1/R2/XRGB8888).

The forth patch adds a helper function (drm_fb_xrgb8888_to_gray2) to
convert xrgb8888 to gray2.
drm_fb_xrgb8888_to_mono() has been changed splitted into two functions
where the common part is used by both drm_fb_xrgb8888_to_mono and
drm_fb_xrgb8888_to_gray2.

The last path adds support for gray2 in the st7571 driver.
Compare the mono [1] and the gray2 [2] variants of our penguin.

[1] https://www.marcusfolkesson.se/gray2.png
[2] https://www.marcusfolkesson.se/xrgb8888.png

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Marcus Folkesson (5):
      drm/st7571-i2c: correct pixel data format description
      dt-bindings: display: sitronix,st7571: add optional inverted property
      drm/st7571-i2c: add support inverted pixel format
      drm/format-helper: introduce drm_fb_xrgb8888_to_gray2()
      drm/st7571-i2c: add support for 2bit grayscale for XRGB8888

 .../bindings/display/sitronix,st7571.yaml          |   5 +
 drivers/gpu/drm/drm_format_helper.c                | 148 +++++++++++++++------
 drivers/gpu/drm/sitronix/st7571-i2c.c              |  38 +++---
 include/drm/drm_format_helper.h                    |   4 +
 4 files changed, 135 insertions(+), 60 deletions(-)
---
base-commit: a6cfa4c8833944f8912c1fa7f95795753f6376ea
change-id: 20250520-st7571-format-2ce6badc48c6

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


