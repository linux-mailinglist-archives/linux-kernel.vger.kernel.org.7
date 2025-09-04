Return-Path: <linux-kernel+bounces-801307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A00B44393
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2874C3A764F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A632DD60E;
	Thu,  4 Sep 2025 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kgyaR8IP"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A9225408
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004422; cv=none; b=QfsTZQjzgeQBYEQ3gBhI4KfEaFiLATsCKtE13LuGHWCkUOBDMTN1s9wwuCXgJR2yjffROmkeXkXKfo57LThfRh0QItFoEZohJTvkDaEon3AgwQpwBjOhyW92kOYaD4F+BUPZgtjJg7S9XbJgsWpqMrkKmQeldj8ciPFGEZbH29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004422; c=relaxed/simple;
	bh=XyYgBJVgBAsJN38h3vgYTMUi63M/my5o6qAE9zBoffM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t9nFoM6Q3268F/0vbIUDjAWkMGKtsD5oAWDM15/rPZ6Pa7/p3ntT+3iBMI0vf5YZ66V5zA8Yrew8PGhQLOBth6e51hO18vpvFeKvX12gSUepg7Ge8s+xBlLt3hqwzzNkSSYYsalFdZ1azc6O6QgM+7GtbdyWykDjW02YK50T90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kgyaR8IP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so8341995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757004419; x=1757609219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/WLNsuxQtqsn76Kxw2dv+Lj7uczL3CnU17b0jUez3A=;
        b=kgyaR8IPxn5H+0BryabHkpZiETtEngos2DtgPQZP4Nqz7ktaT/7SAVL+3Nckd3T7sL
         tamIJ3BAR8Njz63x0yf7d6NdPk6za37X+yMFY8Y4dlQ9M67x+Q6lufy/1WSwqs98uGg7
         kmrmTdl1Fn+WHxkC22+nG+l3arD/UywZja6xHoY6CIYpiliMjyzF8aju7S0hCwi9A6ty
         OWo7cAB2IssKBYJ3U2QFogLaYve5mbnI1SBPkv6Beg6E1AySz4XgFbJJJMt9uCJnhtS1
         6kQ51C6Qe43qpFW5MlNGqkDV8Y9/ceQO0U4S5S/WwNvCTS9sx0u8WEkddLjnn8cJ75SQ
         n7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004419; x=1757609219;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/WLNsuxQtqsn76Kxw2dv+Lj7uczL3CnU17b0jUez3A=;
        b=BpYnvwn8TM5UX+nTN76jYKRHj1o557dLu3efS3bth3t40MN8yMGHI0cKeNLB6PFi4o
         ts8CBjGcQgQdd+9efPO0x4q9E8AFmIEa40ggfVN8ccZgj8KdX5MBYxco/gcZG42WrCB7
         T7bG4r6FNkIi6VNwwF4Thnuga8pD3raM6EecjZL53Q1SAaio4KUU+og7gAbDONPie63D
         qbYYlqRV5nULyvrcjuyw+5PdOG4gA/0wWAJJcbOutnRCpEcPp1z6GkJ2R72/5n7IWVxD
         8UZ8s4AyPIaAzdnX2qqIuzOeOvsbJvIVC/aucXpGW/nizbCh3ss7YXWrs2ooaA+/VVve
         9LPg==
X-Forwarded-Encrypted: i=1; AJvYcCWDcsIpd+CNNo92PqGtgrsEpca2uhIdcmNk8X/KGUJkd6kr3EkBkG74AqyNMExWgsTRSAa8aLanFqR7KBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZCDzgoLODFhyaNvABz+/+d3KNNwkk1lgOdH1iVh+Fz08dq72
	LobGHiwb7AnjVhXzsWGQX2RPWJ2bq5PQjyydS/ksJDDbXL9iMpoZTiwbcyJkYpWeeQc=
X-Gm-Gg: ASbGncujArPnidGVxlwynzZj5X+94I+a1o1qM8t1c+wH8ECrxnsgztgrLBzqFlDMD2i
	dQSKS4sYjsbnR83bBFnrM3nRWznpvinStTX37Lu6wufhl92FGj6m5WEeD8hqw8ot3oJKsZ0yBwR
	87odkPmXiJ3tOi1YYnPCY0ML6U3nTMDxWdolDkHwY2mbDpJrKJnCeTFc49oEX3cZOc3S/fzcOAR
	IT5mJdtcns7u3e4Lx7tt2xHBfT7p66sR76mOnRBk/azrcKd6Sc0Nv58r95Ow2FykJuQseH8urku
	FAA4qiILPIQLVtrHL59/PpYfCnsTXTNz8W5LCx+XRDvfjLDNvD+QCUc+YdQU+zEMKrkXn5SbF1o
	z+OWUZ36iJZQilozU+QVulqd3j/i2ZhCrKWzciimLCx8rHdfI8McDcnnbjQ==
X-Google-Smtp-Source: AGHT+IHQrf0VDJOnlLROwb3iKPchiTJtb5FWTd611Hy/KSG8kw1XqXuDzj8LP0/63OVGDYFX4XRwGA==
X-Received: by 2002:a05:600c:548a:b0:45c:b5f7:c6e4 with SMTP id 5b1f17b1804b1-45cb5f7c9fcmr59378955e9.35.1757004418578;
        Thu, 04 Sep 2025 09:46:58 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f602:3644:5f38:7200])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b7e7f14bbsm299010215e9.8.2025.09.04.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:46:58 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
Subject: Re: [PATCH v2 00/12] clk: amlogic: clock controllers clean-up and
 factorisation
Message-Id: <175700441776.3567508.13329203268479696099.b4-ty@baylibre.com>
Date: Thu, 04 Sep 2025 18:46:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Applied to clk-meson (clk-meson-next), thanks!

[01/12] clk: amlogic: drop meson-clkcee
        https://github.com/BayLibre/clk-meson/commit/e256a6602aa0
[02/12] clk: amlogic: add probe helper for mmio based controllers
        https://github.com/BayLibre/clk-meson/commit/480197ceece7
[03/12] clk: amlogic: use probe helper in mmio based controllers
        https://github.com/BayLibre/clk-meson/commit/d7c001bd76b7
[04/12] clk: amlogic: aoclk: use clkc-utils syscon probe
        https://github.com/BayLibre/clk-meson/commit/2aeeb649ead2
[05/12] clk: amlogic: move PCLK definition to clkc-utils
        https://github.com/BayLibre/clk-meson/commit/32ee5475f7e3
[06/12] clk: amlogic: drop CLK_SET_RATE_PARENT from peripheral clocks
        https://github.com/BayLibre/clk-meson/commit/cf03071b7c3f
[07/12] clk: amlogic: pclk explicitly use CLK_IGNORE_UNUSED
        https://github.com/BayLibre/clk-meson/commit/c3f369363a13
[08/12] clk: amlogic: introduce a common pclk definition
        https://github.com/BayLibre/clk-meson/commit/aaee6f3bce3f
[09/12] clk: amlogic: use the common pclk definition
        https://github.com/BayLibre/clk-meson/commit/b7358d14f176
[10/12] clk: amlogic: add composite clock helpers
        https://github.com/BayLibre/clk-meson/commit/955e18baeb93
[11/12] clk: amlogic: align s4 and c3 pwm clock descriptions
        https://github.com/BayLibre/clk-meson/commit/9bada5ff4bf7
[12/12] clk: amlogic: c3-peripherals: use helper for basic composite clocks
        https://github.com/BayLibre/clk-meson/commit/01f3a6d1d59b

Best regards,
--
Jerome


