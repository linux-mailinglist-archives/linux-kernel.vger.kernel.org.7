Return-Path: <linux-kernel+bounces-852916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97301BDA3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429FF4FAA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5983002C6;
	Tue, 14 Oct 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWkB/o6o"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA703002B4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454285; cv=none; b=E9BwTtEPYus4YfrdGNCTE+7H8jH5QMmgR1ZvyrDWtp5Toj99O4iwS0Ao6NmXE42IBgWFewCdP0cTnrS3rVAlQneuEaFELmyxB7jVWb4E6WjXKF7q0ZDeJFJtdg5hkG92QCwThvHnQ2OIvv0vo3aekRev2LUhPMQLOprNUkQvu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454285; c=relaxed/simple;
	bh=HTqUsRXqv0uayXlXxBww3HqeknMt/byBk1GhhunGYGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYPmpky5IreN75wF06UWUSyWNfURwMQKNyc7k7/QWP3mUfN+kaB26YVO6m23KDQA5EORBAV4lf4giz/WjvjwammeFLy4GPi+T0IKxWJlXaDxQb3/6s16q39QH3bHtELgiEkLFGFBc4Vz4nJrhanXWSzIph4TWi72zsm8YRTPIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWkB/o6o; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so4902157a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454282; x=1761059082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16lNfyPp2lVpupbRAD1MY+eMmDibLLbMsLULc43CNdM=;
        b=OWkB/o6oRUW3EZL8qrpkRB6xrx4M6R+SeSE/Bc2PVSLmZVZNRKKPt0m66BxzKsFhks
         E155yJ8SrOW+LIg4infkssJ1XuTYqWoYCqm0yX4G9ke0AtLu2whi/RR2RWr+zq017/wl
         eR2XBQH3zsCxtXHA2cHOh7lhuBMkJTUgrnxpvnSH/JgX+AAs2dyWeloA4qZ+7+sFRJUq
         bz6q+wl9bsfFUhy4cHaXUVqYeU3vhOXyUmzcKfe+vBRMFv5coUmo8sGVWGHrzr1iMGle
         hFbRC8HvMaH18z+CYRY5PKv6/Gf/27T7bDerJcPi1Fxyd1XOhldWy6sBqEV0z1eKOGMh
         mnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454282; x=1761059082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16lNfyPp2lVpupbRAD1MY+eMmDibLLbMsLULc43CNdM=;
        b=dusc4JRWWr/zadBMVv/KXS3WlLIvItxciI2mHoZudMIatbXvSWceCMI5NseAcl7zP4
         0tABYNaLn93O4ELhH2eDr949oVBGfsA0XlNYtMMNQruVMr0bRKdDjhRzcKXF+yultovY
         EnnCPOuNMjSGHwQFRV7upvPNhupKBZp0h1rdfoQiGnpZXJovTTXH7KrcpevzRCZU6m/0
         tgvLyxkxAVPLy8G8u0NONENE79jK7dyKaIGL9F7ey26tbQ65OXf2gp7AcorONasBBJZk
         tBceXPyVnKd1kuYys4X73dM1p/5nQYFU04pOEOmsrNl+k/rg+/GHnSNBHzUkVDw5MYAm
         rosg==
X-Forwarded-Encrypted: i=1; AJvYcCVHpV8wbEwohPROnpHm57ARUafytFKJJQalZf8axYI/p7Mu+WmZ7bbEfeQBogdTU6Z8X5D08hGEn7JM4l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtdxTCyV1JhXU0KMI3QpVHzcHjQMaUXcjGAc/ltDwb2qSMcGx4
	BCyoC40vmvDpVnfoJRK7QYKgz9FEPTFdYf91DUdDU9L1x9sh1CTpGpRd
X-Gm-Gg: ASbGnctuMUsBxuowr7Bo6Q7tOBalZwOHi7i1T7Tey/oDYCeMW4IcKBOPJFgEskPFQGO
	FzHgtyhzWEuSphxnrXIJjGBwN5oG5/z+PnMNNK5r0AarajcOHnBBrv9xQl1R/QO+Ov5vHN4Mk3i
	jMF05thyECP3GBagUPs/QxuMMzB0Lmo6NF47fqrwmPR3/6uQRLWBR6QmS8jqOUgyFASZkDi44bT
	x9hpJH7mx1dHtXTkPPd9vUd1Z5+U/7TQscCjnbuNEU6dXAYrtAF80seTJ6tBPl8fZc6ngdsmthG
	xQ+aOClVTZbc8zw8x3Aj/qt5DQgQHrEfkDyoKqCUEZV2oTMmcbjvzI+DJ8oi2Fi/igx7YK9Rc1J
	IwzBSuelIdvno+ppYflhYMeCOYzrdryVY6SNklTZtn2g=
X-Google-Smtp-Source: AGHT+IGwEs3rrCDqpl5/3jdMLYGXd/fP1d+HAulIjOxhPLB7QlezpM98CM9KNKeg0TI59ggKTThDpg==
X-Received: by 2002:a17:90b:4d10:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-33b5138db1emr36578879a91.23.1760454280681;
        Tue, 14 Oct 2025 08:04:40 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:04:40 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:39 +0800
Subject: [PATCH RESEND v8 06/21] drivers/perf: apple_m1: Support
 per-implementation PMU startup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-6-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2178; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=HTqUsRXqv0uayXlXxBww3HqeknMt/byBk1GhhunGYGY=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZtIExs41YFPpj0vJDkH9AmK9OwhzMSoCLKK
 Lq4Oy96LeiJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbQAKCRABygi3psUI
 JLLiEACERRbpPD9nPrsGGfapV4gEvqaAHnouFfwKWinXgfj0dP6MuIaz/G7+GbUDhhfC3u4bQpK
 91p4sbNGynjY0RJbgtoIYi1nxnbKb8sHwm5cksvQgTFvc6ijEWbZKovDPej3lGT8J/OT2bHHwTC
 Y02PtU4yzhNj38o2Y6mfR6h0hjejGvSgia5ieLHGZcDkP94gt6BPu4lsh3mfrgErNh31mX8a/RH
 REWOQTV9V6YbUmP1QZ5HQm4NVBZ7h4P+fWOGR3qHIjivQlp6kwrNVPlkxL3pT6rShe2i2LgyFa5
 AJ3o6ufsmOv7CQlUx+HZmhajqZWk51M/hc+0VPQJXTXngABulTD6jeHlxXUolJdB80z0N8Pis9T
 6yzLzN0RhQ2XeN/hTIQtnbzl658ub279hmAV50nk1pBkG+LT83/gjAlcTE/EiQSRfnA2h6AtttF
 Nb+40XxkDfuPnLKwA6Mc+veJdwakQxzkIVV8LzUJQE6O37qj+Ld2fCpfSu8/jWxiG8Kwk2SCZ4c
 OngOeu9D1OsDVjtUYceGVr5fu7x1ILXh6XVC8FXC6hCu5mnife1EtD/fShLv3jDvwO1y4cTQBGe
 QFp+BOd9rOLZsefaDh8l5DSFzsss3w7PF0O85pLHjP+SlQDc0iOIFIPFemoS3FYFKUjfcgmaEkW
 vsWljmeHn0rrd+Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Support for implementations that deliver its interrupts in ways other than
FIQ will be added, which requires a per-implementation startup function.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/perf/apple_m1_cpu_pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index fb2759069fe9e47146f0342fa46e40f3ab836926..303c0e62432281e899a33fc197365c70078d6ac1 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -659,7 +659,6 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu, u32 counters)
 	cpu_pmu->read_counter	  = m1_pmu_read_counter;
 	cpu_pmu->write_counter	  = m1_pmu_write_counter;
 	cpu_pmu->clear_event_idx  = m1_pmu_clear_event_idx;
-	cpu_pmu->start		  = m1_pmu_start;
 	cpu_pmu->stop		  = m1_pmu_stop;
 	cpu_pmu->set_event_filter = m1_pmu_set_event_filter;
 
@@ -681,6 +680,7 @@ static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -690,6 +690,7 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m1_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -699,6 +700,7 @@ static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 
@@ -708,6 +710,7 @@ static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->get_event_idx	  = m1_pmu_get_event_idx;
 	cpu_pmu->map_event	  = m2_pmu_map_event;
 	cpu_pmu->reset		  = m1_pmu_reset;
+	cpu_pmu->start		  = m1_pmu_start;
 	return apple_pmu_init(cpu_pmu, M1_PMU_NR_COUNTERS);
 }
 

-- 
2.51.0


