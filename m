Return-Path: <linux-kernel+bounces-772007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FF5B28DBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7E2189B86E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73C2D3725;
	Sat, 16 Aug 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUGyasKp"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3164284B27
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348047; cv=none; b=UGd8z5VYt6axaWhgNRB8P3DJwcOxEsmkvk8jFoyGpAh7AyjenAQGJeYeZXu/V9vauldGR+7YQwjLne+0t9RyLwDd7j4cNRGScmaBN4dcE748TbRYJ3ZX2fPt9a8a03LkAZ5zedTDKpNjnAy65qzYPWbsXMTvIdnxzTt7E/xSkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348047; c=relaxed/simple;
	bh=z6TiUcnCHZP0PmQ478ZawiNUW64AlKKcpZgnxVXJjBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lJkxA4aj6kWkBJ8cJBRZ3aqxufNQzTNWhAizYmnNF6ZfdLyVylbJzGn/UvgOChdJ+lTMYd/nmfYNKi/8hdb7g3vX4bQz953nlmNYXLfHTQtm1Fo5CpaxTBoKnkk4yZoYDJtcATEm5US4maw0gB6UBg69oBtJP15pmoknmrOW0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUGyasKp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso2455134b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755348045; x=1755952845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWQL0rS+QXxGVFLqe6MStv+JUabdvGeb1lemgu1FvB8=;
        b=eUGyasKpBeuJz10MamkKHQpE9hsqRJZgWNx27EXWiTyAscxa64zCYO6ogcE7EC8ZYw
         2GFiepeOzMp2peEGZycHrv/Czp3boBcJ+/+fWN2y1UsDaOENnvxALqbl88tWY+dSnd1Q
         NMidt3AyIqrK9wnb9MKpFMWK90SKOH3ITWfBaPbaFvCR3pS482i/v8OA3Ctev4mrJ3LU
         R77OlBiEzh0UDvgxoq8ageExXfdp8m/bXnLEVYoBlog0zNTRUyDgn7wS4SG0McPhWeDc
         4QeOV9/tyHf2PVuusWxRF+eFKn4FUjdqBwPTDRDYYpmeqRYtqsviXsDf/hmkbIbG8CxU
         4GgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348045; x=1755952845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWQL0rS+QXxGVFLqe6MStv+JUabdvGeb1lemgu1FvB8=;
        b=b7UGy6dWEumyf6g910nq2tXMPn3qcfY0PcouwafRB4dMsDY7Zm3j1EZZmoOuLKEA3S
         9dEdyomxHapNS+BR+Q1O9c+hG2F+uO27IvpJ+WNUDhybPei/haAK/jSVz+kgDmRuTM6P
         f5nD7Cs1g8JvOyAeL9l5HTQsT2njG97cF8oEG9JJZn1GMEi6baSoNsBngE3sH9Wmsg19
         FYJ5HNtqBWqXudGtRqdyGT428E/hwrJCvWAQbB3hRVJ6/tLvgZtzBsc/74kJUHfDJapi
         qyfieiHqSpX1twAkpUbwU6PVSB1hxgSrR8uAfcoSU87Egr80o4I47p9NwYbDZJlHE4Hi
         ktqg==
X-Gm-Message-State: AOJu0YwPadUNGZ0o5iEZE7PzZnRE9xNGVG2auRCGypB7GOnqg4Lrgh9Q
	gGU63VFtbl5TtsRfvCQzaVdvXLQYKipGl/1+Vp0+JTQR4TOs1eFuZM+bstmnU/rE
X-Gm-Gg: ASbGnctpyYx+oNorYbYN4iGiE/FlZNc1EXPps6Da/7kh7B5A7CGwX84yqgPp2kOCUbB
	Ki13m2LTXktH2zpwuRdaaqDnKALBzXwLR0ArGIptHdB7YmDfCGLc1R/2QIiHjEqgizskekPLHH+
	dDIzNpM4XQMDbHjTbVIxdYMPhp8BAkPYSEgL1F6krJKFEZ/OEP7euZQPo8fxxJpYKwhkUtTweRf
	cD5a/IbbfkJ5bUGoBlJ2X9jqWrpzp69h9l1OOzX7QynBwRsfnVi0iBRhgyTtWjdwPJEVQJLc4Fs
	VdIWpYJ8uKso3j727QBiYzsYlDsFsV/nl/mp868eO4WHqRNgYxcoCDIOYVSevGAIOCczmE0HrmP
	13d8BTerxYl3ImO5JWu96yhTT4ADiMOTlqADb6PMPixAmHu5Otk7wgnSeBPItkQ==
X-Google-Smtp-Source: AGHT+IHwipPJLcniNsbLoALvrlbMHPFw5QfkB9sCy2LZmf/DCxOraYPhUNXMF/FxBi0OHtqaDHKRHg==
X-Received: by 2002:a17:902:e952:b0:240:1ec4:61fe with SMTP id d9443c01a7336-24478f72ef6mr30693385ad.28.1755348044935;
        Sat, 16 Aug 2025 05:40:44 -0700 (PDT)
Received: from clint-Latitude-7390.. ([110.226.179.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fb54sm35055235ad.134.2025.08.16.05.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:40:44 -0700 (PDT)
From: Clint George <clintbgeorge@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Clint George <clintbgeorge@gmail.com>
Subject: [PATCH] Fixed Spelling in cpufreq module in kselftests. Earlier it used to be "loops", now i made it "loop(s)"
Date: Sat, 16 Aug 2025 18:10:36 +0530
Message-Id: <20250816124036.5786-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---
 .../selftests/cpufreq/cpufreq_selftest.txt    | 493 ++++++++++++++++++
 1 file changed, 493 insertions(+)
 create mode 100644 tools/testing/selftests/cpufreq/cpufreq_selftest.txt

diff --git a/tools/testing/selftests/cpufreq/cpufreq_selftest.txt b/tools/testing/selftests/cpufreq/cpufreq_selftest.txt
new file mode 100644
index 000000000..a332fac7e
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/cpufreq_selftest.txt
@@ -0,0 +1,493 @@
+
+*** RUNNING CPUFREQ SANITY TESTS ***
+====================================
+
+CPUFreq manages: 8 CPUs
+
+** Test: Running read_all_cpufreq_files **
+
+Printing directory: /sys/devices/system/cpu/cpufreq
+
+
+Printing directory: /sys/devices/system/cpu/cpufreq/policy0
+
+affected_cpus:0
+base_frequency:1700000
+cpuinfo_max_freq:3600000
+cpuinfo_min_freq:400000
+cpuinfo_transition_latency:0
+energy_performance_available_preferences:default performance balance_performance balance_power power 
+energy_performance_preference:balance_performance
+related_cpus:0
+scaling_available_governors:performance powersave
+scaling_cur_freq:2534945
+scaling_driver:intel_pstate
+scaling_governor:powersave
+scaling_max_freq:3600000
+scaling_min_freq:400000
+scaling_setspeed:<unsupported>
+
+
+Printing directory: /sys/devices/system/cpu/cpufreq/policy1
+
+affected_cpus:1
+base_frequency:1700000
+cpuinfo_max_freq:3600000
+cpuinfo_min_freq:400000
+cpuinfo_transition_latency:0
+energy_performance_available_preferences:default performance balance_performance balance_power power 
+energy_performance_preference:balance_performance
+related_cpus:1
+scaling_available_governors:performance powersave
+scaling_cur_freq:2843282
+scaling_driver:intel_pstate
+scaling_governor:powersave
+scaling_max_freq:3600000
+scaling_min_freq:400000
+scaling_setspeed:<unsupported>
+
+
+Printing directory: /sys/devices/system/cpu/cpufreq/policy2
+
+affected_cpus:2
+base_frequency:1700000
+cpuinfo_max_freq:3600000
+cpuinfo_min_freq:400000
+cpuinfo_transition_latency:0
+energy_performance_available_preferences:default performance balance_performance balance_power power 
+energy_performance_preference:balance_performance
+related_cpus:2
+scaling_available_governors:performance powersave
+scaling_cur_freq:2870789
+scaling_driver:intel_pstate
+scaling_governor:powersave
+scaling_max_freq:3600000
+scaling_min_freq:400000
+scaling_setspeed:<unsupported>
+
+
+Printing directory: /sys/devices/system/cpu/cpufreq/policy3
+
+affected_cpus:3
+base_frequency:1700000
+cpuinfo_max_freq:3600000
+cpuinfo_min_freq:400000
+cpuinfo_transition_latency:0
+energy_performance_available_preferences:default performance balance_performance balance_power power 
+energy_performance_preference:balance_performance
+related_cpus:3
+scaling_available_governors:performance powersave
+scaling_cur_freq:2790228
+scaling_driver:intel_pstate
+scaling_governor:powersave
+scaling_max_freq:3600000
+scaling_min_freq:400000
+scaling_setspeed:<unsupported>
+
+
+Printing directory: /sys/devices/system/cpu/cpufreq/policy4
+
+affected_cpus:4
+base_frequency:1700000
+cpuinfo_max_freq:3600000
+cpuinfo_min_freq:400000
+cpuinfo_transition_latency:0
+energy_performance_available_preferences:default performance balance_performance balance_power power 
+energy_performance_preference:balance_performance
+related_cpus:4
+scaling_available_governors:performance powersave
+scaling_cur_freq:2679211
+scaling_driver:intel_pstate
+scaling_governor:powersave
+scaling_max_freq:3600000
+scaling_min_freq:400000
+scaling_setspeed:<unsupported>
+
+
+Printing directory: /sys/devices/system/cpu/cpufreq/policy5
+
+affected_cpus:5
+base_frequency:1700000
+cpuinfo_max_freq:3600000
+cpuinfo_min_freq:400000
+cpuinfo_transition_latency:0
+energy_performance_available_preferences:default performance balance_performance balance_power power 
+energy_performance_preference:balance_performance
+related_cpus:5
+scaling_available_governors:performance powersave
+scaling_cur_freq:2749009
+scaling_driver:intel_pstate
+scaling_governor:powersave
+scaling_max_freq:3600000
+scaling_min_freq:400000
+scaling_setspeed:<unsupported>
+
+
+Printing directory: /sys/devices/system/cpu/cpufreq/policy6
+
+affected_cpus:6
+base_frequency:1700000
+cpuinfo_max_freq:3600000
+cpuinfo_min_freq:400000
+cpuinfo_transition_latency:0
+energy_performance_available_preferences:default performance balance_performance balance_power power 
+energy_performance_preference:balance_performance
+related_cpus:6
+scaling_available_governors:performance powersave
+scaling_cur_freq:2723564
+scaling_driver:intel_pstate
+scaling_governor:powersave
+scaling_max_freq:3600000
+scaling_min_freq:400000
+scaling_setspeed:<unsupported>
+
+
+Printing directory: /sys/devices/system/cpu/cpufreq/policy7
+
+affected_cpus:7
+base_frequency:1700000
+cpuinfo_max_freq:3600000
+cpuinfo_min_freq:400000
+cpuinfo_transition_latency:0
+energy_performance_available_preferences:default performance balance_performance balance_power power 
+energy_performance_preference:balance_performance
+related_cpus:7
+scaling_available_governors:performance powersave
+scaling_cur_freq:2537966
+scaling_driver:intel_pstate
+scaling_governor:powersave
+scaling_max_freq:3600000
+scaling_min_freq:400000
+scaling_setspeed:<unsupported>
+
+
+------------------------------------------------
+
+** Test: Running update_all_cpufreq_files **
+
+Updating directory: /sys/devices/system/cpu/cpufreq
+
+
+Updating directory: /sys/devices/system/cpu/cpufreq/policy0
+
+Writing balance_performance to: energy_performance_preference
+Writing powersave to: scaling_governor
+Writing 3600000 to: scaling_max_freq
+Writing 400000 to: scaling_min_freq
+
+
+Updating directory: /sys/devices/system/cpu/cpufreq/policy1
+
+Writing balance_performance to: energy_performance_preference
+Writing powersave to: scaling_governor
+Writing 3600000 to: scaling_max_freq
+Writing 400000 to: scaling_min_freq
+
+
+Updating directory: /sys/devices/system/cpu/cpufreq/policy2
+
+Writing balance_performance to: energy_performance_preference
+Writing powersave to: scaling_governor
+Writing 3600000 to: scaling_max_freq
+Writing 400000 to: scaling_min_freq
+
+
+Updating directory: /sys/devices/system/cpu/cpufreq/policy3
+
+Writing balance_performance to: energy_performance_preference
+Writing powersave to: scaling_governor
+Writing 3600000 to: scaling_max_freq
+Writing 400000 to: scaling_min_freq
+
+
+Updating directory: /sys/devices/system/cpu/cpufreq/policy4
+
+Writing balance_performance to: energy_performance_preference
+Writing powersave to: scaling_governor
+Writing 3600000 to: scaling_max_freq
+Writing 400000 to: scaling_min_freq
+
+
+Updating directory: /sys/devices/system/cpu/cpufreq/policy5
+
+Writing balance_performance to: energy_performance_preference
+Writing powersave to: scaling_governor
+Writing 3600000 to: scaling_max_freq
+Writing 400000 to: scaling_min_freq
+
+
+Updating directory: /sys/devices/system/cpu/cpufreq/policy6
+
+Writing balance_performance to: energy_performance_preference
+Writing powersave to: scaling_governor
+Writing 3600000 to: scaling_max_freq
+Writing 400000 to: scaling_min_freq
+
+
+Updating directory: /sys/devices/system/cpu/cpufreq/policy7
+
+Writing balance_performance to: energy_performance_preference
+Writing powersave to: scaling_governor
+Writing 3600000 to: scaling_max_freq
+Writing 400000 to: scaling_min_freq
+
+
+------------------------------------------------
+
+** Test: Running reboot_cpus for 5 loop(s) **
+
+Offline cpu1
+Offline cpu2
+Offline cpu3
+Offline cpu4
+Offline cpu5
+Offline cpu6
+Offline cpu7
+Online cpu1
+Online cpu2
+Online cpu3
+Online cpu4
+Online cpu5
+Online cpu6
+Online cpu7
+
+Offline cpu1
+Offline cpu2
+Offline cpu3
+Offline cpu4
+Offline cpu5
+Offline cpu6
+Offline cpu7
+Online cpu1
+Online cpu2
+Online cpu3
+Online cpu4
+Online cpu5
+Online cpu6
+Online cpu7
+
+Offline cpu1
+Offline cpu2
+Offline cpu3
+Offline cpu4
+Offline cpu5
+Offline cpu6
+Offline cpu7
+Online cpu1
+Online cpu2
+Online cpu3
+Online cpu4
+Online cpu5
+Online cpu6
+Online cpu7
+
+Offline cpu1
+Offline cpu2
+Offline cpu3
+Offline cpu4
+Offline cpu5
+Offline cpu6
+Offline cpu7
+Online cpu1
+Online cpu2
+Online cpu3
+Online cpu4
+Online cpu5
+Online cpu6
+Online cpu7
+
+Offline cpu1
+Offline cpu2
+Offline cpu3
+Offline cpu4
+Offline cpu5
+Offline cpu6
+Offline cpu7
+Online cpu1
+Online cpu2
+Online cpu3
+Online cpu4
+Online cpu5
+Online cpu6
+Online cpu7
+
+
+------------------------------------------------
+
+** Test: Running shuffle_frequency_for_all_cpus for 2 loop(s) **
+
+Governor backup done for policy0: powersave
+
+test_all_frequencies: userspace governor not available for: policy0
+Governor backup done for policy1: powersave
+
+test_all_frequencies: userspace governor not available for: policy1
+Governor backup done for policy2: powersave
+
+test_all_frequencies: userspace governor not available for: policy2
+Governor backup done for policy3: powersave
+
+test_all_frequencies: userspace governor not available for: policy3
+Governor backup done for policy4: powersave
+
+test_all_frequencies: userspace governor not available for: policy4
+Governor backup done for policy5: powersave
+
+test_all_frequencies: userspace governor not available for: policy5
+Governor backup done for policy6: powersave
+
+test_all_frequencies: userspace governor not available for: policy6
+Governor backup done for policy7: powersave
+
+test_all_frequencies: userspace governor not available for: policy7
+Governor backup done for policy0: powersave
+
+test_all_frequencies: userspace governor not available for: policy0
+Governor backup done for policy1: powersave
+
+test_all_frequencies: userspace governor not available for: policy1
+Governor backup done for policy2: powersave
+
+test_all_frequencies: userspace governor not available for: policy2
+Governor backup done for policy3: powersave
+
+test_all_frequencies: userspace governor not available for: policy3
+Governor backup done for policy4: powersave
+
+test_all_frequencies: userspace governor not available for: policy4
+Governor backup done for policy5: powersave
+
+test_all_frequencies: userspace governor not available for: policy5
+Governor backup done for policy6: powersave
+
+test_all_frequencies: userspace governor not available for: policy6
+Governor backup done for policy7: powersave
+
+test_all_frequencies: userspace governor not available for: policy7
+
+------------------------------------------------
+
+** Test: Running shuffle_governors_for_all_cpus for 1 loop(s) **
+
+Governor backup done for policy0: powersave
+
+Available governors for policy0: performance powersave
+
+Switched governor for policy0 to performance
+
+No files to read for performance governor
+
+
+Switched governor for policy0 to powersave
+
+No files to read for powersave governor
+
+Governor restored for policy0 to powersave
+
+Governor backup done for policy1: powersave
+
+Available governors for policy1: performance powersave
+
+Switched governor for policy1 to performance
+
+No files to read for performance governor
+
+
+Switched governor for policy1 to powersave
+
+No files to read for powersave governor
+
+Governor restored for policy1 to powersave
+
+Governor backup done for policy2: powersave
+
+Available governors for policy2: performance powersave
+
+Switched governor for policy2 to performance
+
+No files to read for performance governor
+
+
+Switched governor for policy2 to powersave
+
+No files to read for powersave governor
+
+Governor restored for policy2 to powersave
+
+Governor backup done for policy3: powersave
+
+Available governors for policy3: performance powersave
+
+Switched governor for policy3 to performance
+
+No files to read for performance governor
+
+
+Switched governor for policy3 to powersave
+
+No files to read for powersave governor
+
+Governor restored for policy3 to powersave
+
+Governor backup done for policy4: powersave
+
+Available governors for policy4: performance powersave
+
+Switched governor for policy4 to performance
+
+No files to read for performance governor
+
+
+Switched governor for policy4 to powersave
+
+No files to read for powersave governor
+
+Governor restored for policy4 to powersave
+
+Governor backup done for policy5: powersave
+
+Available governors for policy5: performance powersave
+
+Switched governor for policy5 to performance
+
+No files to read for performance governor
+
+
+Switched governor for policy5 to powersave
+
+No files to read for powersave governor
+
+Governor restored for policy5 to powersave
+
+Governor backup done for policy6: powersave
+
+Available governors for policy6: performance powersave
+
+Switched governor for policy6 to performance
+
+No files to read for performance governor
+
+
+Switched governor for policy6 to powersave
+
+No files to read for powersave governor
+
+Governor restored for policy6 to powersave
+
+Governor backup done for policy7: powersave
+
+Available governors for policy7: performance powersave
+
+Switched governor for policy7 to performance
+
+No files to read for performance governor
+
+
+Switched governor for policy7 to powersave
+
+No files to read for powersave governor
+
+Governor restored for policy7 to powersave
+
+------------------------------------------------
+
-- 
2.34.1


