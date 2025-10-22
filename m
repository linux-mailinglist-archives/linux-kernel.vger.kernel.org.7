Return-Path: <linux-kernel+bounces-864014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ADABF9BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8A4FBB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA32206B1;
	Wed, 22 Oct 2025 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ns7datzf"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E521E082
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100072; cv=none; b=NZu4F0k51Bi2Or7hc2vDlAhTJoJUaPRlpYprKQ4DiTPYiIEmpIL9KprURBv67xJ7sIK/eRl9jw3qcky4s/7JqRiqmzOV6kj58BSlVa3j8vsSL2KAFNdBexqxMVvqmifC04fa+JGRbpKmZx+SWLvx0PcvXX1u6dRUj1wBOJoapks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100072; c=relaxed/simple;
	bh=gtxXSsibCJLZR4eJo0X6XeizsPLCRJKnPsqSUiDcNsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UASISn+h7hEGY9Wy0pvbiIGvBW1jPnT/UB02iLuGhqzqBrNz771WOqk2h0D7NDfAZODMU0z5HRiwK62S9M/IG1uJ3FSp73qHQH4RsuvBJFbtipu/ZwJMAlYIdu6ZV+185f+meyZtVoBk0ShXodtCZacgq3nKVe82oCXe1xWXjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ns7datzf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-789fb76b466so5264279b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761100069; x=1761704869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqmP8PXFVjPtIGVNVJySqdODosEn/uc3qt8eNXsbPts=;
        b=ns7datzf8icGOKTONAAVfZEYX2gMWHAvcdFwbStWebO0Rl/Du5QVFmBnXqRSoiZU6F
         ptf5P7YAZ3aoE7s/Q6aHquXgljNMj4Z+TxXz/HRHggRHwGLOK6rVwuXlMjLRhzddmEyc
         /a6aU+en3DTez+1SXNrDFb3/tQ6sHTGk02umTReHZF43Y/BdECOHhJXF60IYCuXL+cJN
         NTZLYpFA7z5SJO5wFP7WkGsflKczPbG4jpAELRMI5vtL3D6j75XXzKArcmcPSy5dvNNL
         kPHckmZcRpjqHq1jtHBqc67JbXw2PwDBNFk0/Ma9yM29KWvHwFt4UmMzb3KAngK/Rsi7
         4FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761100069; x=1761704869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqmP8PXFVjPtIGVNVJySqdODosEn/uc3qt8eNXsbPts=;
        b=g15JWIXcG12tyC4CElxRVSMgRNVX/SsxetnBBgHIU+Ity+CAlkTJUvBqIrSDHIbDGE
         UdJxQRsW+9OD+t99jvOG7QJGRCMp7z7bzMqpEQ4y+NNhd6mK8ZGbtohY6SQl7D4/oBcZ
         fVRu790fdjqwPjNCmPp8RGKgLOFBNNLLULyxDw1zNFzzLSKOFiGW+XPOHM7B4P3Wg6fQ
         wENRqzMjKYzyvyGKkV+FgbNal/bi9g4IKthGD9x3hFQyNXCjDhphfuehXTJrY8tSSUJ5
         7hqqyOTwlYL/WOFxgtpGB+JqFilTJOBmgDQyIz0H+DwF8KYyQyuBs+410d9U3T/LT2g9
         3leQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ny/6v635CfLQa5+I+wczCee+nnl7v4q5JaoFzxyDVsu6K5svbigxgD0wuFlaFjxuBUo2vRw84MLlx38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPb3NygUGL4x+yvH9Vi6FXO+kX2ERpbfB4KfDEC4wLmvQNlvDj
	9mCm2gWkQk+F2TyNiALtgSyKSsBFvABFf34nWf/+JH5hzhYs34SuPPyG8xvE4O4g3ikijM6GKaa
	0q+b2
X-Gm-Gg: ASbGnctFrxjsNFk777snAW+IfpgDX4Qo55rAufXhni2WphLnpQQhtzHE8hbWeoOVo5S
	RGWhQSTm0LCtQD4eWhG/5AwjiCkvxRc/8jvPIMWi3+1pdajuXd8VrGfowDreQSxbfxDCSV8KHWu
	QwiOwaK3ApYBTUE75Up1TkUrbBynmT7ueKrLmHZGSOde9sng51Cz1UzOFHQGeIux0EHWETAZKn/
	jZiMEo+2wx9oLMmvOUTVRGiTdcblMeCOCU3m/2X3NBZB0hjcT49u3A3pG7+GabuHiJxJ4pUTwab
	5b5VaFpL/XaQfJTzMpZ85G0clRIrTrO3Lg7MS8lE5J9DJoYW+tlGM5n0fcpKT23TcgWSuIda1NR
	wGut+lZAFB3aPA/l6TsCF8kTCuWBxiO+TlgsPZLvd/U4XeUlnPSxoyAh/MCFlv6TyERi9K8l5XC
	+hdQ==
X-Google-Smtp-Source: AGHT+IEkOxWVQSWldQc/gAwbJEjuX6oOPBwr0g1WUs0jQjHOfnCn6OF8lZVM21AQiTMGEA1gGzxfjQ==
X-Received: by 2002:a05:6a20:9144:b0:334:3a1d:536 with SMTP id adf61e73a8af0-334a8536f36mr26023352637.17.1761100069036;
        Tue, 21 Oct 2025 19:27:49 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7cfsm940817a91.11.2025.10.21.19.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:27:48 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:57:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: tamird@gmail.com, Liam.Howlett@oracle.com, a.hindborg@kernel.org, 
	airlied@gmail.com, alex.gaynor@gmail.com, arve@android.com, axboe@kernel.dk, 
	bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	brauner@kernel.org, broonie@kernel.org, cmllamas@google.com, dakr@kernel.org, 
	dri-devel@lists.freedesktop.org, gary@garyguo.net, gregkh@linuxfoundation.org, jack@suse.cz, 
	joelagnelf@nvidia.com, justinstitt@google.com, kwilczynski@kernel.org, 
	leitao@debian.org, lgirdwood@gmail.com, linux-block@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, llvm@lists.linux.dev, 
	longman@redhat.com, lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com, 
	mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com, 
	mturquette@baylibre.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nm@ti.com, 
	ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, russ.weight@linux.dev, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, simona@ffwll.ch, surenb@google.com, 
	tkjos@android.com, tmgross@umich.edu, urezki@gmail.com, vbabka@suse.cz, 
	vireshk@kernel.org, viro@zeniv.linux.org.uk, will@kernel.org
Subject: Re: [PATCH v18 14/16] rust: clk: use `CStr::as_char_ptr`
Message-ID: <rd2jyc57e5p6zjhypnxkfnjwsnihs5tsr7r55qnuwbho5jmkxh@53grgiitw725>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018180319.3615829-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018180319.3615829-1-aliceryhl@google.com>

On 18-10-25, 18:03, Alice Ryhl wrote:
> From: Tamir Duberstein <tamird@gmail.com>
> 
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=&[u8]>`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/clk.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

