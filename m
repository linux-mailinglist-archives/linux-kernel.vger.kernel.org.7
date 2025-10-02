Return-Path: <linux-kernel+bounces-840401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3359ABB44C2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0AB320526
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB2B19D8A3;
	Thu,  2 Oct 2025 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="gaM6XtOf"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0D198A11
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418534; cv=none; b=DeFKqgf/+Mufs+m8/zQFoPJmCStOTKxI5VgrBane/ScvWjNrUguq6nzt/xiKnEVmuy8EaLQ2+tV8r52BejX5kgB7Zov4/pQiLmdVMuSKRLgh0TfrSBjAgWysVSbPI3BWw7VPhPZ0zGpwXtQfPeNxzDEqSdY7sSONk2tBO7aHUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418534; c=relaxed/simple;
	bh=pQO/koYJAS/lQvDppiSwHxpYzCJDueHMHLRlS4eUVSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhNmPSQTd2N+eB1G0rZ6lhCUtzOKeiK76umntXHJKVsHiN/ibUAvMUha9q/kc+tDNKjM4WhSSoS0+euF4o8Yh2mF9Rj7Yvbfoz/3c3Z1htd/NmWIgnK6YlmnA1ilrIMjMqibYWTGHD87K3w8d9cD3Q3cgclPXbj7QoUCkfCTGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=gaM6XtOf; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DsdadTrpEMppSEuIxvzZ9KKkJLLFGGPP5t2vdodYbqo=; b=gaM6XtOfCjcEforVgVm85r4oFn
	kQGlcatfb76z7XT+O0iZczQlo+OkkHYezTHB+ynxobxTda9bvf9VyvjhnslKUNci6EiLjlOKB7dZI
	uedmTUVaEytzBGS6ZkNR7zsoktbb3u6Ou8QjpKi6dt/BL5Dhw9U9LU2HQUTgmb5p1D95LS9kIdB2m
	XRjZmRdNaNRiwE9sGvcrHXaaio8uyq8UsIpCgLs9qFEaeLAEp7d+5BG/Nwqy3dU6ufap186KTbQj+
	s65NwHJA+y3vDi1MB9p1vTxxxulZVWNw2WpBUDEsM3bCui/D+Q+IRteblfVGcqQ1O2trl5jWDKh+E
	2mne6Eeg==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v4L88-00B4Oo-JN; Thu, 02 Oct 2025 16:22:04 +0100
Message-ID: <eed8c89b-eede-4595-b512-424749fec6ea@codethink.co.uk>
Date: Thu, 2 Oct 2025 16:22:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
To: Olof Johansson <olof@lixom.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
 <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
 <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
 <3c9d9f92-aaf8-4d4d-a2d9-8d6a410edc30@codethink.co.uk>
 <aN6U8NtIfqd-fowQ@chonkvm.lixom.net>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <aN6U8NtIfqd-fowQ@chonkvm.lixom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 02/10/2025 16:06, Olof Johansson wrote:
> On Thu, Oct 02, 2025 at 01:48:47PM +0100, Ben Dooks wrote:
>> On 30/09/2025 17:04, Linus Torvalds wrote:
>>> On Tue, 30 Sept 2025 at 00:25, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>>>
>>>> Is there any chance some of the big-endian work we did is getting in
>>>> for this round?
>>>
>>> Oh Christ. Is somebody seriously working on BE support in 2025?
>>>
>>> WHY?
>>>
>>> Seriously, that sounds like just *stupid*. Is there some actual real
>>> reason for this, or is it more of the "RISC-V is used in academic
>>> design classes and so people just want to do endianness for academic
>>> reasons"?
>>>
>>> Because I'd be more than happy to just draw a line in the sand and say
>>> "New endianness problems are somebody ELSES problem", and tell people
>>> to stop being silly.
>>>
>>> Let's not complicate things for no good reason. And there is *NO*
>>> reason to add new endianness.
>>
>> We first tackled big-endian support on ARM32 nearly 15 years ago, and
>> drawing on that experience, we saw value in doing the same work on RISC-V as
>> a way for newer engineers to gain hands-on experience contributing in the
>> open.
> 
> Getting new people going is great, but if you were around for that
> one you also know just how little usage it saw over time -- the ARMv8
> big endian enablment has been on (minimal) life support with just some
> downstream usage in vendor kernels. Adding the burden for everybody to
> maintain this work forever is the flip side of the coin here.
> 
>> Now we’re starting to see commercial cores on the horizon that will have the
>> ability to be endian configured at run-time. For example, MIPS (the company
>> not the ISA) has announced they will be producing cores with configurable
>> endian (https://mips.com/products/hardware/i8500/).
> 
> MIPS has been doing some not so awesome things to the RISC-V architecture
> in the last year or so. They've published patchsets that make it seem
> like that they seem to have taken some old MIPS designs and done the
> bare minimal conversion over to RISC-V, since they need their own weird
> system peripherals and hooks. Again, with the burden for everybody to
> maintain because their hardware engineers couldn't bother to develop a
> full proper RISC-V core.
> 
> While I'm not happy with the lack of upstreaming from the (mostly
> Chinese) SoC vendors, and we should be encouraging more of them to
> contribute directly, MIPS seems to be making choices that might have
> long term burden for all of us. So far the slope is slippery on the
> system side, but needing to worry about BE support seems to be stepping
> over the line for me without some obvious clear use cases that make sense.
> 
>> Note some of the patches we are proposing also make the code better, such as
>> swapping .word for .insn.
>>
>>> RISC-V is enough of a mess with the millions of silly configuration
>>> issues already. Don't make it even worse.
>>
>> This feels like the price you pay for making a flexible and free ecosystem
>> to build cores. There is no single authority making you use every feature
>> that might be specified (although Ubuntu's choice to move forward with RVA32
>> for future is a current pain for anyone who already has purchased hardware).
> 
> Just because the ecosystem is flexible, doesn't mean you need to encourage
> and support everything that gets built.
> 
>> See initial reply for comment on MIPS. We also don't think this a huge
>> change and given most projects we worked through had few (if any) issues
>> with building big endian, we thought it was worth having an attempt at this.
> 
> To me, it's not about the initial effort but about the (forever) work of
> keeping it going without regressions. Now everybody will need BE CI, etc.
> 
>>> Tell people to just talk to their therapists instead.  That's *much*
>>> more productive.
>>
>>
>> Thanks, but that isn't helpful and is just making the kernel look more
>> toxic. I am however going to wear the "I got ranted at by Linus and
>> survived" tag with pride.
> 
> Hey Ben -- you posted a *RFC* of the patches in December 2024. I replied
> to those. So did Palmer. With exactly these concerns. Did we get a
> response from you? Nope.
> 
> So, seems like Linus has better success being impolite. That's a bummer.
> 
> For the RFC thread, see https://lore.kernel.org/all/Z2XLS2HX2KqBJW6U@chonkvm.lixom.net/

Sorry, didn't see that and would have replied if I had.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

