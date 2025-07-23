Return-Path: <linux-kernel+bounces-742740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A29B0F616
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01B3963E65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA402FE36E;
	Wed, 23 Jul 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Yyy7zBhk"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87E2FCFC3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282056; cv=none; b=Cpgj63uw+h4Gjvs05y7a21HUtRvzLzAi5qW/r13HSZBE33rFwDCQwk7C4/PqQaVjYI9D47MfrvqvK9FR3Gl2SJUyeBlB+OP/NCzMA73P1J8Cq6obqyW0zdgfFlP5I9VslTupdtv6dR9ED+QJhEFJ2+/bVMnlO/p2aGvTFOOHTsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282056; c=relaxed/simple;
	bh=MeL5rpabCOQ9W64WCDzEoX0aCqKWSq3A09PvP5YRATc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRZLUdAF7tYUy32/xHYgFgRWyFZp6vqW1iJZ8yrm7yCw8xZS9SE8knvT4h2a8bHKs+wkymrZ7ONCmzm1uPj1BujE2bOgAP0P7iWJziFb1aPnH8PGZvPX6aPdjRINDWWStj9HloKj73VgkDuDVmKVYrW9ihDSUszwE2Z/sx3tQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Yyy7zBhk; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e75f30452so44737367b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282051; x=1753886851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=Yyy7zBhkzE9t6E8ma3qmVy6Xxm+sC68V/EvMLhqxTwRVXtMOh14j3t1ZR3jFnbZhVL
         gCkDWN9JRIpqI0pgC4qc/1p1lbggJ45t6IGJjc4xPt4zCxPSiAf+WEr71IZGBO3tpMt9
         eEX17hJV+76mpL8wSoMwgWYa/2ogjO5ld5LF5aJ1V+YRv3HP68kBDUx4NY237tGtBCOR
         PTOYqBRUi/RVpW0msVaUOV57yLYuQc/88nP1HQY0dao5tosixpnQXVvdFwRIwv8AiwE+
         DGy6dn5kCoPB5xFMr4f1quxO+OyymmeG7L1abtzK0tX74IoFqMDmbW7ibeukt4TASkub
         2HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282051; x=1753886851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=McSDq5WVVV4fW4tve/mn3YpybJQkMfgyD1wJZ5PMaPDTSCeTvdnLd+uNQtr28BL0Qc
         eTAzJ/XabDVuMal8Vkx6wh5L/YlBbGX7PW6wvnniaT1n9up5/Rqyn0nzl3Bm252+7cF5
         GE3L3JCNSspI0h0AFYjUqTqpsPS+ryzkuAiFWeIB5X0E6u1ArxyR+7ou4pfhdhw9d3gD
         nqx2SeuP9Uc1fUt4j4+SZm0TXdmjm1uHy0Kwxvp07EWbOYI4hy6/d/sOLks49Ox70fMo
         HOovBzUXzjgB0+f8DkmWDwIbMm+llLclMJwjjuUKbYQmMr4o5ZcbrhQ2+XM4/7gHi/gm
         Kiww==
X-Forwarded-Encrypted: i=1; AJvYcCUg+isFC5eOWZPzr7CAaOZj57cDF79wWHsPsYzQSMyCF9V4JX2n1byfpqKNwgf2RkVuO5yc0j/mAMDTxzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvfgOiGnmiJJjKnJGjiPX+8/ljSZKraNY0Y5XQABoVEG9qM4kL
	fG+GfmlBvAkyuh6TRpvzwtWMT3SbkpyJdKy8Bd556/hF1XqEiA2yk9pDeAzzjR4eTkg=
X-Gm-Gg: ASbGncvm0RBW5xTIfZWdydpFNqE4/8OdDNQ+8QLCVUcmZtX8YWk0db/k5vV65xDb3jx
	m/MMYWvX+/N4DShLmpVQTiRPkvutF7rQLqRKSB4+mbaepqE8rYeLT5tHgO6kVMNGiPDZSmmHRme
	g0KMEqJ8FnSK99E//yjk34xuITapaPThy7VkkYdzyYKaFDZPnsG4Ubg8ae2M8EdXiR3iA/qndur
	Tp8NB0fYAMn7ykR2QHbo2pNHqbkUI5vXdh3paunIOr5SFARPwH18Rh6dSsMeQWwhtrNZHj7zNAB
	Z0/uypVJSPfvlIsuLnhfAazG8DxDkZlfVoqJOzud7kkzQCopju2PuRcYu5GiOCeMzUZx5AETTaP
	z52kBiuPGmwSArCW6pr1gToBdJGPJkzMnpBHhg8kqG9MbJTlW/NTs3t7uTDi1EiWCN9xNMTzs/U
	sRKxO4vh9LF9mT4A==
X-Google-Smtp-Source: AGHT+IHLyQqcsnOqnRO6HNMaeplbRrfZNdB8+kP2xWX2qbNG9/moHQNfSe1QScqIpYGuy7dJX/Q6FQ==
X-Received: by 2002:a05:690c:d1b:b0:719:61b8:ffd7 with SMTP id 00721157ae682-719b422f811mr42827367b3.16.1753282051271;
        Wed, 23 Jul 2025 07:47:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:30 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 18/32] reboot: call liveupdate_reboot() before kexec
Date: Wed, 23 Jul 2025 14:46:31 +0000
Message-ID: <20250723144649.1696299-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the reboot() syscall handler in kernel/reboot.c to call
liveupdate_reboot() when processing the LINUX_REBOOT_CMD_KEXEC
command.

This ensures that the Live Update Orchestrator is notified just
before the kernel executes the kexec jump. The liveupdate_reboot()
function triggers the final LIVEUPDATE_FREEZE event, allowing
participating subsystems to perform last-minute state saving within
the blackout window, and transitions the LUO state machine to FROZEN.

The call is placed immediately before kernel_kexec() to ensure LUO
finalization happens at the latest possible moment before the kernel
transition.

If liveupdate_reboot() returns an error (indicating a failure during
LUO finalization), the kexec operation is aborted to prevent proceeding
with an inconsistent state.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..bdeb04a773db 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/liveupdate.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -797,6 +798,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 #ifdef CONFIG_KEXEC_CORE
 	case LINUX_REBOOT_CMD_KEXEC:
+		ret = liveupdate_reboot();
+		if (ret)
+			break;
 		ret = kernel_kexec();
 		break;
 #endif
-- 
2.50.0.727.gbf7dc18ff4-goog


