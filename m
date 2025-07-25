Return-Path: <linux-kernel+bounces-745192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF43B1165D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A57BBA91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD4922DFB1;
	Fri, 25 Jul 2025 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mKMAT8uD"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04BBE65
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410289; cv=none; b=dfyk1HuMqUQMklw0O8IOVMu4ireQhKEGhs3Pdba23bMk8dOwHmaI0kath/xQZJzRfHT8yAnTCyaKx0TB+7d3xkUJLtHJI47Vqxq+UEh1c/IIkSZmyrL3tgT4O516FfhfjsxkasqLjcY01soHpIoLMAq7XEhM89UtsYY+cIgteFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410289; c=relaxed/simple;
	bh=cIHbjFIi1PRKZshXzUdlbm3m/wTa0RXFskqetX02gaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkEfHulZnG6Ypf9qqnBu5DZvnbfbruWWKNWtd/20MLdFK1jBLJ5eI74M9zWvE1zRlThKLC1Ud+ewaoB0bFsPtfa8x7KGtIQMd8JAeLm4lYV8XdWv4NbGsNiQ8sAfTu3a5aH04LM8H7DcvZgjpadFpu6VrRcZUp2OywmWLqyVZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mKMAT8uD; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3ecb6ed2-dda8-4557-98aa-52de81c47b6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753410284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNha03/xmAX8VYI+r+HiLE7Srno3NMPw0wl2Wi/rdF0=;
	b=mKMAT8uD0YWkxDyRRyxK9ERP+577ubyvtfIDdRuwqtI5M6G+vCuFU2GBI4sFCy/3GPaVBz
	r6GDgfMO/Qa4pqlVjvC7P3nwn9PcdxcRKnt3/000XoHs0FYfteFSn7YSQ9UgWAG2tx9Hvl
	rv03XSca5cvk5EEN/uFRt2LVagTb76A=
Date: Fri, 25 Jul 2025 10:24:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] hung_task: Add detection count to hung task warning
 message
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <ye.liu@linux.dev>
Cc: Ye Liu <liuye@kylinos.cn>, linux-kernel@vger.kernel.org
References: <20250724072326.2031432-1-ye.liu@linux.dev>
 <bdd8f5de-acd5-4c09-b3a4-ec6af54b396c@linux.dev>
 <20250724151035.cc2d421d1b1ed20b89be1917@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250724151035.cc2d421d1b1ed20b89be1917@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/25 06:10, Andrew Morton wrote:
> On Thu, 24 Jul 2025 20:06:52 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> 
>>
>>
>> On 2025/7/24 15:23, Ye Liu wrote:
>>> From: Ye Liu <liuye@kylinos.cn>
>>>
>>> Add [#N] to hung task warnings to show occurrence count.
>>> This helps quickly identify warning order when multiple
>>> messages appear in logs.
>>
>> Hmm... once we have this number, what do we do with it?
> 
> Yes, adding to the changelog a more comprehensive description of the
> use-cases would help get this patch into Linux.

Yep, exactly. Please sell this change to us! A good changelog should
explain not just what the patch does, but why it's necessary ;p

> 
>> While I totally get the desire for a quick reference number, my thinking
>> is that the hung_task_detect_count counter is the intended and more
>> reliable way for users to check.
> 
> But that's what this patch does?  Confused.

I'm just not sure if this quick reference number is something users
actually need, as there doesn't seem to be a strong use-case for it yet.

My point was that actively checking the sysctl is the proper way to get the
total count. But of course, if users genuinely need this inline number, I
have no objection ;)

> 
>> But like I said before, let's see what Andrew thinks ;)
> 
> Andrew thinks it's a pain when the title of a patch is changed!
> Fortunately the changelog had a "Link to v1".

https://lore.kernel.org/lkml/20250721031755.1418556-1-ye.liu@linux.dev/

Thanks,
Lance


