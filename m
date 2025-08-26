Return-Path: <linux-kernel+bounces-786563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC9B35CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB367C51D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAE322A1E;
	Tue, 26 Aug 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8fCMfel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572528689B;
	Tue, 26 Aug 2025 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208249; cv=none; b=droIAfB3CREyzG4j+iU9kBFYpF/Nvlb4silSHiaHBn0SBYf9f96/ZaHqAnrqjWO6GT+XAqnxevRsSRqWJOrS5dadnXZ6nfz136Yodsni5OfWuDFRcuuEHHaZIS5tJtH6nvcD+p3y4fAzNShjqnVECnhG33SZyoVfloJ69FDB0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208249; c=relaxed/simple;
	bh=vhWjhyKOSmj/KSb4vVuq3nWGsNJx3May1+qso60gS6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3P+EP6b4iYahCK1Gc8yKkahUZiUQSIRmwgSo2EUcVb4GaoOWTsdvltnf56HYfIswu7UpwZrFk5j6N+D1I303MD961xVWJJqYlp3r+38XOpvbrREOcul54Gok616ZhXLdv4bnyvtvWLQlGYLAyft1QL8kJavJs7IMtHeE73DcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8fCMfel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E71C4CEF4;
	Tue, 26 Aug 2025 11:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756208248;
	bh=vhWjhyKOSmj/KSb4vVuq3nWGsNJx3May1+qso60gS6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I8fCMfelHs9mSQNbu4YTz9BqD96m9DiXDcbKvk7FTw9tQfzL9C0S2WSqEkz4a2PWd
	 mt9YODmsey6WwpBL19wz6uXG52cRDDh7iAl7jfup7oWYAETN35SiNa51evaRbGzBGA
	 T8NbZC+yDDlVQ7NYi6ybEo6qFjiRT9kGUep3g7Osj5DL0XrlDGrS1yJy7xtUpYeRhH
	 Vtuk+fW45WPtxweHlWV50b3eZ/y+5JJaQ/xi+d6SbqUbVy2IzAWoUrzgftvyTXsBUH
	 adeJc58LogdlkKGJjXSlXZ9G9hjguNwWvP8guQ9tH+DhYE0OwmXn1FtkAtUzkGPYuO
	 StSPKIVP+gh6w==
Message-ID: <9179276d-275a-49fd-8697-82283fea4bfb@kernel.org>
Date: Tue, 26 Aug 2025 13:37:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] rust: zpool: add abstraction for zpool drivers
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <CANiq72kQv9nJYyiuHvTdaJs2SvZ_bFAnexoEBgjb0CDzPjBTYQ@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CANiq72kQv9nJYyiuHvTdaJs2SvZ_bFAnexoEBgjb0CDzPjBTYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/26/25 12:43 PM, Miguel Ojeda wrote:
> On Sat, Aug 23, 2025 at 3:04 PM Vitaly Wool <vitaly.wool@konsulko.se> wrote:
>>
>> This patch provides the interface to use Zpool in Rust kernel code,
>> thus enabling Rust implementations of Zpool allocators for Zswap.
> 
> In v1 the usual use case question was asked -- could we get some more
> details in the cover letter or ideally in the patch itself?
> 
>>   bindings/bindings_helper.h |    1
>>   helpers/helpers.c          |    1
>>   helpers/zpool.c            |    6 +
>>   kernel/alloc.rs            |    5
>>   kernel/lib.rs              |    2
>>   kernel/zpool.rs            |  338 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Should a `MAINTAINERS` change be added? Was maintenance in general discussed?

@Alice: I assume this should go under the Rust MM entry?

