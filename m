Return-Path: <linux-kernel+bounces-874354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6CEC161A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 556EC4ECDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BAC34BA42;
	Tue, 28 Oct 2025 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGuRx9Na"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615234A3DB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671934; cv=none; b=o4qx7n+V8wwHbLq16vThFxuYXO9T/Oem0emogiCosZTTjF0+ycWE02x0JipGbefEhy33EvnD0DuAFRv1fmVsXyeUUbuJtXwTZIczY5xlC/Y9RnQkbbtN6NLjCqJs4hidYLccycGdFBVwwcSWfVYrnP3APTf52e8+puidU0qcUfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671934; c=relaxed/simple;
	bh=UYwxvkY2zdm/DyH3ka2ma9lDVPuQqvHwI04Qpd7l7vg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GAggCLwYnzQz0yx5dnN9HfcaV67nI3qMRjVzK7yR+kh0/Lrc9IFmnNknXUZ2SGDS8PXQkZSRnUW3pfD7vBA1QSgBsP81OE4sKx83dF6TioEXwLAYfL1Bm5W8a/RsHvcigmD6hGnhfiXF1MvjDx0o4QS+wdvPTPAgdSNDSmZ9F6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGuRx9Na; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290c2b6a6c2so65831875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671929; x=1762276729; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D4n1AXwmY/rwCKDx/cQZwkmGhjBWLLIwBisORqaR6Wo=;
        b=bGuRx9NaTGJ62kAPYH+q5pqRoO0ej+L5PiwZYUnuW43y6S9i5KN7+nHFW6oZc2wOu4
         FZlibd73IiEPZfuvWpSTm/JaNqBHfFLzzIdATnRmA06gSLlNRFGzaqyOInGITFI5B6yB
         CE4f8ONvwmarcuUW7HGLq5pVFaTwAHkMOWN82IvZfegT0XYAuJI0wFXa5DGDQoKfQrtS
         bSCAvXWtgE55awhMVG+hrlQ14Grt8+X8510FipZNE9RuZhKXlJ0BU3R3RZHGNCa4N7Ka
         7CGvYSRl8/q/76q1JbyGooGlGkAdP0vuKPwG+yIsoMS5eNE6ib2ckN0PQ3nLBIgDUmc+
         TBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671929; x=1762276729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4n1AXwmY/rwCKDx/cQZwkmGhjBWLLIwBisORqaR6Wo=;
        b=UFAwLx8F5pO2xRy1xSVTZ6YE95xtsuC/JZDNso0z414ziGc8idTTeKDCL++5uAq5cN
         hwEVVW0lMaLXbNtxQTyLk7M0wMZoF+Sn8eub6hLPxx87Lzc4C9ilHtew1QGMjbx9B0RN
         bvrquT/OhtW28Ox0kIzpjjPw19/r1f4oIejoa3jsdjFJhsI2T6Z/tt8pFTZGrlR1ixgT
         cDx85Z2U3j6kLT/KP04R7QmbBYIIKiR9419H+ifnVVL84D2eIddSrtpQHbaAEM2rqfhT
         7NxIJcfmWD4mm6UOEVKhdCeJVJdoUwbu6tXPlV+9y7fIqZtC1ZT9KwqMzc4lNitNMoGh
         COIw==
X-Forwarded-Encrypted: i=1; AJvYcCWrM5TNh72d/aCHANtPDz50V60FhgQ7GcmpR2ylwqq5FMNcqYaQkgeB6J+lkZbVPnFgYDo4Pk7TjD1Zndg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBqd3YaJdYGr2lILqE2G4MbZ5G7jfdZuKJLg2qpWrPXSRp5IH
	ULCbZWqWwiOFah1SsplQtmMTG5mOMEw0iwTzhxhrNiqIotA+OamdQ1PG
X-Gm-Gg: ASbGncvYxGEhVYd31R+12MYapA/rkfKpBzNaaHuXgIsgyzclptgiDt1jjTYhiLnByN1
	rtSKTRsoBC6tIsO/p7coN94JWeGbKqmVU7rZwVXDA6dj+mL+EGd0uujlDOjfw0+KlXc5jyss0fM
	JY4QZyDtlmICAWPx8ZGVFzaonvf8pDOng86AVa0jKiVgA1DFmx9Wkxt3tJA86FWPCj8f7roATU8
	kQtUMOS+1snzkiJx21fE5qkZrskm3LMYwvFTry5YeUWIxmtdrO7t5gr5SeqeaGFmo3OJfvxetMS
	jD6Tn2QPONJ9wyK29wBw9+0DNswOPUYwRhK303GakXer9RTFpoaSJN5EcDR/8qaxzClq3Utcx5i
	4qEGmjZkRKXbHPm7CVRTe4ul5KKM7SwoJBszPPijnjkKSuQPTLu62/HoQIcQ0fmyZ44mjFYtqip
	yXD4N7Ve6x4bdqbkXEhVOL/Yk3kECOt5DW8qtf
X-Google-Smtp-Source: AGHT+IGzWUp6pB0RrxfOplxKt3YLhG+4AtzqD0EnJQYft/iHYC0j5K1snUzrTanQqB8W/931TN3xVA==
X-Received: by 2002:a17:903:1c2:b0:27e:ef09:4ab6 with SMTP id d9443c01a7336-294cac96c6fmr55866035ad.0.1761671928527;
        Tue, 28 Oct 2025 10:18:48 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3f28:abaa:8fee:bfa5? ([2620:10d:c090:500::7:f7b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0827fsm121791055ad.31.2025.10.28.10.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:18:48 -0700 (PDT)
Message-ID: <bf1de6a8291d2607b8c77674af899551607bdb79.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix tnum_overlap to check for zero
 mask intersection
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, kafai.wan@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	paul.chaignon@gmail.com, m.shachnai@gmail.com, 
	harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, 	shung-hsi.yu@suse.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org
Cc: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 10:18:45 -0700
In-Reply-To: <da8e2759ad57dd96dcc722cfd781141b045ee718df316cec8705e2908e0cb948@mail.kernel.org>
References: <20251028151938.3872003-2-kafai.wan@linux.dev>
	 <da8e2759ad57dd96dcc722cfd781141b045ee718df316cec8705e2908e0cb948@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 15:45 +0000, bot+bpf-ci@kernel.org wrote:
> ```
> commit 16cbc4520eb13d2065d145c76b97fb93035d81e8
> Author: KaFai Wan <kafai.wan@linux.dev>
>=20
> bpf: Fix tnum_overlap to check for zero mask intersection
>=20
> This patch adds an early return check in tnum_overlap() to detect
> non-overlapping tnums when their masks have no overlapping bits. The
> fix addresses a syzbot report where the verifier failed to recognize
> that two tnums couldn't represent the same value.
>=20
> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
>=20
> > diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> > index f8e70e9c3..1a75b7c9a 100644
> > --- a/kernel/bpf/tnum.c
> > +++ b/kernel/bpf/tnum.c
> > @@ -163,6 +163,8 @@ bool tnum_overlap(struct tnum a, struct tnum b)
> >  {
> >  	u64 mu;
> >=20
> > +	if (a.mask && b.mask && !(a.mask & b.mask))
> > +		return false;
>                               ^^^^^
>=20
> Does this logic correctly detect non-overlapping tnums? Consider this
> counter-example:
>=20
>   a =3D (value=3D0x5, mask=3D0xA)  // binary: value=3D0101, mask=3D1010
>   b =3D (value=3D0xA, mask=3D0x5)  // binary: value=3D1010, mask=3D0101
>=20
> The masks are disjoint: (0xA & 0x5) =3D=3D 0, so the new check returns
> false (no overlap).
>=20
> However, these tnums actually represent overlapping sets:
>   a represents: {5, 7, 13, 15}  // 0b0101, 0b0111, 0b1101, 0b1111
>   b represents: {10, 11, 14, 15} // 0b1010, 0b1011, 0b1110, 0b1111
>=20
> Both sets contain 15, so they do overlap. Can this cause incorrect
> verifier behavior when is_branch_taken() calls tnum_overlap() to
> determine if JEQ/JNE branches are reachable?

This is a legit bug, please address.

> >  	mu =3D ~a.mask & ~b.mask;
> >  	return (a.value & mu) =3D=3D (b.value & mu);
> >  }
>=20
>=20
> ```
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> In-Reply-To-Subject: `bpf: Fix tnum_overlap to check for zero mask inters=
ection`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/188801=
08453

