Return-Path: <linux-kernel+bounces-832753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAC0BA049F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BA45E230D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28630594F;
	Thu, 25 Sep 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASxPoWgg"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB22FFFB7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813446; cv=none; b=RXNK01Wnc3QibW4a4KKeiFPQNOTPIsAdTBiSplt23BTuaDKPltRpTVMmvaWDoJbqMlSHCvjNrCV0BCpT/ZJ1DOeThGWc8J5tkNodQeayvi+Q69BghNR46zqCIwvwP/86S6sJP0WAShz1I30C2MvvCVgWV/OgHCz4KfAZv/KqtwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813446; c=relaxed/simple;
	bh=u+qJVWyapenrodgmMyyh5sdeoJQIHo+UHZurPNrBBEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsWWc5whIuqe7COrnSNQZSRFBIg+aex2lhawNa9XoXady1ZZUwMpGimtGgPX92qVzzrcu7w75TW2N27rl5fJTK2rA0JQP2CTmF7J6uQt+JovkDiFhQsWB2wqeS4vi+Shd24+xhcK1BUvMc/O4YRc0GAWYDU8ROWNX81DmgBRcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASxPoWgg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5818de29d15so1400828e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758813442; x=1759418242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNnZ9HXiG4U5oHkge6rfZLR0dPMVP9tD5A0n1Dg/8XI=;
        b=ASxPoWggU2jE6P99zI4CRqeV7JuShOT1D/mfEc2RqTFGTqRfTvoolVpC+su4R2SMBi
         uscAI/KyVs4csYRuIyhjwY1lGPJc5YaCnncVKxuBUCAKCB3b2pmvXjxtnYjIXB8Csmjo
         KWIsVNQvQdB8AyrwSD0El3/1UziL8zd+KKgE7UZNeiTfDuTC9s5qls9ath6D0PXvVNrJ
         wjTAwc43k2FkfBJrk8p5TMHt6TF8NAW6Cz1vFC1QnNko/u6tLDj214hUDDqBXk7bnCzj
         YHMkvnzLZj++BOxhVTxp6dctM+RnAu7PlIqBSOLYoWStJ80XFVnXXC42Q6BEns1e8BuU
         MPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813442; x=1759418242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNnZ9HXiG4U5oHkge6rfZLR0dPMVP9tD5A0n1Dg/8XI=;
        b=A3Ek24lu23rFExUEK+rhXV43qKdaMkF/8/n2EjZ8cfcz/7kQr1BoyZZvbH2HuSC/1/
         oixrK7MRY0LFKNx7LoPyJeK8WhuZUXSBshy3DCL0dgMCafgpvDMGitetik/Nc/a/nqqN
         Rlepr4odCuV1PQf3nlSEezXCuEsfSQwcc4hmbgyPmLmBmvEzQTDFZJDvQfnYpMvlS8R4
         Z3SSlAxk948v6ZtD7otA/Ix2MYohzzDgk4BUe22y6Syrn1xGuI6+EaN3oGQEetlj+JiS
         D2OEK2QmsAE06P1YYjXKV+egrdxRm2tZGVEVHNH7z6trcfE99YHvrsVB5sIGNSIrY90L
         E/xg==
X-Forwarded-Encrypted: i=1; AJvYcCWMLBrwz+SCtMP3y7W7pOeC+HT/RKorQPNzatorvVSbQlURoql+80VTnDR0xLy0HCyGFjQR1am0If5h6qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYa79qgMMBB+YXSoHNHqKSFZ0FRR9nTRBMbrDk8V5uT3sR+v5
	dF4I1lM2N6OGfHORhBVbduwUCRkMPjMErxypRWXR511RhZP3s3hmP82/
X-Gm-Gg: ASbGncsJ7wTnsrbrF2OOZJEKTLiUACNMX6AdtxFf4/eHAOj5Jqxkjj4h5NBaI4K2yVr
	CY1qEQB3EuSglf/YJADC+CTi1RGRlVuzYAWOyeMfJsozScyn6wpFcoLicWTWDUAYVU8MrH0e8oR
	9WaWiN+70lGVXpj/6fJhS2WXd9KR0N96bz3AZ57TELYH9MQIyFscsQqjGxRUbbggpzZl5WGnJsW
	tv/N+VoVxQw1o6FkyBoqJPR7yTy6b3Gd9EAFTUbYgnVhOmQdqlUB07skVlPW42MlrT6XFCovneF
	RofhZN6yrvoybj/XsvRxygO1O+xA57XQOYCiD+06eyziTjPmZP6wzXlS8wDs5SFYtlG9JWGO7TK
	gPNac3n7ZYYthTQ==
X-Google-Smtp-Source: AGHT+IGR2iv+Kh9ab2Gm8gGsLzPj15GIU7TA9oRp1epPRzVsSpV56VOyWvYjJkH+/G6EVhjFNycXFg==
X-Received: by 2002:a05:6512:6d1:b0:57e:ef77:699c with SMTP id 2adb3069b0e04-582d09297aemr1358949e87.3.1758813441925;
        Thu, 25 Sep 2025 08:17:21 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430496sm870084e87.27.2025.09.25.08.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:17:21 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v3 06/22] staging: media: tegra-video: vi: adjust get_selection op check
Date: Thu, 25 Sep 2025 18:16:32 +0300
Message-ID: <20250925151648.79510-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925151648.79510-1-clamor95@gmail.com>
References: <20250925151648.79510-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get_selection operation may be implemented only for sink pad and may
return error code. Set try_crop to 0 instead of returning error.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/staging/media/tegra-video/vi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 7c44a3448588..856b7c18b551 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -476,15 +476,11 @@ static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
 	fse.code = fmtinfo->code;
 	ret = v4l2_subdev_call(subdev, pad, enum_frame_size, sd_state, &fse);
 	if (ret) {
-		if (!v4l2_subdev_has_op(subdev, pad, get_selection)) {
+		if (!v4l2_subdev_has_op(subdev, pad, get_selection) ||
+		    v4l2_subdev_call(subdev, pad, get_selection, NULL, &sdsel)) {
 			try_crop->width = 0;
 			try_crop->height = 0;
 		} else {
-			ret = v4l2_subdev_call(subdev, pad, get_selection,
-					       NULL, &sdsel);
-			if (ret)
-				return -EINVAL;
-
 			try_crop->width = sdsel.r.width;
 			try_crop->height = sdsel.r.height;
 		}
-- 
2.48.1


