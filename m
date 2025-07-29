Return-Path: <linux-kernel+bounces-748723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4522B14557
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EE117C2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330D200A3;
	Tue, 29 Jul 2025 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="etwz6gvw"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58740855;
	Tue, 29 Jul 2025 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753748724; cv=none; b=RNnwPHf1Ipf76TTf/GuMDYJMaPVPvhlo1g82MG3+8Vu2RaBX5Evvyk4YvFHLv5vVlo3MlE4gMdFVl7VLt0RfvV5hhUtzdazDc2zPYbtk8Cs3oHFFN/T7KKwOSjZcYGEZo0hhQM5FP0mAsSujXVcOOD0gEnKB22UmvXtgAF6XPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753748724; c=relaxed/simple;
	bh=yf10sURyfTttx7QqEa0p3PVES3s4FDChcH3hqcbsL50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYpohScbUSvyLu6AfuCxlNDHEbrttJcrcZOK2ZzLNvNkPV5emQ8vHBP7Y4E4E7GxpgvIK9TCp9UByFrfR/CoMwVDuFZxQvdCkARJsyEEp63t2jJW6yZzZA67WCUTHy7HovS4D6ESBxDjy+uRRIhFvq7gFO/6+wO8H6mkwddrzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=etwz6gvw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0OdFvPhp8aEGqtXLUwB1d8tbFIud1VW+9Y7LoModa4c=; b=etwz6gvwu64D22aZtSj4MFptWM
	Rhp4//N15YSRwVtpHf4+gFukURFxNLHXr3czBsU4OqwWm6T5TZBij+48X4hhPAwjkCBG+w/ub9s/q
	8eUPkkurwt2vHMgOJZyIO9uZhTs6t+u89roW2VcKhi0wYZYZBcndsXbuZGM1Ivqwg4PHchs0CQxaE
	d+2OMqy/zVJhrYwEP2yF/JIk2sgrfvdCm8rC+DSgNqWBg+8XJvV7E1LGv6ZfRQO1G61G6BXxBm8ww
	1LY4xC8KSUwd/0rCcwkunp/pB46TY18hm4Ko23TibXvRcGDCxdEm+/BX5uN8K4U1ARG6QKu9FKqgv
	dEggKDdw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugY9a-0000000Fduq-01qw;
	Tue, 29 Jul 2025 00:25:14 +0000
Message-ID: <d55e56d2-65bc-48d8-a80e-b1dbc9ea6396@infradead.org>
Date: Mon, 28 Jul 2025 17:25:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: Fix typos
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250728222347.GA3253635@bhelgaas>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250728222347.GA3253635@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/25 3:23 PM, Bjorn Helgaas wrote:
> On Sat, Jul 26, 2025 at 08:16:26PM -0700, Randy Dunlap wrote:
>> On 7/23/25 1:32 PM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Fix typos.
> 
>>>  			Where more than one trigger may be specified that are comma deliminated.
>> 			                                                            delimited.
> 
> Oof, thanks.  Added to my local branch in case I repost.
> 
>>> -Note that irq domain lookups must happen in contexts that are
>>> +Note that irq_domain lookups must happen in contexts that are
>>>  compatible with a RCU read-side critical section.
>>
>>                    an RCU
> 
> Thanks.  'git grep -i "\<a rcu"' says there are approximately a
> zillion instances.  I fixed this since it's next to another typo, but
> not sure I have the energy to advocate for all the others :)

Yeah, I get it. This patch was a ton of work (well, time).

and like the s/cpu/CPU/, s/pci/PCI/, s/irq/IRQ/ etc.

-- 
~Randy


