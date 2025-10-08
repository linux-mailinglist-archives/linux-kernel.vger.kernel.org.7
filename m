Return-Path: <linux-kernel+bounces-845713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE953BC5FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE015403F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E48529BDAA;
	Wed,  8 Oct 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfSdeRqD"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5A25EFB6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938976; cv=none; b=j28ygtxk3VVxuddwThyqOoDe5YQe69DXIMnFjQyY7wIAX//KM0Oi7h36DxtpqvthdCXoHr90lfMOBFem/ouRFv9qoeIHLxEXPjqJAROfB2omN+JeqNXxMoBhOoPZKwR+JTpC2omCjlcGDZbbzDQ+VE7ijQEC7su1XdrKQf4TzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938976; c=relaxed/simple;
	bh=eecEdOXcvpQE5ckhRbenhXOq+0yEF6ISwrbgrM35NgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgLgtXKvLn1XHhIvH2TCDzFHNmM7QUAD96B1vfA7+WPoN29VRinoPC7b3jisFh1pyJmYsVNzP8EsGWaB6JNoP807RIsVIr6ImtyYMI1eOJ6yAOTm83AXzgkg8coMUb0H5rUb2obZBhdbXzmuUWu78RKbfhk2/RGKUlTg4olpk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfSdeRqD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7946137e7a2so996576d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938973; x=1760543773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFEIMC2U9jb57qswe7OpbYJsyYuAd7DLz3tJrfS5gFQ=;
        b=nfSdeRqDzgYXhKMYOA5OAv61Gy/A6Yz268vmUpoBSuTOxLGjZabf/U/nZnPIO1J91+
         8v4sNwevdx/XpAGzcPC67NgkeMfDjNQOENX+Fh1SXfZxkjbEQEFm1vKv+Vy14HZotuNU
         AbAf3IuoVoCOuhg/GDyLuZZxYxzX6PMvYt/jKti0pstwAlv8wEmUUFuE21vALr3c1OCm
         +0euUBI8QqouLLiYJkQ+a6RCfC7WE4fIa5E5za3dD+fMCwhObXiurRfmtP50k9wZxHLu
         TOjAneC+xx3/iOsg7TDgijc0izuSD+Q53NzstTANC/Uxla+rWsPbO2NUIgo8GMD6qrgz
         wQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938973; x=1760543773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFEIMC2U9jb57qswe7OpbYJsyYuAd7DLz3tJrfS5gFQ=;
        b=QzbDvQ/05Zs0XHo/IKXpI6uY8HW2QzhbDftsF1suo9LXi2zFmvjR5YT2klW9phaZ2o
         XuN1cGWOvUIjAwz7R6G7OYCjYmHFyhm1Wsa0yg6LzkePL6vnZ4y4DBVMxhMo8EEyPr2O
         SjZoLxvsJUbZ8K+/IoGf3g7REIKD51GzgBXgh8sIBv0xqFoKJ41RzzLJq9adsLzg9IXb
         HARMHOvPAMMXBGf9U7jMO27F7t+rietqmEK/o6eJPm/K3IIhqBT96WexjLLcGAgvWM6m
         1N3v8Hfi+vNUsbFifolv1AcvlU1hR65THxJBz4ekF6cEsBt87pezJ4n7YFHbTwG6w4ND
         zG9Q==
X-Gm-Message-State: AOJu0YyHVZFPfgSJXxGd6R/4P33RxahSneWfd5Qu+kKogZJfbRaUvIv2
	/IkQxC2fhfw3/+0h6nq/6wV3Ca1z0u0AJLybNi6/sNMdRIYtAc4Bzm8j
X-Gm-Gg: ASbGnctNVU/50XE0kxikqarFwwQuRS3infsVUZtqxq4uXpJOCXy7LmAeqGZr5u1pbBw
	HR5B5hLBwhG5/vktk/jT3Y6EfQdMx5O9mTL6LHnuJo9IVqH3NElmVJoXEXPTBJuE6sW37rLh0xy
	EdFWFeEmG9mVSJ3hkpost+hYdahEaM5Y+R8cp5fFMPXHJmWp89Kl0QTpXlDWOrM6kAS0CJycui4
	b9Csih7vuUfvoZUIAIjFemyFtHYKcLu6ooVfdUCQzmFV9c7IsfINXWclsrLTa1Yqotb4d0MQjfZ
	Q8YEZXOctJCIflgbsSBxQ0tOki6jBM+Zp5qcyxbNfuDe76FEN0FeucxXaicOe0b43MS6i+wD36b
	qCsuJtzZz9g90gXZV+hkDA7nvRdLTje9IGaZ4Agsyk1Lr9tvyZsBFATN9avMtQjcs5hyNI8F21m
	W3cUM9vk340eaI1DL54AKeA/pCHOIUGCkg3vGYAykBtLTqyYI=
X-Google-Smtp-Source: AGHT+IFnsP6b3viJv8/ZjQSPmyqTukLCG864oTDaEeVKrhW3aBRAqFOSfqGTwi30ZMtg70D/Qovaaw==
X-Received: by 2002:ad4:4ea6:0:b0:73f:a7c8:980b with SMTP id 6a1803df08f44-87b21001056mr59669626d6.4.1759938972538;
        Wed, 08 Oct 2025 08:56:12 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fb57sm166271366d6.62.2025.10.08.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:56:11 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 706C7F4006E;
	Wed,  8 Oct 2025 11:56:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Oct 2025 11:56:11 -0400
X-ME-Sender: <xms:m4nmaNMPdssR-w678MoKxNjT5JgI2HBwFLRHw_XJ8ysc8xvcq5TiRA>
    <xme:m4nmaBiMrnYw8q7z0sVCT67quT5kCPQp3uzXNsQtx61g7ILQVO2ZhZeVaVicNu8BI
    hH5F86FEYU6Q3qCQUbmSdllvx_4toD_gnE-fLYtFc5GUq1sZt3Q0Q>
X-ME-Received: <xmr:m4nmaLjM2Zb2J4qR7uobfQgzl3EYA7WkCKNy5o_VS7MosMASLW9STjMue7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejffegieejvddtgfekkefhjeegjeevuedugfehfedtkeffjedtleeiuefhvdef
    geenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    peduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgtohdrtghrihhvvg
    hllhgrrhhisehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinh
    hugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtjheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhirghnghhshhgrnhhlrghisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegs
    ihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhhohgtkhhose
    hsuhhsvgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:m4nmaAJMSF2dHxU4DqYXtkgdd5r9de_OkEORjVangMGQHxmGSfUQcA>
    <xmx:m4nmaKk2g0MPNjxIL-Wcgaoz1sXaIQIHYFtbQVipTAEUUL2CfJAgLw>
    <xmx:m4nmaIOaMObif4Ftq2TSOWjbJvb7GAUpB3_ybkDTaV3UIlZltMAY2A>
    <xmx:m4nmaE6dNzXs9ZnS8zjfyj4Lma2sGTQVQD6n6D8O2tR4rwego77WIA>
    <xmx:m4nmaMatV60ev3vopmh080nzBd4QwEwZKo_y29vnl9qkw1ka7i0i9XzT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:56:10 -0400 (EDT)
Date: Wed, 8 Oct 2025 08:56:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v3 2/2] rust: add system_percpu() around the new
 system_percpu_wq
Message-ID: <aOaJlHEPzHcAdcUx@tardis-2.local>
References: <20251008151554.340806-1-marco.crivellari@suse.com>
 <20251008151554.340806-3-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008151554.340806-3-marco.crivellari@suse.com>

On Wed, Oct 08, 2025 at 05:15:54PM +0200, Marco Crivellari wrote:
> The C code defines 2 new workqueues: system_percpu_wq and system_dfl_wq,
> respectively the futures replacement for system_wq and system_unbound_wq.
> 
> This change introduce system_percpu(), that use the new system_percpu_wq.
> 
> system_wq will be replaced in a future release cycle and should
> not be used.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

If we were to expose the system_percpu_wq to Rust, then we should also
add queue_work_on() API to Rust, otherwise it's kinda pointless IMO.

PS. We can use the CpuId abstraction:

	http://rust.docs.kernel.org/kernel/cpu/struct.CpuId.html

and have an API like:

    ipml Queue {
        pub fn queue_on(&self, cpu: CpuId, w: W) -> W::EqueueOutput
    }

or maybe a different new type `PerCpuQueue`?

Regards,
Boqun

> ---
>  rust/kernel/workqueue.rs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 300cc2bfe012..05f213444b91 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -940,11 +940,26 @@ unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for Pin<KBox<T>>
>  /// users which expect relatively short queue flush time.
>  ///
>  /// Callers shouldn't queue work items which can run for too long.
> +///
> +/// Note: `system_wq` will be removed in a future release cycle. Use [`system_percpu_wq`] instead.
>  pub fn system() -> &'static Queue {
>      // SAFETY: `system_wq` is a C global, always available.
>      unsafe { Queue::from_raw(bindings::system_wq) }
>  }
>  
> +/// Returns the system work queue (`system_percpu_wq`).
> +///
> +/// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
> +/// users which expect relatively short queue flush time.
> +///
> +/// Callers shouldn't queue work items which can run for too long.
> +///
> +/// Note: `system_percpu_wq` will replace ['system_wq`] in a future relase cycle.
> +pub fn system_percpu() -> &'static Queue {
> +    // SAFETY: `system_percpu_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_percpu_wq) }
> +}
> +
>  /// Returns the system high-priority work queue (`system_highpri_wq`).
>  ///
>  /// It is similar to the one returned by [`system`] but for work items which require higher
> -- 
> 2.51.0
> 

