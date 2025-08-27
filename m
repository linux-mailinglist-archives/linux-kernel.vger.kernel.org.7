Return-Path: <linux-kernel+bounces-788635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B48B387A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455A4200067
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EE5221FC6;
	Wed, 27 Aug 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kRQ4X/VM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6A2116E9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311581; cv=none; b=qaRv97Lfci/A4jEVMWWxh0/GKc4hTLEtFt6sT45CXqEnOiVcZDD6YgN2gZDKEOxtwywKUyGsfXN6kIOo0h7/q9v2tYMyBAYjSMykJnBh+vHgvY9aHx68gh2RA9B/UREyaeNQUBfYugpUX1sshLKwKggeVXN7kDGgmac8EzeFnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311581; c=relaxed/simple;
	bh=3s8bXXoivjIzQPKuvc7/X3X+0XhuF3Ct3mOZI7JDsMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us4bmOyexWYGBAK2uDt3goDzWWlBUDAeTQdy8wjwJTCb0iBVkbsilcGWH/wWy20M8Dp7ioJa94JeLW0iL+CtKOTC3vtspfrXHzJqUh/gJxYvf4lX+vaH2nrQEgcpmRo8kmdXyIEEWtWN2ixEr+ZuEWzYnrbvPnNSZ4PG/pocaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kRQ4X/VM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 260C440E015D;
	Wed, 27 Aug 2025 16:19:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MzNTIKyuC-QO; Wed, 27 Aug 2025 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756311573; bh=0mTubuDuBOdzn3vuvCYOukqWpIN+hiaMClsl75yAPoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRQ4X/VMJskIPT2KlgQTYpdZPqJEwRDGdWIIkcKWbWUh7NfTGjoyXAh876bGCtKmy
	 lLTO2ifQ+XURQ0i0BUav6Etkr2qdn3xij5x4OjfcnlcYTdh134qB2OGzEr/d79KFRF
	 9Rok8SN2jkUCgEb00yUYIVz1scBSBs6BCB3Nvm3dHHfhQOivNMrOh3rhTWBBTyrGUZ
	 Vrp4L61VqC+cM+gsmxZ7td5YjTqNAYiE/0T4HMllT0cUFL9uwKHV/UOyzHMZnRep6E
	 Nelroo5FctYoZokbIq7jMZNK+ShYl49XuNovSEBtG8/1U7P7Eqw1LfdleoEUB4bWxD
	 uziACtwzDEHLm2HL4vlkBOlkWg7jTBFRlawuCZsZrrsXp9YmDfkfC5iiDOKYy2xTpY
	 t66siDQ84kQxjznjaLS5Cbfi4sMOmsuLMZ/V5kgdfutKsxx66kR2f730OO+mbiTB+I
	 GMTjRnWAQVGSAhjruXicp9tCJ+YENMPYQNICeIamyGi5TN+CsLnRLFTcfvP4rcsWSk
	 lb7Adp3blycVezm9a1RHsM8KNMS9ROCI9L7FzmvX42n+ieiXVadBgpO3vh4nVzebb8
	 u8fJx5YzI4OjG9SF9rh466zbEa5KAK5+lApQvrNFtfS2JerwamVqGzU0jAjmEOe76R
	 gaJ66XluCC21eGY7IKEJkQTE=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABE6D40E00DD;
	Wed, 27 Aug 2025 16:19:23 +0000 (UTC)
Date: Wed, 27 Aug 2025 18:19:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Message-ID: <20250827161922.GMaK8wCgjLqqVvHqSw@fat_crate.local>
References: <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
 <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>
 <20250827110403.GFaK7mIxwsQ9IF7ML8@fat_crate.local>
 <LV3PR12MB92655023C50A92BE30D7A8049438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827142225.GIaK8UoYo-rnR9T2OD@fat_crate.local>
 <LV3PR12MB9265934929BC29E635C39EDD9438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827153358.GJaK8lZm3cggYDbw2C@fat_crate.local>
 <LV3PR12MB9265ABD1B81D759A618A20029438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827161159.GKaK8uTy8aW6Xl7UCr@fat_crate.local>
 <LV3PR12MB926507DF8A992FA953F22E099438A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB926507DF8A992FA953F22E099438A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Aug 27, 2025 at 04:15:18PM +0000, Kaplan, David wrote:
> LGTM.  Just make sure to update the commit description since it no longer is
> adding an AUTO mitigation.

I have this now:

"Attack vector controls for SSB were missed in the initial attack vector series.
The default mitigation for SSB requires user-space opt-in so it is only
relevant for user->user attacks.  Check with attack vector controls when
the command is auto - i.e., no explicit user selection has been done."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

