Return-Path: <linux-kernel+bounces-875103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC1C18387
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61BB3AB9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080CF2F0699;
	Wed, 29 Oct 2025 04:03:35 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C61D63F7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761710614; cv=none; b=ZvAF5ubot2vH14elD8L2Q+zbdpmelZn0ur/zukZjZuQo5Zss57OFhmk2kaihARBmBUsPwd/2wXi6CJ+pJFHU+Qw0cXDElsjroWwOCkQEDHRso4Fb9wt0oM2RfpyYLyjdSJgw+Bnm8ODPkfUpN6sR0V2wx3ZOv2P2M1DkS+F42I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761710614; c=relaxed/simple;
	bh=zrFmmUIXMOCdMAOoV7laydL0QAUCSBQLsJZH0rCuNP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/7/Dc1ioK1kYE1pAE/Kn/edgodcO0CUIfxf766on6uZ0izhl+xPUCIu9A2tAk/OnY2QvlLqzIdZq607F3aP8ay9TIRw7OBVHNzqV/PWO2h+lP8faFgYx5nXlppTbKsjZEsczFhiAyCEZHYs+z/sXUSyAs6h18ma4oiYPX7Sd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4cxClK0Jz4zBCLfh;
	Wed, 29 Oct 2025 11:43:41 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Wed, 29 Oct 2025 11:46:01 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stone.xulei@xfusion.com>, <chenjialong@xfusion.com>, <yuxiating@xfusion.com>
Subject: [RESEND v2 0/2] arm64: spectre: Fix hard lockup and cleanup mitigation messages
Date: Wed, 29 Oct 2025 11:45:52 +0800
Message-ID: <20251029034554.1839-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20250918064907.1832-1-shechenglong@xfusion.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
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

On Wed, Sep 24, 2025 at 08:32:47PM +0800, shechenglong wrote:=0D
> relocate the printk() calls from spectre_v4_mitigations_off() and=0D
> spectre_v2_mitigations_off() into setup_system_capabilities() =0D
> function, preventing hard lockups that occur when printk() is invoked fro=
m scheduler context.=0D
> =0D
> Link: =0D
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/2025091806=0D
> 4907.1832-1-shechenglong@xfusion.com/=0D
> Suggested-by: Mark Rutland <mark.rutland@arm.com>=0D
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>=0D
> Signed-off-by: shechenglong <shechenglong@xfusion.com>=0D
=0D
Thanks for the review and suggestions, Will!=0D
=0D
This v2 series addresses your comments:=0D
- Fixed the message to use "command-line" consistently=0D
- Created spectre_print_disabled_mitigations() function to handle all spect=
re mitigation messages=0D
- Added a separate patch to remove the CONFIG_MITIGATE_SPECTRE_BHB option=0D
=0D
The series includes two patches:=0D
=0D
Patch 1: "fix hard lockup triggered by printk calls within scheduling conte=
xt"=0D
- Moves printk calls from scheduler context to setup_system_capabilities()=
=0D
- Prevents hard lockups by avoiding printk in unsafe contexts=0D
- Consolidates spectre mitigation status reporting=0D
=0D
Patch 2: "Remove the print when the CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY =
Kconfig option is disabled"=0D
- Removes the obsolete CONFIG_MITIGATE_SPECTRE_BHB Kconfig option=0D
- Cleans up the spectre mitigation code as suggested=0D
=0D
shechenglong (2):=0D
  arm64: spectre: fix hard lockup triggered by printk calls within scheduli=
ng context=0D
  arm64: spectre: Remove the print when the CONFIG_MITIGATE_SPECTRE_BRANCH_=
HISTORY Kconfig option is disabled=0D
=0D
 arch/arm64/include/asm/spectre.h |  2 ++=0D
 arch/arm64/kernel/cpufeature.c   |  7 ++++++-=0D
 arch/arm64/kernel/proton-pack.c  | 28 ++++++++++++++--------------=0D
 3 files changed, 22 insertions(+), 17 deletions(-)=0D
=0D
-- =0D
2.25.1=

