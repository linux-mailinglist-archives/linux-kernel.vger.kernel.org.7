Return-Path: <linux-kernel+bounces-890879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A54C41447
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6405E4EF1B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663D82F83BC;
	Fri,  7 Nov 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbIqRCGv"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C23376A5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539580; cv=none; b=ADtmi1SyTEflX2KCCeAEhQNqvfrA/rTeH9hpOVC1e8SsKL4fSRDccMJeJAD9/hLhu35winj+NnONRFTf69yeUVY1bipSXzKhhCPZA+nFNeEOS+dduWMsWL+9N0YGdbvmkh6TKe9ik8Y2RIeRNHO2dwCE4ladZew4wVGpbqBSgEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539580; c=relaxed/simple;
	bh=Nfg8fIlYXrhKTgE7llskapPtirpxksa9elL/wFVTIH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iqbAS+MmimPA3wiLEwbp661Ja8pgFFU9zKGS7fRKlaLMF3k5l5acvd1N60eJpRnzljjXFtR6UcWg5hrM4d2z56pUbywxUPFtllRCHXyqd+evZeqK90Q5jc4rFYe0B7thdO+SZioNgk/znud3NEccX/gAXmUVn4EUC7m0HYizMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbIqRCGv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29633fdb2bcso11041925ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762539578; x=1763144378; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nfg8fIlYXrhKTgE7llskapPtirpxksa9elL/wFVTIH4=;
        b=bbIqRCGvsm5SgJnmK1OeHVeQXYBrxc/Mc2P1C9XF4II1wOpZggGjUJ8Qd6KDE5dm9v
         9wVCwD9fTzcPDjPHQeQTWKhCO8nhD7LyyWuOxUksoj8G6Obl6tySUMNkpusKeB6v7wYH
         bGqFzP/nHqMIuCUBLcGNcNeRHFo54h6GM8hAhoA6R4YdKIR1gnuAe9BaM3A/d28sGrhv
         80nUSPMOToiS7zMHF7D1GM0yz2Ypeu+KbHeDS0VocJk9BaRvFwcVGEM3fjywgjkGsxoJ
         xZwYn7LTuQrWoWCJ9AgyMwxsQZne+D0Ex3fsyGRnggqRXvgzb1otaVLz37GgvorCc6ni
         UElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762539578; x=1763144378;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfg8fIlYXrhKTgE7llskapPtirpxksa9elL/wFVTIH4=;
        b=fXQhrcnRuXEya2NSGChOHViSzQYedvTDrp08TQiHoaHz8WzoW5Dlff4tweJY9vVGq1
         xAWqqh/VJEJxwdQ5q3rrNKCFMR+605odFNht8LMtOEnvCyW3b1WTntSMwZ03qPBQldr7
         Lqt6iAa42dyKtHP4U4LDYxoNLBseN6Ku/NC+DUfeVnYblaeybqjMf+L1KDxFtcU/XQQC
         K1KOMUz3HWXbh9WlVFU/6CtqCSBQejk8qKSvCfYFYr5m5kWFcCBG003wAsEPdqsUHp/O
         MJZib4q1IiS2I0xRR9farEAfSEdgCXqUhtgyJrO9YA4odki6zCTtxqf+uwXkiP2w4/kf
         a1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWisEbv8MFcGVnuECtms170x1X4BL+4mGf4hfHZu8IO8SoP+MBFnAWklIRJ4sIS41j8bI1/UkvawwSUmc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNi5O6J9v+OTx2zMkDKz0WrwLvwlwzS0HdlrV2ReCr2HGuO1V
	24e4TJOjmiRyKl7jt3XuyvbdiSM2ywhXKeytDPQd+jkbcUZIl5QfQ0/8
X-Gm-Gg: ASbGnctqHdDfloUS2hjIoyGfef1FOK8UcpPYK8DXiWPwokVP5GGsehScOhGgLIp8uJR
	NhT2uC3Nqb2Zv+2wPt2cOp28ZLELFdY1IiOZukBmr4gFKHscHDJYzqxpz/qfWyZ8isRLoyK6j6M
	4LykMl6Z4xr2v+Yo2OIr/P9ElW+a/OuPM3YyICJ3uZtG8HXGPUYCmDKjTTOM/XybxbRu0KVHGXL
	CXTYpgGwtgi3IgIjncgFmpJgYDjUW/G4/sSNKX8005H0Ez3C7XvD4zWVwbWCu+BYbNU/XpZpMoP
	PMEGVztYqm8+mJLciH8c3SwsjGBzwtELCJvqdwnRtUs0r6PEFvs+MZZfWABJ2LoYpfnPyPPfCcF
	bpFimTzc1Z6p+kjo0Sd3WJf7+njs4482iQCNPDmwkvMRa0quNTBmm5LXk30XIVmJHB9FRPUloVt
	WlK7sLjLo=
X-Google-Smtp-Source: AGHT+IFOtcW0FjrNxyzQVAwg8/hsWcVkY2/+FOGxCrw+aG6ME/j+PMfoUflj60UThewImLHLIJQRzg==
X-Received: by 2002:a17:903:3848:b0:294:def6:5961 with SMTP id d9443c01a7336-297e56d0868mr419605ad.45.1762539578179;
        Fri, 07 Nov 2025 10:19:38 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93e5dsm68382615ad.81.2025.11.07.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:19:37 -0800 (PST)
Message-ID: <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary
 search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, bot+bpf-ci@kernel.org, 
	ast@kernel.org, andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	alan.maguire@oracle.com, song@kernel.org,
 pengdonglin@xiaomi.com, 	andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, 	yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Date: Fri, 07 Nov 2025 10:19:33 -0800
In-Reply-To: <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
	 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
	 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 15:08 +0800, Donglin Peng wrote:
> On Thu, Nov 6, 2025 at 9:47=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >=20
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 66cb739a0..33c327d3c 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -552,6 +552,70 @@ u32 btf_nr_types(const struct btf *btf)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return total;
> > > =C2=A0}
> > >=20
> > > +/* Verifies that BTF types are sorted in ascending order
> > > according to their
> > > + * names, with named types appearing before anonymous types. If
> > > the ordering
> > > + * is correct, counts the number of named types and updates the
> > > BTF object's
> > > + * nr_sorted_types field.
> > > + *
> > > + * Return: true if types are properly sorted, false otherwise
> > > + */
> > > +static bool btf_check_sorted(struct btf *btf)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct btf_type *t;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int i, n, k =3D 0, nr_sorted_types;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (likely(btf->nr_sorted_types !=3D BTF_NE=
ED_SORT_CHECK))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 btf->nr_sorted_types =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^
> >=20
> > Can multiple threads race when writing to btf->nr_sorted_types
> > here?
> > Looking at btf_find_by_name_kind()->btf_check_sorted(), I see that
> > btf_find_by_name_kind() receives a const pointer but casts away the
> > const
> > to call btf_check_sorted(). The function bpf_find_btf_id() calls
> > btf_find_by_name_kind() without holding any locks (line 737), and
> > later
> > explicitly unlocks before calling it again (lines 756-757).
> >=20
> > This means multiple threads can concurrently enter
> > btf_check_sorted() and
> > write to btf->nr_sorted_types. While the validation logic is
> > idempotent
> > and all threads would compute the same value, the concurrent writes
> > to the
> > same memory location without synchronization could trigger KCSAN
> > warnings.
> >=20
> > Should this use atomic operations, or should the validation be
> > performed
> > under a lock during BTF initialization before the BTF becomes
> > visible to
> > multiple threads?
>=20
> Hi, is it necessary to address this issue?
> For example, by using atomic_try_cmpxchg or WRITE/READ_ONCE? Using
> atomic_try_cmpxchg can prevent race conditions on writes but requires
> an atomic
> variable, while WRITE_ONCE/READ_ONCE can avoid KCSAN warnings. Since
> the race condition is unlikely to cause critical issues, I suggest
> using
> WRITE_ONCE/READ_ONCE.

Probably use WRITE_ONCE/READ_ONCE?

> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (btf->nr_types < 2)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 nr_sorted_types =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 n =3D btf_nr_types(btf) - 1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D btf_start_id(btf); i < n; i++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 k =3D i + 1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (btf_compare_type_names(&i, &k, btf) > 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 t =3D btf_type_by_id(btf, i);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (t->name_off)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_sorted_types++;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 t =3D btf_type_by_id(btf, k);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (t->name_off)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nr_sorted_types++;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (nr_sorted_types)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 btf->nr_sorted_types =3D nr_sorted_types;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^
> >=20
> > The same race condition applies to this write of nr_sorted_types as
> > well.
> >=20
> > > +
> > > +out:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return btf->nr_sorted_types > 0;
> > > +}
> >=20
> > [ ... ]
> >=20
> > > @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const struct btf
> > > *btf, const char *name, u8 kind)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (btf->nr_sorted_types !=3D BTF_NEED_SORT=
_CHECK) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (btf_check_sorted((struct btf *)btf)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> >=20
> > The const cast here enables the concurrent writes discussed above.
> > Is
> > there a reason to mark the btf parameter as const if we're
> > modifying it?
>=20
> Hi team, is casting away const an acceptable approach for our
> codebase?

Casting away const is undefined behaviour, e.g. see paragraph 6.7.3.6
N1570 ISO/IEC 9899:201x Programming languages =E2=80=94 C.

Both of the problems above can be avoided if kernel will do sorted
check non-lazily. But Andrii and Alexei seem to like that property.

>=20
> >=20
> >=20
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's
> > not a bug.
> > See:
> > https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.m=
d
> >=20
> > CI run summary:
> > https://github.com/kernel-patches/bpf/actions/runs/19137195500

