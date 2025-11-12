Return-Path: <linux-kernel+bounces-897819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD0C53C31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D0B2544046
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F43446AA;
	Wed, 12 Nov 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="M+EjCIk8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EAB3446A2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968095; cv=none; b=nMKkVdhc7r8PRYeWQZcPYjmnT3ixGHD7GbvtH5buUxsksXMfRLzEq6CJROCZ90es2bqLMLTP8dOG9GeNxKwArbsxZKDT0Hpj6bEr/BtjNs6aS+0RYXkMn77ExPVE4BgYEMkkNsTWk17BtF67G6wb9nudzVVh6sXlW4vuHf9LGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968095; c=relaxed/simple;
	bh=0PPqTUWpeQYo+DLwooIV0l43RIAbTn4FYl99vVTYWgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR2INrqOxmSbE2zNG/ShPSAL1SeGc/Tl+xMU9rT1rN5DHwwmznFfBnekWCys/JEEzNjKC6PgHdb0Xtfn4cGFUGgBFXdJpehrfmrFruaxaXUB11EsEThPBcu6LVkUP8Gaa35sH2n0bYIBMT+FIy7AdaRhs7gihKg0dZnTxAMgDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=M+EjCIk8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E6B0940E0191;
	Wed, 12 Nov 2025 17:21:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LY-csmP1W9MH; Wed, 12 Nov 2025 17:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762968086; bh=+X1dgcso8muvjHmSC3HEKtHeLBiJaK6T2iMBss0NMsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+EjCIk8AHOoDeY3+mL6+3eQ6/ER9ZFvVg2/xakqzlyy5zNjQDDNK1GVhn6X4DeQF
	 pA0eL9TZmEPydj4eDxZlcNjVgBo7OWO80m1GlD55XJcnQZu9My0EZyYjNBmkbITVVy
	 qgyVhIWopR4YRRxJtAEsZGFEMplUWjRSKwNX4npQTIdPxzWvl/cYiB/GB4RGUcOYdN
	 KNPjNZBd6x0u6uAFVWTmRCwuJkwZ31CrJS7cvUJHrnLU8HG89ajq2/cFIh3NBM8MFH
	 WSTisBTYRvxqPcw/PuPhjixcr7/AxCpc9sK04/qlPGEyEVMrPw2Z/XO2K96fsT47On
	 Ra/08tBM79Iji0os65lHweK4MP/9Q3qQvORcCHLuOhLYrVG8GaPxgU5qpj5giP58IZ
	 4owFU+hj7LiwFl9n/c0oaHjbtxxhB4TPAeI6UloZlKejadas1teCf78yQFs4KJSFR7
	 TXgPkVMlpV+M7qrfj5c+29ylWe9IxC5Btb8b2WrF4PTUbMiW8S8/VvWXr3vo/uieQ/
	 n7IQH5IxBOin9tVxPPCJJlNkMKuqps5zEKhDpAqDFqOs6BWm/zobsTwymYo7vym+wj
	 voEKy+wf/jn2LTqzfPoP8PBI+BH7r1kU6cVhNjl/PwjbEylrXOuvzjFfI6iPf/nsjk
	 zRvdhbuvKA9h9vU8S/cTXgGA=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1574A40E01CD;
	Wed, 12 Nov 2025 17:21:20 +0000 (UTC)
Date: Wed, 12 Nov 2025 18:21:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
	Eric DeVolder <eric.devolder@oracle.com>
Subject: Re: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check
 again
Message-ID: <20251112172113.GFaRTCCfu2H6JpkZWB@fat_crate.local>
References: <20251111145357.4031846-1-yazen.ghannam@amd.com>
 <20251112135618.GCaRSSAkqagSF_gr9j@fat_crate.local>
 <c430ae05-74ca-4620-bb11-ff40d2eb62f6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c430ae05-74ca-4620-bb11-ff40d2eb62f6@amd.com>

On Wed, Nov 12, 2025 at 10:35:13AM -0600, Mario Limonciello wrote:
> What version does the MADT in QEMU report today?  Presumably not all
> virtualization solutions make this assumption about this bit.
> 
> IE rather than clump all virtualization should we just detect QEMU and <
> ACPI 6.3?

Version 3. Yah, no idea what that means.

There's some discussion here:

https://lore.kernel.org/qemu-devel/20230510174510.089ecb14@imammedo.users.ipa.redhat.com/

but I'm not fixing the kernel because qemu is doing what it desires.
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

