Return-Path: <linux-kernel+bounces-818024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5060B58BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061277AE970
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E5223311;
	Tue, 16 Sep 2025 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heyquark.com header.i=@heyquark.com header.b="eRF/+CFr"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79C1D63CD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988632; cv=none; b=mwg/zOlq+iavh9Eo36z/1yd1FQtpWHNRgC/cpLYBrfJKA2uy8C4FZ94eV7dTB9DlP6RCJlidUtDDVfRlsNYCY4PDecPhco7S8xRLVfrAfJttNk5e4feCCe7W56cGpCvz6L6wKZG/gMMQxJY/49JVoVREGsjEcpBgl+Bzqk09JwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988632; c=relaxed/simple;
	bh=bXmDvVWcHXxijKQJr8QRBglYzhdO5AlV3JfMf//AnEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPddZZeug/Yo7vWoVnbB+fxrpwAcBI99R6oOlQFLGS/mPtIUJ8f1No5h9jB02BAEZwBn+1E+o5+nZOJAqFfgJqN1JOF3GeQttUECJs1b0Bs4HqG+72fZlfx0wMfSLkCKfldQOEygznHNDV3aumk5zMKN5ZpJObgipXe3I8Tsq4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=heyquark.com; spf=pass smtp.mailfrom=heyquark.com; dkim=pass (2048-bit key) header.d=heyquark.com header.i=@heyquark.com header.b=eRF/+CFr; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=heyquark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heyquark.com
Message-ID: <95d176d1-e1be-4594-91bd-caf0d68fd532@heyquark.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heyquark.com;
	s=key1; t=1757988626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJr24DEs/rWeHHDqtfvtPlFLof2ltSbnJvrEvQKwOHo=;
	b=eRF/+CFr1nTu6HDehRO4fvmEVi8PQElVzr9pKXog1aJk0eEtUK7ZQcdbABGk0cl3sI2gME
	Q1AfB4m6d5V7Pgsfn5lNmwA3BbGLW5eDQNFaH+5fmg3ealHyJyw/JsyQM5poP3qiQRFIVh
	CQvvB2z3abIjCYgzrYALUaruzVET4modJ5T+6Lx5xN3H3QKdb4z6hwIhmWl3ct3ZePcZWh
	mFpBDEmFZGQKGHQvbihd71tyjMNbamXkQvmstyvcTvAkKAdglezTAhgqNnw4g0k/Hufi0W
	yoLD/tzJw36KWKrsQ1iSDM7HfNdLWK6hMAWzD3B4+uVTqtTKYhnQ/9S5mfWrNQ==
Date: Tue, 16 Sep 2025 12:10:14 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 32-bit HIGHMEM and game console downstreams
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: arnd@arndb.de, christophe.leroy@csgroup.eu,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 officialTechflashYT@gmail.com, AWilcox@wilcox-tech.com,
 Michael Ellerman <mpe@ellerman.id.au>
References: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
 <aMbNwBrxtBSPl8NQ@gate>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ash Logan <ash@heyquark.com>
In-Reply-To: <aMbNwBrxtBSPl8NQ@gate>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 15/9/25 00:14, Segher Boessenkool wrote:

Hello!

> On Sat, Sep 13, 2025 at 08:53:08PM +1000, Ash Logan wrote:
>> Wii (2006)
>> - 1x PowerPC 750CL "Broadway" @ 729MHz
>> - 24MB "MEM1" + 64MB "MEM2" (non-contiguous - MEM2 starts 256MiB in)
>> - Kernel 4.19 (+ CIP patchset), dev has been working on forward-porting all
>> the drivers one major version at a time (he's currently up to 5.15 last I
>> checked) + limited upstream support (hardware bringup, UART, not many
>> peripherals)
> 
> There *aren't* many peripherals, so that is quite okay :-)

That's true. The lack of a UART or similar does make USB kinda essential 
for an input device in my opinion, though getting it working is 
Complicated for DMA reasons. (I think this is the main thing holding the 
downstream back in their rebasing efforts)

>> Wii U (2012)
>> - 3x PowerPC 750CL "Espresso" @ 1.2GHz
> 
> It is not a 750CL.  We never found out what the model # is, if indeed it
> has one!  But the CPU cores are compatible to the Broadway, sure, there
> even are configuration bits to make it do the bugs that were fixed in
> Espresso!  (Just like Broadway can emulate a Gekko, 750CXe, the GCN
> thing).
> 
> It does have its own PVR value of course, that is something at least :-)
> 
> (Espresso is one chip btw, with three mostly symmetrical cores).

Yeah, I was just going for the closest "public" chip :) I think the PVR 
is closer to the CXe too, but all the HIDs, missing THRM, missing 
frequency scaling - it's very CL-y...

>> - 32MB "MEM1" + 2GB "MEM2" (also starts 256MiB in) + various small SRAMs
> 
> It has 32MB MEM1?  Huh.  Why?

New generation upgrade? MEM1 does get used for Wii U software too, 
usually to keep framebuffers and other 3D things, so I guess they wanted 
just a little more for all the 1080p buffers the new console juggles.

>> Distribution-wise, we're supported by ArchPOWER [5], Adélie Linux [6], and
>> other distros. The Wii U's Espresso has CPU errata requiring a patched
>> compiler,
> 
> Can you remind me what that is about?  It shouldn't be too hard to
> include it in mainline GCC.

The short version is "every stwcx. should be prefaced with a dcbst" - 
something to do with bus snooping (store-with-flush, store-with-kill) 
I'd guess. I have some GCC patches drafted (activated by -mcpu=espresso) 
here: https://gitlab.com/linux-wiiu/smp-patches

I'm impressed by how often IBM stuffed up atomics during this 
generation. The Xbox 360 has an extremely similar issue despite being an 
entirely different lineage of chip. No surprise the console vendors all 
went to x86 and ARM right after, I suppose.

Thanks,
Ash

