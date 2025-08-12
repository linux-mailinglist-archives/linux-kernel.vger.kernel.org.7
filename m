Return-Path: <linux-kernel+bounces-764560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A24BEB22482
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB83B16ED1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F72EB5C7;
	Tue, 12 Aug 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XrVc2w+J"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824762EB5B9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994245; cv=none; b=SiQbO+lO4fvWrll22w8CEwZUk175FIeKUNbdaABMFui/xmWHtdhevB2a9yJTQ0itJmWg68eG5aU0PJc6X89aaId8w3ngI0YEqJr0xf9dQ5PjS/H6Nq0lYOpRTGDhGmSu3GuQcidv56tY4cPjePVUEDkwz8uFR86HTgD8xYaicNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994245; c=relaxed/simple;
	bh=zSJ40RXAmKTcI19Q94kFvJsysoSHEY17Q9sK1BZeuVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evTC8rLhDCs6gw2Xb/fipLuZU7oY6CM/AmW3Xj8hpj994FaQ+lQAZaABG2EG2u/sq06pefHhJSOY6xBYIm24kLkAn9ME7Rye5+2J29w1BB30JXR15+nruEFzpNorF4VMOJ+CQW6WpMvod9sIr9HwZxBNraRJg8oh97UjN6Ea3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XrVc2w+J; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 65DD740E0265;
	Tue, 12 Aug 2025 10:24:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LBUXfSnqUInG; Tue, 12 Aug 2025 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754994236; bh=KzavHqS3KXQ+1IMv9YmxUoM0tMLWRITTHBxtcukD+QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XrVc2w+JMCmOOiT2gCYT4exUoXOMlsUTXCC35z+Z4bACA5deDNi6VeoYKmQGKtQSy
	 6hthA0Y7eSdGK8H9lE3RFv8PrU5ARqvls+VzxR36o1XA+LIU87WSFT8bURIh5jw6WI
	 QDhoZ2/OiIthuPbYQRrsA3nZwDvV465k4jIpfedIYvZoeeVzQ96l6CGKSA0/ujrcj/
	 9fRHPfoOEzqOvUb7w9b0wNxjjnkzjsQH+snZCaBnNZXyXonF1mSoLao1Lw+KyR0vyw
	 qgygd1zcff4OJbdAa4LiLARXPGDOUSQNEa3nTznTKmgmEFPYcZzecUw4QaM/8dLr2Q
	 a9UEndL9fNrxXlKCh/U4NhisdSmBG2DR5bAGo5cnDiPG2Vc2N8qN2pGVGbSlue6BdW
	 422gOo2pH9o0kCM+eohz54Lb1iHXyH3j1ii0ska+RRUfUcT/VQE2EySuI9jcNrtqKl
	 ieMON3HxjnxV50MjNl935CMckr8qz11diEOnYzNhdZ64dF99fNrjeuTtn6g/xuq1ZJ
	 ZcPY0RZZCtTIjKwzXCHCbWrnOLHE/nAJ6ZOq0F0Cjjyj8faE5bs0oDKX8L65vQSjuZ
	 eSnzdakCDVTN12fMoi+uNJxoX/M8NgkYrFpHWtlak0R3zf8iVH65RjylHClTgHSrKC
	 3fA6+lNe+I2YEP1qgTDN1D4E=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA9F640E022E;
	Tue, 12 Aug 2025 10:23:52 +0000 (UTC)
Date: Tue, 12 Aug 2025 12:23:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/microcode: Add microcode= cmdline parsing
Message-ID: <20250812102345.GAaJsWMTNvC2ULKtep@fat_crate.local>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-2-bp@kernel.org>
 <f641cc0f-e542-45ef-bdb9-d8364860688e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f641cc0f-e542-45ef-bdb9-d8364860688e@intel.com>

On Mon, Aug 11, 2025 at 07:26:59PM -0700, Sohil Mehta wrote:
> How about adding something like this to encourage using the new options:
> 
> 
> @@ -1211,7 +1211,7 @@
> 
> -       dis_ucode_ldr   [X86] Disable the microcode loader.
> +       dis_ucode_ldr   [X86] Same as microcode=disable_loader.
> 
> 
> @@ -3770,6 +3770,9 @@
> 
> +                       disable_loader
> +                               Disable the microcode loader.

Because adding a new alias of a cmdline parameter doesn't belong in the same
patch.

And if anything, that thing should be

	microcode=off

to save me some silly typing.

> Unnecessary whitespace added before tab.

Pff.

> Setting this to "false" is redundant.

Fixed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

