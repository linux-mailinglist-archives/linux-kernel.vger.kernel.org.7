Return-Path: <linux-kernel+bounces-851716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A508BD71FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 390AF4E0FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D93064A3;
	Tue, 14 Oct 2025 02:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpuayaEr"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10F1A3165
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410119; cv=none; b=fyIzHSAB1te06sP2YXRM/4Jao0h/ixiUeW2WESiG6f8ZUeIEGoHIj1Sq2OyB4CMAXSf4P42OQuz4rCpJ7Jgcl5ppwYCJlS/PLF7U+SVAs/yj8UD2AjTKC+36v6NfltKlerIO+WgNCpxycsPBlwJF/9jpx0N8i62oFHC+roWaD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410119; c=relaxed/simple;
	bh=dGj4XItH+WnBUIlZ4F3FWzZdBgz+gnjQrlvvsej3eFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3chX3XwtdltE4YNpvculpbCqTDqQESZJeSvRJFnAigmA6Dyd0BpURukEeewxcAm8eBvCcCpUvWaEZBfxgdZSEjb69yuWt+yjSSK6bnMa9vnh0xggQG5Xdg2tKveyD20ytzhCoM86B7dj7oxNT5B7ydJUyS5Tx1t0W94zKnPkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpuayaEr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso48863315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760410116; x=1761014916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGj4XItH+WnBUIlZ4F3FWzZdBgz+gnjQrlvvsej3eFs=;
        b=fpuayaErAZ5ooC2s/IQzA0WYiTjjxFHI6F0Of++54xAdODFhT2PqP4t6CcMIONOIdB
         hlZKD+n8m+i8hvONsQr8epghJtzwCxgrc51rSm6DrtN4zQ60ofhEc0RAiZrUXf/UJHQ7
         R0iNgiM4ApL3WVKmUqth+Mx6ZbLsVkUO9ymHTC/FVt/7OYmjt9n5g/LAi+iqVmMoC1VX
         rJgvNUkjCKrNvT3ch6xVfswqsBL4dLKIRsfuW9rCg0104y6lqdIajckBNy4pWw63jy5y
         DAJgoXbYNPJHvRls1CN42TFnPltBzXwonLP6FP78nINbcHzNnijgH/SunX6O9cGUE+Md
         4WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760410116; x=1761014916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGj4XItH+WnBUIlZ4F3FWzZdBgz+gnjQrlvvsej3eFs=;
        b=HBQ8y0F9mO8XBVaIq2U9GLkYbAQ43Di3ixWuD2RIup0HmWjfUSroyGob+mWjjxOjl3
         1jchiUmgCTOPg1EINYyrIrcsq94ScjyOfSQYrV5T6Y+j525kPwaNWhRThQ7GQGWOjdG5
         HQwaAN7oJmsWf834cgy6krtB93odOYGLUu4yz2kslscbRM742ctqtip7LVANvMy8siTB
         SP8S8I2ecgTUg9F99b5cVIEfZ0MtMHOCeofkTlF3tNvz5t0i29H1CE9BwkJZJvn97SxG
         QuG1n35mDa0cEH/ja7QoDOobI71dcMAow4OedZj+Ov/Y17bzPG8v7YexJSA/aQD1Pyya
         SPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+48KG2hgItJ1/kgskaitA3xSPzw766rX0Cox6HcdLB15i/S2R/jV5pk39gqcdywEM/CxVHOgNnPwrMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy640E7lSf/7xUJlisPOov2iYdBxehzZ6zUIny8SbPNAUiXdAWw
	JtZ88istqz5Kuyfiugs0j3IGB1Jfw/qv77Shmu+cYMNcyMJjW1wVlUwu/GATJEOOVccDwea+yN9
	iMi6ZtG9bMRn/lRHgNoRNcZXGDYpyHRk=
X-Gm-Gg: ASbGnctkGSs1NToFOH2Al1mGloPXLwqwQ6zYRp/+Ecws46DyN+/SeSFfIraef03huUe
	I4fji1aPsCV1tCnXU0YWIZaDy4GLmqa71n+wa6tKFq6FGi5/hGUCKPb1U0gYKFvClppyq47Jb8P
	jKcuKjoX/caNFFGDIj38Cn/qVubUQcvsKLGEaw3NuX7gQuKczQb3g+H+FZpfRHemFAiy5cjVjLX
	CdAVPgHLiCAnbF1qlOkRW7crZfHayvZQLakYZKvlE+QRccy/DzjxKqGTig=
X-Google-Smtp-Source: AGHT+IFotiWPFO2AllCGKA6tO/T+IXcCmNirCX3Lliq0AZ2OfXI3bRZk7OrVIcI9TcUtGhU5hzc2a/WiVxBXjnfZarU=
X-Received: by 2002:a05:600c:699b:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46fa9af35c6mr161148645e9.24.1760410115695; Mon, 13 Oct 2025
 19:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com> <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
In-Reply-To: <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 19:48:24 -0700
X-Gm-Features: AS18NWBn4zAMAeVMaeMdIBpO0QuBxoqXylpn07vpJYMirTGjgZsbn7Yyj6E3etc
Message-ID: <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:54=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Tue, Oct 14, 2025 at 8:22=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 5:15=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > Just a few observations (if we decide to do the sorting of BTF by=
 name
> > > > > in the kernel):
> > > >
> > > > iirc we discussed it in the past and decided to do sorting in pahol=
e
> > > > and let the kernel verify whether it's sorted or not.
> > > > Then no extra memory is needed.
> > > > Or was that idea discarded for some reason?
> > >
> > > Don't really remember at this point, tbh. Pre-sorting should work
> > > (though I'd argue that then we should only sort by name to make this
> > > sorting universally useful, doing linear search over kinds is fast,
> > > IMO). Pre-sorting won't work for program BTFs, don't know how
> > > important that is. This indexing on demand approach would be
> > > universal. =C2=AF\_(=E3=83=84)_/=C2=AF
> > >
> > > Overall, paying 300KB for sorted index for vmlinux BTF for cases wher=
e
> > > we repeatedly need this seems ok to me, tbh.
> >
> > If pahole sorting works I don't see why consuming even 300k is ok.
> > kallsyms are sorted during the build too.
>
> Thanks. We did discuss pre-sorting in pahole in the threads:
>
> https://lore.kernel.org/all/CAADnVQLMHUNE95eBXdy6=3D+gHoFHRsihmQ75GZvGy-h=
SuHoaT5A@mail.gmail.com/
> https://lore.kernel.org/all/CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=3De=
8avRWpMQ@mail.gmail.com/
>
> However, since that approach depends on newer pahole features and
> btf_find_by_name_kind is already being called quite frequently, I suggest
> we first implement sorting within the kernel, and subsequently add pre-so=
rting
> support in pahole.

and then what? Remove it from the kernel when pahole is newer?
I'd rather not do this churn in the first place.

Since you revived that thread from 2024 and did not
follow up with pahole changes since then, I don't believe that
you will do them if we land kernel changes first.

