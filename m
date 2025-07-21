Return-Path: <linux-kernel+bounces-738829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE2B0BDD3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D4C189DA33
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964B2853EB;
	Mon, 21 Jul 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9BZ1EbZ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69E285049
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083443; cv=none; b=O4SrozKIIqCb8a1sLbW9w1w6Nq/8kppoGw/QQblfzGuEghIziKYJ0VUge8A8Z+JDUdfb4j7XuuXPJKUeGGYQFyvbNb6C8P6b/o2zOgG/o8aDg1QdTkgTUJGpHWg5aWaYbctP/QrVIbTiWmK0GKzERiluMwDeydr+AWtb0XLIg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083443; c=relaxed/simple;
	bh=Kgi56yPbZYI58ok8oxCLNd5/43u9mGkk0C1PxCt4lLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+OeRk2IqyjbH64dCwgApi9xfQ5LyveMcJ28bhrBK2fVADZDeqLyCsin8SNzarA/QWh/yWoHafZRG6M99pe4ZCE0ZS0syKefs6woOR0p0wEUDm+ZVmzZXdpPvIYUv4LwIpNrQsu8bB0TQq6nxcqsxDir+y2SY9yOrgJNxW+F1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9BZ1EbZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23636167afeso37787505ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753083440; x=1753688240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AW7C0Fw+OUlttGGnAPG+jvEboZ7WFaopv/dP3AY9iLI=;
        b=w9BZ1EbZHIYy6Uo0SI9IpYdwLxYfrq7y+jNUnSFDO8FyzRcFEnJS1uHbTX18QK63Ge
         Qwd7Stz5tU+TwvxMVg3hlee7R2dmp8BQ0m0SBqfqjKqP3usdwC30r9xVjH+7lZTy+UCJ
         BJdRfSMkz0vXXDZbfuy359xH5Mn9whuJOu+BpmZaWgLzlD1tJt2Ke1A47p8YWdu++tJj
         eS2E7B1kMJn5hy5ZRHiomRfvI9oxNUvcOi2+kwuSUwFkyXru6gvE+DHtQamKJS4zHnH5
         M2DUY0CqnLM/Gt9X529iaK4areMtHrUjINlmJHXCOrfjis0D3bpLjwYSARh6Iwux7qhx
         mmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753083440; x=1753688240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW7C0Fw+OUlttGGnAPG+jvEboZ7WFaopv/dP3AY9iLI=;
        b=O4j7vSrrq+DjaOHj6g1PjMLTSzfngiy1uZf2kAVOHD4u0DwJ6KxCBLjxiNZgESUEL3
         zs44NWMoElZ+bne8ac0hbm8BEa8cZDIMAeUUE4vBhT1jC9J6AmC+VpB3WobsfmaiT/ft
         S5p4o5KMSvTv9X55XEBOZRy2vGBiQjbDR11Yj8x2KqwESNnHPl4hdC5B6OUR98NK2hAI
         QM+CAV4AQkdvfEZPMW/VgPbRCDcFI3eLq7lK2GLVcsXXmGzCzTSxtm/H5pmzR9Qeae9p
         qyiE8TfGwqOj23FJz2luEqMaZ4BZJBqE4C+xh/J1AG2EWc4EIn2Rus3Y3u05Arc1+cI0
         /lOA==
X-Forwarded-Encrypted: i=1; AJvYcCVDyf+LXcParI9wbzzc+Olj5o7tH8USRkBWhDzlaSCv69XMiFGulo7Jbta2+24kEVMGqM7fxCHYlGYbDmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlfnc91FtPRjTgJSX/fq0QJ/x0yXC3IhorUL8nXCu13TThDJpT
	YYcNeOFvHs2HivrYZedVWpf/Li8clurgAqH753cKQnAHScbtn+o5x1WmruJ0mQ5497A=
X-Gm-Gg: ASbGnctAqhf/dQzBoK2s/XNMz/n1y6ESOt2bi+H3u3DBYYBMKugzQJOvgXW24klDeNQ
	86OPggC7R9bd4JBZ/Hn3stKTA9x1FqpljB7lkCdZNisO0kjkYOVGnlgHf/sLExMUxs8eTLo4SxE
	XzXp0W44b9fx2WF5uVZz0RDVlT9jaIzWyf3LaDqLLsvsKGdU4dyBQ/S8F0TMPPHrNBm4Ih4hf3h
	4yvUGynRJPC4wgITc/ZB+HyNZ1L6A/wc8MrCDHB+BVFvCwCauOw4gXNmt+CfrXuEOZ24haPseU/
	pyYeqlHFFp6oP5xT035ZPuzZ7z3j8vPKAWD8Mx6QkuwkIHW2XRLhQDuGc/l07XIHj1/dnBs45Mo
	gTTW6/Ro8NfI4RkM34hItTos=
X-Google-Smtp-Source: AGHT+IFk3DmrxLSOuu1QML7M9aZcW/M1lwjmHi2A/P/8p7kUrsmSSAAA7m474B7f7eHzVA50L8YW7Q==
X-Received: by 2002:a17:903:1a45:b0:234:c2e7:a102 with SMTP id d9443c01a7336-23e2576c1bfmr262018575ad.43.1753083440496;
        Mon, 21 Jul 2025 00:37:20 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60ec88sm52502155ad.65.2025.07.21.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:37:19 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:07:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] rust: kernel: remove `fmt!`, fix
 clippy::uninlined-format-args
Message-ID: <20250721073717.i6hr4iesfupzvtwf@vireshk-i7>
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
 <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>

On 04-07-25, 16:14, Tamir Duberstein wrote:
> Rather than export a macro that delegates to `core::format_args`, simply
> re-export `core::format_args` as `fmt` from the prelude. This exposes
> clippy warnings which were previously obscured by this macro, such as:
> 
>     warning: variables can be used directly in the `format!` string
>       --> ../drivers/cpufreq/rcpufreq_dt.rs:21:43
>        |
>     21 |     let prop_name = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
>        |                                           ^^^^^^^^^^^^^^^^^^^^^^^
>        |
>        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
>        = note: `-W clippy::uninlined-format-args` implied by `-W clippy::all`
>        = help: to override `-W clippy::all` add `#[allow(clippy::uninlined_format_args)]`
>     help: change this to
>        |
>     21 -     let prop_name = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
>     21 +     let prop_name = CString::try_from_fmt(fmt!("{name}-supply")).ok()?;
>        |
> 
> Thus fix them in the same commit. This could possibly be fixed in two
> stages, but the diff is small enough (outside of kernel/str.rs) that I
> hope it can taken in a single commit.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs    |  3 +--
>  rust/kernel/opp.rs                |  2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

