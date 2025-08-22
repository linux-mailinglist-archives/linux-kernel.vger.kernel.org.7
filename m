Return-Path: <linux-kernel+bounces-781776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37279B316A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD2AA0403E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCEC2F90DC;
	Fri, 22 Aug 2025 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z10TyJcP"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02882E7BBA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863110; cv=none; b=QIC2K3QDiSOB9IM/WE11KN0hRFnLMlR/LWE6UdFG0tEkBGKsYuM2BD5qKjMO2sxCV9WIl5QsxIQxaNTIMaScva5x/7LlzMLQ9McGBAsM6p4KNdF8zL1I8YbWwHaWlx31g5KwdbB3nAYr4Kv0riqbj0wlW3wjorpJVoZaDrF5hJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863110; c=relaxed/simple;
	bh=U1YHheloJqb6BGp/2sNURAjtBLVCXUBMFFtCkTffVcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r7KfIPbBcUvmg3Ki9XL6rrMbWEQRYw6JVmHHMWh0hPgjGLM0bJGGyxEY8VD6vh2GP3RKTJqJZEgRz64tdjbDu2Ld9EHLa+LoqcMq/TogaiMGrP+FXld0f0sy8ZzowIhsRUJnF2fizuQzMIDNWi2VXTSuLEH9tUOszaFqMTCE6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z10TyJcP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0071c1so9837615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755863107; x=1756467907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvN0DxLG2S+FpdAhVPJYSHpGARrWQ6jqYGMXDUXsF7M=;
        b=z10TyJcPUSiosUGyHtrcjQRLF1AYrCC9f5tGn1kCB0zzTCXZNJtCI9s4MUaIQOV4GR
         NTaJaZLnx6m9HSosG+e8hiRe0ZnSf+wxZKFNJvvHyBxUKLRJCuMH/oTuA8t2ue/sn/7l
         EHT9MSjOjx3wrP+Fz1YzBil7fefg7TECZvI2hhTaw/vx3B+Lc5GSYGz9jZqEaEssRGr8
         DbOCoSDOT3c+KvOwrm7zRZmR2m48OIjgmIrdgMqjywTd+C9d0SqFQOIefDx3AhN1uP8L
         7s3BKfCdT9b9kKpTdpWfb0UmrwDGbFDhbq9jL2FwdaOovkETiJG0tQbc/PPwaIl1hcJF
         r4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755863107; x=1756467907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvN0DxLG2S+FpdAhVPJYSHpGARrWQ6jqYGMXDUXsF7M=;
        b=H88JrNiYagyM5ICfgMK3MWE0/d5mhtTFmUNlmfnTBwVgW2LjthKX0lyh5gVuszkMdQ
         gNEK3V7PitvFs/RpBeym5A5kSZ86h6oIelR+QLaFeQzQJgzLZBw0v82Pmz3ehqHpCQF0
         Bh9ePbJGbtvEMi29uHhkbStab2cMx0a6PGsSHJF8QShAgKcZ0hiZJtC1thMAZTN4i7vZ
         og+hiKxgIetgnu3yt4EFS1P5+7F0SE57AmWC+j4OuWUPwhpHBTMX9diDHVB9E1U1eMZi
         P8vdEKta1lOV7gkq9g6SdIhSqh+nLNf0zZHm7qvDY7DKuuSnZkAvwTy01GlGyelGdp5K
         TLZA==
X-Forwarded-Encrypted: i=1; AJvYcCXKXr58oKHFLVJFnkiHN1mUIr3MSHw5l5K1D91VWAuJiEJEpBTM9RDIC3xTd4s7QQ/soQmY7Lp5FNCGONk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIWm/du26XYWBFSk6H5MFGz/6jfLfPUFPfFBOXOWBg7u/1yWU
	jn7Dt8orlvQ3ymES6L/Qc/U5FQNBAZbi23+Xdk2+iyXShGUD7Zi0mVHfFZp8tjiZNvQlzvDzszj
	VPIIHJO5q/uqiRgFhxg==
X-Google-Smtp-Source: AGHT+IFIi0WPgKw5kAsACAPzf0/by98hL6yM+VynYOHVU4l0iuksAHqrV6mFxKfOrPbbaxoWlpkMsBY/YgkdG94=
X-Received: from wmbhj14.prod.google.com ([2002:a05:600c:528e:b0:459:6a64:4582])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:630c:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-45b517cfe7dmr20998725e9.20.1755863107090;
 Fri, 22 Aug 2025 04:45:07 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:45:06 +0000
In-Reply-To: <20250820165431.170195-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250820165431.170195-1-dakr@kernel.org>
Message-ID: <aKhYQk46u_uHUwwR@google.com>
Subject: Re: [PATCH v2 0/5] Rust infrastructure for sg_table and scatterlist
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 20, 2025 at 06:52:54PM +0200, Danilo Krummrich wrote:
> Changes in v2:
>   - Switch to an enum impl for DmaDirection utilizing compile time boundary
>     checks.
>   - Add missing Send/ Sync impls.
>   - Rename as_ref() to from_raw().

Thanks, but it's still as_ref() in the cover letter.

Alice

