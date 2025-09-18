Return-Path: <linux-kernel+bounces-776758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F14D7B2D12B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80DBC4E3F59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4A1E3DF8;
	Wed, 20 Aug 2025 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbjnUHBJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929CA1714B7;
	Wed, 20 Aug 2025 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652212; cv=none; b=BW+1eRtPbFIlXrnlrbN1naZqnwLIQb6Enx7+9vQWjjC9w+0JzqtU61iygQdg0bSoNrLtQZjmMUtbU+DN+iaK/+K/hvWbWhLt615j+PAblXmrfZadgWh86LIjkw84NFVXn9Bf9iDu6EIAYnvJ8UgKJB6OU5BsywQSPdNTPW+HwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652212; c=relaxed/simple;
	bh=QqCqZYsdP7t4g4BRpW/sqNVAX3nSnpvab2ktJo5GCZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=phXwiIspzMLU07h3rH5bNEGpqkDp+WGQUZZ2ST/F0pi2jFgB7z3MnSjEJBaQ1eoAW+ovGk7+gZwv7jaxzXykBLpoBCn16ApIJeqGPlLKGO0nxSEKB67+2j96GeYDvaFCJneBUAwt1FjxpRzbGoHyMgE5WIluXP0zwZSDXOv/J7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbjnUHBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F6A9C4CEF1;
	Wed, 20 Aug 2025 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755652212;
	bh=QqCqZYsdP7t4g4BRpW/sqNVAX3nSnpvab2ktJo5GCZI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jbjnUHBJTgwfeCU+mhl53J56OUOYQ7r2FrHmz99Sb6oof4t6asKvQW6+vlT3A6DwC
	 ymDrNbLoWd5i/54vZTnGz8Bg9qT/nufSrMIswSkfbArvC64ADi7v5Jf4uki0hJN1lF
	 /HMRP/OCcxeTrb4Wo475yFwWu6m7SgGioeSUiNhqBd83a4kFrgPFG0aBSwfaAaF7be
	 KVQfmxctOxrRc+q42K0YAF5yTqzE+mmJjL1T0ThDz5nVJbXJT/isPi7SJqdPFL8AxH
	 iJohj5sio3IoJXbrC24JvH0rW1vsEWo/eJKgNlg1VHORNNdBsKTELHZtuNRAMKOJYs
	 iozPz3fCEWR+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A99CA0EF7;
	Wed, 20 Aug 2025 01:10:12 +0000 (UTC)
From: Per Larsen via B4 Relay <devnull+perlarsen.google.com@kernel.org>
Subject: [PATCH v11 0/6] KVM: arm64: Support FF-A 1.2
Date: Wed, 20 Aug 2025 01:10:04 +0000
Message-Id: <20250820-virtio-msg-ffa-v11-0-497ef43550a3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGwgpWgC/23QTWrDMBCG4asEr6sw+h91lXuULhRp5AhiO8iua
 Qm5e5VAiVt1KcPz+mOu3Uwl09y97q5doTXPeRrrg/OXXRdOfuyJ5Vg/dAKEBg2GrbkseWLD3LO
 UPBPCJyuCE1xDV9GlUMqfj+Lbe32nMg1sORXy24yACgD3UgglFWecXaicD3kYPkY/LvswDffYK
 c/LVL4e61ZxT/4E8O+OVTBgFFElBC2d0Yd+mvozPVL3IavceC4bL6uPxgRrUuJHERqvtr65w6q
 q1whEFqju443XT2+4a7yuXvF6SdQaEWzjzcYL23hTPQYQKTpF0bf77dNb4I231TunfQoyStTUe
 Nz4f/Zj9SAJCeORUJvGu42X0HhXva2X1zpg5Mo1nsMzgNAO4PX/jKMjopDQE/4q3G63b18j40b
 tAgAA
X-Change-ID: 20250506-virtio-msg-ffa-22af72c92150
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755652211; l=6304;
 i=perlarsen@google.com; s=20250508; h=from:subject:message-id;
 bh=QqCqZYsdP7t4g4BRpW/sqNVAX3nSnpvab2ktJo5GCZI=;
 b=iny0EFqW+/PEkNwnpa4x+b5zwUiDi/GP4/0u8CjsotUoG+dgW9JYlCx2MDcO0nO/jt0iDXBCl
 PvvzKw8emXiCdvQM5DIt/7b3Ec4v4zWFHqykBfp+sD6/z2T2bwoqsHR
X-Developer-Key: i=perlarsen@google.com; a=ed25519;
 pk=jjc/Ta4VmrLRmMoahP6d1mBcKzvWU+nsmdtYe2oS2kQ=
X-Endpoint-Received: by B4 Relay for perlarsen@google.com/20250508 with
 auth_id=402
X-Original-From: Per Larsen <perlarsen@google.com>
Reply-To: perlarsen@google.com

Hi,

The FF-A 1.2 specification introduces a new SEND_DIRECT2 ABI which
allows registers x4-x17 to be used for the message payload. This patch
set prevents the host from using a lower FF-A version than what has
already been negotiated with the hypervisor. This is necessary because
the hypervisor does not have the necessary compatibility paths to
translate from the hypervisor FF-A version to a previous version.

Support for FF-A 1.2 in the hypervisor is added as a precursor to the
addition of the FFA_MSG_SEND_DIRECT_REQ2 messaging interface. Notably,
this patch updates all smc calls to use SMCCC 1.2 as it makes it simpler
to support interfaces that need to accept more than 8 arguments and/or
return more than 4 values. The list of optional/unsupported interfaces
was updated to reflect additions in FF-A 1.2.

Tested by booting Android under QEMU and loading Trusty as the guest
VM and observing the SEND_DIRECT2 ABI being used successfully during
guest boot.

Changes in v11:
- 2/6:         ffa_set_retval: Add more details about anticipated FF-A 1.3 update. Fix typo.
- Link to v10: https://lore.kernel.org/r/20250809-virtio-msg-ffa-v10-0-189eeecf8ae8@google.com

Changes in v10:
- 2/6:        Return registers x0-x17 unconditionally in ffa_set_retval for consistency with passthrough code
- 4/6:        ffa_call_supported: Drop case FFA_EL3_INTR_HANDLE
              Added Acked-by: Will Deacon <will@kernel.org>
- Link to v9: https://lore.kernel.org/r/20250730-virtio-msg-ffa-v9-0-7f1b55c8d149@google.com

Changes in v9:
- 2/7 -> 2/6: Updated explanatory comment in ffa_set_retval
- 4/7 -> 4/6: Restore to v7: Mark FFA_MSG_SEND_DIRECT_REQ2 unsupported
- 5/7 -> 5/6: Added Acked-by: Will Deacon <will@kernel.org>
- 6/7 -> 6/6: Added Acked-by: Will Deacon <will@kernel.org>
- 7/7:        Dropped
- Link to v8: https://lore.kernel.org/r/20250719-virtio-msg-ffa-v8-0-03e8e8dbe856@google.com

Changes in v8:
- 2/5 -> 2/7: Use func_id argument to distinguish SMC32/SMC64. Update rationale.
- 4/5 -> 4/7: Split up 4/5: Add optional FF-A 1.2 interfaces
- 4/5 -> 5/7: Split up 4/5: Mask FFA_RXTX_MAP minium buffer size in a2. Don't check MBZ bits.
- 4/5 -> 6/7: Remainder of 4/5: Bump supported version to FF-A 1.2
- 5/5 -> 7/7: Don't check src id in do_ffa_direct_msg2
- Link to v7: https://lore.kernel.org/r/20250701-virtio-msg-ffa-v7-0-995afc3d385e@google.com

Changes in v7:
- 0/6:        Revised cover letter slightly
- 4/6:        ffa_call_supported: Clarify optional interfaces
              hyp_ffa_post_init: Sanitize MBZ bits in x2 and x3
              address nit: use GENMASK
- Link to v6: https://lore.kernel.org/r/20250627-virtio-msg-ffa-v6-0-8c02fd94edac@google.com 

Changes since v5:
- 3/6 -> 2/5: Merged with parent patch as they were closely related
              Don't rename variables from "res" to "regs" to avoid churn
              Update and clarify reasoning for condition added to ffa_set_retval
              Adopt style suggested by Marc when passing regs to arm_smccc_1_2_smc
              Fix inadvertent duplicate statements in ffa_{map,unmap}_hyp_buffers
- Link to v5: https://lore.kernel.org/r/20250619-virtio-msg-ffa-v5-0-412c98558807@google.com

Changes since v4:
- 1/5 -> 1/6: Added Acked-by: Will Deacon <will@kernel.org>y
              Reworded patch subject and description
- 2/5:        Dropped patch: zero x4-x7 in ffa_set_retval
-        2/6: New: use SMCCC 1.2 during hyp init
-        3/6: New: use SMCCC 1.2 in host FF-A handler
- 3/5 -> 4/6: No change; can revisit denylist design in later patchset
              Added Acked-by: Will Deacon <will@kernel.org>
- 4/5 -> 5/6: No change
- 5/5 -> 6/6: No change
- Link to v4: https://lore.kernel.org/r/20250516-virtio-msg-ffa-v4-0-580ee70e5081@google.com

Changes since v3:
- all:        Remove Signed-off-by: Per Larsen <perl@immunant.com>
- 2/5:        Split out from 2/3, zero x4-x7 in set_ffa_retval
- 3/5:        Split out from 2/3, Mark FFA_NOTIFICATION_* calls as
              unsupported
- 2/3 -> 4/5: Drop ffa_get_hypervisor_version, access hyp_ffa_version
              directly when version negotiation is complete.
- 3/3 -> 5/5: Call ffa_to_smccc_1_2_error directly in
              do_do_ffa_direct_msg2
              Push call to ffa_call_needs_smccc_1_2 lower down by adding
              ffa_get_func_id and ffa_set_retval_smccc_1_x.
              Drop ffa_to_smccc_1_2_regs and ffa_to_smccc_1_2_regs_prop
              as they are no longer used.
- Link to v3: https://lore.kernel.org/r/20250513-virtio-msg-ffa-v3-0-d66c76ff1b2c@google.com 

Changes since v2:
- 2/3: Removed files added by mistake.
       Add and use ffa_get_hypervisor_version to access hyp_ffa_version
- 3/3: Use ffa_get_hypervisor_version to access hyp_ffa_version safely
- Link to v2: https://lore.kernel.org/r/20250508-virtio-msg-ffa-v2-0-ed84f8053965@google.com

Changes since v1:
- 1/3: Simplify commit message; drop long comment in do_ffa_version
- 2/3: Correct use of Co-developed-by: footer
       s/arm_smccc_1_2_smc_fallback/arm_smccc_1_x_smc/
       Always access hyp_ffa_version w/lock held
       Remove superfluous comments in ffa_call_supported
       Add and use FFA_FEAT_RXTX_MIN_SZ_MASK instead of constant
       Add FFA_PARTITION_INFO_GET_REGS to calls that require SMCCC 1.2
- 3/3: Always access hyp_ffa_version w/lock held
       Correct formatting

Thanks,
Per Larsen

--
2.49.0

---
Per Larsen (6):
      KVM: arm64: Correct return value on host version downgrade attempt
      KVM: arm64: Use SMCCC 1.2 for FF-A initialization and in host handler
      KVM: arm64: Mark FFA_NOTIFICATION_* calls as unsupported
      KVM: arm64: Mark optional FF-A 1.2 interfaces as unsupported
      KVM: arm64: Mask response to FFA_FEATURE call
      KVM: arm64: Bump the supported version of FF-A to 1.2

 arch/arm64/kvm/hyp/nvhe/Makefile |   1 +
 arch/arm64/kvm/hyp/nvhe/ffa.c    | 217 ++++++++++++++++++++++++++-------------
 include/linux/arm_ffa.h          |   1 +
 3 files changed, 146 insertions(+), 73 deletions(-)
---
base-commit: b19a97d57c15643494ac8bfaaa35e3ee472d41da
change-id: 20250506-virtio-msg-ffa-22af72c92150

Best regards,
-- 
Per Larsen <perlarsen@google.com>



