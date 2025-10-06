Return-Path: <linux-kernel+bounces-843603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF8BBFCDA
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70B944E95D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD812153EA;
	Mon,  6 Oct 2025 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKOZwSAK"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6535972
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795058; cv=none; b=FGticXZLM2+VEwaHSGcTxcnPX5rIBTViRiyaTB2oARLRApRd4VvdnTk+KGC1wFTe8Jnmw6bbmi1+nmJEubjfS1piAqsqwP1UQZ1/ee+nT6ZS/gvqvz+G9pBr1c83TO9qoLlhEr4FCrp+LWuoSY0ZirdcwOXIO9c990b6nUxjEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795058; c=relaxed/simple;
	bh=aeO5Bf807sImgx5mKyNh9w4Vqa9UgFwbmFN57TCeihs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P153RGkvIvhCPATfm2zlt2pQZU1XWtx5ct3XLw4aWslRq0p1OohpeUk5JkUMSI7Bm5Bdsw6URMpmQ25K2PSutXcS2t9C0RM0uqh4RcONxZrva+gWQVzvswJ/72aDWTRUN3Pi0bsZSqfmsL2vF4JyKUi+K72NGCXueai4Xcb1oBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKOZwSAK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f67ba775aso7355790b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759795056; x=1760399856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeO5Bf807sImgx5mKyNh9w4Vqa9UgFwbmFN57TCeihs=;
        b=jKOZwSAKnqtGSoXK1jf1Eyj4niDmjFYchVp942+iNgDf7FHGhW0NlgagwsU/w4pf9D
         FoGNgRCROSrlOFgB60Qru0V32K8p+ip6ZY6oFluhHTzS5oCp8TxKF+dYoosPPM29qoVT
         eAYjOvo6HpmtUVcbCL0XR8yNRVMcsVdY6AetiJnnwU3JfDLSpHi0BOynCkVNvuAY5kmX
         ML4YowpuzeK5gl+MSdz/KSiLydgo5aHDuQdsJiCmw3iuKFAchgPkF9ee5E56O/nlsbKM
         3vNs5YexqAMI+wePl9EueVvbm3Dw0AIh33cc64oUth/oN0CMInpj/JE7dYtRxLn8WFz0
         iobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795056; x=1760399856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeO5Bf807sImgx5mKyNh9w4Vqa9UgFwbmFN57TCeihs=;
        b=dMQnrG8N8u3iu8vPBpg5XHYX1T7r5eHdteDJ345uaoBt57TDWyk5w8AdfCfWLj3jYH
         lam7j1HgyL7Spi8e4Ow38O2eZhSvtsb1z7cAlDV7zkG+xXGT51nXfU5qBgAORqC8VSSV
         r8hdv747Qii9U2qVpHdwiJE9BlOcFzzsWbKWTQAMdJeO+zQQiPhAirTekUX9ksdlDAe4
         IvbOEzarUzdJb0gPQUVyPlkoDtp/WLPPFmq9vSG8hxdMMoJP65HUyOiDNETLWjqDNAXw
         s0C9DQ4c4ZPwU0BoYgbjaGAKHXUNVBQzHOxxgJDRvWJF4jh6gcGG7Rye3LUwq0tTAqy0
         f5YA==
X-Forwarded-Encrypted: i=1; AJvYcCUucRaRUlUX+4Eo25k1+Seus/3bOLd919d5zERoiL93GAQv6yATi5Xge/7zp8d4kUrSzRDGYMQbltZgJq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW1ysocn+C6z+D7rTS8hrxLj0pM2QgZS82DRpszsECdo31i4Gl
	tJ9aPJ8QRACprhnA95RVEW3nBcBTih9tB3OsBUDpgOf17+ZU1LgHuPH+kZHT7C7d4dbtlSpPn+3
	HX66i6nNfmAY7K8EZX/LLqVF+f6Tg2lY=
X-Gm-Gg: ASbGncvF+lF8jN5trLQP2Rlk6acZhg7B/qGRmnZtH6DuiULzwBae7PcsNS8Ie1IjuPO
	pnJVaBVZixlEF2Tq31+GtjwYuPJg4LiH44P5LtIh9Pn4oZe9WftcVi0TEMpjY9bngxBAv8WDUy1
	Eg+hvI2i7e0JexeUM8biM3lbJMkdcEd00/y8xdhxvG7vUokOox5/8B0Se0ZU1TRu0CPuO+1+6gG
	FqOem628+cPMFaWXQKdkxWOSNXMoS4NbOk0XbV4VfKz3eM=
X-Google-Smtp-Source: AGHT+IFlbKfL5TblKqKnNhOe1oc4J8CKVBhJt//RaO+QWpyXhCbuSLuhVLl88NwO9ryI7OF3HhUw0Ia1vy0lp2lGsro=
X-Received: by 2002:a17:90b:1b50:b0:32d:17ce:49d5 with SMTP id
 98e67ed59e1d1-339c27a58d2mr18475006a91.23.1759795056201; Mon, 06 Oct 2025
 16:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev> <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev> <a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev>
 <877bxb77eh.fsf@linux.dev> <CAEf4BzafXv-PstSAP6krers=S74ri1+zTB4Y2oT6f+33yznqsA@mail.gmail.com>
 <871pnfk2px.fsf@linux.dev>
In-Reply-To: <871pnfk2px.fsf@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 16:57:22 -0700
X-Gm-Features: AS18NWAXVJ5dXSA50rDM1SRzH9Tu_dSgFwL-2Wcn7bv26ZAPiAQh2VJdbHvxDyA
Message-ID: <CAEf4BzaVvNwt18eqVpigKh8Ftm=KfO_EsB2Hoh+LQCDLsWxRwg@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 4:52=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Oct 3, 2025 at 7:01=E2=80=AFPM Roman Gushchin <roman.gushchin@l=
inux.dev> wrote:
> >>
> >> Martin KaFai Lau <martin.lau@linux.dev> writes:
> >>
> >> > On 9/2/25 10:31 AM, Roman Gushchin wrote:
> >> >> Btw, what's the right way to attach struct ops to a cgroup, if ther=
e is
> >> >> one? Add a cgroup_id field to the struct and use it in the .reg()
> >> >
> >> > Adding a cgroup id/fd field to the struct bpf_oom_ops will be hard t=
o
> >> > attach the same bpf_oom_ops to multiple cgroups.
> >> >
> >> >> callback? Or there is something better?
> >> >
> >> > There is a link_create.target_fd in the "union bpf_attr". The
> >> > cgroup_bpf_link_attach() is using it as cgroup fd. May be it can be
> >> > used here also. This will limit it to link attach only. Meaning the
> >> > SEC(".struct_ops.link") is supported but not the older
> >> > SEC(".struct_ops"). I think this should be fine.
> >>
> >> I thought a bit more about it (sorry for the delay):
> >> if we want to be able to attach a single struct ops to multiple cgroup=
s
> >> (and potentially other objects, e.g. sockets), we can't really
> >> use the existing struct ops's bpf_link.
> >>
> >> So I guess we need to add a new .attach() function beside .reg()
> >> which will take the existing link and struct bpf_attr as arguments and
> >> return a new bpf_link. And in libbpf we need a corresponding new
> >> bpf_link__attach_cgroup().
> >>
> >> Does it sound right?
> >>
> >
> > Not really, but I also might be missing some details (I haven't read
> > the entire thread).
> >
> > But conceptually, what you describe is not how things work w.r.t. BPF
> > links and attachment.
> >
> > You don't attach a link to some hook (e.g., cgroup). You attach either
> > BPF program or (as in this case) BPF struct_ops map to a hook (i.e.,
> > cgroup), and get back the BPF link. That BPF link describes that one
> > attachment of prog/struct_ops to that hook. Each attachment gets its
> > own BPF link FD.
> >
> > So, there cannot be bpf_link__attach_cgroup(), but there can be (at
> > least conceptually) bpf_map__attach_cgroup(), where map is struct_ops
> > map.
>
> I see...
> So basically when a struct ops map is created we have a fd and then
> we can attach it (theoretically multiple times) using BPF_LINK_CREATE.

Yes, exactly. "theoretically" part is true right now because of how
things are wired up internally, but this must be fixable

>
> >
> > Having said that, we do have bpf_map__attach_struct_ops() already
> > (it's using BPF_LINK_CREATE command under the hood), and so perhaps
> > the right way is to have bpf_map__attach_struct_ops_opts() API, which
> > will accept optional extra attachment parameters which will be passed
> > into bpf_attr.link_create.struct_ops section of UAPI. That thing can
> > have target FD, where FD is cgroup/task/whatever we need to specify
> > attachment target. Just like we do that for BPF program's
> > BPF_LINK_CREATE, really.
>
> Yes, this sounds good to me!
>
> Thanks you for the clarification.

