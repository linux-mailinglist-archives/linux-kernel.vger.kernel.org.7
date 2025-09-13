Return-Path: <linux-kernel+bounces-815320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC0B562A2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18B01B21D57
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252E23D7DA;
	Sat, 13 Sep 2025 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dJEs1yIt"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5378212569
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757790128; cv=none; b=lAQmRs+kbtVdqdYNNZ4MAcvtsXKG5yEGMBn7W7oMOxAM4XBtlYDUdXqqOGsHDZzUr/YyOwZHiQ0BGqRSlBGGXkB+ZssH0soZUMxCsM/hDY5UFDSHOhxkgxe4mzrIbIcN9wyajq2kU3IRHVlBokWqp4aSTZdmCSEymy1ZEYjU+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757790128; c=relaxed/simple;
	bh=PYOzChc3QOqTurkscaqucSyDltUX2/pzt71k37MnlHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtOc35wymuDvQUdhbwvBr7F0LkFAl7Jzm/YiwrZTgl604wgzmkEu9deOyI+3rEu2eSP+HauD8Tp7HY7Ts0roOM5Zmmw1w2TN5GUCWR/9uD6UT9xr1qsJRKvvaf5v/i/SUj3NnaZmwyCt4xRUqayoo3DIfRwq5rpYhCtv5RgTFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dJEs1yIt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4649D40E0174;
	Sat, 13 Sep 2025 19:02:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OhYrpvhZWHLG; Sat, 13 Sep 2025 19:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757790116; bh=p9LfCNNRwOQ3EMh6/l5HSoIoI4uO0TsPVEIbtrYlfno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJEs1yItJhKpJHJbwX+IFMWfvYRNuNp4op2L86x6srjuvYkciwk+qnGDDFC/qQEYQ
	 0sMBVH/Z9gyBxnpij60Zk0KlObsEau7JO0bGim5ZsJIQYuMeGbUffL1/gqmYYvID1+
	 kiEMTeGdoM1kiWsFvdDkutdEDFMgwq0b4NhST84BHZ07qYPlna/eTaUn3DzOLDKdza
	 Wb1KI9snvYRJcq9LFX40hwH0UJqg2DT7RWOS+iJpW4FDomCX11hKK0PGwfAfnIrGkQ
	 fE4u1UDobtchK0h3Sb28bhpEoUIvGrXq10ru7elKJqZ7+N6T+GiPyaDk9/PCoRs52t
	 EStv74BmGDBDTEeGCLHGOTzEgY97UttNPvvMKtCHW6O6yg6aWIaIAsmoKEwEcPMqES
	 7o0Qbw+u/TuNto7LybwLrGSeb5HIirvuTZjuGxFUWLy9QFNu6lCcuK6EQtxQ37+RI0
	 b4BdX6D2j9gAHnMpakmqIVKHNvLXSaZzobVYfi3KybUsr6qe+q2bQ0704txKDghLAB
	 3GtJhNB/v7VMVd82lGrD5Ftta43HXEI8tWdQF18BsPi8Eg70Ht7S6ADC97N64qPI7g
	 8L4d5sQ6OUzDjCnIzeOkuFcd1iWpHbrMGr4zRsNuEkijh1ZCGJoi5vVDdDf+WfsIgR
	 uNoauLH652fln9vDZIKlKlBc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 493A540E015C;
	Sat, 13 Sep 2025 19:01:48 +0000 (UTC)
Date: Sat, 13 Sep 2025 21:01:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, chao.gao@intel.com,
	abusse@amazon.de
Subject: Re: [PATCH v5 6/7] x86/microcode/intel: Support mailbox transfer
Message-ID: <20250913190141.GDaMW_lTQPvxOWRMbe@fat_crate.local>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-7-chang.seok.bae@intel.com>
 <20250912163421.GBaMRLjTUr3bcG5fvJ@fat_crate.local>
 <c0580922-608a-410c-aec6-08249087943e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0580922-608a-410c-aec6-08249087943e@intel.com>

On Fri, Sep 12, 2025 at 05:51:49PM -0700, Chang S. Bae wrote:
> The functions for sending microcode data and retrieving the next offset
> were previously placeholders, as they need to handle a specific mailbox
> format.
> 
> While the kernel supports similar mailboxes, none of them are compatible
> with this one. Attempts to share code led to unnecessary complexity, so
> add a dedicated implementation instead.

Better.

> Yeah, good suggestion -- maybe it could dump invalid header and offset
> values like these:
> 
>   pr_err_once("staging: invalid response header (0x%llx)\n", header);
> 
>   pr_err_once("staging: invalid offset (%u) after the image end (%u)",
>               offset, ss->ucode_len);

Should be more helpful than before, yeah.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

