Return-Path: <linux-kernel+bounces-803626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E911B46321
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91FB1C24C7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271B274B3A;
	Fri,  5 Sep 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AfakqmZQ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29249169AE6;
	Fri,  5 Sep 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099137; cv=pass; b=SXwRC12Vv9H2P+eJOEqASX6DHUp6H2Asn2DDPU8VdPJ/9kBjCd7AOby1kGtyS5oGV55shzt3oxLEiX2BB+twtiJvyypg8UHrQ1uzz4ApRHfh8/1whaxsnR7DCzwGOv53EnPZZ6YtqVoKgjFXrAAvNeddNJTzydw4Yt3HB7iBnIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099137; c=relaxed/simple;
	bh=V9/8qEpcGir04o13c7DhuWtpM6xKqSkTMKD0n/VFj4M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YqxB7xvx02E4mHeWfxGVuXmFuNPwqGHybMboBzONhRrV/NawtFfHGtSp/z/5/2ZvA9iBugJePDKbexl8Kq2z06ZaBHv14qK9NVTwyxkXp01CnoTdq8Kxo1J22+yNSTl0/4zzH4DCkXkWjfr/yRV+huErc8bUk8ZsYQWokgYdKmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AfakqmZQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757099095; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iNAcStWflFWIs5SFP60K5mljFUvmYJz8/sGwPagvPINsgoEnlJrwBsvngGkfP72vrTegKpp1LKF+UL/CPtsEGCsJ6gqoHzO86XlTsf6VZMhXBUpStmBUIRT8dzPsyWKy55uWnlbWxlXzZ4CgnFccmCO1vXf1g8enjoo/Yt+89iU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757099095; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9G3fFpvRLofo4rWWplc8l9eH/C2Hdn+hEERg+tooC8g=; 
	b=acoKAse7jeE7dUa6l33qoxF8PHA8evgQlAHQCZ9e+9KzeLKMCLUlqF2kk3akYven6hFkziX2P5X2K4HGzClUAyF2Sr89UoZ8YDzTokV+N+F/yDWIFJ51C7RO8t0eQ66guyMwyZmhm4DtDAPkzYT4JaCNn6lW+ipDWVUGRR6VKwM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757099095;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=9G3fFpvRLofo4rWWplc8l9eH/C2Hdn+hEERg+tooC8g=;
	b=AfakqmZQIZ/hW7Wp+lr4KuWIzsq2vEASv4yEPqVBLPM24o8MvwhK3rrobOEI+pkX
	aPKPM+uXU1demd79rdYQ1h9v6+tsPmSUxc0cTkdUil944xQ9QBTCXwEX9fW/F5Gh6uv
	svqfz/ap3Sa0kvdfDMucQM4X0z4gzcdpZXRKxz5w=
Received: by mx.zohomail.com with SMTPS id 1757099094481754.8297229417868;
	Fri, 5 Sep 2025 12:04:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 4/7] add KUnit coverage on Rust ww_mutex implementation
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250903131313.4365-5-work@onurozkan.dev>
Date: Fri, 5 Sep 2025 16:04:36 -0300
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 will@kernel.org,
 longman@redhat.com,
 felipe_life@live.com,
 daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <381FF023-C65E-4A76-9122-52DF27A68DCB@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-5-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Adds coverage around the core `ww_mutex` functionality
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> rust/kernel/sync/lock/ww_mutex.rs | 127 ++++++++++++++++++++++++++++++
> 1 file changed, 127 insertions(+)
>=20
> diff --git a/rust/kernel/sync/lock/ww_mutex.rs =
b/rust/kernel/sync/lock/ww_mutex.rs
> index 314360632953..d289718d2c98 100644
> --- a/rust/kernel/sync/lock/ww_mutex.rs
> +++ b/rust/kernel/sync/lock/ww_mutex.rs
> @@ -421,3 +421,130 @@ fn drop(&mut self) {
>         unsafe { bindings::ww_mutex_unlock(self.mutex.as_ptr()) };
>     }
> }
> +
> +#[kunit_tests(rust_kernel_ww_mutex)]
> +mod tests {
> +    use crate::c_str;
> +    use crate::prelude::*;
> +    use crate::sync::Arc;
> +    use pin_init::stack_pin_init;
> +
> +    use super::*;
> +
> +    // A simple coverage on `define_ww_class` macro.
> +    define_ww_class!(TEST_WOUND_WAIT_CLASS, wound_wait, =
c_str!("test_wound_wait"));
> +    define_ww_class!(TEST_WAIT_DIE_CLASS, wait_die, =
c_str!("test_wait_die"));
> +
> +    #[test]
> +    fn test_ww_mutex_basic_lock_unlock() -> Result {
> +        stack_pin_init!(let class =3D =
WwClass::new_wound_wait(c_str!("test_mutex_class")));
> +
> +        let mutex =3D Arc::pin_init(WwMutex::new(42, &class), =
GFP_KERNEL)?;
> +
> +        let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class), =
GFP_KERNEL)?;
> +
> +        // Lock.
> +        let guard =3D ctx.lock(&mutex)?;
> +        assert_eq!(*guard, 42);
> +
> +        // Drop the lock.
> +        drop(guard);
> +
> +        // Lock it again.
> +        let mut guard =3D ctx.lock(&mutex)?;
> +        *guard =3D 100;
> +        assert_eq!(*guard, 100);
> +
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_ww_mutex_trylock() -> Result {
> +        stack_pin_init!(let class =3D =
WwClass::new_wound_wait(c_str!("trylock_class")));
> +
> +        let mutex =3D Arc::pin_init(WwMutex::new(123, &class), =
GFP_KERNEL)?;
> +
> +        let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class), =
GFP_KERNEL)?;
> +
> +        // `try_lock` on unlocked mutex should succeed.
> +        let guard =3D ctx.try_lock(&mutex)?;
> +        assert_eq!(*guard, 123);
> +
> +        // Now it should fail immediately as it's already locked.
> +        assert!(ctx.try_lock(&mutex).is_err());
> +
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_ww_mutex_is_locked() -> Result {
> +        stack_pin_init!(let class =3D =
WwClass::new_wait_die(c_str!("locked_check_class")));
> +
> +        let mutex =3D Arc::pin_init(WwMutex::new("hello", &class), =
GFP_KERNEL)?;
> +
> +        let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class), =
GFP_KERNEL)?;
> +
> +        // Should not be locked initially.
> +        assert!(!mutex.is_locked());
> +
> +        let guard =3D ctx.lock(&mutex)?;
> +        assert!(mutex.is_locked());
> +
> +        drop(guard);
> +        assert!(!mutex.is_locked());
> +
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_ww_acquire_context() -> Result {
> +        stack_pin_init!(let class =3D =
WwClass::new_wound_wait(c_str!("ctx_class")));
> +
> +        let mutex1 =3D Arc::pin_init(WwMutex::new(1, &class), =
GFP_KERNEL)?;
> +        let mutex2 =3D Arc::pin_init(WwMutex::new(2, &class), =
GFP_KERNEL)?;
> +
> +        let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class), =
GFP_KERNEL)?;
> +
> +        // Acquire multiple mutexes with the same context.
> +        let guard1 =3D ctx.lock(&mutex1)?;
> +        let guard2 =3D ctx.lock(&mutex2)?;
> +
> +        assert_eq!(*guard1, 1);
> +        assert_eq!(*guard2, 2);
> +
> +        ctx.done();
> +
> +        // We shouldn't be able to lock once it's `done`.
> +        assert!(ctx.lock(&mutex1).is_err());
> +        assert!(ctx.lock(&mutex2).is_err());
> +
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_with_global_classes() -> Result {
> +        let wound_wait_mutex =3D
> +            Arc::pin_init(WwMutex::new(100, &TEST_WOUND_WAIT_CLASS), =
GFP_KERNEL)?;
> +        let wait_die_mutex =3D Arc::pin_init(WwMutex::new(200, =
&TEST_WAIT_DIE_CLASS), GFP_KERNEL)?;
> +
> +        let ww_ctx =3D =
KBox::pin_init(WwAcquireCtx::new(&TEST_WOUND_WAIT_CLASS), GFP_KERNEL)?;
> +        let wd_ctx =3D =
KBox::pin_init(WwAcquireCtx::new(&TEST_WAIT_DIE_CLASS), GFP_KERNEL)?;
> +
> +        let ww_guard =3D ww_ctx.lock(&wound_wait_mutex)?;
> +        let wd_guard =3D wd_ctx.lock(&wait_die_mutex)?;
> +
> +        assert_eq!(*ww_guard, 100);
> +        assert_eq!(*wd_guard, 200);
> +
> +        assert!(wound_wait_mutex.is_locked());
> +        assert!(wait_die_mutex.is_locked());
> +
> +        drop(ww_guard);
> +        drop(wd_guard);
> +
> +        assert!(!wound_wait_mutex.is_locked());
> +        assert!(!wait_die_mutex.is_locked());
> +
> +        Ok(())
> +    }
> +}
> --
> 2.50.0
>=20

I don=E2=80=99t see anything necessarily wrong here, but I=E2=80=99d =
rather wait until
the Rust API stabilizes a bit before having another look.

=E2=80=94 Daniel


