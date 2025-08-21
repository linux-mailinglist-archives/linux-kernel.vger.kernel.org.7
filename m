Return-Path: <linux-kernel+bounces-779212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A77B2F087
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9A95C6840
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A999B2EA148;
	Thu, 21 Aug 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="f7Qa674Z"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1E2E9ECA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763434; cv=none; b=i2ZAzPTkYm4TDfwrkIh+goGoDfIhILeHRimaB/qzYVsAFPvN5lgsMu+oHUCvzoID9lAuezn8MT9fzx3AdkTPq8zcinKHA85/qvxj+jbh6HhXCeUX+McF6jQcMtTztqfvEO8cnJ2emZHOWBgYLvM82vt6dzGXEcvWtw8EWYEo8XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763434; c=relaxed/simple;
	bh=BkUjAzazCdrdco3Umhau/Xuq5nuzBQH/yodQbE/M+BY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xw7B3GbsgLadi20ZlKBtZGG3uJUkVRtsCIa9TwTBTc1kDRaUcRUGFjgAPMvl3ex17oKuxhAim2cUdrcxMWBQJNWxBoKZQbnaYEmXVPFdBdPVAmaAT+/iogEKSSYDStsaJgKqeXv6spZ7zjAF+vbnINnpZkeIjvNXmljEKH6J4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=f7Qa674Z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso3141525e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755763430; x=1756368230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPH4Dt9LC8zmN5YywximTfS/LxGtIse3pZkHAnoKBEk=;
        b=f7Qa674ZsqtyHtXxNt1JKOnNJCL3M6IKA3Mh7jiyKjGh/g1E2LhMd9yADGzcn4gmMO
         jI0yPDYpFDitcsRZ2MZXiS8uri6J0qARmJL0DMWOWkwatbWz2aDjTeD4zilKMvt4BpME
         uV8BVqeFdmr9RNYrqT3oHBb7KtWauTCYO9I9uHMzd1gUTmSpqM/jorNVnmyUVJvzyoMb
         SF7gqLqaczPNJ4gGdfLAyDu8TupSQDNlYd9mMPVZH7h1bMHcjyWnwG6cOI3PeXOtXTkz
         alnLLLavwtL6EQGjhj5dSUDbfH6M873mAolfjpMQgcatQ6T1m+oR8S2+dFrBiavamNYy
         i3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763430; x=1756368230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPH4Dt9LC8zmN5YywximTfS/LxGtIse3pZkHAnoKBEk=;
        b=mf4BsKyCmM5lShOWNSUhLAH4D2L4O3VJmO1Dg5406CkxNxmds8yuCBTWc5oD7dPT0C
         x46fj7SVc/Zu1KFojL1uOec6Ui5Wdxr9e90w1q8/P31KN0g7G5UdWFi6v5cjtARvawj2
         WBEi/GQGCZ2ZgB3npwZiDdmxpltclJ/cBIC3xroZURIjQqGCAEx5rZhaPcmMExZ2/xWR
         TZpxhwr56fS99kGDNDXn4CWkaATUHwz6C+thi1ViAnWhYWdGHigBujza70eq38287zxE
         GQnalCjz4VwRt2rrHaezpSa9FFHBVYl1rdsor95I+C1bhO3FdcQJaOaayAh1pC0V1XcD
         FTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE2PZP0s84OGNZglHUGpdPmJvvMo2NkmKzMrPiFw7GWFuQRipkcFwiqYC2TNmJizdF4NAKxz4ju50yyfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywet6+eI+zoS3Z/Q74HCEuL/EZS36s1VYWBDdMBjCTp6YHh/yIb
	CMHgkBGSiUcsd1IMh+qklhNfYOWVm/51p4HkMxpxLJlkfBpiwbcfZwNIk7kWSfutjVk=
X-Gm-Gg: ASbGncvEMxieB1+1sb9ujWk60SiXdQy77pdsqSlL8zGFeOXuRxq1+tniFKK0vGhNd1+
	55YtT1eGWI7Lrj+YYGxXmM9Rn57NghssfWIqCYijZ/M689ls9lKYHyi4RJf5HXO61RIRG5wcPXx
	6QqSQgvy55zj7p895rTm4uHV7djtMxZv+ePS8DHwWVgXHfJPp4Me/c7QemocnlsIrNpoC8gpeoA
	suA601oGHsAq1o54rkOxAIG8+8GWjJSYRE0OF8lixr4kq4WtD10OQ4U4ycGWFsLkHBNru+qvtDl
	eFgoJMnD7aHMFHvsPpgTm0lx5tVRcKDJdiZxYfrRIH9l9edlBtSGWdqDQGAVwyiAxDaenKdPNCo
	7W3sOXENEgEQNW0Ht6QqC0ZTaloRhQaLpVFJ9mnDO9X/vCjUmXHk=
X-Google-Smtp-Source: AGHT+IHHm8Lchn2zvhRJUg1fgGzuxGz8KFFfOq4sSoyn5I0S9lKsbcJu4rnRhc/hWeaHsuyWmyDFzw==
X-Received: by 2002:a05:600c:3b19:b0:456:496:2100 with SMTP id 5b1f17b1804b1-45b4d84e6f0mr14634375e9.31.1755763430131;
        Thu, 21 Aug 2025 01:03:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4dc155b8sm17356225e9.19.2025.08.21.01.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:03:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	geert+renesas@glider.be,
	linux@armlinux.org.uk
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/2] clk: renesas: rzg2l: Disable unused clocks after resume
Date: Thu, 21 Aug 2025 11:03:30 +0300
Message-ID: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series disables clocks that remain unused after resume.
This is necessary when the resume process is done with the help of the
bootloader, as the bootloader enables various clocks when returning from
resume.

On the RZ/G3S SoC (where this series was tested), the bootloader enables
the SDHI clocks (for all SDHI modules, of which 2 are used by Linux and
1 is unused) and the clocks for a serial IP (unused by Linux).

Testing was done on the RZ/G3S SMARC Carrier II board.

Thank you,
Claudiu Benea

Claudiu Beznea (2):
  clk: Export clk_disable_unused()
  clk: renesas: rzg2l: Register PM notifier to disable unused clocks

 drivers/clk/clk.c               |  9 +++++----
 drivers/clk/renesas/rzg2l-cpg.c | 24 ++++++++++++++++++++++++
 include/linux/clk.h             | 12 ++++++++++++
 3 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.43.0


