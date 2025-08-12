Return-Path: <linux-kernel+bounces-765395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E70AB23210
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA628166EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2F82FAC11;
	Tue, 12 Aug 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDkPZEBs"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AF305E08;
	Tue, 12 Aug 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022063; cv=none; b=pfrG2N8fHgIQmfrzK8mDzLGvnOi9Xk6gfrT/QLRcJ0X/Ze9OewkekUn4vbT6ebKyWjsJRierLKmUX56CbLvWUQidsyv3s9rhiUUIxu933d4hCCE/FSDP2FeXJxPUZS7aZMGeHd7zfwfARMlF0U3Pgu3H7ev+dXAW+rN3TD/QosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022063; c=relaxed/simple;
	bh=7tVlMxBxSUqDkQ/YT+j6av2beaKwd8lQaB291K7ue9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUGbgWL1vRK+gMgRq7DeeT0JkdsfCHHmtPNfaf2khm3G8xfhnDTjnkrZ2cklIjg6PAlBHkVecGzhuTEqrATAZkpRnUzZt/kDsnfo8jrCwWanlhDPYwEQNRZgc24aZVs5HEUb0ljS/dF1So2iv47i9gu9FbHb8MIO92wbWTN1R14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDkPZEBs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23fd3fe0d81so54892055ad.3;
        Tue, 12 Aug 2025 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755022061; x=1755626861; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7tVlMxBxSUqDkQ/YT+j6av2beaKwd8lQaB291K7ue9Y=;
        b=IDkPZEBs9R1irTV/l3N/8Gm/AS9GNaGXDrnFu0qB3TPQk98dt1JFP65/8w5PesFVNJ
         pbdgYJlzoKK0kUAoqbgp99VSVhdGXuO05CmMp9rg3ZLWrdU67fgiBPnVUVeORIWks1Me
         7swpFiQbSVmag+zyTx8Z7s3sbjI4F347f8iE3zEat8seHxOPQlDDPSa6R1ZpcNPW1o8F
         wqPYretpBTYEkJFR7Ht6QqZmR9/izoeEbptT5FH+R4FW91OcvSEFD6ROmd2dMYzihDcV
         3vma2fAWo35Z4NWxiEXeMGPDtgsV1d3BM/VLyg6Q7DhKeURWYGMIGtXchNPYD/2lIcrs
         NI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755022062; x=1755626862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tVlMxBxSUqDkQ/YT+j6av2beaKwd8lQaB291K7ue9Y=;
        b=irkrS/20ETfpyZjCHtMK0h2vcyBy8+QvbSVsxDRjTvU/LWvMlh6K2WKejRd12IJb5D
         +nt0tkYrej5Ghh3r/rHUxkeDiP/MUCPfPmUjmn7M9YTcHxnwJ1Y64Dpk/5GHnpjdDpK/
         XMFbceXyTb1WDAPHT0gQtJQ/Jqlojr1vEg0g4e0MmNnp9PKYcp9fB+Fj9tbVYIIg48mJ
         ayah7wwTzZj5C31+PiExj/hVa0FqaUJzxUhCkH4CGMb4xNmnGbXV3CqYeOsM+J0xGYty
         1WhkvSLXgYBA5dkFeymkgO5Ig+y8M2URMroAAgIZt8XaD3/O51Btyh1fAqQT948LI4bV
         0oSA==
X-Forwarded-Encrypted: i=1; AJvYcCUuYsvMJFG47E+QPP+uiPgof1ySUl2r4NCfU2dog165FiBH6gG/5VjrH8n+IlW1rL6RxzjTBK2pSYkO5Fc=@vger.kernel.org, AJvYcCWX6DvKU9HzcqrsjijnWmVXPp/rR2pFiBVlbvCDiOA6LgdzZryn5tBq6iYalPfIYW3AsQcMmpqqA3/HSNLXyIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Dk1mwLsUy8KSldWFyCI8NQYqdt6My2+ajYWwwKAnKl0lY40j
	FtMTFXDcjpZSditc0IRLbXwUtdAMLqFMoF2TKazEO3zWLimyzffOQxnF
X-Gm-Gg: ASbGncuuEKSR1z0SJfU97mfqZai4hQ80yBwaw60dVN8VyuuLyk0n5pcPy0YxR6D8gw9
	FCW/PSKu8i6hRVZj50omARdcWKHWWwVOAYYsb8znL71Fs3QVRh9wHW+SI0/71g7fjjOCyUHTaaS
	1svrAnLFIcFNeSxfpWKC4L2V9aGxWDG7hmE9Uyx7nL6/YuImSNwapog20HaSgT27pTnzy6IZdI+
	ddzC9wLDT09xUgLGO+rNGNx57ejIRK9rr5WUFvuMHK+qm3Zjp92Q4RPCK9DVsxTKaPH/Lcuq6nY
	60w8ldYa8wCsugxOPEez8l2PzT+WMHnm+QMJxUr99hyLbdsXEzr5k+j0R0tmK6MyWk4DNAh66sD
	jZHEHoehrou52IKh4TaGeXjXFLas7Dw==
X-Google-Smtp-Source: AGHT+IH2eAbhw6s8RrO6LOuLceoPWy7RgMZVatbE8YimrP9qcp0B/w2fFg+C1Bb2gud7MsEdF4yB8g==
X-Received: by 2002:a17:903:2447:b0:240:9006:1523 with SMTP id d9443c01a7336-2430d0b1ea3mr2286925ad.10.1755022061514;
        Tue, 12 Aug 2025 11:07:41 -0700 (PDT)
Received: from fedora ([2405:201:5501:4085:eece:e0ff:6b68:de2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a077csm305678965ad.138.2025.08.12.11.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:07:40 -0700 (PDT)
Date: Tue, 12 Aug 2025 23:38:06 +0530
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4] rust: kernel: introduce `unsafe_precondition_assert!`
 macro
Message-ID: <aJuDBtpYijOBQUJa@fedora>
References: <20250808192005.209188-1-ritvikfoss@gmail.com>
 <202508122341.rb7U1Q2P-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202508122341.rb7U1Q2P-lkp@intel.com>

If someone's referring to it in the future, this was doctest issue.

It’s actually the second time I’ve hit it.
On my end, this error wasn't occurring when compiling the kernel.

What I was missing:
1. Enable `Kernel Hacking > Kernel Testing and Coverage > KUnit`
2. Enable Doctest in `Rust hacking > Doctests for the 'kernel' crate`

I can now reproduce capture the issue locally.
Won't happen again :)

