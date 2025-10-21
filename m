Return-Path: <linux-kernel+bounces-862434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D61ABF5478
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0856467A66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839F0307AE1;
	Tue, 21 Oct 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkcFdEM9"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4429617D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035631; cv=none; b=U1boPJa6HwWLSOYRZ3EVJlil3C6+cVOx+LmiBQqyZHmV9w47IiaUOwxYXqqmX8ZQkwCV3abpiLLQcR2fm8gSJkOO5r6nB0C7rDtKsNCRSvAND6KPOaDI5/0BwsAFZUGh2XyqPzvH771L5VV91wjE9X4OYH6vVGuGey+ZJ7Pk4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035631; c=relaxed/simple;
	bh=sC9XWrnBE3t7CWsd+EUC6s+rW0xvjJOyGukU/qizeVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwgmF6cVN7/9SJiCkNUNBPmlE82jgxeFWridpal2z4wp9ZMnBBifarmXoKZmPQELhGL/XQUftezjBZMDpSoF1Axnb+t2hV1Y2EEFmsuZYgwLKoVDf+/B5FzG7Bbfru0oIlMyb5ASxivwJM+7geDm4juV7KUmRwsN0c3e8UGQGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkcFdEM9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso7935273a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761035629; x=1761640429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyP++HOcnM7lkmBraj+8ZhnO1B17TMRPQ7N0T27aqTI=;
        b=QkcFdEM941FvSGgVKR6mAUYEOJNo0jtZlbyrMg6OLyfOkykbA6xhriNopFiQBv3IZy
         OyM2B+S0YJFYG2s454TXEC8YNMZB0n6GOk6oFBtO3shjrb4VY+UppC+66pTatdLFjizg
         1LC9jcf8j3Du4/UVggTO7p5UnSz/9P+LJOQC8yLVBVZZx4pASRe92ahe2LDZ0y1BM2do
         c5j9poEaFu26Z5ft4VSZ8WZJtg4zgTGT3+xHkJ2dMGCDfPmKZuIWBsDqOroBz3/cwuPR
         vAsQAYvtUecTgi+uIQcKcLRo3RfUDPNHHw10ltI2R5SuTqH0Abm5G2nJPvb5fnum22ri
         cVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035629; x=1761640429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyP++HOcnM7lkmBraj+8ZhnO1B17TMRPQ7N0T27aqTI=;
        b=g2rZGT2xFZtginTEYJW54Ujy5307ayGTTFPSeh7GZ+iD89D1cme8PQzTt9dw400U8Y
         BDrGK2+aqt5fPUKvUBHqtUyPLqoj/nrlEBJ55r9Y4nuZu4fXHOEfLxe69LE52ZPMFy13
         jMxSR127ECyCX/6cxcemqTXeNtRRqkHiTf7cA2QyvwxA7DnvL911PiSvvUCvEgfFu5bq
         vb8+e6MUdea8/5+pqevZ6rKNYZLNl7VTLJrhbEIn1+RLQ2Rh9LtAIzTJcxXPfajYMxgl
         Q8UDCCY5B47Ufl8XZE9G1H4U8DKLNu8mKFkDUDmg8FFWkTWYLXIOzYbvvFa5aA2/slaY
         ZjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxNeeIhpal16tZjyxKi/fGYDbq1lhwmXOUMon1+hLot8i+zoUrvp6h6lun7K/r3WXuVHw6d2f7FDwA8gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRkdEX7HuMyKXMYYbMhkXfztvm83miVHirdFMRB6DoBvHIAsB
	N+dWHpA/aNjiNr9u0cm9ehEcILP9SnzClUG5/vyVSwY0M/xcZXT1GSFT5aoLj58gmiRWQGzUC6D
	YjK6SWUXVyyng+OwVBZultvcTZZj3id0=
X-Gm-Gg: ASbGncv2k27Kr6lF0VCVdDUlArMQzvD5zBWA08QK1Zupsw6UzzGuhOjGidbP9d+sMzX
	PadOOvnRLluqcTB2lgbyYJWbJIrW9xidvpmtZTVFFFeszUoPBJJpqhmt8Ei409aEgzV2bgD1G3/
	tRRGRaikMS2oQTxxlYIj2J++f7J9vvCVdxp/pyEPsM2BF2Ifc6RFLId+iaU87dqOCUULVV2qbAH
	epzcHC8VKAtoSqIlIkoImSco5oP1v2hYyhLdbXgSJ0eOPqhkI+kIzoLj8Yp2Q==
X-Google-Smtp-Source: AGHT+IH/pE5ik6MMElYZe3UMIK5tnAihJXbcXEyKiU+GhEhSlSbJSIbTy2jEhjI6EnSJJeysRC1LrRzMS8mFAq/utIA=
X-Received: by 2002:a05:6402:5247:b0:63c:4d42:9928 with SMTP id
 4fb4d7f45d1cf-63c4d429ba7mr10190315a12.7.1761035628426; Tue, 21 Oct 2025
 01:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-6-dolinux.peng@gmail.com> <f7024fc31ccc9c8b8bdfe2865cdf3604079e0039.camel@gmail.com>
In-Reply-To: <f7024fc31ccc9c8b8bdfe2865cdf3604079e0039.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 21 Oct 2025 16:33:36 +0800
X-Gm-Features: AS18NWDhGggOjJO_tD-qLkRT-BVTimxKtqYZ4e3A7X_roKbqerQg19kh8xI5vfY
Message-ID: <CAErzpmt8HOfZUtYSbmemvpwKO7=Y79ffJo--tLaEsHFUQCRtmA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] btf: add CONFIG_BPF_SORT_BTF_BY_KIND_NAME
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
>
> [...]
>
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index eb3de35734f0..08251a250f06 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
> > @@ -101,4 +101,12 @@ config BPF_LSM
> >
> >         If you are unsure how to answer this question, answer N.
> >
> > +config BPF_SORT_BTF_BY_KIND_NAME
> > +     bool "Sort BTF types by kind and name"
> > +     depends on BPF_SYSCALL
> > +     help
> > +       This option sorts BTF types in vmlinux and kernel modules by th=
eir
> > +       kind and name, enabling binary search for btf_find_by_name_kind=
()
> > +       and significantly improving its lookup performance.
> > +
>
> Why having this as an option?
> There are no downsides to always enabling, right?
> The cost of sorting btf at build time should be negligible.

Thanks, I'll remove this config option in the next version as suggested.

>
> [...]

