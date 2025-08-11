Return-Path: <linux-kernel+bounces-762286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF538B20472
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B5B18A0730
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E988A22A4DA;
	Mon, 11 Aug 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZD3UnBr"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386E1FBC92
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905864; cv=none; b=pwAGI7PWdP7ERErRXvQ2ebvWQMCJh+A+X//PKxlEan23HPlInxD7grzJ9o3oYUaHb3ahbh81RFzKHV0G9yQdOpUfGjOL59UOk+p5CXQV0g05pL4F4rnt3jbxI/u/cEFRR6IFU9hSmLFgMf3GCSu/rrVPV15KlpCyzCUwaH/dv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905864; c=relaxed/simple;
	bh=C5MatfIhs12u8LBN8rcB7OmjjjJR/sQwe8LRRU3PdCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NQvMSwRS01kwVjV49EYIyj2v6YnMOw3IJ+2kUEdZOLNgk8yaSXTkmLNu6+aoqenNQUXcn4h4dtNNg0aAK1c5MS9i+SP4ZArfwNbhSGvucy/7d5VT8smBgxTFOQ80TUl40t0PPgSTe2PFoelB83lS8gmCxOo9mhJL14Aj0pgKJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZD3UnBr; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b793f76a46so2662908f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754905861; x=1755510661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eAE29LBrFArgSyvFQ5lS9xVaxfMO1U9/JaZNL/bK/48=;
        b=hZD3UnBr8w3DLpIqfXGNFHM8v5vP6OTBzzQE3sZj6lZlAetIFtoeB3NXtUgsGxMBuQ
         b2csTwsFfPrzs8e7YSGFKI23DaNGhq0TUCkDjwoIQIbbpmFATN6vVV+STbnyxXFOyVnQ
         IXXO81E4V8rHYdzbkKu4rj3A4jmU8SAbMfOW+UGYw8/EeoppJEHHOvrRE5fnXvbgJH6C
         Id2B5rfcba/JIAUtyu4P7ufQOkkQDmUsz83uVAOHpNx9n/t2RaeWk2+wRsaulI58FgMp
         5KwHOkFzNJjP9oIQGllvga7cxWUUrCNnJpU9fdV6drgN4lUu+4y/T95/9LcK0ZMD5iFO
         ICHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905861; x=1755510661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAE29LBrFArgSyvFQ5lS9xVaxfMO1U9/JaZNL/bK/48=;
        b=ucmuTXOr4LQb06+AYivRUWjXaLuoE+6hEXreMAP/HIM/BHNGpGbl0S0KGL3QtCa19a
         Ilhirl6czeSFT33PX+i1uY2cfkAtq8yKKvm9uf22ZVbof5gu+XHqigmsP9JU4Ie187c6
         iYbb4IYbJyjdbuNc1+YZtQ0JUnYomuC5ZLA4M6bDVEYiy1iu8ugQ0ZGuTz5yP69MwT5b
         40GfPfxcsPooDzeo/w6+XRjd7RCVrROvE+ClhuplJUpK+KJ4HFLeWrFksI2F+g8lRtjE
         lEs9HHr9Pp9eC5xF7sqX78uJf9x7b+HYOhioJLVUUpEWb2FrmrASESgYLb0klhT+TMNm
         aKrw==
X-Forwarded-Encrypted: i=1; AJvYcCW6fYb9fyRAILbUUhaNpFniAK6P4AhOEPdlybo17KfCUGT7PTOMD2aOBpANDhPQP1Tw2bqecPWuVzzTwmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBtQtILP8gkOUlvW6Ig1YhCwwcyp3p21yKDRVzm1jy8kYPbOs
	6Ptl80xEw2XrEX+iCmb77wCRpgOMrgGjHKOaMHYVZZ0lGq7VP53x0S28qBOYcYn4bNj8LTRrHFd
	gqWfbEVWujv9Mx12BQQ==
X-Google-Smtp-Source: AGHT+IGTv1HAGp4uXaV3XH6tL1TykMyBCbs/097zxVSNyRqSXVdMeoikVR/Ak34IFOdwpahSprtW+i8IpUvxOZ8=
X-Received: from wmtk8.prod.google.com ([2002:a05:600c:c4a8:b0:459:d4a7:967f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64cd:0:b0:3b7:9c38:e8a5 with SMTP id ffacd0b85a97d-3b900b8bd0emr9524002f8f.56.1754905860749;
 Mon, 11 Aug 2025 02:51:00 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:50:59 +0000
In-Reply-To: <20250811041039.3231548-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com> <20250811041039.3231548-3-fujita.tomonori@gmail.com>
Message-ID: <aJm9A_D-zlJtbV6X@google.com>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org, 
	anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, frederic@kernel.org, gary@garyguo.net, jstultz@google.com, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com, 
	Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="utf-8"

On Mon, Aug 11, 2025 at 01:10:38PM +0900, FUJITA Tomonori wrote:
> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
> 
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
> 
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
> 
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
> 
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.

I would drop this paragraph. You have a call to might_sleep() now.

> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Option<Delta>,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,

I would consider just writing this as:

pub fn read_poll_timeout<T>(
    mut op: impl FnMut() -> Result<T>,
    mut cond: impl FnMut(&T) -> bool,
    sleep_delta: Delta,
    timeout_delta: Option<Delta>,
) -> Result<T>

And I would also consider adding a new error type called TimeoutError
similar to BadFdError in `rust/kernel/fs/file.rs`. That way, we promise
to the caller that we never return error codes other than a timeout.

Another thing is the `timeout_delta` option. I would just have written
it as two methods, one that takes a timeout and one that doesn't. That
way, callers that don't need a timeout do not need to handle timeout
errors. (Do we have any users without a timeout? If not, maybe just
remove the Option.)

> +{
> +    let start: Instant<Monotonic> = Instant::now();
> +    let sleep = !sleep_delta.is_zero();
> +
> +    // Unlike the C version, we always call `might_sleep()`.
> +    might_sleep();
> +
> +    loop {
> +        let val = op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check again.
> +            return Ok(val);
> +        }
> +        if let Some(timeout_delta) = timeout_delta {
> +            if start.elapsed() > timeout_delta {
> +                // Unlike the C version, we immediately return.
> +                // We have just called `op()` so we don't need to call it again.
> +                return Err(ETIMEDOUT);
> +            }
> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }

I would just do:

if !sleep_delta.is_zero() {
    fsleep(sleep_delta);
}

instead of the extra variable.

> +        // fsleep() could be busy-wait loop so we always call cpu_relax().
> +        cpu_relax();
> +    }
> +}
> -- 
> 2.43.0
> 

