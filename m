Return-Path: <linux-kernel+bounces-802960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E3B458ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BA45C2B83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3072EDD76;
	Fri,  5 Sep 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoFPWGdl"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1AA350D5A;
	Fri,  5 Sep 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078715; cv=none; b=CM0TwGM7BlFNKFdkL2q2iWzgPsNjDCwaSISk8E5qPyTRXjUYmeMssTLfS5/iGLL3nsNTPOEX/qhBCknSg4dRuZ3XM2kPgE/veqQJYD3oNpPrKJR2AzE3n0b9gPLfMaZbj3Q/Q98b9sbM5d4YdEYGCwZkRm+TitDdS4e+ByS/WEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078715; c=relaxed/simple;
	bh=hiLsLS8SxLgBG2vpe0Zg0das0JZTqvUxdNHb1cq12bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtCVtzdrZA7M691WzgKuUHxggv6RHxeknuJT2g87klJoZG9O8n9HqVb5YtF6gA5oTylfoDgoE7bYZq0qdHuE8r4UWoJ891a2Bz/xDEqiXHkCovvJ8UnnlpxQtoYujOBK8WaekWfguOzRaxiL1aVo6Mtt3QfstNcLC5an6t1cmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoFPWGdl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24622df0d95so16533825ad.2;
        Fri, 05 Sep 2025 06:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757078713; x=1757683513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC3Ih+3Bk4xdwbwU0Ef6uM4jrfPw6U/3ht2D0BEr27k=;
        b=JoFPWGdl8D3cJgA/ijfNgi4VkKdf5HzUVse79hdEUv9fUrdKFLaKEuCjJJhoSrnEUm
         mbnaBDxQbhq9lXG25vox6m3oQQqNXsaCo3+ilqjqKjPclnMy0UFxGKluPhJ7xFWih9Di
         d31C+ogV6ewN5xK9oyMvObNzpWXQisKsWAZmenYesZVf86PS/BK4uOeEatUE5V+4ODdV
         bDY2Mw4QmcalepMU3xgbRWwxPAdMSfi1KIgF/NbDUhK6NkVfe6o8X6VbrjhppieVzQRS
         4CpPWu4F4yfDhZ9R8n8eoiW4ze2hnyUSmWmz3/JExIUiZuKzg6gzDwS8KaILyWQ/1oIO
         nm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078713; x=1757683513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC3Ih+3Bk4xdwbwU0Ef6uM4jrfPw6U/3ht2D0BEr27k=;
        b=XxycMk0hdThciakf9nC+rUrLTmIh4+tt9ZDAo9dfwhw2zFqshUJ4tRAvjVpf9F1wym
         M734WkDFMH37EvAtK7+jIVWID+y2AfO7TtFRdoRHIfYFcF0rBcdY7Bniri43eFHSsbf1
         RiWTJ1KJRjqtH1b01zPxBAacSPHCAnmSOBp3xYhURPMW8/NBUzgoSkmpa/UJBFxD6GHP
         HLjAYCuudBpqdqBhZZLfDBuQouARtDgiXJGTfbzCT2FTVXJif3JBriDBvmM2lJdAd8sU
         iHQShV0/gpltVSvtbtIJtcAoTabFX+KFRcuzO8nBCBS9rBjvmzWfXdrhWWUwxpRnKeae
         zZOg==
X-Forwarded-Encrypted: i=1; AJvYcCU2X9z0fCPtZXZ3jt3pCogFuf1GIcnj9X8KvIVOWaD8rb0rY4Bw6/1e1NIl1luviDYLlYSYBTiaKHGy@vger.kernel.org, AJvYcCWVPwQQ7KeKk2ujvb8rrx2pvB0DBa0uA235QWGk7kBJeBCwnRewoOFn0aifUHuKYkT+Npb3ewN79OjT@vger.kernel.org, AJvYcCXVizEqBY6PXsrfbckHRG5Xza317nWuMuZIMQP6E/nc3lWdp8DybthnqA7XfJuSyqfYROJYD1fgzn1uRITt@vger.kernel.org
X-Gm-Message-State: AOJu0YzGukQSNF+tejL3IJMik0MdX6fVq2hxmmuX8Eqnx40rWci0BTUy
	WLnUfSCZfLO6DLnrI6xMAj2qCoNX9qRBrQohG4kGVAd2Hr1QycvuJq0o
X-Gm-Gg: ASbGnctPzMyMYK+qHtMJlwQIQ9t3tB3OJiEL+qE5K99lxdAZjxvZrWRWfGu5O1WG0W1
	RZT44bdKBMvdI7c5TfrBgvoArYBtwdSSVURmvAFH+Lq3KBGhwKZY5ZeJ7ndfj3IdrsUuujfEi39
	zjXPEF+HyAVQ8Xwbgw0v4evMfBPspbtOXd2xB2iGEVJITFbvuRsDJoLnQc7NFcGDCftOZK1SS2o
	g+uCgXB0v6Vf9/BnOqeosuqNu0rreENL2g0N4jlnSaaRn5q4idDbn+ZLCnNySGOMkD3RQItT+nd
	fQ7NQkcXvsTCBQCc0fNJibEnVCj3T/EGGI1tkMDzdhc6rw9+5CYSgSh+1fngChbIl50iGxnmoMd
	tt6QmYZhukFU=
X-Google-Smtp-Source: AGHT+IE+eUTD1AjKw6WS82Iy2sBoi205L0uzIQBM5pFUvuD+OqHeIgDN6VAY3z7Yrw3uD7CXrMOfrg==
X-Received: by 2002:a17:903:3d07:b0:24c:92e6:3921 with SMTP id d9443c01a7336-24c92e63c8cmr141227795ad.17.1757078713506;
        Fri, 05 Sep 2025 06:25:13 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c8945d8d4sm76447955ad.127.2025.09.05.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:25:12 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v1 3/4] clk: rockchip: rk3368: use clock ids CLK_I2S_8CH_PRE and CLK_I2S_8CH_FRAC
Date: Fri,  5 Sep 2025 21:23:27 +0800
Message-ID: <20250905132328.9859-4-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905132328.9859-1-cn.liweihao@gmail.com>
References: <20250905132328.9859-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the clocks via the newly added clock-ids.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 8159f643dc..1fb18c9596 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -244,7 +244,7 @@ static struct rockchip_cpuclk_rate_table rk3368_cpuclkl_rates[] __initdata = {
 };
 
 static struct rockchip_clk_branch rk3368_i2s_8ch_fracmux __initdata =
-	MUX(0, "i2s_8ch_pre", mux_i2s_8ch_pre_p, CLK_SET_RATE_PARENT,
+	MUX(CLK_I2S_8CH_PRE, "i2s_8ch_pre", mux_i2s_8ch_pre_p, CLK_SET_RATE_PARENT,
 	    RK3368_CLKSEL_CON(27), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch rk3368_spdif_8ch_fracmux __initdata =
@@ -367,7 +367,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	COMPOSITE(0, "i2s_8ch_src", mux_pll_src_cpll_gpll_p, 0,
 			RK3368_CLKSEL_CON(27), 12, 1, MFLAGS, 0, 7, DFLAGS,
 			RK3368_CLKGATE_CON(6), 1, GFLAGS),
-	COMPOSITE_FRACMUX(0, "i2s_8ch_frac", "i2s_8ch_src", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX(CLK_I2S_8CH_FRAC, "i2s_8ch_frac", "i2s_8ch_src", CLK_SET_RATE_PARENT,
 			  RK3368_CLKSEL_CON(28), 0,
 			  RK3368_CLKGATE_CON(6), 2, GFLAGS,
 			  &rk3368_i2s_8ch_fracmux),
-- 
2.39.5


