Return-Path: <linux-kernel+bounces-864217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B63BFA328
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B16B4E99C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A92ECD0F;
	Wed, 22 Oct 2025 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MUtAQiMY"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36B2D8DA8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114037; cv=none; b=qjR3NOBxK/0nZwGVySFzsb7TiqzUmLKl5uJcCgRzR2FZw3u6YsmY/aIjjin/Pm9L3pM2Geyfb5oiyCDwL9uq64aUzxSjdJa9FO/+pP0lcUxUOxynlffGcQSKgMoBupagebtMxNzqraSVAW79eLTVDHW/VaDj5cO/zFb6LG8IZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114037; c=relaxed/simple;
	bh=/SY2P4p5XZZM2qSjLYV/K6G3vvJ2CtTzzLT0uep8k+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYhQ0j7aINO0/iDtDiVdXrWDtWdrep8/Uc3P2OfZNEeMvBNdhcLSEBhirksPxvwNbSWQ6S+WiF6F8P/+zQEpmNlHBIRgL8yuc4NqSmSRIkSgy/ZAVa0noabHJJlfpeSOtJUVH06IgzVjd89bUuqcH9YxUm8u87t9lgb7T+ohlIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MUtAQiMY; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ab0c5257-bbb3-4202-bac8-3e74176fe34c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761114033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xGUMpWlS5ys3I2gYM86ycziVMk+GyFsNzyypjhrbYGw=;
	b=MUtAQiMYKqmCmhCP9Q7CICf7/5jxigvDv1UgTtfRqFsQf91LkfNUkhPHzgdForHgB4CEQd
	vISRBTMd938WDVd5nMoItNdvfbbT2CJ5ZBsGQ9LD53KreOYKXKHlXXJCTEvVjox21Xp0xr
	VDjJ42plJloM8KBpUOONoledtci/moA=
Date: Wed, 22 Oct 2025 14:20:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Lance Yang <lance.yang@linux.dev>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251022055138.375042-1-leon.hwang@linux.dev>
 <49bfd367-bb7e-4680-a859-d6ac500d1334@linux.dev>
 <2025102245-backstage-sprain-76fe@gregkh>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <2025102245-backstage-sprain-76fe@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 22/10/25 14:07, Greg KH wrote:
> On Wed, Oct 22, 2025 at 02:01:26PM +0800, Lance Yang wrote:
>> +Cc: Greg
> 
> I have no context here at all :(

Hi Greg,

This patch fixes a build error in the 6.1.y tree.

The mm selftests failed to build, likely because some patches were
missed during backporting. I believe it's better to fix it directly here.

Thanks,
Leon


