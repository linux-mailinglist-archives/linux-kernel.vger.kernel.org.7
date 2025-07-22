Return-Path: <linux-kernel+bounces-741268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CCB0E233
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09911AA6624
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515CB2576;
	Tue, 22 Jul 2025 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VQyRFRxs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57938FA3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203282; cv=none; b=DDJBsJ4JUUti/v5Tp29qnMIyVoTlvUMZ+V479tGkDYnEWWujxgTfStMZjEA6WAcKYbqQTFX++78R7f5F7EzFH/H32gH/ytWSjtLkJnOfUKi4uXw2x9kwA92ECzwZO+MpCI1CfBmAg1jxe4FLr+FX7df1J8CP2GJbK2c5tNJsXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203282; c=relaxed/simple;
	bh=itcsi6QdvYC4x1Zuyn5rV0sYkyzwfF3Nw0yXVqzSDgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I02jKmSwXDI/beJtSGeH9/j/37yHStarM66m6hXrfRewIV7MRi4SITF48+eqo4ssBpG/0SfpMi2HyQxVFKA4OgmPteoYvQq1yIpDXA5GPWX/FFBYqDx9NT/2QsYkiiZRfizdrTN83VX3Kdb7W/m2+MAWg7Tlsgu1kP060iw4sec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VQyRFRxs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E509340E0265;
	Tue, 22 Jul 2025 16:54:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qgIo8_eghGXe; Tue, 22 Jul 2025 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753203275; bh=HHakQphditb2T8P3R9avOkOYp3iZuMjJIA1rYIORmnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQyRFRxso0EYpVr7BmljR9jxKU8QaPfJ5N6NdNgwI9mwAyJxvZgabud52kfoTgY0X
	 LrNvtXJbbSvtkBvGSYcPxwqoERPPnvyZJtY0y6m+lxEhQYaiqV1SwpZQpwUQ1FIWHe
	 YpmRwCKZARm4/006Qe3GXCysAl5GrRz4YmolCjaEFoVtTtUikdpEbvKOuMo989R9dD
	 8gFUx13Ho0EFLKdEC+KtB6KFUjsTA27QkJ0Fs/hFvpumCGVEaoge2Cj61boZ6QKNi0
	 wXuRZ5TIc2ablYPCt0hZ35Hcch9/PQUTMy0HkPXFsrHXppSqkOpsECCljrRWxKGhnW
	 7LZeCYTSrvO5FOz+rB68ckAuMT8efACoeM7TjNjlNyjx57UzU88Sk1BT2oxMZExShT
	 a6jGhYyKxdCXjN1JFAUkdwg+lTMuKSwifaSwoqqfeo55CEb+bKn665ywqxcL/Ams+/
	 +d9R1Ale5vk8yajhVl+eIwcv25hOUxEiTofP0qwgdiiJDLFdygo2/EOhJgAjC6xZN8
	 fny8u/azkbzM/qgW1zKpCzmok7pjlngR8QBIB7r/29a2t7EfBvLjwySTPsGczLT6ac
	 c7mmvpZRwTPA7exR4GW82lKjOWhKr3rey8ZKFmsIUb+OZ8GAilVHDmOCv+u+xLDCno
	 vwquiv3yDTUCI6cBVLXcc/V0=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0ACE040E026A;
	Tue, 22 Jul 2025 16:54:14 +0000 (UTC)
Date: Tue, 22 Jul 2025 18:56:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Libing He <libhe@redhat.com>, David Arcari <darcari@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
Message-ID: <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721181155.3536023-1-yazen.ghannam@amd.com>

On Mon, Jul 21, 2025 at 06:11:54PM +0000, Yazen Ghannam wrote:
> The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
> commonly used error response from hardware. This may occur due to a real
> hardware issue or when running in a VM.

Well, which is it Libing is reporting? VM or a real hw issue?

If it is a VM, is that -1 the only thing a VMM returns when reading that
MMIO address or can it be anything?

If latter, you need to check X86_FEATURE_HYPERVISOR.

Same for a real hw issue.

IOW, is -1 the *only* invalid data we can read here or are we playing
whack-a-mole with it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

