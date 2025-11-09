Return-Path: <linux-kernel+bounces-891759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 975F9C4368E
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 01:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFCC188BB39
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 00:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCF5A944;
	Sun,  9 Nov 2025 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DlVNoBac"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56234D392;
	Sun,  9 Nov 2025 00:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762646602; cv=none; b=u1t1Hz0pxEw1OeuwHad+/iQuO7Alfqn0TVhfUyxsIeG9bdSXXlVKZ9pq8MA+I5tJUeCac7nn6pgS4pCrJxCp5jAZzKmcGwumKDI5kCh+Cv85Z5+8ls8FJn72efshNd9xAqs8X5ydXoXPYOC1CNtnMNTQBBBxWK9Mp4PbiWuc8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762646602; c=relaxed/simple;
	bh=CfClJ40GSxvHuAolF3EfKnGl5IygGs3fM0TmxfJQGQM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kGhOCkrUDplMifagI1aaAgh8zQoqwngjbDTqUke5lqKvuXUGIbH55cF2IdEJL3Hxbm3k4gw2+o3211cls9H7YnNISua0ktYcGXQuzrcMVNr2RXeSW9wYb+fXffddwhVO3OosEevfJBoncepcZO5SR+qD4L6JyBzXZCmJPANrNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DlVNoBac; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9Iotjfk7zBGWmYINvak1u4IZsQhzzsxP73x3RqVXHZ0=; b=DlVNoBacRPtE/tKGvW1O8qKOel
	QQjQ59MIqcS2vlarW55R30v5ebxNoRsIfLIzKXkpyzhffnemcK3ztS8/YsKDxaB5A+brUpiT3WWuL
	Ju66nGpMfSnPY1CCxskioaQ3e0GC2teCnDVzj1KqgGIjkpelC+xPbn330g1F5SLdebs2/q8DYF0Qj
	1HcimQv3xvY1qqYNo7vAyiVJTOw6IZyQZkr283fcYbRDMdVmVocaubcu5AM3OCYqex/wtKe3F/57Q
	02oFLdtYU97Rw/JYItOvzXOQZOF6VNbymdggHLkQ0OM0L6XLQQyJoMR9S/hMyiXqM17243NdkTyjZ
	tWP6BWyw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHstn-00000003aga-3O5j;
	Sun, 09 Nov 2025 00:03:15 +0000
Message-ID: <90db7fc0-5ce5-4ed4-ac33-18910c37d3d7@infradead.org>
Date: Sat, 8 Nov 2025 16:03:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
To: Jonathan Corbet <corbet@lwn.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <87sees73i5.fsf@trenco.lwn.net>
Content-Language: en-US
In-Reply-To: <87sees73i5.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 10:12 AM, Jonathan Corbet wrote:
> [Heads up to Stephen: this change will add a bunch of warnings that had
> been dropped before.]
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
>> When kernel-doc parses the sections for the documentation some errors
>> may occur. In many cases the warning is simply stored to the current
>> "entry" object. However, in the most of such cases this object gets
>> discarded and there is no way for the output engine to even know about
>> that. To avoid that, check if the "entry" is going to be discarded and
>> if there warnings have been collected, issue them to the current logger
>> as is and then flush the "entry". This fixes the problem that original
>> Perl implementation doesn't have.
> 
> I would really like to redo how some of that logging is done, but that
> is an exercise for another day.  For now, I have applied this one,
> thanks.

I think that this patch is causing a (large) problem.

With this patch:
$ make mandocs &>mandocs.out

Without this patch:
$ make mandocs &>mandocsnoas.out

$ wc mandocs.out mandocsnoas.out
  29544  267393 3229456 mandocs.out
  10052   95948 1208101 mandocsnoas.out

so it appears that this patch causes lots of extra output.
Some of that may be what the patch was trying to do, but
with this patch, "mandocs.out" above has lots of duplicated
Warning: lines.

$ sort mandocs.out | uniq > mandocsuq.out
$ wc mandocsuq.out
  18012  167689 1994145 mandocsuq.out

$ grep -c "^Warning:"  mandocs.out mandocsnoas.out  mandocsuq.out 
mandocs.out:25273
mandocsnoas.out:10022
mandocsuq.out:15252


In mandocs.out above (29544 lines), this line:
Warning: ../sound/soc/sprd/sprd-mcdt.h:48 struct member 'dma_chan' not described in 'sprd_mcdt_chan'

is found at lines 7 and 29122.

So maybe the logging output needs to be repaired sooner
than later.

-- 
~Randy


