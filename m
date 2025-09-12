Return-Path: <linux-kernel+bounces-814740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3450DB557FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C417C66E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24828466A;
	Fri, 12 Sep 2025 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kiNWHG1G"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A69223316
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710944; cv=none; b=Apulsynojm82W/+3YU1XFF8N8cp3mtWnGfA9Q5sJ+YnbS4e0gdIICwLhM0ErVLDXiGvgHyLQ4INf9L2r/Ec80Qby5g7X7RwIkQc81XJyQLrueGyazd7bXgaiP8wq4M+edrIuQ1H57hj/xIxyXi7mr+Dbd9cvHZJWA7FwKx97KSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710944; c=relaxed/simple;
	bh=GMz9+xllyST7cIhbITQMk9tKHdJ0slp/rL9hgA4+46I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1PTr/TYgYsi5xUJlpxxK8cwp1qiOLqwimAoTlKX3+PFyZOASo75HGxxt8JXyoZ5jhXawV8H4IrRGFcOOBc2g5fWpuPX4F/Ll7Nh3xG2p5nze9NSm1GxUe2pXS++JfLeCudhGlwvurT0UVLMz12oL8I2rhuSihV7DgrkOzyyzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kiNWHG1G; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 561CA40E015C;
	Fri, 12 Sep 2025 21:02:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qM5yvJScYERo; Fri, 12 Sep 2025 21:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757710937; bh=tjDwjUF6W4gKnSGSAp/M3RRbEWfvCsNGQIiPadPWm40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiNWHG1GU0FG0FrmpVczlfeQlISJm0JfA7jXOiaJcL/Esl5w9Ium5WwnoN1MOJ98/
	 3/Go0CygRpNOaTw8VdRaUvsOn4kaCZ7Okk6C51G2yYkkGwovUZoqtuPPD0XdzEnV2f
	 CQbz7ig0MNwA1fRME3Xv9swTg6GUx8ZWMvGIXAYzQbE8R43kXnDhaUEL0Dl0TwiNWJ
	 pj0r6k+fNDwi3yVC7c3MOHPgMJW2gYREB6o2Q17fDVOTZA5/NLWxeYNac11+R4Cu2W
	 GXT8iMqCDFVX3jqgxI+myNK9nqXQVE5eclvqXjYRNmdzuhqttLWvtM6wpHwqBYLvIw
	 I5ga8j+xVCHtccniNV+15TcvddU/d7n0LYDHPw4sINLKq+lephCOc3hhb0quikVR/d
	 57MJBuT8WBrivd8dKccNdrDo5jrnZohErrnKJgakiBBcIR2kvyLERBEt9By+kt4vnA
	 d8mfac7QznpzF5514EIWgRHoGfv4oDB1B010f8eFxkRYvfq3KkUdPfdrQsxCcH+VWd
	 kTluTPkqWpRwXFnEPiEY1L31v0aDTo/xYSVFwfAAqoKS9b300OGv9ieJwb7NgoMBRu
	 RJw+PgBkw8NPbP7N0YltTmcpbz3Ak7aLuUQHvC2/8MNFTglezLT8h1Po+T+smJBa7I
	 8+8QSMU7NYCnWQFx5aOTs8SM=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id F027140E0140;
	Fri, 12 Sep 2025 21:02:07 +0000 (UTC)
Date: Fri, 12 Sep 2025 23:02:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, stable@kernel.org
Subject: Re: [PATCH] x86/sev: Guard sev_evict_cache() with
 CONFIG_AMD_MEM_ENCRYPT
Message-ID: <20250912210201.GFaMSKSSvK55XIwR3e@fat_crate.local>
References: <70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com>
 <20250912204203.GEaMSFm2-N6lPteue5@fat_crate.local>
 <20250912204929.pls6245t746gtalr@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250912204929.pls6245t746gtalr@amd.com>

On Fri, Sep 12, 2025 at 03:49:29PM -0500, Michael Roth wrote:
> I think that's actually the concerning thing. If someone built a guest
> kernel with CONFIG_KVM_AMD_SEV=y they might be under the impression that
> this is performing evictions when it's actually just a stub function.

That sooo needs to be in the commit message...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

