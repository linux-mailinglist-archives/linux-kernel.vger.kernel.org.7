Return-Path: <linux-kernel+bounces-816119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246EAB56FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6313B7866
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4576227602E;
	Mon, 15 Sep 2025 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QEgbWh2S"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094517BEBF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757914476; cv=none; b=M0jj+/IK7X4SpAKtmNHZIpJvhDGVRYWMwo8aK5/8AgX0eiY/8YM1bDKeEiqlIek72qajOWsMg0P5ufGjjTkMfX9joY6qLoz48qGN0GQ5T8a7Bed6NymqxP/z0ESrdJMg6FOkEV3HqVDlMpc7UlYhALnTse0rHwKVvlRsine/Tz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757914476; c=relaxed/simple;
	bh=1MJFzf4pGz8DgaKAs7CKJL+eWNPRE7XZdof1TjvBwFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1opix0NW7Epykv1EwMisDHh1CJg6+Qkgp8qG+UxgukIbGbCIAmCJL/0SBssgsecPT/EU/3VOSCafMA1TrAidM2pVtBKdgvalwsCdmR3ZOfBDxx8BcPCIo62AddWHzbsI/seP2niX5o9Qw3QQr9SnXqSmjV0xfZafJ05j8maHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QEgbWh2S; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77619f3f41aso1789051b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 22:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1757914473; x=1758519273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HcWOum1mNBViAIuGhSYHqBX6ni4rWoPSQnGJMRFhyRI=;
        b=QEgbWh2SGvLVQ6+bLS6V0L28fPmCVKNNK/2Td7dLtaGbjDpmryKsaGt7kFbgvyyOSf
         sA8XlWQrfscz7Zzniatf0LNv51nj6bjLy69KFwvL2WqhuSJeZyqYPPrvCAfv3KKFC9lG
         1WEcugjX3/OAsT14fzov+ZNdoa7b0nHSdXmOfGWfVdmmczTNAWwsiIIbZdalqfJwZNPs
         Vo3GRr7uWWzk/Yh4eaqLAHHKjBaeAWMtid0YbLSjJA0p03BZolej73suIWPFdydDpenz
         fLS4hQUoW+enX77HgWGjBvDxJm9QwnTbwldMyO+9K6CYV+myFDusNtWaPa3dgC7n6yDA
         8Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757914473; x=1758519273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcWOum1mNBViAIuGhSYHqBX6ni4rWoPSQnGJMRFhyRI=;
        b=fEGH5868CY1DBJOPOsaLQkEkA2Zg577hhzFuQ6DGNyuF7rpYYR4yotRK7pC6DpCFuE
         xpREp3NXdUyvID5gj0HlUTqEDe/SLkCIUgkWCnJZJETrzkYpTD2bLVI4ljVXsvPVjSeU
         +H6k31GhGp+dG9YI4iWiY17e7o0Q+IInrplRc9kvAZvTvzDD/IFG2SbpnXxKPohdk4Po
         AZiS1gUgnrBcBvP28hpiXM+GhTR4QOpdfG7RhTNV0oxVposNCWBf28p3m0xTrOc5S6Wd
         ljQwRA9cbCu06PRG6nfZFONpnqAIrDY/faLBae/TKjg5F1q85WC4PGjeSAq6UaEo/cbf
         7JUA==
X-Forwarded-Encrypted: i=1; AJvYcCUFs15C0Qn7Z9klBj+zQX45zODUulxXwTKRPryVThJQTpkHKbmvx2+vhe112SBjNumbAVFwHCzfzBRySg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kmgcWA+w2y8UUHhm3XLVxjBMRTph8jiW5oh/AzDk6BBiksYj
	7gT8ig4p3JVz0s542hbI6lYH88+13iRdOrUYAfp9X663wXLkXlW6kB8SXPFdS4TdAtY=
X-Gm-Gg: ASbGncs+c+YRvcoLjAs5Nm/F9tniZLXtCL2hCCMiqcyAD1WZXSLaQiZo/SYpZSVUMaE
	3hbhSQJEnJXOyHme8/VnIsTrEmJzv3vg+0bMyvdIv/kGrWIePXztNDO3geHlSfSfQgg1qA7JUZb
	lu6xLBlzCBO/9WCpsAcb1ju1jvxxqArPcw/6lYeVFMB7KKxOlQkvdNZFl0Q+Ud7pHc3NyFCFskt
	NCbvjpv8tJR+/gZmsxEOR2+04+/Sr/LR+TpOOhJnbOcmdNbEHGAX4lm4Rl8gb6EdxLq6DF/z2Y1
	8mqGA9asqDpUWzLhF49HHXaL6+TDBkisao0a+c+NuB7VVvQ8CnjX0mnChqxEZ2LVTf1qay0bE/2
	5PKj2gPNfjEgc6CZROw85xpPt2/KeIea3dCUs5eqo8rDoiEuYvp7A4Vg=
X-Google-Smtp-Source: AGHT+IGjRSvNn9pjamHg0axHO24KuBYdd0ejvKhVmAXCjHWpKLeck8mQqMrFQreoUO1LGLwUqHHLQg==
X-Received: by 2002:a05:6a21:999a:b0:262:d265:a3c with SMTP id adf61e73a8af0-262d2650de3mr5504416637.32.1757914473069;
        Sun, 14 Sep 2025 22:34:33 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387cc21sm10604151a12.28.2025.09.14.22.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 22:34:32 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	kvm-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] RISC-V: KVM: Fix SBI_FWFT_POINTER_MASKING_PMLEN algorithm
Date: Sun, 14 Sep 2025 22:34:20 -0700
Message-ID: <20250915053431.1910941-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of SBI_FWFT_POINTER_MASKING_PMLEN from commit
aa04d131b88b ("RISC-V: KVM: Add support for SBI_FWFT_POINTER_MASKING_PMLEN")
was based on a draft of the SBI 3.0 specification, and is not compliant
with the ratified version.

Update the algorithm to be compliant. Specifically, do not fall back to
a pointer masking mode with a larger PMLEN if the mode with the
requested PMLEN is unsupported by the hardware.

Fixes: aa04d131b88b ("RISC-V: KVM: Add support for SBI_FWFT_POINTER_MASKING_PMLEN")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---
I saw that the RFC version of this patch already made it into
riscv_kvm_queue, but it needs an update for ratified SBI 3.0. Feel free
to squash this into the original commit, or I can send a replacement v2
patch if you prefer.

 arch/riscv/kvm/vcpu_sbi_fwft.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index cacb3d4410a54..62cc9c3d57599 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -160,14 +160,23 @@ static long kvm_sbi_fwft_set_pointer_masking_pmlen(struct kvm_vcpu *vcpu,
 	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
 	unsigned long pmm;
 
-	if (value == 0)
+	switch (value) {
+	case 0:
 		pmm = ENVCFG_PMM_PMLEN_0;
-	else if (value <= 7 && fwft->have_vs_pmlen_7)
+		break;
+	case 7:
+		if (!fwft->have_vs_pmlen_7)
+			return SBI_ERR_INVALID_PARAM;
 		pmm = ENVCFG_PMM_PMLEN_7;
-	else if (value <= 16 && fwft->have_vs_pmlen_16)
+		break;
+	case 16:
+		if (!fwft->have_vs_pmlen_16)
+			return SBI_ERR_INVALID_PARAM;
 		pmm = ENVCFG_PMM_PMLEN_16;
-	else
+		break;
+	default:
 		return SBI_ERR_INVALID_PARAM;
+	}
 
 	vcpu->arch.cfg.henvcfg &= ~ENVCFG_PMM;
 	vcpu->arch.cfg.henvcfg |= pmm;
-- 
2.47.2

base-commit: 7835b892d1d9f52fb61537757aa446fb44984215
branch: up/kvm-fwft-pmlen

