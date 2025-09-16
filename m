Return-Path: <linux-kernel+bounces-818633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E571B59462
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11867484A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5132C2359;
	Tue, 16 Sep 2025 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef/f0SZF"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893242C21CC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019902; cv=none; b=Fd4HDSpQ66ei5RXuu5qtfLftPcczIbtFqZpdSQv2JMZLy8DEpsxxege/E8a82xDMovwBkgnzQKMSTh6c70AUH5ChAKKDgHextJ7RO0MRX5LDIWlz062txU9FDAadQLj0APcqFzQNjCmx/qoOBhDHsyr4FbvtFiojN7QhVXihgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019902; c=relaxed/simple;
	bh=uetLMam59rqoueBhx9E0z0pGPZLJA28i0fsai71QFtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Znjxk3AZMEyZ1GQQ9PYch4JTRdSuugDzPC4Khl/oiTi8loxAcTAMUlcjkzt7wmgXfCe6i3pMUrn1COQbWjVs0FfKLWBhR05GtCX1ib6YufrTBi5vCRJFdtV8xyRXm64hIVmCc7L83bHtz9JGEC0/uuF3WhIrvA4PbnZmbIscId8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef/f0SZF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so2488556a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758019899; x=1758624699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OObpzBjFF7yMnSbls/d6bSlMk0bpjxblQhgbD3Wv4xQ=;
        b=Ef/f0SZFXGDj1+vMN+GNFzv3UccgxpJpHb+FYKkNN99C9oVCPyTP5K3mf1KdhamE9Y
         3yTW4Um49yZL5Bwcv6P3F8t3vq4bDxdnn7otbRdTF6K5zLCiO4AEfm+1CBC4qjPDhlAI
         ur8mFef6j3sQ1iZgmIk93FJRI5CKu78sge+/luPyIO3mpVqCmAUpAY9Ow2p5bNy/XQa2
         6iBGaGvJx5JlFbQUhJPV7VLkqTu9y8fro5x9TcnvCzhhdBR2QrXXGlbICv+8aBd+XxNK
         W02s1pmnC+0wXVJd224ZjqqTwG7smv79dNJoAT3tWFaBKO0OpLbLVE/nAn8X/vgn3BlI
         BH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019899; x=1758624699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OObpzBjFF7yMnSbls/d6bSlMk0bpjxblQhgbD3Wv4xQ=;
        b=EMBRWaTMRyRYyTY+HeZ9oS3v1MVdK9p3WzVF4APQc79EQmx1kamjbH6zUQTTaoJYzW
         oSqFLCE6SOTZzHYHIR0wj7AE3XQ2jCqBRHgkNpRo9IohbL2bY7If0EPtQX32u9hIPIDZ
         pzCysBiplHCeHhb/F6CpgROPi8tizrDnICUvtfH3LtX8IQCcLlkClbfVM0yaXrBS3Y9N
         IEH71oC+koBATwmGd5UbOU1xF8EYa6McLZ1GhlWFAyabMHIwbx2DNnByTzj2vw6A0zN6
         nt9HF1lRvWzGj+guDQi3TzbxMk4jjOZHWEy+gAQTfy+P6EkPKy0GJDC1CU4m7YM8UbBb
         9VSw==
X-Forwarded-Encrypted: i=1; AJvYcCWPIr2r6BERwKhlxSG/68QmhHTNxcqVbQ8gjcTXiyj6Xhgp0HX5ZNs9FdLblhKF4L30Phqyy4ZL0wJx7rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyEFBWvQDK5kXyqc7VZxjm/wbdS6DNRlhhiH1TY3stpWKxY32
	hAZq0sPE1TKuhJj0EILhaZuprX070DLQGxXkR+SR4nbRSe0MJh+8V/usa9JpfjSdZvQhWVOkpcB
	Kol/be/DmOvv7AtuMK+YrGbkB2mz7IEg=
X-Gm-Gg: ASbGncvxjiY7S+u/rQNxPOTjsB4uGrfkRzGfSnsrP7HW8PS6GSeGlZcbDmiV3PAJ8bH
	6RTYwf8wjjiYlJ5vbET/suwY36B/vzgIkGpmTw1rgIhix8xasQfAEwzpfOqeRVGTOIvgfKX2KyI
	hHC67ZTS8h/IQ66dsUsSfHgpIftJzOHO8PHvPgVcSaZUfrb8z4D6NXTQxO2NURiOtLF/CVc/C8m
	VN2rC8KrKkr89SuXA==
X-Google-Smtp-Source: AGHT+IH6HVcq8RFIaQkQFA17EoE6YWoCKD+1h9ynJNaDikwRoq31OLQVBiURDJCjf116z9WR/3PQypnzBaYuEhoS4l0=
X-Received: by 2002:a05:6402:2802:b0:627:6281:e441 with SMTP id
 4fb4d7f45d1cf-62ed8278bfemr15882478a12.23.1758019898611; Tue, 16 Sep 2025
 03:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756987761.git.zhoubinbin@loongson.cn> <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
 <CAMpQs4JbQU3D-Bs2687BXSC=FKJBS6RMvWAKb6AJEtzit6hWqw@mail.gmail.com>
 <20250916084002.GF1637058@google.com> <CAMpQs4+J2zYgZaGYBSaf4UwzKZY-qMoD1oe2vmgJQXAfghqu=w@mail.gmail.com>
 <20250916101438.GA3585920@google.com>
In-Reply-To: <20250916101438.GA3585920@google.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 16 Sep 2025 18:51:25 +0800
X-Gm-Features: AS18NWDo7mI5EB9dmqCohctCrqyLMUFRWlwlIpYcOxURUZMTdq3nypJv3YzNjgE
Message-ID: <CAMpQs4+kj0i1BpJ4Nk+Z=Ov-AMEWcqPmkbruNhD--TmycX4z-Q@mail.gmail.com>
Subject: Re: (subset) [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC support
To: Lee Jones <lee@kernel.org>
Cc: Corey Minyard <minyard@acm.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	jeffbai@aosc.io, kexybiscuit@aosc.io, wangyao@lemote.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:14=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 16 Sep 2025, Binbin Zhou wrote:
>
> > Hi Lee:
> >
> > Thanks for your reply.
> >
> > On Tue, Sep 16, 2025 at 4:40=E2=80=AFPM Lee Jones <lee@kernel.org> wrot=
e:
> > >
> > > On Fri, 12 Sep 2025, Binbin Zhou wrote:
> > >
> > > > Hi Lee:
> > > >
> > > > On Thu, Sep 11, 2025 at 10:33=E2=80=AFPM Lee Jones <lee@kernel.org>=
 wrote:
> > > > >
> > > > > On Thu, 04 Sep 2025 20:35:04 +0800, Binbin Zhou wrote:
> > > > > > This patchset introduces the Loongson-2K BMC.
> > > > > >
> > > > > > It is a PCIe device present on servers similar to the Loongson-=
3 CPUs.
> > > > > > And it is a multifunctional device (MFD), such as display as a =
sub-function
> > > > > > of it.
> > > > > >
> > > > > > For IPMI, according to the existing design, we use software sim=
ulation to
> > > > > > implement the KCS interface registers: Stauts/Command/Data_Out/=
Data_In.
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Applied, thanks!
> > > > >
> > > > > [1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
> > > > >       commit: 67c2639e1fc1a07b45d216af659c0dd92a370c68
> > > > > [2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
> > > > >       commit: 2364ccc827e44064e9763f2ae2d1dcc5f945fdf3
> > > >
> > > > Thanks for acknowledging my patchset.
> > > >
> > > > I can't confirm why you didn't apply the IPMI patch, but this appea=
rs
> > > > to break the patchset's integrity, potentially causing missing Kcon=
fig
> > > > dependencies (IPMI_LS2K select MFD_LS2K_BMC_CORE).
> > >
> > > Pretty sure this doesn't break anything.
> > >
> > > What build errors do you see as a result?
> > >
> > > > Additionally, as Corey previously explained[1], this patch can be
> > > > applied through your side.
> > > >
> > > > [1]: https://lore.kernel.org/all/aFVtNAY4u2gDiLDS@mail.minyard.net/
> > >
> > > We only apply cross-subsystem patch-sets to a single tree if there ar=
e
> > > good reasons to do so.  In this instance, I can't see any reason why =
the
> > > IPMI driver cannot go in via it's own repo.
> >
> > However, there still seems to be a text dependency issue. The IPMI
> > patch modifies the MAINTAINERS, which depends on the first patch.
> > If the entire series of patches cannot be merged together, does this
> > mean the IPMI patch can only be merged after the MFD patch has been
> > merged into the mainline?
>
> No, not at all.  So long as all patches come together during the
> merge-window, there is no issue.

OK, I see, thanks.

Hi Corey:

What do you think about it?

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

--=20
Thanks.
Binbin

