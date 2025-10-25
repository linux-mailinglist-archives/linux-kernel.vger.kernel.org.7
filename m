Return-Path: <linux-kernel+bounces-869761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1BC08ACF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552131C83751
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E91299931;
	Sat, 25 Oct 2025 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYTyfUSd"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B803261B83
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366622; cv=none; b=jTtBSZSlRxnR6jcGvSX1nf/pRkWWpVWAW0tZvWzK0/CRFt9puSNKYWhT4jt9WgAPCyAa9MBgq9HF3oUl7qP3yeiEIpp5F2BefYADeIdx8exjEAeCIyDCcAfhkq2sA0oT2YZyewM0gFq00HEgrMZ4Jygteoi7FF6n0LdMyaSqk64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366622; c=relaxed/simple;
	bh=uM1zICi2IeNzgDiSdnW52W6bh7sjCXEC60ZWMbk1sEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXCUjEe4xNKK8U1Os+TK+eu1fMZPcu8qtb/i1rA8w6uDdYsj3yqk2alqLOXwqF5939xm4dvUilg9oKO0CaaXGHsVUo/k/hOWUziI/aYGlHh6bPbZGkWlQUuneupUykbswgZOpTL5Ew4ZyEInlSaBpkIic9QLrNuIA3d8N5+Qwy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYTyfUSd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a1603a098eso1698697b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366620; x=1761971420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKM1l0S1H1voKqVnV3wmOtndsVV1rHqN2zk5FLIUsHQ=;
        b=nYTyfUSdkQ9YjK1mqym09CgvGehUcPGjD9qFUzAkXsnOK3cTlPy6CpXVt8ZcOwnXwl
         oMzwM0mh0eeqeptWXA/mOuoOWq0N0DwdMqxFwXok5LLGnLFq6ZZ6Q6cuVPVvanHuvoQQ
         0CcogXNjcOIywn3hu4eJkgKYIYFd/AM3MmBa7+vaWYr2MHbR3L+ydcMfrQ84/4y9brrH
         5rlm5WHfNxahmwQ1xXu61YLxNevCEAp6yma38/XcICZSrF0T5u/eFz4k2ArXA/LOJxIv
         wGpLXN8xo/h8jyXoK9Qlb4Jqa/hAZH5sHpbqV8TNz7lFffnElOmzBRCXfYh0CaTsO/CM
         5riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366620; x=1761971420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKM1l0S1H1voKqVnV3wmOtndsVV1rHqN2zk5FLIUsHQ=;
        b=ASJXTHUDUuIZD1ycub5Gsz1RQ3ejq7R4DAXAyvjHF+f9vULVP05L422Fcv6jx8gBUa
         ZHrOxo0CU4gEyrWK/TmSooYfliUQXflNqBCP9lED4+720FN5FAqUOQ0TYhN8hM3LuOIz
         o8uhhAtshcFGtVaUAtVw+cJjCHVK5yzQQkrPo7wwv5NRFesSxjHQ44b+QhZjA8lpkXQf
         imq0XUnFAcGBJSIE0zbDSJ+iN2FPKJgLThI3CI1S6xD+5N0RQKt4I01HT+oxNoVVNPbH
         qEcw59ypYhyKyCVsErqK5vSc8xD3jA8Eq9lYGHqAJ6zrWkvQXEoBkPtKMi1Ihl/PP+xy
         WW6w==
X-Forwarded-Encrypted: i=1; AJvYcCXyxnSBBL+alTBo2J2QzjejYYI+NKTOtofRRRQqraEtpqIAgQzOim6Zyn3Ve4L7sJomkKCeeFiGTSFdlbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8T/u+w/uzN52ppBYhtlsQTc448dBy1zc8CShc9mo65+gEyRH
	SY24gsaSxL0/rxntmq285LfWIzctzaboHIBQ15I/z3XmwACvGT7vQRZG
X-Gm-Gg: ASbGncvH6yWFZWxW68wEm+ixIfs3eixM7q/rZpcBQ9oIjCLeTNIjBIamIV4qbTaWG57
	fokqi+6pkh1/tDvJBbZUPlMOx3/97s1AWJGqA05dj88q0p2TqvHfk5DzNpiDM9X3xhyMjbOJOUJ
	J0fwFG7ZRfhtqCgDOFkuUkoRmJIusRx55q/wP0rEDfMTMtaYjrhLJPoyEFihJajHkBiGnafTQxT
	d0Q71bZnSvD9uRIzz3p33j3qlsUcBoeJIzF8TrV9F+YGz/zTsPd8A+YcR2u8yUd2LMPsLCIAqo3
	XiPiLiLHbNy/9j86158Y4A9+C+YrH3zRAllxSCdDZbryMKQHCg7QTb1fmc71fdJXEEW15qXJzfX
	bEyBt97MrZmQRwO6gjT0zatuNHgoqFJfkAzMqwBc8UDpvu9FR4jS7h0CxlnIPak0ODH+Z0+ma5i
	g=
X-Google-Smtp-Source: AGHT+IHnxtIhiuCO0WxN5X1kEHXzwK1hnW/lH3LtDeMQqk+92JN/kd97ffteykynOMj24ZQ8sJlSGw==
X-Received: by 2002:a05:6a00:2e1f:b0:7a2:7df5:5bb2 with SMTP id d2e1a72fcca58-7a27df562dfmr7690599b3a.10.1761366620399;
        Fri, 24 Oct 2025 21:30:20 -0700 (PDT)
Received: from gmail.com ([49.37.171.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414066d0esm910393b3a.43.2025.10.24.21.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:30:19 -0700 (PDT)
From: hariconscious@gmail.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	kuninori.morimoto.gx@renesas.com,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] ASoC: codec: wm8400: replace printk() calls with dev_*() device aware logging
Date: Sat, 25 Oct 2025 10:00:11 +0530
Message-ID: <20251025043011.598300-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

Replace direct printk() calls with the appropriate dev_*() logging
APIs.Use dev_err, dev_warn, dev_info, or dev_dbg to reflect the correct
severity level. Pass the canonical struct device pointer so logs
include device context and become traceable to specific hardware
instances.Improve log clarity, make messages filterable by device
and align the driver with kernel logging conventions to aid
debugging and maintenance.

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---

This patch replaces direct printk() calls with the dev_*() logging APIs.
The change uses dev_err/dev_warn/dev_info/dev_dbg and converts messages 
to dev_*() where applicable. Note that this file already uses dev_*() 
logging in other sections and the patch makes the remaining calls 
consistent with those existing usages. I have verified compilation with 
the configs "CONFIG_COMPILE_TEST","CONFIG_MFD_WM8400" enabled and booted.
Runtime testing is requested to confirm logging output, device prefixes 
and that there are no regressions.Please report any failures or unexpected 
log behavior and I will update the patch accordingly.

 sound/soc/codecs/wm8400.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 5ad6d5b63ffc..d716775cedc2 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -318,6 +318,7 @@ static int outmixer_event (struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	struct wm8400_priv *wm8400 = snd_soc_component_get_drvdata(component);
 	u32 reg_shift = mc->shift;
 	int ret = 0;
 	u16 reg;
@@ -326,7 +327,7 @@ static int outmixer_event (struct snd_soc_dapm_widget *w,
 	case WM8400_SPEAKER_MIXER | (WM8400_LDSPK << 8) :
 		reg = snd_soc_component_read(component, WM8400_OUTPUT_MIXER1);
 		if (reg & WM8400_LDLO) {
-			printk(KERN_WARNING
+			dev_warn(wm8400->wm8400->dev,
 			"Cannot set as Output Mixer 1 LDLO Set\n");
 			ret = -1;
 		}
@@ -334,7 +335,7 @@ static int outmixer_event (struct snd_soc_dapm_widget *w,
 	case WM8400_SPEAKER_MIXER | (WM8400_RDSPK << 8):
 		reg = snd_soc_component_read(component, WM8400_OUTPUT_MIXER2);
 		if (reg & WM8400_RDRO) {
-			printk(KERN_WARNING
+			dev_warn(wm8400->wm8400->dev,
 			"Cannot set as Output Mixer 2 RDRO Set\n");
 			ret = -1;
 		}
@@ -342,7 +343,7 @@ static int outmixer_event (struct snd_soc_dapm_widget *w,
 	case WM8400_OUTPUT_MIXER1 | (WM8400_LDLO << 8):
 		reg = snd_soc_component_read(component, WM8400_SPEAKER_MIXER);
 		if (reg & WM8400_LDSPK) {
-			printk(KERN_WARNING
+			dev_warn(wm8400->wm8400->dev,
 			"Cannot set as Speaker Mixer LDSPK Set\n");
 			ret = -1;
 		}
@@ -350,7 +351,7 @@ static int outmixer_event (struct snd_soc_dapm_widget *w,
 	case WM8400_OUTPUT_MIXER2 | (WM8400_RDRO << 8):
 		reg = snd_soc_component_read(component, WM8400_SPEAKER_MIXER);
 		if (reg & WM8400_RDSPK) {
-			printk(KERN_WARNING
+			dev_warn(wm8400->wm8400->dev,
 			"Cannot set as Speaker Mixer RDSPK Set\n");
 			ret = -1;
 		}

base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
-- 
2.43.0


