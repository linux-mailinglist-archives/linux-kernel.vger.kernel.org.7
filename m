Return-Path: <linux-kernel+bounces-845966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE5BBC6968
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E73A48B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52F92BE7A3;
	Wed,  8 Oct 2025 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg8IgoDf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542D212560
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955424; cv=none; b=htw9zZNYxZZxr0zQmivJVuQGjFv9TBV9dK1jxNwcCRA+yS2Ugf2BS2DaxwOLtBInSaM7ez1UCQPmS+28MmCVVwp+i5FILVkFakOnnPUjXKBCsxVjUaEqhoNAGbfaPOK8GnsVWDOdRPEwVcSW36TmhcJBJDlZt+jE8+WOlXpfVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955424; c=relaxed/simple;
	bh=cxNGY0VqHnS4y0DG5RnOgp8zIJEvrC0X6rQm5IDgXQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c89jXBgleCtnmBhblYgnuQ7XMeoFSG9iNRB07BXd8cLiv6kAraIUkH15yUm5rA5jVeEN0Z2jljqnmCxQLBACsxMGCFS4NvT10VXp7tS3SLonD7EtLJajRreYXenfsWxZoya0KQdCgnjOw4guyHeGMmZ4Aq53tqIu6FmimPSCRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg8IgoDf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698e4795ebso2372155ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759955422; x=1760560222; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8W4R1Fl8LuoehuXK7eXYELzoKCO9DHojcbpKMHA77cI=;
        b=Yg8IgoDfK7wpo432fjLxs2zBe4S5y/R2gHPWCgJ0WG0I5iefvI8cjhvFmi3ViFN3ix
         mk01ot0SpDyfpT8hrsRPV//tmWLUaFOMSRiz/7qHVhxY9MJ3FmAfK91Z40a2zECH1q1/
         q/7kt1gGkmMC6OXmbX1zOa4pL75ukGn33uqInKJUXTmhL0exl2liBG1FPhwcAfYxu4mk
         euROtk5msTCxU3hJmXGXjtOvdmK+UCOqPc3SLhlK03u/39eGVE/Kd4JIVSd4+UxfqBLR
         omm22/sWePJTbeEjTpI0wOmmYAo2c/IDxuWAmNkLfiob6U3C41Ev1MqUSsTpMgMNm20a
         hZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759955422; x=1760560222;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8W4R1Fl8LuoehuXK7eXYELzoKCO9DHojcbpKMHA77cI=;
        b=by3cq+pYN2GJwogm+L7eG2gf3CcxY4upJ0DeXe5Iy/oiLhaB7sgoaifjIQux2xNaDX
         D4BF3Lf9LpJcwfnOADyOkeGzlMAU9wt9Elyz+nuBUarZPF1nOg1Nd/vLO/LAlIlxoqD7
         Pyp7CyrbHH1rAFBrHANDOh4CO7zZ4MqAzMcDRdzJoTmF6x8sTfCXFjRsfU+xkFjcfLdS
         uPL41H/62uuurIQk84HOGV7w/qF0WHdqDlwsZHVDijcBofStR+Bd2lMzpDhM2YvlFFSX
         zsfIkzeBNzj94ih0D/BVC5uXW+bFAL6bCcRtNEGFWU1hKWqduW5JJwHKfc9uLDri5W63
         qSsw==
X-Forwarded-Encrypted: i=1; AJvYcCUVlLt7ycMVmcyPVCJxGlXS17J5rRK7aqsArrKcAB/lYPgXYzTlVNkDMiAvkDKgHYE72BdG0J2WL7Ic18Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3yJCLxzugOi4fv35+ik2Lufo05MaaZOoaqCQolTu97bObIgJ
	odrmpXWGMVaG+rgSW3ohAEM0KQwh0ir+dPTMaLorD6b5UuhEP19oKQGW
X-Gm-Gg: ASbGncucICOjhnG6QP6Z5Bxt0WH+Y0ga9DiSQ3xFW74YIjXUIzPtj3LvT5TvmR0lRjh
	Ny3XXeeETdSgU1DHTVHpvJOWJxwg1zLvUQOJcMZWfx6wMFO2jSYIst8y2wdJJjImS9cEUhbJma/
	kwGnJzVVjwA2ROGvh4VdFaFcRBvhr/OHzjO4uATJ9ffzMARnE55nQatxtbkHy24zt5riQD6OOMH
	x4+IhEwH1GPW+wOIow9YPvVxK4Zzog+n3vbE6fXd2m/VLvyKz7IfsihE+q7Lf2cYSNJpZ3qYwWh
	65sk+PqOJypvw5hFj8aniue8AdALryGleSAS58hu86pmXhoP+G/teu3ipJTkZs6GAU8HcHDaJm/
	qUdM4jCw57UZ2Cvaj92/DGNC2hDzzLulL0eTaNC9ltZHFHFAG1ky4NoVCEJ2XkGopdBeNbRU4
X-Google-Smtp-Source: AGHT+IFmxlbatHKcTfrrBFnxBs3rUY+XByMjhN5ITEoUzWa/Fm/F4lRH3eQ1xuWKmo4CxU3H7kW1Fg==
X-Received: by 2002:a17:903:1ae4:b0:25d:37fc:32df with SMTP id d9443c01a7336-29027402c61mr63029365ad.47.1759955421912;
        Wed, 08 Oct 2025 13:30:21 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f51f:bb9e:9f33:c390? ([2620:10d:c090:500::7:e1e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de54d2sm6278115ad.12.2025.10.08.13.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:30:21 -0700 (PDT)
Message-ID: <09bc63a92ba1c9042d57bf19258e28e3cd00be57.camel@gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe
 fault to BPF stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Leon Hwang	
 <hffilwlqm@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong	
 <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,  linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Date: Wed, 08 Oct 2025 13:30:19 -0700
In-Reply-To: <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
	 <20250927061210.194502-2-menglong.dong@linux.dev>
	 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
	 <3571660.QJadu78ljV@7950hx>
	 <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
	 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
	 <CAP01T75TegFO0DrZ=DvpNQBSnJqjn4HvM9OLsbJWFKJwzZeYXw@mail.gmail.com>
	 <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
	 <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 22:08 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> Since we're piling on ideas, one of the other things that I think
> could be useful in general (and maybe should be done orthogonally to
> bpf_errno)
> is making some empty nop function and making it not traceable reliably
                                                  ^^^^^^^^^^^^^
                                   You mean traceable, right?
		   So that user attaches a bpf program to it,
		  and debugs bpf programs using bpf programs?

> across arches and invoke it in the bpf exception handler.
> Then if we expose prog_stream_dump_stack() as a kfunc (should be
> trivial), the user can write anything to stderr that is relevant to
> get more information on the fault.
>=20
> It is then up to the user to decide the rate of messages for such
> faults etc. and get more information if needed.

