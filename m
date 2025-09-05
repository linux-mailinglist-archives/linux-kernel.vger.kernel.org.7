Return-Path: <linux-kernel+bounces-803904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FF4B46707
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC498AA730E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27C92C0278;
	Fri,  5 Sep 2025 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="abzwPUGq"
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D172639;
	Fri,  5 Sep 2025 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113970; cv=none; b=gwcg0QDOnOBJE42q4pbPi7Run4PQ7CWdk6GI+VfsMkrrqckF+g3OZGhsePsIXwDtm9z61vrWSqCXthc+wc6H+LRq+KI0cj4bKuFBTvXwGYMPQij70sB9luYiwuEQNYMjWVvK8W3zRyUANFW79jQkqzWJN2HPtrvQzPaK5GCbTls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113970; c=relaxed/simple;
	bh=3gU0ueFPsOh8WC7TPJeLYi3Oj6xPVlViOPWGn/Fb7Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTwxiR+LvfvkL7LAth788AwIKfLe9m1aHExsIJXSi5ND2+a0o1tY7mpyFhhWtq+Y18LHUWqU2woaI4Bpe9tYwvcNvceKJAi+PIqO8y35+/HQn6DVjnrG2yGyi/uTqb1GhHs6poYgOkz5REHbusVmHDJmWA8HB7kJzenYc/Bh9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=abzwPUGq; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757113966; x=1757373166;
	bh=Azips1Ngad9yZJkZOMDLspKogsCHNUulSwOFnys7WUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=abzwPUGqd0Y0ALrc8vxR2Dx4qYBy6wPchwaky9aEVE7S+W8UiZK3ol/SU8EKfDnG1
	 IuKvD8IRJStAIHNgPfXwsHtaZErYrDh/QqYeo4afZJ/2K+Y8y89BOVyJ6ux3oMzeDm
	 uVRGpx7lvtLVtxOtXVyARr1fdwEZn5715loakfRbXgxBgc31gOIfp1GHoxfHRbA1BV
	 yAZbxrzygiYsloZIOjyBIPT8ekp+ZpGm0VxqJAzXPrf6o4oVKdeMqnZQUBKqw1uqmd
	 PXb/QejTbYfvy38oU1l4mGNHk28FIJ4HNMzSo8/3IsHcVyREppFAE7HrHGedwBSb1c
	 IH7WEYjUr4lBA==
X-Pm-Submission-Id: 4cJXF72CfNz2ScPt
Date: Fri, 5 Sep 2025 23:12:40 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, felipe_life@live.com,
	daniel@sedlak.dev, bjorn3_gh@protonmail.com,
	daniel.almeida@collabora.com
Subject: Re: [PATCH v6 7/7] add KUnit coverage on ww_mutex/exec implementation
Message-ID: <aLtuaHNDoQlBO17q@archiso>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-8-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903131313.4365-8-work@onurozkan.dev>

On Wed, Sep 03, 2025 at 04:13:13PM +0300, Onur Özkan wrote:
> Adds coverage for `ww_mutex/exec.rs` implementation.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/sync/lock/ww_mutex/exec.rs | 148 +++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
> diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs b/rust/kernel/sync/lock/ww_mutex/exec.rs
> index 2f1fc540f0b8..543c5218232a 100644
> --- a/rust/kernel/sync/lock/ww_mutex/exec.rs
> +++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
> @@ -174,3 +174,151 @@ fn cleanup_on_deadlock(&mut self) -> Result {
>          Ok(())
>      }
>  }
> +
> +#[kunit_tests(rust_kernel_ww_exec)]
> +mod tests {
> +    use crate::c_str;
> +    use crate::prelude::*;
> +    use crate::sync::Arc;
> +    use pin_init::stack_pin_init;
> +
> +    use super::*;
> +
> +    #[test]
> +    fn test_exec_context_basic_lock_unlock() -> Result {
> +        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("exec_ctx_basic")));
> +
> +        let mutex = Arc::pin_init(WwMutex::new(10, &class), GFP_KERNEL)?;
> +        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
> +
> +        ctx.lock(&mutex)?;
> +        ctx.with_locked(&mutex, |v| {
> +            assert_eq!(*v, 10);
> +        })?;
> +
> +        ctx.release_all_locks();
> +        assert!(!mutex.is_locked());
> +
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_exec_context_with_locked_mutates_data() -> Result {
> +        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("exec_ctx_with_locked")));
> +
> +        let mutex = Arc::pin_init(WwMutex::new(5, &class), GFP_KERNEL)?;
> +        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
> +
> +        ctx.lock(&mutex)?;
> +
> +        ctx.with_locked(&mutex, |v| {
> +            assert_eq!(*v, 5);
> +            // Increment the value.
> +            *v += 7;
> +        })?;
> +
> +        ctx.with_locked(&mutex, |v| {
> +            // Check that mutation took effect.
> +            assert_eq!(*v, 12);
> +        })?;
> +
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_lock_all_success() -> Result {
> +        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("lock_all_ok")));
> +
> +        let mutex1 = Arc::pin_init(WwMutex::new(1, &class), GFP_KERNEL)?;
> +        let mutex2 = Arc::pin_init(WwMutex::new(2, &class), GFP_KERNEL)?;
> +        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
> +
> +        let res = ctx.lock_all(
> +            |ctx| {
> +                let _ = ctx.lock(&mutex1)?;
> +                let _ = ctx.lock(&mutex2)?;
> +                Ok(())
> +            },
> +            |ctx| {
> +                ctx.with_locked(&mutex1, |v| *v += 10)?;
> +                ctx.with_locked(&mutex2, |v| *v += 20)?;
> +                Ok((
> +                    ctx.with_locked(&mutex1, |v| *v)?,
> +                    ctx.with_locked(&mutex2, |v| *v)?,
> +                ))
> +            },
> +        )?;
> +
> +        assert_eq!(res, (11, 22));
> +        assert!(!mutex1.is_locked());
> +        assert!(!mutex2.is_locked());
> +
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_with_different_input_type() -> Result {
> +        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("lock_all_ok")));
> +
> +        let mutex1 = Arc::pin_init(WwMutex::new(1, &class), GFP_KERNEL)?;
> +        let mutex2 = Arc::pin_init(WwMutex::new("hello", &class), GFP_KERNEL)?;
> +        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
> +
> +        ctx.lock_all(
> +            |ctx| {
> +                ctx.lock(&mutex1)?;
> +                ctx.lock(&mutex2)?;
> +                Ok(())
> +            },
> +            |ctx| {
> +                ctx.with_locked(&mutex1, |v| assert_eq!(*v, 1))?;
> +                ctx.with_locked(&mutex2, |v| assert_eq!(*v, "hello"))?;
> +                Ok(())
> +            },
> +        )?;
> +
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_lock_all_retries_on_deadlock() -> Result {
> +        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("lock_all_retry")));
> +
> +        let mutex = Arc::pin_init(WwMutex::new(99, &class), GFP_KERNEL)?;
> +        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
> +        let mut first_try = true;
> +
> +        let res = ctx.lock_all(
> +            |ctx| {
> +                if first_try {
> +                    first_try = false;
> +                    // Simulate deadlock on first attempt.
> +                    return Err(EDEADLK);
> +                }
> +                ctx.lock(&mutex)
> +            },
> +            |ctx| {
> +                ctx.with_locked(&mutex, |v| {
> +                    *v += 1;
> +                    *v
> +                })
> +            },
> +        )?;
> +
> +        assert_eq!(res, 100);
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_with_locked_on_unlocked_mutex() -> Result {
> +        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("with_unlocked_mutex")));
> +
> +        let mutex = Arc::pin_init(WwMutex::new(5, &class), GFP_KERNEL)?;
> +        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
> +
> +        let ecode = ctx.with_locked(&mutex, |_v| {}).unwrap_err();
> +        assert_eq!(EINVAL, ecode);
> +
> +        Ok(())
> +    }
> +}
> --
> 2.50.0
> 
> 

Thanks for adding these tests!

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

