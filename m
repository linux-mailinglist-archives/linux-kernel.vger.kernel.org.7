Return-Path: <linux-kernel+bounces-880422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0389C25B99
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DA734F7CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC72F6934;
	Fri, 31 Oct 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HSkma5R3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B02F549B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922003; cv=none; b=DadPMZVqTtj8dkWq9hw3q450662mgfxQ9bbpkZeyYnE/u3lPJ5plu2WeQTBQKU/BDX9vAnL1AQL9NHbygn6DBg4rCpdpUHOGw1k2V9a8nBcAe0lJxITqsxhUjY9dcRduAHvR4wRxRfOnAm+AnN6yOW5wfom2jAf2blou6HYtQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922003; c=relaxed/simple;
	bh=I0D8zEUzHWRoLyMrLmjRg0TO5+pa0DnWNgTRL/MMC7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnEG/nKO2InZFDJdgxoWMgxevGMNaOTFzNu678sh0DT1NpzLPasABK1rGjgkd/k6ZCI8q42kjXTR992BaoYt9PCphYg0orgr7Ly0JIrXaxhIxOcf/jWXvb2jE/K7tR+BIqF9guQuAiAczKBqYaMJ96XsStj4o0RTO9cgai5tYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HSkma5R3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D931940E021A;
	Fri, 31 Oct 2025 14:46:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 12ypCgd7SYuo; Fri, 31 Oct 2025 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761921994; bh=S0lKdfMX73XZcfsrdjcrRexDp2SzUblDbE57cuGidgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSkma5R31uDoOHZ8j4YkKpz1W74Uwnv6E8C+nJpROoPQCnyCrWtKeLH1QjoncGg0G
	 XgqjYhCYBiYfJs2Gs9gfNW0J3g73HRsb5OBTD2egzn6HsJKjp3S/g7PKAVG0mJ9DxE
	 uMXyLbK0jMSp9zmkHkREU/WvirM9g8E5S8kH8avZuziVPh3drRmEg2U5HR2j1TK4pl
	 oFFZ2or6dwu9A+XkCA3QAV65UKsCDGyU/bYsPUBGZyY0I3voJwj/Gs/PDq52twnxx3
	 hEiiKeAaaMtE9GzC8UQR1Gl5Gc64gWTbf6hucRJa83cjOC2riHO9poRMzIgB4q7ag8
	 x9Rro5xU4A6Pq0sCziDDyGjOyEhq45OgobuZQW2z3sHGOvJ2lJOP1e/X8X26PlL7yI
	 lHklTM/972HXqGD9lZBr5ycopbA6Afm8a6ECQ4V+UuXa02fkRlAO+7DRqHlIpH62Nq
	 HP71g4EsoZ8/6kPJCddy5YcIvgkZBuvnhGeO/ct56CmsgdahMjsfZlPGdysvG11tVR
	 Fg/jKUJeuesHL3uiQ+Iz0HenYhVl+jaEnTr2hqNOo+aw46/qBu46OS7deCYXuQQOE7
	 D6xAlSpSk0aK8TPdJiFUfuyYwhsKA8+EdvTHy7B27hOMfu8qcYX2Gtxugg3h452OUY
	 LIOJGxprrB89DEDiBx8CIDmU=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A67BC40E016E;
	Fri, 31 Oct 2025 14:46:25 +0000 (UTC)
Date: Fri, 31 Oct 2025 15:46:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/mm: Ensure clear_page() variants always have
 __kcfi_typeid_ symbols
Message-ID: <20251031144624.GHaQTLwONX3j6aDkkP@fat_crate.local>
References: <20251013-x86-fix-clear_page-cfi-full-lto-errors-v1-1-d69534c0be61@kernel.org>
 <20251030192819.GFaQO8U29xvWcPT_s2@fat_crate.local>
 <20251031142044.GB3022331@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031142044.GB3022331@ax162>

On Fri, Oct 31, 2025 at 10:20:44AM -0400, Nathan Chancellor wrote:
> These errors occur in Linus's tree so could this go before that one then
> it could just update the instances of KCFI_ADDRESSABLE? I don't have a
> strong opinion, I found these series of errors tangentially but this
> feels like something that could go via x86/urgent and that series could
> just rebase on it.

Sure, that works too.

I guess we want that in stable too, considering where the Fixes: tag commit
landed...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

