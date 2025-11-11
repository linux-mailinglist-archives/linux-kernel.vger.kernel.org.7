Return-Path: <linux-kernel+bounces-894497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919FC4B2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4598E3AF4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08888343D66;
	Tue, 11 Nov 2025 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxgXzIuy"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E921FF30
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826870; cv=none; b=cE+JyFhtzRgUTKUId0qpY1fNv9uZ66d8XE3POfh057FllZWrB/NRkCqIV2vVKq/dfRgVt5IYBuqfqpN9QgoaUIOrrn47OSiSJuiqcdDZS3xsGvab2mmtUswnJTERqzoce46Xt+xLcNZU6sDIf7CAc6gBGlVoNpkq4CX+2T/B8VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826870; c=relaxed/simple;
	bh=T460uL9FiOLYoivH40F2G/WPk7NwyWw3CNdv0gT0zbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0p10yoBQ39CIPcKaepWHfCuIUMakItsnQcQGeipDDhF3ZZm8wFUtQDqW1Z954Tz9rD4lDPqLBAAsyOrFArxrsYHZ6z+l1TUTBr1kwF+ENtUM6GQK+3dBExi+2TtmyfGgEZvWlzvOON9k38aaOQyCFP8tO1QjfkZbyFVLylBK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxgXzIuy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so693179666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762826867; x=1763431667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvXEtas7awGSG20JiUM7wOBwde2r+GQBbDrxF85hmLI=;
        b=VxgXzIuy0Am0PPJHRX41/HvtJeW7mBXXIfrTFDE1oH9fsysv44Kd+22n2197bAC6Op
         7MJ1G4QHVjZ3GqTBRtmrWdfREDAiO953Qhrmyl/nd6N7g4qgwjkMN+msW6l0OxIp9O0S
         fgEzEkIbuL25pMDbNw0F1D2Eg2cZP7HeyTVEjaKJ2T0YXgAqRFCEMCth5d4tiCGwN2Aa
         U4HmHd40oO1Xtnzb26caCBlEScJpjzcFxYzfiIQqH77ACKYWC44xoixA6NMQ4ijXS94v
         7zRXOTXHgyS6JLPP3NxNgLjvkTtoKd6ZVzSjhcr6U2K/3U+evh4ttEw2dTnyTDcmEUB3
         wJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762826867; x=1763431667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UvXEtas7awGSG20JiUM7wOBwde2r+GQBbDrxF85hmLI=;
        b=buwVbLLrB18PVUQnI2y+KIWaA6mSkod3cLNF2bI4TQbjql05OZc9Y0PpYK/uZ8YEOl
         r8Veequ/Oz8VaMzg18FrK6nR0VYPuXafdiZ0M6eYnnVd2bSH8SR6aNorkTcVtRxAvwAs
         m0m/LtpPCgtyWVNCluPqhR/ynVxnNFia1fgk+wv12rzDR3ULdUljT81n4W2fCk+zpUNT
         B5Mr8+Uy+w1SK7JjDahGeU1iyqVKaAc/s8bmQh+l9eIWmKuNhPy9hZ3on7d/p8wAh3qr
         Py3/HZVJlSX299A4PjokcwolRSVK9z4YUbRv/IqGshQ0F7ix6237TLwlyosZm2JMNdgg
         AEGA==
X-Forwarded-Encrypted: i=1; AJvYcCVOqdk6VrY/6hxmUFjheprJuFrQgKANIwMNlZ5M5jo8uUCOHV06OkB4ssKgeT+a16y/gN58taJrGJ1HiZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWwMCmARaCugCb3yOUAXRJplnDqddqt6WXx2anZdb8c9yTz4p
	gSmEG+fxlCc9jh3CTuAioLqTj9Uts9km+NPOgcsyjXbYw4eRaJSgrcfn5YFPdPEBkKA6O5QEDpN
	rAvEMtqfnNeh/H79kApYJL0PAhmHqJyA=
X-Gm-Gg: ASbGnctdTey4fvtuKg0dVJZ8MJU1XQeP5rRykv9M8750cCHGBnfxTtYIC/S8ywDrAZm
	20LUlxG7KAjKJtscykf/qmV5n6Bqs17Dkisr20VxM/uwqWW28LZneeAgzxrAbVSfdWYzwQwaoLA
	DHjGpE+3re5+pKLjGxJ9RSjzNkItAqIIypOF4T7KK92vorGzmaX0PUGc4cASq9Ul8nFXMoZCY6Z
	EmFsIi3O1h9vNk2/S9D+DBlpzgwY8Wjr6M++J3nwA54XZ3ZqfFaoRJ7QANJkW490/PzBIcP
X-Google-Smtp-Source: AGHT+IFuLZi1fgS0EEtiHw5TT0FBLfHLMo9uIcW5Vnf6D1qmNTB1jUjVtcsDiBNTYYr2WHBLKWaaNTLBG/+n9MTWAQw=
X-Received: by 2002:a17:907:5c9:b0:b4a:d0cf:873f with SMTP id
 a640c23a62f3a-b72e036c31emr1095265066b.2.1762826866999; Mon, 10 Nov 2025
 18:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
 <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
 <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com>
 <5a8c765f8e2b4473d9833d468ea43ad8ea7e57b6.camel@gmail.com>
 <CAADnVQKbgno=yGjshJpo+fwRDMTfXXVPWq0eh7avBj154dCq_g@mail.gmail.com>
 <6cbeb051a6bebb75032bc724ad10efed5b65cbf7.camel@gmail.com>
 <CAErzpmtViehGv3uLMFwv5bnRJi4HJu=wE6an6S0Gv2up3vncgA@mail.gmail.com> <854a2c2ceaa52f1ad26fb803d1ad5668fd3200b3.camel@gmail.com>
In-Reply-To: <854a2c2ceaa52f1ad26fb803d1ad5668fd3200b3.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 11 Nov 2025 10:07:35 +0800
X-Gm-Features: AWmQ_bnAM2kObujKR5ov0jYGM4otiJtvPUgJ9CCt6W7Ix9UXpf3LPSTc2FVCuE0
Message-ID: <CAErzpmvgzLwxFDRPQqXjkj_a2b6X4kA1DMhP1Tew_AY0Q_JUcg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary search
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, zhangxiaoqin@xiaomi.com, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:44=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-11-10 at 09:42 +0800, Donglin Peng wrote:
>
> [...]
>
> > [[Resending in plain text format - previous HTML email was rejected]
> >
> > Thanks for the feedback. Based on the previous discussions, I plan
> > to implement the following changes in the next version:
> >
> > 1. Modify the btf__permute interface to adopt the ID map approach, as
> >     suggested by Andrii.
> >
> > 2. Remove the lazy sort check and move the verification to the BTF
> >     parsing phase. This addresses two concerns: potential race conditio=
ns
> >     with write operations and const-cast issues. The overhead is neglig=
ible
> >      (approximately 1.4ms for vmlinux BTF).
> >
> > 3. Invoke the btf__permute interface to implement BTF sorting in resolv=
e_btfids.
> >
> > I welcome any further suggestions.
>
> Hi Donglin,
>
> I think this summarizes the discussion pretty well.
> One thing to notice about (2): if sorting is done by resolve_btfids,
> there is no need to check for BTF being sorted in vmlinux BTF.
> So, maybe it's a good idea to skip this check for it, as Alexei suggested
> (but not for programs BTF).

Thanks. I noticed that we still need an additional iteration in
btf_parse_base() and
btf_parse_module() to compute nr_sorted_types for lookup performance
optimization.

Thanks,
Donglin
>
> Thanks,
> Eduard.

