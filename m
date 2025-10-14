Return-Path: <linux-kernel+bounces-852692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C10BD9A24
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96A34501CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08B315794;
	Tue, 14 Oct 2025 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9+NifUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147E315D45;
	Tue, 14 Oct 2025 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447444; cv=none; b=jxVSKkd6U6fM+7W9J/i8v3xa37YaaYxa0eDb2pB4Vdz0wyC7MmAKWfx1UtkD6+J4kfaLLusIgrzWRPELST9JZjTE86H3YIl1umKifrvzmYvREv0pKNtsQBXeijFVZVsojz+bTmT9ABkftwoLux0iSyTHjx409olThNmSmyixny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447444; c=relaxed/simple;
	bh=1z29qiTz6h5jyAO8g68bo34GcYPLqTUSe9I3ydJUTw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZeLDS5Q/1ITttVT6k7/wzoBeMFTa2v83OhwUsPaUmvFUoGcxmj7YQJkjO/32245HWxVnn7Bn0AthYCIjyWBn3pVFIYBkCFMgwkP9KFkpC3tGh1Qtht4v294JD1xDIa6iTmItHgMUk2RttBVEKdtskFTlEwwnpyK8X+NCewsLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9+NifUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8533FC4CEE7;
	Tue, 14 Oct 2025 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760447443;
	bh=1z29qiTz6h5jyAO8g68bo34GcYPLqTUSe9I3ydJUTw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g9+NifUwXszKwI+i9b+BADg9CHX9pjgCw2mu/yxA+73glB/SfRpvhpeMLwX+7zeg9
	 cpZyrZdbl6zsMX+Wo90KkdV6hDFv+HpHH+GKnixUqPtsiiuipRTYlBSA+RFLrU6AdF
	 z8MA7ZC0dDyvXrecjZhU8nlLLfZCLEsyyqROyne29Obt+UqzwZBF2jT+f8QUD3imN0
	 gQ5aZfRz1OgEk0IJVCMTbI4VrsIEPNPKNZutUFVMj6TdGeXxePJsX5/R68ibLC+6iv
	 jZYvfqrXGK5MchNQMt25O838FaWOmrFURP+ZyNfLcRWE1zF4CmsEn6AFbRAtwXlHBn
	 SOQ76mXQJoW1Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Changyuan Lyu
 <changyuanl@google.com>,  rppt@kernel.org,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  anthony.yznaga@oracle.com,  arnd@arndb.de,
  ashish.kalra@amd.com,  benh@kernel.crashing.org,  bp@alien8.de,
  catalin.marinas@arm.com,  corbet@lwn.net,  dave.hansen@linux.intel.com,
  devicetree@vger.kernel.org,  dwmw2@infradead.org,  ebiederm@xmission.com,
  graf@amazon.com,  hpa@zytor.com,  jgowans@amazon.com,
  kexec@lists.infradead.org,  krzk@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  luto@kernel.org,  mark.rutland@arm.com,
  mingo@redhat.com,  pasha.tatashin@soleen.com,  pbonzini@redhat.com,
  peterz@infradead.org,  robh@kernel.org,  rostedt@goodmis.org,
  saravanak@google.com,  skinsburskii@linux.microsoft.com,
  tglx@linutronix.de,  thomas.lendacky@amd.com,  will@kernel.org,
  x86@kernel.org
Subject: Re: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
In-Reply-To: <2ege2jfbevtunhxsnutbzde7cqwgu5qbj4bbuw2umw7ke7ogcn@5wtskk4exzsi>
	(Breno Leitao's message of "Tue, 14 Oct 2025 01:34:07 -0700")
References: <20250509074635.3187114-1-changyuanl@google.com>
	<20250509074635.3187114-2-changyuanl@google.com>
	<ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
	<mafs0wm4yluej.fsf@kernel.org> <mafs0h5w2lpqu.fsf@kernel.org>
	<2ege2jfbevtunhxsnutbzde7cqwgu5qbj4bbuw2umw7ke7ogcn@5wtskk4exzsi>
Date: Tue, 14 Oct 2025 15:10:37 +0200
Message-ID: <mafs0cy6pljci.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 14 2025, Breno Leitao wrote:

> Hello Pratyush,
>
> On Mon, Oct 13, 2025 at 06:40:09PM +0200, Pratyush Yadav wrote:
>> On Mon, Oct 13 2025, Pratyush Yadav wrote:
>> >
>> > I suppose this would be useful. I think enabling memblock debug prints
>> > would also be helpful (using the "memblock=debug" commandline parameter)
>> > if it doesn't impact your production environment too much.
>> 
>> Actually, I think "memblock=debug" is going to be the more useful thing
>> since it would also show what function allocated the overlapping range
>> and the flags it was allocated with.
>> 
>> On my qemu VM with KVM, this results in around 70 prints from memblock.
>> So it adds a bit of extra prints but nothing that should be too
>> disrupting I think. Plus, only at boot so the worst thing you get is
>> slightly slower boot times.
>
> Unfortunately this issue is happening on production systems, and I don't
> have an easy way to reproduce it _yet_.
>
> At the same time, "memblock=debug" has two problems:
>
>  1) It slows the boot time as you suggested. Boot time at large
>     environments is SUPER critical and time sensitive. It is a bit
>     weird, but it is common for machines in production to kexec
>     _thousands_ of times, and kexecing is considered downtime.

I don't know if it would make a real enough difference on boot times,
only that it should theoretically affect it, mainly if you are using
serial for dmesg logs. Anyway, that's your production environment so you
know best.

>
>     This would be useful if I find some hosts getting this issue, and
>     then I can easily enable the extra information to collect what
>     I need, but, this didn't pan out because the hosts I got
>     `memblock=debug` didn't collaborate.
>
>  2) "memblock=debug" is verbose for all cases, which also not necessary
>     the desired behaviour. I am more interested in only being verbose
>     when there is a known problem.
>
> That said, my suggestion is to only dump extra information when something goes
> wrong, not affecting the boot time neither boot verbosity.
>

With your proposed change, we only know what the overlapping area is,
but not who allocated it. I don't see how that can be done when the
error is detected. memblock debug lets us know that, which is why I
suggested it.

-- 
Regards,
Pratyush Yadav

