Return-Path: <linux-kernel+bounces-849942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34906BD164D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5C574E742C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBFC2C15AE;
	Mon, 13 Oct 2025 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvnVzt/I"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3B2C11E5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330916; cv=none; b=UfVG/Aqpo+v2lEyGk63ghzvwO2TLpITVDH3hyUxFDLrzTe9CDihZNN2mKaekM0Fx6OBMNH21qUqOW/eC64WtvXw/JrXmCKGTO7nkhO3Dr2cyx56WsvzRoofy1c5spb/CnweJHuF4s6qLKdw4znxTtP/VJCPOj5sp5uPuXNxf0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330916; c=relaxed/simple;
	bh=w5flf0ZTD8FoZKNNJ44xzj8U9JvZaMG7ZVwuxSdM1qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHb4FS8G/GkENL04xJw8bEQyj/6f+H4OZ63zy18hYNWIbXEt0dqolCkjP0yTYpCR853+cl50d/fPQtwvKfEbwJxRulfKmxUwviBCPpwepyiE2oXIDfKwfyvGCm06+moBL7y27lYKfPLx34UOdTNcIb9NkQpLgY5HVSFeAbLmCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kvnVzt/I; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-271d1305ad7so63075345ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760330914; x=1760935714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+N1GbW5T01OcE9SjnTkQCqp4CEF9pzePEjEN9o9hnwo=;
        b=kvnVzt/IQzVhaAdfwsLFLs9LGpMpWsE4RD31U9YuMylfp99NZFbl05PEW8HOdRjD5G
         04POdV7jnKL4cfzELmZOaZ2yL7Awxgjy1/9tJ+yRF3hUgJjnla0hm04TMtmc2NkevqZD
         O5XIt7AEbSKAPqhFqyZlCVb0o/dj79eiw9tyUzJD8zVGvmDGD/rjEOg4pD3YFMUDY3cE
         AR/fnaHHX91LS9dMAhRbaOm8QbGvwCwkhZ6jhecdMUglK4f4n6/QTUIlhChEi/+C9p7F
         p/kmduabe8YZAOShOMajDKRa1ePrD7qWTD0cRmXnufSMFKfck8Kvmxj71KH7YV4EWR8f
         4eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760330914; x=1760935714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N1GbW5T01OcE9SjnTkQCqp4CEF9pzePEjEN9o9hnwo=;
        b=LbIPh46WrrRZ3IbMt3wOs3Hmltl9jrmD6CCJGY8PXPuGWDtM64ebtmx7wUI1DcPsoD
         IQhNrLaqQ252Ra4fZmqU+nOT0PDurxwN2vKr8bvtiiZ0t3pKkiQGb6kqp3gX9Qt1RAwk
         pb+vsDbztJdKwuj2yzBgaCzJf9ateUBBcJegxnGieB2Rb5hEvZgLLgx2yh5LYqGZ3mj7
         daFW9SlfHmiaDAXc8T6pht82RaX98nCSvJBaAnqsiT+8XsIClM6n8A+8FT3DSqr9PPOj
         EGzvtBBeR8zm0Q/vtKL5JlzD1imKFvbtfiEEwJonJvZVFK4iBQCctjUFKRihPjKYAN9G
         c3ag==
X-Forwarded-Encrypted: i=1; AJvYcCWyt2h7QJ7Q8pbmBt/ZdH9k0HRl6ioPWYlMrDEVCmdk9clEqeodoNdc14ZZx+aC+8e8r8UZmsaYdgwq+3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeerKY2bUL0sWHb/P/mO4gX00p5FUGiCvf0XvidfWeSwL3Fcgg
	oM0lB1a7KMVQxXRF2AMzYhGS0hpDnOOzXNO/eUGPLo1NHf60Vloe44r+YVi1zY3K8/E=
X-Gm-Gg: ASbGncvY0KTO6PsyEhPqFidk+aZdZk7F3Zor8Ywj9BdsVQladMDaHzLLx0WX7JpGxIj
	93ElQLpLltBJKS9TxRpmTkARWSoKJplud5THTquMkiB9XoRvXwsIfe7QiYng6vnzuYfzdCL/rbK
	trVkG7DkDYlI6JU/MiXRXqrFAjVTwmcgy840/xTvcQJLtmYG3JdJ3J2pM4e1x+cui4m52epVINO
	MeBmRKXLDBU9TC0NqldR3e2r2QYy4XFWc8dyMPFSMa3n6h6U8TbaxJXLT/UkTAlQCF8FmSD5lUq
	5J3EwS9mVhODMIZmzpulPBIDpCEr0JiKGOK825W1gKPnO+alpVm0twbJIdkJJ1I2rQo0a516P9L
	4lGWJOwJesZTwEWlL3JJgC4n5SFHMifx8kiOf0+FpQytoG9G4Kp36lbis1A==
X-Google-Smtp-Source: AGHT+IEjf3zE4VC422TWXSW/Bnh5dRfTTAIjmK5mj1HsvRN7orBZtaN8hGr9+1lO1J8DEcWKyA4uXg==
X-Received: by 2002:a17:903:4b08:b0:27e:f005:7d0f with SMTP id d9443c01a7336-290273ffc50mr241023805ad.44.1760330913936;
        Sun, 12 Oct 2025 21:48:33 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034cba155sm120234705ad.0.2025.10.12.21.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 21:48:33 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:18:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Subject: Re: [PATCH 3/3] rust: cpufreq: fix formatting
Message-ID: <7equbjyprjv4s4sg46inaiggmmh4l2aatuoqfpgrj5dgvxgqy2@zo5vh7i5ywjj>
References: <20251010174351.948650-1-ojeda@kernel.org>
 <20251010174351.948650-4-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010174351.948650-4-ojeda@kernel.org>

On 10-10-25, 19:43, Miguel Ojeda wrote:
> We do our best to keep the repository `rustfmt`-clean, thus run the tool
> to fix the formatting issue.
> 
> Link: https://docs.kernel.org/rust/coding-guidelines.html#style-formatting
> Link: https://rust-for-linux.com/contributing#submit-checklist-addendum
> Fixes: f97aef092e19 ("cpufreq: Make drivers using CPUFREQ_ETERNAL specify transition latency")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/cpufreq.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 21b5b9b8acc1..1a555fcb120a 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -38,8 +38,7 @@
>  const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
>  
>  /// Default transition latency value in nanoseconds.
> -pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =
> -        bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
> +pub const DEFAULT_TRANSITION_LATENCY_NS: u32 = bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>  
>  /// CPU frequency driver flags.
>  pub mod flags {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

