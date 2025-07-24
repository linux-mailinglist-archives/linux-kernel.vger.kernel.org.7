Return-Path: <linux-kernel+bounces-743516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B842FB0FF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4663B605D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7EC1EF38E;
	Thu, 24 Jul 2025 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QpsttOkH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6157524F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753331182; cv=none; b=OxK4qKRqGtmfPtFai6lS/zSiFydBModZvfyNnntsMjTIUkN35Hq2uFYxPZjcqMjkz3eJ3w/1WspKib1qFqYpFeNhMFRS+0I+ZMyFP0OC7g4U0RHakKCVJLo+hplCvgtMGlvfJtKTgzPynfs9Cyu3TAm8I+qC43JcNEENg9ENWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753331182; c=relaxed/simple;
	bh=TWBkbq+tvfq/zZbrpQ+/xiUhc0ndZKkb6GrpTq98nFA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nIdJTMpiWwLOkbEb9WHliebA+qopoL5Vfcmc3iYOM6zLJfbpTaKoR5R/RXcQzdSfSqjoLQuyGzInmwm18eo2A8P3M2+r6NLVNheQFigomBRRI3zhRF/QjgYia1/PSUMI7dgk/95x6U38E06bkIWIDKUEwnky1OVdMI9cMeeD0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QpsttOkH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7216B40E0269;
	Thu, 24 Jul 2025 04:26:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GIPNf9hvZ4Dx; Thu, 24 Jul 2025 04:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753331170; bh=sIv3UoB1llrHecQQhUt0t/mTLGaF5vj8yx2UU+N6pI0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QpsttOkH/U/3KutLoXQnMz5RgX3v5RMOi0ni0x16LK7/U+Mv2yOcBj88+HDAEbR+u
	 L3KP3hQZr6kHKIKus4TJTWipw8Ox6OU4CCWcCPjT9RHd6elBvtUsK9glUduz6Fo3WB
	 jZcyRI/YOzk+jrRHJgFiqqR5h7PN25B528tglaZBIoxqQ9xhmDdDLMwq5EpMknxkkb
	 hZg7FrZ1ez5zo6zxwNT5dq1y07Vx9h2edDGuT/HvpBhjRbgI4pxWh/2M1gcgGrOaut
	 ImsMpZj+/mh0dnx5nEozCgmTRPvN2JJeK6l9T7bHmyyihn6W6b13jgG4yzzXG8TxBM
	 TrjtgtTJ7mWLWab74p7T7o+Db9YwKoogacb+gbiJ+s2ayesJdZd/hBhOCoOgTWhjfH
	 ciTGnyHxIKSiOVPvnQxF9mFNVGoEVgfVHCR7lGdxUyM5KdYzbOH/9Soy6UG8oCcQNR
	 fB8Vq6Qh+Tmq+07GIo50qPa/C7KJNyue6VRrpbK6bLnaLlZ43tqFC32Hr3NleWPlYI
	 kx6Sc33lSveWs/F9T9bX6lS51opQDlLPDx+XegSyV1KruH/wn+np34iIgJ3ZIfcaCb
	 efYhqPYcMH+Z2KRxR/1wl/NWAMI6cuesMc6qZTL4B/Hnn/u5i/ODRmu6eWTtNsUu/t
	 F16IQNj00dLO/4G+MdBSZ/Ts=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3030:a60:70e0:1176:9e41:51e0:6730])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9DA1C40E00DD;
	Thu, 24 Jul 2025 04:26:03 +0000 (UTC)
Date: Thu, 24 Jul 2025 07:25:58 +0300
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
CC: linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Arcari <darcari@redhat.com>
Subject: Re: [PATCH v2] x86/CPU/AMD: Ignore invalid reset reason value
User-Agent: K-9 Mail for Android
In-Reply-To: <20250723200752.2851345-1-yazen.ghannam@amd.com>
References: <20250723200752.2851345-1-yazen.ghannam@amd.com>
Message-ID: <61E4BD23-24B4-42E0-834F-1E1E416EFA34@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 23, 2025 11:07:52 PM GMT+03:00, Yazen Ghannam <yazen=2Eghannam@amd=
=2Ecom> wrote:
>The reset reason value may be "all bits set", e=2Eg=2E 0xFFFFFFFF=2E This=
 is a
>commonly used error response from hardware=2E This may occur due to a rea=
l
>hardware issue or when running in a VM=2E
>
>The user will see all reset reasons reported in this case=2E
>
>Return early if running in a VM as this register is not emulated=2E
>
>Check for an error response value and return early to avoid decoding
>invalid data=2E
>
>Also, adjust the data variable type to match the hardware register size=
=2E
>
>Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
>Reported-by: Libing He <libhe@redhat=2Ecom>
>Signed-off-by: Yazen Ghannam <yazen=2Eghannam@amd=2Ecom>
>Reviewed-by: Mario Limonciello <mario=2Elimonciello@amd=2Ecom>
>Cc: David Arcari <darcari@redhat=2Ecom>
>Cc: stable@vger=2Ekernel=2Eorg
>---
>Link:
>https://lore=2Ekernel=2Eorg/r/20250721181155=2E3536023-1-yazen=2Eghannam@=
amd=2Ecom
>
>v1->v2:
>* Include Reviewed-by tag from Mario=2E
>* Include hypervisor check suggested by Boris=2E
>
> arch/x86/kernel/cpu/amd=2Ec | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/kernel/cpu/amd=2Ec b/arch/x86/kernel/cpu/amd=2Ec
>index 50f88fe51816=2E=2E7a10fe426104 100644
>--- a/arch/x86/kernel/cpu/amd=2Ec
>+++ b/arch/x86/kernel/cpu/amd=2Ec
>@@ -1274,10 +1274,13 @@ static const char * const s5_reset_reason_txt[] =
=3D {
>=20
> static __init int print_s5_reset_status_mmio(void)
> {
>-	unsigned long value;
> 	void __iomem *addr;
>+	u32 value;
> 	int i;
>=20
>+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
>+		return 0;
>+
> 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> 		return 0;
>=20
>@@ -1288,12 +1291,16 @@ static __init int print_s5_reset_status_mmio(void=
)
> 	value =3D ioread32(addr);
> 	iounmap(addr);
>=20
>+	/* Value with "all bits set" is an error response and should be ignored=
=2E */
>+	if (value =3D=3D U32_MAX)
>+		return 0;
>+
> 	for (i =3D 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
> 		if (!(value & BIT(i)))
> 			continue;
>=20
> 		if (s5_reset_reason_txt[i]) {
>-			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
>+			pr_info("x86/amd: Previous system reset reason [0x%08x]: %s\n",
> 				value, s5_reset_reason_txt[i]);
> 		}
> 	}
>
>base-commit: 65f55a30176662ee37fe18b47430ee30b57bfc98

Ack=2E
--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

