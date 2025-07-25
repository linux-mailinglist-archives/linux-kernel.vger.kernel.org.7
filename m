Return-Path: <linux-kernel+bounces-745773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A049B11E58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72673AAEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06D12472B9;
	Fri, 25 Jul 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOTYUv2m"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC8246BC7;
	Fri, 25 Jul 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446046; cv=none; b=GPEOMnkajtRNHcUWG6dA+WV/fUlD9kZCGcwV5vvp/C/pU6NU2YWKlzA7Rutrzf5nN3pPwlgP1ikKHL0dkk2xtbWlZr7VIIK5SnT+4/+gveNcdboLiMZx0EmFy4r0c0r/LtKXpBqNbQmbEzTqdEKdq3r81iXYSe+HJzGHQA6vBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446046; c=relaxed/simple;
	bh=1Cp7zc6lqPvU29V2fbv1NcFYqTlUMGp8N+HlDjlY+jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gs0zQyGVsN1fvylnY11UNlljYDO8eLhabQMdvMr4IcPAglbalKW02ObY5NrVHGHQOUKp6mNbl3mihMQVf2LcnZ0jjzdW7a0JgHTcRoq+e5653D5jOhdWWw14AMgyt+0sySloqO1SV+xyNe+An6pHv8rbN5M2HfcILwL1KFGQOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOTYUv2m; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so20881545e9.0;
        Fri, 25 Jul 2025 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446043; x=1754050843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VA1aVk5ATgGwWP5YvZwY73Pqu6/2aciSmLuZYBAcU5o=;
        b=FOTYUv2mTCGrzaxYBRYfR7g3m0poAUIJduXfw9ZqR8JSahWDMrMz+CR3QIRHUTvgH8
         PRKMWwpFSMtv2htt+fQ7IL1WqArlHiUOpTW0RJ0WiyKo0FTQHlY/uEbVV1h+jEBW9qbL
         zwoqCYv+qYBdIngC17MJsMJRazEGqq13ShymFlnbgkJzIh1s4h40FdPvLc1pOicRdKm1
         8KxE2haCLNa7aa1hVXsCYFZ8VTrSwmmly2urLsYz4aUCZ6JbiUnPm63UJIesO5XASaN6
         6De7WW/uln/ri3/lWgU6+hZf7gZ3d3iSlNL4+Kw3SbLJf66t9xAIBn2kThKDYRiQ7rmr
         4ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446043; x=1754050843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VA1aVk5ATgGwWP5YvZwY73Pqu6/2aciSmLuZYBAcU5o=;
        b=E9TEgbwb1HaXB/vM+iJFDthj5/RoB+bE536leL4mBWtXpviDwBXxgVesAX4RkV7zr3
         MjZC2iJtARr5IhWVoa9EylcMFYuBGMgUd7e5Ea0dO1YQuOWYcdT1IwExIlnxOhNHtHF3
         ImwGOuDUvda/68nAUKfC+igq89YraOoJ7Ht3BnaaqpfTHRbALCLOMl3cpQ/NOsSLM9mc
         ql0lKy46zWVQZ2ropl0CJZGZYh3zVfO6WEGCgpJZukjWKraRe8Z/2Ev+cl9+qJBblC3x
         5AAfhzFj0qGjHc/IWDTndNo43LXhJBqFakpbzshm57FHg9vG2/sQ0/yiNWrf4aatFl2d
         fTYw==
X-Forwarded-Encrypted: i=1; AJvYcCXYivzv4vVz+D0ewu8qyikloKLTJxt3kjQUCkfmt4tS2J9J2/enqmnp+vQfPBbRz4a8gNj2Cyka+FhRCLQ=@vger.kernel.org, AJvYcCXoZSyPCYIlw1EbmKMfJxuunAzo4WZhI8Cktno7x2nNpkNn79AGcZ/P1Jj7BlohIRovsy5c/gnbySHIGSOA6gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfCMD/VmPcA2RLv0I9S4eTSodZoIlSaR6vm/FHMpIflMAH8oi
	KgfNyE4ThW9hJxJkCIrjUKB2saOt+TbVoeD+2aScA6/SovJcz1kIRxp4
X-Gm-Gg: ASbGncvumY8w17xhuHT50lFc0GLpj1aNhBChQ02M9Il0SZQc6o5fGthkd9t2egvY0CJ
	hagfT/5MQ+BhS3rJEv3wLv/LsgAMt1GC5QAjn0owpG2Sy0ivtCd5Plsm6DTZGt0m32P8L88pyuI
	w8uoln3655EWQ5aGjxTJ5IIJmQecV4No2yuksTEIbqpggKeTFTsJucPbu9aFqjfihJzyyafCx2O
	ran/fSbOFCUc9sIc+SQo3LD3xaTtDOrzKPF56kUlaf8tQPKTRNCLbh0SI5oxtsUxKdIKnJWuGGW
	U20dNVupXlq3TVKEYRMo+uXXoAF0saSB6P9UpOKoFiNSLs2oRpveBSLoWBDCqH7wYhTogJlZczV
	e/gjg5bTDMOjyclbwa5apDM/L+HQc/R29nYA=
X-Google-Smtp-Source: AGHT+IHSdaknPrqijioY9HDWLiOWQTIycCby2q675AueD5MlPYeEPC0uzrUjYIL3oulhKhqiN6JSTw==
X-Received: by 2002:a05:600c:8b11:b0:456:1d34:97a with SMTP id 5b1f17b1804b1-4587631561fmr18307095e9.9.1753446042665;
        Fri, 25 Jul 2025 05:20:42 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:3587::1ad1? ([2001:871:22a:3587::1ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054f686sm51705225e9.14.2025.07.25.05.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:20:42 -0700 (PDT)
Message-ID: <5b2951af-517b-4d5c-887f-417f486fd9a2@gmail.com>
Date: Fri, 25 Jul 2025 14:20:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: nova-drm: fix 32-bit arm build
To: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Gaynor <alex.gaynor@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20250724165441.2105632-1-ojeda@kernel.org>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250724165441.2105632-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miguel,

On 24.07.25 6:54 PM, Miguel Ojeda wrote:
> In 32-bit arm, the build fails with:
> 
>     error[E0308]: mismatched types
>       --> drivers/gpu/drm/nova/file.rs:42:28
>        |
>     42 |         getparam.set_value(value);
>        |                  --------- ^^^^^ expected `u64`, found `u32`
>        |                  |
>        |                  arguments to this method are incorrect
>        |
>     note: method defined here
>       --> drivers/gpu/drm/nova/uapi.rs:29:12
>        |
>     29 |     pub fn set_value(&self, v: u64) {
>        |            ^^^^^^^^^        ------
>     help: you can convert a `u32` to a `u64`
>        |
>     42 |         getparam.set_value(value.into());
>        |                                 +++++++
> 
> The reason is that `Getparam::set_value` takes a `u64` (from the UAPI),
> but `pci::Device::resource_len()` returns a `resource_size_t`, which is a
> `phys_addr_t`, which may be 32- or 64-bit.
> 
> Thus add an `into()` call to support the 32-bit case, while allowing the
> Clippy lint that complains in the 64-bit case where the type is the same.
> 
> Fixes: cdeaeb9dd762 ("drm: nova-drm: add initial driver skeleton")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> As discussed, it may be best to have a newtype, or at least a function
> to perform this -- here it is the minimal fix nevertheless.

I agree we should at least have a specific conversion function, but for now:

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

Cheers Christian



