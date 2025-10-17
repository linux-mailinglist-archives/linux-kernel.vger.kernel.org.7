Return-Path: <linux-kernel+bounces-858062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D76BE8BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623D41AA4C50
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2D5345729;
	Fri, 17 Oct 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1xG+71F"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C226CE36
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706528; cv=none; b=VawUhnebH4F5VGyoJqFgbVBoKZBmcA1UhqNrkSjVLSOttNR3T1V6XoqNyCJ2ltDdLqTqI9pHdVR2SERBV82/R3KseihvD4yjXxL9tW8fLKuhPlAyRnI50oZ8SgohT4yEZBgLAQvVr5SsOBtDEVv4zdux/xc/CfLavjRUkkMuB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706528; c=relaxed/simple;
	bh=YPT7YaFxJr/DP2krd+n0zCPmvIWHZQOhW/R2XbFhEDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RSCUsyMwHH6WAltwVbVt9KZ/aYra5F+7KsOfYUD21Mo4M9ALcCIxyAY2dkU1JrYDmtFWEJ1yK8bjVrflqQqzJph5zLKPcf4jPf6n4Adl7gut9yFwcypZO1v13KWoZwbxN+z/Mq+45el0cuZEvddxEOuEM8eFCH8v2af0AilAaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i1xG+71F; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4710d174c31so23116875e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760706525; x=1761311325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSoaI0Nu4BM4dbSgZ9LtXWIMvqWvuCY8C+cLR0Gw67Y=;
        b=i1xG+71FPl1VINMXC0UKt7vue4mGJfU2csQuPwsKs/VCb/tDkhJYa3K/K77QwRLE4z
         P9WmVIzo6rnYxNt9otYoubXHFwaNqVk3G2eHONFsBlcB94W4vIufBb5LYL2Z6c9kFbC+
         ygfdl1i+wa9J1cyl65fnLBJBZogh9J26OzSHo6tXgimMPKQDSjnBbqyhQMDzYAixJQFq
         jq+BrnWGw2D0L8iY1U0XgZkrJpwnkUpxXwIc2QVpr19HGNPCGr0uSkTY23/aJc1uRu++
         JwzKq6IIKjmvl25j2a4RzQZh3QdzgbKF6wWc+K2TbKDZ+oSRygR9pY8WbxPafdMMIcry
         SKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706525; x=1761311325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSoaI0Nu4BM4dbSgZ9LtXWIMvqWvuCY8C+cLR0Gw67Y=;
        b=Golm6325RVAMGyPFAPy+Whx6OSHpMOTL3851zja2dZT3s7fvRcofOQSmnTS94s1Gyg
         5J2pcM/qC3hJcVrf0fsJeBnd1Bssm5VDrUNg7Ii5gb/rYdA/mpbHxUbRi8YSPBskU5pS
         GDIJu6+OthDDiQl4kWTMqmwPYbdLM+ZKvAejagIN2jH4Cu1/PkegnLuB+FvvdgzPwoDt
         0x2rL7uEiPsNpQAuLCHOcKnfcxcyOs8Eov6QFaYLAY7n7npRO/Qx3p2S56oHAM4yJGMb
         sWqa4k+qU7y7NC9bB9mECrLPPx8tbtaKmBHIyu68coA7NWOta20KqVESDR8ZPpwS8WG/
         hV2w==
X-Forwarded-Encrypted: i=1; AJvYcCWWf0amX6EVqXE3sYG0djkuvHQAX2aX6uSaZCQuUi6kL75p7QLRtELW6SThSmxN+mszC0ibiyp+JufGBIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfczdCeYfiDxs1X+CAfWzXVuFIojEEKCFlBqT/ed6lq/Ozgwob
	0Xj8oYyEJdLdQL6UPaYyHuZwRIPyMFfVsyvElbzIqHkaSGAFrCk+ju3SoHky8EY+svcMPQBD9HF
	ivkh6oyQzgohhhsCLvw==
X-Google-Smtp-Source: AGHT+IGfS/GiLnB3eiTHz9v+40BS/boW4LbipGvMYHkAEl/D+2dbSk1rf0yTiwtqOLvzpgJw+OmfNTk1aMxX91w=
X-Received: from wmmh11.prod.google.com ([2002:a05:600c:414b:b0:46e:4943:289b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:350b:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-4711791cd8fmr37761135e9.34.1760706524883;
 Fri, 17 Oct 2025 06:08:44 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:08:43 +0000
In-Reply-To: <20251016210541.650056-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016210541.650056-1-lossin@kernel.org>
Message-ID: <aPI_2ye1h_yeExgF@google.com>
Subject: Re: [PATCH] add `[pin_]init_scope` to execute code before creating an initializer
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 16, 2025 at 11:05:39PM +0200, Benno Lossin wrote:
> In more complex cases, initializers need to run arbitrary code before
> assigning initializers to fields. While this is possible using the
> underscore codeblock feature (`_: {}`), values returned by such
> functions cannot be used from later field initializers.
> 
> The two new functinos `[pin_]init_scope` allow users to first run some
> fallible code and then return an initializer which the function turns
> into a single initializer. This permits using the same value multiple
> times by different fields.
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

