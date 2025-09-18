Return-Path: <linux-kernel+bounces-776762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E2B2D131
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15603B53CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE21E51FA;
	Wed, 20 Aug 2025 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC/Oswqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4E1A9FB2;
	Wed, 20 Aug 2025 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652212; cv=none; b=WWgMtoWN1drvBg42tTmWBvUeGANkYwc+b8T4kntYD5l6YKIDHvmSHJKx7RM0yiP0mbl8VwFxGMt/JDJFshs1vIQ2I1p8aKfvtxxPn7AtPgt623JZnpVguKVrqb42SKkA1cITR5HjRmq713WPb0+/BzWFpLGG93ySkicuMbr4Ot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652212; c=relaxed/simple;
	bh=eOm/bvOMAexpdJ33PwPohvn+1KUMlAe/pR+UbnvP4KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IoZwZvDL1hgd8d2FSDBbzhZXhEaXI+5KXkqaJgHQa1UZANcTOmqEY6cWlPmYucxt5JGCQjsfmEPVaiHklNX8F1v1Yv/7lvBoyKZg6XZh2dHGHxQtW/2m8kQva5Hhiux7KFTYEmPHDxZy1zL+rW2mj+Uh+K52b9t+76DkJanLkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC/Oswqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8026CC19424;
	Wed, 20 Aug 2025 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755652212;
	bh=eOm/bvOMAexpdJ33PwPohvn+1KUMlAe/pR+UbnvP4KU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DC/OswqecYxkgXwl77+Ov+1rRro07KfOJwmeHWSHpYBZ10oJI4WQZgYIS4IjNf3Zy
	 bOladLIGr+Jo2FF+nPVz/HwNlhyniE7gyPPvpNWcLMz55Y83BwADvMDK9Yar/DPu1j
	 YO37H08npbK17SBQi9zghAaYyPrxhgu9gXvKj7wPCG3x1NTFU4eVtTFJ0pg1QejFrv
	 leTQMTnh+PRrD+DD4MLNXpnGaKQQA9siJl18gZZiwL9kPs0Cfkgx3zHX1SCkIsGor5
	 Jy7gUDAXwMiXP49UKFaoRLnwCdz1reAiMhW6iJoXwshOcaoNsFO59lUBuh1rqVAYdS
	 BLy2qBsNfCN8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7768CCA0EFA;
	Wed, 20 Aug 2025 01:10:12 +0000 (UTC)
From: Per Larsen via B4 Relay <devnull+perlarsen.google.com@kernel.org>
Date: Wed, 20 Aug 2025 01:10:08 +0000
Subject: [PATCH v11 4/6] KVM: arm64: Mark optional FF-A 1.2 interfaces as
 unsupported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-virtio-msg-ffa-v11-4-497ef43550a3@google.com>
References: <20250820-virtio-msg-ffa-v11-0-497ef43550a3@google.com>
In-Reply-To: <20250820-virtio-msg-ffa-v11-0-497ef43550a3@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755652211; l=1035;
 i=perlarsen@google.com; s=20250508; h=from:subject:message-id;
 bh=axvv1e3eXiB/+xexcDgx6JaWgpv5+SkVFL8SUFw7cGw=;
 b=GUSQIldlrNo8coOkbJ1NoBMsenhoCI9wnCj0kif4wX+McoVmMUpRsHZm9TM6nJaF+KYEu9Qo+
 7KbJ9pgZlrUAG4or8PmT8Uz4LOrxJ/vDXPQgVSx+hzLMihsRyY7tq5i
X-Developer-Key: i=perlarsen@google.com; a=ed25519;
 pk=jjc/Ta4VmrLRmMoahP6d1mBcKzvWU+nsmdtYe2oS2kQ=
X-Endpoint-Received: by B4 Relay for perlarsen@google.com/20250508 with
 auth_id=402
X-Original-From: Per Larsen <perlarsen@google.com>
Reply-To: perlarsen@google.com

From: Per Larsen <perlarsen@google.com>

Mark FF-A 1.2 interfaces as unsupported lest they get proxied.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Per Larsen <perlarsen@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 40a785b6ed063f9de31f51f1e82ebd9c70b13de9..96109aa99c48741e45a2b85d8e7bf26440597398 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -678,6 +678,11 @@ static bool ffa_call_supported(u64 func_id)
 	case FFA_NOTIFICATION_SET:
 	case FFA_NOTIFICATION_GET:
 	case FFA_NOTIFICATION_INFO_GET:
+	/* Optional interfaces added in FF-A 1.2 */
+	case FFA_MSG_SEND_DIRECT_REQ2:		/* Optional per 7.5.1 */
+	case FFA_MSG_SEND_DIRECT_RESP2:		/* Optional per 7.5.1 */
+	case FFA_CONSOLE_LOG:			/* Optional per 13.1: not in Table 13.1 */
+	case FFA_PARTITION_INFO_GET_REGS:	/* Optional for virtual instances per 13.1 */
 		return false;
 	}
 

-- 
2.51.0.rc1.167.g924127e9c0-goog



