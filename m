Return-Path: <linux-kernel+bounces-747883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09033B139B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210A316BB87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E07A25A33F;
	Mon, 28 Jul 2025 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJdPAVXg"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FC38F80;
	Mon, 28 Jul 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701069; cv=none; b=k/nxTuBfwhl5Jf2x9hbtRT5J9sVF0FkiiUDcYLouLiAPm8GeqcRdI9ZrvujznH5Hv3xBiWUxoylznjs4mtCz3MT4umCjVrmZjo4Yu7TacqDXgCPozYbAQS+nIBPOwo3Ymyt/S0e9LL6b/gnn8PMg05Ol8dNKjpKscgb6/yMM0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701069; c=relaxed/simple;
	bh=Yyzz3UdbIQBO7aejzRdazhb9pI+IikjCUT2kiqKxMyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jw9PWLZJA+Z5KH53A6Xcj2Yt75Mhmc0NovHSQYhhPNY9sW9HrE5hIn9iXs9j9oMP9/ALjZ38DN+9Lx4a5xgjYPyYmgJUBsPYupXnPS8YysOm5O+GzMbgR9ggxz00ED4i9rzZSy8C84C8aR8xXJ7YACzKtssgj30J4etvXx4EqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJdPAVXg; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73e810dc01aso2347675a34.0;
        Mon, 28 Jul 2025 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753701066; x=1754305866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YelJq5+KqwjZ5s+zSqyZgpj7s0sgr+POM2J5j33U9x0=;
        b=MJdPAVXgdwva8zTHYJyGqSIkEQpEXyZHemtmiyvjFnznQawXnCUJbMKBGMPUW/B5WZ
         CBVxV+PvRaw2HKW5mGZeyVICv5B4z8IpAdfxvez/RbO9rf68iCrumP4snunE4dain0kM
         P5PX/B6Z3LfPuvMfD/kM3uMMYSSdKklsKTs8QVq0W0OH2NZhy9qLgEaGaRSokvhLzJLw
         Rnaw5mSML20NJvHRPFcBFxUVZgImzbCJLNu3lomvKCEdFn3J8UmjQCynWWBcSDc4P4iS
         JM67cMZwj2DHJkuBlWqthP/Jqg2fewgilvFLr40NZxF28srHOUvgjih/TlZKdJaiXNyP
         IEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753701066; x=1754305866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YelJq5+KqwjZ5s+zSqyZgpj7s0sgr+POM2J5j33U9x0=;
        b=Wf4Orx3oTfCYc3+uyKeoldO+QOVph+nW5ktY4DmY8HWam5WRRtFxmlHuVW98Lnb+xo
         QLnEFlkwQmiVGNjFGHVNmwlPovDHBGmdReYehWrQ6UT0+36BXEaUvevByhL/cOIbyblu
         htdxX3zTyuC42P+BT6EViEaxsKNsrdZEmQdwhXp6Be7yfaL5JYFnvp1ONuv/9kCthIM/
         nZUnNTaT768LxrWA57SRCfpUuMLoALAaKPHImkw2HQbUlU2VQp1DwZiXL2eiC5gHswzZ
         iY73Ulv/RtRilobii5q/GV9yO/jYte1naqpcRKNVaIhrMWcmpzABarLJXA/4Fv+AeGEr
         AiMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfcF9V6vKLfBeh2I+H9CeWDGmXR/Er3OiwY0bSAglyY48BmdbiMZMFG3hvMNRXQchNHY+2Bdg04H1YujjV4QM=@vger.kernel.org, AJvYcCXf4c9fCej/lvQRc1sqqLwafazIweWry7ucJhXdxdL3Sg0OUa2QwFvETbA7b1g7xMDmYdW8Mgxiaz5hA88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRiqbBmxQPSxVeauqiB0G38NVQrApUpWLDP5ofr4axXHTngLqU
	hZx/PiwIvEcVW1HhlS3vM2MXaIuv3E+0nG50IFr1+XS7AsVksfAf8c8j
X-Gm-Gg: ASbGncvGA8YAy80EI/0OhnvDY40wta5ddbhwp/vPJmH+1YoKKfIq5D9pG4tF5DeYTZ/
	dno71GlVtQY+VMYjZIXidnx67PpEma8rIK8WG1kZK1eYjwpQ3c+EYfwmD++GuuJd64sBn6b2jrX
	1nefPya5/6tlEWxtdYKOWUhpAm8hlgYDBZN1DmqKD44UM3IIXe7xgNJ/5rMZsleFgstec8WcOql
	yJjoq6JDMMYtjEY00ZgVsa/ZElVTEKjmBhLZw2TlkNBxmks16jRHsbXLsh9Uq4bv0V9nA+ZEI19
	fXCV8b95UCGbed/HG05Kizd1S6wYSiCA21IwdQIKCSkNoduxNWBNXtFNhmSCo5rq+xIq8iLa9y+
	iBguztlUxLvJw8ls1gCpPrNIBUtpNB8ZxJbwpOW100iJ5IMRDYSEp6epw2WjWvm4jXpPPtc4ELj
	5KglRO
X-Google-Smtp-Source: AGHT+IE0MGdMlJEMmoauyyGL5IGwz1RfJolQSIkKm13B128tgDOr9GHPwxPr5ZGTrFtGLyQRiODJSw==
X-Received: by 2002:a05:6830:4d92:20b0:72b:8fd3:e2dc with SMTP id 46e09a7af769-7413dcd7b58mr5857781a34.21.1753701065943;
        Mon, 28 Jul 2025 04:11:05 -0700 (PDT)
Received: from [192.168.86.39] (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-741481c5c92sm1027355a34.30.2025.07.28.04.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 04:11:05 -0700 (PDT)
Message-ID: <a4b93eb0-9742-4f24-86d9-486ce87fbed8@gmail.com>
Date: Mon, 28 Jul 2025 06:11:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: maple_tree: add MapleTree::lock() and load()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org,
 maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>
Content-Language: en-US
From: Andrew Ballance <andrewjballance@gmail.com>
In-Reply-To: <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/25 8:23 AM, Alice Ryhl wrote:
> To load a value, one must be careful to hold the lock while accessing
> it. To enable this, we add a lock() method so that you can perform
> operations on the value before the spinlock is released.
> 
> Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I have a couple of nits, but overall looks good to me.

> ---
>   rust/kernel/maple_tree.rs | 94 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
> 
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index 0f26c173eedc7c79bb8e2b56fe85e8a266b3ae0c..c7ef504a9c78065b3d5752b4f5337fb6277182d1 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
> @@ -206,6 +206,23 @@ pub fn erase(&self, index: usize) -> Option<T> {
>           unsafe { T::try_from_foreign(ret) }
>       }
>   
> +    /// Lock the internal spinlock.

probably should add #[must_use] here.

> +    #[inline]
> +    pub fn lock(&self) -> MapleLock<'_, T> {
> +        // SAFETY: It's safe to lock the spinlock in a maple tree.
> +        unsafe { bindings::spin_lock(self.ma_lock()) };
> +
> +        // INVARIANT: We just took the spinlock.
> +        MapleLock(self)
> +    }
> +
> +    #[inline]
> +    fn ma_lock(&self) -> *mut bindings::spinlock_t {
> +        // SAFETY: This pointer offset operation stays in-bounds.
> +        let lock = unsafe { &raw mut (*self.tree.get()).__bindgen_anon_1.ma_lock };
> +        lock.cast()

This cast seems unneeded. lock should already be a *mut spinlock_t.

> +    }
> +
>       /// Free all `T` instances in this tree.
>       ///
>       /// # Safety
> @@ -248,6 +265,83 @@ fn drop(mut self: Pin<&mut Self>) {
>       }
>   }
>   
> +/// A reference to a [`MapleTree`] that owns the inner lock.
> +///
> +/// # Invariants
> +///
> +/// This guard owns the inner spinlock.
> +pub struct MapleLock<'tree, T: ForeignOwnable>(&'tree MapleTree<T>);
> +
> +impl<'tree, T: ForeignOwnable> Drop for MapleLock<'tree, T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we hold this spinlock.
> +        unsafe { bindings::spin_unlock(self.0.ma_lock()) };
> +    }
> +}
> +
> +impl<'tree, T: ForeignOwnable> MapleLock<'tree, T> {
> +    /// Load the value at the given index.
> +    ///
> +    /// # Examples
> +    ///
> +    /// Read the value while holding the spinlock.
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    ///
> +    /// let tree = KBox::pin_init(MapleTree::<KBox<i32>>::new(), GFP_KERNEL)?;
> +    ///
> +    /// let ten = KBox::new(10, GFP_KERNEL)?;
> +    /// let twenty = KBox::new(20, GFP_KERNEL)?;
> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    /// tree.insert(200, twenty, GFP_KERNEL)?;
> +    ///
> +    /// let mut lock = tree.lock();
> +    /// assert_eq!(lock.load(100), Some(&mut 10));
> +    /// assert_eq!(lock.load(200), Some(&mut 20));
> +    /// assert_eq!(lock.load(300), None);
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    ///
> +    /// Increment refcount while holding spinlock and read afterwards.
> +    ///
> +    /// ```
> +    /// use kernel::maple_tree::{MapleTree, InsertErrorKind};
> +    /// use kernel::sync::Arc;
> +    ///
> +    /// let tree = KBox::pin_init(MapleTree::<Arc<i32>>::new(), GFP_KERNEL)?;
> +    ///
> +    /// let ten = Arc::new(10, GFP_KERNEL)?;
> +    /// let twenty = Arc::new(20, GFP_KERNEL)?;
> +    /// tree.insert(100, ten, GFP_KERNEL)?;
> +    /// tree.insert(200, twenty, GFP_KERNEL)?;
> +    ///
> +    /// // Briefly take the lock to increment the refcount.
> +    /// let value = Arc::from(tree.lock().load(100).unwrap());
> +    ///
> +    /// // At this point, another thread might remove the value.
> +    /// tree.erase(100);
> +    ///
> +    /// // But we can still access it because we took a refcount.
> +    /// assert_eq!(*value, 10);
> +    /// # Ok::<_, Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn load(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
> +        // SAFETY: `self.tree` contains a valid maple tree.
> +        let ret = unsafe { bindings::mtree_load(self.0.tree.get(), index) };
> +        if ret.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: If the pointer is not null, then it references a valid instance of `T`. It is
> +        // safe to borrow the instance mutably because the signature of this function enforces that
> +        // the mutable borrow is not used after the spinlock is dropped.
> +        Some(unsafe { T::borrow_mut(ret) })
> +    }
> +}
> +
>   /// Error type for failure to insert a new value.
>   pub struct InsertError<T> {
>       /// The value that could not be inserted.
> 

with or without those fixes, for the entire series,
Reviewed-by: Andrew Ballance <andrewjballance@gmail.com>

Also, if you need one, I would be happy to be a co-maintainer of the
rust maple tree bindings.

Best Regards,
Andrew Ballance




