Return-Path: <linux-kernel+bounces-743798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A1B1036D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8ED356448A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5121F2749F0;
	Thu, 24 Jul 2025 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrhxOXon"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48232749DA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345322; cv=none; b=dmKQrppNBxwd7+E8bS7gbNabd450Y8Q/FKcGSFnjPZaaiMCmiK/4AUDyzPkpeqep7bB4XXjTNxPAmj3UVmQHnUbjISfWVfGBdP4JiYniptzrvdsqaq+MKH38vPvHHvkvcUvCVSrcsBGh++pdCATa/oaUZg414TBTKtHs1sos2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345322; c=relaxed/simple;
	bh=lU2qJ2eNm5bITZLmn/fIF+MliGvrvmLfk2L+Ql3Hrww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEuSRlya84ojj2c57FDqgihveaie+vUx0lh3MVRXAIstBMTK92cRia6k7E678zirtoAt2N038ezLaczM7sneIUMrcsa3u6Cny9Mp3qGcXtoUzG//H56R/+B/PL3MnCEuuEAFKVtMdqfRPPrsJz8cP4o7dF0ecgCt5JdPlDo68FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrhxOXon; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so538513f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753345319; x=1753950119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qHtcMc0408Zu5EgcfjQqPB+I0ZAppu4qXBL+zV/PVo=;
        b=TrhxOXonlTs1vq71gJDFHjcf08+mzERxwmhMCx1TW6zaI86g0V/YNBxHQ/SuS4alXx
         DKKT4HNzsF3dpQNmeMXijTkcmrriTmLd8y6iaHV6wVvbDwd8w+IiH2DTF68qoHQaCR8L
         PdQg1P5GWTc0sWG9ep+Fvegj55kYz196Yb4flUCQP+w1+3d0XveanadanaILFftaxpnL
         B9Ns2Tn95xuKJKixoJCRTvJ2OIHRo8JZPIs8VHFk0hY7k4p6EI9f9k/ORYi4gmDxEI0o
         fs8aE4PdOY2O9MAFyR5pVtIJXgJnn+7h3rYu54fBPMgXG4Kqbc5GtTtCvojPZTNyfDrT
         guzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345319; x=1753950119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qHtcMc0408Zu5EgcfjQqPB+I0ZAppu4qXBL+zV/PVo=;
        b=DdYfqego8kalfNTinylSOWwazPslVwFZoiOQSrFiPVkjg/av1b6sT5XWCrbAOYpolX
         kr5zoK7bE2bCX+9WIGTynlNk7rYCn6ONA4COG3MtnzabL3k4lwkHdV+Uuoc77u5YNUms
         evx4qg+yshJCxt0jFeJm9VcAZ31EWZz7M9/ii5fHuw3wYxIdqdJ5Tc5DJnzyCXuGtoh6
         8L4vXXUZkl6fh09XiGPYRU2TIO6iA5hAWCsHbQ0cfmdtKggtJdo0nCGyC93Fa8iUhq4I
         JlYup8kemfYQGWjhEHCoGYAa5IF3ticY+hSgk17yep0p9r8MwAy7STizQVUTwJHhwAX2
         Ukvw==
X-Forwarded-Encrypted: i=1; AJvYcCUV0sY8y752W59FdulyHKwqMa3hsNQnA7zn7eNB9uhD7XQULjKYE5lJ76thyniccM+PQnK1L8BK6Bujpgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcaeV6eJI6dN0U3Rq2k/cSA2OEJbhd/2o972r08qXrzDZeIaWl
	/VYi1NMhYTrJra6IQ7BALTInJ4R8NOVmyUepJdX/Bu7O0ighnrUBVmcM2V6Tk4r030sp2veO+Cy
	emNM+L7i2H1Ht1x2tbbAPTA8M+l5gQVVWOsUKw/hu
X-Gm-Gg: ASbGncujSWR8l+buyMIJHTrgDFgYB+UDNRc+AC8IeIbpMxKwr2QN5K6vy3Eu+D9Av1W
	tQnn4K8dtJ/9VFeUNzvCfUiJP7TO5hmXV5dBW5Cl8T/pkRLPlegDIpdXBIyyqJB+nyxGaQoegeK
	z4XBFhXCJSmqaLDWVfyceE5KRkIMvkE8oncssPBH2jzDsr3d63OoAnSJXdcpjJZo6RyaKAzE5i7
	tepou5A4RxHJfV84Ch4QiLpZhDdOm4SNYTjUw==
X-Google-Smtp-Source: AGHT+IFZ1bWCA0CLHrAf6RIMJ6bhocJ8Mk6HZEH6kbkHhDxkoLS0mxDLcidXvGs7uje5KS9AOA9iBiJLV+Zkel6NAA8=
X-Received: by 2002:a05:6000:4023:b0:3b7:6828:5f6f with SMTP id
 ffacd0b85a97d-3b768ef39b5mr5386441f8f.38.1753345318973; Thu, 24 Jul 2025
 01:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753339262.git.zhuhui@kylinos.cn> <376014022fa799f5480f6f993f1e25b2561507e4.1753339262.git.zhuhui@kylinos.cn>
In-Reply-To: <376014022fa799f5480f6f993f1e25b2561507e4.1753339262.git.zhuhui@kylinos.cn>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 24 Jul 2025 10:21:46 +0200
X-Gm-Features: Ac12FXznCB8nMDpbedYxLMvA0oxkOQotm5Qo_JUE4Fp-kkB-FY9f8E_3CgrKh4Y
Message-ID: <CAH5fLgiYnZKtrHxtTHfw1n4VbRakNa1Nid9UHPWOwfNh-QHoUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: alloc: kvec: add doc example for `as_slice` method
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 9:54=E2=80=AFAM Hui Zhu <hui.zhu@linux.dev> wrote:
>
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Add a practical usage example to the documentation of `KVec::as_slice()`
> showing how to:
> Create a new `KVec`
> Push elements into it
> Convert to a slice via `as_slice()`
>
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>  rust/kernel/alloc/kvec.rs | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 3c72e0bdddb8..d384c34d1a5e 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -224,6 +224,15 @@ unsafe fn dec_len(&mut self, count: usize) -> &mut [=
T] {
>      }
>
>      /// Returns a slice of the entire vector.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D KVec::new();
> +    /// v.push(1, GFP_KERNEL);
> +    /// v.push(2, GFP_KERNEL);

These function calls are fallible, but you are ignoring the errors.
Please use the question mark operator.

Alice

