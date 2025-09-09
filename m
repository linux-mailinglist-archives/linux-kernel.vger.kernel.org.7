Return-Path: <linux-kernel+bounces-808795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E1EB504D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A887AB8AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942313570DF;
	Tue,  9 Sep 2025 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aeqREOwg"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47C352FE5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441202; cv=none; b=WgppGexsi25eIhX9fWrjl5kGzilR3Iwe+mcKq+0bxxSIBd+4KESoYMgmKl7TxncR8p7ngadQ+C4BqUO6W+c2EpoawcJ5C6ZcfimlgZ5950o45RChTjkPAfLDSSW49jsfLRowtZGLYUtJAooLhkQ+qTh9kv4ezUjlRFTFPK4nSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441202; c=relaxed/simple;
	bh=jZ4q7/TmAhAt9Egg4Ce9ImZslltIxN0BNL1jgujUK+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCXXeKRljgWFt1EcLcO+27AqbNh9xYEp4Ba6tRA2X8ow2OemYxWkdZ/sIFQnjFZ0qFqRDNhaV50O4U0JeePNxj2WGdjp1vEAJVq+BV8SOhpOBZc5pG80Ybw8lYiUM3i97Nx/yV2tbsQimhY3EBwsTrLMLWdfV+epMRr4ic/CCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aeqREOwg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so1632a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757441196; x=1758045996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs2bT3Dg9Ff25HRhQXBnWG6WLypX8eEtjPTIvXY4ebI=;
        b=aeqREOwgtqZzVMwht/CmjhUXvcOqESCiykwZa6O/6NtvH4K8D1xxEC7rD2UoXiDlSx
         Ztw3/m6BjtCICe85Aai3y7zBZymhJfVoZw/UYFacxzsrx/9y/+RZS7C9SL9WHw83PLNY
         YuB85yMUbXTGKAaShc+0/B8DnZ3Mdkv2zZfhJ73vrgiXjWRGmC798/v+5YudnkS2yQXA
         t9Y/60lpdxHMhpJPrvEcQwJMAcjhjrnnClX2zlayJBH18EfOIOyMR/XH0zL1ueUo4bO/
         QfSLVQ2245wwr3UqgwXtKBDM4mDWs7ojRYOWYpqUABhiMeNUCY6dUVzakxi4WPTIAQ23
         UJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757441196; x=1758045996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs2bT3Dg9Ff25HRhQXBnWG6WLypX8eEtjPTIvXY4ebI=;
        b=SSXTyWwTp3uOzHQDXedyyYTYJ0NrVC26Sbatf3fN0fcmpG5NBQvNW8gOoXO4+B6e7b
         eAxsyjsdG1x8L2yFzW8oika4GT/TW2za761VDO/RTB7FW99xZQj+t2gHHfR5FWpmRgY/
         RAcAbf2/aBfqkeMXAgCaqyFObKpM6rp1UILIGzMXDlTZ5m18czEAO90lWZ+sbQgCxg7P
         bA6Qs/cdzUVNMhuSJumMTvXPaNWjnFQIJxbTvau3p9Yj2+ZEKolpUGz8yZu6wDliLj4P
         IVcufSDMiPhHDRME6/uuQlWS8lCOhOC0ezmSeWG8al/UB355V2e4K8xDSDviU8P3U6TQ
         4VbA==
X-Forwarded-Encrypted: i=1; AJvYcCXBIu0T9eTQjBNNYcMS6Wis69W0E1rMR/QRozSs0tammjiTzLDtH5uKNDijGaxWaYYY2q8LlxaXb9q49gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uC7MSogbxIdUyXb+qkpo/z6FDjYOfobbAsmVLzOkGCtXccJ3
	eNiXc+x2Ly+QKjP0FZd/0gi4dbgb1nAghZoPWnbCSqgIK9SWiqTzpdXVn7DO7qJGkSIMB6OyTtv
	3FdUclQ0Q6a1OD3H7bvIQyTO+FMY1MUDAvoOilXer
X-Gm-Gg: ASbGncvduNIeZB73beO3pusMtuw0CMpQHT2PmJ9pe+YP6I5oHP25or/iaYdnf+sWwDQ
	VknkltGAtRqvTrPWqpVztthfK7WiHYH6ad3xIFpveVWDVJDAqkJYC+U7XiIp+TuCTnT61Nrb39x
	MMNi1kpVe4DDoTavw69SmKNKWYPKmVJQDcpjqVBfAAfAVtGKnyrMAUBriEJumBc1eJvWyKXwjQU
	k7ORta0tfN5Nj51K+StTIXG6b1Y9ynQ+7hSDTVIujhz
X-Google-Smtp-Source: AGHT+IGeH7jyX9ct4ZAzKinokBQ1+zc2FEaXfp6pE5j81gEVTiuyh5DC4nkYapGmxfFWYMAqNWcHbugCP2vmV3t5O7Q=
X-Received: by 2002:a05:6402:21d4:b0:61c:c08d:359d with SMTP id
 4fb4d7f45d1cf-62d27d84e7amr6983a12.4.1757441196486; Tue, 09 Sep 2025 11:06:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909092707.3127-1-yangtiezhu@loongson.cn> <20250909092707.3127-3-yangtiezhu@loongson.cn>
 <CANiq72n7OSCUzycAQXFybx6BSVnj3MWAXvZj7U=AWf_UQwmO+g@mail.gmail.com>
In-Reply-To: <CANiq72n7OSCUzycAQXFybx6BSVnj3MWAXvZj7U=AWf_UQwmO+g@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 9 Sep 2025 11:06:25 -0700
X-Gm-Features: Ac12FXyLkTDu-xW8KQeBG2jwxZmVi08cxdiK25_6D-p0oCXaRRpW6X0CHqv7ho0
Message-ID: <CAGSQo01mQfcU1EiW53be1hcts0c1p-HQAab_HBk6VcVmhq3n2Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] LoongArch: Handle jump tables option for RUST
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 3:16=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Sep 9, 2025 at 11:27=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > +config RUSTC_HAS_ANNOTATE_TABLEJUMP
> > +       depends on RUST
> > +       def_bool $(rustc-option,-Cllvm-args=3D--loongarch-annotate-tabl=
ejump)
>
> I am not sure if this needs the `depends on` -- from a quick test, it
> seems to run regardless of it (and your `ifdef` below doesn't care
> either). Cc'ing Matthew in case he remembers why the docs mention that
> the Kconfig one should be guarded by `RUST_IS_AVAILABLE`.

I think this isn't needed. I added it initially because Kconfig was
dying when `rustc` was not on the path, but I'm not sure how I managed
that, since `success,trap` should guard against that (perhaps I was
doing something wrong in earlier development, fixed it, and didn't
remove the restriction). I have tested `rustc-option` with an
intentionally missing `rustc`, and Kconfig doesn't seem to be taken
down (and it gets a no answer), so the change to the macro means that
doc warning should be removed.

>
> In any case, it shouldn't hurt and it is only on the LoongArch Makefile.
>
> If you will be taking this through the LoongArch tree:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Thanks again for fixing this!
>
> Cheers,
> Miguel

