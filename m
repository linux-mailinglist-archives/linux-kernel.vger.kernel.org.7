Return-Path: <linux-kernel+bounces-830342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61DB99700
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3051165CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF2A2DF715;
	Wed, 24 Sep 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIfdVrrF"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD72D8DDB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710069; cv=none; b=d5GC60TBCfmGhgfbWM1HRBlRampm0KW7o/2VwE6dD3rN2AMKdktxR/e4pA/tIZuzpO8je8FA1FiDOmlyd6Bkfz4XNZUbVtvG1bmqAApKmiLBaQV6/alGy9e0rerYXim6P/qXqB/dXOh2YFrzwpDJfYbx/XYEnQuYY2r+vINE3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710069; c=relaxed/simple;
	bh=iCZecmGO+STxbUbkpqNdKtXsZ7KCXVwG0poykSFvFX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fCu4NHT4Py4DEldvieVPuxIr79ZhuphqyKLrsLLtJcNLgrWWIpomMQ1eeAq2GX0yq6SaStrRUhXBzfLWFoMBWpPTSARZiiFLnjIASpBHLBgBkcOR9VnvsLTzKAx7jceaGGpDjz7LBUUC9U0FzAGS+E7q+CO4vkkdLGL6DrpSU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIfdVrrF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso3252193f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758710063; x=1759314863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dyqsmjj5lpyVJoV+oaHjMaHdvJL32WXjX0ymuQZAuU=;
        b=LIfdVrrFyzETP/wQuwKKYXe6P8Te4IltzXFRAtw8obSsuQfebLnLSTaQaLJ+IqkWku
         XFF0zmpYghGY9VJdb7x3AnTERiE3eY9K6m4FxP6M/2niMm5s3+aW+wxQtqcH2iRUHqIT
         TXnpyspReaZrPf+qZ8I1a+bHVtwYnCwVnwne2pF78iRd4GqvB9AW+0U+X4t1Aur+LtOD
         Gk6KTcdKFQOFsttqZDuAqfZEvD1wRl1EjnTxK4zoJoDSfNuUk70tSvRXIomcMxHsZWHv
         o3zvRe6AKrXx+wza5OG6Nc/0M8Kz4DE39LM856FraXNKL47ltHCoRWwEUkgneBwYaS2h
         ljuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710063; x=1759314863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Dyqsmjj5lpyVJoV+oaHjMaHdvJL32WXjX0ymuQZAuU=;
        b=tyGPv9sbDSDQyHcOzw7whJJyJDbPJ5AR6hxpiCBYGialwaKfnuZAvtU7Xuw8ERYvoG
         3awBVoMQjPo+/B3F5ctQUu7usbNWJtdx4uRbo0waOXgOJpEDoBaYuC6YqRbzv+CjiHNM
         jwORpm8WiZBFrh92QqinUevDI+RaAJEz8/UOb4JhnYsBDSuQN8NRyZFI/yT3J692O8un
         nDVqIUVpgScLOmc/iFO6nyWayXNXpKT8uY3pL7Zz6Nw5I12SiZVzBYmZEZJCRKnc4GR7
         ampfpsyHgNUPsDrQh+Y5Z3QqsmwGqGJKx45sYZVH+sqT462TSbUsct9qZL4vAerBpEqj
         6xIA==
X-Forwarded-Encrypted: i=1; AJvYcCWN4B2XSaZchGEQphNeYXOhMLWmVNnKDDb4yyaoWG6R5WPvRTnGnd3pSt6op4WyE0vG+hQUThxF7gEPR5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvXuOFMsr3Nxm6Ccn5aGb7ZI4xtKRSGiN9VJIF6BakvuIyN08
	YQ/eFxiwmAKEV7LQky9OZcVL6/MPxipFyBwdoyj0EqsCz/r37gAqIN0L
X-Gm-Gg: ASbGncutTsV3US+k8g1N6stVcfpZ4M36xbDliAvke06s6rntw7BU1BiPxem4LMZqH3H
	oMwfgb06YCTFun4m448WpALGDfLBFW6lvtcXjjhnPv0upLslF25F76kym7hB3+25Xes598e+eIE
	SyQioIoe+czRIlW6QcMA1mdmuL540MIAQwKHdpG/atK9rXCxVtMIQ4NIH3uKSGLiW5A21TR0bvo
	eM4y2JYJf1vPS/ZbIy5srvdB0oO5PR/cTPdz648mDsVFI8mEu715ykUeFZMaoquRQHmp4Bwf24p
	i4OcWR5SNp0ZZlPUfdYH/cJT6dCrF/jiIhnIB0hIs2zvnO5PGLIOGDJWz/oQW+ZhX3k3TY8OcHw
	o1R7jr/+XuL6i6EQrwpQhjQ==
X-Google-Smtp-Source: AGHT+IEA4Y4Oswnv4lzMacht4nwo2IDihzUjlV2YSxZ6/wz2OAJZ/oXm6ngVsSDWYTRVwUEndg4jVg==
X-Received: by 2002:a05:6000:1a89:b0:3fe:efa8:7f17 with SMTP id ffacd0b85a97d-405cba9c47amr4576595f8f.61.1758710062608;
        Wed, 24 Sep 2025 03:34:22 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee1227cc37sm25825584f8f.7.2025.09.24.03.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:34:22 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: codecs: wcd: Fix a less than zero check on an u32 array element
Date: Wed, 24 Sep 2025 11:33:34 +0100
Message-ID: <20250924103334.9832-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the error check from the call to wcd_get_micbias_val is always
false because an u32 unsigned int in common->micb_vout[i] is being used to
to perform the less than zero error check. Fix this by using the int
variable ret to perform the check.

Fixes: 4f16b6351bbf ("ASoC: codecs: wcd: add common helper for wcd codecs")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/wcd-common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd-common.c b/sound/soc/codecs/wcd-common.c
index 9bbfda828377..9fd3965ed540 100644
--- a/sound/soc/codecs/wcd-common.c
+++ b/sound/soc/codecs/wcd-common.c
@@ -65,9 +65,12 @@ int wcd_dt_parse_micbias_info(struct wcd_common *common)
 	int i;
 
 	for (i = 0; i < common->max_bias; i++) {
-		common->micb_vout[i] = wcd_get_micbias_val(common->dev, i + 1, &common->micb_mv[i]);
-		if (common->micb_vout[i] < 0)
+		int ret;
+
+		ret = wcd_get_micbias_val(common->dev, i + 1, &common->micb_mv[i]);
+		if (ret < 0)
 			return -EINVAL;
+		common->micb_vout[i] = ret;
 	}
 
 	return 0;
-- 
2.51.0


