Return-Path: <linux-kernel+bounces-652982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E94ABB319
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 04:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9DE17457D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 02:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A191E7C23;
	Mon, 19 May 2025 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSijgHQ1"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA31E0B86
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747620335; cv=none; b=Z6itFald9T8kof3qBs11xEQEcv/5XQt0RewgopRDS3YhFyi4mF8B2+rXiYFHbW5QxpBCH4lUoRNAsKLXJJ4iOPfNZYNM4Wx7UwDeMwdkL9p7337NmEZoWtfYGbNmjfqS7OdWVorktggZDdm+QcomiGOqO3Mt3/Q8Tv4y7Jfd4PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747620335; c=relaxed/simple;
	bh=vhlqpmusHxL1JZt/ZFHIB7uvHtunhIURE7yXQKjBzcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=StVNoLFNLBBbEssvZGU/kaNsmZqBk4zbkrBaiuT8giXQQ7kmI+n6Jswdp10GKUeqxwJtcevfJIq7eAem9cVEIB+ajW8r4azK5MWs9r6nYgH+TFqBBhWus2eCh6XF2i8z4ZTDHvzW+kGOrRZClZJmXRg3zxZImG9bTmoZ7EdkJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSijgHQ1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740adfc7babso3108711b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 19:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747620334; x=1748225134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozZypt7suTsjkfADlsvIHKWSBSo/SCbJ6vLmSxOgWCg=;
        b=aSijgHQ1vY7nrLtJWwfGmlFV3C6c2zn/Nl0GN2URfzLhlvjT/Dezdjxr/ZXOR9W7eU
         srBkX2095/b+hnAsCW8JzXn/gpWoCTFDa2ZFOE9PeEf2vwLspU36hreh/wDVViWYDFqR
         XaopdEEaHGKG76aOe1ADPdefdMNm6yrv+l7q4BVcfv3Qm7nYPt2pFMURpbtiePYPe/M3
         8+ExSHfHUFOV9ZlF51ABhsJ5y56imAB7PXXiLwL0dZNcMw/zRL6Gs18wDofPJ36x3bZ4
         D0JJfq/jmZzDhhbpTKi4WJGLIhEV0uBDLYYr5GiWB5ujfNhRfrlGVNPKrBYJHkBmyKIf
         Z2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747620334; x=1748225134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozZypt7suTsjkfADlsvIHKWSBSo/SCbJ6vLmSxOgWCg=;
        b=bEqId39Fkvyo2TFuHaBsuhleW4PQgbLgc071B65/0qCvInje0JBo5wZnJk6K1Qj8sa
         GTkJqnVb/o2KRRWotQbacQ5ff5+M/cVN+dObIzgIaAasVsxf3nkEz/fg29QyWBC1MUtG
         HMb+HTt6qRhxBtPhhMVImxnjaDoty89ILVubYdvfkZ7N24h0yCaiic4Qw19VJrKf30Ac
         p49Oiiq2pZd/SQXLw5SIsNCS7TYoxSifRGMj8WtNgXl/zhVAyJjlrVU8w4DTQhzHS6yy
         GEMz62BgH5Xw3ztvrHeqhbj00nMRMPvUd5WrO/VOcx/ox4rHIjtXcSO9phQ5dLmec1G8
         0TKw==
X-Forwarded-Encrypted: i=1; AJvYcCU9TsxLInErUHll2SKvHSSnffLA1F9n1gSPL06pFJv+YeLwML/df9Hf/Ykk4GVmwCK+0HzrSfedXYVJ6ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF3IxERVjgCmu7U19Of/2xtvUbRHIIt6MtaHsd9a9CFVEfefu6
	8bqV6rKN5UMn28ht6ffhGsYf8wOXvZYapQvmyPOA89/aTujNFjNdVLxu8WEJ+Z3hETRJ/1ta/bT
	D+8DAef25Vs0QhLWzWhFp3w==
X-Google-Smtp-Source: AGHT+IFfFJCU+UjTSG6OaFb3YmsS2nc7RqgXiBB94gS8wlNu7QImZL00ebeBdfbpdye51BoIWeJb49t2p8OWfE7o
X-Received: from pfkk22.prod.google.com ([2002:aa7:90d6:0:b0:740:67f3:214c])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9185:b0:736:3979:369e with SMTP id d2e1a72fcca58-742a97ac52cmr13156659b3a.9.1747620333701;
 Sun, 18 May 2025 19:05:33 -0700 (PDT)
Date: Sun, 18 May 2025 19:04:48 -0700
In-Reply-To: <cover.1747619816.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747619816.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <546e9abb8eac1be75f47b51460ab69a5736d8a99.1747619816.git.ericflorin@google.com>
Subject: [PATCH 5/9] staging: sm750fb: rename `hw_sm750_crtc_checkMode`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `hw_sm750_crtc_checkMode` to `hw_sm750_crtc_check_mode` to
conform with kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <hw_sm750_crtc_checkMode>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 4 ++--
 drivers/staging/sm750fb/sm750_hw.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index eb7bae5e2044..d4596590e266 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -512,7 +512,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 		return -ENOMEM;
 	}
 
-	return hw_sm750_crtc_checkMode(crtc, var);
+	return hw_sm750_crtc_check_mode(crtc, var);
 }
 
 static int lynxfb_ops_setcolreg(unsigned int regno,
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 7450eb975b1b..8bf70a3731bf 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -201,8 +201,8 @@ int hw_sm750_output_set_mode(struct lynxfb_output *output,
 			     struct fb_var_screeninfo *var,
 			     struct fb_fix_screeninfo *fix);
 
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
-			    struct fb_var_screeninfo *var);
+int hw_sm750_crtc_check_mode(struct lynxfb_crtc *crtc,
+			     struct fb_var_screeninfo *var);
 
 int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 			  struct fb_var_screeninfo *var,
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index c01abfcea811..3cb69a471c0a 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -219,8 +219,8 @@ int hw_sm750_output_set_mode(struct lynxfb_output *output,
 	return ret;
 }
 
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
-			    struct fb_var_screeninfo *var)
+int hw_sm750_crtc_check_mode(struct lynxfb_crtc *crtc,
+			     struct fb_var_screeninfo *var)
 {
 	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par = container_of(crtc, struct lynxfb_par, crtc);
-- 
2.49.0.1112.g889b7c5bd8-goog


