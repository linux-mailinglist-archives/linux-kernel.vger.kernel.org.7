Return-Path: <linux-kernel+bounces-835057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9DABA6280
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECE83B990F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29310235BE8;
	Sat, 27 Sep 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh8CVj6V"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C22223DD0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758997260; cv=none; b=TKEA68HwVQrg2AerWIqO5DaeOtjAaYXCytKv8UzZNmO5gJSkf37xCTpDJQMrycD41CQm9f4IgPH7+RZOBI2j0uNuQL8tMvAz7JoxQ3y5DDiCvzmffrbs3eK8l++z7ehpd3rDyxI6jkw0d0qJI89/jJ+f+IN/s6B3Ib+RflTOZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758997260; c=relaxed/simple;
	bh=ZZsUqsXlT+NxuLRa0wHvGFSehTMZVHpC3xtckn2HDG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVuFzwj6igmakAa1QPpk5Ep4GHiGngMbUR2p9wJ9wZzErUoYlIjZT/U1BktmsrxnJKHiyWmvLVV8DoX121LG3OVQ1aZP0ZlrxDOCzlBjMP0hJGORKe6b+RwSlEaZIA/2kqSUtHWcf1CTMHGuOmtYwtfNtw1GdW+hn2iOkOcmfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh8CVj6V; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso23070955e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758997257; x=1759602057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiTGFZwhz927PRv0PGaGJg7Lawc0Y6HmusWqcFMWBM4=;
        b=jh8CVj6VciDNgdMg7TjOEkX77wode/Z6L/VUCMS9qMBqLQqEqR1MR67B/yEwzE0m4y
         UEmErRoyQH6Eir6z3AW69/0d6/BflBpErrmO5OeF3He5UdKYBc5KJF2rEGcbwudYgjGO
         e07npljPffC59CUgc48OdnPdW0gInNF7XFQ2vgbyV1xvv7TcOOURT0x6aSNHtf9hinXV
         e++HYZqc9S8sMBCUcwU5JpFb2oVwaWIWt77lrUV7V37Dwktnoa61Unlsz0yjNpdYSXd7
         5O6MEBBZaS4MduWYQbuvKs2icRwJ+xwcKCYKHrLKiCqapEnqQAr5c75SPqhFl146xHRM
         2lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758997257; x=1759602057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiTGFZwhz927PRv0PGaGJg7Lawc0Y6HmusWqcFMWBM4=;
        b=N7RvDCUoytxtuUIcCJOKDSK2NUYKZKByXT2xkazGDXvLTkSXmnkZHn1im12PEq5sxa
         UiJHeSQ1iAg07bxII6Nl8+vfDsWawbC0gaLxtxgoEKpf61+hs0wDQzomiuSlLUWEAc2y
         MJFej6lzweYpk4WV/Cx7/Zf8WHc4z/WJWQ4kpWbEompPsBzKBNQSykmKLazj1ZgkVOKf
         idCgaD6S+EYrAbfgT6ThQlKmLiNP9FXWbsfDX+eGlKKcn5jOTbF5s1L7OxdAD6APcv5n
         DEipEah9HO+4FwlI3wotNATrzreheR+wVvaUVlU+tg8UGGB1pBHCdUCLzDfbTAI7S5IR
         cvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXjlVGL0JXyU2MW4eYvjJCgKIfTfqLiFFpZQMzY41TSr7S1z20o50AGwRTKbNTb14335G13yci0kCgaV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ70dxDLVXCzj+kBbsVGVGmh5F90kWjk5pttG2nIjgfILJQcLL
	RNu/4MC5DmPjyShC0gnydf5BGtjJ7jyLyBuQIH1KMrlnv+LS9wiZofcI
X-Gm-Gg: ASbGncviJP3muTHfRQ83MTyl5TuX4k1C87aP78nbnc1aqzdLqOdj8F2gzbyn68jL5wF
	u8KuQBIax2BWT6FE8P+Ll3PIMPR/xO9KZXaAZYWnJrCjwDYovvdxJj6Wfe04cYHafVvAl+bnWag
	q1u0qnjRAYUCYUhXNMDBRg0QDY+d8wgzgLq4CyL9YBLzQdPRETAH8g3ew7qqY09rb2vc1K4gLoh
	lOCKgFWsuZgKkzbxJvZF7rV4WR015Izz54Xo4AjYOPOtpLKf3AS6k7os3kyfKKP/BAnLn7V1XtK
	kVxaiTqLhNqG8UneglsqeSpfOqkvxnFRna9Rlk8LEOkzqnz/YwPhCDA/NHMjoxtN5hQx4LvP6TA
	MzvftFFdWS41gt2X4NTtx6FEhJaYjpaX7zKhQsykq1qn4mnjN9Se5K6SKNmnpuNNAd4h4aZLnV7
	ou4jzWwH7b4TznyBPg0pk=
X-Google-Smtp-Source: AGHT+IEtiFdCtMagiN2PlJIlHgX907vHybIZWjwyy/+2hiQWsMBj67930e8VQK2WHaA903g/oabW4w==
X-Received: by 2002:a05:6000:40df:b0:3ea:c893:95a7 with SMTP id ffacd0b85a97d-40e4adce88amr9868281f8f.31.1758997256826;
        Sat, 27 Sep 2025 11:20:56 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:8b21:7400:a8dc:c580:efa:e675? ([2a02:c7c:8b21:7400:a8dc:c580:efa:e675])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603356sm11601993f8f.30.2025.09.27.11.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 11:20:56 -0700 (PDT)
Message-ID: <10637103-7e15-406a-8e9c-0eee3c5c4922@gmail.com>
Date: Sat, 27 Sep 2025 19:20:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] samples: rust: add Rust I2C sample driver
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Hung <alex.hung@amd.com>,
 Tamir Duberstein <tamird@gmail.com>,
 Xiangfei Ding <dingxiangfei2009@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20250911154717.96637-1-igor.korotin.linux@gmail.com>
 <20250911155048.97364-1-igor.korotin.linux@gmail.com>
 <DCQ9K980YX1W.HZIQI6S5MST9@kernel.org>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <DCQ9K980YX1W.HZIQI6S5MST9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Danilo

On 9/11/2025 9:46 PM, Danilo Krummrich wrote:
> On Thu Sep 11, 2025 at 5:50 PM CEST, Igor Korotin wrote:
>> +// NOTE: The code below is expanded macro module_i2c_driver. It is not used here
>> +//       because we need to manually create an I2C client in `init()`. The macro
>> +//       hides `init()`, so to demo client creation on adapter SAMPLE_I2C_ADAPTER_INDEX
>> +//       we expand it by hand.
>> +type Ops<T> = kernel::i2c::Adapter<T>;
> 
> Not a huge fan of this type alias, but up to you. :)

I literally just unwrapped module_driver! macro to get to the init 
function.
This type was part of that macro. I do not see it necessary, so I'll 
remove it
in the next drop.
  >> +
>> +                i2c::Registration::new(adapter.as_ref(), &BOARD_INFO)
> 
> Does i2c_new_client_device() grab a reference count of the adapter? If not, you
> have to store an ARef<I2cAdapter> within your i2c::Registration as well.

Well, as far as I traced the C code, `adapter->dev` is a 
`client->dev->parent`. Inside of the i2c_new_client_device the new 
created client device is being registered and as part of this 
registration device's parent reference count is being incremented.

A big thanks for the review and comments.

Regards
Igor

