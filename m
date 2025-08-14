Return-Path: <linux-kernel+bounces-767909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DAFB25A54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0601B66386
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB52FF65F;
	Thu, 14 Aug 2025 04:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udFrMsi+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABB2114
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144800; cv=none; b=vFwQIsBMfdJw6XNyDIy+bx/OVrgdSkeY4Gt55iVg3UXvvDGRkTkZStdY0GD9V0nhzIYReiBtD9uipeLaJ1UnJa0Oy1nUFMF4nbPjSpzqAbl6tZIwrUkv3KHRdXNIkSpZaLhU2IJowdAkUSk/7v2V1BBvtP/UH/KecIdrgY5M9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144800; c=relaxed/simple;
	bh=VGzEBobUnqTenM6o2yCYtZykv7kCalxd6Xw2oMoXnPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZrkJNLUn6f+Qveeh70gStjyvvT/Z820RLI2XgNz6q1OGjfkLk8Rg/jnyysd55pMUBQm9X4YFcW6yof8mVa5D7HDdIeVhi4U51wh3gbC0vNAAL9EXo6HxvgUkBNMdlyghdYRHOjQNqilOJZ6e2nrIxlnoH5s3C3RUu/fYAfmE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=udFrMsi+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e614b84so577260b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755144798; x=1755749598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzto4+R4SEpsXQvu35Am9g0bxExsmpRAPRKsrODRUCM=;
        b=udFrMsi+sWQWpPTCVJQnbUBDRJ7SgIrcbPOqxQTZwc31tnNq/0cYHIgzzPz/HjOMvK
         X6PE4Pj2ZdzANvP7pGRY+qxMaON5pgLsQJ6jo61lC8Ek4Z+68EAthLi+GCO8yCRRKJ/f
         W00JfWphXoqqp7xKPlUP6VWgjOYSb+ipTlgRRhx8rDh8Q5oLj6gtRK7qNc72yInOWrHo
         3ejEftkLGa/mcsilQpy3KpDyCseiPlwQmofsFm60sva6GIUvoPe1meTgmkfYsMz+0991
         kzkT3cuhtvhuziJD+sJb1DE9hGIsjv7YiF14xclSSSedkK5uZT5ZxG2ElmVdhepYWFL7
         wubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144798; x=1755749598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzto4+R4SEpsXQvu35Am9g0bxExsmpRAPRKsrODRUCM=;
        b=UqPa2rQwuXGoACKajQEnMHNr3HWR7Lo6O37P5MiUxpcpGhfOnaKY9fT8ukNDsfXZ5o
         AW2E1UK6hBAFxyEme2Mi7UDgFnylMFJZQOyPL4NofGexjypsFA11zC23ix4Q/Iq9rNmp
         VBKWl0J/TyaoWLaisagdKQ3WK6cVmqCr7ARKIAmwY36b7Mua18Svx7fzL5CXWKD7dRN1
         bHgNZc4pgwO5c3xip3lFIZqFol40VAHgzo3a+ny2rX0xRnLdesuD0h2BltzOCa+kQ6qe
         BGdARSNwO+lDCd6aODdlv/ONtYhX2pqBZKioEso0xndR8PQcsJSjGZI0P8DsqyQbffda
         WgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDy30tzKyCC7n7lbs9mNMxKnnSiXX1SAsLs69mPPmTkuxZwQ7wfe3pEMUCdfhPBxRhAMbH3eGTHNF2ul0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYwLPxEZo1ApMy9sPAzEGInfs3g1ILgfdk/IbvPiBKtJXBRmni
	GjyXkL3WsRCfGoUV1RAgRyC/j8fYuN1QiESkv2GfpDj6lUgJHLE+EET9C1WbGjLbrl4L08Gy6bX
	Fib1U
X-Gm-Gg: ASbGnctDjMkq15YkZJB6COWaBMOeIEsRuEhy3HbyR2OfzuboCM6dMvuvEu6ZyOK2lvy
	8bu8RTkoSFhTfUHdAk5e0szlDaFxiFySs6EuiHeqLCGOvKZsV+NWH80cTRdCF1EEzEc7LRowni4
	oOS4LFOng0Shlg1Y78AqHTARyBcm4q2NnkGgQwnq7nit1a2YBDdX8MxMloqCOomW2LfjHzbaL74
	uiMAuNsfg6EQ+NA4MNK/K6dS/rolqUjn1ulTl1OV+docgW1i/ig906SAsxUjS/o1ksx0ohN6+G8
	PLGelUEflHJFolQFF4O86OeCQ+XEQZE4L53BduBIStDKcEzPszjiyCJkA7MwWiHVxXOcclWsuje
	94krHm76TAT8h7Ej+ii7uz7eX
X-Google-Smtp-Source: AGHT+IHuZAqDG+bKwN4mmEbOegBcVFPvD6aKGH7LaHe89lphIokLJFFNQE++EiGJ4ANYP7KMAZ7a4Q==
X-Received: by 2002:a05:6a00:9a7:b0:76b:e936:607 with SMTP id d2e1a72fcca58-76e2f9310f7mr2697735b3a.0.1755144798295;
        Wed, 13 Aug 2025 21:13:18 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f474sm32881328b3a.4.2025.08.13.21.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:13:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:43:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: rename CpumaskVar::as[_mut]_ref to
 from_raw[_mut]
Message-ID: <20250814041315.ywuxwp627jiphiqf@vireshk-i7>
References: <20250813-cpumask-asref-v1-1-1242aa8e0cfc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-cpumask-asref-v1-1-1242aa8e0cfc@google.com>

On 13-08-25, 07:54, Alice Ryhl wrote:
> The prefix as_* shouldn't be used for constructors. For further
> motivation, see commit 2f5606afa4c2 ("device: rust: rename
> Device::as_ref() to Device::from_raw()").
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  rust/kernel/cpumask.rs | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh

