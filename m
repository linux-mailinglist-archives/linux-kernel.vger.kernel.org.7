Return-Path: <linux-kernel+bounces-840248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B86BB3EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99FE189C72C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F9130FC3E;
	Thu,  2 Oct 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="jD3VPsxA"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A91A9FA0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409357; cv=none; b=pfJ7d6kqbbMT5/gq+C5StVAC2BmY5ekU1rf9RNVs4FrEenaTU6gOzil+uiWvwN3ajtLtVGuEJMZ113iUfG31rIQGqejHyTYDK1EdokGC6SsaPVrpvxzlPMZA5KksRuLzuxZsHwOBOSHwnJWzC7EHA80dxo9xSRz03MxGdA4tcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409357; c=relaxed/simple;
	bh=dF+HMDCtAaCtk7/K/A86shLDHMc2i0cgn0sSLJEHgcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyFsdIbkKEKkqWZGSTrpMZgVFHCJHsS6ywZ2RRIXopEOf3FUq6XxFILknFvvqstP8D3PaLFHZlwXVzOIazl7wBqODNDoQ6lchob4T8oXeEY3B1W30i8BQTRNln0ES/xPjg9XEuZnhDrP+S/ZCbmTkbtlLuobXCwAjVfkpzSn/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=jD3VPsxA; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QEH3pN+BQ/qdHz36ORaSzBuUuVBfDvWQjuII3QxZO2s=; b=jD3VPsxAhoILjRxyk1I37RqhtR
	R/s4pTQdrO7vo+CUwjbnI7PGg0CnT3w2cyK2u5ob6nKPtc2xlFQpJJ7j907/tTJywfXMw9FUdBNy1
	1Vbpwnzqmc9k5Z4qZhmHTeyT1LD3Ph2YuNp/BfkSmNyBT3N4/F/w8od20iypIOGeMnEABe4uSGgfX
	NAWxXJHji4svOIO5dmtxguFhLShA0mn706+QFYh0WRAIJEpoDykTC+ruT8c/MzMDR/D1hmubB5OlA
	yu5gVVsU6R86hJNkjakosszA823ps/vw+3HNR2nS4sflHxSnAc3CS7cUqEafYCy3thuxRc3pTRZI6
	UhZXdrmg==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v4Ijn-00AxWJ-IX; Thu, 02 Oct 2025 13:48:47 +0100
Message-ID: <3c9d9f92-aaf8-4d4d-a2d9-8d6a410edc30@codethink.co.uk>
Date: Thu, 2 Oct 2025 13:48:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
 <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
 <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 30/09/2025 17:04, Linus Torvalds wrote:
> On Tue, 30 Sept 2025 at 00:25, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> Is there any chance some of the big-endian work we did is getting in
>> for this round?
> 
> Oh Christ. Is somebody seriously working on BE support in 2025?
> 
> WHY?
> 
> Seriously, that sounds like just *stupid*. Is there some actual real
> reason for this, or is it more of the "RISC-V is used in academic
> design classes and so people just want to do endianness for academic
> reasons"?
> 
> Because I'd be more than happy to just draw a line in the sand and say
> "New endianness problems are somebody ELSES problem", and tell people
> to stop being silly.
> 
> Let's not complicate things for no good reason. And there is *NO*
> reason to add new endianness.

We first tackled big-endian support on ARM32 nearly 15 years ago, and 
drawing on that experience, we saw value in doing the same work on 
RISC-V as a way for newer engineers to gain hands-on experience 
contributing in the open.

Now we’re starting to see commercial cores on the horizon that will have 
the ability to be endian configured at run-time. For example, MIPS (the 
company not the ISA) has announced they will be producing cores with 
configurable endian (https://mips.com/products/hardware/i8500/).

Note some of the patches we are proposing also make the code better, 
such as swapping .word for .insn.

> RISC-V is enough of a mess with the millions of silly configuration
> issues already. Don't make it even worse.

This feels like the price you pay for making a flexible and free 
ecosystem to build cores. There is no single authority making you use 
every feature that might be specified (although Ubuntu's choice to move 
forward with RVA32 for future is a current pain for anyone who already 
has purchased hardware).

See initial reply for comment on MIPS. We also don't think this a huge 
change and given most projects we worked through had few (if any) issues 
with building big endian, we thought it was worth having an attempt at this.

> Tell people to just talk to their therapists instead.  That's *much*
> more productive.


Thanks, but that isn't helpful and is just making the kernel look more 
toxic. I am however going to wear the "I got ranted at by Linus and 
survived" tag with pride.


> Really.
> 
>               Linus
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

