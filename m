Return-Path: <linux-kernel+bounces-887118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FAAC37523
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B5B3AC543
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C7291C3F;
	Wed,  5 Nov 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GceYcRrU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413227FB21;
	Wed,  5 Nov 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367389; cv=none; b=IIhabTJ7Hkc3XeMT9oLihoT+k579QsBpW4QkwxH7TJjIKVaFL/Mi/vwuxot9VMmzgYxP3nXiRRtPB+j7GpYu3Mn7cpopZzJzKXf2QpioAHbraOI6m6fXY+NkQMpVyZItQMmnvHOLx7g/DHUQx1FSqEWTOfeUO5J8lo7PWbc5n+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367389; c=relaxed/simple;
	bh=OpM8Xif6DGVMY6CLUVbXdGI8wP3YtVjrHoBLxN1UFLI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3mmJk/J67C4MYWfbheILFKPoYCfCYLL3VGfCmhhiJZ1+ZMJZ4kj/dGcI7TnHzW7nkODBhqORr2tjccKS9oAkigHYPSLfy05+wYOiE/Ne7nstcEYADNhTPmxRDLuyifNNXe4FWVhV8QeaD7AwYjNjd04Mg/85Xm8vZd05oPfrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GceYcRrU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 92BE840C2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762367387; bh=S/TeqikExD8uWgrzEF36syodhjADFZ8CnsLO5vNjOM4=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=GceYcRrUTa49a0sjT9AyycZ6b5aAkOpizHyJRkJ6AlbymBs/zQT/p2dkc9+16yDAR
	 mvsVMcYo5HnqHU5IGjuslddj+IxMAKaFUR6rXqKWMXUCuePuz09nMyu0FuA8tBvVBw
	 dcxZvgRtnNbr3SPjyPGZh0/LeJsZUNepmsUCINqNxz1de1pBqx8jJ7TmDJIAp1NmK1
	 GyygWQhILFNhw0rlYKXWDsJpX8m9Cx5wSi9okJlF34o/GScshusnVA7azPRvFDbko/
	 8rl+cqPw4K1RrUixPUzSsptkaPc4Hrj7lUDvtnKUZL3JECu9sGcmtn1fwj2qdgnSMb
	 5zROpPS87TGhA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 92BE840C2F;
	Wed,  5 Nov 2025 18:29:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jacob Keller <jacob.e.keller@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: pldmfw: Demote library overview section
In-Reply-To: <39096776-9b98-4e09-a008-d8d9620433dd@intel.com>
References: <20251103030228.23851-1-bagasdotme@gmail.com>
 <33ce66c4-d128-41d5-9e26-aabb7e80aa67@infradead.org>
 <39096776-9b98-4e09-a008-d8d9620433dd@intel.com>
Date: Wed, 05 Nov 2025 11:29:46 -0700
Message-ID: <87346s72p1.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> On 11/2/2025 9:09 PM, Randy Dunlap wrote:
>> 
>> 
>> On 11/2/25 7:02 PM, Bagas Sanjaya wrote:
>>> pldmfw library overview section is formatted as title heading (the
>>> second title of index.rst), making it listed in driver-api toctree.
>>>
>>> Demote the section.
>>>
>>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> 
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> 
>> Thanks.
>
> Acked-by: Jacob Keller <jacob.e.keller@intel.com>
>
> libpldm doesn't have its own tree at present, and most updates typically
> have gone through netdev. However, I think this makes the most sense to
> be taken through docs tree, since it doesn't impact any code.

OK I have applied it, thanks.

jon

