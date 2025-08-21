Return-Path: <linux-kernel+bounces-780064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A85B2FD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AFE627A93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398A2EDD65;
	Thu, 21 Aug 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC7F2tmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DA7263A;
	Thu, 21 Aug 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786765; cv=none; b=VVRttp4HWFOLx6tMoGbMrJiv0T9h50YsVbAg4ie9qaWLhROFaf7e6LZf0UD+XAR2a3ygiKfzCyDMVoZGgGttisuEcNcFlNy88+IE2RNMkWcG7hy91ovwwsyQAnDZP1gir1WjKHRoboJfLJ/7eUIyyomSwoqz20Xkb/pXzd6d/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786765; c=relaxed/simple;
	bh=OcH92vAjTX0+vo5BSHLDcFy1Wdx4BKrILtb6alAg2ws=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dMqzMCU+Uoqormu5Prj6+No81FPftTM81S9F5uW1FgjzGOn4i4IJvJMf7cVWxMIBykd1kvwkT62CGuF0QtGEaIFtvSEuGXb5RSxUSZSu7pM86lYdIyHkcOqUA2q+u1Uuwu6s2Y/np6tgfLXmAqRj1c8ZZo96cjPiGcBJbYU2BiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC7F2tmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E21C4CEEB;
	Thu, 21 Aug 2025 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786765;
	bh=OcH92vAjTX0+vo5BSHLDcFy1Wdx4BKrILtb6alAg2ws=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=LC7F2tmGYn/sJkAKGyEaQ5akRdZS8hmzcoB1z+V8Vy3Jduel7MgAM8YiuTjwxVA5c
	 UL5w/1VDFi2AKRlgnhbg6yCU3QjbhkyBLyr1SnkWut2usA3FoKIBHZZoELQdeyIbDf
	 x/9x1HboPymNqvzNvkLb5wZ/Dof8lPnv9+9orc+CuKq2PJya+0wDaxS+viBn0vzZm4
	 ZtGTBTVbg4EF3m8LhVwTNnb2YebjfTtfV4WguUOHJ0IADl/6VQ7moTcSb3Sqx4oN4Y
	 QTOpO4MYs6ikMQcxsc9F032OYRrRZi+OBJl1gs3JcKQmhPyMB66pW9Pf89C/0QhJij
	 lpkKytxdldIcw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Aug 2025 16:32:39 +0200
Message-Id: <DC86GM7VK8PH.QYLPP2SLYM3M@kernel.org>
Subject: Re: [PATCH v2] rust: zpool: add abstraction for zpool drivers
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>, "Johannes Weiner" <hannes@cmpxchg.org>, "Yosry Ahmed"
 <yosry.ahmed@linux.dev>, "Nhat Pham" <nphamcs@gmail.com>,
 <linux-mm@kvack.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250821111718.512936-1-vitaly.wool@konsulko.se>
 <DC83A2M3G8EH.12FRM3C05ABCR@kernel.org>
 <DC83WSYHY3K1.1D3XEES0BIKGS@kernel.org>
 <27139676-8470-4067-b259-f01022751bbc@konsulko.se>
In-Reply-To: <27139676-8470-4067-b259-f01022751bbc@konsulko.se>

On Thu Aug 21, 2025 at 4:15 PM CEST, Vitaly Wool wrote:
>
>
> On 8/21/25 14:32, Danilo Krummrich wrote:
>> On Thu Aug 21, 2025 at 2:03 PM CEST, Danilo Krummrich wrote:
>>> On Thu Aug 21, 2025 at 1:17 PM CEST, Vitaly Wool wrote:
>>>> +    /// preferred NUMA node `nid`. If the allocation is successful, a=
n opaque handle is returned.
>>>> +    fn malloc(
>>>> +        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
>>>> +        size: usize,
>>>> +        gfp: Flags,
>>>> +        nid: NumaNode,
>>>> +    ) -> Result<usize>;
>>>
>>> I still think we need a proper type representation of a zpool handle th=
at
>>> guarantees validity and manages its lifetime.
>>>
>>> For instance, what prevents a caller from calling write() with a random=
 handle?
>>>
>>> Looking at zsmalloc(), if I call write() with a random number, I will m=
ost
>>> likely oops the kernel. This is not acceptable for safe APIs.
>>>
>>> Alternatively, all those trait functions have to be unsafe, which would=
 be very
>>> unfortunate.
>>=20
>> I just noticed that I confused something here. :)
>>=20
>> So, for the backend driver this trait is obviously fine, since you have =
to implement
>> the C ops -- sorry for the confusion.
>>=20
>> However, you still have to mark all functions except alloc() and total_p=
ages()
>> as unsafe and document and justify the corresponding safety requirements=
.
>
> How is destroy() different from alloc() in terms of safety? I believe=20
> it's only free, read_{begin|end}, write that should be marked as unsafe.

destroy() should be fine.

