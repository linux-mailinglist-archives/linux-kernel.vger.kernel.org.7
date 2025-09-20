Return-Path: <linux-kernel+bounces-825605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0398FB8C4F6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7EF560690
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5643C28726E;
	Sat, 20 Sep 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJy2cQ5P"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8347F77
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361577; cv=none; b=nPvhgc8AS7LV7m6D2Mgw4DLJprwwKIHqvoiZnI8BUuummz8eGEWLBo0MwTd+uvboz76/kg6yVaxPzS2SxFu/WHLo6S1ZhWIKBhriiqPhfjQBr+3lWoJE1tlI0IGxZFaQJt5ofRMVUw74AvLR5xYd4/nQETsdS4rUJhBO6Y+Rmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361577; c=relaxed/simple;
	bh=Ymhz4POi7eKVLGuF/w/+qOeKrsw2T/cmevT1fA8QBlo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CYadL5lUcjBohSqbeb0ZiJ4eo4kyVjnYMuvN7/FSkFf9Rok1OGsIh9/MABrzKNluxdDORv4OlYH6MgxmaEyNaWNNNhn0E1Krwg+UQpoNRLOa5lJSGUxK2rwAq+wR9wOKtQPz014p8p6QpHedWz+8KJII9Cymq8OMFnZn2PxHkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJy2cQ5P; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so2620425f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758361574; x=1758966374; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9AmXy4+QY1EUkh+fpSVOr355frd/pBEAbEoqii3KVA=;
        b=OJy2cQ5PElympH0frBbTuQOPbYHpptkFsS7U6tZT3+JsfB1rH/NrNOX9+m6T8TADa6
         HsYkaqeZdKIW81qiu47//YBcum8CTdktmAcalbaBse1MWDUg3IxqeEZ5jPFaUADr7enE
         I5T2D51nMVC5LIdxHcOgSNr3zlKT+9RDPHaIssdFZmw+PX2PqjgjNx9KOGL4zntMfioA
         u8X98O1MHvEK+vVHr6YVLbzFzrr6uZYKOkMo8aa17Wg9swLx7qeJVuEf5Drm2mncxmJC
         CKXIPbKhuFAlwvjwDEvB08dYq7gVKcw2wPFFoQ6NvubKT4RZvE0WOeC/hz34gaWhKrQj
         EALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758361574; x=1758966374;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9AmXy4+QY1EUkh+fpSVOr355frd/pBEAbEoqii3KVA=;
        b=m8xOInM6cLCchefYzFSTCn8biXhXDCVH4UYPfLTHnyrwJNjgcbcZqtGTOhCmDsto0e
         qC30GkcJ4elYNKQpml/XvAWwSNDk85LYvMGzlMaZ4wy5sS79PM/gkdJIVPeoYAdRd6+D
         F0VNiQ9TeuBgNnXWAUfOLq7VTpXG1oGvffsmeLXxn51Un/4vsCLvjg+djddLpY6yMRLg
         ehQ0XaYDu9AS6srOzWcHuAabgvkF/VhU2tnrJ1IPUknB6HuLyMpUlIepmqfpmsczB+PS
         Tc/9q2IlEaORmQX0RTtbFceMo+Pg8vBJDHghEdHOFK8ey7V3swMpRWwchZkRpvPiB3q9
         ctqA==
X-Forwarded-Encrypted: i=1; AJvYcCXFgu4uIX7zWKk++LWVn1cXyAjeBeoleygcCceI+NUvyeN/B6nTQJDB/+Q2yyNu8mKc2+c18lh8xfQWvrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0svRBGvGqNQ/XgoGQBJqqj+6jIyp7bTRAyxZc7AUsaKhP2qT
	wJvkNA4CUaKeTfl+cjqJXN05k0Wh2O9sjkHAO3PuRaa4aL3OyH0OX+fR
X-Gm-Gg: ASbGncuH90j31iGsrA9BAG296leMkZwixGklmZaw47ey56KJpyLWQ33ixQMDFfmlxeE
	bC5HcQ1C6ksLnODVAj/wgAE6bkvmKobHXW2FmcdcxU8nhG7pLNlAeGrbIcELfSx+42DWQ0THIDm
	A71+jx/ymNAl8s76Cv0bkyIQDpJvj+bTeBnEIxFT8CQ2T/gv+YUvxSFXZpqNxBh07jQ71SITgZR
	5+ZCg298s+orOqHsl0HLMFJIFM6urdyLAFr51gcKgtv4oJMcqw7ytSJ8nZUeZDKgeeZQbWHxh5j
	1zg0H9bXlv1FLSk2VhZuxv9hodNzLtYclaUQ7MAHoy78tw5F6te3++BuRyrVYx3o6ESb4W3SgYE
	iC/KSLQFSAzgr8/Bz1prIsE+cYocmh2aRcXzRuiN6Iuhx5YFLd71rQVyZJOLLorF5
X-Google-Smtp-Source: AGHT+IEatF3KG2Gj7cdp5qI2sAlIkCwMm4RWqlOem2CllBesxAwlDjeW1w8yej2F7QTtoxZSOOR6Jw==
X-Received: by 2002:a05:6000:2282:b0:3eb:5ff:cb2e with SMTP id ffacd0b85a97d-3ee83cabcc7mr4746585f8f.29.1758361573978;
        Sat, 20 Sep 2025 02:46:13 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.139.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm163883615e9.23.2025.09.20.02.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:46:13 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v2 0/5] drm/solomon: Code improvements and DRM helper
 adoption
Date: Sat, 20 Sep 2025 11:45:40 +0200
Message-Id: <20250920-improve-ssd130x-v2-0-77721e87ae08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMR3zmgC/3WNQQqDMBBFryKzbkoStThd9R7FhYkTHahGkhIsk
 rs3dd/le/DfPyBSYIpwrw4IlDiyXwvoSwV2HtaJBI+FQUvdSlRa8LIFn0jEOKpa7sI0renQuea
 GNZTVFsjxfhaffeGZ49uHz3mQ1M/+byUlpDAW6w5p1Ij0mJaBX1frF+hzzl/GT9cHrgAAAA==
X-Change-ID: 20250912-improve-ssd130x-b45b89ff4693
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

This patch series improves the Solomon SSD130x DRM driver by adopting
existing DRM helpers, improving code clarity, and following kernel
coding standards.

* Patch #1 moves DRM GEM framebuffer CPU access calls to make critical
  sections more visible and maintainable.
* Patch #2 replaces WARN_ON with drm_WARN_ON_ONCE to prevent log spam.
* Patch #3 adopts drm_crtc_helper_mode_valid_fixed() for mode
  validation.
* Patch #4 adopts drm_connector_helper_get_modes_fixed() for mode
  management.
* Patch #5 enforces one assignment per line per kernel coding style.

These improvements reduce code duplication by leveraging existing DRM
infrastructure and enhance code readability without changing
functionality.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
Changes in v2:
- Use a goto label to ensure drm_dev_exit() is called in the error path
  of drm_gem_fb_begin_cpu_access().
- Link to v1: https://lore.kernel.org/r/20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com

---
Iker Pedrosa (5):
      drm/solomon: Move calls to drm_gem_fb_end_cpu*()
      drm/solomon: Use drm_WARN_ON_ONCE instead of WARN_ON
      drm/solomon: Simplify mode_valid() using DRM helper
      drm/solomon: Simplify get_modes() using DRM helper
      drm/solomon: Enforce one assignment per line

 drivers/gpu/drm/solomon/ssd130x.c | 80 ++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 48 deletions(-)
---
base-commit: c571cb70e1ed43ee543c70151e61a001ab2eefa2
change-id: 20250912-improve-ssd130x-b45b89ff4693

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>


