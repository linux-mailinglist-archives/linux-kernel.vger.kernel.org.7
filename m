Return-Path: <linux-kernel+bounces-833044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9948BA114D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A221711E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CADB31AF33;
	Thu, 25 Sep 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="VL0Rnr3C";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Gge1mCn7"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA7319877
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826364; cv=none; b=XKy4XcuwDt2xpNfmWhkZfsevulAb6phOJvSM7X6SJcCkmova9h2Uw6tvnGNt7JA2xADfse1RWHi5tKogbSMtLNw+R9UI4HvezuRciS/F0L6AEMRuhuZFJKy9GIykMhE3lNPgdvQrTRYPjz/QKRMI9DRyQeYkb+JkCjtWaRRKV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826364; c=relaxed/simple;
	bh=py1R90auHUwRZcLSo/U4sqM+Pp8Fv3SpehMlnxzLw/4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=MEDHRTFhl01gu2eWNI6hj6KCuGsm1vvFv5Hy3nieV6S00NLw470K6xn5Yz7z8OuYqIe8b1HipOfWzRhBtxXch5Jj2aWt+ArQlG9wrZAf2W0mCHER0D5Wo0qfj0//mipBRSdNPA6j6+noBRQmN0SBwX76I4f9Ru5L8Bvhv3oHN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=VL0Rnr3C; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Gge1mCn7; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=VL0Rnr3CT252ggiJajFl+wGy782COuKaCRn+M0Vx1ghE9d/7xxu3IyiO8W/Ir4CDeA32xB4C/vrzXsoxs77br6fib1WuFh+vNRj+y5lJLlUSlM7HRyb88WufKm4cazfNv5+9Sviocbw6NNuCJApMqGUlhwPX7i8N0oCzOddGxzquwRy8qfeT7NAxePZzqNV3W6ueRfWdvcnB2HYvkuQL4oeec+9dIcvi0ITBI0WGFieHGkDRi06mM13HtMaBx2HI6VzyDJMkLEJAIzhgpZklAiekRxeiYA+7GgsvG+SmE29MNE1CiljMx1y/KEfas2XtAUAM4qNI++Zar5V8gnLO7g==; s=purelymail2; d=elijahs.space; v=1; bh=py1R90auHUwRZcLSo/U4sqM+Pp8Fv3SpehMlnxzLw/4=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=Gge1mCn7UZnkjPpZQQY2BEihVNsQPCQVv8hJTjwZAahrf9Hw2bQTq3FnnXMZbyILiTqnV1J9SE8eEZJxZqbyianaOJ8oiwoHjkM/7nebnSy3gy1IHh5WF5pt6WydZrqRLFaqt6Da4ToRWfxVLGi/1uMmxvTbmWS5WbQiBJcJueNnplPhaXOXsOrJNFQDqO8uefITIGF0yZ/1ieL6GICKf1ItUrTQvw0D5mj1W8sHC11uw2/cIPK02Rpd3/uA0tM4lqIFdEdK7B87MaZau0TF/2hmtsP0F3bJ+PTkGaT8+0bG0YxrT44bY54tdf0CLvLCPBP0vGWp3ePE0Y8wLQxLcw==; s=purelymail2; d=purelymail.com; v=1; bh=py1R90auHUwRZcLSo/U4sqM+Pp8Fv3SpehMlnxzLw/4=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 26912:4866:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -567714660;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 25 Sep 2025 18:52:20 +0000 (UTC)
Message-ID: <bacf0774-2128-43e8-92cf-6754fb554824@elijahs.space>
Date: Thu, 25 Sep 2025 11:52:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: slab: add basic slab module
From: Elijah <me@elijahs.space>
To: Danilo Krummrich <dakr@kernel.org>
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <73d7d53f-439b-44a9-98ca-0b1c8fbc1661@elijahs.space>
 <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
 <6e9c820f-070b-409e-ac25-af96b8b962c6@elijahs.space>
 <DD234804U7YK.3S2MBUJSFHF8J@kernel.org>
 <74b3ef24-a307-4d3c-891a-8c5283448b20@elijahs.space>
Content-Language: en-US
Cc: Elijah Wright <git@elijahs.space>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org
In-Reply-To: <74b3ef24-a307-4d3c-891a-8c5283448b20@elijahs.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/2025 11:51 AM, Elijah wrote:
> On 9/25/2025 11:15 AM, Danilo Krummrich wrote:
>> What are the other complex issues you are referring to?
> 
> I think I misunderstood what was involved for (4). I was thinking of 
> keeping the extra reference in the object but I think it can be done per 
> CPU. I'm not totally sure how much would be changed in the kernel but no 
> matter the implementation for (4) there will be some complexity
> 
>> I'm not sold on duplicating the Box code just yet. What issues are you 
>> referring
>> to?
> 
> mainly where the cache isn't static. if you have kmem accounting enabled 
> and a ZST that encodes the original cache's address then that would 
> break, unless I'm misunderstanding (3), but that's just an example. I'm 
> just thinking of potential code in the kernel now


