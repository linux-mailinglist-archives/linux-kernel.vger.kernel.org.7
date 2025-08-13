Return-Path: <linux-kernel+bounces-766765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96004B24AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A561C1BC71E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D642F5467;
	Wed, 13 Aug 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iq2gnyUl"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199932EACF8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092358; cv=none; b=eP72P4xKpFjBKFj/uquyLaeG6oXK0AxVom1qbEbKOqG8WAX17GwyCOxmoJLHBkPDVNz0AE3JzsmYDEiB4zy+xM92A812Wmz8aPjYwzcR1C3C6KcYNSOJriOoGmeEATDu7LABrg2oqndnN0O3VC85MU3J0mg5nxV1HiJEoiLO0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092358; c=relaxed/simple;
	bh=8IXJ4w8szgydeEsRIezTVodOHdHqDxt5F6vslQDwrEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ub4TA1wfQGEt+qlDhc7IdxhmwJdbUfskscgBTksoHIWMb4eF4nPeWUTvpHeRGtAvhJCINNYgi+fQiCBh/KaSUQ7I0XwB3YIFn32FoDVOEe3DwWkBNgGwvn47atOMm1kUILsPlLXMPBkGTkL4ls8y+Cwx9vHEiOXiCxhTRoS2Ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iq2gnyUl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459d40d16bdso42303085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092355; x=1755697155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeStqnXaxy3QngS5Ia1n5mO+f7KQZ/BhVH2TpqaUklY=;
        b=iq2gnyUl7mkM8N3tauhLn3H9TxWZkUvQqwVokbMrY6m1U4y9QK0tj3zsYuQUpVTr2e
         xjwg/ff8rET2OAeCpu56SPzCmv3rLTl2Kk8oaNQRVcXmC3iGvay2XzebnR/lm4niBZTS
         B9ZHR5UKvxhTBwVf8TqG+xmCDe501++IzzQebMG8OP9FMcSd++Uw5N+531ZC2Itmv3Al
         Jd8jV5FzuTwh7xygFYfQ/rHdhpkoYzC+e34T2+DtipIzzyDVNwCGXfgRlDSVGOfL0ZKQ
         8ip9+q1cslA4CUq4o9flnh7f0Uc97tTmAGoq5LMQuIDwxSt1Kv5O73dSnbdWfi8tFuiz
         juTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092355; x=1755697155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeStqnXaxy3QngS5Ia1n5mO+f7KQZ/BhVH2TpqaUklY=;
        b=k7/aTNZIsDOfFDgk/0IEGKu+5h7obPXh4vr1z63dbeUzieaN3YWdsmlMIzY84/K8sC
         lICyFdrUYJmL0KuDdeAOex/bZ5psIcbjr884f93vQH0nxN1GA/AFnZCwAZZaWF7JxeeE
         +WoXQFTbYfW1C5pQ3mLWftjoTH0iWjYjqJYq57T554GSXj2/73G8v3noS8zPJ7ZpDNDQ
         9AdFtGaKJs2IMAQBdNZrrmuIA31XogxRyXmhwltsZPUVIv9OYaFHd96VSnZ/nKqSY1QA
         +rH1cKx9pqQf49tHfbx+Xe0qJZeXJZnT/rUX1gh1QQ+do3SS+In1/dOkxch4BU5rrL7f
         haQA==
X-Forwarded-Encrypted: i=1; AJvYcCU6V/ao4KIKjSB3j0ry50IKtUhpcxDTwMigXCyepeDUqbbATTB+F7DL7mLhjX1Lbjt1nSol9xaOt9IJxwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+70Ki8Coz2Uulz7LW8i+lyLkbDz5d8VZdI+x94Z/+c4cNfEU
	qQhysFfWhW3itv+diz+5Lr/WRWBEzpg33nx/WGhprcVROyPxwDpNXGOxt2LVGO0wsvI=
X-Gm-Gg: ASbGnctr3Hazo4qxntbmxhw3NN9WQK5+ZUPpoD4jC2WYCFFTY+YTQXj048dupBE4uBo
	/NkA8GpqUzjk6fpD9DvewkblXrR1iU4Od8obblMm7sM2vxsdDcHKe4Qxt7hY23kJe1rLL5Y4++1
	yystHMFlo1JrSWCGWcsa9oDlLpJSSG8g8gG2E7224EoCHtsFKH1n15EUH8g7GRmDWW5MYFlIqib
	YrtToXZo+k0uEzigO66PRSIYaV6iErz1oka6zqzHkoVdqUU0lGTSjMCnIhjdlMgt08GNkAEE8Fv
	0ZQHJF7cgaPWdAGGUqAIBI4GIRoN8xEE3VpGob/OpY0xJWOw3DfeeCfDK/MZuBtILzSnJOldgHF
	KKVTqT2pmM6q8Lr5zWipBOZHJWmJmyLg=
X-Google-Smtp-Source: AGHT+IGiXArFsCsvNs28Mu9JVgeBLPfa1rYnkKC5It8U74TbonupuIcmTSAjOYs57oxdgF9sCrSLQw==
X-Received: by 2002:a05:600c:4750:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-45a165b7b22mr32838755e9.4.1755092355313;
        Wed, 13 Aug 2025 06:39:15 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a596280sm2559145e9.28.2025.08.13.06.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:39:14 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 13 Aug 2025 14:38:50 +0100
Subject: [PATCH 2/3] perf test: Add syscall and address tests to brstack
 test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-james-brbe-test-v1-2-76a0144b73fb@linaro.org>
References: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
In-Reply-To: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
 Adam Young <admiyo@os.amperecomputing.com>, Will Deacon <will@kernel.org>, 
 German Gomez <german.gomez@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Test that SYSCALL type branches are emitted from the expected 'getppid'
symbol. Test that when only 'k' is used, sources addresses are all in
the kernel. Test that no kernel addresses leak by checking for them in
the 'u' test.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_brstack.sh | 61 +++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 46e5aa9ce8ee..252d22d39c7b 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -64,8 +64,50 @@ test_user_branches() {
 	do
 		check_branches "$x"
 	done
+
+	# Dump addresses only this time
+	perf script -i "$TMPDIR/perf.data" --fields brstack | \
+		tr ' ' '\n' > "$TMPDIR/perf.script"
+
+	# There should be no kernel addresses with the u option, in either
+	# source or target addresses.
+	if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
+		echo "ERROR: Kernel address found in user mode"
+		err=1
+	fi
 	# some branch types are still not being tested:
-	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
+	# IND COND_CALL COND_RET SYSRET IRQ SERROR NO_TX
+}
+
+
+test_kernel_branches() {
+	echo "Testing that k option only includes kernel source addresses"
+
+	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
+		echo "skip: not enough privileges"
+	else
+		perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
+			perf bench syscall basic --loop 1000
+		perf script -i $TMPDIR/perf.data --fields brstack | \
+			tr ' ' '\n' > $TMPDIR/perf.script
+
+		# Example of branch entries:
+		#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
+		# Source addresses come first and target address can be either
+		# userspace or kernel even with k option, as long as the source
+		# is in kernel.
+
+		#Look for source addresses with top bit set
+		if ! grep -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
+			echo "ERROR: Kernel branches missing"
+			err=1
+		fi
+		# Look for no source addresses without top bit set
+		if grep -E -m1 "^0x[0-7][0-9a-f]{0,15}" $TMPDIR/perf.script; then
+			echo "ERROR: User branches found with kernel filter"
+			err=1
+		fi
+	fi
 }
 
 # first argument <arg0> is the argument passed to "--branch-stack <arg0>,save_type,u"
@@ -100,9 +142,26 @@ test_filter() {
 	fi
 }
 
+test_syscall() {
+	echo "Testing syscalls"
+	# skip if perf doesn't have enough privileges
+	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
+		echo "skip: not enough privileges"
+	else
+		perf record -o $TMPDIR/perf.data --branch-filter \
+			any_call,save_type,u,k -c 10000 -- \
+			perf bench syscall basic --loop 1000
+		perf script -i $TMPDIR/perf.data --fields brstacksym | \
+			tr ' ' '\n' > $TMPDIR/perf.script
+
+		check_branches "getppid[^ ]*/SYSCALL/"
+	fi
+}
 set -e
 
 test_user_branches
+test_syscall
+test_kernel_branches
 
 any_call="CALL|IND_CALL|COND_CALL|SYSCALL|IRQ"
 

-- 
2.34.1


