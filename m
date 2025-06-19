Return-Path: <linux-kernel+bounces-693595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F80AE0123
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 11:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FAC178602
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02911284698;
	Thu, 19 Jun 2025 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQwIMTLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0127F75A;
	Thu, 19 Jun 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323808; cv=none; b=ZTvGG1JmJOrqg/9YuEvFerF2e0YKjpAOWZQOngn/O/AF0inNQhjU0kFQzQhBIeg6e4inD5yFCq70FjV23fr13ceCpGEIt03crdfkvahh+1r7Xp8E6+itXxH0mLBHbzp5imczh2Q3mWbfi9R302j3cOkIemm/dvo1C00KecmZFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323808; c=relaxed/simple;
	bh=JDMcRyLLeYcFRVBAt6QvueCzaPAy/7MNgWJNDM2A3wo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UqWCvZAViobPFOaCIUcBLT+zIP3LR2pfkJJkffvdXNXMQCiW959FgxId7BytgrG646ocr8NoRbt52OjrAvPs5Ys2CFw60AO9iRbUf4h6KEIhTD5OFs2d21WxW6Zqk5W9Yx9QjNXcLUwrZSQdmqbhV4bWEYlFhm+8ZzliR3dJ0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQwIMTLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 169F5C4CEEA;
	Thu, 19 Jun 2025 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323808;
	bh=JDMcRyLLeYcFRVBAt6QvueCzaPAy/7MNgWJNDM2A3wo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NQwIMTLGePLZCpJ6SD5ZnIRsdpYpKAnrCPMWJ6C+5nJYk1ssfxat6imk5Ig5Cwe1d
	 YROHkJ3EZzpuewS+PVZQwCuvOAj6CkEHqUg6ibP2Qv5icY24qliCdQvO/4pM9ozslz
	 FIznZvzA4mle4Rp+yy4Wav3GFUt5mFox922cgg9+bmU1nNNLMBdgLVUINc8Kd0A680
	 cL9qfdNtLsWtJD5AIU8iAGx7/v7uE6myfSyItDFHl9kY6FjxzK6NHAmA8Q5+tzJdoA
	 ONHSFjruidFOmiWpHXOvHC5V0Ic5mzEmG+1LZ23mW0DOzhpuQnkqfW2d57kGd8BEmk
	 Eg44TDqikthdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047B3C7115A;
	Thu, 19 Jun 2025 09:03:28 +0000 (UTC)
From: Per Larsen via B4 Relay <devnull+perlarsen.google.com@kernel.org>
Subject: [PATCH v5 0/6] KVM: arm64: Support FF-A 1.2 and SEND_DIRECT2 ABI
Date: Thu, 19 Jun 2025 09:02:53 +0000
Message-Id: <20250619-virtio-msg-ffa-v5-0-412c98558807@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3SU2gC/2XQTW7DIBCG4atErEsEw49JV7lH1AXFg40UTAQuS
 hX57sWWKrn1chbPq0/zIgVzwELeTy+SsYYS0tQO9XYibrTTgDT07SbAQDHFNK0hzyHRWAbqvaU
 A1nfgLsAVIw09Mvrw3IK3j3b7nCKdx4x2nwHWADNnASCF5JTTB+b7NcT4NdlpPrsU19gYypzy9
 zauwpr8DZj/OypQRrE30humxEWr65DScMcttQ6pYue5OHjRfK+167T3/BPcwcu9P/yhyuaVYYg
 dw7aP//HLsvwA+P8cZ2oBAAA=
X-Change-ID: 20250506-virtio-msg-ffa-22af72c92150
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Per Larsen <perlarsen@google.com>, 
 Ayrton Munoz <ayrton@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750323807; l=4385;
 i=perlarsen@google.com; s=20250508; h=from:subject:message-id;
 bh=JDMcRyLLeYcFRVBAt6QvueCzaPAy/7MNgWJNDM2A3wo=;
 b=malgCl1TuMWj2eQg3bYUOakJFv3JTuy39cNzNEoqz2BENpNeCbzMdEneYwr0JG/zh4bHHjFef
 5ZaYt1YbG+mDZEbNZcyaAG+MscMgOv3/v8Qwb0RLnX1YRZ8sBoCzc8H
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
addition of the FFA_MSG_SEND_DIRECT_REQ2 messaging interface. The bulk
of this change has to do with the upgrade to SMCCC 1.2 required by
FF-A 1.2. Additionally, unimplemented FF-A 1.2 interfaces are added to
the list of unsupported functions.

Tested by booting Android under QEMU and loading Trusty as the guest
VM and observing the SEND_DIRECT2 ABI being used successfully during
guest boot.

Changes since v4:
- 1/5 -> 1/6: Added Acked-by: Will Deacon <will@kernel.org>
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
To: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
To: Joey Gouly <joey.gouly@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Zenghui Yu <yuzenghui@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

---

---
Per Larsen (6):
      KVM: arm64: Correct return value on host version downgrade attempt
      KVM: arm64: Use SMCCC 1.2 in hyp_ffa_{init,post_init}
      KVM: arm64: Use SMCCC 1.2 in host FF-A handler
      KVM: arm64: Mark FFA_NOTIFICATION_* calls as unsupported
      KVM: arm64: Bump the supported version of FF-A to 1.2
      KVM: arm64: Support FFA_MSG_SEND_DIRECT_REQ2 in host handler

 arch/arm64/kvm/hyp/nvhe/Makefile |   1 +
 arch/arm64/kvm/hyp/nvhe/ffa.c    | 373 ++++++++++++++++++++++++---------------
 include/linux/arm_ffa.h          |   3 +
 3 files changed, 239 insertions(+), 138 deletions(-)
---
base-commit: fb4d33ab452ea254e2c319bac5703d1b56d895bf
change-id: 20250506-virtio-msg-ffa-22af72c92150

Best regards,
-- 
Per Larsen <perlarsen@google.com>



