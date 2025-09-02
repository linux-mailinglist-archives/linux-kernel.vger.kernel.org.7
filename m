Return-Path: <linux-kernel+bounces-796206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC275B3FD4A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8776B1B22B65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812C2F6183;
	Tue,  2 Sep 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIz+/tyL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A32E62D9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811130; cv=none; b=qmIMwbvS/DmrQI3KNRyrwOXGGTn7kvDGPw0ECI34qHK1ASTJ+tSJE/Ksw53yunx+cNbHvKKeoSbMk9B5g6Tp1e8GQCbB4FyL0Un6pRaZYcT2TuOB6kfNjsu0HFOXEhsDzi9b1UKaQJLfE7SGTBxC7lXNIEHnmEjEetwL0/LV3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811130; c=relaxed/simple;
	bh=JNhLbkrTSSYl1O0oaQX9iodNALQo/R7RSOEwFYkJ1XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYEMBamc9YB5INx0UWBt4baDHUcyL6nX25Cw/SGq1QkislQ9SvoCxRxnScqMRxDPcZcZGVHNSQhy70oBFDRIh/2K44cX3W9JZjHnVAx5vO+7ljXyVKqPfa2kSngbfMNjQZEs367pzntUjdYP2GDFBaUVqaXmW4Zhwd0ZI2l5HTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIz+/tyL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3cf991e8c82so2745903f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756811127; x=1757415927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNhLbkrTSSYl1O0oaQX9iodNALQo/R7RSOEwFYkJ1XE=;
        b=wIz+/tyLynWinX07cShV7AOfQnG8aytx5+sMI58P1ASrqbRxI+mFfY24XkTovyYHA2
         6YN/vwkUVbwqU9RS/EQf5eNtsGct8grrdxMWIdJHvnxrhqpBbRwgWaZB7hn0+Rma7MnW
         CNnlGtrp1daRKOVvD88Ea668GdTjchMSslmoX0ZK/upxEu3Fmno4CvRoYXVNByJpOIxg
         5UA689tnYpt1rMJ/BV+tUrHaCnKS0da9ogrD1CMXWHm2x517kQu5rRjyaZyvjWcnU2R7
         grOM1lZNC1NadSCu2V7zQNWWUF8k27YP8e3VVvyHFuS2g4uP8i/So2q8B/lXgGIFs62a
         lyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756811127; x=1757415927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNhLbkrTSSYl1O0oaQX9iodNALQo/R7RSOEwFYkJ1XE=;
        b=Jn1zfBCoACoaXeKorj1YNhsHKm1DniPLaz2MJUjMWneZYpgYkO2BfCOsK0FLpHm5k4
         macn/pOl4OjcGKEyX0jew/KDon0CNe1bVKaMi7ujgkMBDC9eJ4Tv45JHE4v1rM6eouXp
         2I2bGHOeb/nKkmo7BW4+XHd5Pk9NEPI+hSnsOTiq7k0mpGWOjtoaTVj7OTyoN4WdC3eS
         JLX4O5aDx5ALgeE1/eVVx3vZVzCTo10IU6H5VePNRNEOqtxEL2LJqUco8PDLRNpEzXcJ
         Nix+BLQQQ4mJKPFQ9yUQvt/zgi0x3mvHGp86lx3/t679XOzJReF6fyYX6myv4zwhOqus
         oS+A==
X-Forwarded-Encrypted: i=1; AJvYcCWmweUxIWPuuRdk22iYLJ7kgvs3I5G10Izg6xwAQWGBbT52hLFTcnCaWt/eKI4EIQ19/aWDGqwqrPBcHu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4r+/pu3rZzC1QEZ6YvtXfV6aMMdMXdKhG0g5EM7f2RiB+fDPT
	cLzXMAE7mAbIn2lBk1M9xbhR2FCxTzzWeSsfiF8kWgfnWCGacwJRs9ckkk17zLvY/ksq1b7oFSm
	4FwfdE/Y5wxZwW6QM09jDGIBZj5rCtwybKoSdaZHM
X-Gm-Gg: ASbGncvhQUfQRcOJ5bnsKOxy8dGrKocI23/8+6XhSPEYI9jQd2U4sf/MPqJ0X5vWv2U
	Hztt6I+DoKEZNGmhPWpgR6S7So0fd+XVcTRJWDlNn1MqofxAulpFST8rozM+xpJzN87boNXVWG3
	l5Js52b0Tbiq76T7UvAviMLUzM1VCx3ftUZyFau+pe4OAJ/8Vy2Tygem1euEmMFSLnTPY3p3H3j
	ETfFf4v4UqK6ZZxabxtIR5haUAU6aP1yxtaC/09dj02xbTP/3+7EgCGzWYVVGGV3gTGQWJ6Vm2W
	E9uXWcaINiM=
X-Google-Smtp-Source: AGHT+IEir5U2skpXGJOKBLRo8SShEmmKbmwKkr6fi+yT+rQfVyO6HXi3h1QxrXMkv1T7lG1XS1yx0dP3rkpZMldBUX4=
X-Received: by 2002:a05:6000:268a:b0:3d4:2f8c:1d37 with SMTP id
 ffacd0b85a97d-3d42f8c2014mr7963608f8f.26.1756811126368; Tue, 02 Sep 2025
 04:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org> <20250902-rnull-up-v6-16-v7-5-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-5-b5212cc89b98@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Sep 2025 13:05:14 +0200
X-Gm-Features: Ac12FXy-xKi1uby6tg12v55n-9aLUomtRzJeW72bbKsP_0DXTmIVIHyqBwAX6YA
Message-ID: <CAH5fLghbUMBqFEEe+xMyucBuwVg_N=fWjCiG+5+wzUzGFHQEYw@mail.gmail.com>
Subject: Re: [PATCH v7 05/17] rust: str: introduce `kstrtobool` function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:56=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Add a Rust wrapper for the kernel's `kstrtobool` function that converts
> common user inputs into boolean values.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

