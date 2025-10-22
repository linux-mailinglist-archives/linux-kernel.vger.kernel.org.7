Return-Path: <linux-kernel+bounces-864044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D247BF9C90
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0843B9991
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187822A4F6;
	Wed, 22 Oct 2025 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naOXyBe3"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80D22333D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102498; cv=none; b=FcCUlgC3UI0sD0FD6nG0nMKYJJ+GlbvBKro6oP4f9PzamTAE1Ypq6b7o0V6XqUZpMkQvTKjKKlaerGryAhICsib8XcltyPw/v+tc7gCiKcD50JyozEppQ6kM0gOmtn8BmxFDa5sSEwyOyLbwoCkYZMAHR1Hes/mt91SM5G80S2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102498; c=relaxed/simple;
	bh=zPBJPWJG1RmSuUSiXXFf7Fti2uJ0uJ2ARX+chCP+tt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqNkM1L7PVB0EVEWO7XR2kI0PN2ZQdmcjajOEKIPobLAWLbFK6+hlWLQtOJ6fHqMSrFFbBgCeG6mqWNxcvvwDIytz+w9e3jOi/cG8cBUIpjLAQlLk3gHdKHqS7HTu6BRVJsB3CaiHkvZYi3w2UCDd3Wy8jjdQNj/sBURU2Z2Jfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naOXyBe3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso953271a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761102495; x=1761707295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InWFJpQO8fTxO1bkzACACUHVLGVVqDW5A3rrLvGIiHo=;
        b=naOXyBe3+hvTKIo+vbFvLXlll+y+KoSnNIP9bGK+69ckGp168T341BGAXX+iL8Nwx4
         UB+/16hqXMr9Tk6KZcoZDP/3xLL/+hlGzV86xxL0tw/sgUg92vyg9w1kBduHJ9oS41VY
         WiE3aPl3KWkd3uWf7z1jPkQsX9n6oJ6dh90oOBmas0EEQLWnbjsGAzo79m8/411kq+Iz
         Zu2Oe4Q37i4Vl75V3vVCwWRcUZ4/1g56Lf+nmnJKOvK2X34bLwK1E1sY3pE1qyOTGJ4+
         c9RV87r2qa7vpfRKku8GYT9UhyoV7Ta031pz5+1q/8eRGLp1AhoQQbO6dEGizE1j0v6A
         hXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761102495; x=1761707295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InWFJpQO8fTxO1bkzACACUHVLGVVqDW5A3rrLvGIiHo=;
        b=lhXVDxiww84YU/knR/c/Xg6Hu29aWyYKVqj6G8NHpRjIjPPD5NHO7O1X0oId9JvTBq
         X6SZdTOtG0N/72NJt7XELp+1fpwM4Uc75yYyfExwR8v3GDFQ+ltWhBHthzSHsxiTHBIi
         C7txUAKYWXoQUZehh+pRmkKCcwkGTKbmTItEuReUl0bk7+OUpkCPAU7o/1WzxBrKBiiI
         NVfDRwv8caocBSgOdwEC+J6D+YAdmq6d3NlOR1driiesObvmipfj+zfPJg1M/awSteyu
         so2/gWfB0EySKDk8smoTY1baJi21lKkrWe4T4Gxmtnkj3oLvrDFD0osoVhK4Ak4RpLTD
         crMg==
X-Forwarded-Encrypted: i=1; AJvYcCUGdMlgcYO9o0baydplqa2nJPlyWgw8lh5QFn+Rl+Rh+SrvLDv0iK1j4FdO4CNsm49ycNlXWSwbUzeR1hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/j4xwA6PBBAlZXk+WWbvR3z2MNCHU1hclNezO1kvaslD/K2i
	8yJr3HO4saRt0rbSEQl2/QuMK/JKNp5Y7iW9GtvfAC1NQ9jutDnN6OKSohfGNwK56W3c3SIwPtv
	s63D+0wb5OJlXPHn8PzYF7UwXf+pFBtc=
X-Gm-Gg: ASbGncsOSLpV5NdkwRysSdV7/huXxH3VwB0g3uossRBUgoJMZfNSRKkyqgUCWl8Epje
	WDY94R0bRt+DwSJCON5UkDk2dbDe3oSbEL9Lc6u7JmFhTUw0IxwdjzTHm0YuD7jcbVz01zspOrO
	98ckpYAyZd2HuG+iuIN6BCWTtNDJxK++NGVz5w3bEe9P7dvh1y0zxldGvvFGPQhuGBRvN7S3wWB
	r/DbbkB/hdjIiu98KD90fc5ofH958fc5P+INTJuDKidrlco3GUhro3ySZsIhfshnABq75W0
X-Google-Smtp-Source: AGHT+IEX1rltKwLPyvW0/Qg9CwBU/OfKcOnqDgE5TVcbY0wTzB19biWLcNylgJME1yuSwaOCqqEw3jC5+BWl5NnsTiE=
X-Received: by 2002:a05:6402:210b:b0:63c:5892:3c3a with SMTP id
 4fb4d7f45d1cf-63e173c0c0bmr1896817a12.13.1761102494810; Tue, 21 Oct 2025
 20:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-2-dolinux.peng@gmail.com> <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
 <CAErzpmvLR8tc0bfYg6mG82gqMSXHq_qXeMsssSDuzirxkSt-Rg@mail.gmail.com> <dacb24230861da2eb8fb5bd7168bdca571727b62.camel@gmail.com>
In-Reply-To: <dacb24230861da2eb8fb5bd7168bdca571727b62.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 22 Oct 2025 11:08:03 +0800
X-Gm-Features: AS18NWB2xp5k8jJQYnmoli_av-vve609ERXlhcmwqYUxVIE0Xnuffu4DyjzlWZQ
Message-ID: <CAErzpmtV4AS4=TvgXM5R0bW-7kv8W014D=mcCFANQ-o3PFnZtg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] btf: search local BTF before base BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:56=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2025-10-21 at 16:31 +0800, Donglin Peng wrote:
> > On Tue, Oct 21, 2025 at 9:06=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > > Change btf_find_by_name_kind() to search the local BTF first,
> > > > then fall back to the base BTF. This can skip traversing the large
> > > > vmlinux BTF when the target type resides in a kernel module's BTF,
> > > > thereby significantly improving lookup performance.
> > > >
> > > > In a test searching for the btf_type of function ext2_new_inode
> > > > located in the ext2 kernel module:
> > > >
> > > > Before: 408631 ns
> > > > After:     499 ns
> > > >
> > > > Performance improvement: ~819x faster
> > >
> > > [...]
> > >
> > > > ---
> > >
> > > The flip makes sense, but are we sure that there are no implicit
> > > expectations to return base type in case of a name conflict?
> > >
> > > E.g. kernel/bpf/btf.c:btf_parse_struct_metas() takes a pointer to
> > > `btf` instance and looks for types in alloc_obj_fields array by name
> > > (e.g. "bpf_spin_lock"). This will get confused if module declares a
> > > type with the same name. Probably not a problem in this particular
> > > case, but did you inspect other uses?
> >
> > Thank you for pointing this out. I haven't checked other use cases yet,
> > and you're right that this could indeed become a real issue if there ar=
e
> > name conflicts between local and base types. It seems difficult to
> > prevent this behavior entirely. Do you have any suggestions on how we
> > should handle such potential conflicts?
>
> What are the results of the above benchmark after sorting?
> If things are fast enough we might not need to do this change.
> Otherwise, each call to btf_find_by_name_kind() should be
> inspected. If necessary new APIs can be added to search only in
> vmlinux, or only in program, or only in module BTF.

Thanks for the suggestion. I'll run some benchmarks and share my findings.

