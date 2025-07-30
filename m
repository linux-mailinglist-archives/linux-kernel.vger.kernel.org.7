Return-Path: <linux-kernel+bounces-750829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3FB16186
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9F71AA28AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A7A29A9E4;
	Wed, 30 Jul 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="KpHOo62P"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A962989BF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882072; cv=none; b=dvTqX4Q8ojjfJoNxzxsm2Iga9EzMvlzOFgm5Y9bbtG5XUMxlRUOacAFluUGhaZnELQHAq0drs/IS2to+4cFByNSsEYcTMuK2T+qojIK3c++UL9yZgnr3drqZf0bG0BIxo4Fakbx2pubKFigrQKu5fjWD/a+J5bWajSdtVyUMeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882072; c=relaxed/simple;
	bh=3KhlsfxD1afiXVUFTv0MDo+p5dzoiP4SrD8Q5oUNi40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6oluWRwXNKjyO4NT9AF2wOUt74lcTf15bzlS3tCXm14DT8bkHr96L9nq3yV2dZNoUMzg70YOlDLjUSOA148Ky/3edDbpwLZE5zSmC1Agb850FpdMaKFLTZFxk6PEqe7MSotBVNZ1v6uE5XYuKPDP16MyAYKkBYpvALH5rbAzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=KpHOo62P; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae36e88a5daso1412696366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1753882068; x=1754486868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75YOp4HxyEEORrkg+J0iH+aQiJlUPUOSbZs0eZIgZFI=;
        b=KpHOo62PCC2rNJXNQJNxRK6voenzjlPx4XXUxi62BXzAVuincYa3c2Wwofe2WciXrO
         AjlPvA068vIU5mH2deS3dBwN4ZKeOnjrDkDUPwB2hdOrv4nqeYFi/8u8YkmC+VMfEw5i
         kBQR+DdqUpKX/lFZc5wfcbhgtGMm316eiyw5b1/B3gE9rpDTJ2j3vBx6GhOhq+ltcMr1
         0UXxp1gewF3iKUpmhhmP+1ebb1pmxMPUckwwWZoFkFc0wmls3b8kONMjcyuHB04s7wxD
         nygtGvpgaOlFFNnMAQAamq2iZh5+b+FpfRHVK85weXlleWoouAo6l/G6f9EYHyHxnlvl
         lalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753882068; x=1754486868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75YOp4HxyEEORrkg+J0iH+aQiJlUPUOSbZs0eZIgZFI=;
        b=ia2IphCFn1v6KBmjI85tR7FKEWJhRxtsNcCQaDBrevp45FI836nCaN1loYTUpFGDkd
         Wp0DIwckCfWaMDUGfnlJzx/rpW5C6873vytgAYagxjlQVzFpYBaIdG9CO4da3k/7K37M
         ukiO/uC1lcPRdAkQT+w8I7sADlK/YAayihtJNFrxvcectLxO5hCW8MqtfRtYzZnJ+JpE
         5QsyPCOrTsC5bXAszfBQoUH5+v3QoSQL9Y59bvPbHM8PDJzzugg7x14gGWaLa+zDrAQw
         I+3OIT4vRCQbBGYTOws+m1ztHqvg0Pk6UXXN5slDEJa2PSAbg2/+LDmnfWjMmxWpGufh
         ZhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpq89J3wn0roMN/2emyZfG2ljZJQqxMg2mRdt60L53hcSzU4+U9tOxO97FpRClK8s6zyEArPi8qDfZDu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9/eeYYiscSlxf3hL2cmUGlhD9+FRXAfew2BckLpgOUo+dzlF
	9zGqTCENyr4uPnhwvh0bYy9ChfLxqbWky2iUD54/TxSoWKQU/5sBqfwFYcRoCo+B+ZM=
X-Gm-Gg: ASbGncuTfaA360t7UB6tcHA/Q2hR9gY9Z+GAnmvDu84jV/BM5lUCsljQbVegHh463vH
	xzwNgyQxvi4ZS5O9syts0/V5n4RTpRxqlrTPFKJR+qM3Kw5nd+nuOKiXG7RtXQDRu/6IBwo8DAs
	R9w4VCy8Fyo7gUdKIoUM0LDdsyLV9BNOE7HkDFw/+VDrkwMO70zC27EsEnOC+XU6D0ispoZjQf+
	n0V6RjkmW9mUh8TEMqf9u7GG1hXKV0lz1ZAKlbCij1v72hb8GleH+frKENhdHQ1uzncS2JluE9C
	TdRQ+LSr9Mww71leCiagxj85TafE7YLPe/ht3DzX8vYDlwsdu6fGp4DSwdkTLLDcUGD+SzXeEpO
	OJBGhKsp5BqKCmHMTmGfPWMtpxruDDxkPRMwFVifxTn/IrXyZUmfWOHcJ9W0ExW8+RYiruG8N
X-Google-Smtp-Source: AGHT+IHyHy7GapLEq74VfzWCjhi43qnvQ0e9vbEsRdz+rw2buMQvVQfT6+EDh1DMqSayb4erGZDneQ==
X-Received: by 2002:a17:907:e98b:b0:ae9:c86f:c778 with SMTP id a640c23a62f3a-af8fd96e1c9mr429180766b.30.1753882067956;
        Wed, 30 Jul 2025 06:27:47 -0700 (PDT)
Received: from ?IPV6:2a01:6400:11a:26:d163:a794:aa16:5e2d? ([2a01:6400:11a:26:d163:a794:aa16:5e2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358a2743sm752906766b.48.2025.07.30.06.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:27:47 -0700 (PDT)
Message-ID: <20cc8581-0af2-47b3-9fdd-584ff0ef36ab@sedlak.dev>
Date: Wed, 30 Jul 2025 15:27:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: clk: use the type-state pattern
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Benno Lossin <lossin@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Alexandre Courbot <acourbot@nvidia.com>, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <fc26c393-5c4b-48a8-a7ac-12558f79b140@sedlak.dev>
 <DBP8RFDV59PF.1OV46P0UYKOGM@kernel.org>
 <07575756-58EA-4245-B837-AEC4DDCD0DB5@collabora.com>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <07575756-58EA-4245-B837-AEC4DDCD0DB5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/30/25 2:59 PM, Daniel Almeida wrote:
> […]
> 
>> We essentially would like to have a `#[sealed]` attribute that we can
>> put on a trait to avoid the `mod private { pub trait Sealed }` dance.
>> (so a trait that cannot be implemented outside of the module declaring
>> it)
>>
>> ---
>> Cheers,
>> Benno
> 
> This is not exactly what you said, but how about a declarative macro? e.g.:
> 
> macro_rules! sealed {
>      ($($ty:ident),* $(,)?) => {
>          mod private {
>              pub trait Sealed {}
>              $(impl Sealed for super::$ty {})*
>          }
>          use private::Sealed;
>      };
> }
> 
> sealed!(Unprepared, Prepared, Enabled)
> 
> Note that I am just brainstorming the general idea here, I did not test it yet.

I think that API-wise it would be better to have a proc-macro #[sealed], 
something similar to [1], as it may provide better error messages, when 
used incorrectly. So the outcome could look like.

	#[sealed]
	pub trait ClkState {
	…
	}

And then

	#[sealed]
	impl ClkState for XXX {
	…
	}

If you are interested, I can try to look into that.

Link: https://crates.io/crates/sealed [1]

Thanks!
Daniel


