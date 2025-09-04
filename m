Return-Path: <linux-kernel+bounces-800722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6F2B43B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6765173E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82F2C0280;
	Thu,  4 Sep 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="holA9B0E"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500627A469
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987715; cv=none; b=RV5zQ/eXAiTzTGzrAhiIpiW9WpsgkV/s+vUikASkXq3Gi7TBSkD8bMH/d9V7IhoiAipAw9KVNt8PQb8D78h5q1JgB2qluhWycF3U1qpsUJZmWJhQKGNT55NYYMS5WnHjsl2eN/PbMeXbqUIgdewy7zJD5JoqBcdgRjH/I52V9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987715; c=relaxed/simple;
	bh=mvaLXgsGBNDd97YgJRteylnH74QLc2fIyUCy3v+Zkwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WowMQd8kaAXwzcHmfCMPjbZqjRZqyxTQYV37umpQXf5VWaNViHxsSY1Z/zwyWMSeLNlwcO/FxlYOmwSP0hpnYomLQEA5ZkmkHT+dSXsmnWjico7dSgYWXgD9hdw4PTx3ZaF5DfY4fXdlqYg8kEDIIuNkCHJJRD9KgvUPIyLukYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=holA9B0E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D06F640E0174;
	Thu,  4 Sep 2025 12:08:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2zLJfMy92YX6; Thu,  4 Sep 2025 12:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756987705; bh=Joi63SZUhDyXdjs3QNq/K2PEcgPN2J4HEknQME9r+OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=holA9B0EfQRlzwtWfr0S5mGfmrzxoIlQ+06iMCkkrUO4204TFaZtaXVbNpS/OSEld
	 XEMYqGSYng8PSNnKY8mFnCiu7Edpv6U/hF3jckK8Sea/cxv1npfr4Cn19UIHcKpEH9
	 RvXeTYrOpWsHL2ozlHu2yvLCMQGKc+mUcEfiZObalsLCuJ0IhS7ukndHWvPDcMSL2T
	 0cQBJEXQb+AQLxRent/NUBCbDW1kTzrjbkjDRgaVQPQPVg3vYYGtxvZ17LWE0C7za/
	 PYtrwspasBkaYWaXXdk4nMhenG74RVwIhgXdxuSDC2RkS7EFvVfOMIHiexW/UEiHhK
	 UE1OjPaf91TfOV80+yECPpDcrKPgxOgG0P3CsoRTV6j7sEYEwSY1oBzbQFy2Cmf31N
	 28fMltqAb8cny8jxjiFugRhrlOIRBr18+3FPv1CKpZaTPg38fneTKznzBTOPuwSt7G
	 Tts89RvgwaHBFAjis1Sh9285vXBnDqBvhvDjKt8ZwwcrwINMGjJ3bnOUu6MHnFqiq0
	 valKj4fvgqLahin51Zi3zrkxTTNcCHJsEEQqnp7IA2K2/m6385y6D3fznYma9YxPCu
	 FxWcoPxBjUfLEvr8bxdIfsBRIwtfa3L7LNG35mEvqgg/4FidV7GPrYAIhrvNc72aNS
	 Va3YZRI20fnuSauQQxvpP2zM=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 634F440E00DA;
	Thu,  4 Sep 2025 12:08:17 +0000 (UTC)
Date: Thu, 4 Sep 2025 14:08:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, chao.gao@intel.com,
	abusse@amazon.de
Subject: Re: [PATCH v5 2/7] x86/microcode: Introduce staging step to reduce
 late-loading time
Message-ID: <20250904120810.GJaLmBKtFBh8wke2Bo@fat_crate.local>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-3-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250823155214.17465-3-chang.seok.bae@intel.com>

On Sat, Aug 23, 2025 at 08:52:05AM -0700, Chang S. Bae wrote:
> As microcode patch sizes continue to grow, late-loading latency spikes
> can lead to timeouts and disruptions in running workloads. This trend of
> increasing patch sizes is expected to continue, so a foundational
> solution is needed to address the issue.
> 
> To mitigate the problem, a new staging feature is introduced. This option
> processes most of the microcode update (excluding activation) on a
> non-critical path, allowing CPUs to remain operational during the
> majority of the update. By offloading work from the critical path,
> staging can significantly reduces latency spikes.

"reduce"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

