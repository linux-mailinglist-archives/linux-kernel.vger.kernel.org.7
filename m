Return-Path: <linux-kernel+bounces-885299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC58C328A1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F564616B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D98733E353;
	Tue,  4 Nov 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwaOCWaY"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2433DEE3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279806; cv=none; b=ZL/+djubdhiY6PyY0/t+gwXBCq1ES8UEz0biAJu35dqNUrpXSrVjp4oisrM1Pt30I2sKYbj5F9ISIOCGqwb1MHrzjzZpUeuSc6QBwLRVmHXnCsje6RDuB0TqcqhT3xmwHnxtNrjF7/kxsF0l5pvCr9zBQHA04zksxwYFBg2LfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279806; c=relaxed/simple;
	bh=aREJ13it41dhVSZnZkEIp556vGl5b/Ra76n/PoBdPPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQtpZ8QARApUq46ZSVjTjnzi5HkxkXfIG4YgN7Yk9Ee/Jy2x1tSfisXjlIoZLBdZ2coSTxRV6bYlJERLPhXIMI7jVE2VhHyfYDDSnbbIUtcM8fe0BbS8PjzA/xTQ3I+6gL0I3T9AV6WNXHVhyOWKtLmDmvwaW3Zpu0/YHxRJTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwaOCWaY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471191ac79dso64629485e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279803; x=1762884603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+/CRDV30StujBfkrHNR5F++4wuDv1TH5QOb5NIYpYA=;
        b=hwaOCWaYTz+Da/sZQ42GwKQ/m4+pLEm8Al5vmIg2ZDUr5R7U8pC+rxqNjknA9rCmOW
         UGv86CovdYhgXqjnp9/fiJT9y/wK8/i5tRcd1IP5oP3BDWceMJarpUAPW6kBAF7duzW+
         z35sIAuscxMBBVxTXW3L53/2uWvZ7bkwXGc/Ok9RSwbsenONxBtUh/va248cm2cyqb1i
         d/5mpS/9797UpHYRAXfmcAsgYMKRrHFjKdry0EeVCepzyY8hCgLeuAysdxeZuNCjXHaF
         9AmOm7gwkCOnnG6j+jZQCs7fyCzz5Ac0haPqkPaxcvcXt1T6e41ivtdlWtXmRYoHHlqs
         ydeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279803; x=1762884603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+/CRDV30StujBfkrHNR5F++4wuDv1TH5QOb5NIYpYA=;
        b=HnRvue5mUXAlIW4slhskuccQ+ogpvX9JgcvuG2B7wDqD+kO0K2tUpxVxDxMIGmyCW5
         n9FHPZYiXJTVDSb2ol3CTOetCP8k2z+6tK5VbGzmYfeGfDvtUL2G6MBwQ4S4DXO8dd9P
         +DunwpQNYbPuHN+PSGI5bNyHjjtiiQ4f69MlUINgVCiMmkvCnj+xsJlQyYPuUwDdJYES
         t4Dx405PaGIhPVhDUOQMOwOhMPzS3O03ROYhLb6LBIkArTMAtKMrXxG26/0jfnpHDqQh
         tPC4WIdlsxVb9/D5TLkym15hNwqUWPJcBxyWEtq6qXPotU33SL1J/93Z6mQUSwVyRrpl
         Sqzw==
X-Forwarded-Encrypted: i=1; AJvYcCWbW4j+RAhV3KR7RBollk/JztzAiBHi81YvJK8uLCavsXjKAcEtt6wIsrW2x48bEhcpUyOjyZ5MXkEDaaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPGnOuM00udRyo83YhGsKQnU+uHRAgy0vr7TnrDLL2oHMyu0o
	Bm3E3PyDQQUxLkzOU2Y7kkPhL+e+VIqhIaFdO7Cxuy0cFVHO2Y3PGG8d
X-Gm-Gg: ASbGncuLNGo2eceoz8jf0kWa817Qe9HnN6AvpHI3xrPP0WUC+1gFcQr/ZHfbs8RxY6E
	HaVfygvBG24Ki/1gY8csOhY3JCjarXi0sbgRq+ZpdnZJVvWR+OjuyuBYh9SYVLvSdhlOspypT+z
	Qz83ms8cKMJXdnRhmbxgGuTWdBE7sFLdVqWhcacLxo3kGz7muK0jUJGjpqoZmMOBrxV3PlyQGP0
	cr/1/+XKUb4sMe4CptVX/WFdQc+PFf6UdHzGBcScgSe4j+AzC0r6ApWuxMZHnMfHu665tuguN2+
	TYSk9uT/pycQRcgo+kBnc2ZFMCmNICRmZbbIw60TvIIwgnV97i/ZXNeYxYkczWZCvirVRi7XZ6V
	FHNoutwnict5I3/m8Ji2TlGpR7nVECas96cOyzwHlVyZ3AQmxCkzGpjN0WgbYC5hHmDeTh41UkH
	w/JZSYxhuv4zxB0AFypA==
X-Google-Smtp-Source: AGHT+IGtn2Tb5IVfUa8fwzSIF6EUNQPbcBikspeOnI6L4J7SH1eZ3RvMdCq27U9/2nMsft5HkQB0Jg==
X-Received: by 2002:a05:600c:5251:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-4775cdbd440mr2296855e9.4.1762279802950;
        Tue, 04 Nov 2025 10:10:02 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:02 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v2 01/30] drm/sun4i: mixer: Fix up DE33 channel macros
Date: Tue,  4 Nov 2025 19:09:13 +0100
Message-ID: <20251104180942.61538-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104180942.61538-1-jernej.skrabec@gmail.com>
References: <20251104180942.61538-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properly define macros. Till now raw numbers and inappropriate macro was
used.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index a1c1cbccc654..b5badfa2c997 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -39,6 +39,9 @@
 #define DE3_CH_BASE				0x1000
 #define DE3_CH_SIZE				0x0800
 
+#define DE33_CH_BASE				0x1000
+#define DE33_CH_SIZE				0x20000
+
 #define SUN8I_MIXER_BLEND_PIPE_CTL(base)	((base) + 0)
 #define SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, x)	((base) + 0x4 + 0x10 * (x))
 #define SUN8I_MIXER_BLEND_ATTR_INSIZE(base, x)	((base) + 0x8 + 0x10 * (x))
@@ -242,7 +245,7 @@ static inline u32
 sun8i_channel_base(struct sun8i_mixer *mixer, int channel)
 {
 	if (mixer->cfg->de_type == SUN8I_MIXER_DE33)
-		return mixer->cfg->map[channel] * 0x20000 + DE2_CH_SIZE;
+		return DE33_CH_BASE + mixer->cfg->map[channel] * DE33_CH_SIZE;
 	else if (mixer->cfg->de_type == SUN8I_MIXER_DE3)
 		return DE3_CH_BASE + channel * DE3_CH_SIZE;
 	else
-- 
2.51.2


