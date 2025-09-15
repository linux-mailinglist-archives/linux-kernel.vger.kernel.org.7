Return-Path: <linux-kernel+bounces-817904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3984AB5885A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC542A24D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C52DA77F;
	Mon, 15 Sep 2025 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOIrvey/"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592D1A267
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979621; cv=none; b=hoYtD/DoJ1W0I7yDSANMXduvmmpSh/pyq3f+tkCtKLYC4Xy+ARshvKvvJe9SDeXXT/EPY1JyMtJs1iRzMGlOvm8A7t6MUIOMtNM4S7uR0ePAXMFIkBEN5/nE6O8LoEZnbpXryZEkFoG8/8o6harjC5NMlnkaFEJGQhzlzqvAnGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979621; c=relaxed/simple;
	bh=0OcssUkImO3SE1HHfnrP/IX7TMqj8GUkVeISdnI1urQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcOOpdPFEiwWMfoxJdNC+eK80cEpOSLloiSRJe43rWQzY3uuGjg7ChWSllL0Wo3T/Bvw8NWHodJQvq3duXsXRcZUGJac0mhdW6FmuAZwTU8f4eSX05413NDO1PJ1hkhQA6yTimqJJGlTckqiomlpbmlBd0tKV79tFI/I0wVqFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOIrvey/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77786498b5fso1468172b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757979620; x=1758584420; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJSMheGsHe6BVL8P/ZodqLFYVtMcU4bhndx0+FT0+d8=;
        b=BOIrvey/fc+9CwbpEfkrfrES5ocb04nWAA0Y61HQpekWVvMEwYtQ6m87MLQoekED7f
         i2jvVHNAf99DOS2pB+v+Pi+2g5UhvZ+hjOCFNrL3l8w75CPZ5KrkmgxWrXNotQnEvqQn
         G7xbKZAhBbS0/eYO4kfGcj41rQF2NFlVSYKeezcV7z8IVi650+vkq4YKoXJx7RbBGnnW
         qljtulD0pwex7Qm2usGIlyUVsty6WYovdBUwpNeLLRlNKZj87NFKo2dM4kgno5zAO4HQ
         6mSXYDoZmMV2oYlSB6Wpd6YffK/DCpvLoOqFcnSsuSzocw1Nld6BirQ6Qn3uukENSjwD
         O41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757979620; x=1758584420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJSMheGsHe6BVL8P/ZodqLFYVtMcU4bhndx0+FT0+d8=;
        b=LmkvVdSU/Him9uNsZPP7nx7irnBVGmsFh9VO7nlGs22WJ646gHZGeN8a3gD6rRP5Mb
         TQs5yjlxaCU9mZ/VCZPqqCwczzG1q2Job2/iwrL3U2Vow2rgKAsQocA88LBZTZkns4t7
         i81gEQ7+kCiI9B0cat5meZqQuCZr/RUqmOt92UtI78IJgmQM+lQJbmueH1+rr0WFYifl
         F2QG7iB3gu12TaGjrAluAl0IoNutegED14dq5LTS5Hpz4GCBe26NG8Rpltr3dvxHFR6h
         sdOyZ7A96XtJfhvgslDGpPAaTSk60WeLOb0PJ167Dr15k0O6u4sxH9K+e6X3hl6XEX39
         lWRw==
X-Forwarded-Encrypted: i=1; AJvYcCU/LKie1HjeLU9rsnwCTc+SdeYNMaQqUN5ef4MwEN6+MDEK2MtG4ziZe38Da7yzrFmoPY5PnldcV6LAwYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tc5kqTtoEgCBOgAhFmoIO4XY70BNNSiMVuKg0OngUl3w+1AC
	lwdBUc4xrwt0/yX9DCNvCl8q3V0RgNWfASwHItmYLedS7KvAmdjbM3J1
X-Gm-Gg: ASbGncuTkjQMkk4hcBw8dfKEZLoxaGgYl6z2CF2gtvinDRkGyrzyyS4PPTNNlRQxiCH
	17GfkclspkvX+eS9wIgZIwc4rR0Z7GtRPBKy5HXviZwGdHcPrXYszcdjUPoECPhYf331S8Q0d37
	ke89v6w8rC81q4QSVdDezZcQRhRpiiqsXUkQ4JQ0OThMUjgA51EU4s7YJE3oQKugi4NhfnnBB5+
	g5PJH12OqLSimJ0jMUS+aTxJr2QJMocEbuFw94+2r1t1nG5/arl7IMp1S9mx9ZIhs5RHmt22cum
	hzX7i5GCCNyLj3n0glCiTm0r3OVW515fiLzxqYaV3zzfmj2yZ+yOwU1JTuB2L/uvbIDrLaNUckG
	9hTFadngdsikR1z3HZdxMPWGrpibsrsKxrVdAcngzIa+Oqc0k
X-Google-Smtp-Source: AGHT+IGnt46crtLT5a+xjBfk4DXNhqvw6MM+OfwjuMK5SV74rlSJI5wYJ4cGD9gfrEGJ6UmbOVxeXg==
X-Received: by 2002:a05:6a00:3c92:b0:775:fab1:18c8 with SMTP id d2e1a72fcca58-77612060f6emr14543524b3a.3.1757979619680;
        Mon, 15 Sep 2025 16:40:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1da5:13e3:3878:69c5? ([2620:10d:c090:500::4:283f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-777d3ca57e2sm5193931b3a.33.2025.09.15.16.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:40:19 -0700 (PDT)
Message-ID: <b1717a5b75475b8e14afaee4825a40a3808bd0cb.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in maybe_exit_scc
From: Eduard Zingerman <eddyz87@gmail.com>
To: syzbot <syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Mon, 15 Sep 2025 16:40:17 -0700
In-Reply-To: <81bb1cf72e9c5f56c92ab43636a0626a1046d748.camel@gmail.com>
References: <68c85acd.050a0220.2ff435.03a4.GAE@google.com>
	 <81bb1cf72e9c5f56c92ab43636a0626a1046d748.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 15:34 -0700, Eduard Zingerman wrote:

[...]

> > verifier bug: scc exit: no visit info for call chain (1)(1)
> > WARNING: CPU: 1 PID: 6013 at kernel/bpf/verifier.c:1949 maybe_exit_scc+=
0x768/0x8d0 kernel/bpf/verifier.c:1949
>
> Both this and [1] are reported for very similar programs:
>
> <this>                                      <[1]>
> -------------------------------------------------------------------------=
-------------------
> (b7) r0 =3D -1023213567                       (b7) r0 =3D -1023213567
> (bf) r3 =3D r10				    (bf) r3 =3D r10
> (07) r3 +=3D -512				    (07) r3 +=3D -504
> (72) *(u8 *)(r10 -16) =3D -8		    (72) *(u8 *)(r10 -16) =3D -8
> (71) r4 =3D *(u8 *)(r10 -16)		    (71) r4 =3D *(u8 *)(r10 -16)
> (65) if r4 s> 0xff000000 goto pc+2	    (65) if r4 s> 0xff000000 goto pc+2
> (2d) if r0 > r4 goto pc+5		    (2d) if r0 > r4 goto pc+5
> (20) r0 =3D *(u32 *)skb[60673]		    (20) r0 =3D *(u32 *)skb[60673]
> (7b) *(u64 *)(r3 +0) =3D r0		    (7b) *(u64 *)(r3 +0) =3D r0
> (1d) if r4 =3D=3D r4 goto pc+0		    (1d) if r4 =3D=3D r4 goto pc+0
> (7a) *(u64 *)(r10 -512) =3D -256		    (7a) *(u64 *)(r10 -512) =3D -256
> (db) lock *(u64 *)(r3 +0) |=3D r0		    (db) r0 =3D atomic64_fetch_and((u6=
4 *)(r3 +0), r0)
> (b5) if r0 <=3D 0x0 goto pc-2		    (b5) if r0 <=3D 0x0 goto pc-2
> (95) exit				    (95) exit
>
> So, I assume it's the same issue. Looking into it.
>
> [1] https://lore.kernel.org/bpf/68c85b0d.050a0220.2ff435.03a5.GAE@google.=
com/T/#u

Minimal reproducer:

  SEC("socket")
  __caps_unpriv(CAP_BPF)
  __naked void syzbot_bug(void)
  {
        asm volatile (
        "r0 =3D 100;"
  "1:"
        "*(u64 *)(r10 - 512) =3D r0;"
        "if r0 <=3D 0x0 goto 1b;"
        "exit;"
        ::: __clobber_all);
  }

And corresponding verifier log:

  Live regs before insn:
        0: .......... (b7) r0 =3D 100
    1   1: 0......... (7b) *(u64 *)(r10 -512) =3D r0
    1   2: 0......... (b5) if r0 <=3D 0x0 goto pc-2
        3: 0......... (95) exit
  Global function syzbot_bug() doesn't return scalar. Only those are suppor=
ted.
  0: R1=3Dctx() R10=3Dfp0
  ; asm volatile ( @ verifier_and.c:118
  0: (b7) r0 =3D 100                      ; R0_w=3D100
  1: (7b) *(u64 *)(r10 -512) =3D r0       ; R0_w=3D100 R10=3Dfp0 fp-512_w=
=3D100
  2: (b5) if r0 <=3D 0x0 goto pc-2
  mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=3Dr0 stack=3D before 1: (7b) *(u64 *)(r10 -512=
) =3D r0
  mark_precise: frame0: regs=3Dr0 stack=3D before 0: (b7) r0 =3D 100
  2: R0_w=3D100
  3: (95) exit

  from 2 to 1 (speculative execution): R0_w=3Dscalar() R1=3Dctx() R10=3Dfp0=
 fp-512_w=3D100
  1: R0_w=3Dscalar() R1=3Dctx() R10=3Dfp0 fp-512_w=3D100
  1: (7b) *(u64 *)(r10 -512) =3D r0
  verifier bug: scc exit: no visit info for call chain (1)
  processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0

[...]

