Return-Path: <linux-kernel+bounces-872410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A903CC10ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912675646D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36BE274FD0;
	Mon, 27 Oct 2025 19:17:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB2A17F4F6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592656; cv=none; b=e/OHKXMJytKGg3YSHCUtRFIeKM+347HD3IZsuiR54TKrw7yKarSi/OLdCNCQzgDMI2UqyA6sYho6SUgDpOEmjk57oOgocbTqwic0HbkwFBmycKnZnv6wfmZVTqbix83RnFYf2qi1LyJy+lQ4akfz2K9IHHTir0yq5djJphMxo3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592656; c=relaxed/simple;
	bh=YQ3CEdiME4l7INBeC7ifJ0qoBqJo++fsrzCxtPoPAEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Kv+0RXBKLa2xRD8wRTAmoYFXmdCEq5qjWVfr1LiH9AWHzL4c0Gk9pMU9YRI/8B+cjVEnwrd/YUcTlOzNIvn8rTRLsHiVudmbsA7JNb0XU268p2+u3rCfeNLNW9B1Q/g/m18lJ1WMgGe/PxcrHHTDR6xZFD4SWkfqtaGQr2PzwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53633169E;
	Mon, 27 Oct 2025 12:17:25 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 393153F63F;
	Mon, 27 Oct 2025 12:17:31 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	perlarsen@google.com,
	ayrton@google.com
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 0/2] use TPM device with CRB over FF-A when kernel boot with pkvm
Date: Mon, 27 Oct 2025 19:17:27 +0000
Message-Id: <20251027191729.1704744-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To use TPM device iwth CRB over FF-A, it would be good to be compiled:
  - CONFIG_ARM_FFA_TRANSPORT as bulit-in
  - CONFIG_TCG_ARM_CRB_FFA as built-in

to integrate with IMA subsystem otherwise, it couldn't generate the
boot_aggreate log with the PCR value.

Unfortuately, kernel fails to probe the TPM device
when it boots with kvm-arm.mode=protected since the FF-A calls
(FFA_SEND_DIRECT_MSG/MSG2) are failed when CONFIG_ARM_FFA_TRANSPORT=y.

This patch series resolves failure of the TPM device when
kernel boots with kvm-arm.mode=protected and based on v6.18-rc3.

Yeoreum Yun (2):
  KVM: arm64: fix FF-A call failure when ff-a driver is built-in
  KVM: arm64: support optional calls of FF-A v1.2

 arch/arm64/kvm/hyp/nvhe/ffa.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)


base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


