Return-Path: <linux-kernel+bounces-749531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF4B14F84
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8851F188CE32
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB301EB5CE;
	Tue, 29 Jul 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jIIyl9Az"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D61A5BAF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800565; cv=none; b=BreTd/hGWmx26OoXLSEoZdENXbYGyeCyo8+9JhHct8IWU9VYod0YfY3hdTo6Jt1z1bHHZQ+JHcWzY8U7aOw5PgPfX1ujOQw75Qp8l0zgmTnnbvZCPdLkeF5c58VKf914NTJEzD/YcLw/QHLiZWDCkkxiqyRnkqCZLOMerlZUpx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800565; c=relaxed/simple;
	bh=uXq9b6ottk2mN+gbe8SQc7kx+BSCtIwZtExhs6VQBII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oijFJxkTEqG+omid/AFib0Gp/ZvrzYs3m4GsoKohhi7FehClmJwJ/R3EKCajDDatGm+vUV2e6xZJQsYVOlxqsZtbgT6P6v9chspjooyak0aBZUr4w3PnfA7TD0qOv8nq7lkZVJWZUEyvSxb/Zcr9NQ/9KaeN/lxKwL+fnCTtDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jIIyl9Az; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CBE7B40E0254;
	Tue, 29 Jul 2025 14:49:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xU7if7vNggZh; Tue, 29 Jul 2025 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753800556; bh=ozS6w32Wt12YeytFxNdQHTqW302/+NkU74tv2zhd/Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIIyl9Az2vfVGrKQbHobV4DhiVcSBqTjGSm/adv1JcXjfzow0soRWqmY7VoQidhKK
	 N8xk8+Zm6hp2N3P1ShRgp7DGwEabOvdO1vMWQcFlAUk5sqKwMGdok3h0Cp6Du+QSQy
	 1jt+BYYZYLcRbAwHt8FtpERLrvMyV2zWMRgri0iRBAM5qkKOknTY3yflfWabl1R/fN
	 FVDNV7BDMa2vicwrEKMELQ3D27dA/lvamwUBN4tXCBl6AO6RRwbhuKJJVk/tALuUEK
	 KbRqEdE8jP96y9pTTchLStpMHqygPpbstBClKn2nST4Gzqo9TwT+eeH/JP0aTXq5wB
	 zjsVDf0tA+WL40ZN65x21YpjnTmwcB9iFlTYufD+WPHMRwvroPSa1D53d9rjCIltNW
	 hrqAgkYd8Ol/XJ0G5enbzPf8hc8jkK9PH25K19fJBp7iCR93sTcq0roFpchLHynpoQ
	 mbPPWQBiY48IFp01fI2f8QenMVwU3/s39dvP4pLhlgoHXEqg6G7ZmmFWT4fqsT53ck
	 NK02fVWe0rt5CksrxhlO4daKLizI8jQiSCZj3KZ2CTo6tQH++zy5Ojt/vZTnOZdHVe
	 wg281KxW0/AMJlxDBoj9zz3W8Idw6TRCVbx+EEnvWrRiSMz1TDskO9sgQ9uz59hSqU
	 aHf1DyWozmT6D+IbMaV9Yjg4=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC63040E01FD;
	Tue, 29 Jul 2025 14:49:05 +0000 (UTC)
Date: Tue, 29 Jul 2025 16:48:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>,
	Ard Biesheuvel <ardb@kernel.org>, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] upstream build error (23)
Message-ID: <20250729144859.GCaIjfWz_D0VK-FKnq@fat_crate.local>
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
 <20250729142512.GBaIjZyNHliBrvMFlo@fat_crate.local>
 <CANp29Y4cTQD0EB6pTHgbbrja8ExxZuoz+RRLDY1ua+FQ=EjJ9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANp29Y4cTQD0EB6pTHgbbrja8ExxZuoz+RRLDY1ua+FQ=EjJ9w@mail.gmail.com>

On Tue, Jul 29, 2025 at 04:32:39PM +0200, Aleksandr Nogikh wrote:
> It's not a random config - syzbot uses a set of fixed kernel configs
> (most without CONFIG_EFI, as in this report) which used to work well
> before today.

Can you bisect perhaps?

I'm assuming 6.16 is fine with that .config and if so, that has likely been
introduced by some of the latest merges of the currently open merge window...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

