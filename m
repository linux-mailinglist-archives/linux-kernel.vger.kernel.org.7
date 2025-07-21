Return-Path: <linux-kernel+bounces-738826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 442A2B0BDBD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714C518894F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8AB285049;
	Mon, 21 Jul 2025 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGGSv0HF"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A3283FEA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083321; cv=none; b=pir5iYWOeXedS7oPebOap22MkNyC4D7L0rXR7wRlbUQj6qvviUBQiQaZiLxNR0mOhPvx9jOBF63lDfjd4h2t8BjFfxj42QSb453mmeIZjRJtSk7pVq8huGdcszeZzj1Ive4NfHq4dJsS0MRCfHnmfam1tiLItEvJSZgWZWKSHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083321; c=relaxed/simple;
	bh=75yem3WjluK+t3HLkk9qsg5NT0tv+wkaJxCTWsY2V44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfUb0CGFBrB5onNHwmCxg3a5dHmqFcFc1isvkThZVEZpZE1M1DQu0jbbNMZ6i8hbxZf6ywMfi/HgCMauOWKxNYe3/Yf9XYNS8PJ73w+XijUXUZVvHFZAGzv2u2+ChexyiMJzXxN7DhkRgCSfsqucKNlZAb8ABooEBA+ZyTGoV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kGGSv0HF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167afeso37773695ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753083318; x=1753688118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5dBnPu5UuatkXMTVj9BGvrncU8K1V9rUHxc0C/1nEk=;
        b=kGGSv0HFtXZDd/hf8OoliuSHGqTcVMDJmtt+p69A1UB+zSfVBODkqmNY2aiPHYoJ14
         jKSpkiU4TkRSUkRSbw0Ul6L+xEDsIRhAU14VTBOpBdsVfZ7bDP/mYjfhawa56kHmO+yt
         VfYUKhjdZ2yZAEx7YrVTb7EJhbrpEa4qkk/D+9qoZPDhY9pwkq+GWNJR7AA4k9U8D+cP
         FlcC0hoB9s2ztApoLKJoZi4qBmhHvI9z5cGSCjJzgfSWVGJrSElYYe8wV54Z7Y/UyQcg
         GrZva1rov1N6CJUCRIDCDHOpo6BODt7/TRHIWuLhSAAQYB8fZ/Trcnban2blXlBgKjbp
         p/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753083318; x=1753688118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5dBnPu5UuatkXMTVj9BGvrncU8K1V9rUHxc0C/1nEk=;
        b=cn07T8YzPdnOy/1W1Z1XejpMjC9hX9dDaKVd+FnNJgegqForvSWL4/tnNMwK5g7yHx
         8fqZQrhc2Os1AGtJ2hr2nIUHrhl0+ECZiskjLgp2So8FjwStp/m1G3bLEK/TnJ46sijf
         zSZq5weWixTORT60A6UglOpOxjM8Z2st0QmE6X0sLht0jETt7GLKoqBLVHwm5aI0ARMO
         jn8sshYuZN1dKOOKmK9fo9U3hHChCDTnnJWzC8rUNmrl4Dib+z3hXIvs+/tQlM4A7jKp
         OSp9dD23jVaUBJFt5s1y61+Lgy3C6TyeLUdCwhHi+yFilIXuvKnAlM14eExOJY4G5Bm8
         Edeg==
X-Forwarded-Encrypted: i=1; AJvYcCWeoF2S6rcpqHjulsJbColSPVEE5E1FZnAgQbiQphROlDK56seXW1L8WP46dvg9THRwMVZlDwnJn3+IKpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9O2zOECOczVTod+rOq9hJJf2p9D3qfbZvs/jpSTu6tk8Bjgc
	2HcT99BbHZ0CkKFTIBzkdlZoPuJD0PRIQRqUsGCc5yq3BglvcU9u87sesJ5VVh/YvKQ=
X-Gm-Gg: ASbGncvXjaQ9JaqMVqArFdGugIOhicVM/R401X0HmTkSE4odCEqmvKlR2I0p31yu0nz
	9p87CmeMKH9MxgcfDSdIAo1MeKfb2H4eD5M+0HRBzEFUXJlNftQPsHwvn8oh5+Q9CJokQfh5C1m
	2IxD7i2xypOqd83UdCSPJm6oGplVjRwcF7v/qmrV54ymaoSniOUYVNC8+7sg+/3Hl387pOc9KI2
	Z234Ftrp5MCTe6WF7UqD385LFjDhO3BDBKEqEOE20Z1utn0svzr59tk0QPJsOgm31M9y0ilKu1t
	uynpuHmh5FJ/1fhQkLaGalEARizFFh8JpCjhW0rY74qvk7B/BFwc4hQnjzvPSBlNY6y1/+4u70x
	df5TgIYmkg4qcqz9ToaCsk1wtVO6SXo5VWQ==
X-Google-Smtp-Source: AGHT+IETNDRZoddMesKOQhKRvcZzakzOmMfiCHJxW7eO5wvM2qbmpmfxE8rY5ugFlkzEUO27/HUOzQ==
X-Received: by 2002:a17:902:d58c:b0:234:a139:120a with SMTP id d9443c01a7336-23e2572ab00mr258734915ad.32.1753083318367;
        Mon, 21 Jul 2025 00:35:18 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d239dsm52577175ad.155.2025.07.21.00.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:35:17 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:05:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/10] rust: cpufreq: use `core::ffi::CStr` method
 names
Message-ID: <20250721073515.2srip46utnyap7fb@vireshk-i7>
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
 <20250719-core-cstr-fanout-1-v2-4-e1cb53f6d233@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719-core-cstr-fanout-1-v2-4-e1cb53f6d233@gmail.com>

On 19-07-25, 18:42, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoid methods that only exist on the latter.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index e8d231971276..71d601f7c261 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1018,7 +1018,7 @@ impl<T: Driver> Registration<T> {
>      };
>  
>      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
> -        let src = name.as_bytes_with_nul();
> +        let src = name.to_bytes_with_nul();
>          let mut dst = [0; CPUFREQ_NAME_LEN];
>  
>          build_assert!(src.len() <= CPUFREQ_NAME_LEN);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

