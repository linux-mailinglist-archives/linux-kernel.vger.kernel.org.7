Return-Path: <linux-kernel+bounces-791137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E3B3B260
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC38D7B2EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE032153E1;
	Fri, 29 Aug 2025 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRushieB"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7911F55FA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444814; cv=none; b=owFzHiuLmI32t6AypVmKN0Xt8QBw/4aEvaeFaBRlFHvLjPumsyrq8oAEJoX5nVDNI/JkOifnzRYzTT7sDN80xVex1AiuWek6R+aC1jnOvZ4LPUrrnPTeB8pwsHAzP6wENaXGAEQY26eKS2Qj5S9HijujlT8xka5o3w0gPYwSuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444814; c=relaxed/simple;
	bh=1Zqk+4vnIkwWqVkrcUdNeo1ti71o+27E8x4Bps+lroU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab107dlTGXqnYhJqpPu7qO1zhCxGD4D1MncONIaQDS7nmZ+uqzLRIQPIT3OS7nd0r6hVNYau+IWIkdGyiBAVjClZIMwrI4z4svdLCQZOeYrWcTgbkgOw5u0/c3hMailtskmlbmLyXUlx9ZdZjJmnhZmHk1gtuIOLmA8TMQ72WC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KRushieB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771fa65b0e1so931415b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756444812; x=1757049612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvfbFYwUN2Wv0aTFajklPrgWujcFzYTBTym5k6QlzSg=;
        b=KRushieBvuQ2YCbTp1mphqQqsbg79KPUVp7r6NeFCAGtZ7JngH+R+Yno+n36tX+Tyu
         4NIjqboAJOpgmzlV2iD8ge9KDzcNQqK8E4G1weM5vOtAtbPfm4Ckwl4n6o6DsM84X5uc
         4qOK6JRE7dGcA8R7JxKEqFXtcAWh2MHl4w9R2f2NYkbTMsMYhAN5FChx3P3RTjfkuU3G
         V3DhIuIKqP+EkwphVK3cHQE1CoNnu3RtoJvOBQ2QaM4XUDd96/9KCaBYQn8Nhvvbvi6R
         qM3dMrkw5Y9yN/IPgYM+am49SywlxHHCSKcvDHXV7jL8MSxkrJqh+aWTwcs+dGlaa4VO
         84tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756444812; x=1757049612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvfbFYwUN2Wv0aTFajklPrgWujcFzYTBTym5k6QlzSg=;
        b=UpsSBTaUM4OyTR0KdbNprjQLCC+iMj+7eIMiaiBkiTV3jjWsYgX+qe2hkVHPQwLFBL
         EfgbRgpC8i7HPtgJ8fJsBcfZoa617e1eS+0KIz/tZGhzjA2NR7q3QFBjuIrIznd9O9HR
         D8GFHSIhv1WYjODqjglPY4UQit4JwkxduOyWOCxy8O42PO9mHep1DMLOIKXNdmjnVSsD
         pwL9xcgywZh05FQM8LxCrAJJ0wg2Ct7L9/eb9W9x5KiXI+vGYR5V/UV5Y8YSlOT5sOrb
         HUCANxmamnClsNbDLqq5HrowGDlPP5q3/vCoYeZnARGPTd9riGiCYTrneDVPFfIr/z7u
         Lexg==
X-Forwarded-Encrypted: i=1; AJvYcCULRuYlwMQllSzhvRvISsAaoSos/rJjoxqsrVRtsXJT51K2+LWc0CrgkLytKIQZrSDA7kQtdDhREgmyOqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwndtfKXvJuALirdI111wPq7QjgpWPUAQriSsrLXsxejghCEpiC
	SPdTNglfN5Y10A4jmOu92NCmMzYt15792rqBCb4xUkiV719TtYdslYTDkBwNCzK/4EQ=
X-Gm-Gg: ASbGnctCSUcMsQsjmtGYBNC5uDSWFUa4QJWngSiDPqh1Ic3TToCBWvREW2y52Y2OT6x
	CmitGUvAmrKSSjRqfDj34NDyq6VCmdLiHBjAUlPdFpsye8Yw00BUIp8fOWw/WVTow6S5p2bmlDA
	fnW81rhPLGRuWSvfAUN6N1wFIBXqknGzeRmYXw3XfkMlWQRZ29lXcjF94bbI8TEZZv0lvJXbV1t
	62j6FD1dJRQ9HESR6p4jLMq3RxFrr5/wP02l4+XzjYfYAofbGgAkmiNXpmFlsBi5MwzJyjt8WY/
	VtfcuWrKKzSWgAOnVdYSQrRUjUz6bqOuq4kDdiFQdUsYMiZsH82nsXrjaZneugey2mRxN5MCjmc
	RyotwTZ8hZdycDd5mQeURrpE5nEtADMAROW0=
X-Google-Smtp-Source: AGHT+IF9rXnIKgqvJMpaMTUtFPVV7KQF3OFqGDqAWPTMUUDPlHpYvFwpf3iklNWoMxNux/mqBvASRw==
X-Received: by 2002:a05:6a20:7286:b0:243:ae10:2433 with SMTP id adf61e73a8af0-243ae1026c0mr8924481637.40.1756444812495;
        Thu, 28 Aug 2025 22:20:12 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd308f90dsm1046614a12.40.2025.08.28.22.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 22:20:11 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:50:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 4/7] rust: cpumask: Add getters for globally defined
 cpumasks
Message-ID: <20250829052009.glitgqzv22zf7c4a@vireshk-i7>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-4-4dd92e1e7904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-rust-percpu-v3-4-4dd92e1e7904@gmail.com>

On 28-08-25, 12:00, Mitchell Levy wrote:
> Add getters for the global cpumasks documented in
> `include/linux/cpumask.h`, specifically:
> - cpu_possible_mask
> - cpu_online_mask
> - cpu_enabled_mask
> - cpu_present_mask
> - cpu_active_mask
> 
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/kernel/cpumask.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

