Return-Path: <linux-kernel+bounces-889407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA6AC3D7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E085C3A25D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0FC3064A6;
	Thu,  6 Nov 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgX5FFoN"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C781D432D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464304; cv=none; b=eatKOCLuzsgpw/o37RIdupdElRe7x9SozCgms5BN1uPdYbg4jhgjf24ie98ldAw7h+RhK58DwvuamGqEkMkfx1tvSyoE3SlV4Vesxcr9CSLop+1G5gn5lcM1+dieePXHycpJmc2wDXo4XUlDncVXON1QM5TJlkuc4uz5zOjBUdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464304; c=relaxed/simple;
	bh=j3o5uZtHhBjZCwpRT+vuLhEkCZ4NFat2T9UI/fTlUyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSFXRW4iKW1D2qJFm90wq1Yz7He/vNvIQGZrpYrbefe4B2EcaPJj3ApdHjAMLTPyk4GDi+yWJmdiDLgHnXIJl4eO9YWrXO3dmvsYBDUwtBrh+UVf1xTZ9REaSRadehmbnGzeJ2ZuCkU9JPqU//FUg2IDdWf238vb2apwk2hR0nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgX5FFoN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so522135e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762464301; x=1763069101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKes0XVjNGJ2FggkAmqRR788Mxk3TjUGRm3n1mueSWg=;
        b=kgX5FFoNdaKNGVjeY645WilSfvJtIRxpCgsAfnPiUruE0PuJFyEKdPEYlU4QsHEPPM
         fTcHbfTA5Tzc9QKx4zrPu3Cn+gkh9IOAsKup/pn1CDo7battPX3wipdw3E5ZCGTzRZVU
         E7cVhH2Nu+bn5E9FRfiRCdyukBfsQfBQzpni/RcyAvoPuHZXwoAi376zMa3QsVIGT/3p
         r5lzz4G5STiWNMUdr+HKoGMleF4qW8bN341PaXUPLl9ieWVACrnnFfjTFDR4b33nX84U
         JF0KCuIOzbMX6XFUjh4hoNVJluB/2KRwNWAxv5mYpcIPUYD8Tn2q0yhzLt6U7rUuH7Tw
         m8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464301; x=1763069101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKes0XVjNGJ2FggkAmqRR788Mxk3TjUGRm3n1mueSWg=;
        b=fs3znUppeDQiNpA9xTLvCfrw/KZKv0I/f5IDXT39lNgh6mYKx7miSXdnwVeJ9qB7vJ
         u4vvkmKix4EvmWXGG1TRayWKCaSVOdjzMZJpi6oUSno7dq0nHlVciCHIO0YLIGA0C+Ky
         QAj5LtdZA/xBVkmHpALTHDKoYCxBKf6EWSfqT5gWZIRg0vVOQuIMJv9jIMOBM5/KR0BE
         YguxMX0rfVgEhUdgeHHCwiL3x1T0SeTD3XlsSZKXfaKyabD7Pkpx9mCqNSXXhWvpHamI
         qRkPqE23w6teuGPt4HBaRkJ2LZGJNXnc6oiuK6p4QC5uDcu40+opJeDadSFeu0h9T0EA
         LZdA==
X-Forwarded-Encrypted: i=1; AJvYcCXoTyBXhkvl4WB7oX0VXBYBsr1f2ZBe4kd5a7efTIJdrIn8V2fQhmEsSQO01RhssvYQ9fmzlYGk+rO/WjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz020kFmby7hKqAju/bvhhRzxrup3sYmaOdDY+aPCO1Zz9ueVJ3
	IdX7dPd+fhQDLdpPahwrex62S3ulSIBNANUh9gvgjU1GBi3sS2VJrxHS
X-Gm-Gg: ASbGncvZwWLw2VcpFGxQuGwbjvusR0SslhhFAejuIaC+KrFZeoK9pxXE5mNOYf9moHd
	CZ9I/xEgq4+hv3n9Z8qwZ9OBptIAk17Zv8vXUaHKgvhi+Lq3dHjtOcXTzUK0dQSGgTEkA6IDmI4
	UoFOziBrKmeYE9kM7DPkFwRK+vwK4vm6EtWwT9xoksHT3teoOe5AXDnM8FEC7XgGEzV6vOgexCy
	cKOpD+w2Askek0c/mJL4Uyp2q7nigJuMqvPVYMbixJwYzR3Nr5s6Cz+AQNWoINUnaoHxRqElQnO
	vqoa/9ubJRzM6kO5z5L2elGag2s63K7izAme9ZHU1hJyMcrh0VZmf0+ZjqbKECh3IvJaKPoyEmx
	SdOJq9uCgQWUkZJdmwmUXPnz1qQbR2Zh8Q3dU03UdongmBviIQxf7Sz/Kul9se2BYcRdu8AcTrr
	ho2k95L5oUgbBhEj2pciNG9UvtpT+NMROa5Wqqag8WWfLEaaVe6eqijEyKrCrGOWU1UOw=
X-Google-Smtp-Source: AGHT+IFRtleD8p3GDaRn7y4cLlgvtrJ8k9u0N/dFUXsYAq553rRak+Diry9dTEA+SBjhoD9RJ2Xd8A==
X-Received: by 2002:a05:600c:1384:b0:46f:aac5:daf with SMTP id 5b1f17b1804b1-4776bcfd091mr7371805e9.35.1762464301183;
        Thu, 06 Nov 2025 13:25:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:acc:bb60:756b:64e3:20ef:1d08? ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67920fcsm1257502f8f.39.2025.11.06.13.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:25:00 -0800 (PST)
Message-ID: <ff95096e-83de-433c-9048-55a35dab3dde@gmail.com>
Date: Thu, 6 Nov 2025 22:24:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] nova-core: Simplify `transmute` and
 `transmute_mut` in fwsec.rs
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20251104193756.57726-1-delcastillodelarosadaniel@gmail.com>
 <DE1H0USFAGNU.FFRA802H95RG@nvidia.com>
Content-Language: en-US
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
In-Reply-To: <DE1H0USFAGNU.FFRA802H95RG@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexandre,

On 11/6/25 09:32, Alexandre Courbot wrote:
> On Wed Nov 5, 2025 at 4:37 AM JST, Daniel del Castillo wrote:
>> This patch solves one of the existing mentions of COHA, a task
>> in the Nova task list about improving the `CoherentAllocation` API.
>> It uses the new `from_bytes` method from the `FromBytes` trait as
>> well as the `as_slice` and `as_slice_mut` methods from
>> `CoherentAllocation`.
>>
>> Signed-off-by: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
> 
> Thanks, this looks great so I am staging this series for pushing after a
> short grace period (probably tomorrow if nobody screams).

Perfect. Thanks for all the help!

> One nit, the prefix for Nova patches is typically "gpu: nova-core:", but
> I will fix it when pushing.

I'll keep it in mind for the next time ;)

