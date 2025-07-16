Return-Path: <linux-kernel+bounces-734383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EEFB080D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BBD1AA5C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2352EF29F;
	Wed, 16 Jul 2025 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ifm2d+JE"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EE19DF8D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752707977; cv=none; b=eOtD8vLrMzUy8JEK7xAO5k7UojLfbUxRXfj2MI7BIFOEJKRBbkrPFLbb9xolf+vTpoZBczt3vDvdxTFCIn/poqB+fsMtILljbxiuPvymCK+Uyi+RN9j/CgxQg360pRcSF7/Nsl+juuGVMurEcXz8qsIQc1vE4zdcMKgES029VSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752707977; c=relaxed/simple;
	bh=9/NnJDTcQwKH0nX4EoIsUlDscSEoGQ+CI3cGaPK+Ctg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8HbOV+xTaxNlaMcb9DRMqCRt+wqh0eE6r6H8S7VgHlefUDcRCZkaG40xz0ed8x47mWex1Y70Wamv7JC9imM3ggecagkyP4a7s/ayKaQO2BAxC0gPGs5/hs932oHVi7k3kcOV3nPSoawn6GYntaA08EfqRhzqe9AUh43pfrsgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ifm2d+JE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso2620a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752707974; x=1753312774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9/NnJDTcQwKH0nX4EoIsUlDscSEoGQ+CI3cGaPK+Ctg=;
        b=Ifm2d+JE80BYbwXflvBz3bueuGj3YgIHqR4QY99jKgc8N95hmnd3shmqX6OmpFQVrp
         p42Go6U4UFu0eZsm8GKKSWc3sik/JfpEwKdtvMq4wLN0z/UbAyoRyOHgN6cbdziZeudx
         PIpjCiz/43rVxFPnOgSmsHrRO9Vsm/rjv3YibMQwiigD0v5YfPIXS6gyKHPf2q2uh2fh
         o+A1mg7ZRVPctGbmLcTN8VXXsq+XAXLiiI9eaFQBFE1KFJdQhgP2FLXMYFSMMQ3DAu0E
         zL+nMsHptOWKIGgciwtBOLFbVrarfsOIeUpWMmquKsPQ7iXBM39MywcAsBGCkiK3YGVy
         n28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752707974; x=1753312774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/NnJDTcQwKH0nX4EoIsUlDscSEoGQ+CI3cGaPK+Ctg=;
        b=SAy8f1K6C+R4YRnf4/2KS/YVtFtlhuDEzZg4XF6SuCzSgj6Ri7rLmfU6+kecEEsq96
         P0hnxDMGQ70qsDpETsoulY8pJRHFr36iglR0PCG6FnIdgQQiqz2cGnsINe5KZpEqpJWX
         jEEwHR0yESVdw/qWbp1qHWZVvybz+Ga5a6t/s3PHcMLxRELVXJCHub9IP8zXT181EQ7t
         iXPkD8ab1Rp16h5JVkw9AFX0izzYPxrx+1TJDCYnUc9T1z8QZcBAt11Fvgo4SLXB8XCS
         ldnyZT/dgQ092WXcoBnWgZBUfHfYyuG3VPuxVZb/Y68VVwfZCSNIkfb6uki6M/iOc8qT
         Iyqw==
X-Forwarded-Encrypted: i=1; AJvYcCWO985t0YtUJtsprf0xWO+OjNI3s2sQgKZ41bk3D1kfgJ5wuR76/yBL4kz/90pyMaPdktM9kOcrUAec21Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDyr9f0YFqcZ03SBMCS0rQr1uRJCVTk4toawgjVl1py/thNPc
	+IuRpI3+TQfQFyv2f8ieajnPUfOegM6zVNQkZcwhOjx5LIBA91LaXMTC1LwpWJIO3pjsvNHJYQb
	DQ5wYFMAd/ZItUdQJIqe8ZZK4jiw13RSKQQdxb4pN
X-Gm-Gg: ASbGnctOoQ9eenkk3Z+VeKspBjMhbNLMQkH+MzxLXQhHJQRYlkJzg3ybMoTwGjUXykc
	7W1vNuMHrdTUuQYH3SfOH7r3OvGrkT7xvZOivNzid0oi43/hQBZNxqLuktiTu36DBqoZJGXeA0U
	ckwTG3QFkjX16osatvVsjJoESP39//VVStCaOToAKwLlWzdsvjPt0H+bHHy0u5t2Zjt7hIRyG4g
	j2UF+N2aVd/ePAew133LGy87Fe1ppbU8horg4l8RA3vhYHk
X-Google-Smtp-Source: AGHT+IEWW6wSvnNGlneW8csSuEUINBhv5Xrj4krisO4j8KjigJe6weh6HtfKmo/FhQRiZhIVz1T5uW67ohk4ura9SHY=
X-Received: by 2002:a50:d75b:0:b0:601:f23b:a377 with SMTP id
 4fb4d7f45d1cf-612a4cf8fc8mr29145a12.6.1752707974101; Wed, 16 Jul 2025
 16:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>
 <202507150830.56F8U908028199@SHSPAM01.spreadtrum.com> <c34f4f606eb04c38b64e8f3a658cd051@BJMBX01.spreadtrum.com>
 <CANiq72=v6jkOasLiem7RXe-WUSg9PkNqrZneeMOTi1pzwXuHYg@mail.gmail.com>
 <24e87f60203c443abe7549ce5c0e9e75@BJMBX01.spreadtrum.com> <aHftocnJcLg64c29@google.com>
 <CAH5fLgiiZE_mFhB4J+G7-Jdz46+d-5NP15npjn2_H7DgSAynxw@mail.gmail.com>
In-Reply-To: <CAH5fLgiiZE_mFhB4J+G7-Jdz46+d-5NP15npjn2_H7DgSAynxw@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 16 Jul 2025 16:19:22 -0700
X-Gm-Features: Ac12FXxXgsXM-s4jPwxbK0qidi2uE_QL2umvn-Fdybn9nHdZCi0VGiyXjMukuYQ
Message-ID: <CAGSQo03DH9L7OFZsGXU8gt_4iq2zo6gZbJtw3p2hD6tGp0KTzA@mail.gmail.com>
Subject: Re: Meet compiled kernel binaray abnormal issue while enabling
 generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, =?UTF-8?B?5YiY5rW354eVIChIYWl5YW4gTGl1KQ==?= <haiyan.liu@unisoc.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?B?5ZGo5bmzIChQaW5nIFpob3UvOTAzMik=?= <Ping.Zhou1@unisoc.com>, 
	=?UTF-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>, 
	=?UTF-8?B?5p2o5Li95aicIChMaW5hIFlhbmcp?= <lina.yang@unisoc.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	=?UTF-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <christian@brauner.io>, 
	Suren Baghdasaryan <surenb@google.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

The reason removing that code makes your build "work" is because it
entirely disables pointer authentication in Rust code when you remove
it. That is likely not what you want.

> > We have KASAN builds with android16-6.12 and haven't seen this issue.
> > Can you share your entire config file, so we can try to reproduce?

This - please provide the config file or instructions to reproduce the
build. Since this is an upstream avenue, ideally provide instructions
for reproducing against `linux-next`, or failing that (e.g. if it's
not broken there) against v6.12.38. The default android16-6.12 build
will work fine with ASAN. If you can't provide the entire config file
in a public context, or if you only have instructions for building it
with Kleaf + fragments, or can only reproduce with the Android tree,
please reroute this request to our bug intake system (I am pretty sure
unisoc has access) and cc myself, carlos, and Alice.

