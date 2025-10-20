Return-Path: <linux-kernel+bounces-861653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA7BF3433
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E83A3350942
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576119005E;
	Mon, 20 Oct 2025 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ib9X9TZk"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A2331A77
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989513; cv=none; b=lDoQJoPiM7Fch1BwED5oHkLSa0GFLPsPZ/vniqxBfz8Fp2VLvud5+XJrPgElydID9HmNjxszqLiKhMkIRgfkYUAcnN2jWuQhwapSw+dgQJgMlPPDzUenlL/nvQG5lwmGx4CkmnLfygrT4bJP3J/5ufV6PWYwKI+/Bh92pAH2l4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989513; c=relaxed/simple;
	bh=VCEU0WKOcRt8uH09AxlgIdGdrbwjCqsNTrZ5PR2D38E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhNQla3w/zC6umLmMjs5O8Tbnm1Q5OoEwkwoh+frVBX56LG1BqKqfQASZliZKWmDHOST+6h5LyZon0Ta4P0ss+AgtZCcEUm2ERc7xIR1xqRow2DHPVyt5w6UclYbKKxrpcZGea7tIaEimXt2HJRj6x1OPLkBd8dt3TsQf1ZVFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ib9X9TZk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33ba38ed94eso5208952a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760989511; x=1761594311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCEU0WKOcRt8uH09AxlgIdGdrbwjCqsNTrZ5PR2D38E=;
        b=Ib9X9TZkHKj2D0thJvwbpRFLaZFa72cofLe0ytzoAyEV8mCmKn9EUk8kF8p4HRlOz5
         uRXYw07qztw5FPac/MVOA/9Ik/KmGaz0F9Q0q9atZBuiYYWgETfcnMm1XhMLBdNE2Fak
         o7VrXVp/fS1blf6gqyxarxC2xwezy8il+oj5qx/g0IwuDo9DlTod9riSf8iheof9C4S9
         BGf9q1kKM9BIykMeUPL3B6SnZdOIWr4vf68SHptB9sbo90epShdrOOLJXQJyrF+cxQPr
         eaBPx7Th8a3jvZZWnU6EvP+2ZMvavHhvnPtUXKT3qr4wKqLuHjR7taLPWSGnXNOekbKE
         Efpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989511; x=1761594311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCEU0WKOcRt8uH09AxlgIdGdrbwjCqsNTrZ5PR2D38E=;
        b=Zfz7ITn9sIstMVFqCJJO19qiSa+/S9DaDidkgFeFs8RAu3bhbqI58jXqo7gwxLTfwC
         /oCA1CBNGePHCk+nnH+ZIJSoFqIA6JY28ufTrTGs66PnDCOXxttAlySM/+ubcFF42lxd
         pF96iPpw61BycoYmHCc6YyaY1334goj5n1MYP4VU7fZUsExu5UaD26wOa4MtC6W5I90/
         OcgvzndB16GUJBR4lrGE9wd7mnhOIJmNfxqlS4Q4B/jnQJJwjw/dNDgsr8HoUKgVp0Nu
         72xWeoCEsAK7oP/R7gapDcOc9eStfUEFDc2WInOUwEDhEUOQ4IE5wqNJ8udWC5aOSiz5
         aNJA==
X-Gm-Message-State: AOJu0Ywa6dDGwgDOQJ79kXEqcnpKoQavcbM2SIzUD76txiXSoXffuX1p
	DbcZGHWnoB9YJrwJ0qVnqOnj4gYm7jbbLySKqQ36KyofX66vk2Sm9wkVkK9GbrnGPXkDR2ECfT5
	OwBFsqMzM/FUmFhnM0Ot3Xa03s31kT7ciGWgw/iuv
X-Gm-Gg: ASbGncvUFED8ptEc3qglkqkvZnG+BScAJ3RIkolpAtxw1PM7jo6EFH+1M4CUnDmXN4k
	06QQ9wx+pMegrcVP46l/x+qJ+UQNuWezufcjpC93wnNPo4Ay7vz5Nc9M9Hm9n3ET8hAChTOySBl
	kJ+2bFvUZrmUnAJElx1EFnpJSujW0z9sCtmR28prO9Ykneif41AQnygTMhQyrXrqtAUg0rQy8U3
	1t1isM9oKNjq0hrIvMd6sG0tGdd1DxTBnYEPinrekfIar1BiSo0fAftOhWH00bIV9OJ+Vw=
X-Google-Smtp-Source: AGHT+IEenXOkNohiqJLVgj5aurgvEoGkiULfuK8scdYRERow3ijKAZkm4ZUS/+GJ7fckXlSK4CGIhPCjIiaxr+Y8pxE=
X-Received: by 2002:a17:90b:5105:b0:32e:e3af:45f6 with SMTP id
 98e67ed59e1d1-33bcf87b6a4mr18241210a91.10.1760989511270; Mon, 20 Oct 2025
 12:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c77eac51a26a0248980027e9f3b3b564@paul-moore.com> <20251017095342.1180797-1-zhanghongru@xiaomi.com>
In-Reply-To: <20251017095342.1180797-1-zhanghongru@xiaomi.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Oct 2025 15:44:59 -0400
X-Gm-Features: AS18NWD3BYsicXVXZu5qzq5h8AK3tIvy-eKY9eQXxou9Vzg-_zWsJHfh8MkXdLY
Message-ID: <CAHC9VhStjnvsgunsrKZ55zMfAAGOySLtp-TNGUKZcECJO2LkOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selinux: improve bucket distribution uniformity of avc_hash()
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:53=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
> > On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:

...

> > If you want to change the AVC hash to something else with better
> > performance, I suggest sticking with a well known hash algorithm,
> > ideally one already present in the kernel; that is going to be the
> > quickest path towards acceptance.
>
> Stephen initially suggested I refer to the jhash or MurmurHash3 algorithm=
s
> in the kernel. In my previous testing, MurmurHash3 also achieved
> performance improvements compared to the original algorithm, so it's good=
.

I don't know if it would be any better, but we also use djb2a for the
symbol table hash, see commit 32db469edfcc ("selinux: improve symtab
string hashing"); that would be another option for you to consider.

> I plan to move the MurmurHash3 implementation from avtab_hash() to a newl=
y
> created file security/selinux/include/hash.h as a public function, which
> will be called by both avtab_hash() and avc_hash(). Is this ok?

Sure, that sounds reasonable.

--=20
paul-moore.com

