Return-Path: <linux-kernel+bounces-781897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 575C6B3185D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C0864E396B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982932FD1CE;
	Fri, 22 Aug 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9GkepGr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F212FC026
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867168; cv=none; b=QbloTt9y3JdwpJlHwu09bgeRdhdWl4dwhzwLV/MqoWUorAAsaZz6isS0pqZ47bdFPIikOtz3ftJuvmdW9BZnYLjAZYRipH5hJTQMzUlRr6AFdpCMnMpC6V2+0ojrG9GBiIs4AoF0USPaph1VIcPWZzJUvmfdoB4EA1WlZMrfx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867168; c=relaxed/simple;
	bh=wYwYIuP54yw3qHwhEcASvJX1kT5O33c4GcjtRzjHV6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msrd5L2fBSFR/bSITN0zsVAnpzQOM7A30nsJbqYf5im59NmVE7KiHeCAz61ux0b0gFTT4wcoIK2fknjbHHt8/ua5pjnm9vN0zeQqVoee1+u2wK9oj1bFoZei5M68wXk3tW8rpF0y4IwvrSc4Pq5B4hAf7ee0kicEfXk7i+qYQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9GkepGr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso15845785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755867164; x=1756471964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQxzrle3VKFwpadizhrA++PgP4oF1J7QwIr8TLUlKCQ=;
        b=i9GkepGrqHjaaw2hdpBjfyI2TowX4icWOOgTcF+9/EcqQ7kTDQbGoebftK/xW1AhJF
         WrRIcqVZofcbEBv86kzh2gSVl9/i6E/HtGAETcoEkJE/DPvKSrYJHWb16tpMrF0ax/vD
         SdGFrzyKffVQOsKxOVBb+WuUdor8Si8d2fe+Ijfb8W+PmWzlPChtlCOkGcVTPtWB9Rim
         ktw4nnIyUQCQTpKkmQNesu7Eq2Q7HtWuvoHo0mediBLUjMWvSVifk2pSbNbl1Tz7eTCU
         fii9xd3SFI7jvWRYH7cqCoDjMQ6zQK28R4XFDaZJAlZscxRnbQ3RHRYXtpPwDoRllY44
         ukIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867164; x=1756471964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQxzrle3VKFwpadizhrA++PgP4oF1J7QwIr8TLUlKCQ=;
        b=Tzm3nkecyL5Io6H19Wimh20e0BIfkRvZiLXpUahaqQdAMsier4kOp1yjwFJH9A6031
         93ZqCP5qmdcc5PZmNQ0UcRiWv5emTtTCsS5jydTeFcB4KYp6HIg2nqiRvsMxhTvlDHy7
         2tA+UqEbSDKQBmpnRO8X76nPxP7+maapk75c7lfPHrdpOuegItOseMRKTubF4vpuz14r
         BCzTphE41+9Z4ZEsOm7D6cC+m4M5F1vSHNQgyZ4ThDsaLsNhtY8/roQpMXeSVlFsPhQZ
         Bmh1pDlFSCcgYCSAFv5fOFJzWWedfWAKfCtcwd6k+5Jyg9d54T98Z9Ovt2kEHgdKl329
         kEkA==
X-Forwarded-Encrypted: i=1; AJvYcCVi3v46tkxDmbOGGcX6+OzTPXLAz/5hUwJhpkv3NxYGMb1bguPUE5vxs3M4QBNn9xkLJZU63eL9h+ELV0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcvEFQ06rOj3HES5Qt0G5ena7D8HSiSMto+GtE1dOUxuVtckEh
	b/XksuqtwUPq7XcxLyDS68LsqCgto21Z2R/s2+wT5HucKgO3l8CqmhhZdmIkuL39+FFl09NIf1J
	I2n7HwXG6I0Pj5Wa7YUsURy7y96o6N6oVVGGalZ3y
X-Gm-Gg: ASbGncszWYen5lwumIf5sgqx9JssvtKqdW/lVBscfipGaRozyzA1upAECaarat14RMH
	HD1IESw819RgTPlyDfp68NhJFU1qakRy56qL15qGzNHREstZuJBRm7+/vkpvecLoSXw6wQ40Z8U
	JbZ1OLFLFDRluz/9ejq+KWjCalrDE8pDr1k9DOFNwrQJaVvg9JJMxyDPVAuGs6RCn/MLrQS9VIQ
	mn5LivpvaYB8X6y297nNPaqTYIyesMB8y8JQ8AMWXO8CN30HmrhkdzhGWrQIwnlwmztPdeYPA==
X-Google-Smtp-Source: AGHT+IE7Y0lQvf5r/Ym72waDaFduU5pis90P/Y8BoW2WQ2ZgXRN4nLW4iRYkwU9mYPjzWGowKlbiftsAubogUD/WtkY=
X-Received: by 2002:a05:6000:230a:b0:3a4:f72a:b18a with SMTP id
 ffacd0b85a97d-3c5db6bb8d0mr2118466f8f.26.1755867164304; Fri, 22 Aug 2025
 05:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-nova_firmware-v1-0-ff5633679460@nvidia.com> <20250822-nova_firmware-v1-1-ff5633679460@nvidia.com>
In-Reply-To: <20250822-nova_firmware-v1-1-ff5633679460@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Aug 2025 14:52:32 +0200
X-Gm-Features: Ac12FXxHtvKHWX7r4WBjHUgk1Fpgkh30TWxJenE5FBjdNdkXpbTtw7CFj3EHlec
Message-ID: <CAH5fLgiXYj0f0UEPCTjDgykjX3mFo4hf9SUswRYwHzh6Vznwtg@mail.gmail.com>
Subject: Re: [PATCH 1/5] rust: transmute: add `from_bytes_copy` method to
 `FromBytes` trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:47=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> `FromBytes::from_bytes` comes with a few practical limitations:
>
> - It requires the bytes slice to have the same alignment as the returned
>   type, which might not be guaranteed in the case of a byte stream,
> - It returns a reference, requiring the returned type to implement
>   `Clone` if one wants to keep the value for longer than the lifetime of
>   the slice.
>
> To overcome these when needed, add a `from_bytes_copy` with a default
> implementation in the trait. `from_bytes_copy` returns an owned value
> that is populated using an unaligned read, removing the lifetime
> constraint and making it usable even on non-aligned byte slices.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

