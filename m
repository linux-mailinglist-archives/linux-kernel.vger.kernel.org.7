Return-Path: <linux-kernel+bounces-835987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 360AEBA8848
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8374F16FB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F74C27A442;
	Mon, 29 Sep 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQuT+Sin"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EE27FB3E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136729; cv=none; b=NngEwm8QoqKLlwWii33itL0mjglukFfLaLBvvqrL7V/ZEgNtmvK0A3lNZoVpNT7WJT7qtouT8woMhMYaMRW9dGRJTcgzyzyjzhY/u1AeKZ0oVVRBfyWrxWzjqmAsrciXSsyBx9l7sPYF/6ortlc01lrvH1pW2hGOc6qEf8Zfzmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136729; c=relaxed/simple;
	bh=VfNfnv8T6wFQdjBp99fQCp6r0cFMOOnZqrGR1VOZ4Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4kh+7U784FbY5Kl2+O7E3t3W8GZaxri6VQQ/PSgLFCZeh8Jd0R5i/BfNC8JY9HAYXW8oH8dCAEVH0AxNsd0WW6q5DH2VVX05v66v4S06TTcNCgQZKbTyyyJQvPfRCJvx0P30hD8y2rWDpB7CDZvBtARVmTi3atkN05iroEnaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pQuT+Sin; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781997d195aso1119978b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759136727; x=1759741527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=isWBuGrVavExFHtjWRBMLQZSe+K9COO/1eBnPARTDvc=;
        b=pQuT+SinCmUVQILNLEhC0rLBJxvptZZ68yza29Q7YF/0sFoAWYr6SQWjwa6vnFUKhS
         Y99axNibcizHwdnGcAtGHb4gpc8z4NsCWzzQ9QZeblAbNzMT8IKOi9KNoGbF/pHH2jA0
         qTQ3PF8lyGytdBmpPppmZY4C7c7BVFSmaQTM/cJZh0vZtMfxHGNUo7N+QlO/YfOk5klp
         DkluIIa8avJj/Dk/0AokeWuizv35icsHlI6902MmnpiY/RvlZHZqpEgjTAhVpVeTN1sD
         mBg5Y2ryeaQgIIdzxo+DoBzDKZ9JBrT4i8Ie7rQrQbxbBavde3UstNvsjcv8WG5boLtw
         DLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759136727; x=1759741527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isWBuGrVavExFHtjWRBMLQZSe+K9COO/1eBnPARTDvc=;
        b=Xky4xmG69v4Grd2lv/rC2638kbIQOp4FmSrT6va9Mc1nRwE03DVwzMK0Ol+/J3pZgv
         2h2frixe++e3EB0pYk27F54CIi8aGIE9hr/ba4L/JKS7j56FVjBwJ8ymjhFAnrdN1f61
         FDK5uIJTs3Bfififgw4ZSvvPiNShbcAm0dFFPuSI2vCh14CjNPbKp6iiJgvRFXYGkJOT
         xIIaCm9gfkajIgPAeSEcVGjt849661JbCgqFynF5HPj2YLUkimErmbv8pkafgvuHz3FA
         Soav5shxuP/g0xTvm75x4tfEaOP+YCAq+D2YDq8ORmetK9kv+uULq5241gY+pp9fe9qk
         iSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtkAy/W0NBJvYcWTlnzLGGOfpp/cAG0i2Fc17AQ+nW0L9iLw2vigKik8TfwsDTU0L07QjMj8hGuPVesL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbVZ9QeX0JKwXY8XPKTd+GPL8g9/1Swguj3BDkFr1dj0RDKDKk
	Vn44b0lRZwtnenR8kg0hjIVBA/SrCd8k0HQEkH9k/0scKWExSbuN010qHVQD5WyHW1o=
X-Gm-Gg: ASbGncukh9fkUoOStTX9qSwYmy9ZI6q+4vf4Rmrk4HXiIzCozA8ogDh4dcMptfGyV16
	7K+1+58papYOdl1++kIRJeS+uLWTuhVObzk7qdAYbT9Gkl272k60/hj0XwitGLDe1sGKrHu98i0
	aKZ5lbNbK1cHM8X12XcHJirZ8jeHIjmGD4WochWui01CPFttQlxeZ+D/FIqCuFTgkwXgfUxQdSD
	SQe6L+dE3NUjSEhvqALpV9PuCqXB9JQNv62EgcR2G4Qx7Q1EL6isXoNOcRNTkg1R7uhvplGAoSB
	93zw6LISB9za/EooGnM0wwBnBsiEFAVqnCOppHRkZUxbotrtqV9xazygG84M+6WcQKRy0tKoKrn
	k12TUmKUCwyj99wCYz62QUtUUMYWg65e4raY=
X-Google-Smtp-Source: AGHT+IHI53HjGws/0MGMYg9oIUI1/ZiOD1m0ms5Rmqmk3vyfhObi4885Z5MzNYAXHb1e431NwurN+Q==
X-Received: by 2002:a05:6a20:394a:b0:24a:1b2d:6414 with SMTP id adf61e73a8af0-2e7c1bc5598mr20471212637.18.1759136727306;
        Mon, 29 Sep 2025 02:05:27 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06981sm10451766b3a.72.2025.09.29.02.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:05:26 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:35:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpufreq: streamline find_supply_names
Message-ID: <20250929090524.ztcp6o6qndml54lm@vireshk-i7>
References: <20250915135954.2329723-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915135954.2329723-2-thorsten.blum@linux.dev>

On 15-09-25, 15:59, Thorsten Blum wrote:
> Remove local variables from find_supply_names() and use .and_then() with
> the more concise kernel::kvec![] macro, instead of KVec::with_capacity()
> followed by .push() and Some().
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 7e1fbf9a091f..224d063c7cec 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -28,15 +28,11 @@ fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
>  /// Finds supply name for the CPU from DT.
>  fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Option<KVec<CString>> {
>      // Try "cpu0" for older DTs, fallback to "cpu".
> -    let name = (cpu.as_u32() == 0)
> +    (cpu.as_u32() == 0)
>          .then(|| find_supply_name_exact(dev, "cpu0"))
>          .flatten()
> -        .or_else(|| find_supply_name_exact(dev, "cpu"))?;
> -
> -    let mut list = KVec::with_capacity(1, GFP_KERNEL).ok()?;
> -    list.push(name, GFP_KERNEL).ok()?;
> -
> -    Some(list)
> +        .or_else(|| find_supply_name_exact(dev, "cpu"))
> +        .and_then(|name| kernel::kvec![name].ok())
>  }
>  
>  /// Represents the cpufreq dt device.

Applied. Thanks.

-- 
viresh

