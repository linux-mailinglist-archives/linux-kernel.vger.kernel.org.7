Return-Path: <linux-kernel+bounces-818670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF855B594E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EEB4E08E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC928315A;
	Tue, 16 Sep 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="jjnHESx7";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="WncKLC5s"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54B1684B0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021385; cv=none; b=P+pAkhUpopJsTolfmMRmcC87TMD/zwKADpnRRtSFkVrLTZ0RVAU72GoqRu8T/3ARi2oM7rckqMTOYUvGuwTe8UyFzqX9PczbzmJ/Qy235e/g86t49TkejlBqOdugecDh/FaXW/MFNf/BefnhY8RQ0hlUtDD1ziRd0x+XNNOo1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021385; c=relaxed/simple;
	bh=hVpykSd8UsUvRbvpzYppVu1X+SxOaq8Fc8w4svXwdpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrDUn1ogfpalM474F+n+TsNLIqzG2Md24bLp5RjQFEGyNJCcWJnTZ9KbHSaLkuCe+S/z6ad/BKRYXl54/FbPrH7SayfbYHK4A7ATCCXkk++bVASTxZ58Jb+pAr4gvvPj+NzGfyAie4eWfcpdiGIOdpYWekkSJACFd/nr8G7vJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=jjnHESx7; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=WncKLC5s; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758021367; x=1758626167;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=pP90yeaFqjeMBYG9e5yov+4PvbWY+bRrEFrDgqvDYnU=;
	b=jjnHESx7Xjtip5gTpkigaliDQOOBC0kGJQS07xdIR8XEv8pp5RYgYARz6asFJfCdI2FGtMhMNPG9Y
	 w68YhrJkkNldZQ7FHueWY+TnDkA1WSaUS7aEg9pqDDFpEReEn/NET0e87B0yPFZAlLye2UdISqxQpb
	 4pC+FA0H2FTvU3gHPCw4MF3Ei1zhtpOHORvHyva/+7qLZJ9rkTt1t+Q6zivSB+9kV8TduUmkOQZ3Bp
	 PRxVkf9JhNvouhKn5SPa+CwKnAFt6TmoLbIPsfIXGS1r6vSuO+1L+Xm64yUNldJMYjMqXC5ZiKxB0v
	 CB0hRWwONCp0ohcGGidW1LHU/K7qE+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1758021367; x=1758626167;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=pP90yeaFqjeMBYG9e5yov+4PvbWY+bRrEFrDgqvDYnU=;
	b=WncKLC5sQQIoPcUhDtoVTqr2wAuEUC4ig2CqozfmaMPwCyyXFHcSxy3Hp4qqUAuQGZxDwUzsX4jBN
	 l73vdKIDw==
X-HalOne-ID: 8932b5ba-92ee-11f0-aadb-494313b7f784
Received: from [192.168.10.245] (host-95-203-13-255.mobileonline.telia.com [95.203.13.255])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 8932b5ba-92ee-11f0-aadb-494313b7f784;
	Tue, 16 Sep 2025 11:16:06 +0000 (UTC)
Message-ID: <be7fbc94-cd3b-41b3-ac20-5c46aad9aa84@konsulko.se>
Date: Tue, 16 Sep 2025 13:16:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: remove zpool
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
 <girukcvvzgbtkxt4aftfz3lw3glvf2qsof4mx6wf5perolck5n@vaxlrtaeuzw7>
 <dh74mr7bjtpzk7frviv6iqqno2u2b27p7jiagp2dtnsz2wrfhr@wlb5vqg4majs>
 <tbvushbdn7nzitey3uy6humdndd6247r4544ngqkds3cr447e6@prnla4edwxmk>
 <f3ufcsjvvxhi5gzw2wglkpedgyyi6tiaje7em3tbxkzhklphvh@sv3dbo4yba5p>
 <98B3AFB0-EBD5-4779-A5DB-FFA6717E83C3@konsulko.se>
 <fui4gqm6pealaxooz3xv3dnnqxscefyvhw5bhntedwh4tgjvdq@ootmbuoc3dpa>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <fui4gqm6pealaxooz3xv3dnnqxscefyvhw5bhntedwh4tgjvdq@ootmbuoc3dpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/15/25 21:37, Yosry Ahmed wrote:
> On Sat, Sep 13, 2025 at 03:55:16PM +0200, Vitaly Wool wrote:
>>
>>
>>> On Sep 9, 2025, at 10:12 PM, Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
>>>
>>> On Mon, Sep 08, 2025 at 09:18:01PM +0900, Sergey Senozhatsky wrote:
>>>> On (25/09/06 14:25), Sergey Senozhatsky wrote:
>>>>> On (25/09/05 19:57), Yosry Ahmed wrote:
>>>>>> I think Android uses zram+zsmalloc with 16K pages. Perhaps Sergey could
>>>>>> confirm.
>>>>>
>>>>> I'm not working on android directly,
>>>>>
>>>>> I can confirm that android uses zram+zsmalloc.  As of 16K pages, there
>>>>> was a way to toggle 16k pages on android (via system settings), I don't
>>>>> know if this is the default now.
>>>>
>>>> While I don't know what zsmalloc struggles Vitaly is referring to in
>>>> particular, off the top of my head, zsmalloc does memcpy()'s for objects
>>>> that span multiple pages, when zsmalloc kmap()'s both physical pages and
>>>> memcpy()'s chunks of the object into a provided buffer. With 16K pages
>>>> we can have rather larger compressed objects, so those memcpy() are likely
>>>> more visible.  Attacking this would be a good idea, I guess.
>>>
>>> Yeah I personally think attacking whatever problems zsmalloc has with
>>> 16K pages is the way to go.
>>
>> Well, there is a way out for 16+K pages, that being:
>> * restricting zsmalloc to not have objects spanning across 2 pages
>> * reworking size_classes based allocation to have uneven steps
>> * as a result of the above, organising binary search for the right size object
>>
>> This will effectively turn zsmalloc into zblock, with some extra cruft that makes it far less comprehensible.
> 
> I think the way to go would be this, identifying problems with 16K on
> zsmalloc, and addressing them one by one in a data-driven way.
> 
> I don't believe there will be opposition to this, or even adding more
> tunables / config options to alter zsmalloc's behavior based on the
> environment. If there's indeed extra cruft, we can either clean it up or
> hide it behind config/tunabels so that it's only enabled when needed.
> 
>>
>> Another option would be to leave zsmalloc do its job on 4K pages and use zblock for bigger pages. But it is not possible at the moment because zpool api has been removed. Thats’s why I NACK’ed the zpool removal, at least until we have a replacement for it ready.
> 
> I think having a separate allocator that's better for each page size is
> not a good option tbh.

I don't think anyone has been talking about a separate allocator for 
each page size. The idea was that zsmalloc (as a well-tested and 
well-performing _on 4K pages_ allocator) stays the default option for 4K 
pages, and zblock becomes the default for other page sizes.

