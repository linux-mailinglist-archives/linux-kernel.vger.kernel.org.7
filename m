Return-Path: <linux-kernel+bounces-781197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943CFB30EED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD3D68678B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E842048;
	Fri, 22 Aug 2025 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="djFdonhQ"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316F2A8C1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844142; cv=none; b=Tm1ifvKtiJK1OABw4YbNYBMYc6RQf0AhMULD1o3G2B1sCYAe1DrIjagOZQKU0+wnGYkhWiDjSk96QzG5+mnP9cIAGMrV/cZ4BVEGKoWzBxvg7NZZHmAkPsgRfrhQ7Ly48Ftxvl5nTRh4lwMa3XfNBwMKwtvsJCOeRYJkCvzsN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844142; c=relaxed/simple;
	bh=CDQnJj3KcI7gr1gzNZoQr1S3uzUp3/HF6QMZuuEmugI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5kt4Se8v8Fg4OU6AqycNRcstHU7GKz21M/0Cne/9EajNiMgI2I0g0obmwBunyCra7j/pSFahu2GtLUR80SY4iWS0Pp1VN9DIj1sOsZjbFksTEJMLdYqBSC7D6i9G1DS+nP75cn+xgrZDb/4oiAgdCeCy7d3zFHHtN1bp4OIyxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=djFdonhQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-324fb2bb099so1170081a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755844141; x=1756448941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AxFZWCSKR4desKiHPJ6haTS2ebGrBTXqENWB7tlhWOw=;
        b=djFdonhQsnHb9clygPy86+SpKvswI87LLWaknjEoB9ByYKHdR4H0eAJnXoB/e0oBXL
         Nur2hv4xaA1ZWOxsJB9Mvrdp+SKsd9sOKVjcHp/X0IrABXXrYN5ToYEgj988r7SGjHJf
         RaY4bSv2rqHrvlaPR+HRd7CnHGZdgrXAQ4Iuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755844141; x=1756448941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxFZWCSKR4desKiHPJ6haTS2ebGrBTXqENWB7tlhWOw=;
        b=JYS7ctqriAFsdqmhyZ3T7V71Puk4mHLHz6h2mJEC1YzOjskWZYczSPFJLUFV9vqWaB
         C4viUxNZnrYP8l9kknpAaDU4fUywt+xf/xdt81E72bQTIPqOHs2u7WoYclmYYnro2p0u
         d0ZBUAAES7eseQjjX4fETewIKLSy7a8LzDsIPZC5ONBkCShlu4sPDINGzxNVYlc3eQ4o
         CFohtGys8zRNIaDHVGA6ASL/AlPHxwlErMAAzt5pQTy0YY5UPJ0HUAl711/wCHDyWVpS
         1zyLgv9FymqtkRAKp1A8hgEL5s+2zvzkaAVgDsu5iahCo8judkNJZvNvJio9+dwHwxaL
         BL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWH2rs/NUDzXuDQ1kH76Ct+fg/5BkbVjWS58uI/j9GQAXqaQqc8SJVpNezXu1jK8jSn+XMalpNNmRbr74Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCcJdgsflgz37aFY/dhiSJDz2FsWg26l61CQvsqfriYFoaKPA
	UHK1jic5qEHSa6eKcS+QHcIc6EU/sGU6DKVuWK2Dsskz5nodwFEcG/OT67XrDdXEJw==
X-Gm-Gg: ASbGncshodvBsI9bv2vEyylGXtvQHRv+Ru3MlreLVsZkG69b4PLXNxPB6E/9AoocGRG
	D4BjltiQwMRGELsX2MR+JTwTeHaHVGG11LtOILmTAkyCcEsfaYir8/WCWzi48gm3yDb+rb+klp+
	CVpcCmWB98lTfcLYXj+pZLJU9aastcpoUr2rL6b618fG3/7CfQfxCN1+j8oXY5MGnovCyFLGLVF
	KvQswTQfOVmerwNPg0vNw9VIcMhmeBgIIW/TkxDIPJGX47eVxDHWfkS//4+Wiyzx0k0+kWFrVvO
	AOc/w9qFI6d0JoLB+fKKoQiiTa73BYr/PRCLmhAwq1FqJvGGDc84oOwmF64hKWbhe2dX7IMajWb
	55Ep67OwlTVInmS67ePlsfS7Y/g8eiH52lgH37x8h
X-Google-Smtp-Source: AGHT+IEmIoRbqzsMhT4RaCduv/mgQBiZTCW0YMv/crR9hLxBxCwCtU4VSoj9WK1ncCfxE24zov8CFw==
X-Received: by 2002:a17:90b:2e0e:b0:313:f6fa:5bca with SMTP id 98e67ed59e1d1-3251744cbfamr2642987a91.22.1755844140925;
        Thu, 21 Aug 2025 23:29:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8278:5411:367e:2f11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325143959e1sm1530661a91.23.2025.08.21.23.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:29:00 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: clk-mux: Do not pass flags to clk_mux_determine_rate_flags()
Date: Fri, 22 Aug 2025 14:28:52 +0800
Message-ID: <20250822062854.2633133-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `flags` in |struct mtk_mux| are core clk flags, not mux clk flags.
Passing one to the other is wrong.

Since there aren't any actual users adding CLK_MUX_* flags, just drop it
for now.

Fixes: b05ea3314390 ("clk: mediatek: clk-mux: Add .determine_rate() callback")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 60990296450b..cb015dcf8d30 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -148,7 +148,7 @@ static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
 {
 	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
 
-	return clk_mux_determine_rate_flags(hw, req, mux->data->flags);
+	return clk_mux_determine_rate_flags(hw, req, 0);
 }
 
 const struct clk_ops mtk_mux_clr_set_upd_ops = {
-- 
2.51.0.261.g7ce5a0a67e-goog


