Return-Path: <linux-kernel+bounces-864728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82631BFB6A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B5E42006C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33166313E37;
	Wed, 22 Oct 2025 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BylKF6x/"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A68526F2BB
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129159; cv=none; b=gKIsyXX/WmJtSkeTEnTHxlX6sXrvhuKNSmGS/dp3B75s2wA9vIrjC/RnOGbkHjfakUbIgP32hi2FUBP1i+ADiu3LKZKcpkLK3S1nTUXA6b9EBEuTEvQGjkDDPKcvWZF/bYORt5W8NcCg/PahL2S6Kah1BiaK75vwLOA59+OzuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129159; c=relaxed/simple;
	bh=CiZOns0eToY7P9gv/nt/RsalrqWoAl93Il55RBlfYbk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pSsQlCkVN6sk7BGNixW1l7Dam3eXl7k871C85yPL+WC+AF4jay9EQMbXOY5Kw/dMTyVjoZLSst2E9QBdhkv/uu6amrAdGKWF9MB8utcUJAHL8YRJPz53oMEazSyA9+DNOpRVZWuYh+16sRiNJxRHf2B2VicuyWDgk/2O6Pq3738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BylKF6x/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33e27cda4d7so603729a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761129157; x=1761733957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuRqJeC65yvo3Lmn1DVO5+nHc8XAm9gp/N8GuccccSQ=;
        b=BylKF6x/iZ7CI8FR/Jx38DawfXHqouFeE+X20DxeHCGFgZpgOTUcL2MZ06gl5TwDpJ
         P/LeTNKLHcdPJot90V4Fxm2mTFUrPNTrzJMF7sjjjjmGg88ErSxuOOS5HlcgBVoLKZqq
         COX19mg4r7DyxqZkIYsXixFds/zbC2CgfxpJUJlVsJ5H3fzo+7SUojBZm5SBULFhpAKd
         5V4U3l4MNsNALNsF0bziprcPhNaOIBjXMILGKm+ixay0sZtFGYx9dhCpby/v38DGKuNf
         A8ElasNrjAnjQHG7L/Kxoi0p0/vnOoELSpkUOxPktXjGyax1L0AVIfPR1eFo2+/f/+fp
         U81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761129157; x=1761733957;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZuRqJeC65yvo3Lmn1DVO5+nHc8XAm9gp/N8GuccccSQ=;
        b=wZasKmZWHAX/zXED5NBSiV2W6XIvOmM5d1OUT2RCe3cJWPPxzruhzlrC8XLxpT9ukh
         Q/0cKpbzIEqshqM+e5VQNiwFPkxJoKd3E6d8rKwlosc352BVyxtJE4Xu7zUm0P3oQFQj
         5NUMKVfyQ0eqkMi8L/5CCNxe2C1fQZG0eV1x0PFh48pd9b5NUp7OdepeWNnsr5CW2Cwj
         QLs3lIgUEWD2cEGMBp+IeLP67BS5eBAWPSMDnimcdIKO/feO1ELjXl+rYZE6v9prRdct
         MtyB689l2SWhEoiCvuOZZOk3I16Ud5MFRrnXq61sgBaNMBwPu1Z6zE1qwTs+/us0cgxX
         1ukQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6kfUCPJDoy7OKChpUn5P0gwLOJ0AnFI7UzdwP+2QRCl0L8RSfGoYSoKmLw/vkJu4GT5xEVc2fqTToYQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQvxBQKDUlzeVfnkirFjCvK/4fIUdTU7EYrYgpYgCpkGMvmmw
	EtJB3aTypqSofrE3mlHT67z7AN2v8znnn2KvLjoY+OSVl6rZwytMa6Yu
X-Gm-Gg: ASbGncvsTFxzNc6GijtPudC1IGM+XnnxI8ti7SGIteQQiaKhSFYX6taxGhLbU9wCWKH
	N+Du6rl3OjKKpDnQfWnwA87p7uHX0DS1BpL2RQCy9TtAf5B6N/dB2X9TAUGG3MLhKwIrmXpRx7g
	0ft5AEfD1CoGYvKxwWYAWb1waI/yStI0dci5agrRx2uI8BOIsNM1B7Vj0ro+9pO66kEB+yA/Cg5
	FhT04doP3jZJ31039ti2tH2xrpDiToZXM2MoXS7yDDQmGTIIV3lSmVewHpO4yz2NVVsAnM/D8ZX
	cLtkwfkxpWLl78CaNiJkPS5bodBeqdl6N7eptIJoz4qw9kluriPJKF1cemGGthzWigAFBy15Txn
	tJik2oNbA+5AfgXmzWC2YAdPo0QyHVHdM+kQXEKGSof8PwdkHF1uIGq4euA5EcfILN9k/Z5693D
	oNA/Wihj7b4XMUeOS0Ve+3YmyrlsYexvKXocYDyCJ+RTTvVVcArfSGDrx5TMFneunH
X-Google-Smtp-Source: AGHT+IFlZ5+t9Mg2OdV2xMBkVPCC9UkNcFEp9TCLp/fsD6NdnQ567HulFK6cKVMY5pofdf/Rt/bb3Q==
X-Received: by 2002:a17:90b:4c48:b0:32e:716d:4d2b with SMTP id 98e67ed59e1d1-33e21ec326fmr3840511a91.3.1761129157272;
        Wed, 22 Oct 2025 03:32:37 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6caf129cbdsm8795116a12.42.2025.10.22.03.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:32:36 -0700 (PDT)
Date: Wed, 22 Oct 2025 19:32:30 +0900 (JST)
Message-Id: <20251022.193230.585171330619599845.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: miguel.ojeda.sandonis@gmail.com, fujita.tomonori@gmail.com,
 aliceryhl@google.com, daniel.almeida@collabora.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, frederic@kernel.org,
 gary@garyguo.net, jstultz@google.com, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 sboyd@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DDO3OMBHS8TB.2LDODR1AFRCU3@kernel.org>
References: <DDO3G26SIZTK.1KV7Q0PQXHWTA@kernel.org>
	<CANiq72nUiizxo3YFgxUZ1jiczRNbY2ATao2YUBiCEC7k5hbv6Q@mail.gmail.com>
	<DDO3OMBHS8TB.2LDODR1AFRCU3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 17:20:41 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Tue Oct 21, 2025 at 5:13 PM CEST, Miguel Ojeda wrote:
>> i.e. if they aren't sure what the value is, then I would prefer they
>> clamp it explicitly on the callee side (or we provide an explicitly
>> clamped version if it is a common case, but it seems to me runtime
>> values are already the minority).
> 
> Absolutely! Especially given the context udelay() is introduced
> (read_poll_timeout_atomic()), the compile time checked version is what we really
> want.
> 
> Maybe we should even defer a runtime checked / clamped version until it is
> actually needed.

Then perhaps something like this?

#[inline(always)]
pub fn udelay(delta: Delta) {
    build_assert!(
        delta.as_nanos() >= 0 && delta.as_nanos() <= i64::from(bindings::MAX_UDELAY_MS) * 1_000_000
    );

    // SAFETY: It is always safe to call `udelay()` with any duration.
    // Note that the kernel is compiled with `-fno-strict-overflow`
    // so any out-of-range value could lead to unexpected behavior
    // but won't lead to undefined behavior.
    unsafe {
        // Convert the duration to microseconds and round up to preserve
        // the guarantee; `udelay()` inserts a delay for at least
        // the provided duration, but that it may delay for longer
        // under some circumstances.
        bindings::udelay(delta.as_micros_ceil() as c_ulong)
    }
}

