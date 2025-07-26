Return-Path: <linux-kernel+bounces-746548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D599CB12805
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F290A587678
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5A129E6E;
	Sat, 26 Jul 2025 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cj5e5XqT"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FB2E36F3
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489819; cv=none; b=nRDtSQGTtUAqNItyfzKiwt3bn4cHoBib0xJq1GkAf9pa8FeKbDmmRsW0LusSjRFgro83xWPyC9ZRcaX/OZsPEF+PpUjBXHgJOolCNFHqzuAt3wSXRKHp0Y4cTmUSTuxwPCX+vLQfeqAScI/F8PJx9pT/XE1GLL/x9lNojpCuM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489819; c=relaxed/simple;
	bh=5VZiPzAk02+Z+u7DWJ3d8mCBiSi0EmcuuRSJYn2qm9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHXf8686GVYCZkKiQe4xjeEXAMCCNPrcTw2gO0T6npYtb3idQFf9WW860yxV5CZJ/UAG/cXWcRRxs34bOlTgQIug8DxECMgFgU41taPGdfZq4tchHtta6twMsIPIWN7JALUfBkqOiaiPTW7b82yVtQzf6sVLODEeHlGQuTWLi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cj5e5XqT; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so41385ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753489817; x=1754094617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FLPFGHXVO+M6lQeuPBeajmfc+gHzdZezLy461FS5no=;
        b=cj5e5XqTcKeVApvk59xCtD+6n20mkeq0pPoV2phbVd9wzN7qF0wshC4+oC+fJojA/x
         Ttf1iHYccwcc/87krctoMLcNoD4KVLvD+2sg0urZ5wQb8yDu4TUgmsTLJLKJ2GF1m/CT
         yX1f7Gi5MSlWhR+H4tfhKmzjA4aAJv1DIbzz7pf3rIQjoaZddXqLvBo4pGz4BPw5BpZq
         DUthpESbJJzQavIRHIJ1mAytmKDeS8wjJrP4jtM+jw2xMsjWI9KGGDNMqPQgtA+KnLT3
         JRrccFYqcGYAItDwLmqjnnPFbD6qLxD4TQuOCes/rL6jIVxrOuk6mAnmjf+4yG97jrkU
         pZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753489817; x=1754094617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FLPFGHXVO+M6lQeuPBeajmfc+gHzdZezLy461FS5no=;
        b=XbReJVkze6mkYXkCSVhDPLX3th7OwKSe+6A22+Ije7Y1NoJGsoGfxUou0dMpoIGDhy
         EBnB3rnw/8QpQAMmfn8y12P46ZP/hB2vNLqOSzguLN3vegzY7pQ7R0HB0xp59Jc5COab
         606Md/Q/oMR5P7qYAMNRejpCTHQ+sZ8xav5QR8O2i48xUdU77GDAB6AoWr6DXAzu/zjA
         AKOHGR1OaHYpwdIsmsAr+tmWCSgX+tSwGRHvYthKxoNIj5opmcgnlkVAHkfk2lL3zXLQ
         CrDvMIwbBP6ttugZY04UehUc7yhtbNobwtbydsJAUXfkvmoURGRL1qSQOMsw4VyIgMvx
         PKfA==
X-Forwarded-Encrypted: i=1; AJvYcCVDrmapoA5d5qtbpgcRK/vTx0U8MsGaAexbCHIJBNh1I+ttabd04aJRgXvVYGtdB/VjuoEcjTJ8QDS2s/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOJv9uskvAJL6cQ1Up6bIiV86fShJAHC4ZwCkVaWBBZAtUeRb
	V9zI4GzdAuN8ICKv01YAbpPW7dpvwte4MmgrRT5/RDyqMpD15b5DJV526ms+h6thoIFjcqDdMn7
	kqRNk5PaUppB5l6wqyvj3uyGFgwUoSFYTAPznXEVp
X-Gm-Gg: ASbGncuS8qROnMYt6OmHogFkuGjTcvzOREVudtB/3QidqabY9FF6736rgn4zqa4BBXV
	dmafse+jGnP2V41JP0J2rquGt9Rby1vmBSFsuEmi+32Upo/VD/swAB30utaqRxyeRPPSGMBdEtx
	SCOPlpu5PiaSJJQNF7/05RMgH5M9a0JYlOltnkrdd3UjJPh57uwhZHrKqiNJggmA0dX3cdruMbb
	mzPjts7
X-Google-Smtp-Source: AGHT+IEKbaGdaud57btGyC8P7efLaOwq5P86iPcR7HobckPzULoLUGLjsjSvgvmW+f+wDNGNbCbt4jUgQKIYpKtKBA0=
X-Received: by 2002:a92:c249:0:b0:3e1:eaf:3d48 with SMTP id
 e9e14a558f8ab-3e3cbf76627mr1743835ab.4.1753489816811; Fri, 25 Jul 2025
 17:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-5-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-5-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:30:04 -0700
X-Gm-Features: Ac12FXxBOo_Y2Pp_nCCqNn85Oau1WrRBF3-bt-lIx4Tt5Hsl_uAnLJ4qW2KUHe0
Message-ID: <CAP-5=fUM=1paD_3morMnz_6m8WWE8pmN0sC27xPanbp3FWYtjQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] perf annotate: Simplify width calculation in annotation_line__write()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The width is updated after each part is printed.  It can skip the output
> processing if the total printed size is bigger than the width.
>
> No function changes intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index c21152710148b68c..d69e406c1bc289cd 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1993,6 +1993,7 @@ void annotation_line__write(struct annotation_line =
*al, struct annotation *notes
>                                            symbol_conf.show_nr_samples ? =
"Samples" : "Percent");
>                 }
>         }
> +       width -=3D pcnt_width;
>
>         if (notes->branch) {
>                 if (al->cycles && al->cycles->ipc)
> @@ -2056,11 +2057,12 @@ void annotation_line__write(struct annotation_lin=
e *al, struct annotation *notes
>                         obj__printf(obj, "%*s", ANNOTATION__AVG_IPC_WIDTH=
, bf);
>                 }
>         }
> +       width -=3D cycles_width;
>
>         obj__printf(obj, " ");
>
>         if (!*al->line)
> -               obj__printf(obj, "%-*s", width - pcnt_width - cycles_widt=
h, " ");
> +               obj__printf(obj, "%-*s", width, " ");
>         else if (al->offset =3D=3D -1) {
>                 if (al->line_nr && annotate_opts.show_linenr)
>                         printed =3D scnprintf(bf, sizeof(bf), "%-*d ",
> @@ -2069,7 +2071,7 @@ void annotation_line__write(struct annotation_line =
*al, struct annotation *notes
>                         printed =3D scnprintf(bf, sizeof(bf), "%-*s  ",
>                                             notes->src->widths.addr, " ")=
;
>                 obj__printf(obj, bf);
> -               obj__printf(obj, "%-*s", width - printed - pcnt_width - c=
ycles_width + 1, al->line);
> +               obj__printf(obj, "%-*s", width - printed + 1, al->line);

This doesn't seem to line up with the commit message, should width be
updated prior to this call?

>         } else {
>                 u64 addr =3D al->offset;
>                 int color =3D -1;
> @@ -2112,9 +2114,11 @@ void annotation_line__write(struct annotation_line=
 *al, struct annotation *notes
>                 if (change_color)
>                         obj__set_color(obj, color);
>
> +               width -=3D printed + 3;

nit: For constants that like '+3' here and '+1' it'd be nice for a
comment just to say where the adjustment comes from.

Thanks,
Ian

> +
>                 disasm_line__write(disasm_line(al), notes, obj, bf, sizeo=
f(bf), obj__printf, obj__write_graph);
>
> -               obj__printf(obj, "%-*s", width - pcnt_width - cycles_widt=
h - 3 - printed, bf);
> +               obj__printf(obj, "%-*s", width, bf);
>
>                 (void)apd;
>         }
> --
> 2.50.1
>

