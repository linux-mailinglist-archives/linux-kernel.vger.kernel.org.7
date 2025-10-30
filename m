Return-Path: <linux-kernel+bounces-878919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B1C21C22
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15AAA34F004
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676E36B974;
	Thu, 30 Oct 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZBAEjp52"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9A1F4180
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848771; cv=none; b=pZVEgtkrjGpEc6ckv/QO8+bRGfnGwNCWA2O0pBNGeHpux+oM9jrptr1TjVIqwqxzW9FoV8MPKE52gn6fr1k+SuZPccJSUGNJ2wq1ynIQlTyaDBMpgV5bVuM4JKDaezBaEbEBuAkGclc1EW2eP+J41LA7c/DZCfkDHQWPh/Bu4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848771; c=relaxed/simple;
	bh=PZVE37wwRcSG8WWfpheVX28dn1/Jp9IJqc+83vrL8jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy0L5gSoSghhe4iSWWAdPnDlaHVQUF1SIhpRcl0cGybGbiocHHvYjWRO7CTOl9BOAM9NU0MLJ6uj49iLR9roP0u4t6IXuUQMEu56TcJ6K62hCaPDApKLKQRJEL6q8uRwUckLusos6t/hDkAapGy3K/9LuXktNcvGVxTVXVKrUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZBAEjp52; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so1988172a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761848767; x=1762453567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FG/tgMR93DSZXM9XUANIqdTVWOdWVYK0sFlihrocsYU=;
        b=ZBAEjp52znsHe8cH9qn1AcxTo7KwBNCVWyn9c68v9VVVdYjab5/8Vb8ZBT/Rgj9VBg
         vUGZydmdg22O1KvgUf083f/gyoywkfGgf1/oqrPuSAUuTdfDieDnZuSaz6tL4j1pEoBQ
         7drQhWoiM/4ra4FrI7PEFj/rITTAaXFJ1qOcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848767; x=1762453567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FG/tgMR93DSZXM9XUANIqdTVWOdWVYK0sFlihrocsYU=;
        b=erJaYJSP6e0Dox8gjK7hDlZ9DNpPW/opv5nTqJ87lr+GasWkb2gguRVccg4M9R5Aqu
         HilcUaQPy8mq1bBc//GhhREQglQFLzG4DHn2xKejya+gGuiqmEFx1KmXdqSe+DcKOU6I
         bcHD4i2HhD6knkg0XAbhPy7bjF5BoYnsS80Tf3Malo5E9zBQXNVPAKyDJvydnodpZfhj
         XF/QrG1ydTzBXaIn/J510jgnHFstn3XVFEaB93ZGRAoBRY9KfUCz5DbYpPs/kGCh7SS3
         guxBqFCioahpEwkPYV5B5yGgGXYL2scFaU/Y34PQlMi2/6pZxC6f13+IjhG3L7z0wrrW
         a1zA==
X-Forwarded-Encrypted: i=1; AJvYcCW7BY9xKc9GpAKMxJi+wbx/qUFazdVWl7ur9Ut4q3JO2HIhI9xhu2NsE7bT4R8b/ZWzGvoD6bZeAX5qW/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4bMogPEA99SOrCZdLgSVKXQSc4JcmblESXdl7wUyF204WHLO
	MnARUhpoB02Pm8d9I2ICDbSNEJvG+ZpJJ9iQ5lWXt4p3PaYhnw7n7F+5h8tVKQjq8VFtKhf4hFG
	eGRlyCq0=
X-Gm-Gg: ASbGncsWJQ8iL5a23eprph4Q5mQ02z9ZsR6IvS4p9J0WYtQ27xfHjksFFJ2mY7KkV0F
	EHYfe7pXiXu8tDAamZEnOCow/xlKEPIzTFMFD5ChL91xNJ0p+H5D6hxnh/nsdQgxc4cT37qzmAj
	A7naQ4gn1IwpvE7H0Bp17YVcOqP9IbRJNCltGO9UEkjc7pU0ycLxpu9Q2DxsNuEUpQn9AgZq3dh
	YJXuwbl0E0BP01lQCMwkL6D18QJRCKJCux7tEMHBfyY/sgWfebu21hxNMM+IKVsT1Pvju8YhZsu
	t+0gSlq89cCsy0QgBSYe3ygx5rKCktb4fqmta3Z4Wfcy35tDNIPodZnp3xHXws6vYDfvDIqW2a8
	I9d4xOIw1NIf1RtdXf10RwBtHxWvDClOB/aYS+rSYR5hHhuAtNANUNdsGuYSs8nGBz1DgQDIBsW
	d4MORk8MAXaRRSvsYMSkCIiRY22rBr9TwK3LDBS5N79/fVle8beg==
X-Google-Smtp-Source: AGHT+IHVzoGCa/uAntybx09XKEL4DwbZYJJ0lO2m/jdt9+cuMIxDd78+qyvGjcR/2Msc/ubeejtkhw==
X-Received: by 2002:a05:6402:1e90:b0:63c:9e82:4059 with SMTP id 4fb4d7f45d1cf-64077040fcbmr289358a12.19.1761848767167;
        Thu, 30 Oct 2025 11:26:07 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef96105sm15370101a12.19.2025.10.30.11.26.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 11:26:06 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so1988088a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:26:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX83azW67XIcalHiFiS2tJ4Ild46QQBxRwWeCgyNjdvCuywwiDkV7Wcxdq6YMZs07Kg0QkgI1ZjGd9KjNg=@vger.kernel.org
X-Received: by 2002:a05:6402:2711:b0:628:5b8c:64b7 with SMTP id
 4fb4d7f45d1cf-64076f7cb44mr434963a12.6.1761848764039; Thu, 30 Oct 2025
 11:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com> <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
In-Reply-To: <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Oct 2025 11:25:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifyJz+WCZxHo6FLht380Y7uQAxX-=RqNh7u4978zhggg@mail.gmail.com>
X-Gm-Features: AWmQ_bkokgorRPDRmv0GASJlLRuWoPF2zAAWRYoR--ZWtsDTk3dH-mNwE000pik
Message-ID: <CAHk-=wifyJz+WCZxHo6FLht380Y7uQAxX-=RqNh7u4978zhggg@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 11:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> ENTIRELY UNTESTED PATCH attached - may not compile at all, but
> something like this *might* work to show when a module uses the
> runtime_const infrastructure.

Hmm. I tested it, and it seems to work. And by "work", I mean "show
real existing problems":

  ERROR: modpost: "no_runtime_const" [arch/x86/kvm/kvm.ko] undefined!
  ERROR: modpost: "no_runtime_const" [arch/x86/kvm/kvm-amd.ko] undefined!
  ERROR: modpost: "no_runtime_const" [fs/erofs/erofs.ko] undefined!
  ERROR: modpost: "no_runtime_const" [lib/tests/usercopy_kunit.ko] undefined!
  ERROR: modpost: "no_runtime_const" [lib/test_lockup.ko] undefined!
  ERROR: modpost: "no_runtime_const" [drivers/acpi/acpi_dbg.ko] undefined!
  ERROR: modpost: "no_runtime_const" [drivers/xen/xen-privcmd.ko] undefined!
  ERROR: modpost: "no_runtime_const"
[drivers/iommu/iommufd/iommufd.ko] undefined!
  ERROR: modpost: "no_runtime_const" [drivers/gpu/drm/drm.ko] undefined!
  ERROR: modpost: "no_runtime_const"
[drivers/gpu/drm/radeon/radeon.ko] undefined!
  WARNING: modpost: suppressed 29 unresolved symbol warnings because
there were too many)

and yeah, I think it comes from access_ok() use.

It turns out that all of this "works", but entirely by mistake, and
not really properly.

I picked the default value for the runtime_const pointer of
0x0123456789abcdef because it's easy to see in disassembly, and
because it causes a nice oops if not fixed up because it's a
non-canonical address on normal x86-64.

And *because* it's in that non-canonical range, it's actually "good
enough" for access_ok() in practice. But it sure as hell ain't right.

I think that for x86-64 and for the short term, the right thing to do
is to make access_ok() be out-of-line. Nobody should use it any more
anyway, it's a legacy operation for back when doing access_ok() +
__get_user() was a big and valid optimization.

So I think the other thing that kind of saved us - but probably also
meant that the bug wasn't as obvious as it should have been - was
exactly the fact that it affects that operation that really nobody
should use anyway.

               Linus

