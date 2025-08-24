Return-Path: <linux-kernel+bounces-783449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A8B32DC5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5395A3B110B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D289E238D57;
	Sun, 24 Aug 2025 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fqUNVMjB"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E92376FD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756016360; cv=none; b=K8Bdsub8zqXjz679vg1WyAg7RSBL1WEoY8WPHbkQbV3foA1ZPPAJ/zfcT687gd4ipcrSmjg9S78bSXhAHzCvctBxIN+D7SG8dREfU49+iB5/ANxmR5wVGgqu2oCFzPlR7edjZJnN3iju1yqSKnZWSnFAfEOem92uZlVpLQhcr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756016360; c=relaxed/simple;
	bh=aWnyWpVpmRA/TEM+DQ7lGMG2JKN9gC4jy/Tey7yqi/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BylhNcttB4ni4aY5IRIZCA6yU/e2y4Va+m36OxizWZPeAHn8ZTVp2mw+Rc9FOSMT1aEyy6ngp6U5hUj3beKZkDSa2E97D7r4d03OIXKBoxaWuBdfsZXdaqGPDpW+XB6JwfUFpa5GOkrj7yxlyymQUAGkxFNKmh3MLN/3Jv+4Fuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fqUNVMjB; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ff7bea5-185f-458e-9ae6-ddfcbdf29b7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756016345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CtR68zd6ECJ7fn6f8w4WpB+86/yimlas3RqjC+/LWmE=;
	b=fqUNVMjB/ldRGKboFELsCAzgHYfRi0z7xgldfRbeiF6BFiae3y2YnCI+WLeYMvnoEBO1ck
	4jMFgdz8hf69BIVgaPvqFL6iCfhjWZmPwmoounV88RdMJoHF4xoaxR22415zt9MJLhwRMY
	EJ4oE5hdL1fBjtmkbSKsqo8pg36mzAA=
Date: Sun, 24 Aug 2025 14:18:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on
 lock structures
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>
Cc: akpm@linux-foundation.org, mhiramat@kernel.org,
 kernel test robot <lkp@intel.com>, geert@linux-m68k.org,
 senozhatsky@chromium.org, oe-kbuild-all@lists.linux.dev,
 amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com,
 ioworker0@gmail.com, joel.granados@kernel.org, jstultz@google.com,
 kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 longman@redhat.com, mingo@redhat.com, mingzhe.yang@ly.com,
 oak@helsinkinet.fi, rostedt@goodmis.org, tfiga@chromium.org,
 will@kernel.org, stable@vger.kernel.org
References: <20250823074048.92498-1-lance.yang@linux.dev>
 <202508240539.ARmC1Umu-lkp@intel.com>
 <29f4f58e-2f14-99c8-3899-3b0be79382c2@linux-m68k.org>
 <9efaadc9-7f96-435e-9711-7f2ce96a820a@linux.dev>
 <a70ad7be-390f-2a2c-c920-5064cabe2b36@linux-m68k.org>
 <e27b6484-8fb9-4c7f-9c8f-4d583cb64781@linux.dev>
 <0e0d52b4-8c69-9774-c69d-579985c0f0ee@linux-m68k.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <0e0d52b4-8c69-9774-c69d-579985c0f0ee@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/24 13:57, Finn Thain wrote:
> 
> On Sun, 24 Aug 2025, Lance Yang wrote:
> 
>>
>> The blocker tracking mechanism operates on pointers to higher-level
>> locks (like struct mutex), as that is what is stored in the
>> task_struct->blocker field. It does not operate on the lower-level
>> arch_spinlock_t inside it.
>>
> 
> Perhaps you are aware that the minimum alignment of the struct is at least
> the minimum alignment of the first member. I believe that the reason why

Yes, that's how it should work in theory.

> the lock is always the first member is that misaligned accesses would harm
> performance.
> 
> I really don't know why you want to argue about fixing this.

Okay, arguing further isn't productive. Looking forward to seeing
your patch ;)

Thanks,
Lance


