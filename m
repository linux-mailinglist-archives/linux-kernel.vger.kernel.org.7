Return-Path: <linux-kernel+bounces-814505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B6B554D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D365C4851
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B407320A36;
	Fri, 12 Sep 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUb+E3YN"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CF31E10A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695369; cv=none; b=c4vw3GL+Dc2Bmi79Ri9dciJzsYz8ocr2UAPMqnsdv8qj5PtqZuDNm31kXYLy/SZjFG6NVfWr3aLLr69oUgCGNNYqqfWKkPDVZGDkHiVtLOf90CNPxQoCTwurg0Cn8Afzes9QnJNYDZjOezDpWxi/G0t1Ir7OJqWRJLlsNM3J2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695369; c=relaxed/simple;
	bh=lZaPWL908OVj4SrzNG7Ubz2Oo21Sbd6XaAvjzfQjEMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pz3BkjIt8SCMYUYhNX17Y+C5zndrxprQryiOVEyHzROAQ0trv4cTYCY+trieYMuXiXL45jzPvdKXWNP8t1pR2YqPeIUKihu087wph7hEsOsvWPPQoVTKMEkMDsqc3ghH0s9jPJh2qYIGxh99mHS7wGGn/TQcYfZzl1XM8lbJ9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUb+E3YN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e249a4d605so2331722f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757695366; x=1758300166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLwAUPbOiAmud7bKZYKSB1YsNPeEWpmZUaenVfyVXkU=;
        b=TUb+E3YNSSIIFwhlqi1V9rzcVdKEbiAvytIqL4poSIe5F+xiCiXqZH/MHLi8mdySCe
         MOtXLWJDV6XB4fgbVIzx7xdGLbmfTNbHoy2Uzcmnso0yePwzezzdER7/hXcZ82BFIZKG
         tOILUieIeYV4KfjP026WqdhcqPKg5Ytga3lxG8yPtMJpBrenO+ApASoTB/ts9mjDR9GN
         2lfwY33opi53YtygX18nKnww/ML8ZjFHnUUl6w0wpystTav/A1GqO0bRzjc9s1bVzKI4
         yEVm9PQd2numkK/ROiWaErmeQmtU2kcfiIWPINOdmkqqowPxixod1hJHalpPtNy4S9kR
         Ny4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757695366; x=1758300166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLwAUPbOiAmud7bKZYKSB1YsNPeEWpmZUaenVfyVXkU=;
        b=eI48TUXRZ228QowKWO+XQ73lIP7ErSargBnLsAHnqQWk9Cu1zKrTHezeInflgr2Nsu
         aKUrG79IgLljhJ7Yk8nJa8rIFHrLrEqYrp4ThD8ah3FSrtQZzGD26zbwNXdcdafOtmgB
         IDzuFviOldUH3vaRvkg50xkRPBdsFwcANvgFuwuozmNNljwAFcmFSdji2i0uL/19hJqV
         FIlND9YV2Z5elfDHxH8sYGRCjPir8aZLtHJ9e6wYVeZAyLhdMFqGcG0r3AqcnR2uHTxs
         KbpEr0nfb+FaPJb8KqHofU/pvXRNCdnWCdo6cldL78hTYfOZjhjWF84jcgCnBOt1KFI/
         u9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUbfPzT1Ba2K4gOofXfemtAUG8OrP32C9nLtDyxeJ/yv3LKuz9tkIjDi/cXKFYzmfHvGjSlMDXngvraejM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQfqP1YNc666KFqyvz1X35QSRI+kUYEC4dY4wrrVPJvsp4ptKi
	/GG80toixe0fas6zY+mJcZ7u8M0v+llP1tBqnos68QxXdxe1CXXaDpH3UCcOdw==
X-Gm-Gg: ASbGnctfzMajUBWSmOYYeSrcGF6qVM1rz5bZi63sX7hLnGZM8WV1DZ++IhkSmoIoWW3
	4qFttaRB8A6m6T125ighL3u8IjvgHTT8c/gX9WsHqTkHZArm4wAWHg7iDSjDyCiLcGYSXeQeuA1
	QdWJtNWZCkK394o7UXjq0KlDv4KEPW9L8ro4PHy3+6Ukbm803PmQeoFav+IIbp29pw9RTaHwSvn
	toIJ8OKzDhLkbhgalAV/UW/RQ0tUO/IX/nNIVDDdibpGR+BhowNNXiPvf4l5W7p5PLP+nChQ9aD
	NUjdPDknlU48dSVgRnFREmX0WnsAexWlIGBZ3n8EiaMosSGuptdZHANFNJlFLMqR866iEDGDL/y
	uirjbRKw5LUTH0XOn72I8ZNBnU218Uh4hV1E0bgsymocUXsb8ON4vxxggT6B91+8RN3VIjwHPak
	M=
X-Google-Smtp-Source: AGHT+IEKnltXeeMvVDI2QemSGP+MIU6It7d9Of00qdZt9eZWQWOA1s5MS+l2BWMiGa13PqXhzaHkNA==
X-Received: by 2002:a05:6000:402b:b0:3dc:eb5:503b with SMTP id ffacd0b85a97d-3e765a1607cmr3933540f8f.56.1757695366194;
        Fri, 12 Sep 2025 09:42:46 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([5.225.138.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm7086696f8f.30.2025.09.12.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:42:45 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 12 Sep 2025 18:42:13 +0200
Subject: [PATCH 5/5] drm/solomon: Enforce one assignment per line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-improve-ssd130x-v1-5-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
In-Reply-To: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

The code contains several instances of chained assignments. The Linux
kernel coding style generally favors clarity and simplicity over terse
syntax. Refactor the code to use a separate line for each assignment.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 7bdccb5140195a45d8ffd01e139dd4eb2e3cc327..a09e64719f62562126851e67c4f77d779b861148 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1864,10 +1864,14 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 
 	mode->type = DRM_MODE_TYPE_DRIVER;
 	mode->clock = 1;
-	mode->hdisplay = mode->htotal = ssd130x->width;
-	mode->hsync_start = mode->hsync_end = ssd130x->width;
-	mode->vdisplay = mode->vtotal = ssd130x->height;
-	mode->vsync_start = mode->vsync_end = ssd130x->height;
+	mode->hdisplay = ssd130x->width;
+	mode->htotal = ssd130x->width;
+	mode->hsync_start = ssd130x->width;
+	mode->hsync_end = ssd130x->width;
+	mode->vdisplay = ssd130x->height;
+	mode->vtotal = ssd130x->height;
+	mode->vsync_start = ssd130x->height;
+	mode->vsync_end = ssd130x->height;
 	mode->width_mm = 27;
 	mode->height_mm = 27;
 

-- 
2.51.0


