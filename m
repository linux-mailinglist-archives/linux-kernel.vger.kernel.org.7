Return-Path: <linux-kernel+bounces-818082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 313EAB58C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 118864E1ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894A24C076;
	Tue, 16 Sep 2025 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHxiUCsG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3D2DC78E;
	Tue, 16 Sep 2025 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993868; cv=none; b=ku3G4aFkvjDPtid6eZLE1KuwwaX5d49iFVaUypYaKb+bzfrLlgT5VthXpLCYwcbuz/j+j9EBWd+pdeuywW2+Dqj6qVIXzZSThFK+KwAQOOBop6l0eSa3u0SJpGHkR6oYYg23izb3wowWZ314a3N0TAeWQor85TYzI4B4y13PiR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993868; c=relaxed/simple;
	bh=DnwM+DNIezG6uRTSjV7Xuwxap01opZOQvveqLeHwhSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1cpGHKoQ0gZWkkVWmh66FHDLcFDyGly6ni3KpsZHUaJ1LzNtCGwnNcEfeRgmo7XGpaXXcBU94T/v8trxbQznXgk1NQxdUIpUOmVeMi2kKpsEHzfC38g5Ko6kF/Iwvx9JtRDlvwftVReTNJZVvRmM/Xr8aqBWY8ms3ccRZjlVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BHxiUCsG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=SHXVcB+MgSUzgb/L1IQrcZLOr0QNwhlIqJqUrwYWeO4=; b=BHxiUCsGkhz9h2MCiKe/6rfi4f
	9ocEA7IgI0qGOI7u5kbNalRUV4ikPE/99AD4hKAhlb5QLuANIxMulKo4J5u917QHU7s9mCYocHOpH
	4LG5mCXMusxDSV/A6f6y+Sw3E5L6yVfO54TkYu64UTI7iUwpvfCZr8i5gz09StGOk4WggGvflHmvb
	VSdksX9CVv0S3ExapoAEsognAW3OyrXRrcBRvz4w18xymYkT+dSezDpNdvRgEbqjUBroCPb3PkCwF
	lA7ghjKyot10FNHgK+pWOrKnkwfLycZZ/l4gOblCUc4C9KlgDjZo0hpvts78+r2vHqYdtBJ+tuTnH
	7kHBPNyA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyMVh-00000006bqf-2j4o;
	Tue, 16 Sep 2025 03:37:41 +0000
Message-ID: <6a2f324d-5be3-48d4-a787-2c3bc76a56ad@infradead.org>
Date: Mon, 15 Sep 2025 20:37:40 -0700
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
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>
References: <20250915192235.2414746-2-thorsten.blum@linux.dev>
 <c85881bd-a159-4bb3-9615-b87ce4ab0575@infradead.org>
 <E32E7460-02E4-4E85-8482-E91D3FD12253@linux.dev>
 <8a9b2f36-963a-4d10-9aa1-10f8dcb4bc31@infradead.org>
 <DBCAF005-F4C6-44D2-8DB3-71B002501770@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <DBCAF005-F4C6-44D2-8DB3-71B002501770@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/15/25 1:06 PM, Thorsten Blum wrote:
> On 15. Sep 2025, at 21:43, Randy Dunlap wrote:
>> On 9/15/25 12:35 PM, Thorsten Blum wrote:
>>>
>>> On 15. Sep 2025, at 21:29, Randy Dunlap wrote:
>>>> On 9/15/25 12:22 PM, Thorsten Blum wrote:
>>>>> The sentence starts at the previous line: s/Indicate/indicate/
>>>>
>>>> Are you sure?
>>>> ISTM that the entire line is a "sub-heading".
>>
>> After I sent this I saw that I should have added that it's ambiguous
>> and needs some formatting help, so I'm not surprised to see this:
>>
>>> Hm maybe, but then the layout/rendering on the web is very confusing:
>>>
>>> https://docs.kernel.org/maintainer/maintainer-entry-profile.html#key-cycle-dates
> 
> I think the entire line is meant to be a sub-heading. If it were a
> single sentence, it should be either "Deadline ... indicates" or
> "Deadlines ... indicate", but not "Deadline ... indicate".
> 
> Maybe the author of 4699c504e603 (cc Dan Williams) can confirm this?

I think all that is needed is a blank line after each of these sub-headings.
That makes the html output readable and more understandable.
Would you submit that patch, Thorsten?

thanks.
-- 
~Randy


