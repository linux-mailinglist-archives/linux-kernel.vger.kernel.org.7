Return-Path: <linux-kernel+bounces-667856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E823AC8ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD167A3EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F29221284;
	Fri, 30 May 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RNJbGHOV"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30000219A97
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597323; cv=none; b=jdLr3JrTLZ13m8YK/7ZUpxNCKWzYVBLGyahjNZj9iMCqm0LYB0HyR0t/f/qEYZMEtuWed3JPq3KpNnm+GlR5Z7LMg8QazvyGVp8cFaTWQsxvJrawDVxbZViSARCPVed6lJA/pnCQknusEpNeNKANFlUySyXmMP1xOjPdwaM8CKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597323; c=relaxed/simple;
	bh=ppCxvzGPzwxMK0c+R/BjMfinsaxs9oKUnADG8qsL8g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwj9EcbDlRPi37P76sV1Nx4m6keD/yucBX1rrhLoeYD8sDW/ZKcWwfFI67V+7fEZ/U6fFcDRgdQUUgwo1IUeLJom2YVhy9oZBYlyXhVrwySj21riZjbP6Htqy1TCSOCewrxxTvS2GVqiyRETR/E5wFTblY3vqTnjqNigFc6u11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RNJbGHOV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-310cf8f7301so1486040a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597321; x=1749202121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/A+gAHA3ZAGJfkMi3IvOeV45q7o44ZhkocltOJrpQQ=;
        b=RNJbGHOVy+7gA5xoBsRaT1rKXF040JsAQapN8McX3jn1Wyk4I0ZZsaZbS8pB8DpatB
         3g4kRPZGZxPujBKYFUZMfrHtujffJ6DNwYHUekHRdsao5cXm3myz9VwKiW0EuyowgMpp
         PIq4oAY9ym5CCsuoHm1VxXGovdSKOHG+FuKhYGkKeL9YBIHHrbtc9YanYWLHXJH0UO0a
         LESGRa9jM7y2+XjtsoLNrWJIkVkQFrL6526NQ1Dw8BichmkPc+kjMxzJ27kZyTD+tHiw
         Zj/SCHFZIYYbr2XsoSF3U/5XhRQ5EWBkm35poP/UZR0nPRMb18IBTzExgW4+GBKCcGFy
         SKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597321; x=1749202121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/A+gAHA3ZAGJfkMi3IvOeV45q7o44ZhkocltOJrpQQ=;
        b=dIC1YCD0QdLb+XcYner9Idy6gylVb2rtgU4Is59+ThfNdu6dCW+m2zhA32YcAPT9BC
         tj2oZimLtwiJfbfujyFIIxA1JUamFX9ec0qy3yS4tuqemmREz/+Xsb0jGI1sDeevSzft
         QK0m75ryJA1cquIWGCMghaZFkGU8PZ9Y+QMopgqli9t6tCICg6U/f68G7Pq9RQ6h/AbD
         9hEMONn3pjohXVRgY1gmEuhL54XayewWZ2DlcAiMs+kq0LyxAFziqpzbJBebdzAVKZLe
         uKvKMtNpkEvv8sWiYoPhqOUEr2cSz/T5OLTmNpJZH9jQ2NFFb5A/qEYMl0elmYUr1QNm
         cFZg==
X-Forwarded-Encrypted: i=1; AJvYcCU74ckBAVmEXdpyUztXzucvgP2WswHfKtDLvOrRUEiVyFYbyQu9J79+0eI9GkUo/5PdHHxwekpstmfhbPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvMOVRxwU4ffm38LrJrenaGosoZGQeKhGp4uzmMzOgcsQ+xVGH
	0vyr9chOWocX1T1D+U7joGLJLaRp9YkGjENMunsLRZOsnz3ZK50qZt2JqCZexIk8lf8=
X-Gm-Gg: ASbGncssKRIT3xbW5PUkX9MQu/P1+d15MEXWjB4kOnu5ZlYAKtpBmk85wXupQaknFMo
	7uJ1PolOj2dqeD7Qt0k44HlAMZlluDMh+wUOni+55HBBCLWCF8CtbboALVpK6+mmHKpk7cEIV30
	5moJhot2Fti6JjJ4DX56n6oWhNIOYZ8Mb9PgflzVBXMVEa6AY0z7bv/DuzwO9SZf+ABoXJXjtyP
	QPNONJoBmh99g9ENDjQBkgWfQKOJfsYKWc4TcPNC9pBI5nz5Bpe0mVMpFuKL5afYJils3r4pep/
	TuPaQrDiDOT7rhFEaNCalioMIUC+AOEo2EkJEA66p7XjHDdf91S2r/lzPhgzREjZZ2/bbHIiK3r
	CjdP8plXEf7qtC0z7eSgU
X-Google-Smtp-Source: AGHT+IGtvKSy5BRqT77HroAME3q1wPsiRK2qsvrkfhGABhYMviWMHBoI0lrSImjloPHkxtdJIsjzUQ==
X-Received: by 2002:a17:90b:4a0d:b0:310:b602:bc52 with SMTP id 98e67ed59e1d1-31214e11d96mr9868483a91.2.1748597321318;
        Fri, 30 May 2025 02:28:41 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.28.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:28:41 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 01/35] Kbuild: rpal support
Date: Fri, 30 May 2025 17:27:29 +0800
Message-Id: <e68046d85a19a0d161e6f76f31ef6a208c646bb8.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kbuild support for RPAL, including new folder arch/x86/kernel/rpal and
new config CONFIG_RPAL.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/Kbuild        |  2 ++
 arch/x86/Kconfig       |  2 ++
 arch/x86/rpal/Kconfig  | 11 +++++++++++
 arch/x86/rpal/Makefile |  0
 4 files changed, 15 insertions(+)
 create mode 100644 arch/x86/rpal/Kconfig
 create mode 100644 arch/x86/rpal/Makefile

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f7fb3d88c57b..26c406442d79 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -34,5 +34,7 @@ obj-$(CONFIG_KEXEC_FILE) += purgatory/
 
 obj-y += virt/
 
+obj-y += rpal/
+
 # for cleaning
 subdir- += boot tools
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 121f9f03bd5c..3f53b6fc943f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2359,6 +2359,8 @@ config X86_BUS_LOCK_DETECT
 	  Enable Split Lock Detect and Bus Lock Detect functionalities.
 	  See <file:Documentation/arch/x86/buslock.rst> for more information.
 
+source "arch/x86/rpal/Kconfig"
+
 endmenu
 
 config CC_HAS_NAMED_AS
diff --git a/arch/x86/rpal/Kconfig b/arch/x86/rpal/Kconfig
new file mode 100644
index 000000000000..e5e6996553ea
--- /dev/null
+++ b/arch/x86/rpal/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# This Kconfig describes RPAL options
+#
+
+config RPAL
+	def_bool y
+	depends on X86_64
+	help
+		This option enables system support for Run Process As
+		library (RPAL).
\ No newline at end of file
diff --git a/arch/x86/rpal/Makefile b/arch/x86/rpal/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.20.1


