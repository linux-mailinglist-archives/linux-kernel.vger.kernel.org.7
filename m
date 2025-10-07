Return-Path: <linux-kernel+bounces-844818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624D2BC2D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275F418911F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1225A33A;
	Tue,  7 Oct 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZ7RNk4l"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB927381B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875297; cv=none; b=MC7nTrO3VtLwBUL+I+MWKTKIgLCnaEa/ThsKvnrqVd/9y1JGg46sQuLJA8JQdWSprNV1fc9F4bJD6LE4GaYVHEd4HgIZ/TXmed71qxHRr4tQKf6s59dTsJiLXWcDB1uokBNrBsR/7G4LyQc4NOAWeMokwbwShfgFqG/RIl2iVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875297; c=relaxed/simple;
	bh=pEAhEjGmE/6E3+3IorVbdBNzf37J42NibPq0N4C1YsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=byXTqv61JojCuLRfowGC1Sp7gxTVjosTFMIo4vJKIYnqY5TYe2ukoPYFQF7dezSh8avSPIQv1hSB7iBtbNjEjdwBIoSAdSFAdH+CgRxKDlAtwZxU4eUQZipqbrpLvf+tygZ+I11G2jDd4uqc2pF/rNSdQg3eTlZnFhSjm4l/8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZ7RNk4l; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27eeb9730d9so67946005ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759875295; x=1760480095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zTQs0EnNDco2mpUUW8A1kWTJ2V3fPeD2Oux5tvQu97s=;
        b=AZ7RNk4lRemOUJ1AQ+l0/R311etQWhq16/9XadfgFbK/bpEjz5Jd3Wgu32razvWC+H
         S2QDEa9N6GSPZ6qyyGXpnuGeOzxBNsihz/y+Eii5BoY4xWnGC7JY7O7Y8Ybo+wpzcHo+
         lmEgA9mzTkelrKaVzaEf1ixU7Rbi3HMZOU3jnWKWMUUxiT57TewXx1RjB3l6Rpt01F1m
         oqWBqWZ/NkNRm4WpZStxWa4xQjoSSh8CP7hejF3OwxKiU+/TOifRRtw05YkaBg2Ooof3
         T9rkAskaTRHYd+Xm3/b/H3ev2r/vHkOk9lNO+j9R0PA6WOGm1kzBa0K/Ri+P8tMr+T4m
         LHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759875295; x=1760480095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTQs0EnNDco2mpUUW8A1kWTJ2V3fPeD2Oux5tvQu97s=;
        b=Gr9pVYfbebxw//lx+nqVOPHDqo6QoObQliS6P8QC8b7Vdf+/NjY8ECV2Xr+/d0duZX
         eTfs2id/Jb9UsgUzpnNCGt6p2m8A4sMqM+qpONXPLm3LkrSrQ7dd8gw5Q7Z6WvDAQxrC
         fQpo+k89n9cgnS2agk/0Kc7Uu+zuUOfh1Jq65C1knwZ3QFgzY9Id7xwKBLziNQXWNZAk
         i6BOwpQkmo3/tNgAQMSkZKOMl9YYFFafYHHNfWAIbuOibDHQgiM/g27IZ87Qge0O6GQ7
         10gJEF6WFMFNRIbJM2a7yuZvsg0puTr/Gg20EeutzeXIde1lguYtLSOhADdHB9IpNKUu
         BdMg==
X-Forwarded-Encrypted: i=1; AJvYcCUArQso2I9UhzYhF9alZg5Z7/yoljX3xmQD4S7EWbdBhGj0XWkIOK2oX3ZE8D/mECqshUAJZdHCSpJrPog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPiZ63eWuBD7s+KOS+vdrKpSsnl1r6b4gcXF1D6HdK/tqvrQc
	qE+XKxiEPWB7uRdOJapZr/+LeAT0TSv86cfELbhJhaRWBV9bupXCYQGjlovh0RqIzHHTG4s0Cq3
	aEMHsUQ==
X-Google-Smtp-Source: AGHT+IE4iOU9kwHgBlllnocBeU6IrHkDCIzq84NfugFiFee0pXpv+6bFVeJqE6gHwaZr6A6SdSFRTrYPG7c=
X-Received: from plhx16.prod.google.com ([2002:a17:903:2c10:b0:269:8ca7:6998])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e943:b0:269:ba8b:8476
 with SMTP id d9443c01a7336-2902741f0c1mr13607885ad.56.1759875294643; Tue, 07
 Oct 2025 15:14:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  7 Oct 2025 15:14:18 -0700
In-Reply-To: <20251007221420.344669-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007221420.344669-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007221420.344669-11-seanjc@google.com>
Subject: [PATCH v12 10/12] KVM: selftests: Add helpers to probe for NUMA
 support, and multi-node systems
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vlastimil Babka <vbabka@suse.cz>
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
2.51.0.710.ga91ca5db03-goog


