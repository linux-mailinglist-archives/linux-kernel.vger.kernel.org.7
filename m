Return-Path: <linux-kernel+bounces-843572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EAEBBFBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 017244EE5F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B0207A32;
	Mon,  6 Oct 2025 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACd35Qs0"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202C1DF261
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792191; cv=none; b=uX818eKmEoYTFuyQTp0M5n7M6u/AbU/HnTsBRGh46J0/NhT/du12TNxNBy6P2H9QnBUeeYeJwENtD399Z3IqQO/YGlkAby9uUi+nXx49bOd6VF6XIiRDEpOtK0DQ5EJ0YDQKr32/ql9kcTf+7Ieu5XFvRXEm50cNvBqRRbm4a0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792191; c=relaxed/simple;
	bh=NQ8J43I4uNCJEJQ0QsFSMKAS5RFA5CEyKQ6v5lKmyLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpwsNTXYMUWUXLo1L77uqUN4gTY3fft4YTHL0G7UFDapKcsLDWTsmYA4ilZz7oI30IBmjCtoCuktZZ+haEBLb5OQpBaaKs+lpgvy9BqJ/rbTo8sTdhUl1FLkOn1uHHaStObcu/+xaT6qhaWirWltPMegrknD5aC2x6SjlHwxL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACd35Qs0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c6b9fcso56054441cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759792187; x=1760396987; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3EJTfcu8h4GhEEKd8FZr25euFK3dzJW/aZJwSSRQB9Y=;
        b=ACd35Qs0tflW5xK4gwx3MfmO4jWIEj4rT8bVEoZx/sPO4ZoEMIn57TRsRFXG6PaJFy
         cQoqV5jaN5CFYk8jFkbvr2w9inz4Nas0uovcRIFNpHSdwNY+dbrVdU4hPoOhwp/sbRiO
         1ocWR4W8gw+g/TWIjKP6wgP2ekGUg5UPinCv8vCxTVmirdcbKI3HKYuTcXwDihUfUd+i
         8NN7ihRyOCjF/WiwAAB0A62w4TMvD2Z9n8vXnOQ87U4h20hVEyhzJU05Innv4BLzAHfl
         BIqpaygfc4E+iTZ+67UNiFGseQs/QhdiyIcbNLbQSPOFj/FJICl0odXzrJrqeNyVxEKV
         1PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759792187; x=1760396987;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EJTfcu8h4GhEEKd8FZr25euFK3dzJW/aZJwSSRQB9Y=;
        b=lApJ828a1eW3UlcWWW+Pz3o350yEVUe2S103FzSwTT1MmTu6rP5cW5tTR3xjUlrrfu
         rHZPeKJIpr/kcGuK28JC6JRQtoiXpVVJcHeitAPNElNWWAljj0xDnSKOQZr8jzgz+KF6
         q90dG/gyylCr/DUPMkWWLl8OhHC8ypuO5WwuZv6YF/hoZ/LmHSHcDDPk/bzQIOLM9FZK
         W78f+PTha8f/xBInkcKE1gsQ5eUJNGVR73hBPHylGJi9egavYJYkLfZDZvj+C73WVLvR
         SJ1SfNxCmHwZFr0gP1f8CCnIm/hI57+0SbETfN+zH9aehrYBda1Jdy2HqQFWWCgYnoeA
         bIpg==
X-Forwarded-Encrypted: i=1; AJvYcCXMZK2AFx3+Pd07rYULtRPlcA7mU9NZ6SIcuEVDCfd5DLjIptRXP8O+iNppbZrhFF3umRgpCRZ4Mgpe2no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNNWQJGxA0HyEOKpEpysMnfX7nKp9Pa8eqVEu4rEtsfBhGgb1
	j7B6m8wUz3iafu2Tsgaf0qDsn7JlQineDdR/KbSoP2p1B5JGL2Uu2O8j
X-Gm-Gg: ASbGncsb8/o3OD2+5RE/NcwwbMW/IfkN3DhtPeCrMhM5mHQMnDdIYZiQ43QTphZgC3t
	gzI3bOrHPCFRLdUsl2y9GyOqNQYaWouH/+c7CpJBW3ckm6ax9aUzrhZKlQen8QCq8W+u0pk0IZ+
	zlfDDAIkmN5g39TsXZDK/oCWgPYAMPXP0oGtz+F1VPeIYCLJ1ZLu4HTUz9DMGM0q4T4lzz6vUPF
	+9OpzjVOvhh6g6aeRHTZKIA6LBdBa5OfKWtE5H7mUNPWw0r3sDn8nq/eocyFV5x3nKb43PRzTZm
	x/IwomAEEjD2VvWnbGxqstAsoP9bzmVgQ77K2Y59YMAwbkDabrpFjmU7vQTGUDiL3Sxjnb9lS2R
	JnevxtVmHI56DkTgmwcrASFNXCTdlbG0xUgMdkmTWtIdP9eO+UZlK6FM057rQglTyQ2TumEY8/d
	DAv2S9kxD35JCG9J/Gupt68eigI63MvYr2zIpCl61FH7QvwtQ=
X-Google-Smtp-Source: AGHT+IFreUBAqPeM2h2ornDIoHcelDSJDRklng9KnvFrE/xsqQejPQGKywtCZzD+qAhNnKO9SG6+Wg==
X-Received: by 2002:ac8:7d8e:0:b0:4b7:9f86:8705 with SMTP id d75a77b69052e-4e576b15df1mr138802431cf.65.1759792187194;
        Mon, 06 Oct 2025 16:09:47 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55a34b607sm131310111cf.4.2025.10.06.16.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:09:46 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 887B0F4006A;
	Mon,  6 Oct 2025 19:09:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 06 Oct 2025 19:09:45 -0400
X-ME-Sender: <xms:OUzkaCQ75Y-hcc_LvPhoJ0YN6Xgs0nsh9PWtsv0mylW7vQNHvyVX1Q>
    <xme:OUzkaAmUpnMh6LBCkU_sV76O5HPD5xqkhXqvTWethJikQUqhadii5q9lwk2vKIFC9
    MuIghayWuNacFY7CU6kO8z2cBACJY2_DMYepgi_oSq5TuMgJpOw>
X-ME-Received: <xmr:OUzkaBLPCsvOYl0oh78al3vBl2MQskwS19troTAiNz2wKRO1nv248x_QIMh6mtJ3Q1qtdK7taENqPrpdwl9wTBPLAaCw5F6gzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttddunecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomheqnecuggftrfgrthhtvghrnheptdegheelveffudejffegvdelgffhhf
    elkeeiieefgeevteejvdegveeuffeihefhnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhg
    peepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvud
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihorhhksehonhhurhhoiihkrghn
    rdguvghvpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrg
    hrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhho
    thhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:OUzkaDRba0ULP75wnv53fSYRkJdNYns20KlkrHscX4RE312vaYkLEw>
    <xmx:OUzkaPQ0Utk0y1dB5o-gqieUeM-tP7w4sVXwMyaWSOcSD0jz9Pnr6w>
    <xmx:OUzkaFxhqRJ5jZV_eWHsL_c3SeMLTkhl6_3rnwpVDgeg1z3nXrHg_g>
    <xmx:OUzkaFvj08Mb_nWTPWlrCvauDCMQRZxBY3f4qbOBhhg6aNwwSbWPdA>
    <xmx:OUzkaEzTHRa-phZDTucTY704fcIZcWxJuFGc1c1DSnfy9p-rtdrayqdR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 19:09:44 -0400 (EDT)
Date: Mon, 6 Oct 2025 16:09:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	linux-kernel@vger.kernel.org, acourbot@nvidia.com,
	airlied@gmail.com, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: xarray: abstract `xa_alloc`
Message-ID: <aORMNreduCPSIL82@tardis-2.local>
References: <20251006163024.18473-1-work@onurozkan.dev>
 <20251006163024.18473-2-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006163024.18473-2-work@onurozkan.dev>

HI Onur,

On Mon, Oct 06, 2025 at 07:30:22PM +0300, Onur Özkan wrote:
> Implements `alloc` function to `XArray<T>` that wraps
> `xa_alloc` safely.
> 
> Resolves a task from the nova/core task list under the "XArray
> bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
> file.
> 

Having this information is good, however I feel it's better if you
explain/expand what exact the usage will be on the XArray, otherwise,
it'll be hard for people to dig in the history and find out why we add
this. Thanks!

Regards,
Boqun

> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/xarray.rs | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> index a49d6db28845..1b882cd2f58b 100644
> --- a/rust/kernel/xarray.rs
> +++ b/rust/kernel/xarray.rs
> @@ -266,6 +266,45 @@ pub fn store(
>              Ok(unsafe { T::try_from_foreign(old) })
>          }
>      }
> +
> +    /// Allocates an empty slot within the given limit range and stores `value` there.
> +    ///
> +    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
> +    ///
> +    /// On success, returns the allocated id.
> +    ///
> +    /// On failure, returns the element which was attempted to be stored.
> +    pub fn alloc(
> +        &mut self,
> +        limit: bindings::xa_limit,
> +        value: T,
> +        gfp: alloc::Flags,
> +    ) -> Result<u32, StoreError<T>> {
> +        build_assert!(
> +            T::FOREIGN_ALIGN >= 4,
> +            "pointers stored in XArray must be 4-byte aligned"
> +        );
> +
> +        let new = value.into_foreign();
> +        let mut id: u32 = 0;
> +
> +        // SAFETY:
> +        // - `self.xa.xa` is valid by the type invariant.
> +        // - `new` came from `T::into_foreign`.
> +        let ret =
> +            unsafe { bindings::__xa_alloc(self.xa.xa.get(), &mut id, new, limit, gfp.as_raw()) };
> +
> +        if ret < 0 {
> +            // SAFETY: `__xa_alloc` doesn't take ownership on error.
> +            let value = unsafe { T::from_foreign(new) };
> +            return Err(StoreError {
> +                value,
> +                error: Error::from_errno(ret),
> +            });
> +        }
> +
> +        Ok(id)
> +    }
>  }
> 
>  // SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff `T` is `Send`.
> --
> 2.51.0
> 

