Return-Path: <linux-kernel+bounces-865759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF89BFDEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B623918C8A11
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C411634EF0D;
	Wed, 22 Oct 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WNMF5g3C"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7652EFD9E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158929; cv=none; b=mEo4mxeil4PhhuuMjLmoQShlYAD7XC0TtP7n9B2R9Qw77Aeex4Nda85dMa2zITS98FGqc6xiQf5qnZymaqeM6kfZ7gWJUN96XEWd9gUq4/cXDtDXWMT7y0hrx6wDT+PO6YGutz7NtMt8Kk3qe+mmHKnZ8DF9QGIjAjtawcXlR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158929; c=relaxed/simple;
	bh=FHUACAaiX1jjv8OK9USVBfc8Jm6dpMN4yK1um3hueKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doOdCL3WBF2woVQDwrJFfcDFud4YlE2txvxNgJ/W0LOaFlki4yb68VZJY53OyCPkkb2VsIcYlcYAXk/X8bCe8mPQ0VK+bJNM9VE5+2uNx4af1ArFitLoxGye5DAzYU+a7/NEEqZrYJHlCUBoQVSp6/yS0f8uzSIXst8rNictND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WNMF5g3C; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 49EA140E0200;
	Wed, 22 Oct 2025 18:48:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RCuBXRfORJXG; Wed, 22 Oct 2025 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761158910; bh=ISfiyR7G3qnf4fKwczk1IN85ZQ5wZAMfiSbg8Us0Jn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNMF5g3CMV6tFD3VWx9qgMBx7Mdw09drLkSTLzkIVrFLIclAf1TFDpFG4WMKUsn8g
	 N0zgWRBerzgcNxmTDaNfTfXIAwmMXOgMVulEGIJLzHiAb9W/cZbqvll8foic4N0rd0
	 +W7XlBAInh5ip0dx61JF7TZj3nRA+U1Sj8ZzS04pYprp8lgIy24xNFLnQTHpAvwZin
	 swiuQPDiMeE6B21fu7CWV1GqBiYldWJwjNRby5vTxZoZw3zcJAVMhfxlSLOpFqkMd7
	 iQ6FIUFiH7hQPHn7yhMYt/0juKUHM8z6jzP0NdKXg+Qub6Fv4LPoLMFq57M8OmzHH1
	 sbgs172LtVyJ1X8lNpnWDfExz9rcxjVXbEgDXnfsGPUKRAu4z7Y+Ch3JJDt1hLBe3b
	 pikX6BDvjQWCWkhvGr29AEVZOycLnfh0haPj5JYkAp9cB7JJ31Tjpx4Q33dUXvn+kY
	 vpbUR+/S8UT1BLwt3PBjAEGoMSFE01LZqKMvCQInX+sMRqxu3wJ/z9hIFYRVWSdCNX
	 oLwL2n7o0cz9GRcfBwTcs8TgLYLqPRDQrOBi546vQX+sQcLciPbr6fJ2WGhWQ0MOf9
	 sQYnK21c+Mx9ld+7PliBH9o1Uufkgl2DJ3avrvIxKHqnX+Rboghogig5NcqXJb+F8s
	 BVLa0mZ0ooRwb0pZkANOFoE8=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0FC2C40E016E;
	Wed, 22 Oct 2025 18:48:25 +0000 (UTC)
Date: Wed, 22 Oct 2025 20:48:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Filip Barczyk <filip.barczyk@pico.net>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Message-ID: <20251022184816.GPaPkm8CpZZrMuxmbp@fat_crate.local>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
 <20251022111342.GNaPi8ZqATfwpja2GR@fat_crate.local>
 <20251022131904.GA7243@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022131904.GA7243@yaz-khff2.amd.com>

On Wed, Oct 22, 2025 at 09:19:04AM -0400, Yazen Ghannam wrote:
> I don't follow. Do you mean to combine the other loops into this one? Or
> that this loop should be expanded into three loops explicitly doing one
> thing each?

See if you can do everything in one loop. I.e., limit the amount of looping to
the least possible.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

