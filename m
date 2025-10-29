Return-Path: <linux-kernel+bounces-875100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A7DC18381
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1C714ED3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65333238D54;
	Wed, 29 Oct 2025 04:01:55 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292851E3DE5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761710514; cv=none; b=Z5mlbY9moLQSR32ajBQskjkgHlUY7XWAuiMuU8NocMzfHTJ0xHLArmfHpvdXSexTo+H0DDOVBtMbbWt+schjPOafd19vNFhoMU8HucCI4naPtl4a9TbDwTFqo4CTRZ4/9K6FTejj18z6Ixe/RBvfkFHomYp5/lFbGnCNK+OMJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761710514; c=relaxed/simple;
	bh=LKDLCtaCIHQ/NgSHufRUIv43r+UKoK+Ay+P1wDPYaTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ9i/eEJFV0c3yvd+8oqKDsz32giyRlyiTJd5puPJms8GwK9dDO0rqCVPbyc4ncH3i1qYbsaISp6qjSstSgz6VgXJNr2IGF2smHRbbBY2+YSH9TxH0z6MJyQgwD//mcQI/YIsxxIF02tXNDVCsORTnqH42+8BXvD12fAoDXM6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4cxCnv6KrhzB661H;
	Wed, 29 Oct 2025 11:45:55 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Wed, 29 Oct 2025 11:46:30 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stone.xulei@xfusion.com>, <chenjialong@xfusion.com>,
	<yuxiating@xfusion.com>, shechenglong <shechenglong@xfusion.com>
Subject: [PATCH v2 1/2] cpu:Remove the print when the  CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY Kconfig option is disabled.
Date: Wed, 29 Oct 2025 11:45:53 +0800
Message-ID: <20251029034554.1839-2-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20251029034554.1839-1-shechenglong@xfusion.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <20251029034554.1839-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03046.xfusion.com (10.32.128.186) To
 wuxpheds03048.xfusion.com (10.32.143.30)

Following the pattern established with other Spectre mitigations,=0D
do not prints a message when the CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY=0D
Kconfig option is disabled.=0D
=0D
Link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/202509180=
64907.1832-1-shechenglong@xfusion.com/=0D
Suggested-by: Will Deacon <will@kernel.org>=0D
Signed-off-by: shechenglong <shechenglong@xfusion.com>=0D
---=0D
 arch/arm64/kernel/proton-pack.c | 2 --=0D
 1 file changed, 2 deletions(-)=0D
=0D
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pac=
k.c=0D
index f9a32dfde006..d833b7c1bba8 100644=0D
--- a/arch/arm64/kernel/proton-pack.c=0D
+++ b/arch/arm64/kernel/proton-pack.c=0D
@@ -1042,8 +1042,6 @@ void spectre_bhb_enable_mitigation(const struct arm64=
_cpu_capabilities *entry)=0D
=0D
        if (arm64_get_spectre_v2_state() =3D=3D SPECTRE_VULNERABLE) {=0D
                /* No point mitigating Spectre-BHB alone. */=0D
-       } else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {=0D
-               pr_info_once("spectre-bhb mitigation disabled by compile ti=
me option\n");=0D
        } else if (cpu_mitigations_off() || __nospectre_bhb) {=0D
                pr_info_once("spectre-bhb mitigation disabled by command li=
ne option\n");=0D
        } else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {=0D
--=0D
2.33.0=0D

