Return-Path: <linux-kernel+bounces-799140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2BB4279A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CEF7B44F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C73148D4;
	Wed,  3 Sep 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7hLySco"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38820E023
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919281; cv=none; b=nRW64csVji6aKX3ZaodTKvmydI+cDAcnj6PtLz2DbwYApmIGrsXDrmxeQh7LOZ4HviN1C7G6Q4YO8M9/WWb/6pwuZd5ddqZjfufww54rYyI0BMfpA9A2J/wMkjtCDIydBFmxooNJFRG0nBZneFmfyGwC0ZKTlGVN0PMtox9TgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919281; c=relaxed/simple;
	bh=9qCTFG7GmVGo3IVwDSQvHNoB94WYbwuSMYDaJ+LxJWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMf0NMOp/mNAzJy99MmUJw7uPvS0emRst/oRvJtZ4R7xbUT0fK+7Qf2eIrJQyQANkCnoa2OyRRXuoMbBmO8GLevCgRQJekyXjzZorG+llxLBI4k6WoXP55DJhRLBS/1yo5BCjSxlh/UC+q92MA2WOiHU5iD1T/HiuyJz/kVwuIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E7hLySco; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61d14448c22so259a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756919278; x=1757524078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOy3uiI86tJvI7FGJoVOj1YT+P7Fnq5qQXCbIcfLxzs=;
        b=E7hLyScoTBvLxx8oU8IN3Y/cvSjvngaGQ1rtpMWORIje4YDtQmAPCcbSH6qWxEUcYC
         pHW8nPfFmpvLEOSe3eU+O4ZHHNP6tYaGz4/YLmcjzVRwFXCmrGLTgPqkYjWAh9ZnBW3S
         DMZD4YOcYRxydyZ0aYcZb2AztRPHuLggGbUqQlOOu2wdbrAsPVVac5LUPsFUQzm97L0O
         aV+CuCusqKBLfRybYQrd99g1F36QdMQ2o1cozD82ohZfCgQdNn6e/CYL0YGLobRlUzcE
         974hXub7NANQggGsLA6hjBHlogcMwTL/RzHJUekhQy7rnHu7/djRqSeaeTG9HPQ4KsiA
         0Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919278; x=1757524078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOy3uiI86tJvI7FGJoVOj1YT+P7Fnq5qQXCbIcfLxzs=;
        b=tuhZ1xPyAQC2BE+WXxqC6qHmnGJ+P49ZE+Q3rleR6ioTYzarZ35Y8sOFVNjxn0CD0I
         lVN1Vtc16YOrr3tz42SUIm9FEIfzrHrTtqOoaXRTCWqxLCWANJ27js9jf6vsdu/oHW97
         fS0dTx1OFkN86Gebevva9YAx7IAuid2SreiyvdyAMku/MXa1RzY2RlaosfXKSGOKV7kE
         4Yi8c1VfFZ1TSBHCZR9d/1MmzMUqzYdlbF1rAum4Yd5lOzN72tnyUrtXTyqj3aFUN3Em
         SZbJ+X++Qy1ZXrE4Ar+00DPEuvpCQ02wxKN3EOwHRs+KxDDKqk76iCXROCZFcZhE2tla
         SxjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPoLvPpsQUnseMzKGHkfuMuKv7DIbzIjce5nC2P0dLKAUNea5eUDMLlFqgSv5I84vyPQB8dwY3nZC1G4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws2YFiAwXxiRYZ086LytDDeNRSlk+Npllnj7TPTFId8p1l8ZL1
	WQAbaRKH0JFIFO2fZVih7xarqFFVQy9jQ16vXiMEIUBa42gEUXDvN1sdgCPvOF8dYSiAiiO3FsA
	FFzfU2Pi5Hxx5vTBM5DH33KW8m1MVPXJ9wkEtpW+0
X-Gm-Gg: ASbGncvbagTDTNBy2Jwjit5LZvsCucViSrmlOWV9/ubBkyz0y2jZ+OJkWUl3laCk8GL
	sJNHrYtNM7K95RnYhvQT1vxUlErac1svB1lfOIez2uJBr4l5+mEHBSTHPjmKnhE68b7Lct/cKX1
	jR4uWSbizrVJDrQ5ApDMv9FGDUOidExzmC3omHTs2he0j+c1UFVqnvCBEY8vE851exC+nkaD35M
	qaNbGtopyUDP9ZqnNeKOqLhW46Cyk+NlMERJCEbPCO1FTz2
X-Google-Smtp-Source: AGHT+IHychBkvK6ZWrYTnSznm3+l2PaQ1tnBnvAVllfrH2aL6Xr0iYBPC6W/1RSUT01Mb98+V7ZrDP+jMEOCDbAhs34=
X-Received: by 2002:aa7:cb0d:0:b0:61e:ce79:1da7 with SMTP id
 4fb4d7f45d1cf-61ece7935c9mr207979a12.6.1756919277446; Wed, 03 Sep 2025
 10:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756897825.git.pyyjason@gmail.com> <d7998ea0ddc2ea1a78bb6e89adf530526f76679a.1756897825.git.pyyjason@gmail.com>
 <33E58899-F5E1-4E24-B830-A3E914331083@nvidia.com>
In-Reply-To: <33E58899-F5E1-4E24-B830-A3E914331083@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Sep 2025 10:07:42 -0700
X-Gm-Features: Ac12FXw1t6dt4dOnQ8qWCWbnXCPmPMyQQkv__RxYXd2_GKtSxElsS5L9wHXlLu0
Message-ID: <CAJuCfpF1kKqjk44a0gZs0RLDnPEQS8LH_TgM7xu5BXwdjP8XFg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/show_mem: Dump the status of the mem alloc
 profiling before printing
To: Zi Yan <ziy@nvidia.com>
Cc: Yueyang Pan <pyyjason@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vishal Moola <vishal.moola@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:29=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 3 Sep 2025, at 7:16, Yueyang Pan wrote:
>
> > This patch prints the status of the memory allocation profiling
> > before __show_mem actually prints the detailed allocation info.
> > This way will let us know the `0B` we saw in allocation info is
> > because the profiling is disabled or the allocation is actually
> > 0B.
> >
> > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > ---
> >  mm/show_mem.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> Acked-by: Zi Yan <ziy@nvidia.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> Best Regards,
> Yan, Zi

