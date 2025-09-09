Return-Path: <linux-kernel+bounces-807093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E37B4A01D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AC51BC2375
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0F271A6D;
	Tue,  9 Sep 2025 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+AIDndP"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A954654
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389076; cv=none; b=s1Np9Ap6ZMAdiNWt+NrD4nyMfhK9raPkhhZX72OZ1XYNlimoI5G0OaxTs/yEL1gwHEvNoEWyb2EpqsleVS++VYGPTjamT6ZQxsd1/PV6XBfKcY1gC2loWkrUlmRYBLkciIt3XI615obPP3WLxqwL4K7Nz8Kk/TjFoExNe6o2RbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389076; c=relaxed/simple;
	bh=R9TIjEGBHJvOpzfCva5pnVMZC+c2zPOGBVmYquzb3g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J39KRqqkCrjD+rbvIrEQ98D7L8X5Bgi4ZW2I4gsX6pOjJpegmAHCxf14O6ITDiQxgyt5HaiOR6XMXNpX9pyf6C6EXTpz1sK7iAzmOwrAknPDNeLbh5LTUhJSWtY95iNhA+Z1ZBLrum9hhANoS1y+JljNYe0xSqtO0X2Y7nkaVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+AIDndP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24b2d018f92so566765ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757389075; x=1757993875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9TIjEGBHJvOpzfCva5pnVMZC+c2zPOGBVmYquzb3g0=;
        b=y+AIDndPTckCQEavR14eWmsBAHlmd3rZusObyrgiIq9Ba6gLgG6zjGClsXMdLJpix3
         m8vi2Gffr3aynYzOlg9kL3bXP13mHl96oblNNFFPZXD2n9dmsB/IehrV89dtVcnB1OoI
         l7mBHca3qb3RgdA13UhqZpB5QcbNLLt1SIwaScWkL0oLn4noMNA2y7Z4kZNLEpKHq3lC
         X14ef8qcNzwoS+LTLZbNWaUm3SE6oCQH2eT6gt6HOz7vYeq4OHx9uey7eHfhqzSBs8VO
         QO1ze7Sj1UIt6cqvnJfwd9E5WUljo3LjQXsN+CbVbZBhLKX0aVpTKDcC2SSHPCMONGYl
         uB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757389075; x=1757993875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9TIjEGBHJvOpzfCva5pnVMZC+c2zPOGBVmYquzb3g0=;
        b=n61friKgXpAciLCboCJgZC9FNaA71E71+iEKyPD1NjL0JmVdfq8he1UdrNH2c5XwBZ
         FY4CN+11bN/dnjeuwFpf73KDuGuhfcK8+FiwyaGk0GIvCjJ1YbuEdmdDqh+Vda2PSjTi
         eSd0lG4It7Y+Dc73ujK9JktGnu5O0/frkKKFppzksBPwK3EiS2PY/SmMxJFR8oE1b/69
         /w3M9fpgPrsVYIgEg4BF1qjnE3wmbofpP0VzFfd8022ONJmf1bInlbEWa2BcDmuy02ku
         9wwWqdzyDxX1qQRC2vU5wn3Am17+p812oCDLKussniXYzgj6YPJGdm/WhI6eSmDuCpgl
         Ab8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1JbOpHiIdXmuxCABW1dceWZF6s51wCeJNJBHCP7WPh33LB86kJR8t/cXlbbkx8M0gsUbDJp0Xk1i8Hvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hY1q3eCSKZCNFOwAeaIdH3SUQUEq3K6e/ttSRUoRVgfvY6TC
	zYcaFOj+a2KYmfvaGcEs7FDLdlTn0tkV9P6BobSzSfeZn4+t86RRqdU6aevwI+4vBnWpDFL68cB
	SksH2WnV28VZQK6vevh3WSjor+Nun9ncHDOey97SY
X-Gm-Gg: ASbGncsCakvtSDlVdPRsH3xtnOcuRkHLbP2LuHooo61FYdEwOjdTaFxCgwUI8ArpHxJ
	trBhzVfwEhBjyyEthDHrQGGW1D5Jg8iHz+nGVB+zjuTX91iS85wNP9AueNpMnhJ0P2RW//zOezI
	u+se5y0xEs53DBj8zho7mO9paY4gfFx1OdheTrPHkMOlwN9m/Gt1gMj2zdGjuC3qdntroBeV2Wt
	pkyc86pKQUArO9wGD8AxymJzsF1shSZaMeS
X-Google-Smtp-Source: AGHT+IHZEv7S0yqxnkNuP1W7kwOxLdWIqSFH2fvaOMywvOWjbfZJzlq/tdw95cHtFgBVoXq3Nr8yc9vVu7TDngqITFw=
X-Received: by 2002:a17:902:db11:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-2510f458c5emr9942915ad.0.1757389074383; Mon, 08 Sep 2025
 20:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903172453.645226-1-irogers@google.com> <CAADnVQLkhysjnEsZACK-fgG3XBaHj1FqnhJdu+0V6PCbpKEK=g@mail.gmail.com>
 <CAP-5=fUm0-f6CW1DNKWK0Zv_4Hzqe5oV+d4ajhd3+XMdxXvu2Q@mail.gmail.com> <CAADnVQK_X7PnKwbrmS2sT+oV1ZVYfmnagt_Wi5wg2nO9vt=W6A@mail.gmail.com>
In-Reply-To: <CAADnVQK_X7PnKwbrmS2sT+oV1ZVYfmnagt_Wi5wg2nO9vt=W6A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Sep 2025 20:37:43 -0700
X-Gm-Features: Ac12FXwOEtFt0omQgpq8-1lvJkOwUT-yCFsKqELPXWqu0zjP_pbGE4cRiMZyE5M
Message-ID: <CAP-5=fUVGLiyu8fiuM7P0CG6d9R07pvUq_sfF9WXmJbhatdObQ@mail.gmail.com>
Subject: Re: [PATCH v1] bpf: Add kernel-doc for struct bpf_prog_info
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> Posting a patch generated by AI without proof reading is not ok.
> Wrong documentation is much worse than no documentation.
> If you don't know what these fields do don't add random comments
> to them. Read the code and document based on your understanding.
> Copy pasting AI and throwing it at maintainers to review is inconsiderate=
.

That's not what was done here. An AI has the advantage of reading
mailing list posts and gathering wider kernel context. As the code is
devoid of comments and I lack a fuller picture it was the best I could
do. Were the code commented then I would have just migrated the
comments that are missing.

Here is the commit message that captures what was done:

Recently diagnosing a regression [1] would have been easier if struct
bpf_prog_info had some comments explaining its usage. As I found it
hard to generate comments for some parts of the struct, what is here is a
mix of mostly hand written, but some AI written, comments.
[1] https://lore.kernel.org/lkml/CAP-5=3DfWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQE=
S-1ZZTrgf8Q@mail.gmail.com/

Anyway, you can decide to ignore this patch. Feel free to write a
better one yourself. Take this patch as a bug report in the form of a
patch trying to address the problem. I'm sorry that this has caused
you such a great offense.

Thanks,
Ian

