Return-Path: <linux-kernel+bounces-856711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B3BE4DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C6E1884078
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D8342C89;
	Thu, 16 Oct 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEbtd3Zz"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC363321C4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635828; cv=none; b=shmSpy+p7pqFeybDqFGjazjkby9p1wk3NkHZP64HjWHHTscyLKBJrT1An7YEPPRy79EI4OzXf7gg23prS2GawIwDGop0LbyKyX2wVzmZFmVVHo2syzQzTq8pOR7ucEgsqd2eUHwoUL7P4j8nwp0oPsg4rpjX1BThivCOR56N2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635828; c=relaxed/simple;
	bh=zAGO8GGKnG833AeVLmHSCE0KZKwUxrVP8lLpUQ5jXwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WhOrbqa69ehGf2iRFTSalI2RQUDYEsC29wv8MegeRRrrHCx+JxW5cHZjGkxofk2YY7chSofFN/wpX5O/RFgFg1LYghrJMxuNydKb/yO+ocU8aXxXSCCeHMRxJTB4w2RwuAmu8hyz5Kyu/d+7Ni9W3rajD5tF7yrHd3VP7YecTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEbtd3Zz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-334b0876195so1188101a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760635826; x=1761240626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MjfqQK1ImtipxRLIgz8KiAh5ZIfb00cJavU+9G1+jb0=;
        b=fEbtd3ZzOowLdKVTWaGjBBY7DvA9kyNhFwKNkDnoNmwedwhX6/QUyv6ldtr1m3nM1u
         Dhk/HWSKuudQNr5nd4BtZUeAFy397atggn4uDKLMoIy0250RVdv1ekp9GMVUfKUjuhSw
         I5G13unvidNT3tcEodTi7wJ9ka64d2Xi2iQnr3D2iLO9Mi2hKYXBLd6wMP/HIb8BCnCQ
         bv86fe7hdAHDE8PLJKkGbHvFkdr9Oy4v6uBg8sEP9yR0S3Q9TO2FSABV9jb84RkcUtM/
         Vz02Hc3MfEGI4ksGppQGQ7FgGOzWmiybzgYZwSmbg/vODjBcOVuojVgTomrGGjaOdb6p
         3Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635826; x=1761240626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjfqQK1ImtipxRLIgz8KiAh5ZIfb00cJavU+9G1+jb0=;
        b=RvMHd3Qk0H2wZPlL2toodWH5hgpc4tnSQJrjpYPD8TEP46/7+TfpuNJJpBOkqtxSuS
         ESJgLlrapL8ybvFmWZ4ZANnDl5XNf0BMbd+e88SqLOng1rlY2MIAdS4wYCBOlgqKcC7N
         XCDOkxpSF3bfAjDpiI0ObnlXMXJzV8Lv7ZGhic7xFTbI15T+yJaXXMzrSMUeTJoRONAj
         KGHWqMlX3hxvgJRY82uCzY5Jm/uzpwDNtq00hhgdRSyW6aF82FCJy9ekhyClhmu2p/FB
         AMILpJ6VOfMjK+pfPdx9Od6vN6cexFxXEadWev4wlyq6PinlCG9ypHuPQEHuL/6IU4qi
         WryQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1d/whALoH8lb0zuzaTLQDj0W2uzjeXciMpA3IQ2ltqm80g8lKSjjy+SjGxlyc3yTcLgfy4FDroatLZiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNT2np96gC3/5A+GlsEzC466GMwp3b9gmJOhdj7MeATusOUsR
	0/cJ7/ZSKQAqNn7o2qJzH20630i4AGCm6bj8dfKCk1LmzAWVNgbT8GZkqVj0Hk3o1kEioq36Jwy
	v+bYZHg==
X-Google-Smtp-Source: AGHT+IFL+8SBcvf3jgd/Fu0Ax5ddowRDHeGJ6uBAQjp5iYeeHHRFS26oOh+ndsfJVw9WwZQocpqdf8pR2R0=
X-Received: from pjbhh14.prod.google.com ([2002:a17:90b:418e:b0:32e:cc38:a694])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cce:b0:335:2b15:7f46
 with SMTP id 98e67ed59e1d1-33bcf8f75b2mr642670a91.21.1760635826197; Thu, 16
 Oct 2025 10:30:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 10:28:51 -0700
In-Reply-To: <20251016172853.52451-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016172853.52451-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016172853.52451-11-seanjc@google.com>
Subject: [PATCH v13 10/12] KVM: selftests: Add helpers to probe for NUMA
 support, and multi-node systems
From: Sean Christopherson <seanjc@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

From: Shivank Garg <shivankg@amd.com>

Add NUMA helpers to probe for support/availability and to check if the
test is running on a multi-node system.  The APIs will be used to verify
guest_memfd NUMA support.

Signed-off-by: Shivank Garg <shivankg@amd.com>
[sean: land helpers in numaif.h, add comments, tweak names]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/numaif.h | 52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
index 1554003c40a1..29572a6d789c 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -4,6 +4,8 @@
 #ifndef SELFTEST_KVM_NUMAIF_H
 #define SELFTEST_KVM_NUMAIF_H
 
+#include <dirent.h>
+
 #include <linux/mempolicy.h>
 
 #include "kvm_syscalls.h"
@@ -28,4 +30,54 @@ KVM_SYSCALL_DEFINE(mbind, 6, void *, addr, unsigned long, size, int, mode,
 		   const unsigned long *, nodemask, unsigned long, maxnode,
 		   unsigned int, flags);
 
+static inline int get_max_numa_node(void)
+{
+	struct dirent *de;
+	int max_node = 0;
+	DIR *d;
+
+	/*
+	 * Assume there's a single node if the kernel doesn't support NUMA,
+	 * or if no nodes are found.
+	 */
+	d = opendir("/sys/devices/system/node");
+	if (!d)
+		return 0;
+
+	while ((de = readdir(d)) != NULL) {
+		int node_id;
+		char *endptr;
+
+		if (strncmp(de->d_name, "node", 4) != 0)
+			continue;
+
+		node_id = strtol(de->d_name + 4, &endptr, 10);
+		if (*endptr != '\0')
+			continue;
+
+		if (node_id > max_node)
+			max_node = node_id;
+	}
+	closedir(d);
+
+	return max_node;
+}
+
+static bool is_numa_available(void)
+{
+	/*
+	 * Probe for NUMA by doing a dummy get_mempolicy().  If the syscall
+	 * fails with ENOSYS, then the kernel was built without NUMA support.
+	 * if the syscall fails with EPERM, then the process/user lacks the
+	 * necessary capabilities (CAP_SYS_NICE).
+	 */
+	return !get_mempolicy(NULL, NULL, 0, NULL, 0) ||
+		(errno != ENOSYS && errno != EPERM);
+}
+
+static inline bool is_multi_numa_node_system(void)
+{
+	return is_numa_available() && get_max_numa_node() >= 1;
+}
+
 #endif /* SELFTEST_KVM_NUMAIF_H */
-- 
2.51.0.858.gf9c4a03a3a-goog


