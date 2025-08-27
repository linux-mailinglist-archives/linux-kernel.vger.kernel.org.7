Return-Path: <linux-kernel+bounces-787993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF2B37E89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A58189BE67
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C741343D87;
	Wed, 27 Aug 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pWsGU5MR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B0343D7E;
	Wed, 27 Aug 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286059; cv=none; b=AaiY8ctbC2TKR8mvUS7NFOHxC/P2DECnzlKeia/YKQ6u7jwEhxR/TDZ3hWik7X5z9uyNn5TyyXtbYG71QdNM9wU8yoxWNaFI+zY4Uacgm8yKyNXCVjMgJilUvZGacy8zxYgvE3ZDLmZkYn/1uuvDtQinulG9QsPHrAhD7rHdcNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286059; c=relaxed/simple;
	bh=5D1RSNh8SPdHigkKTi5kPrSK7v3ph6xdRdhiellMLZc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=owMwBsigcH4lpsj+qhzcOfiYyPXp5cm7MUHClgcERNNQp4Hy9+KulqOx664XS03JSjGnCseEIxntMW4YCixfVnweM+5n+IxwDjbP9vPDD+xXbr66X3ikU2Y13BqzBRU/uLLsMJGBKT9deCkXt3gGBW2rsLd/Ua1ezXwGeolw8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pWsGU5MR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756286056;
	bh=5D1RSNh8SPdHigkKTi5kPrSK7v3ph6xdRdhiellMLZc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=pWsGU5MRZ2qpbkEohHl6lbG0wwsZ8JKYMT3LgJinrwGS2Mk4kgREOXv3ta0bLBsZp
	 IRnWDKF4XcYXFw0+3VFGmxYHcruDSLuJA6US/u8hhniXX5r1QdmRQk+FlXHwJZOcoY
	 Oh1pw+TiQ8K8t/EKT0Acrbnz6YqiTzKLuqoE/AFDrzCEsLUTsjMEjC5di8lj4VElfh
	 1VUWpNuE6NxcpKhXc2f8EcXOFMgU76GDG0YY0Cu0f6Bhy82k/oiKrM/resVEp3whZt
	 25+e1Gwg/9irqA5liQxpDcm2kRE8vXxb3/1qwKkr3QZ8tfb12oTPa/uhpnGHUA/vEI
	 PaiFe9cjl4/Mw==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B1FB817E0483;
	Wed, 27 Aug 2025 11:14:15 +0200 (CEST)
Message-ID: <5b39ce10-9845-4429-95bb-18b03513cdaf@collabora.com>
Date: Wed, 27 Aug 2025 12:14:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] USB/IP VHCI suspend fix and driver cleanup
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 "Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
 <2025072637-corny-careless-8523@gregkh>
 <3dd94c4f-0971-4744-91e1-3a5474e1576c@collabora.com>
Content-Language: en-US
In-Reply-To: <3dd94c4f-0971-4744-91e1-3a5474e1576c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/25 12:41 PM, Cristian Ciocaltea wrote:
> Hi Greg,
> 
> On 7/26/25 9:43 AM, Greg Kroah-Hartman wrote:
>> On Sat, Jul 26, 2025 at 01:08:02AM +0300, Cristian Ciocaltea wrote:
>>> The USB/IP Virtual Host Controller (VHCI) platform driver is expected to
>>> prevent entering system suspend when at least one remote device is
>>> attached to the virtual USB root hub.
>>>
>>> However, in some cases, the detection logic for active USB/IP
>>> connections doesn't seem to work reliably, e.g. when all devices
>>> attached to the virtual hub have been already suspended.  This will
>>> normally lead to a broken suspend state, with unrecoverable resume.
>>>
>>> The first patch of the series provides a workaround to ensure the
>>> virtually attached devices do not enter suspend.  Note this is currently
>>> limited to the client side (vhci_hcd) only, since the server side
>>> (usbip_host) doesn't implement system suspend prevention.
>>>
>>> Additionally, during the investigation I noticed and fixed a bunch of
>>> coding style issues, hence the subsequent patches contain all the
>>> changes needed to make checkpatch happy for the entire driver.
>>
>> You are doing two major things here, fixing suspend, and cleaning up
>> checkpatch issues.  Please make that two different patch sets as those
>> are not logical things to put together at all.  Work on the suspend
>> issue first, and after that is all done and working, then consider
>> checkpatch cleanups, those are not that important overall :)
> 
> Yeah, the cleanup part ended up larger than initially anticipated, but I
> don't really expect further changes on the fixup side.  I can handle the
> split if another revision would be still required, or would you like me to
> do this regardless?  I've just made a quick test moving the first patch to
> the end of the series and it didn't cause any conflicts, hence there won't 
> be any dependencies between the two patch sets.

This continues to apply cleanly on recent linux-next, hence I'm not sure if
there's still a need to resend as two separate patch sets.

Please let me know how should we move further.

Thanks,
Cristian


