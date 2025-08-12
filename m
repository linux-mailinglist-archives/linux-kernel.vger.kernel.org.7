Return-Path: <linux-kernel+bounces-765602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E64FEB23AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7621B66DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4222D739F;
	Tue, 12 Aug 2025 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFPBjmZY"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D0270EBA;
	Tue, 12 Aug 2025 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033961; cv=none; b=TZ10YPkiS5cPHyZK6G+L5wxnMZOXfvTE+TBdZaAApUIj/OZSJAm/GFsgwP6rForbUWgqMNf9BbOk+8K5zz9MZi2n+KL0ajrASsVmeyvVlZrspVr0Swgih/cHWHQF1hiP41veEGi71cAcE8S1F72yl949vPizXD4FLOnHUQPd0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033961; c=relaxed/simple;
	bh=QsczK3PoMDKgHLqMUXABZVq0fMFVJStyGNK0F2JQqq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbKCBC5G4DYPoygraX4V4RKCV/LnSj3gPXoRMpxVlCrQUkjO513z9dEncqhWpb1kKkoa5Lm0qFGSOJGF1xjwQ0TK4V8fDsGybcoV2zNgElOLUErkov19wSPefkVISf4F5GZOlzW9RQx1jGCkG/JHiadoUnlCJzn+iXJfZ3GapRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFPBjmZY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9170db547so124392f8f.1;
        Tue, 12 Aug 2025 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755033958; x=1755638758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LUXsTMGS1hoLJRdMmGStWy7qZBWo6O3VqHZsniSFB58=;
        b=ZFPBjmZYeIV9QRGSk14kXUT2hfI+7EKsiwGwQ3nVFKJK7AYAEdUis/JdN/pGhEE/Td
         gXpAUgPbmtxX0C7sU/Nlm2J72f2XgNxcoMUJVx6byZ5s/bcVZj7KOzwvMWpKjA5lrJZZ
         ConstE7oU9Sm5OviulReQAlnZe1eO1u4PYAfOBV+wfZB7H8xQxBB4EN8KPqsO31Lt706
         nkhjKWnI6VjKL9El87tVsx80O1jk0JRTVr8aN5nFlk87WSpEoAiB9PsbHVvY2NGoePdU
         9RqNJyDbuELPHZ5uSLk/W7IPz27upewSQT1EC7Gkb2ATqUd6lSkjWy+mgoADJIglRtAa
         1nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755033958; x=1755638758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUXsTMGS1hoLJRdMmGStWy7qZBWo6O3VqHZsniSFB58=;
        b=rZUf3QP0XkFa2cjAcB+NLhqLkD9I+b+kw4ZyWlcaw3aUxz3Z6o5PNja/2q6A8E+nf4
         Pz1pTHkbepY4jPcR4chR2s7FrvEMnMusklOelsRl/mI8woc4I3NnAaYkIhuLwTDFyZNX
         G6ffz3meiVUNwHG4AnvhscT9wEd++BY6/PtlrRHd5jqYwOd9M0jX9JsFpAroXdtaBmtV
         OSzT4RPuUtnjTOOmZaQ+EGTjgX0htrjovQ9ob6d2S3t1LCH2bOWJ8su22g4+B9i/Sgdn
         jEDSDiZXFEcLm31DqhvyDuprL341fUmeMwuSxoSR71CdeVHFT/uy9lQjA3w31mPPO3Sv
         kjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhobMXdrkpqzlgBP0s6lqdiHKMoyId0M/+su8AoeNwsdy2KuCKJFTLFcpvD/MBjGXvF/MEthnOCO5adxC2zQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHhKlzjUEEHpYgDbLYWc0dK3JHyIMqGAWOtGQAq7GcBZZasmv
	vD3tRKOnS0jKP6VlAFlkiagwPhwLXo2C/vuWV+T47B0W9eT/7RLtpPRGf8DNHA==
X-Gm-Gg: ASbGncscS3/igEtezOiluoMz/X6IZntt9ZT1CEUktp0dAnxSqfndpQVZfFpPTqftgNB
	21mPL6Og1b56pFZsl3BQdgSfKaZDiEMeAVnpLhwNAK6vJAckKJzwa2d8ruL4IVqUQ9jMdZwRb7T
	J6/fbcj7opr6bvviDQxdZ3G7UVs+ZQ5f7ttKrp1ovVxBK6QvxWNCqlV3ZEtIlBa/TNFOCoyT/Tb
	WqPA8/kjlmBQiO2VCSDcUpkzr1oz8PuG9nBGtCvXy+lOaQ900anSp95uNe50jBirJoeUqIBU5kw
	NJAUliKKilQozbWQ4582LdIRbYvPORAX6i5VxFTjZ92d7Ge1IU8Xbv6QZ+/GIxq024p7as496FP
	tcH4kAb9GeenU45Fw+eSDQMm2SA796A==
X-Google-Smtp-Source: AGHT+IGxtGU1Wd6l714Qe6Xu+u5PrVWcM71n9/QDnRKPYwk0AfHVE2Tl4ZwcKT/IX4cm3n8wIOjA1g==
X-Received: by 2002:a05:6000:3107:b0:3b9:16e5:bd38 with SMTP id ffacd0b85a97d-3b918c4cebcmr51195f8f.4.1755033957868;
        Tue, 12 Aug 2025 14:25:57 -0700 (PDT)
Received: from fedora ([2405:201:5501:4085:eece:e0ff:6b68:de2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b90fdc85a4sm6229401f8f.60.2025.08.12.14.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:25:56 -0700 (PDT)
Date: Wed, 13 Aug 2025 02:56:20 +0530
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4] rust: kernel: introduce `unsafe_precondition_assert!`
 macro
Message-ID: <aJuxfHaslGAlBJTR@fedora>
References: <20250808192005.209188-1-ritvikfoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808192005.209188-1-ritvikfoss@gmail.com>

> +/// # Examples
> +///
> +/// ```no_run
> +/// # use kernel::unsafe_precondition_assert;
> +/// # use kernel::cpu::{nr_cpu_ids, CpuId};
> +/// /// Creates a [`CpuId`] from the given `id` without bound checks.
> +/// ///
> +/// /// # Safety
> +/// ///
> +/// /// The caller must ensure that `id` is a valid CPU ID (i.e, `0 <= id < nr_cpu_ids()`).
> +/// unsafe fn new_cpu_id_unchecked(id: i32) -> CpuId {
> +///     let max_cpus = nr_cpu_ids();
> +///
> +///     unsafe_precondition_assert!(id >= 0, "id ({}) must be positive", id);
> +///
> +///     unsafe_precondition_assert!(
> +///         id < max_cpus, "id ({}) must be less than total CPUs ({})", id, max_cpus
> +///     );
> +///
> +///     CpuId(id)
> +/// }
> +/// ```

The example I've included is incorrect because `CpuId` inner field is private,
so it can't be constructed this way.

`CpuId::from_i32_unchecked()` exists, using it here would make the example a
trivial wrapper around that method, that would be unnecessary and confusing.
Also, I wasn't sure about the doctest config when I wrote it.

I'll send v5 with correct and much better example.
Plz ignore it. Sorry for the noise.

