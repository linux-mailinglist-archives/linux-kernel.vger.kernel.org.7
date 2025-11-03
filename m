Return-Path: <linux-kernel+bounces-883517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB22C2DA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE53AE240
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9C72877F2;
	Mon,  3 Nov 2025 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C/nXSjfP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470B17AE11
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194324; cv=none; b=s07SUCAAZBEsucZlAf4b9cEqMPZIWrL7OixPjvjx01zRLEIyWGgHckK7KtgxCh7xbdWtPSj33Q3r80LGUXqHO5HE62gwOEoE4KeE2Qy7zaR/sDE5U7j1Yhp91peZG2pZJg681GnLODLon5fHtcQBfR9kCYE3DpNydK/5EnAueEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194324; c=relaxed/simple;
	bh=+ZiAF22RG8SE4/22xvinAMCOZqVTMfiP+2XRMc9Ytro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+Qr3nB+CnzwtjlKoipkdDIk1gscxDhSXIao6ed2Smk9MUJFZIng50W3H2hKH9TiwdLY0E65k1Gp39uStoqo4lQQbctJwzz23D6lOvODsqFLfl/Tt+27ckO3oe5Q8OrnMaVV7SyuWq9EkNJWg7uIqFwT3s8ZYm6xQ+p/fv+aFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C/nXSjfP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9351540E01A5;
	Mon,  3 Nov 2025 18:25:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UbSHcfT87xcm; Mon,  3 Nov 2025 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762194314; bh=eJWqppVKbxIicm6T21Iau17wwrjoNq1DoEbwbkFXN5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/nXSjfP3r64/tur+d4ojv7T56X+mU8kIjC0G7QnPLQpZZjzVomh4Syca8/el1dsy
	 QdrYam1zJIKxsj0OnSZ82J7a8cQS3QX/ac3LvUpzrti1Kz1z0sCmPhjw56gOtEo28i
	 HikArqY24+THO91+NbgzSWS7OWxgtmcorsUzU3h4MZuniqavNfgot5RQgizAMprp9D
	 WA4Mx//neAnyJNl52dN4CaMjDBOmZR4hPwXkvkZBWsDZ/2ZjZ2Nhx3K31q5ydYwB7X
	 RgUjN5LitTRQTY8Y8/k1vLEQe5YGAO8nAK2PNmBxA5wDNv2KNrRvxPV33thoiDKEbZ
	 iDo8Z/I642AQuOH3wIwbTdSSdp8K1rDeLabbA5ui3l0sw96H3cZpDxqMCbs9Qpe39X
	 TtylIh0Hj1i6Fg5tJBBaFjdswr2wnc9HzTUlG9f3k3DByaxyDRS1Yf/8fw7EENIaNd
	 YDA2VbKrLtGKEwr1ur34oq+THJem0EWEoasVsImLygujZjiJGn/MWWPSp/JlrlJzv8
	 IJ54cgdA+Smg6XdYlvwz8Ji0D5ACSAz3aNlZkLRWMwGxVeGDH1GTzkH6O6nUoQ4vXm
	 m8aDzWi3FTTAkLzR/xjYA0jcXRq8PilpyiamvM1usjtMffjqgw97pAtopkWl/yxWPu
	 Bf4Z8bO78ZBdSRFgr7RD797U=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 36FEA40E00DA;
	Mon,  3 Nov 2025 18:25:02 +0000 (UTC)
Date: Mon, 3 Nov 2025 19:24:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 04/56] x86/bugs: Reset spectre_v1 mitigations
Message-ID: <20251103182453.GPaQjzdVCYTKRb7H5Y@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-5-david.kaplan@amd.com>
 <20251029115719.GEaQIBH1j4vVEQLas9@fat_crate.local>
 <LV3PR12MB92654784A9E2D5E5639B875394FAA@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92654784A9E2D5E5639B875394FAA@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Oct 29, 2025 at 01:48:03PM +0000, Kaplan, David wrote:
> We have cross-dependencies around the *selection* of mitigations, but not
> around the application of them.  There is no ordering requirement around the
> *_apply_mitigation() functions.  As such I would not expect (and have not
> observed) any ordering requirements around the reset functions.

This sounds like a single undo-function should be fine...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

