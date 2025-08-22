Return-Path: <linux-kernel+bounces-780868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC1B30A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DD32A4216
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB2F6FBF;
	Fri, 22 Aug 2025 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="U0FITsEU"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD51EC2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822130; cv=none; b=HtbfNTcqUPdKvA3qgERWqY0Ofl4TgXaRfSjPPePGi8aX+2UXvFL9QFEu8Ff7UvdV02go9hr6wchtzlZNJYBoZ7Fwib4DGXYeU89hnDrRGUA9zWkwzxdovHwtBbYFM7KyPPsF4cdJK5pKdb6C+TiqR7Em77BTQCLoWHyNigg1pYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822130; c=relaxed/simple;
	bh=DDbB1RO8B/3ntGMIfiJsz6eiLqLaXTDzheESMXj7ZtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFHi97GHvKKIwo5RCD5hcUXMb9RcWnpRGJtA3/ooyCggys0JvzQYtI1lrxfkNkrY9Pu7n6OgsVIfzVKEkF9XZdizh3lc67MYU0sofg8f84JIzQ1DIg4IeNJOywU44KkAPccH7eOmyWEyJ8+0BcvqbOeUxzYxUkJKahE24jqIMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=U0FITsEU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e87068760bso181551185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1755822128; x=1756426928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvGMV188YiibtGuznHf40d1pmt+2SAT1gXmJIlT35ZM=;
        b=U0FITsEUyXdPs1xv7N7tF/R/dYWWZpWusMtKjnxXTehJjz6iwsScqtUxj74mAa1vSj
         xaDg3vY82nXpkSdVdz13qNOjZyX0HWnMRxbL+jgyR3sQQEgIN8oocDNCNYZZJmRNWPRG
         aW2YU/tRU25r0QE9VuFijC/BRhJNcAPGWkm/ee94DFDMn9lQRO+F1wQXAm/h+OBqxhJg
         xPpnqKZ4O+RxDuLfNGJLSlc0e/Au4/NZwuh7sSCwL9m3AiciLVXSRTHERIPZ+HNXgYbD
         CQtJSURNiclsrvsS08PkJ76pAYWZbtPbYL1HJUy2JdehZ2XP+7dxak54pdoslU+B72UZ
         A3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755822128; x=1756426928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvGMV188YiibtGuznHf40d1pmt+2SAT1gXmJIlT35ZM=;
        b=akO8fq279A15xlQeGZiAyx9z0V91Z96BPy+Qn/r2w4WfVM9gbEYBrNOVEBRQqKeqJ2
         HjPxRrGIdsOn/HsD9mNUc55FvyTbrccCVYjNYwb6d6mRwaEkJkg9cKY7FhZ5nqkTAOHN
         pbZMeXwsH9rMDk69pX2YMVoy+Lkao8RPU7ZsAqjFzlBaPiedDGmh+y49BWDB0UIJsiaZ
         oZ/TgsbFrBbnGTuiImKHJIIxSjHhbQmIUz8zTkSc8RJq1Ke1yd/Ii8dKbs88F3YbG6OV
         E1TcqunU+2tcW2SvIsU98XktiaYf5xvYsTWlRDEluZ8+oe+svo7iIJMT17Yv1BJ81UCl
         xPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOfRX1PUUTD8lQz48dsRP8/IsM3LKRL8cRTCFYUyz3MUgZM7v4m8Xy8jyefjqrM7C53sXefZWBa1W5TrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9rQUHxADl9rL69MtxLbJHnq4pkOqLA8MOsmvafgyFcMmWOd/H
	zCCQbmntGWV03Pfi9VBAwb6Sb12uhxmFCOG4zIMrZwVrOoTUxS1voX0/vFu+NDEsPA==
X-Gm-Gg: ASbGnctX6Y3uHRoKzUGAOghko5IDfuv8DtIMoO6kTmYocwhqtzf+hV5fw/tqI7ps7Wl
	LBAd7rpmnlYdibdho7d5KbLcKMXMaxmlhWgr+P/zYXwWCqZ/9b+9W8QyPz7/zAs13VP2uU5e0yG
	aXmhrhvLYX3qlL4RK6RGmpNk6ZutNlCqkMG3htmaJIAFnFrnpPDmcZA125I4LMmq7PmtVKag1O3
	uJOF6cVSevoDF8zg4hauY+EpSjLMRayU7vaQ9xYV31QBJ9OKK9jzNvq3Fn+vs8jYn0qCe+nVBqT
	XFC+D1mnv/dp+RYdgOPeaTxhjtLRowgOfiaRAhCQhqmcP8M1zSQKloh0RkUxJi2QONWaUnOPdHA
	5B1kgrnrTvfufbQ/AsxDUx/mxpiz+4OMSAiAtrJ/B
X-Google-Smtp-Source: AGHT+IGHm6rZ2RaOlXfMgFSf4U8z7KV1Q+DwlLKsqiFCn1DG+L7TJ0TPCwJKMIb2sZIk+AiQv0UV3A==
X-Received: by 2002:a05:620a:3195:b0:7e8:2989:1149 with SMTP id af79cd13be357-7ea1103a64fmr184064785a.49.1755822127818;
        Thu, 21 Aug 2025 17:22:07 -0700 (PDT)
Received: from localhost ([2607:fb91:3b82:29b4:add9:bee5:e413:378f])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87e075df5sm1228228685a.30.2025.08.21.17.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 17:22:07 -0700 (PDT)
From: Da Xue <da@libre.computer>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jian Hu <jian.hu@amlogic.com>
Cc: Da Xue <da@libre.computer>,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: meson-g12a: fix bit range for fixed sys and hifi pll
Date: Thu, 21 Aug 2025 20:22:02 -0400
Message-ID: <20250822002203.1979235-1-da@libre.computer>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit range 17:0 does not match the datasheet for A311D / S905D3.
Change the bit range to 18:0 for FIX and HIFI PLLs to match datasheet.

The frac field is missing for sys pll so add that as well.

Patched:

+ sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
/sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
996999
500000
+ sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
+ grep -i '\(sys_\|hifi_\|fixed_\)pll'
 hifi_pll                      0    +/-1562Hz
 sys_pll_div16                 0    +/-1562Hz
 sys_pll_cpub_div16            0    +/-1562Hz
+ sudo cat /sys/kernel/debug/clk/clk_summary
+ grep -i '\(sys_\|hifi_\|fixed_\)pll'
    hifi_pll_dco                     0       0        0        0
       hifi_pll                      0       0        0        0
    sys_pll_dco                      1       1        0        3999999985
       sys_pll                       0       0        0        499999999
          sys_pll_div16_en           0       0        0        499999999
             sys_pll_div16           0       0        0        31249999
    fixed_pll_dco                    1       1        1        3987999985
       fixed_pll                     3       3        1        1993999993

Unpatch:

+ sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
/sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
1000000
500000
+ sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
+ grep -i '\(sys_\|hifi_\|fixed_\)pll'
 hifi_pll                      0    +/-1562Hz
 sys_pll_div16                 0    +/-1562Hz
 sys_pll_cpub_div16            0    +/-1562Hz
+ sudo cat /sys/kernel/debug/clk/clk_summary
+ grep -i '\(sys_\|hifi_\|fixed_\)pll'
    hifi_pll_dco                     0       0        0        0
       hifi_pll                      0       0        0        0
    sys_pll_dco                      1       1        0        4800000000
       sys_pll                       0       0        0        1200000000
          sys_pll_div16_en           0       0        0        1200000000
             sys_pll_div16           0       0        0        75000000
    fixed_pll_dco                    1       1        1        3999999939
       fixed_pll                     3       3        1        1999999970

Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
Signed-off-by: Da Xue <da@libre.computer>
---
 drivers/clk/meson/g12a.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 66f0e817e416..f78cca619ca5 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -157,7 +157,7 @@ static struct clk_regmap g12a_fixed_pll_dco = {
 		.frac = {
 			.reg_off = HHI_FIX_PLL_CNTL1,
 			.shift   = 0,
-			.width   = 17,
+			.width   = 19,
 		},
 		.l = {
 			.reg_off = HHI_FIX_PLL_CNTL0,
@@ -223,6 +223,11 @@ static struct clk_regmap g12a_sys_pll_dco = {
 			.shift   = 10,
 			.width   = 5,
 		},
+		.frac = {
+			.reg_off = HHI_SYS_PLL_CNTL1,
+			.shift   = 0,
+			.width   = 19,
+		},
 		.l = {
 			.reg_off = HHI_SYS_PLL_CNTL0,
 			.shift   = 31,
@@ -1901,7 +1906,7 @@ static struct clk_regmap g12a_hifi_pll_dco = {
 		.frac = {
 			.reg_off = HHI_HIFI_PLL_CNTL1,
 			.shift   = 0,
-			.width   = 17,
+			.width   = 19,
 		},
 		.l = {
 			.reg_off = HHI_HIFI_PLL_CNTL0,
-- 
2.47.2


