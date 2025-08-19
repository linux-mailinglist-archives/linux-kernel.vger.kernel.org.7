Return-Path: <linux-kernel+bounces-775934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7EB2C679
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945877B01DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF001F4C9F;
	Tue, 19 Aug 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qf4tucmN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92131F2BAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612206; cv=none; b=S97aNS3nv+ERXuwIDUIZ4yZbLxs6QhL8dA5HP+H9ZGhSJfmLyfk2DmgAad+Dw12lERyxZLyp7W51iOJP3AlhWCpcH2uZ17QolKex+5uc7VgL595Xe0HjsTBCxdkqzThERdmW4PqaL/SFuX6v0jcv51Z/rMmNPf2rj4x1/dMTepU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612206; c=relaxed/simple;
	bh=Os43/Ps9lSDGeXR2Vt1qbg8hPfdyfB/k+6pnF0QYeiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCZKRVyuTGGvV5aIJ+E2Au73GziWMcOG5VCtPrvRY29b0OHyfJ74agsp7+/GPwL5RxuYo8aOmUY22iRsfLhPMagYduaQThN26w/yyWBDgXjET/MmULFeCRoTMnHlx52Lk0wshwABPV+BnLK3NP1mU6JTbcT6f68Dk05cINOWoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qf4tucmN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7E35F40E0286;
	Tue, 19 Aug 2025 14:03:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id auAitoUlA6Ur; Tue, 19 Aug 2025 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755612196; bh=n04+d6onp2WclGfkGmT16OdJYkfE3RzAaqpfKYOuFlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qf4tucmN6HJP12fsw+MDeGV5MWlR2CPjNZMvAnj75Y2AiCHZecW8jwVF8Q3E7Nduk
	 cKT8h/ipObl/b9qYjcxLjNdVkJXWFuySjPelwAwWN2wmBrnp71efAB9EMIsd3p1n5v
	 ZP1sERpMW3nPZm9WDCwAu5S2NTuYzY8qyr6sBxbcTDVlMOXfj61vCEjL7Ab5tmWQfR
	 rXaxon1Nh1mOhCZzkZ4PbX9sZzsMo/CssXrlJ0VPCNyiiTnMHOT8qySCtWzkJTEa4J
	 Y1iM/SmgP4+/0xMDB+KWMisZ5wAa62PnTfgcPtHAyL/6Ha0Siw3QSR0bSfUiYt1YKi
	 zJDkX2uvurbzoDS19e7++ACWESlC9gDFclazPY9ZQYu9YLYbCsS1NuEqWdg1NsQWdZ
	 0umUt2Ddby4x4glomxuknCPHJi/KhtUx7J3nj1f73oGhlqOgFCKKNiKoWR/bTEciu7
	 2lAxKJCE+dJ3YNKl6XRgHBWc1+fYOKhektjyNaIOl6tXOeJcHGr1dIdUS9lHxfUiGP
	 DM9pJY2cJUJbmlw71CiZ9xlePkc0lK7jmVgWIO7vXrBBupS+CAeMW3jYvkDzh/ZzUE
	 vVoHsjUmQqCRZClZP0++4C+leNqRXuQBhVYh2ElB5ZH77bpaYiL7G0E3/rr/536sUE
	 2cYDK1U6432PhgrWeaWzCobE=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BC4E40E0232;
	Tue, 19 Aug 2025 14:03:12 +0000 (UTC)
Date: Tue, 19 Aug 2025 16:03:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: x86@kernel.org, linux-firmware@kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] amd-ucode 20250808: "No sha256 digest for patch ID:
 0xa0011de" on Linux 6.12.37
Message-ID: <20250819140306.GFaKSEGnSdHfB3D_Qv@fat_crate.local>
References: <CAMGffEmFm8wvgiw+s0ZpOhRxBLOz3dQiS=sQCkgJLD6qC3VwJg@mail.gmail.com>
 <20250819105527.GCaKRYH9VnQaVdl7gQ@fat_crate.local>
 <CAMGffE=+hhf6EXCVYo+tvdUKN8B=uEtjkTpo1R9PXN3HycXG-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMGffE=+hhf6EXCVYo+tvdUKN8B=uEtjkTpo1R9PXN3HycXG-Q@mail.gmail.com>

On Tue, Aug 19, 2025 at 02:16:29PM +0200, Jinpu Wang wrote:
> Thank you for the quick help and for clarifying the situation. I
> apologize for overlooking the information in the `amd-ucode/README`
> file regarding the required minimum base microcode version.

That's ok, having this documented on the mailing lists is a good thing too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

