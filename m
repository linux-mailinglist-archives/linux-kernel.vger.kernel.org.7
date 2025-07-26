Return-Path: <linux-kernel+bounces-746569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1593B1286A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762A0AA4484
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1448B1A704B;
	Sat, 26 Jul 2025 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbgydL2a"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14B14A62B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753492774; cv=none; b=Rt1DJYMYGA/I/jgfgiYtoLtlyPnTJddkjB/K66Q7K6JtdDorxNASmTvuro9ZrpMJsc2FXwjNB0JN927b/558tMukNFNKozVhMpVZ3MrNuN5IJuaECS7st4LmDOi2SqciVIyW9UBcIOFHpIhldcSqJTqYf4LqBK1t3IPl+zC84ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753492774; c=relaxed/simple;
	bh=MNVnAn9lPopswiMaYYvJPW3FqrRZbZlytTwJl/V0hHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+It1SdngWVxN/gRGgdWDcGYIDFLqYm/nKsrn2OF/I+w+YLXUmUHPgD5rl80ohQ94CTuMOkYU8zrifmD2m1jMz1er0ZiVO6MMt3LFWGNoML7Xd02umFugIIFk5kIlV2FtdSufG6mnOjXi/bd0+FoDzqEoMTw+cUuOvTQ0dNhfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbgydL2a; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e389599fso81775ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753492772; x=1754097572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZVdBwsMKuczQR9Eb14UbIMxx5M0fil/YqZ9yzK2ioU=;
        b=KbgydL2aFRegQTzreLXfXSshSgMoP3pJyvPzOBN3csmiZ8/taAsRSE7Q/nstGE/pCi
         UlXqMe7QclmX0Bpb+kpcUZy1LbaYK/AN1oTQonCN1V2Vt8gYiDqCp4Tsa5xSE3jWyBAD
         Ad10LwjkFTvU5xuVMOpp+bCBIX7UIs6HCs5jIDPavz2zHJk5wImB0EHxZ0hjJaslTPuD
         Zl9gbHwKK0PAYYI5vvjZ+EtvfDAMeHxobC1EMsPPpo4cOp0tfooDEB2xWb+OeUWYZciZ
         u2D2ohUoSRv9MGfftoPbY+51LfpRIDPIzbR8PBwVYhHIBPVtHgg6LMctMnUUxipRlayH
         fmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753492772; x=1754097572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZVdBwsMKuczQR9Eb14UbIMxx5M0fil/YqZ9yzK2ioU=;
        b=oAnQjzAij4WzB2cN2mxrBtw14RzWoD76e0bFgFyfQ6DoVbLD6EzZIbl+wsjGb3n31Z
         btaquzVmvEo7VZMc1ZfPFjF0JHSx3JFvfFEQQbzvecQ5mI8rDzvc4Bwf/S3ordXDI74z
         OP+X9pkpfWk4xFpOuVpLujLLJUOqvhPgkEV/Zr9Lu6jbce81z6683G1wzGgmi8RZ0ndD
         RjbY+EKrLyCtrwwWQeU2TWa9XQnG3j/UwN4FYdsW29gg0JUzsnlsgVKpiKB6AJSKbZfH
         gBM0KHOSPYG73wh2HkpAysuDEOt46xWKdbeqgOf9mAf0QDEXfwxQ8VeSXl+AbNavpZE8
         daOw==
X-Forwarded-Encrypted: i=1; AJvYcCX65MFfNCmEPhe67GidNOXkR1/+FNDQL/8/RBUArUo5eYFb8flG5hAyyU0lYS1FnhCkWHT8LT+RxeIS6X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFTA7kvZYHglzjnhUbgg3INF3WZ/xGAvjDTxr+3Fie8pmsR8m
	E2YuAUy2jnPiOuLwGJQzFggTTtk97w7YLYYKE9aSiOUY21YyIrh0QV10bpdaam6Vuhj8ZtkKZsZ
	O43wbDxx5SRbTb4ZxCJho3PZWnqmDN5lxlnU5J/hY
X-Gm-Gg: ASbGncunQD6j8YzLkAbe4dWgSLdPk9JeMFkJE5mkIPVIC0cUgb0fYHlnbWtCRTHy/jh
	yGRXvgoXkvXdX/mqGyHaiYtn7Ci12XYulxgUxEyVt88cJtWHkcOd9kzjAmYE5leWhYuBvMNp+9m
	iB4vuxOkzxkzsy+IWB2lI23SJWQr4HcUdXyIkh/9mCOXumEaNuw2zkVJ7spcRMWzBde5B17xZHI
	edd11mO
X-Google-Smtp-Source: AGHT+IE2KBNQfEYnirio4X2BL59DvsBPRPrHrVtbCtttpSUwFkqwbI1HzyDQ7upg0GF6894GNX2yoSeQvnGUT2+jAmU=
X-Received: by 2002:a17:903:40cf:b0:234:9f02:e937 with SMTP id
 d9443c01a7336-23fc599401fmr718285ad.25.1753492772185; Fri, 25 Jul 2025
 18:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com> <20250725202809.1230085-5-zecheng@google.com>
In-Reply-To: <20250725202809.1230085-5-zecheng@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 18:19:20 -0700
X-Gm-Features: Ac12FXwZdtVe8wo8O-ldHOoXnQDxjvVqsJUQylN-ONGvqKrz8lvYkYCXaQieQbE
Message-ID: <CAP-5=fXyrLbQRSkhbqWWNnuinQ2H7p2wfriEBvp0ZO0AJbdL6w@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf annotate: Skip annotating data types to lea instructions
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:28=E2=80=AFPM Zecheng Li <zecheng@google.com> wro=
te:
>
> Remove type annotation on lea instructions since they are not accessing
> memory. It should be counted as `no_mem_ops`.
>
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/annotate.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0dd475a744b6..0d6f85ab9170 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2729,6 +2729,11 @@ __hist_entry__get_data_type(struct hist_entry *he,=
 struct arch *arch,
>                 return &stackop_type;
>         }
>
> +       if (!strncmp(dl->ins.name, "lea", 3)) {
> +               istat->bad++;
> +               return NULL;
> +       }

Should this be conditional on the arch being x86?

Thanks,
Ian

> +
>         for_each_insn_op_loc(&loc, i, op_loc) {
>                 struct data_loc_info dloc =3D {
>                         .arch =3D arch,
> --
> 2.50.1.470.g6ba607880d-goog
>

