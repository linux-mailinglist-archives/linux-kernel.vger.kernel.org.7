Return-Path: <linux-kernel+bounces-577883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23574A7281F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 02:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7341C17AEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 01:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF076410;
	Thu, 27 Mar 2025 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFDpO5vg"
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3870825
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743038705; cv=none; b=FOntDfRBEop0x/76bz46LPxrMYL7r0rURFR4AtjpyUzLuI3CXxeyh/p0kxs4U1yOrOoLb6hQfv1tuXiAoOnEFduotPHLXq8WkdsmbIImqIlPyezHGnuymysdDs9DyJudJwNezfy/Z5NGd0duxJUsN+o2TgaEX3euhNPMQN3r5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743038705; c=relaxed/simple;
	bh=zLlqYxdhGw0cqRRjDi96z+MiFOFcknIK743A4mTOODc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nIt5Jm8Ox4zsGtU1UbtunApuNSm6PzDtnjQhwwoHDsIF4+RAm9u/xzxMEwe3iG7Y3x370bhHg9Ir/mTJV6rElNJo9RX5vRQA52cfLRmzTFjg0+gGqHgo5J46As7ifbQfeTeyRsVaEnf4WS6/WhePJI5KkH1bpdAnkgE/W6mG+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFDpO5vg; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-86de09a23c8so176793241.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743038702; x=1743643502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0gV2Hykp1nZANVivobuz4rpzhYTiIcgA3xTmvOSP0Q=;
        b=OFDpO5vg6rmLLlky+r5POeXYQXf3GYRT8jp/LN2TBpZvY2bY+Eq9l3CfvWbpUs6BzO
         Lx05cX2//I4yKjrtlXEFMoSqFeNyBWG8taLEr2MxkBNfzDvNHNVxfVGgswwZiPCbtInb
         geYrSQSUrwE8NMGvgxn6E/do/oYu9B5dc9zvNBGskhcOwnD2jT/4dFAVn/gS9YsOPE8f
         9cowvT/WlIIPp5zmaa0RqBsdJUI7BK4im2wZJupoIf+Sxr3xTjUtFP+7KoLCD5gOHUrI
         BmcFK2mvu59pr05l2884oBRKphVJd2cvn9Tzj4AT2A7Zv3OxCS1dG6FeunyDdAPUuA2s
         I/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743038702; x=1743643502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0gV2Hykp1nZANVivobuz4rpzhYTiIcgA3xTmvOSP0Q=;
        b=JOQ1XKAfLd7yl5JjQpmKISVzEyFNL26oiBRi5Z5srESRKL2OgLxsNUj0mcTrzXsIfn
         WKlJcNV/UNb5pncMEWLy8teOJXT5Fic7bY0/GbzDJUE+hCkHJybgcP8KcehnwWtB4gvp
         jx2HcsR6pKFgJ0Qz4YOJg9bpJ/CeLAm/R1hH+WyoDkXBb+4uUWj7FsGr5iWX9tzP/nxD
         4QMMVLq4PAAv5Wi6Ruxq5TAeL888LgAWd0sM5upVpbVb+76UbETrRB72+MTbbp5d/viG
         JyBMtdw33QFtJO/Efwf0aRayiSt6l4zXGj9VWSEU4n5Dpw+J35Ndn4ae/ma4hmwKnawU
         JM7w==
X-Forwarded-Encrypted: i=1; AJvYcCUOgRabeY7n2YY8KbdJSTVGFrPRKRl0hOIzYKopBxXmiF1dgIH4Mtq2ulCshmx0KyF54hv4AalqCxyzIY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhrTgaPZ2ylsaBLp0gBnb/DiExloggGg3XGEI/Z6JVvS13wyU
	7VFx/2e5M9ZCxHABmdYQy+hY1XD71n11HUgbIu1rQfkpCNphjPXoHuTUzjkzfRZGFnbnZOz89oV
	RHNadLC4iLKlfdZ9D5w==
X-Google-Smtp-Source: AGHT+IGJmEiF1OitEok2mFLmVWOSM49l4tKCl8gfyYUS8Qjj9MZO3Hq+PCEaZnJlxmlEaGvIhaJ2wvGNJri11VQA
X-Received: from uabfv8.prod.google.com ([2002:a05:6130:1a88:b0:868:f371:5d73])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:8015:b0:4c3:9b0:9e6b with SMTP id ada2fe7eead31-4c586f5f8d9mr2292397137.10.1743038702744;
 Wed, 26 Mar 2025 18:25:02 -0700 (PDT)
Date: Thu, 27 Mar 2025 01:23:49 +0000
In-Reply-To: <20250327012350.1135621-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327012350.1135621-1-jthoughton@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250327012350.1135621-5-jthoughton@google.com>
Subject: [PATCH 4/5] KVM: selftests: Build and link selftests/cgroup/lib into
 KVM selftests
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yu Zhao <yuzhao@google.com>, James Houghton <jthoughton@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libcgroup.o is built separately from KVM selftests and cgroup selftests,
so different compiler flags used by the different selftests will not
conflict with each other.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f773f8f992494..c86a680f52b28 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -219,6 +219,7 @@ OVERRIDE_TARGETS = 1
 # importantly defines, i.e. overwrites, $(CC) (unless `make -e` or `make CC=`,
 # which causes the environment variable to override the makefile).
 include ../lib.mk
+include ../cgroup/lib/libcgroup.mk
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -272,7 +273,7 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
-LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
+LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBCGROUP_O)
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))
 
-- 
2.49.0.395.g12beb8f557-goog


