Return-Path: <linux-kernel+bounces-864085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D5BF9DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A60422D41
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1E2D5954;
	Wed, 22 Oct 2025 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYuErM94"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBBA2D0C7E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105104; cv=none; b=bBBJCv5XIV8ShcP5FvlihJU/q52sbkeeiWAAdMcV+pcV4OOwyx0ewkVP6anE+Qp26Hh5H1bxd8PW42LccH2TuDxDu5nYgxSuz7/8lCSir6n1momLqOUPq+UEng51jE0gBpk0camUFYCLG0agoHFSwX1X0hXE64tGRz4gpxB5Gkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105104; c=relaxed/simple;
	bh=pdiQSk4Fi4cmsTBMiS+1YGWGFe8bT5UbTzQTJFqBPdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG+AJPSOX9OknDUs58DUaC6hUaNU8s/frdZ4JOP/KfpJyTVMeh5W1yvPXq/1yNbFg0JcIIdmTj3GmDxML52s7cpKHEy2aKqOerXIJlW6ZI/2I8jKSoGCaKtKuarlavvIHET/uEaqH/whrXrqUPPH3rBIQHvR9sxNtdq7haVq6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYuErM94; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-269639879c3so60161225ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761105101; x=1761709901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0fINMYlT3Eigm/x3CBbhagxF515t1HkjauS4M0nlfw=;
        b=IYuErM94ZCZ96fer1GDzVG7kbT5n01Jv6VhLUOyecetfc3kxgxecAjbjnBqsYG3xbe
         q1rnD8xt/GsF5bIFqE+GHGxz569MMst2ru9zp1cakvADmJwUnC5sqBAOZoKhg4JuJMvI
         cI5Pw3tkfc+UodgDUo0VysGiTPWACzP4ZOUVX5VJtGnl5bVnUeU0/9Mywru+kl2arF/o
         M7iXMu8jSNyuCaNGVaR5ktJtPF7GpOOg3Qmwdctv/Rn5dxL3P0k/H/+dnw/CZUpjXj/1
         vxVrOqhA7FXO7P6hreXFmbxNcprfNpcdQ7qWFy/mjObI1BaFrY2BdFWREkQ0tMc0MsKx
         2J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105101; x=1761709901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0fINMYlT3Eigm/x3CBbhagxF515t1HkjauS4M0nlfw=;
        b=r/vFChYwxNsaSH/5TX/nCGCPVA2+gwhY/VimnPBU+DRbnEvnCITNHPY5CDLIDH1NfM
         5PNEnWAhcFaet/NlOU6tg+rVUNjcgLB+ljBFeqBpMEqrWdtxTQyfqoTUoEneU1yKWCBw
         oLrGW7mlKgUkF5c8OS6yTHARw4xL7lf15mmezdD59KP/l9aNZzmvDVsueotUmU82ZLwL
         ZNiu5z11myutjbPknNV19t7IGaJXHouUC3QC4gvmEvqEUfioPYMxogLDKtGC+S6VWCFZ
         Wdlhs0swmX46aDqXfy90EiKW0nJCydWgAttfegFbQLalMlb3uN41u6wxIQHkHvxDcj4H
         AZGg==
X-Forwarded-Encrypted: i=1; AJvYcCWOTIegQDDXa2K8sSo5I/K5FjNxp2m3xcxB8BCxQs2BABMHLbdJaBcoDlCzUPjNZ5sMha8hIGqRmwMC5qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5JB1ieVNiIhCsr3t9u6R7cNG7gLXz9wefEA7jxU4tgCImocM
	fAVF94cJlXLA7zAY9lhv91j3iayA1sGfdVVuArT5jF/4TH4ClW/e+9sPU9WLkAReRS0=
X-Gm-Gg: ASbGncsPh6o1NPLdYk8nLhTvYspar8mpMxqla7FjXgAF5owj8bRYMGjvwbCYSow9l0h
	kJiabKU3G+TTG3BbRYg7kJGlpf+So1Sb/qxRyDTA0rEFjSTMa9iPbzgFx25T+2spAr+3qzwVdHp
	/AfdK0CvzcqNzuIRbwQVE4v8OXvoZQqt6EovZlwGJjF6xyuFr9rKxSh2UhqpG51e3oqrod6pa5x
	u+p0x7Dscp8DCmY9umP+9qWDATg1+zs0SfJWbraRDmBIXDC5Iv0G2YDVNB9k2Wk8jbUDh/cD3ZO
	Qc7Y8LOSTNPmig4L8Ng7UuxNVzyfjmg/7Ls/S6d1GeSjBw/vB0HWRGzyaiDLh8h4o7BTKknWTQC
	HoCnM+E7C5Zk2rqjbTYUvvkYiAWTeoBSKPX5skKrpWrsH2aXqAFHl9a6w+GFDq+UXrr4G0lFoOI
	EfvMrm6vGmeUyw
X-Google-Smtp-Source: AGHT+IGDciG6vViP4hTgCaODxmJIH8hJ/wjl4CRNsOUT4mlkT/H7ue4PN1kkXs0mzWXK/CzHz1MOqg==
X-Received: by 2002:a17:902:fc8e:b0:267:ed5e:c902 with SMTP id d9443c01a7336-290c9cbcc96mr256553125ad.20.1761105101098;
        Tue, 21 Oct 2025 20:51:41 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2924721b6fdsm124657385ad.118.2025.10.21.20.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:51:40 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:21:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
Message-ID: <ghaqgzgnk6mkv6tm4inm2e24jyidsk7qhbff6zwc46kefojw5p@3jvwnn3q4bxw>
References: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
 <20251020-clk-send-sync-v2-1-44ab533ae084@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-clk-send-sync-v2-1-44ab533ae084@google.com>

On 20-10-25, 09:35, Alice Ryhl wrote:
> These traits are required for drivers to embed the Clk type in their own
> data structures because driver data structures are usually required to
> be Send. Since the Clk type is thread-safe, implement the relevant
> traits.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/clk.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index 1e6c8c42fb3a321951e275101848b35e1ae5c2a8..0a290202da69669d670ddad2b6762a1d5f1d912e 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs
> @@ -129,6 +129,13 @@ mod common_clk {
>      #[repr(transparent)]
>      pub struct Clk(*mut bindings::clk);
>  
> +    // SAFETY: It is safe to call `clk_put` on another thread than where `clk_get` was called.
> +    unsafe impl Send for Clk {}
> +
> +    // SAFETY: It is safe to call any combination of the `&self` methods in parallel, as the
> +    // methods are synchronized internally.
> +    unsafe impl Sync for Clk {}
> +
>      impl Clk {
>          /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
>          ///

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

