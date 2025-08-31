Return-Path: <linux-kernel+bounces-793388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9CAB3D2C6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089CE17942A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3E2561B6;
	Sun, 31 Aug 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DvKLYnfc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781461FFE
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756642931; cv=none; b=XNUsI741MX7e7ZD9q3szIyMw5pifvpPJCDohBK04ISv2cl4w1RWDOzKv5BHc3YduPC2/ZJMsjjkRSXS81691crs8WGNultJqSBzzwrJ22yFzuF1QpJCYwHtYNdE5KC0cVG4LyJqJZ4sfEOEnUpqKEO3wvc3Js8i/gdZAz9eZe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756642931; c=relaxed/simple;
	bh=dGdbkyakvcLPgUrrpzrlZqt2mia0fWSTKTpiRvkR64I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSP7yYVf/qr/ko2PGl7vTYeB1Sl6MqoErI5t5HyzGlEQ1ShEXc6GcRJ///5OivcAEO8C82j99/0Qe9qJkTPiyZXoCRIcrJk32Y0ZB9AuLMLuG+ldmWSL0aEEgf9TJguC+S2zvdgQm0x7PHBXK3Ol79hTP7ib3ol9adzh1oQHYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DvKLYnfc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4D2C940E019D;
	Sun, 31 Aug 2025 12:22:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t5bGD-yK8Lqd; Sun, 31 Aug 2025 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756642922; bh=PfoPD0AvjYmdQ78gS2NPWjiixVYDFyWshrc+IHdqrmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvKLYnfcDepThDOYKYeuWQhUn5c9pP4/Ip9N8gH1iZRBVKvarOv0EioRRcK+l8acX
	 CPaLbNiXTtQcMxDC7lhURMEKq/cUgNVVg31hLcxwGSlI9ybsXNlvDO9vQmzmgHQNpm
	 FPH37uW55FRfIlHdoBF9zQTkw1su3Up3Zs/V2+DEdiCYGULq61AgAfxRcJ9yilP+yJ
	 Ci7UHtH9XWfjZGUmOve7yafU/UmtMCYYR0iZbF35w9n6qfMFIiA5OWvtmQDkLfqzAG
	 oUF/RfLGLwLf99NG8L3WtcQGAeVbtAAoLrHj96g49Ho6q6LfROsGWLfdMkH5DVK6KE
	 Sbnh84dLc7l2qscj1hHLgid8VKoI1GnM77UyMb1Mp27+Xjkpbmj6eYeEr/imQ/VufH
	 /14gEl48Vm855eapLRFSKjG3OtzudL9TK62w/yCkeJOtJFXCE5j0sRPSnnfbxswUg1
	 uIoAhz1SSreIRlnOgZKo5v1VyhBT4+7MZ/eBejVc4r5BZ50ThPXv9w+VS1dbbFpxjY
	 YlRp7CLaqryontBDHQf1COEkfsndRxkRdxqiTdKxbjs1EQxOqHAqiSWDoh1WWFgQcD
	 Kjt8RPBD6SL+s/QNJXi/m6ymmUGWJPHGCCNB1cpmywbgFCB95LgO6LD893hPK0L+OA
	 P4PmrlOkK4rCgZE8Nzi5xQCk=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5A2E740E0174;
	Sun, 31 Aug 2025 12:21:54 +0000 (UTC)
Date: Sun, 31 Aug 2025 14:21:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Initialize mm_struct::futex_ref on mm_init()
Message-ID: <20250831122145.GBaLQ-WUUgrhyFCwxN@fat_crate.local>
References: <20250830213806.sEKuuGSm@linutronix.de>
 <20250830222545.GAaLN6aeQzWHYc20BF@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250830222545.GAaLN6aeQzWHYc20BF@fat_crate.local>

On Sun, Aug 31, 2025 at 12:25:45AM +0200, Borislav Petkov wrote:
> And then leave it in that branch for one more week for some more testing...

Ok, boots on one of my machines, fix folded in and force-pushed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

