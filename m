Return-Path: <linux-kernel+bounces-890969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3094C417A3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 714BE4E3BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104BA32E131;
	Fri,  7 Nov 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLlRaKRT"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB930F953
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762545093; cv=none; b=t+qWiui8RKyV+Nai7FFNJUMMjkPm6wp9TvoB824byDX4Ki3QF8qegmxSQ2DSKf67AvV/sm00DmGv7/wdcFPTjk+LesNmilIsBiArbWy18pnvKGkHX75jFdbopJCXZU2MfNJZV4/Txs9FGgOFVBeAnc3gpPljiqJFJJmTnYoEQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762545093; c=relaxed/simple;
	bh=LwvNTetXQLBxY1Dihygez0M8/N/kMn2ykyvFcBvcJJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n7vH8W5yCF6U3m7UzBvfjdPiTGh7FKMoQPFjnKPP56ZSr/gATFGtQGv//nl0xWABtXIMAqC+ItrzyqaWMLjXOQZ2iIKCHQbieRO4OkZ+ancX+01CXU4XZ6vfLuTfAQON9T/XiuGWe1zbzj/hhvLxRpjvLUTErJGiDr2qrg9Ze3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLlRaKRT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1285359b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762545091; x=1763149891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LwvNTetXQLBxY1Dihygez0M8/N/kMn2ykyvFcBvcJJw=;
        b=DLlRaKRTnqoAajt0XMqGZ/FRnmqR6HCM5VMVE7HeC61NZoFEpYs27LL67qQrKS4j+h
         9Ry7uUwwdci81mGC524kie+CXxv+7Kuri2GILxxSZHJsdixjHL9JrFToanPfuIYSAhcB
         WLl8NtbgLKiE8LHCHiMSqEI8pg4Io18sa3vNunhZReQ52riAl+LIOBCuSoMUNya42EDh
         DF4aj+Ayyiot8mg1DFxwkVWJnHAW6EJ4cXtxKl0cjQ1Da0OeOMtzLN1fT4QJnPoqELnw
         wFfxsPka8v752CfJbJLDZhQKSC5tjKne22Yv1PumoV76Oms6Y5qTW0ag4N4Lig04TxbQ
         q1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762545091; x=1763149891;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwvNTetXQLBxY1Dihygez0M8/N/kMn2ykyvFcBvcJJw=;
        b=R/AE603+L6dos6P37hDqW534Qe5XWqafK/DPirB0xg1nnb8J7I3yc4wX9IplecmYEE
         zercABxAJtJVQTEzODyxltdxu9G6snCaixinfJ6ydw+rlPtEjYK7zKjkABeoG/nVes+F
         iXHL6C9nLtKCO0+XvPb3L2KkcT/rQy4Y+TLesjfe9a4MmU18VPJmHDMPJ67/iqCJiEg+
         sTj9B6CJBxzbO1M09VG5I4TX26aINY5LPrG4mqRJxvhyXWQo4OxoEYX/yr76sYtLtqpi
         AVu6rl0jEvqpbKHu1GdxcwoFWZTG5Ttmc6G6rUWQwa6wE289lR6fxhOyOycWLE8gTNe0
         DRhA==
X-Forwarded-Encrypted: i=1; AJvYcCXLN6KWrMCoGNNI80Hq2+ld0PUrXCuOJUnc+7lMyA6c6iDKXJ5fanf40MLQYlwZ8CUVCaI+V4mAXJP6yZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfdu+9boQBSs0Usgkgis8rc1ZX02iTFzIGp+HP2xvd96p4QKQ
	7mu1gr5N4qgzCMVLYHj8JuNdVHc88QEhrpHts8K4wFt/9TI0Zmb5yTHG
X-Gm-Gg: ASbGnctHMigzY4PB8NTvpv/9ghnhbYU5fWIEUP6nkERNXwhQ9e+upxdT13uhv7RTjNY
	dFVEs5m7BjHmrYp9oqoZnPR6Q9iOp77OnaYPjIETZKYoP5x/AyA8H/rNg+71uWYu5HTixqmURZ+
	POktCcBrIElyuGIWdygu231dlQnF3GuUu3R4KxBHrTfm+cYEh/srUYrhyToTr/YR0iSQADq1eWP
	NE7fGYkh6n7oNpHHExl6rE7dCEQZOqGuMmWZ1cRjp35wYqaGFmqRjDca89ZzsG7J67qybXMXzwc
	J3CxGa56n2oE8xNZC9nY1sgj4GxSp4G4gPTycHqCz3Vp+4xHoJWQkEHkfScw53RNmti/T6+3gyY
	ah7YFS0gLvZNrpJaizOzYtW08CwX2G6FoBAjdypK+wr+41h/Jke3lTs1XPftf8rTid/xilDM+nH
	3bxc40/fU=
X-Google-Smtp-Source: AGHT+IH4kmDiMAeLWcurSK75qHGKTOjb0w2R9m5O1XJZDMjTuFy2C63qThx0nk8Vy0U5BQOcF8ugbA==
X-Received: by 2002:a05:6a00:4fd4:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7b22737e23cmr459610b3a.32.1762545091182;
        Fri, 07 Nov 2025 11:51:31 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cd01sm3683726b3a.15.2025.11.07.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:51:30 -0800 (PST)
Message-ID: <6cbeb051a6bebb75032bc724ad10efed5b65cbf7.camel@gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary
 search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, bot+bpf-ci@kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 zhangxiaoqin@xiaomi.com, LKML	 <linux-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Alan Maguire	 <alan.maguire@oracle.com>, Song Liu
 <song@kernel.org>, pengdonglin	 <pengdonglin@xiaomi.com>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann	 <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>,
 Chris Mason <clm@meta.com>, Ihor Solodrai	 <ihor.solodrai@linux.dev>
Date: Fri, 07 Nov 2025 11:51:27 -0800
In-Reply-To: <CAADnVQKbgno=yGjshJpo+fwRDMTfXXVPWq0eh7avBj154dCq_g@mail.gmail.com>
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
	 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
	 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
	 <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
	 <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com>
	 <5a8c765f8e2b4473d9833d468ea43ad8ea7e57b6.camel@gmail.com>
	 <CAADnVQKbgno=yGjshJpo+fwRDMTfXXVPWq0eh7avBj154dCq_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 11:01 -0800, Alexei Starovoitov wrote:
> On Fri, Nov 7, 2025 at 10:58=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om>
> wrote:
> >=20
> > On Fri, 2025-11-07 at 10:54 -0800, Alexei Starovoitov wrote:
> >=20
> > [...]
> >=20
> > > > > > > @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const
> > > > > > > struct
> > > > > > > btf
> > > > > > > *btf, const char *name, u8 kind)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out=
;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > >=20
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (btf->nr_sorted_types !=3D BTF_N=
EED_SORT_CHECK) {
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (btf_check_sorted((struct btf *)=
btf)) {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > > > >=20
> > > > > > The const cast here enables the concurrent writes discussed
> > > > > > above.
> > > > > > Is
> > > > > > there a reason to mark the btf parameter as const if we're
> > > > > > modifying it?
> > > > >=20
> > > > > Hi team, is casting away const an acceptable approach for our
> > > > > codebase?
> > > >=20
> > > > Casting away const is undefined behaviour, e.g. see paragraph
> > > > 6.7.3.6
> > > > N1570 ISO/IEC 9899:201x Programming languages =E2=80=94 C.
> > > >=20
> > > > Both of the problems above can be avoided if kernel will do
> > > > sorted
> > > > check non-lazily. But Andrii and Alexei seem to like that
> > > > property.
> > >=20
> > > Ihor is going to move BTF manipulations into resolve_btfid.
> > > Sorting of BTF should be in resolve_btfid as well.
> > > This way the build process will guarantee that BTF is sorted
> > > to the kernel liking. So the kernel doesn't even need to check
> > > that BTF is sorted.
> >=20
> > This would be great.
> > Does this imply that module BTFs are sorted too?
>=20
> Yes. The module build is supposed to use the kernel build tree where
> kernel BTF expectations will match resolve_btfid actions.
> Just like compiler and config flags should be the same.

There is also program BTF. E.g. btf_find_by_name_kind() is called for
program BTF in bpf_check_attach_target(). I think it would be fine to
check program BTF for being sorted at the BTF load time.

