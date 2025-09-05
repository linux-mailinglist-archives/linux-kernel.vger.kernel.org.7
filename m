Return-Path: <linux-kernel+bounces-802956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B94AB458DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B185C23F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC743322DD4;
	Fri,  5 Sep 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVzdq6zR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8A353340;
	Fri,  5 Sep 2025 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078704; cv=none; b=ih0kXkHzha9D9ILISDC39cuqu7AKufVF58NY4qEYPLR5QLZcWuPTvFbZ1tW6nZgtnFXJt5WdsZv37w9ZAmHKUvYYCZel+hNHbCOsAeRvEErcdx8yW94UmSzPHkchnuepUwAIa6A33kYr7sm+1oGACujcQdo8+J48897kaRPFLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078704; c=relaxed/simple;
	bh=4g7sTXCYaWnKn/D8OunDYdgTGYj2L6yFb5LQp7jM4Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zefp+dgOPmhCNIJaugGoT9bfGJNk4Xu5m9blHZpDV9kfsbROdNqF1uundFWoN3FtF1kcgdk5hgkFUee2IYKcTRH2B89EEJl8OxG2AZPjspJhbYktN5gSbSvwLurJ+WhFfQNQh4iM+JymkX9IgDqWDKsLf9AScybxwT3lEQyKSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVzdq6zR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b1622788dso15716145ad.2;
        Fri, 05 Sep 2025 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757078702; x=1757683502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzs0fcUa+DxpkLkc7ASzbeG0qA3dcJ9VCs0pVkhY65M=;
        b=cVzdq6zRkTe2Y9nQeNmrsrbePw7/bfLh6rnoJ3Fw9iuK7Ewlgk9THquotATQNMsYX1
         jpTuUNblJmnKq2WAR+FsedWabn/Z7Z1sksB+tuiHunLimJAWm6n21zDjFeVYB9nGllPG
         5MXCVi99UNB55gF2oFJ287GX6zGF5t4cEltbeWJVWAxHHZOceIlBytjbcCe9xj9w+2eP
         qOacY9J2I+eTQ38gfGrrBFOZWjOX85qTdVIcbUKc4mCsR29DbOIkhqyfoc6aO8fI2FMO
         CEe2bvzVfACa8nuLGBnQmVCJWXQRo5OepW5YCmEYZrX2Jawhhgro/cCgR5O5ufGzFPy9
         Ut4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078702; x=1757683502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzs0fcUa+DxpkLkc7ASzbeG0qA3dcJ9VCs0pVkhY65M=;
        b=taFPaTgLrXjuMVSuvgd+XcMTAPjMLqHHhj9mzXZRoa/o3P2W2TBzOL5YV/9l4PEqX3
         nqPCobKpWvwULvQCwUTlrQRSioZjz5ZDjMT4JJoqVKS03K1To5UAt/t82C2NZSFTooYy
         GXi1e0JFPL2Nyar/FzjmdWua9wfHBzTuWfj0vKnoez4Ahnik7n8dIAgcM7379sNHJw+w
         ZMaDEinFt/yBJ4aQ8qwW5xAgwBchkAlP9RTu/as8ZCZRh89DSKdYbrl46LZRUcLH/mDi
         gvv7RWlLudLYDl2T458qb6IgpI4nQSVKw4403BTCIyuybYWqP3pnoZIWzaXzvuMuiX27
         Gb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHgChEzBagpmBqnGx41ebNEVE4AxkF9abE24efTqKyjo7CNBV8ZCjJqzqAOCU56Pc86bm93Fb9O/8j@vger.kernel.org, AJvYcCV5ZxZkfeudz+94vUCOBy7TuaVA5ucFxy1C1hDnonvkbtO5eR7HcVr2jHRryo8OVsP1zkFxRa8Ebx9Q@vger.kernel.org, AJvYcCVJiZM2GZEI3KNwyBf/1rlYJ3sNvqEmlORiRYA807a9s7TmSH8/r8YSYZ8pUcyxbH9BGWxCb+kb7BgZR9ps@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYS2oeEbIepVzNrIKRtbzHVqnpoLsSm7NFJs8cyvBefjVL5nQ
	ZJ97CV/SlOap5Hgp2TcgLy89spChuF304eyKCFpjg3Ljkb4Zf9sj+5n0
X-Gm-Gg: ASbGnct3se02BqZpV2/B+U98Pd+QoXMvYUJjQbKx2X9M1z5AFgFJdoC650/qEfUGGY/
	0WxRI7r8u41FmNqJPfj+ddRQwpsavPE+C6ChL/+AHH91e4TnkEDSLpkajZPvOGcx83AO38N1KdC
	FfTgMOdr+sMAT6rpIJvHvkdUXAoGoVOcuzzpLictRhBtFRSGQ+nNr7tGXCzafBBD04LXN9ofY/R
	/H10ivI3r53WrTk8nSLuWWRKaTOJdzDjfkCw6lpxgAvrYuG6yLDzGV95TzigWht568xxIxFZ/z9
	Id2caVWKOEA9yCuArx44x6Z6l8ha5bxIep1D+S85C9hmB7PdRcEh11nGjXMAHRtBGVod4zI82o9
	/zmvvXHLPmyJc+C0pLsKV7A==
X-Google-Smtp-Source: AGHT+IH4zx4sI6FblJmB5He7a6nYAWLg6d3RbumYzZWccC7zXGmeUwtWGArXlU0WRJI06Z4GqaIqDQ==
X-Received: by 2002:a17:902:c40c:b0:24c:b2a4:7089 with SMTP id d9443c01a7336-24cb2a4744fmr134900655ad.31.1757078702100;
        Fri, 05 Sep 2025 06:25:02 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c8945d8d4sm76447955ad.127.2025.09.05.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:25:01 -0700 (PDT)
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
Subject: [PATCH v1 1/4] clk: rockchip: rk3368: fix SCLK_I2S_8CH_OUT flags
Date: Fri,  5 Sep 2025 21:23:25 +0800
Message-ID: <20250905132328.9859-2-cn.liweihao@gmail.com>
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

Clock SCLK_I2S_8CH_OUT has no capability to adjust clock frequency by
itself, add CLK_SET_RATE_PARENT flag to fix it.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 95e6996adb..8159f643dc 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -371,7 +371,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 			  RK3368_CLKSEL_CON(28), 0,
 			  RK3368_CLKGATE_CON(6), 2, GFLAGS,
 			  &rk3368_i2s_8ch_fracmux),
-	COMPOSITE_NODIV(SCLK_I2S_8CH_OUT, "i2s_8ch_clkout", mux_i2s_8ch_clkout_p, 0,
+	COMPOSITE_NODIV(SCLK_I2S_8CH_OUT, "i2s_8ch_clkout", mux_i2s_8ch_clkout_p, CLK_SET_RATE_PARENT,
 			RK3368_CLKSEL_CON(27), 15, 1, MFLAGS,
 			RK3368_CLKGATE_CON(6), 0, GFLAGS),
 	GATE(SCLK_I2S_8CH, "sclk_i2s_8ch", "i2s_8ch_pre", CLK_SET_RATE_PARENT,
-- 
2.39.5


