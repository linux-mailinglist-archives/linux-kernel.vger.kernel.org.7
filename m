Return-Path: <linux-kernel+bounces-808573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A9B501AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446097A6693
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C22641F9;
	Tue,  9 Sep 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXslSKOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10525C81E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432425; cv=none; b=leMka2tR27vmXB1fXw1rKqg+vub947C4q8yuJFn+PQMlmL2IW0X0N1KC7O26fMALgVvKXlDZMnGrkxzyE3/cAg865zdfjd1aRTFLT4qQZEgjuosUPnQao2W0c70o4jkpv51NPg7OY17PxwNfKC1PTqc25xzYT9rY0c39Ggc3is4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432425; c=relaxed/simple;
	bh=J+P+ERGtyQIPqKHoHTRunn1D/v4lU1nzFD4xwAWeJEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NgsrIqx0/YkWVSS+EVQdA2VXi+fR2QYUZ+OtqTA4BxsydavBb+XTH+a710Td5xEfX8z7ErzPZ5s58hHwgqoozYaF+cyEactJwonaNU8Sbi/bnuMrBi+PQTBmaIkmpe6ITrs/R7moUfy2a+nPGqDnybENmglg/oYJ4DGyEx7FkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXslSKOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD52C4CEF4;
	Tue,  9 Sep 2025 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432425;
	bh=J+P+ERGtyQIPqKHoHTRunn1D/v4lU1nzFD4xwAWeJEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YXslSKOpOjN++5UFXUYxNV490+NFjX291NvrK3OsZheHLjV2yS1bWPcGMqzcImcz2
	 NOc8KlRHnla4/PGZ/HqtrTIyv7hdBGYEm7b48WdAgJ1Uoott2Pd9/NHmqISuWWj+Pa
	 HNuOPgSc7Qiy+8mN4a7jIoHWLJosYqgMVgDL2MmHZJslXSv/YI+N6SeCIx9xyPiTAu
	 f5ypmAzDDRNFUD/dg/J9TwOMMHl5bIoIf5ytrhq8p/O4ddYNGX6igaKvDYQlqfAkgy
	 oDKZdeNHzNDHH3w2hgUmQ63xi0GgV2AVgW0tsEmvAKSHsrCWo7Fj5fJk+SfkZCpNUk
	 JgoAWFI0onM2g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Mike Rapoport <rppt@kernel.org>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Thomas =?utf-8?Q?Wei=C3=9Fs?=
 =?utf-8?Q?chuh?=
 <thomas.weissschuh@linutronix.de>,  Chris Li <chrisl@kernel.org>,  Jason
 Miu <jasonmiu@google.com>,  David Matlack <dmatlack@google.com>,  David
 Rientjes <rientjes@google.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] kho: introduce the KHO array
In-Reply-To: <20250909152814.GL789684@nvidia.com>
References: <20250909144426.33274-1-pratyush@kernel.org>
	<20250909144426.33274-2-pratyush@kernel.org>
	<20250909152814.GL789684@nvidia.com>
Date: Tue, 09 Sep 2025 17:40:21 +0200
Message-ID: <mafs0ldmnk522.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jason,

On Tue, Sep 09 2025, Jason Gunthorpe wrote:

> On Tue, Sep 09, 2025 at 04:44:21PM +0200, Pratyush Yadav wrote:
>> The KHO Array is a data structure that behaves like a sparse array of
>> pointers. It is designed to be preserved and restored over Kexec
>> Handover (KHO), and targets only 64-bit platforms. It can store 8-byte
>> aligned pointers. It can also store integers between 0 and LONG_MAX. It
>> supports sparse indices, though it performs best with densely clustered
>> indices.
>
> That is a bit of an understatement, it looks like worst case cost is
> 4k per entry. I would expect better efficiency than this if we are
> serious about supporting sparsity..
>
> I think you need to encode the start pos within the entries in some
> way so worst case cost is bounded to more like 16/24 byte per entry.
>
> For instance if the page was broken up into an array of structs like
>
> struct entries_block {
>   u64 flags:1;
>   u64 num_entries:13
>   u64 pos_increment:50;
>   u64 entries[]; // contiguous pos
> };

Right, good idea. I can look into this. But only if we get an agreement
that this whole idea is worth pursuing. I don't want to waste time on
something that will not make it in at a fundamental level :-)

I think another idea can be run-length encoding to make this even more
efficient. But I have stayed away from that so far since I think that
can get tricky and bug-prone to create and parse.

PS: do you know if bitfield layout is reliable for serialization? Can
different compiler versions move them around? I always thought they can.
If not, I can also use them in memfd code since they make the code
neater.

>
> And if a high 64 bit pos can't be represented with pos_increment then
> you'd have flags = X and entries[0] == pos instead.
>
> Jason

-- 
Regards,
Pratyush Yadav

