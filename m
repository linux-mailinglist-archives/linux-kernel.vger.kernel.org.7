Return-Path: <linux-kernel+bounces-781020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9922B30C66
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84EB1BA325A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046D289367;
	Fri, 22 Aug 2025 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="G4bFmw0i"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A0271447
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832604; cv=none; b=VJXhZO0jKwniiqy+FPVupLoXUupCxS8cN4DAPS1KaZgsETWJ+6uiG49jUrwQA/EN0ArSauIGxHstxorKHt2iBUEz5NEsRqTMtvAcJhMZ+Kcmwl/ZYf/4i3LN056vdQn0ICvf6jfr7BYUu29s4gyYUzPqrLY6yWBILmCXHgHH5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832604; c=relaxed/simple;
	bh=UxmMU8bzkBQzj8gGXBuFRC2TfwP2x2RdYhhhCuDkImg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiQqKXlDonR+pO1i09Zir1uypsPAzRgvzoIzrSnpLFlrSiMeCbNZ3DsFZsoOC3+GLiFfUXNI0ZGFKS3yh7pVn9Vkib+fsnlyyzfg95KwI8Eb6yvM5scmdiLXH6x8XbOwzB41UKJKFk2/GOj9e15bjS8fDZ+AqWJE9bSZj46QCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=G4bFmw0i; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4716fa7706so1098635a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1755832600; x=1756437400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/zK7mkD8fhIY1XCicJNUFjtjYCKj9ei/cY2eINbo8s=;
        b=G4bFmw0iEqzubWHQZJjl0c74AlQlWfUd8bmb0rtFq4pAEt9+XhPyTuR2OJafyUVsok
         /pFHiZobRWpbUL0DrqtG04gNbiwrK8B9Il+uvpfGDNW9ZuyE346mVmhCGh2rTpJ8O2uY
         9VSBTVnxi/5drPJcsUQ3Eucy2PadpCSpaYkP4LH/RtFMitP8UxlFHJl09GpeZ6EaMCin
         L4qvvoMoog+2IGZF2cNxneBR7TmOr0z836YvyCKqUIj6+vEsMoWH4mu6cVTuFs5t/Aok
         9ovjskYrIs/OSvUfTizivqPQavli4cH8EtKYgUgu5AiLWm+wZvzWA6rjDMY3eKF3/wX/
         XCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832600; x=1756437400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/zK7mkD8fhIY1XCicJNUFjtjYCKj9ei/cY2eINbo8s=;
        b=ZQsYn0wq8HuCuJfK/mXcg2JTCeuXZi17u5kXOnLSOgHpij0r7GgAA/g5kVJy5ADpew
         FShXKNXUDLeP2iMrQC7rXhzvGArP2Ynq/XrgX1W9RIkAw9IsAVd5QvgCjwG6Ah9rsOr4
         +Re10w3IRlvGjE93O+zFRj7TaE368DBo2jMRgdrfbq12kyqEsNZAyVn3adMNdghztmBL
         LXum/E4t+q3ReNX5+Mmh9ToT1MqYUskXTgbIvwWSihaY+jqo5iHdJ8pA76pcXtI62GSe
         5Y/T8KMu15mQ2Y9GwS0yS+kQ/Z6bBJf8sg48x8btVZakUETL3Y62OIp3YBsmIv7Fiu4c
         jy8w==
X-Forwarded-Encrypted: i=1; AJvYcCWyz3JgTGJY2JsY1oJRmSwn+kdsPp21gGck8mpqxAH1f/QrzFv/P7lyfIl5EatofgFrjHsdc8GRYIxwy/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+rt7qDX9A/6+DM9VNnAhjcQYso2Xi4Lqfu0me7ZDRoNdKVT2
	ahhU2Os9FA/Nh88gn9aSxz9YAA2f0Pv8dzFhq/NYkusiUIlrF7uX6naEqVy5b0zTJk3KHsSHhY1
	T66CydjdRxNf6B/63srK7OLbxBx0RvtgBGoWYZ6sAn4WSYixUyzuMRNK5NrA=
X-Gm-Gg: ASbGncs02pZvd6MCOrc27BX4KOw14j2fNinQ+TqyINOqSIzs0kdylInMcT9z5KUH6Dd
	moFC16ndskUJn967SKaMZRi4Jc8xdvAnaNdVRRLTQlG1AQHNgVAcTsqV7CWWDGhHnYmsmWNuLSj
	O+p7vDAj/As2+LiHkG3NbureGo14xQKKEv0D0ozS6JBvIZjGpslR1sQKRLsxqbu8U9PWJ7GYepZ
	8uMyYbfM73JMcNlBPiEdiU5G8mBgE5s2IPYOlS5Hz2+wyJO1K6v0Guy2UN+DzZxvtKXfbHU55US
	KIe5+eYCUuMrb2yNn5eBt/udr07u1KXLKJtOkjdZfmo9craXU/NrduuOD50dkEb2KgQfRY2LBLw
	7U+jF3dKHb68CKLpZgOTUFK0I0Qw4SFmQdwa7NeMuz/nRkLGhrlSnw1t8R9zr
X-Google-Smtp-Source: AGHT+IGRHO829XEsXzh+WOPZNk1WyYwE7h4SZNk2NBxWmhF3KYYwHSWfii8nwJe2Ho0aEwY27Tlw2A==
X-Received: by 2002:a17:902:db01:b0:246:1a33:d9da with SMTP id d9443c01a7336-2462ef85803mr23044175ad.42.1755832600100;
        Thu, 21 Aug 2025 20:16:40 -0700 (PDT)
Received: from zenbook (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32514c4b722sm1089459a91.31.2025.08.21.20.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:16:39 -0700 (PDT)
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei-Lin Chang <r09922117@csie.ntu.edu.tw>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] KVM: arm64: nv: Allow shadow stage 2 read fault
Date: Fri, 22 Aug 2025 11:18:53 +0800
Message-ID: <20250822031853.2007437-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0

We don't expect to ever encounter a stage-2 read permission fault,
because read permission is always granted when mapping stage-2. However,
this isn't certainly the case when NV is involved. The key is the shadow
mapping built for L2 must have the same or stricter permissions than
those that L1 built for L2, hence opening the possibility of mappings
without read permission.

Let's continue handling the read fault if we're handling a shadow
stage-2 fault, instead of erroring out.

The following illustrates an example, vertical lines stand for either
L0, L1, or L2 running, with left: L0, middle: L1, and right: L2.
Horizontal arrows stand for traps and erets between them.

'''
L0                               L1                               L2
                                               L2                 |
                                               writes to an L2 PA |
|<----------------------------------------------------------------|
|
| L0
| finds no mapping in
| L1's s2pt for L2
|
| L0
| injects data abort
|------------------------------->|
                                 | L1
                                 | for whatever reason
                                 | treats this abort specially,
                                 | only gives it W permission
                                 |
       eret traps to L0          |
|<-------------------------------|
|
|      eret back to L2
|---------------------------------------------------------------->|
                                                                  |
                                                   L2             |
                                                   writes to same |
                                                   L2 PA (replay) |
|<----------------------------------------------------------------|
|
| L0
| finds mapping in s2pt that
| L1 built for L2, create
| shadow mapping for L2,
| but only gives it W to match
| what L1 had given
|
|
|      eret back to L2
|---------------------------------------------------------------->|
                                                                  |
                                                   L2             |
                                                   writes to same |
                                                   L2 PA (replay) |
                                                   success        |
|<----------------------------------------------------------------|
|
|
|------------------------------->| L1
                                 | for some reason, relaxes
                                 | L2's permission from W
                                 | to RW, AND, doesn't flush
                                 | TLB
                                 |
       eret traps to L0          |
|<-------------------------------|
|
|      eret back to L2
|---------------------------------------------------------------->|
                                                                  |
                                                    L2            |
                                                    read to L2 PA |
|<----------------------------------------------------------------|
| stage-2 read fault
|
'''

Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
---

I am able to trigger this error with a modified L1 KVM, but I do realize
this requires L1 to be very strange (or even just wrong) so I understand
if we don't want to handle this kind of edge case. On the other hand,
could there also be other ways to trigger this that I have not thought
of?

Another thing is that this change lets L1 get away with not flushing the
TLB, but TLBs are ephemeral so it's fine in this aspect, however I'm not
sure if there are other considerations.

---
 arch/arm64/kvm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1c78864767c5c..41017ca579b19 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1508,8 +1508,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
 	VM_BUG_ON(write_fault && exec_fault);
 
-	if (fault_is_perm && !write_fault && !exec_fault) {
-		kvm_err("Unexpected L2 read permission error\n");
+	if (fault_is_perm && !write_fault && !exec_fault && !nested) {
+		kvm_err("Unexpected S2 read permission error\n");
 		return -EFAULT;
 	}
 
-- 
2.50.1


