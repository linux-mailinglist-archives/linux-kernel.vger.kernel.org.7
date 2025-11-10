Return-Path: <linux-kernel+bounces-893351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08656C47220
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77AEC4ED2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B0313265;
	Mon, 10 Nov 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKC+C/RN"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081031326C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784438; cv=none; b=npsu7MqtYIByq3+48xbjJLwQY1ovLqDOBWR9bHW8yA8/eQxZR8SGPCn1fwZo1hSoVWuFJnkDWYc0LUCF4ZuvZwhbtIEf7jyp24cyP+6HI4XG1oKF4NCGD2BjY+g1anMXdogkDRsMj++JCDgRi6KJ1DtAcehwp4apiqftNIBouA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784438; c=relaxed/simple;
	bh=5RJhHiiCQwpWrTvgzqpoOfkmMP+cjTCBSE/GzQfeUmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ikp1pQVF3rkrhwSHRb5K43cp6LtSWrt296MssQat2b8eioKJK2IYPkJmJFHi+cGJQup44mZsz5FivJasuHCW4iGjOS16eYdp56Olu9ZLdlxNExVM2EJ5IPPVhq5xrO0zgUVRcPVIQFyOE8+USaxWAsetIVHuKUBYIrRBLuilQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKC+C/RN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297f6ccc890so1116165ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762784436; x=1763389236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RJhHiiCQwpWrTvgzqpoOfkmMP+cjTCBSE/GzQfeUmA=;
        b=eKC+C/RNcmvF9/7kIronPyxyv0c4XMQUhOnLeLqCjVccI6SdWmDRHSFqwlx4uH9VX/
         uOIW3UyFt5hgeKdgB2PLgMSqF81ew2KlYDa8VegWS5nLBdK+kujRMsCOAj1YIOQSPfvM
         LmUjrTI8dFCTlnFKfg0+z2hDEGQwLY/U2TpVtFtCOIcjWtCH/qL6KeTcpXGbVxpkLr2K
         928OiyoRKMwm3mVXkcyrN6myhaGNLdbZ5RnUkpGFbhAY1Ri8TihqTojt2FhkpGD3vHhO
         nRNJa6+oovjzXglYDxo2KObrVHXJU8icuoleIYRKQCtubnxgLuKTQ2ejGpYSCDV4SqdT
         6r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784436; x=1763389236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RJhHiiCQwpWrTvgzqpoOfkmMP+cjTCBSE/GzQfeUmA=;
        b=OJNtmsDhTRj6MlZAYSsNuehX1zuEIkiGJMYRs/5je2TvcEYS7OHYuTHWYB4g+36MYH
         9VBRSng5uyebu2DWtE8iUcwqxmDbknd9kF00OQDrC+udcI9AbqS0hY7yeB14U+9cbTyc
         izw5+5ftd50i3tPKwQD+qkmkjpdi1ZDaNQwbf2/dZKsH87OKCub3CFvqiVE/4fsa6GJ2
         4EVLz5ktFPYYzJQIkGPNRkF4y3QI+InDKxYf9zQHnYPgNGnXAlZpvcNVpAfP8Iy3WpVa
         K9gSgG6onv8CsmR0+wG5DuSfJ4xfgRTjq92Hcog+mjg3gn5+SzWE2HTOK4bVrGwop0zp
         irSA==
X-Forwarded-Encrypted: i=1; AJvYcCUTyD5leTFy/hMw04q1bLFAgo5GtYZnu/Vwuwj0PybUrH5Q6iSeOk4DUzfV/tt5tbJktJaWGP0+2CSWB+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+m3Lkyyyx1LYyYQD957T2O9LNpURB69j3OhOtA4QZptP9pJ3
	KvshHZvtQKLK8mv6qe+yS3nj9uMfy8IIumOM7E25Y3OWEM4KCvH7WFZ3Cp+Y+4Q36nPwqo4M5rD
	A9KGhqrNpWRkPR13OTRwp+dgpxhhIkvI=
X-Gm-Gg: ASbGncsTwcyzZqVQsqaK690dWgwH2UIZCDfhcboFa8QvPH/oUkEw/RePvnNG9VgIR1Z
	Fs1/uqKk35Ioz5CSawqmcTjmlJs+jVC7R3gqiYkKfH0S1c1pws5a03s+UwTTJ4X+Gviq4Uy/KW4
	zslqAG7VOx30/WMWxTE+9THWigj+p/kNnaLDP//vCw15F6Ane7qhj+8JHIUMP0VHhJbuxlzcILt
	GeC/VmKtVG1UBsGyLRY81zZwoNsbsmfLHiYV1FlNuc/7nsgXMC+K4LFIQaW+LgrXHL0KuD04Rbb
	OSr71PcrE+w1JmPeyL8feQf5q3UDkS9InsWPijLqRcCcCsLzIkUEtfreqvb1+7aSXo83VTLpPU0
	6rxI=
X-Google-Smtp-Source: AGHT+IGZkiX1aUs0nv10YP1XlBKx2b0IQf5b14V0qJA2D3DBZY4ttkzgbksRaQa0wfRvU24Ndk4q5iwI6HlbKZJm+ow=
X-Received: by 2002:a17:902:e353:b0:297:e604:598 with SMTP id
 d9443c01a7336-297e60407famr37566705ad.4.1762784436127; Mon, 10 Nov 2025
 06:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110135927.05d83da2@eugeo>
In-Reply-To: <20251110135927.05d83da2@eugeo>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 15:20:23 +0100
X-Gm-Features: AWmQ_bm2tVFpKh5HhJeEvZYuh2tSSNBK7puyKDd5qGaAhmDUcRORxxihnStSDk0
Message-ID: <CANiq72km0fyL+ueULZZCcg+2Uc5HTtdE_C++WfigLFnqE4sZ=g@mail.gmail.com>
Subject: Re: [PATCH 00/18] `syn` support
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 2:59=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Thank you for creating this. I have been wanting to use `syn` even
> before RfL was merged into mainline :)

Indeed, you were definitely one of the biggest proponents of `syn`
since the beginning! I could have mentioned a bit more of the older
history in the cover letter, sorry.

In a sense, this cover letter could have had a
Supported-by/Wanted-by/...: Gary & Benno et al. Actually, I may just
add that :) And/or perhaps something about the history in the actual
commit messages or use the cover letter in a merge.

Thanks a lot for the very quick reviews and tests!

Cheers,
Miguel

