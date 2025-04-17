Return-Path: <linux-kernel+bounces-609073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB3A91CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 14:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9491F4457F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201A378F5E;
	Thu, 17 Apr 2025 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CjuLnHAw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC728E37
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894318; cv=none; b=peecuGi8cicwt6WDMalWhYbzRvSN6RZHcnsyhahQXy7pkaXEURulBQZ1bueTCRHB6nw0XYQvfX7joNkUCqdP/b208asNiUN1j/yYgbM69390VwOQREB2yP5/B8hD3+M2JZyJ42jEEZoBMRwLHQeGRPRxZTQ91g/jNy0cx2/xL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894318; c=relaxed/simple;
	bh=zYiKuijpdMMZlMRVFlrMgMVcAf/1clBIvp6L5K7ttbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4QWlZZF/g2fDvuJMU9KqTzmIf9VM9oSHN1Abd8BT62eGolIvE/DBZ3aH2Cawq8XeJ/Z3tfH1M56nUA1ktnh5XZWtlWOxK75HwWlcZisjMRESET7e36dya2eijeAPr3Vf5GUanju8fD2Px/jKBOtWEdzRJIv6pX6EYhBHNHfKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CjuLnHAw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso7165845e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744894315; x=1745499115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=128aOD0HeldmNUa28jrs19qlYjVCdjVZq6egvszSPpE=;
        b=CjuLnHAwEPDKIgIQKc1eTxv4x1nmBA3MhJF+bhSg6wppeCmXd3L7z6gG6VyKOOkD/I
         eaDNFaDqg3FQq4LVj68F6CD2pMUKZR4q8R2jS3JtVSs79J09qvF3vops7i89ViEhBtoo
         NKZd+s+Ae+Y3RfI/rgUOHuz2CxuPP4Nsp2UX/AzyJ0L0Sdcw9AcNJZSbLtj0v5XJ5v8k
         hZOf/6xxEK896fY18/nlOUNuzMJl/QVPiWcXHOdmh391d6KwD6QU+X7/Jhj7KGqVqeX3
         WDSVnJrE9vBtb/QSsBtT5bdXmnOvgcCIzrzShJzfkkpxJzSw+wGj2VBGCKNVU4sPT6T5
         UHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744894315; x=1745499115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=128aOD0HeldmNUa28jrs19qlYjVCdjVZq6egvszSPpE=;
        b=EQ4Bpzp7ZE3pmuFy8gvKfJRw30lKbUu7K5fZvoWStP8vam88mVjAEuPpEBvq4j/a+z
         LQLEBEsXbuszyWNVEyf/cRLvLlh68W79UJI2eA88uTpo8qPLSDyMCaVykR2AH3sHQwnf
         pYj6xhJzeVv1QA1nYB767TNcLGSZthhCb4QrvQeJHAjjReDtBun2CQbQ5CKuuEH9fLz5
         OrCCPCLcGRReo5kBw/HcvT15zgl0F9g+aWu43Uosx0Wg/e974a5tk9sfRDBJKUYc+Xa1
         WOcqG1zQLfD2FxvE80G1AStCxKHrvk3shNDWxoYhkQcBW088bdvYPA4bnDUFlveBOTwO
         pxIA==
X-Forwarded-Encrypted: i=1; AJvYcCVvziSItOfRfHPLjFGA2MRVSVO1UhMSIsGfoUejHzOBoafwg4sEHJ5DBOBwzF4bRLDhIPhEPR6K3lBAB+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3RU7rmk0a6K3ZED7vE3X5RdqTt/HOmDRYQ1XOHqSKdsTtyP/
	KJvdx0QYhRwXjTBGHi3Vc+5de2oDIcTOWdaGgmuTzu+2STAn5hqcfGR9RFBy663nx0on8HxHc4N
	Q7EyIEwMDKanYbnTaDmCygwWekVcSuxh8E8cLyQ==
X-Gm-Gg: ASbGncsSKYea9ARYnHj9kznWLEd4pTvCe4JnW+0kgnhaTn1bbA5imJydFQgJhO6tbnC
	EyKQpO90oh2oaf5kCfOoG2gBb8Ur21kLNdifXQOWhGS0BXOhuVZvoF3a+mvv66ZZ3tEc12ODHTl
	tUN9/M3phMp0CKEk4g84l1ro1whqPUGpE=
X-Google-Smtp-Source: AGHT+IGSfaYlPsKYCZjwpMpDTw1oGQ6TfqqaE5dxySzTi8eYWLO/4VGzwdMbe3MJeePxuU0AjwYwUoAHiqHdzyVxgjQ=
X-Received: by 2002:a05:6000:1a88:b0:39e:dd1e:f325 with SMTP id
 ffacd0b85a97d-39ee5b3623cmr4465854f8f.31.1744894314691; Thu, 17 Apr 2025
 05:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116230955.867152-1-rkanwal@rivosinc.com> <20250116230955.867152-2-rkanwal@rivosinc.com>
 <CAP-5=fU9ovvb-JopPqQfNaj6xtL=u_WZO-b56RdhBmUw4mY0ZA@mail.gmail.com>
In-Reply-To: <CAP-5=fU9ovvb-JopPqQfNaj6xtL=u_WZO-b56RdhBmUw4mY0ZA@mail.gmail.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Thu, 17 Apr 2025 13:51:43 +0100
X-Gm-Features: ATxdqUGKyFbJpoByA6kTqSXnrGrcoiAJmkG-BaTaT2Bx7fpRX9c9j87i6CMLo9g
Message-ID: <CAECbVCvX8St8sXh9pTnyO_94-cJT_DB4MyggtS_-PXqWNtXDXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] perf: Increase the maximum number of samples to 256.
To: Ian Rogers <irogers@google.com>, ak@linux.intel.com
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	ajones@ventanamicro.com, anup@brainfault.org, acme@kernel.org, 
	atishp@rivosinc.com, beeman@rivosinc.com, brauner@kernel.org, 
	conor@kernel.org, heiko@sntech.de, mingo@redhat.com, james.clark@arm.com, 
	renyu.zj@linux.alibaba.com, jolsa@kernel.org, jisheng.teoh@starfivetech.com, 
	palmer@dabbelt.com, will@kernel.org, kaiwenxue1@gmail.com, 
	vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Adding Andi Kleen.

On Thu, Feb 20, 2025 at 6:51=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Jan 16, 2025 at 3:10=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.=
com> wrote:
> >
> > RISCV CTR extension support a maximum depth of 256 last branch records.
> > The 127 entries limit results in corrupting CTR entries for RISC-V if
> > configured to be 256 entries. This will not impact any other architectu=
res
> > as it is just increasing maximum limit of possible entries.
>
> I wonder if rather than a constant this code should just use the auto
> resizing hashmap code?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/util/hashmap.h
>
> I assume the value of 127 comes from perf_event.h's PERF_MAX_STACK_DEPTH:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/perf_event.h#n1252
>
> Perhaps these constants shouldn't exist. The perf-record man page mention=
s:
> sysctl.kernel.perf_event_max_stack
> which I believe gets a value from
> /proc/sys/kernel/perf_event_max_stack, so maybe these should be
> runtime determined constants rather than compile time.
>

Thanks Ian for your feedback. I am not sure if it's feasible to use auto
resizing hashmap here. On each sample of 256 entries we will be doing
6 callocs and transferring a whole lot of entries in hashmap_grow. We
can't reuse old hashmap as well. On each sample we bear the same cost

But I do agree this should be more dynamic but the maximum number
of entries remove_loops can process is limited by the type of chash array
here. I can change it and related logic to use uint16_t or higher but we
will still have a cap on the number of entries.

PERF_MAX_BRANCH_DEPTH seems to be denoting what remove_loops
can process. This is being used by thread__resolve_callchain_sample to
check if the sample is processable before calling remove_loops. I think
this can't be changed to use perf_event_max_stack. But I can rename
this macro to avoid confusion.

I didn't notice PERF_MAX_STACK_DEPTH. This seems to be defined in
multiple places and touches bpf as well. I agree that we should avoid
using this macro and use runtime determined value instead. Tbh I don't
have super in-depth perf understanding. I will give this a try and send a
patch in the next update. It would be helpful if you can review it.

Thanks
-Rajnesh

> Thanks,
> Ian
>
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > ---
> >  tools/perf/util/machine.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 27d5345d2b30..f2eb3c20274e 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2174,25 +2174,32 @@ static void save_iterations(struct iterations *=
iter,
> >                 iter->cycles +=3D be[i].flags.cycles;
> >  }
> >
> > -#define CHASHSZ 127
> > -#define CHASHBITS 7
> > -#define NO_ENTRY 0xff
> > +#define CHASHBITS 8
> > +#define NO_ENTRY 0xffU
> >
> > -#define PERF_MAX_BRANCH_DEPTH 127
> > +#define PERF_MAX_BRANCH_DEPTH 256
> >
> >  /* Remove loops. */
> > +/* Note: Last entry (i=3D=3Dff) will never be checked against NO_ENTRY
> > + * so it's safe to have an unsigned char array to process 256 entries
> > + * without causing clash between last entry and NO_ENTRY value.
> > + */
> >  static int remove_loops(struct branch_entry *l, int nr,
> >                         struct iterations *iter)
> >  {
> >         int i, j, off;
> > -       unsigned char chash[CHASHSZ];
> > +       unsigned char chash[PERF_MAX_BRANCH_DEPTH];
> >
> >         memset(chash, NO_ENTRY, sizeof(chash));
> >
> > -       BUG_ON(PERF_MAX_BRANCH_DEPTH > 255);
> > +       BUG_ON(PERF_MAX_BRANCH_DEPTH > 256);
> >
> >         for (i =3D 0; i < nr; i++) {
> > -               int h =3D hash_64(l[i].from, CHASHBITS) % CHASHSZ;
> > +               /* Remainder division by PERF_MAX_BRANCH_DEPTH is not
> > +                * needed as hash_64 will anyway limit the hash
> > +                * to CHASHBITS
> > +                */
> > +               int h =3D hash_64(l[i].from, CHASHBITS);
> >
> >                 /* no collision handling for now */
> >                 if (chash[h] =3D=3D NO_ENTRY) {
> > --
> > 2.34.1
> >

