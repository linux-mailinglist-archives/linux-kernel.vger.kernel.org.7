Return-Path: <linux-kernel+bounces-856802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BBABE51FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC891AA0BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1E23B61B;
	Thu, 16 Oct 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/AcmAyY"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C480238150
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640863; cv=none; b=amHOsF/LY+Nn/5MNfeniea8UzZPfW3K1YcxxfMmjcUOEdgtLlHbO4PYyHkocUgXRXu8B/o5UwB+CsGLP2uK4kNpA6K2nNRUkEJ4rtw7Qt/eNhhrxRaDHWFGSqoVlCPebg+aCN/Pm7tbPjkPfxsYpBWF3WMEdcG8mRF4P4OuB6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640863; c=relaxed/simple;
	bh=+utBgb+Y0Uu1IYHRlU1599odQNpYd89QM72RzQIjkKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knFOFXm1wLw1AIh3nSuirGIaVgnyBvyzdAQar2NJMnvwP0QfdhYMQwKJ2hItO8ACE0gRoRXOAjj+V4tPyND7DXKkWJwzegkvWpxtGrDiZyWta+qR/3SXyIMQ2yD135fjhCIhmcmjaqPzoXkTwcPvE425g2p+60S3r9nFz2ezn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/AcmAyY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-280fc0e9f50so1365455ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640861; x=1761245661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfjITJrDrBsj6NyrvMWKq7r/mdAyxrTj8oS5nFcA3D8=;
        b=X/AcmAyYGA+t1YhKP94+NATzTMfT2RmapnyBp+pK1RW/ivJvtADIGOt+BEjkaIO2W4
         JuWbh8C3mYOhYGN2o91ecCQlwtsuBhgDKT72gqJafnWDhEYRX41Ez4nzUutob1/mdjeZ
         UaRCnyao7d+Vp1yXDPWLgiGUnSBZV5/RGDaoEISbEskGsxuq00JA8tpsPBJwHD67CTlq
         7BZvFic4duWbZHwLEK8ogizOFZit4VKsTH9818QTG6BcnDvg3KOXbFA9W99EMFnldMRw
         G7FnRNX7ZRSb8K4uCBMuT8s3V49EKBl1hklAiUk4mzOAy4PwHwbU0ObjJ3EnVST0Ejaf
         DVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640861; x=1761245661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfjITJrDrBsj6NyrvMWKq7r/mdAyxrTj8oS5nFcA3D8=;
        b=mX8FsrZRFPT4TPw6QVOchR/5uJyVM+Q4iyoauOL1Y0gTpifltLXki3E0C59gHmWa7p
         Xwx/L7mb4s0c9wEETEiPyew9g5ULk0u20m46iF7hd1bHx5bEMWq+lhB096jYBfC3zDuG
         1Lp3af89lWnzJqCA7lESPI6g6MYOdKM1ZS0vx6eG8CgXqrnI6SkuwBZuUjkNNKFAVBvf
         HNk3ZI1K9Iq4Gnj+ghKAz/4JyUD4AivPduzxYos5KF9IZ9gC9WvVu4UviPIiPIsS0IcV
         sYPfUxzRk14evriC5QqEDxVpq5xqJslHrTzmvGAmuMLUpXQ/xZVlkAStdRT2iKB5merq
         rIbw==
X-Forwarded-Encrypted: i=1; AJvYcCUf8i+2itkC4U+97bsKJ2GXzSqJswJtH+XIEbfnYxNhU8bLtotM+YmZtX4VmH3BcH94ZEE6/v4Op8HGLmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSpvyj6tKto3UuwR4lwZbpY3UB1hiJ45T+TQWDvSJn89SzwFw
	Dzu7AxUHaqSzVKp262nj9fyT/uupXW1sGwvBUd9uHaxnSuHgoMvClcLnv8jFxMjl3xSEM5moyTb
	d8Zu/rbe77yA8CwtHW459lcXGZ6e+Hac=
X-Gm-Gg: ASbGnctgR4AB0Wng1AqEF1lIrDVqbNxX89c4yXECY5AQ3F5hRYpAucBhDiu/bKJb0dI
	wYVZYkAEeeiVArrMMC1Gi3kUMK0//6BtotcLyZkVYi4Ii5znR9BkZx3dOhHHJFujeswFa+S4Xdf
	P0U/bDGx+gyiOmICOesYs3zAD35bZYmcFzulsXMpJpKmGMt5QjruvBnp9W0IvUgva6lHD464Mfl
	+wk3/wrhRy8n9gPCio6dVCyg9mxji0noChOPwaFIFySVmfljAd4JBQEQoLGGHk9AOVC56kQc7JH
	C2q2/v+KR+PfM7zcHzfTCQyGj2To9l+wOe8x6WT3xzposVxjcD7cjRHTrQ5jiKbYRBLr9SnhZUi
	2+++9/D7ldBOSBQ==
X-Google-Smtp-Source: AGHT+IEbKwbqFQ/fneIGbpfTlhDpPKZtHqphNXdfbEVmTezUHkwYnzXeQIHBTRMspHOBh02pv2qlfv7V0DyvDzmt1nM=
X-Received: by 2002:a17:903:40ca:b0:290:55ba:d70a with SMTP id
 d9443c01a7336-290c9cf3306mr5986045ad.2.1760640861448; Thu, 16 Oct 2025
 11:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015182118.106604-3-dakr@kernel.org> <20251015225827.GA960157@bhelgaas>
 <DDJR102F5NFB.1X5IVJQ6FK3CD@kernel.org>
In-Reply-To: <DDJR102F5NFB.1X5IVJQ6FK3CD@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Oct 2025 20:54:08 +0200
X-Gm-Features: AS18NWANSYIYYVl5goGbtu4qiEWHeLwDVADFRWSVLvLKuJro8t-8yxzSNbn9BXI
Message-ID: <CANiq72mB_M3GeU8DLg5Wnn66wgUimF1Eg8Vpy50AEZoD23O7Fg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: pci: move I/O infrastructure to separate file
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:35=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Those could also be a candidate for the list of "good first issues" of th=
e Rust
> for Linux project [1].

Indeed -- done as an example:

    https://github.com/Rust-for-Linux/linux/issues/1196

Bjorn and others: of course please feel free to create more.

Cheers,
Miguel

