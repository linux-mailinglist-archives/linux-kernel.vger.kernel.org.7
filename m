Return-Path: <linux-kernel+bounces-850253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0CABD25B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C82189ABDB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8902E2F08;
	Mon, 13 Oct 2025 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMFqA0Wi"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3723D7D1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348754; cv=none; b=hN9+iqdg8m18PX9M5vl3PNOcwi0WTZ4fiX1srXyaXB5VzV7QaMYYPq3NOVzmsjxq43bjuzklENuiOuZ6glK5b9RdKmmGz5sihtMJUVHdaQRtSv7Jdd8ESeTI4H+JOiBcPkHrbKFmj8KqsLTQR6FqOqmCEvHQFLkGB8DrUosjhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348754; c=relaxed/simple;
	bh=f5S5EzRGvuz/r4X9fJ+a+VGxsMoAlj8KpasOUBJh7Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnwioi+YlNf76YACnJtsFRkMbExZoUSJYYUTDaqzuTH7kRredwytXP+Qzaa7MPP3bHek0rJg7EFI0WhklVg2XNR/JGW8Gu2p95/VbSBciert3TThxrviXcMNLaJs4aUPg01rIi3MbvZZDrOnQagHrNsTs/m4AngCX82dBXJKzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cMFqA0Wi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so37222525e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760348751; x=1760953551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVu1hEkIf44NHHLfFJPgY+f91pjliiXRGzufnhZn7d8=;
        b=cMFqA0WiHBlr+qcD6I3/7PFTzWl85dVmq/H7T3GWOpm2RsiGufqjMM72VEAJCLkDAe
         DhwME2wCbZUe7DEF89ZDFF4VAJIqsnIFEAV4/JTlOPfdtrnofR7iyXVAZN1hfd2N1zvD
         cjkK560wz2MEV8zSGtcv412sbn+D+S2jvHo46NcSOT4S+qM5RMLA/XRskJdCNXcUR6ub
         vdIHk6GkDbWXdAUqoptWSvI6inMArupUEQsM91Kh7K9Cc82OfnGs1NVqdZdPosvEkm+K
         9WpEpB5qvuaAYhIBEdqgsjXlBVTSV9WoyT0ozfU53TqH9EdL0CEbRVWMilrPcGyk2xwo
         xz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348751; x=1760953551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVu1hEkIf44NHHLfFJPgY+f91pjliiXRGzufnhZn7d8=;
        b=c38MRftAxMemzDHHtzSSyF7ckfeDcR6aczsdRK5h0adrssW0QdwLyeGsuukdnajSnu
         sejosfwpS4Id/X3jZW0fJoqS6CgsQ6UWxTGpD3mkOPQIJHU5VeGH517m7oiOWpNWkkAp
         wuYunQ8oPDKuWiAi2yd3XbO/5+gPb9gFU2n+0FolBNv31zWX5MX8oliE8+ivZm+GCvaQ
         rp2aHIKQvZtP3yuS4tLTwJvp0ZgePNAERFI7VMBLWxReUY9+IxeCdFggaViOFfHkxv8v
         XBJyz4l6YAF50s6GKbTb7xRUBg48TCDp1V7u6J9cnXwizLqAlK9cFduuMny9SLF5R5ey
         7LOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi2StKJbK03Bm0hLfXSg7iUGrifZl3p9tNjIW4+zLXJMhJjVV4CQ0r4LV13byXfErqGJuAjGgfsCyEyW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZqZXw50n7fOd/1VzGWs3ZaGTyA6eWFKb7lULsy6n3+mpvXCh
	6H/+vKYCHlFW2BWT+1rrrKY9mt9LQCmALlf0n+HCvGrP2kR4uMnJeSRHCia4MzZxMCsozS+SLa6
	X4VELgxgpSJD6pDkmBvS2vblhz/twUlE/+aUYBThV
X-Gm-Gg: ASbGncu/x7XqTcERAfV955RF+By1ytVvJ/AWvyuVweBwPI5i+bZduHZ4xbT6HMXQeVm
	IXaz4LGs+1H7xuej3t3tNMPlflQABPJhJsbD8YSfYJlSbE6ARKHMi/+DwEQv6TlqGYqLQjH/jKF
	Sf373/ZR8zPMGKuLU+zNzKVzKR4dn9r+2GPP4IgnnZnerCehg/2jmGvMaOc7MTtMYVqjoyZHV8j
	F7d5OK3lp2skyItp5RjacdqggP1aEC8V/DgyB/I7MYQwKok4t3mF3AxEuLeXUJml6IDlD2+
X-Google-Smtp-Source: AGHT+IFqaBixRi77uwFxD0KO5fWa70Oa0mflVhXrjLFcAwKyNCUyus7ehKoAqeSTAbzAk4ZDHyQpfzilqQdd3qFUiUs=
X-Received: by 2002:a05:600c:502c:b0:46e:3d41:5fe6 with SMTP id
 5b1f17b1804b1-46fa9a9ebb8mr133351055e9.9.1760348751245; Mon, 13 Oct 2025
 02:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003074939.465517-1-benx.guo@gmail.com> <20251013043812.13186-1-benx.guo@gmail.com>
In-Reply-To: <20251013043812.13186-1-benx.guo@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 13 Oct 2025 11:45:39 +0200
X-Gm-Features: AS18NWC7zd8zRon9s3XEh0rKZRaVm37ojpo0BrRNHaKslRzb8eH_XUzUW9LbRAU
Message-ID: <CAH5fLgi4C454xG67vN-T5rRV1X4-rAGEj_ftnHqTOoN61wtcKw@mail.gmail.com>
Subject: Re: [PATCH v2] docs/zh_CN: Add translation of rust/testing.rst
To: Ben Guo <benx.guo@gmail.com>
Cc: si.yanteng@linux.dev, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	alexs@kernel.org, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	corbet@lwn.net, dakr@kernel.org, dzm91@hust.edu.cn, gary@garyguo.net, 
	hust-os-kernel-patches@googlegroups.com, justinstitt@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	lossin@kernel.org, morbo@google.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:38=E2=80=AFAM Ben Guo <benx.guo@gmail.com> wrote:
>
> Hi Yanteng,
>
> I=E2=80=99d like to confirm the expected use of the In-Reply-To header fo=
r versioned patches.
>
> In my case:
>   [PATCH]    ->  Message-ID: <20250929163531.376092-1-benx.guo@gmail.com>
>   [PATCH v2] ->  Message-ID: <20251003074939.465517-1-benx.guo@gmail.com>
>   [PATCH v2] -> In-Reply-To: <20250929163531.376092-1-benx.guo@gmail.com>
>
> That means the v2 patch points back to the v1 message ID.
>
> Could you please confirm whether I should start a new thread for [PATCH v=
2], or if there=E2=80=99s something wrong with how I used the In-Reply-To h=
eader?
> Thanks for helping clarify this.

When posting a new version, you should start a new thread.

Alice

