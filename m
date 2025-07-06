Return-Path: <linux-kernel+bounces-712215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10DBAF0639
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 00:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D11C02B93
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E6306DC1;
	Tue,  1 Jul 2025 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou9N1VQW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5B2FE386;
	Tue,  1 Jul 2025 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407607; cv=none; b=Q9xb0eVSdBZ9Ja+ghtPVq0eOaKjs3Ex/6QU0isieniU7YWslbjEaGpKEn56+5l1LN0VHYGb+wRfqH31Y4Ml/VtUaYoQzPVVmrFXEXOUKhfsZGTNBs1bqY2yTnubThyS+NqrY0kzfPJmoMXquuia+3w7BiDYIowwTNlLLInQDS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407607; c=relaxed/simple;
	bh=coAKO9TLhK8MTIgf77yLemsOevi3hPcTUAqXS91Y2b4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLeNxqTHDJDik8BKW+gIkp0C146jGw6sXc4ixJEtXneotUaJ86IhUo9777+lrW/x6zjra7mW82F1Z8FzWoXal0GTkMb5Rl8BYaey8lhG/7T4bOtuO7Z5OZB9j6C7Z7lWD5pFz0eRRxC4cCQ1DOwFQgPmMb7+Qqdk7eI3P0Hdufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou9N1VQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6688AC4CEF3;
	Tue,  1 Jul 2025 22:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751407607;
	bh=coAKO9TLhK8MTIgf77yLemsOevi3hPcTUAqXS91Y2b4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ou9N1VQWEpWqTJgnCNRhMvXIzHw+LyYwPmDO37rQ0wuMJYADInvEcSP7RvEEPV/Hv
	 mVqafQKIUYfwd+DySyV4CkmOKFysZAppyNhCCyaW9eDiZRCLpJhfgKSPqrYYhfYsTR
	 /7BVBY/MaGyayNxtNwxudldX73TfASMmOL6567TXwhrtYAOsfHvQWnwBMAFNdSfiKK
	 AMWosxvMUEo6svrC0FM8qEiNOB11a6HiTt2O/s+26rztwzSVpZP618MK8p9vbU4OP+
	 Om5/EQ8pF8Q+ZsvRT9xtmLam1uNeiEwWs4onSDsdnQ7/i9G80Me0aAUuQ+dF49n2B2
	 0caV0cTO9jN4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54480C8303D;
	Tue,  1 Jul 2025 22:06:47 +0000 (UTC)
From: Per Larsen via B4 Relay <devnull+perlarsen.google.com@kernel.org>
Date: Tue, 01 Jul 2025 22:06:34 +0000
Subject: [PATCH v7 1/5] KVM: arm64: Correct return value on host version
 downgrade attempt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-virtio-msg-ffa-v7-1-995afc3d385e@google.com>
References: <20250701-virtio-msg-ffa-v7-0-995afc3d385e@google.com>
In-Reply-To: <20250701-virtio-msg-ffa-v7-0-995afc3d385e@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, ahomescu@google.com, armellel@google.com, 
 arve@android.com, ayrton@google.com, qperret@google.com, 
 sebastianene@google.com, qwandor@google.com, 
 Per Larsen <perlarsen@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751407606; l=1399;
 i=perlarsen@google.com; s=20250508; h=from:subject:message-id;
 bh=Dl9KrxrUP4K0W3dgejUfrC3aK93wdcqeauIVLeuo9f0=;
 b=5+AIZdXIIvjP+RFQX4/gsaepjpoFaUB3whIL6rjGFeBYlFyAuLRkoOvgzhSwRQhsyy388yIym
 3qKnZpyTKsYCmPGQlh0pIPCa2Xcoa7Q6uUDbGY9Mzwew3tvIgMN7r6E
X-Developer-Key: i=perlarsen@google.com; a=ed25519;
 pk=jjc/Ta4VmrLRmMoahP6d1mBcKzvWU+nsmdtYe2oS2kQ=
X-Endpoint-Received: by B4 Relay for perlarsen@google.com/20250508 with
 auth_id=402
X-Original-From: Per Larsen <perlarsen@google.com>
Reply-To: perlarsen@google.com

From: Per Larsen <perlarsen@google.com>

Once the hypervisor negotiates the FF-A version with the host, it should
remain locked-in. However, it is possible to load FF-A as a module first
supporting version 1.1 and then 1.0.

Without this patch, the FF-A 1.0 driver will use 1.0 data structures to
make calls which the hypervisor will incorrectly interpret as 1.1 data
structures. With this patch, negotiation will fail.

This patch does not change existing functionality in the case where a
FF-A 1.2 driver is loaded after a 1.1 driver; the 1.2 driver will need
to use 1.1 in order to proceed.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Per Larsen <perlarsen@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 3369dd0c4009f84ad3cf9481c747bdc57a162370..2c199d40811efb5bfae199c4a67d8ae3d9307357 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -712,7 +712,10 @@ static void do_ffa_version(struct arm_smccc_res *res,
 
 	hyp_spin_lock(&version_lock);
 	if (has_version_negotiated) {
-		res->a0 = hyp_ffa_version;
+		if (FFA_MINOR_VERSION(ffa_req_version) < FFA_MINOR_VERSION(hyp_ffa_version))
+			res->a0 = FFA_RET_NOT_SUPPORTED;
+		else
+			res->a0 = hyp_ffa_version;
 		goto unlock;
 	}
 

-- 
2.50.0.727.gbf7dc18ff4-goog



