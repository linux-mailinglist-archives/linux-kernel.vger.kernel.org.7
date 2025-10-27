Return-Path: <linux-kernel+bounces-872058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9FDC0F2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5995F4F852F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB930BF60;
	Mon, 27 Oct 2025 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gDtp7cUZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAB2309BE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580979; cv=none; b=X7RML9We3DEaLeURU8DuIjhjC7eTGQ3M8av3Oy4ORdYqGSnfnmvSR5czY9wiwh96HlpgsVFZVrcY6endWtVS2xG+ihqnxGVHkKBLzEsHJ70qGkPrXmEEKZ9dnf8d8zX5AiBMoGi+inqJdiY3Hb3TeC2teXhFOwBXueNq0c83Gts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580979; c=relaxed/simple;
	bh=dBMfsXfdNCbje721kFB8RNurYbqw+OsNasMF0PfpxhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNCy4OOW2Lj1uzRdQhFVoc/5OHtHNJrGkgcUKqeysF1akst8YJaS/qYyra4raFFgwM3rOF5Mgl9POJIGxdj2hF5KhtQVF0i8WSGg/a8/VDu/4PK2MhK+IjVBAKF8ryrwP/6Essp31AfWHfOY4HUma1IY+Uk3WEyM3i3SBBcGizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gDtp7cUZ reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B6D8240E016D;
	Mon, 27 Oct 2025 16:02:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8YJvf6cy8cXG; Mon, 27 Oct 2025 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761580969; bh=p/+7R9CDMNO5tIzIiD9H3Zx6OyqGLVQtKWsO8cYeygU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDtp7cUZPe1ihxNyCEinAGck/pSEpx6vgV1psTDNRehDWi2eOn5F5xlnTT7j3O5a/
	 0wFcjZMcn/xg1ptNKpMEpxycQ0bYOdUL+XBa+p7LyAbL3pgZsMa9ZdBvXuOWhBBwTQ
	 HacuKmbSPOTxbQ3xey5Sdn+prOxsrTY8fJ6pAXhmrsK3pfk/PAtOMz51En+WtVYK3K
	 CocCPpBC8g7ijWlPQBtHBQk0PEdHvx38no9rdgKmey/+nEiSVgKbRvj3MInRtJV7yv
	 M4s9KPPhHmYRaZ8lglZG44PNeaAF5OjGiTW/GQOHTp/5N4a4L+G6GleyEjf1CNybXr
	 fqQ1nq3V8tXjX1ggAM5OCYODe9Y6RVrvD4DWa5NxjWIAbnZ8Dt1wgFvbWncA0YyFci
	 AR7Acg88THK7x0zcGrnft+s6DjiF/qxhGagjm28fZVfudFhz2Y+WMYuMf+xEkxbonB
	 Vnej64s+XlvE0dYr6PehWd8yMXAW3uF/xek3WdohCS9jMVJl/IA7UsWhV46aMcjHrM
	 rNeTEkNH38epmVzwHOEEAc9e1GE9h1FBJEps1jOVThvmUWpuhWtdjE6oa+TyDu4O0Z
	 +IqUbm+1mSfZwduGm4M7O5+DPvT3uvG+oWRjHMboGmr8nB7bsdCtfjZ0uwtTjr8ch3
	 ayG+IdNN9tUsKFFYNRkCOWcc=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 24C8540E021A;
	Mon, 27 Oct 2025 16:02:45 +0000 (UTC)
Date: Mon, 27 Oct 2025 17:02:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: bp@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: Limit Entrysign signature checking to
 known generations
Message-ID: <20251027160236.GCaP-XnF4EqWaI8-tZ@fat_crate.local>
References: <20251023124629.5385-1-bp@kernel.org>
 <d12bbb56-8ce4-477c-a7a6-600909374734@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d12bbb56-8ce4-477c-a7a6-600909374734@citrix.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 02:47:24PM +0000, Andrew Cooper wrote:
> That's Zen1-3.=C2=A0 It's Fam 0x1a you need to split to separate Zen5 a=
nd 6.

/facepalm.

I deserve that when I try to do gazillion things at the same time. :-(

Thanks Andy!

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

