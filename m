Return-Path: <linux-kernel+bounces-652981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CEBABB317
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 04:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDE518951CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 02:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6941E260A;
	Mon, 19 May 2025 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTJ+D6TN"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7171DE883
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 02:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747620334; cv=none; b=gNtLRZsnjB5p5B1kbV29KIu+g68AxZFPXPGbSbE5IhO+nPu2mKm/mgTaALRELtkAgY0gI8VBRQPEhsyol7nymfJPskGNp2QUGH2pjGv5vO2z1s8N/hWg64FeoDWzBhwhuaR2Dz7YVAQmHRDgNxUAtFkDYs5KV22trDiqz+uBy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747620334; c=relaxed/simple;
	bh=KuNYkTVSYWwA6JxxznbCZ39dzpJPuPVHpn1XlVTuiTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hCvtwSC3lFTudGIGf5EUwKi46ObP6Y1t7RWPSwp8fOtyP3vrhlol+SlTcJNACVa+Fdt9I6k1SCrLPd1QTtp6zKVheQ2S6BXMM2wyFxgfvzT1IBF5iM3ctUGWJDk5gAaQplRLkL5Ye9rnQR82QiBjFTv0cnQyChKdZSdeL2F56XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTJ+D6TN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742951722b3so3074012b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 19:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747620332; x=1748225132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfHmDfi+DPX6UiPcv/N0w1gisnR08EyU/T2sRMe8FD8=;
        b=RTJ+D6TNKETk6bvjnG9kooE8iwzDN3Tt0gWhkxBS7tSd64wzFflr9A9VovIuSsNkC2
         VabOgcEJWtjORuFH7RkVR0F5YRCj4tt/Ul825fpgnyPVZm7kzn2b+PRIiJ0E8QA8w+qj
         0qwkR8s3YgfjL9+WwbPFKMdcOjv/B2bSJF0hb3ZIP0kK06BnDS0tTtpYeT6dZhjAQxaV
         4hmm5yHB8tngJ3znzxsQKF223NwgS0Q4okNFH15Qq9iEZ7fiS9OBX2RmugufRhGlztbq
         1lx0gZvU59hLk+4Qcdj4THtoPtnS+eN6ycvmmia30eAZWCV3d0kOI6dFWUCa2c7gl7XZ
         fK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747620332; x=1748225132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfHmDfi+DPX6UiPcv/N0w1gisnR08EyU/T2sRMe8FD8=;
        b=FfWnJ9A8D7MbV1v8/V367MqwTr/qLeHGZbYCUmGcvdCdnIMxcTXNgBk30WrpI2K24e
         f6P8jCF3uh/Q3ctZ1u6qzkZLD6F8tUEXqHQUjmOCFjPPk+ysCetYYP9RT9G9O+1TFlxI
         p7OVkQmt3k12HHPDBPbZiU8EnuSMHriFfAVN5iXW8Lq4OqeK1b3BKMEObpfBdt2F+rGV
         FkHS3C6SLde/6LkxNDKEkmoWIdtqbTXJx+A0bwCMErnn5QWWzoz/wCSt2tQwBqbcc4N5
         8xW49NNclW6jC6+RKiiplqg9+SFXUYC//F5JjD8PKHu8N7TWyuI9CJcQP3Lee6VK8SYV
         bUig==
X-Forwarded-Encrypted: i=1; AJvYcCVIhPZtDEU3eWOOOZD9FlSBxHx/pQmAMMh704O8ePgUMaAn+sXQXk7FxfiEMNzRVYEITtB2jrHMk69QQrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiV5fx5PEc0tM8HWES+q/6CWbJW29WAtsSBouz7Ff6MKTwEawH
	94ty+otnhocigtBzyd7/yPonwxc2vq9rGYrWkV3DlwShojeR2jR5F6YGozmVv20nZ7APXtsVg6u
	+P8zmRdSIS9THtkzOrQDp9Q==
X-Google-Smtp-Source: AGHT+IFWhP9qCzE0xp+jghUcFnN+E/k12ZG/1Uh9728niLyC1prSappxNcMkFk73ffaaGfN/Y5Lbn/I5zuqjnXq6
X-Received: from pfbg13.prod.google.com ([2002:a05:6a00:ae0d:b0:742:a1f2:abb3])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d0a:b0:740:6f69:8d94 with SMTP id d2e1a72fcca58-742acba67c1mr13868560b3a.0.1747620332264;
 Sun, 18 May 2025 19:05:32 -0700 (PDT)
Date: Sun, 18 May 2025 19:04:47 -0700
In-Reply-To: <cover.1747619816.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747619816.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <32daa589cf80d2f6f67ed257aa9397128a5458d2.1747619816.git.ericflorin@google.com>
Subject: [PATCH 4/9] staging: sm750fb: rename `hw_sm750_output_setMode`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `hw_sm750_output_setMode` to `hw_sm750_output_set_mode` to
conform with kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <hw_sm750_output_setMode>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9c62adec9914..eb7bae5e2044 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -394,7 +394,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	}
 	ret = hw_sm750_crtc_setMode(crtc, var, fix);
 	if (!ret)
-		ret = hw_sm750_output_setMode(output, var, fix);
+		ret = hw_sm750_output_set_mode(output, var, fix);
 	return ret;
 }
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 7de3a3d44dce..7450eb975b1b 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -197,9 +197,9 @@ void hw_sm750_init_accel(struct sm750_dev *sm750_dev);
 int hw_sm750_de_wait(void);
 int hw_sm750le_de_wait(void);
 
-int hw_sm750_output_setMode(struct lynxfb_output *output,
-			    struct fb_var_screeninfo *var,
-			    struct fb_fix_screeninfo *fix);
+int hw_sm750_output_set_mode(struct lynxfb_output *output,
+			     struct fb_var_screeninfo *var,
+			     struct fb_fix_screeninfo *fix);
 
 int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
 			    struct fb_var_screeninfo *var);
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 49b0d5b91183..c01abfcea811 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -178,9 +178,9 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	return 0;
 }
 
-int hw_sm750_output_setMode(struct lynxfb_output *output,
-			    struct fb_var_screeninfo *var,
-			    struct fb_fix_screeninfo *fix)
+int hw_sm750_output_set_mode(struct lynxfb_output *output,
+			     struct fb_var_screeninfo *var,
+			     struct fb_fix_screeninfo *fix)
 {
 	int ret;
 	enum disp_output disp_set;
-- 
2.49.0.1112.g889b7c5bd8-goog


