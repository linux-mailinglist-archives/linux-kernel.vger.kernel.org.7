Return-Path: <linux-kernel+bounces-799438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC51B42BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698BF7C77BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C02EB5A1;
	Wed,  3 Sep 2025 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPuvS8Ly"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3D2EB854
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934598; cv=none; b=u1qSv8yO1gQdbk8VepR9HVeA6m5dAAYWcaMPuP3VG5EMyTFFTobW/DaW+uUWNnBB2t0ThiYndJK8AON5ZhwsX1XO6ZWlO/RtlcOmP7fFwzAsWrEsGFUOdhBv8MuylBN+YVn/GPN5fdy/LcWhGo/aCF4u7U63437UmCFwhmghBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934598; c=relaxed/simple;
	bh=YV5JeLX8eppE8ekya9WYH3l90CIWMh2mNh78A5JQgAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDPU8Nv4VLdh1qLVX8JokJ5A1MwFy1Vr3B95yuK8YHUHVT4rGGvMBy9O0u9aVbMWuAVko3vE7gg1uu9CDitBoUd2Lo1eAYeS0am9S+vFl/FdjQ75WdY1UWffE1TJFCLdPVqxJttJn/JLpDl6TQq26Ng+rrQ43CpuXt3JTn+RbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPuvS8Ly; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0473327e70so55597266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756934594; x=1757539394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTqpzm8Plz8DYgvTTByPTlxjwBnf7eagmEFAvqtbn0I=;
        b=sPuvS8LyYrA+Na5z7Ugx9I+jKuzs6FYxQW9JoTUqt59bO0Y84rzi2POoPXkP2ycM5Y
         zEsHh1Avsbs/dwOKEMb4C2CxFa0IQCrPLH/305V9il45MUcKMjah9+hK2SvoFpKHcabD
         UlLo3xsPSdYWwnx7tzsqNDVSN0pk9ODjnhQT5OegZnUm9AXCqk2QIyDjI5ljR+uDMQw7
         j4OffPED1RwnQVGeBDfaVvskLLdATGF39YUFoCgWXlEgkfLZsmMKNYQ/FYpnNPI1g7nt
         oQgeo+sRMcRGPvIHZPeB1lUQe7hDDYQ6dmNFz2YJV7LakCRtb40kV4qMVOPoidwsGHpl
         4Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756934594; x=1757539394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTqpzm8Plz8DYgvTTByPTlxjwBnf7eagmEFAvqtbn0I=;
        b=MREzAP/08+0shzAaPbwagaOFP4kHj+sXcOr9uXfSFdQl2fTpWQDUTTRsIwNkIRPVrR
         qbA3QTQL56QusWH2btabvRrjlI4fpgNo7lWnRVBIrfQBLvcds3rltsThuouZn9MHIi+c
         /ntV3D6U2XianhNATWMazjkHqtyl/L2bNMZKzAf8XoyDRflxu4aYegEy6xXCyh+ryVQ8
         Hg4ZpgssQqfx0dhAnvwB71EnP8Q9KWmd13xY9rDaxxQLCtqCA8Vu6gw9vq1zJ13/KcL4
         T0IX6JGw5acFJDyUPVyDdPidiO5OCN1lfodtSuedVbVcdrz0XjoCGdb9CN4VJiXW3hDl
         z5nA==
X-Forwarded-Encrypted: i=1; AJvYcCU1eeU7zh7ypUZ5ETL3ex1hh4UQN4XAL1nZWMiDpYkeHYWprHDpxY/2bP6B7N0e6e16KCCItLTOXw0G9M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsv60Pg1EgAkR7LYC87eDUXclKcNiznbp2OAB/K99Li8gl6GW
	F98FEOk6Z1XbVeQTxMJl931qS8IDzph/x0rkcqqyH4XbvjwXJiXL4l782cc4Kv0Khm3a1savyls
	UQBOSSBykV1xWi8K4LOCdaDLD5CHXN9iBZvZsI0Xp
X-Gm-Gg: ASbGncvQB/u/5cFaOsJkftzROnKk3ZoKFPbWfm8Fi5QvuGLwh3hqNvEK/HbnuuCHl0P
	qawyqU3cjjkSXPwx1O5xNuKlh0sj7SnCe6xhClCIQsCnMkOrvT6mq8CW8rsZ9Uqjs3weSEuzEPC
	U+QOOuOHanadhr8kXfI4ZXEtnmL1gxyMAkC9izlhZxGGxELJt2V/Kvym1rpDv2WaH4y3YBvmrQS
	i1PXr21cD2kuLFZbBDI8t7wKlG7DBTmf7+yWe3xUl1JQ2jjWOd7ctQ=
X-Google-Smtp-Source: AGHT+IEXmPGlRSS3y+KTDoly322hxE6u1kV48Yzp4pTSOjFrjS/2qZjmSO36eB/691/J+IRZsHz0s0vjKHuMr9FWmIw=
X-Received: by 2002:a17:907:6ea5:b0:b04:3d7b:ad43 with SMTP id
 a640c23a62f3a-b043d7bb618mr1226009466b.40.1756934594492; Wed, 03 Sep 2025
 14:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195806.226328-1-zecheng@google.com> <aLKot1esgc3HHubX@google.com>
In-Reply-To: <aLKot1esgc3HHubX@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Wed, 3 Sep 2025 17:23:01 -0400
X-Gm-Features: Ac12FXzobMEN-ZWxzH8JZtzKBn47sB4CsCCDsJiBB-2w7RDo5XQRKxA0s_bfZtk
Message-ID: <CAJUgMy+jTTAQ+=F=ddryLrftyB0h==pezZdvnZAT-UHmSU994w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:31=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> > - In match_var_offset, use __die_get_real_type instead of
> >   die_get_real_type to preserve typedefs. Move the (offset =3D=3D 0) br=
anch
>
> Why do you want to preserve typedefs?  I think a variable type can be
> typedef to a pointer then now it won't resolve that target type anymore.

check_variable preserves the typedefs. It would sometimes resolve to
an unnamed struct if we remove the typedefs. Let me test if it will
affect the dwarf_tag(&data->type) =3D=3D DW_TAG_pointer_type check. Also I
found calling dwarf_aggregate_size on typedef'd types gives the
correct result, so maybe we don't need the sized_type in
check_variable?

> > - When comparing types from different scopes, first compare their type
> >   offsets. A larger offset means the field belongs to an outer
> >   (enclosing) struct. This helps resolve cases where a pointer is found
> >   in an inner scope, but a struct containing that pointer exists in an
> >   outer scope. Previously, is_better_type would prefer the pointer type=
,
> >   but the struct type is actually more complete and should be chosen.
>
> Can we improve is_better_type() then?

Here we are comparing two types with the extra access offset
information. In other contexts, the calls to is_better_type compares
two types only, so I think we don't need to add two new parameters to
is_better_type?

> > -                     if (!found || is_better_type(type_die, &mem_die))=
 {
> > +                     if (!found || dloc->type_offset < type_offset ||
> > +                             (dloc->type_offset =3D=3D type_offset &&
> > +                              is_better_type(type_die, &mem_die))) {
> >                               *type_die =3D mem_die;
> >                               dloc->type_offset =3D type_offset;
> >                               found =3D true;

I find changing the is_better_type call to !is_better_type(&mem_die,
type_die) would yield better results: prefer types from outer scope if
the current one is not "better" than the new one.

