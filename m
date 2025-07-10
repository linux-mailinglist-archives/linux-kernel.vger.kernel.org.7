Return-Path: <linux-kernel+bounces-726143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D888CB008B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5D0171AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEDA2F2716;
	Thu, 10 Jul 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdDNsTv7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05102F235D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164889; cv=none; b=XBd+yapP3V6nlAcaaRO6v1JGkOBrOEheOPF5UR59RW8CXYAzis8IA2HeUtvwohMBfa4VT1umZEF3DB+cT97oZ64pmxaSnt7Akyu2jKiE2qK1EiNyro4hp9sigzE3ELaKT+6ICuuog2CtPhfqDQKZtXyxJvr/2Ox+N5ofOD385Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164889; c=relaxed/simple;
	bh=9JfaJTYaWcQgtLDo8JR9Ya1ZG9LJ7XkHyQnaRl1pFYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XP7uv+RZbpbKJb+FLL0J+v6ZdwqQ8FoAkb/wXg5zlXCaQgzI14//iUSapJsPvGEvWv+mPe68lmu2kYyLOgy7cp30gzNfQaTPRYykBn9p3avDizx0ntDJGEW5hSE826uBOREp8uxJ3NtDiT8YPSXdvbeyTgvoeDRpiieJ7FNNFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdDNsTv7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752164885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pZ2fEmImzdGenxLPe18zM0sHzB+F4RfmFNy4FQZ+Zs=;
	b=BdDNsTv7L8uI1rqa/3kbNCJ+VPmcbJf4xHO8iSMu3VkgMXjxMNJ2uF4o6ReJfxec5yzgSS
	kxsin4J/wqhxpZJB9cc22yRew5TKPBJKzTVHbuiqtk+jaC0XFZVhUO1JceY1e+Crdv2U2u
	HmzWDxqYHYvapDRAh0ZNK4LV3v1oMcg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-0B7WG06LNmubX3uX3TNgCA-1; Thu, 10 Jul 2025 12:28:03 -0400
X-MC-Unique: 0B7WG06LNmubX3uX3TNgCA-1
X-Mimecast-MFC-AGG-ID: 0B7WG06LNmubX3uX3TNgCA_1752164883
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d09ed509aaso160016585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164882; x=1752769682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pZ2fEmImzdGenxLPe18zM0sHzB+F4RfmFNy4FQZ+Zs=;
        b=BEpH03X4zaFdSiTkluQal2vd7Fu0cdNczUQKuWsahuqRLZF1dz5UYoc3CzmUYX8vw+
         iTDRbSj/1YhAf+dbLw/85NXIL+zkNR5CMVPHyPlefND/GCSR0Ug2JULvKM8lPyeJ4SwD
         rkUQFyr6cEJbUdcPRI89IJSf1fLG7s5bykhtml5+UqLmlzhU3Co42jlmUM7ynYPawhSg
         z10j9Kzc7puDUK1KW3D8jnXYFErI/lHhYX6OzTCW7ANO3aICQRpX9l0kU/BLlpRNCH4t
         uaYllIaFrWYa9fKpNFgV7oFy9Bx7LTsJx1gO/bXnuV7ww/lAKNc03An02yCrzA0GMK54
         BVWg==
X-Forwarded-Encrypted: i=1; AJvYcCV2jIKXfS6j+FxqdxlyMuRfbElB1CdqD73yaufXbdzLXl68fCY814vlQg+1k5KnowHpC2jQcq8jb9hyGss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzutVvZITquaQ9b5wwxO1cpOuCklpSChsbuFdI2V7hR5I1t6lRE
	D5zz8TDJ+VbwqYSJ9fqcXqGnVfldcC3N77WQ3gC4312eEi93jQBNhtxpIy1oHxLVL/YcFXlXj/i
	avEfmQO3n5BN+Pg9YRk1iNPThB/FIlOK3JBic4x9gnvbIUT6dZCpoPpPGqrtMg0QdbOZM3rhj0g
	==
X-Gm-Gg: ASbGncs0FbXSqRJ2+LrgXSwKakb+8pHEBDfH6UpskSvOv7bYIL17HfjdF0fUO9oIY2c
	tSmqk5k9GEMp7coNC2AJ92EW8NhdUshyNHYQcu8gu+ldR9vRYPSVT/D0txl02pmwSGVxHTsbWWb
	EBycEPenxW8799YuFYvq6fwiOlZkS90K1GKbXwSQt/TnG5ZJ5aliH/nHzgIuMiVzyc3i8WWhVI6
	hK4p1tQBSfe9R5keNHcH09fADa/uYlodW6Ia+mmc2F+CEh5DoEFBAdWxT4MofBiGvURWY8Ay4D2
	xSQ3zoQVl3E5SMro0X46uxALvvJWCnxHHwjvx6ByOvPRNBIMhVpI4AjdBXxa
X-Received: by 2002:a05:620a:1726:b0:7d3:a6bd:93fc with SMTP id af79cd13be357-7ddebc935b0mr21979585a.28.1752164882022;
        Thu, 10 Jul 2025 09:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8nqAlSCWoWvORjsOIeWDgtSIE42hyDBJ1u6hirl8cdDrojUMZfEO6FEu3YLQazTijxe6XZw==
X-Received: by 2002:a05:620a:1726:b0:7d3:a6bd:93fc with SMTP id af79cd13be357-7ddebc935b0mr21974285a.28.1752164881473;
        Thu, 10 Jul 2025 09:28:01 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc5df99asm113487685a.49.2025.07.10.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:28:00 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:27:32 -0400
Subject: [PATCH 6/7] drm/msm/hdmi_phy_8996: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-drm-msm-phy-clk-round-rate-v1-6-364b1d9ee3f8@redhat.com>
References: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
In-Reply-To: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752164864; l=1782;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=9JfaJTYaWcQgtLDo8JR9Ya1ZG9LJ7XkHyQnaRl1pFYQ=;
 b=VQSi2rvdK2y8CpHnP8Kq87P2EN9sLMIAXn3sz8naTxS61uqPmjG5VbCcKXFPae1OucSiF/EyS
 rtenvdJm/WaADJl4nH/jtBQrvVWU5LOG7EEpXIABxQ7+T5Ia3BPM/cU
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
index 8c8d80b59573a37a4008752b16e094a218802508..dd59b2ed7fa3f53b6a70d20925e4f9cbd5d0573c 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
@@ -629,16 +629,15 @@ static int hdmi_8996_pll_prepare(struct clk_hw *hw)
 	return 0;
 }
 
-static long hdmi_8996_pll_round_rate(struct clk_hw *hw,
-				     unsigned long rate,
-				     unsigned long *parent_rate)
+static int hdmi_8996_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
-	if (rate < HDMI_PCLK_MIN_FREQ)
-		return HDMI_PCLK_MIN_FREQ;
-	else if (rate > HDMI_PCLK_MAX_FREQ)
-		return HDMI_PCLK_MAX_FREQ;
-	else
-		return rate;
+	if (req->rate < HDMI_PCLK_MIN_FREQ)
+		req->rate = HDMI_PCLK_MIN_FREQ;
+	else if (req->rate > HDMI_PCLK_MAX_FREQ)
+		req->rate = HDMI_PCLK_MAX_FREQ;
+
+	return 0;
 }
 
 static unsigned long hdmi_8996_pll_recalc_rate(struct clk_hw *hw,
@@ -684,7 +683,7 @@ static int hdmi_8996_pll_is_enabled(struct clk_hw *hw)
 
 static const struct clk_ops hdmi_8996_pll_ops = {
 	.set_rate = hdmi_8996_pll_set_clk_rate,
-	.round_rate = hdmi_8996_pll_round_rate,
+	.determine_rate = hdmi_8996_pll_determine_rate,
 	.recalc_rate = hdmi_8996_pll_recalc_rate,
 	.prepare = hdmi_8996_pll_prepare,
 	.unprepare = hdmi_8996_pll_unprepare,

-- 
2.50.0


