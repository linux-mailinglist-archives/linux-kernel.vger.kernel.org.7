Return-Path: <linux-kernel+bounces-817694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 021DFB58576
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796871B23271
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BCD285CB6;
	Mon, 15 Sep 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3m7PEqF"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE44285C99;
	Mon, 15 Sep 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965388; cv=none; b=OvvZ6TXYu/OTRs3E/gB+1T+n1s/dQ/AcMDYxWGC7q9vtUVnJLs6b0KkWtiAqQgoWC/8l4RoLXf+/aNHjyp5rEWLKYBi29Gg+Jrk2VD6aDIMkuKwSPmuFtvWvb1N61a5mfnSTANF7AlaAvqNQm+tunLxMrILruop4MHx+SxI5MeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965388; c=relaxed/simple;
	bh=epaKwJMYczTSL01ZB8bXFMGtqIqL7XJe7T+42cBAevU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jis1meAT2MkewdZJCSxoEXT1tdgtoR9uG+prRIeOFMNTWHw4LvWlndbXK2inQSqjDItdYJ64WwTTLEqEQb/7Iih1lQw0v0WeeSmyzLB61mT2BNiltC2+wMrmZGdDLE+C2+ZzAVXDcL2Pycv/G/eo5Q0D33qkaSuOYJvJuR7Wltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W3m7PEqF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cUN3WtXzTxNqQ0CfUfMOoJPuAvmct5rRY2sJBTlMcbg=; b=W3m7PEqFmUz1qc+WctQxbF61dm
	zYH6T+hZ70GL2xseVnvVp0CWaU2lL8qRELvgot6iARgCH5dfxBSFaxdNO5abz78jWxpPpPDTIqb8Z
	/III5Y/bcLtKak00OH/fR2oZipuvCO3nsRAo5I5fcLS/meBLmLlEvtkoXXKuX2L0KrJuJpfdH4lQa
	HaDtUyJAkxCXAWBC5F3uQWHvywCzMzffUwfP9vJd7gyfL4M9UIy3LaYJ9WBS1Ah3qZhfHp0YWYq/A
	5GQr+KdDe+9O1MbDVxqrBMk9nYFeBQmajHIqDCHu4SO3DDtb/MeUtFsMLaXiZcdz5WLN8+ACDDOrm
	kBlkyr6g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyF6Q-00000005X2w-3QIW;
	Mon, 15 Sep 2025 19:43:06 +0000
Message-ID: <8a9b2f36-963a-4d10-9aa1-10f8dcb4bc31@infradead.org>
Date: Mon, 15 Sep 2025 12:43:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: maintainer: Fix capitalization
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915192235.2414746-2-thorsten.blum@linux.dev>
 <c85881bd-a159-4bb3-9615-b87ce4ab0575@infradead.org>
 <E32E7460-02E4-4E85-8482-E91D3FD12253@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <E32E7460-02E4-4E85-8482-E91D3FD12253@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/15/25 12:35 PM, Thorsten Blum wrote:
> Hi Randy,
> 
> On 15. Sep 2025, at 21:29, Randy Dunlap wrote:
>> On 9/15/25 12:22 PM, Thorsten Blum wrote:
>>> The sentence starts at the previous line: s/Indicate/indicate/
>>
>> Are you sure?
>> ISTM that the entire line is a "sub-heading".

After I sent this I saw that I should have added that it's ambiguous
and needs some formatting help, so I'm not surprised to see this:

> Hm maybe, but then the layout/rendering on the web is very confusing:
> 
> https://docs.kernel.org/maintainer/maintainer-entry-profile.html#key-cycle-dates
> 
> How would that be fixed?
I'm not sure. At a minimum, add another colon at the end of the line.
Or both sub-headings (this one and the one before it) might need a "::"
at the end of the line and then a blank line inserted there.

I'd have to play around with it and test some, but for now I have to do
something else...

-- 
~Randy


