Return-Path: <linux-kernel+bounces-867320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1140C02410
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE083A59C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5A248F5A;
	Thu, 23 Oct 2025 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Sx5V46"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D1123E356
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234791; cv=none; b=rI1CPxIMF4kJsQ2u25L5e1ScpG5zppxSvNT7OYIfuIIVMQmbsIteKt5N4jgWqHQ3rShjyCwjQ3+hHCooe+nH7dBQHYLNT2qR2VTw7xpJSLKM+IwPd37AMYSKWWft3Nop9HWqozAloIbCdOklI8VB8ASZxQBoHExqBEuF5RZOUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234791; c=relaxed/simple;
	bh=8YARU0Mc53mjXAXyXU5+DtiwbSIY+93yMyj7L6JyaJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru1Ylod1fGcGxH6jKedvpVVC4XcVRSLJzIeyTadVWSH/ojVg/so0aVZDoi29VZajy1DD/T2nTYzgvSzJzZhJ15GvxmG4JveAE+0wiK5blZpiMzhf5YFo5AvSWnvA0Su4/K1uc7YONHtY18JR51y9iIhhU8OhvFbBRTIkExcTaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/Sx5V46; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47109187c32so5169175e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761234788; x=1761839588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xArOOzRNeee8Y5GZ9VW+Mc5iRqcYPNCt4ydjP08TiyA=;
        b=K/Sx5V4692eyz7CfF7BVrPLY61fN/cIEiAGySGZNoZTAUlEBT+DoPIpLylM8o/3CgU
         MYfwWrlD94VYzDO2VCEL/t0R33JWHz8hOv+92xjXosxCkfyFSAnkv2UwkWTMYipd1IRO
         50aXGOlHLYpdtj2VxIWzQob5oe3wN6LwqwjdEjTP5R2VRd0rumU4mumM39ROBqWpE0SK
         GWAUYX5MtlMqIgLsT2uiD0flbs6y/DXvwy1zcG+zFOsuOSVgtruKSJAdY2O8w0Bu2WNW
         gV1Tsfr3W16pArfufGbHXwpKRrxDpD4QHH99EQK4aMsyjgnfNx2hsSeaLm6qu1EFCZ2a
         nS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234788; x=1761839588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xArOOzRNeee8Y5GZ9VW+Mc5iRqcYPNCt4ydjP08TiyA=;
        b=Wg5fMOnk/qqvnXOMhFwl8oTZWExMVCOgd9L/rukmudq3fBl+slrphmukyEsk9mIZ8R
         FnnSAJxXCKg+vRarrGpoZw9vsDwicdUh7TazwBB5mTq8Gmsa+h9pBtlXude5Qwb8ChxW
         9AjfmKgj7L7uIfewfX44G3kvhj93m4QHuS+bG3etzbMNcJZOFvyFqGCPyIao5v7D4zfn
         QHFR36/wdidKQiJCmYoQFRegQIQyiUCe5IQuIaOijkaTt3RXGuzd7HyAW79qfiPZOZe2
         nomO0mvMoGY6FmHwdTeO3pXcTkq9251LvvDoNQh5foqp/ClW5qFE/axADoGOnWA61xsq
         wF0w==
X-Forwarded-Encrypted: i=1; AJvYcCVNT8F1n+vDoExAOJVBBwb2C0RxN86RR7Rqo/xziiEqhIWul+/ZlSaiDacLTWKkXOYdzAMhbAIF9UZWIhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyedhENu0u0HlHyOo3pbF1ysc8BMQOXv2e43+a7tiConE7IFr
	h1L5yl2Wb8uXZcT9awiUhiwURfy3Zh1RnjqZcDa7i3rbY9VsuEFBliiRdo1z4mP1jcf49JioGfj
	h0O7BbFJdLjNVk6TXDOATYoo566pNsLY=
X-Gm-Gg: ASbGnctCfQsNPMKTot2SekoUA9ZfKobtQ6Bw4RDHgO5jDvmn7WVhoOwW5humilprjGT
	qSPDEcg7Qp7CWQVZKkTgyinZguRiFbJIekOsZBDnylO4r76T1om9ef1WjEySuRPSZJ9BdMjgDG4
	BbCw/8o2q7SimTVgfW+iTb032B0TzQxedkzS5zC/E1jQzZTums73DVq0+yi6BG4siiTP36KJxdw
	5FUdgyjNpn187hEYsxeV00G8DW+c4PCz2ejKfPCOPoz2nMnMHLoPGxwLtqFfLW0d6YoCCoggG1n
	o3ejgyX5BFI=
X-Google-Smtp-Source: AGHT+IFqNQRd6z8POrKG9gx/vtI8SjdpIQvfuAoFenw4t2LmMth8dsNK8tz5awLWR+F2TTPMKqUjdtFvfI/JaX9BjM4=
X-Received: by 2002:a05:600c:444d:b0:471:15bb:ad7f with SMTP id
 5b1f17b1804b1-471178b04cfmr164550255e9.17.1761234787683; Thu, 23 Oct 2025
 08:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com> <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
In-Reply-To: <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Oct 2025 08:52:56 -0700
X-Gm-Features: AWmQ_bmOQJjLilSjL_d29tKIBtQHC3nGeFUO8NBl8n7PZYVtBGpyQskXLAHTveI
Message-ID: <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:35=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Thu, Oct 23, 2025 at 4:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Wed, 2025-10-22 at 11:02 +0800, Donglin Peng wrote:
> > > On Wed, Oct 22, 2025 at 2:59=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > > > This patch implements sorting of BTF types by their kind and name=
,
> > > > > enabling the use of binary search for type lookups.
> > > > >
> > > > > To share logic between kernel and libbpf, a new btf_sort.c file i=
s
> > > > > introduced containing common sorting functionality.
> > > > >
> > > > > The sorting is performed during btf__dedup() when the new
> > > > > sort_by_kind_name option in btf_dedup_opts is enabled.
> > > >
> > > > Do we really need this option?  Dedup is free to rearrange btf type=
s
> > > > anyway, so why not sort always?  Is execution time a concern?
> > >
> > > The issue is that sorting changes the layout of BTF. Many existing se=
lftests
> > > rely on the current, non-sorted order for their validation checks. In=
troducing
> > > this as an optional feature first allows us to run it without immedia=
tely
> > > breaking the tests, giving us time to fix them incrementally.
> >
> > How many tests are we talking about?
> > The option is an API and it stays with us forever.
> > If the only justification for its existence is to avoid tests
> > modification, I don't think that's enough.
>
> I get your point, thanks. I wonder what others think?

+1 to Eduard's point.
No new flags please. Always sort.

Also I don't feel that sorting logic belongs in libbpf.
pahole needs to dedup first, apply extra filters, add extra BTFs.
At that point going back to libbpf and asking to sort seems odd.

