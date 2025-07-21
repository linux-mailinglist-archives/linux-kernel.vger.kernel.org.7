Return-Path: <linux-kernel+bounces-739083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889A9B0C196
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028CA540144
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0877286D77;
	Mon, 21 Jul 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE1ly3ak"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2F28FA87;
	Mon, 21 Jul 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094654; cv=none; b=r0ccoEYpILQQ7cPmaZ2Raa9Dp1m7EAdo3NFcjLBMMqphS4TRg9OUMLMJIYxNTFZ4+dIxpLPuD1fZX54AQQG7WrlnVmUFw9ySzcSRmpt2mQT4T4KvucXnqk/zuFkxz3kUPZp0Xcx1VwHEy6DgDv98KB3X9COgB+GyiILobL79YTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094654; c=relaxed/simple;
	bh=CqXvKoIpv47+9Jo8IQqETyCXrvf0/tNJtdJBkk4iTms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SsF+klk1XnNBuVGmTqLAi+0NvdbsxJtR45YrrpuLeylw3UBufCw7ZX3iHQtOu4K0odxslZmt0S5lCe2SVkaunid373RKhFRf7TLkl8Rg94/Qk90u55Xf/wN52Zh8elU6DVHXbgu+fWktc5b5Qi36F+Bal8ocsRt6neHULrNL3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE1ly3ak; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-556373661aaso3507409e87.2;
        Mon, 21 Jul 2025 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753094650; x=1753699450; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MloNkOxsM+6t7pP0mYVWFSXRLps1DlPfl53Fxu1h82E=;
        b=NE1ly3akTmCzH5GDAHgPgECk1HrMg7haO1lrnY5FW6Sy/p/fHVTF61xU/iRLhJZ956
         Y6gYt7a7wAsneLSQtBILmtHOiATldLgFFjR2Xz6w7HYGIvqzbLKvatY1onGlw68/Uh2v
         K3VmD+7vZVf8ockqzDCYAN4BeXOIgxZa45iTsbKN20WCHm4FSolq6SrjfFP/bR3FsKx/
         aP659unu7N+Mafj5FlEWexFsUGUXhS3tSzEyd0PH25F0jckjPSuAfd2kb+Z4siD0DTte
         xv+X34wUJQabjPUg3hNDd1fmorUszbf/Ib0Upg1vnlp0ix5HI90bnvfqh96T0+eEsPAB
         +iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094650; x=1753699450;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MloNkOxsM+6t7pP0mYVWFSXRLps1DlPfl53Fxu1h82E=;
        b=u6C/DVcsntPrhX6BxBdwuETQ8l5CK+gfzVzXgBvMCZwi15J70ra+ozM0eddmXLonSH
         O9f4Y45R4aEoPmIxljw3aP4YgCwnM/dZC+zxK+JMPEHs1C4lY1C+LlI1ymIuWkZ6M2W4
         /d5hZ9kluUp5dCx7GTvqO0pAYr4+XKTAnBN3ppfAIJQTnrJyxfQUlTyAzTg7VE55YqsN
         Ek+WFtco/ge7bRrNtAD9wiz3h9p/tG1roBPv/haUc3A2UZ25QWH+01et+TnAWZznBmWs
         ahRThyqem4lbdydJNn3hmcmkuS+DxTRQ0G5OQ5dk3N11hn9RqRgXssZz4wIz9/eogCxg
         OAuA==
X-Forwarded-Encrypted: i=1; AJvYcCWdEdltOWaWAhooh9A30Z2V19yjSg7b9vZZm4TiAH0vS22KbcHOB5RD1FOcuveI0IhPW6BaT1/jBPNl@vger.kernel.org, AJvYcCXxfI81o3SQsiohGv1s4q3JspAoeRCxA8sSSgTCU79NsWVykk9xcBl/VqXmgy9gm3/LEZAxUqTN2MutFI7S@vger.kernel.org
X-Gm-Message-State: AOJu0YxEmZB27ZHcYoY2TUPwVklzxlGDsHaOkY8iZ8mmxqIey65slaKw
	OWJOr9niEWckJLXId1WfAQrbtDS++8RSEf2kIGZ2EvqmGGNJz5NBjprp8gK+NR2HKQk=
X-Gm-Gg: ASbGncsFz9babugFS1wYD0A/ORmNexU+d8w/SR59L9rgu9i9Qk/XGC9RJI3bMYn87I1
	IrYGZmp2l3DqF973lifoHjW8UfAuX58CF0V4DR1n4e/eAOh76LUXgGF14KELePV9NxKzYRVyp9V
	vJHYnG0UXCJ+PLNUR81AM5WYprqruMH0uBQWy9h4F18irCday7G4ZEGFbrCFP0h9KvYKhIU1Mxd
	ANoLjHSwROyuhYsTAHLzgg15hGJKJ9kNBKVcgcX5BndFziqpV/fNdLZ1iaUDbdUuCpUxxYRjFEB
	/roujlQNZoSN3qEX0D1EvwA+SqXnRFxY00XyWjSs/VTKKj8WHspDv8W0BjkyDQFhC535hgKMz5z
	hFWUYivYzDNPv60dlXXOgMlnWhQYk2Vjd1OQyv7wS57wemPJRhMQG93E7LtVplt7y4vQ=
X-Google-Smtp-Source: AGHT+IEaTLVSFdGKI+Xh6r3i/xROhu8qw2nQSim/N5dEd1SjI4SK+6UEvIHqBEAnpSME0bPwhkjASA==
X-Received: by 2002:a05:6512:3054:b0:555:61e:ca7e with SMTP id 2adb3069b0e04-55a23300424mr6273856e87.10.1753094649919;
        Mon, 21 Jul 2025 03:44:09 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31db89bbsm1505164e87.237.2025.07.21.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:44:08 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2 0/6] drm/st7571-i2c: add support for grayscale xrgb8888
Date: Mon, 21 Jul 2025 12:43:30 +0200
Message-Id: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANIZfmgC/13MQQ7CIBCF4as0sxYDk1KMK+9huqB0aCeRYqBpN
 A13F+vO5f+S9+2QKTFluDY7JNo4c1xq4KkBN9tlIsFjbUCJWmqUIq9GGyV8TMGuAh11gx1de3E
 d1M8zkefX4d372jPnNab3wW/qu/4ko9o/aVNCCouGtFI4WO9vU7D8OLsYoC+lfACAokjqqgAAA
 A==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=CqXvKoIpv47+9Jo8IQqETyCXrvf0/tNJtdJBkk4iTms=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBofhnUYdvsOrhAWxNuyYe1ew+jZfPzZ5HsvXCsm
 cT6jJBh67OJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaH4Z1AAKCRCIgE5vWV1S
 MnQ+D/4xXxBUtCdOxdnnv1BsrNkNDNDdSuYB6TUb8xOO6EIB2oKUhrg59fICxw+6QMxZt7e2/cD
 fUg2KAODJc2MHYAansVBcSN0mXR3SgevWE4YYaP9GHg5ATwbOCBQGGypw6Ly8wuJCfG744saoNr
 FiACbUffA2ZAdxnmoM7rcZvg3rQyhA2MyuS4RhdJ4GatSN9HNkSXO/me3CSrwf8J0qBA8/fZ71D
 nHjHGxp2qJxDhANpBhGglvmo9+Y2bAMlsgLqkMQ4Z2xpMkBMjHdZZEjIySl++029bDJ8/hvjy3L
 6xyK8iih7pm81MbZ7YD4UGXPb8LEvqXEu8slSx3q6GL5vSoElRzHA3WhM0p1eI0qXg7zahbBWBn
 7Q6JGzh4CUmB+JhgDO0dWYEoseZZ+/bBuLQ95A7GSNhCvQTngWBMsT/8MPBut395flDUsC2KISf
 n+p/gnIfjRrDWpfFem6AFEWqrvDTPzTsh+XM+iPleluHs/HXLyU0rMtDL4aHkW0wSnokHR+2AHd
 GmzKVnjLY+v9nkiSjj4Lymt8njqv5M4AALOnjq8xjiQxe0Pbta7lQXVDdo0Ew2nM1U+ykV5gkmU
 PSMI3/ZPsN5az/Iv8KSoeYjq6gIaHKkMS83UnjqLSKMOoPZTQ7DLRuuWkqZKgWmb6yCK1OKfuN/
 4ArybFy4w6MnLdA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

The goal with this series is to add support for 2bit grayscale with
the xrgb8888 pixel format for the st7571 display controller.

The first patch only corrects a comment of the pixel format.

The next four patches adds support for inverting pixels. This is
necessary as the connected display may or may not use the "right" (0 =>
black, 1 => white) pixel format expected by the supported formats
(R1/R2/XRGB8888).

The fifth patch adds a helper function (drm_fb_xrgb8888_to_gray2) to
convert xrgb8888 to gray2.

The last path adds support for gray2 in the st7571 driver.
Compare the mono [1] and the gray2 [2] variants of our penguin.

[1] https://www.marcusfolkesson.se/gray2.png
[2] https://www.marcusfolkesson.se/xrgb8888.png

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v2:
- Do not share code between _to_mono() and _to_gray2()
- Correct formatting (remove  "|") in the dt bindings
- Implement support for inverting pixels for st7567
- Link to v1: https://lore.kernel.org/r/20250714-st7571-format-v1-0-a27e5112baff@gmail.com

---
Marcus Folkesson (6):
      drm/st7571-i2c: correct pixel data format description
      dt-bindings: display: sitronix,st7571: add optional inverted property
      dt-bindings: display: sitronix,st7567: add optional inverted property
      drm/st7571-i2c: add support for inverted pixel format
      drm/format-helper: introduce drm_fb_xrgb8888_to_gray2()
      drm/st7571-i2c: add support for 2bit grayscale for XRGB8888

 .../bindings/display/sitronix,st7567.yaml          |   5 +
 .../bindings/display/sitronix,st7571.yaml          |   5 +
 drivers/gpu/drm/drm_format_helper.c                | 108 +++++++++++++++++++++
 drivers/gpu/drm/sitronix/st7571-i2c.c              |  41 ++++----
 include/drm/drm_format_helper.h                    |   4 +
 5 files changed, 144 insertions(+), 19 deletions(-)
---
base-commit: ca2a6abdaee43808034cdb218428d2ed85fd3db8
change-id: 20250520-st7571-format-2ce6badc48c6

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


