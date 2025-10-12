Return-Path: <linux-kernel+bounces-849691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D3BD0B09
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85C2189732F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665E42F1FE7;
	Sun, 12 Oct 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PumKXp3Q"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D42EBBA3
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297024; cv=none; b=OsD/Irp6y41EmFdkJ3KxHrhIZMN9UoS2bPKwF+dwuAOQxwvcP1eyD0Nl58zfm3qTiCBqbZhO1r67uO5bTOqarfsKpW8kgAS4uR6KmwHbbMBVlRHqA3tbpv9pfxcV00yJzuqwZ/3VOEs7/5IvP3XOQYdOzaJrbXvL6foeyrXY5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297024; c=relaxed/simple;
	bh=QfNARh4pPe+cdZZuy3yeIiaQzdxv6g6o5G8d6KVVAlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxmrPvuPrZgOnQJCFmIl6ul+hbXXHiajztNtAqbOAiOU1c3ZNRn4DNthErgg7yqmfUr/66G6Pa4q+UV2GTx5f2wyxt2qnFic0TJU0gOR60rZ82ZxuMTUUhgnAzSRqzcdeU/vXsWfHjwZWaZXxtTfg+AKbWjFnJp1dPjG/U97BZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PumKXp3Q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso592121266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297021; x=1760901821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftu6zu8GSme2+XDOtZSOO4FVxV/p+JAxG+4qy5/uDJg=;
        b=PumKXp3QOB/s/qZk7Myq7LW5C/77iBD6xovqq7vW3yD1odgHyO2n/EBjd8UevZoyj2
         q/xBJPY6oKrSH/2+To1uUegqPo/jElit8EZ2s7mChfbtBUaSfl/YeXSbTDSTCKU08K2h
         UbuEHCOiIaRqNMU2VZkh7cienZHBPJzaJu8HORNc/ceE5viwMe9y9tpBWkz47WbekoLN
         dbC6Rxya4FqQcNFWNBuBXImBUok5+CyO/1gA+G5x+exMGLV1Sc2lhp6nevjXoT9hCUrQ
         lWhEVz2TeqUTYoVdBOFXPmR+oxw6QPAUDPpyFe98foowJd5odJ99CJSCNaGk0XuxSzb6
         zZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297021; x=1760901821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftu6zu8GSme2+XDOtZSOO4FVxV/p+JAxG+4qy5/uDJg=;
        b=pxooDhK1j7Cr9sUrZR/ygECmVeOCvYIHBgjUk7lYLKNRe78OnWVPwQBscElnhLDZ3M
         Pvm5nvXZx1SJQzZBnQk/T2AOuELic6L73a+JgrMLjh/bAqTt8MIlGzYNz0xImvLgr27t
         hG8pxdi8o+r5Hsph9Oo6cTCawrFZI6ZCAFUyuckvUfHRsMaBoZg069gKZ2lFCGQ6Hx0q
         O1l7WsRkckaK0yn+HUbhzps1iU9SAC1NjVwaGf4YfMF9yNkeY77vgbQ/jDAQbmf5cq7f
         MqA+cYtmGDBwzaGla/OuPBq4jK1Dtf4fAAxLYUE/7kogHeeBxSNCimd++BqoWyV40sjp
         4/mg==
X-Forwarded-Encrypted: i=1; AJvYcCWeZOHTUMHKZk1Ara+0K5V0ltQFReyG2tEExb/OGI7bJVhlD0mvjWbxoDFLg4bEQuq8Scz2Cc2zou9Zr6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UlV+06xcAolu4YxHGl/4JhE1ErWqDhVaB7XYgS0nN/ufK1DE
	/Mjh3TEyxB8PruqUSHcQhkmhrqBfUliGN0anAL+KZO/sr0xxLMLTLQq0
X-Gm-Gg: ASbGncsEqpSQ46ldl/bOSAqHTKF3pFYlrMIAPKw6q+tiac07Pje5PicLGvZXUysa4D+
	pkG6eyCi2hHPmuhIKOOFfjvK2sX23q3buifZKb47SKgZqiVb74aOioxyUQlds05SODCp52JjJgD
	ar55frLOsrQ41DlheokH4Igizpfs8zg22n0uOJwjLGBu+9b1yU+olBucggiuF8k40F0cUezeR7O
	Y/kqC/16mJB5nvz1HQiAp4uNCT7ZlgXeI8YeqbojCexMPu6yqqPeGfR2Fj7pDifwoh5y8QkjgcK
	SepRbt1dR2fQSXEP7cn/Lm6+Bs41ccJImp2xKStPok1SIGu6WZvlXeNf7ySus/algsIbFWMI4ee
	GwPIM7/LCK3q66anjloiqrYP1N0yhFoD+G/mZW119+Qgb7uPqTJ4PcOg5ic1WLQrqrjgE3hN0Wc
	TUwV+W4lAoOnS0pl7NTWmtOW9psqNvhvo=
X-Google-Smtp-Source: AGHT+IG0sfEJIgIhhCJn3/nqxzgHPFNNqWX+VjerNb/aGPJmXt/GeMNgqqdE+ygKI0NpsjQeQpcZAA==
X-Received: by 2002:a17:907:2d22:b0:b49:3ee4:d4a6 with SMTP id a640c23a62f3a-b50aab9d96bmr2151162666b.18.1760297020857;
        Sun, 12 Oct 2025 12:23:40 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:40 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 01/30] drm/sun4i: mixer: Fix up DE33 channel macros
Date: Sun, 12 Oct 2025 21:23:01 +0200
Message-ID: <20251012192330.6903-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012192330.6903-1-jernej.skrabec@gmail.com>
References: <20251012192330.6903-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properly define macros. Till now raw numbers and inappropriate macro was
used.

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
2.51.0


