Return-Path: <linux-kernel+bounces-790551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA8EB3AA1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F214B988129
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392372773C4;
	Thu, 28 Aug 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNw98LZ8"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0D2765E9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406208; cv=none; b=aJeproc/a78uqc8sTcqopRZnA9Ybi4ZXwGfBjWb2+sKtuxnTo7U0uSZgsdtx27tz5CkaBlKLy4gNp00l9jnLsxtwa+iTES9CYpgldwwwu8IHLVSXYWtqQ/mTkEClY/XRrnKtxIxl+cH9BDpTvu7ES0njprRlOTj22M+kn43Rl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406208; c=relaxed/simple;
	bh=bvhPWX3894/1cLC+TB+lwb7jSVxlvq91YvDHkvtjR5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmV7v3oEF1NHSbaYAzv4zFEkMVaOmkSTO7W+suuWpytB7e8jW4L02M1ont4ioiassUP1UcgsD3AKMHY2UH1vcsbmeASnG/HVtW5/68ZTc22YXNNP0h7ZGP5FADDALi1if9nekCJA+McxpS3+pVH1gooMgtrpM13GhXe8QB/awQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNw98LZ8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a16441so187136866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756406205; x=1757011005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHW66vik/XOF/b5a9eA0c5HxElogAXhATll56cjYuUc=;
        b=iNw98LZ85Mpd5Q8SMSlr4EgeGQ0zY130a2bpfQ2GMaYcnoZJivH+CX6Mp+WthPCP77
         iW71PlTySqzBibHZz1fpci1oGDniPwzOEhxkgocMIwqIXfwwARCjoyMj/snLPs2Y3wX+
         ex8yJubWcb+H/eZBspCGWaFYh1OxV98AWLNLbeQjhIlsjzwpccB0bQbSCrjnfVX0ek8o
         0+fmHxboXx4PxNCm6ZE4j3wIi6RErpbB97j+a7G6HB1M94dDWy1gAInzDqGiwJe0nc5R
         HyEmqYO8QFMS6Lm2tj0OCAfJ1NOLEJO8cYEynZtxhhVHdw16dK6SBN7ItvwrQg1mjSGd
         NKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406205; x=1757011005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHW66vik/XOF/b5a9eA0c5HxElogAXhATll56cjYuUc=;
        b=ZSB+W48GAs8rUhfKz45KobdrXlEdG8MIwJz7gIlVJCNKHV7XVn9ds6aL6Bqi3cx2fb
         CQilr+ohUXF0S7drq+HjWwuMJX3lfovzV4A4GmDhvZTdu41xqzVgNOug8DmjQ4o5zA/W
         JPfHYHzYffSjMx12mnRakTbF7T6Xwp2AUvu6GqO0UCWZ6qsellOiqpe9EJimdxjwmvzY
         Elk5vp2E1HYKYDjDqkXsN4hy23J1n7ARLq8Qq0cM3W3N+pdm/akRfDf2Ny+EBa/AxmaV
         dRTr/cSt5EgjN+II0a6j4dTJV/Vyn3ElfWF3R1gY4MpxC67HR/DUI7t2m6BbR5FZaFI9
         lNMw==
X-Forwarded-Encrypted: i=1; AJvYcCWfxhv290dQEUL7byCE9xx1Wwud4fHnp0XIIRHUyrq6/35ulTE2S3ON0PZVPW3cBwtkpBofiDpbuU6u72Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUM8gOzjLWdBEPD4TBcEBzMoeQ+KU2+49xUAjoO/QcQ2GPdoDp
	EqhQ8rnR+vTB41Hn8ZtVySf39oYSCtp0V6r2nQka9rDIbpvMLyLZdmBRvc/hZ8A1vlWeBdxAlV6
	ywMyGOZnsyBzn19NSVGjAl5PifJSknaJbpVzEt1PH
X-Gm-Gg: ASbGncuMcUma969L1h/Q6TzEqvQaSv9TOIqiG3pDA/DWUpJxVbrG2UlVsi4OOJpvITd
	F7YXIGl8vQ1Fq+zIwICftKRsIakOL/2yIOV3rWYbkkUaOpHujoudu0q4ush3m9iIA0jp/ZAckIW
	Z1fSgYcDsu0VXcNBirQWlc5ont5rdpib4bEbF66mSdPED6WBZjfKzadpc3+WaHjACDTk0JRvU8r
	+YRNbL6OJlNIXoC60zNGZoSZwVj59y8JxtYS+615zXMhbTP8Z92J1L0Uoe1HCyikw==
X-Google-Smtp-Source: AGHT+IGMiMWlNBMZzKgGFJuPkN5U8PL7qDthlThh6NkESps4kFZfJXlrZ3T4dW9Uddef46UXYdRba/Pa4HgyNIMDCFk=
X-Received: by 2002:a17:906:8f8a:b0:afe:c2e7:3709 with SMTP id
 a640c23a62f3a-afec2e7433amr686859166b.18.1756406204609; Thu, 28 Aug 2025
 11:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195412.223077-1-zecheng@google.com> <20250825195412.223077-3-zecheng@google.com>
 <aLAC4pKRVyzFR8nZ@google.com>
In-Reply-To: <aLAC4pKRVyzFR8nZ@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Thu, 28 Aug 2025 14:36:32 -0400
X-Gm-Features: Ac12FXyOmG6qOzijGmOY98Fs0TzVvdyjlqP-oeOBptUFoEa_KQU99z-KiieCows
Message-ID: <CAJUgMyK2wTiEZB__dtgCELmaNGFWhG1j0g9rv_C=cLD6Zq4_5w@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] perf dwarf-aux: More accurate variable type
 match for breg
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

On Thu, Aug 28, 2025 at 3:19=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Aug 25, 2025 at 07:54:04PM +0000, Zecheng Li wrote:
> > Introduces the function is_breg_access_indirect to determine whether a
> > memory access involving a DW_OP_breg* operation refers to the variable'=
s
> > value directly or requires dereferencing the variable's type as a
> > pointer based on the DWARF expression. Previously, all breg based
> > accesses were assumed to directly access the variable's value
> > (is_pointer =3D false).
> >
> > The is_breg_access_indirect function handles three cases:
> >
> > 1. Base register + offset only: (e.g., DW_OP_breg7 RSP+88) The
> >    calculated address is the location of the variable. The access is
> >    direct, so no type dereference is needed. Returns false.
>
> I'm afraid there may be cases that the base register doesn't point to
> the stack.  In that case it may return true, right?

Hi Namhyung,

In this case, the DWARF specification for a DW_OP_breg* operation is
to always calculate a memory address. So, even if the base register
isn't the stack pointer, the expression still resolves to the
variable's location, meaning the access is direct (is_pointer =3D
false).

> I think struct find_var_data already has 'is_fbreg' field.  Maybe you
> can add 'is_stack' or 'is_stack_reg' field if the target.  Currently we
> hardcoded X86_REG_SP but it should be arch-dependent.

Therefore we don't need to check if the register is a stack or frame base.

> >
> > 2. Base register + offset, followed by other operations ending in
> >    DW_OP_stack_value, including DW_OP_deref: (e.g., DW_OP_breg*,
> >    DW_OP_deref, DW_OP_stack_value) The DWARF expression computes the
> >    variable's value, but that value requires a dereference. The memory
> >    access is fetching that value, so no type dereference is needed.
> >    Returns false.
> >
> > 3. Base register + offset, followed only by DW_OP_stack_value: (e.g.,
> >    DW_OP_breg13 R13+256, DW_OP_stack_value) This indicates the value at
> >    the base + offset is the variable's value. Since this value is being
> >    used as an address in the memory access, the variable's type is
> >    treated as a pointer and requires a type dereference. Returns true.
> >
> > The is_pointer argument passed to match_var_offset is now set by
> > is_breg_access_indirect for breg accesses.
> >
> > There are more complex expressions that includes multiple operations an=
d
> > may require additional handling, such as DW_OP_deref without a
> > DW_OP_stack_value, or including multiple base registers. They are less
> > common in the Linux kernel dwarf and are skipped in check_allowed_ops.
> >
> > Signed-off-by: Zecheng Li <zecheng@google.com>
> > ---
> >  tools/perf/util/dwarf-aux.c | 38 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index 920054425578..449bc9ad7aff 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -1423,6 +1423,34 @@ static bool match_var_offset(Dwarf_Die *die_mem,=
 struct find_var_data *data,
> >       return true;
> >  }
> >
> > +/**
> > + * is_breg_access_indirect - Check if breg based access implies type
> > + * dereference
> > + * @ops: DWARF operations array
> > + * @nops: Number of operations in @ops
> > + *
> > + * Returns true if the DWARF expression evaluates to the variable's
> > + * value, so the memory access on that register needs type dereference=
.
> > + * Returns false if the expression evaluates to the variable's address=
.
> > + * This is called after check_allowed_ops.
> > + */
> > +static bool is_breg_access_indirect(Dwarf_Op *ops, size_t nops)
> > +{
> > +     /* only the base register */
> > +     if (nops =3D=3D 1)
> > +             return false;
>
> Then it could be like below:
>
>         if (nops =3D=3D 1) {
>                 int reg =3D reg_from_dwarf_op(ops);
>                 return !(reg =3D=3D DWARF_REG_FB || data->is_fbreg || reg=
 =3D=3D data->is_stack);
>         }
>
> Thanks,
> Namhyung
>
> > +
> > +     if (nops =3D=3D 2 && ops[1].atom =3D=3D DW_OP_stack_value)
> > +             return true;
> > +
> > +     if (nops =3D=3D 3 && (ops[1].atom =3D=3D DW_OP_deref ||
> > +             ops[1].atom =3D=3D DW_OP_deref_size) &&
> > +             ops[2].atom =3D=3D DW_OP_stack_value)
> > +             return false;
> > +     /* unreachable, OP not supported */
> > +     return false;
> > +}
> > +
> >  /* Only checks direct child DIEs in the given scope. */
> >  static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
> >  {
> > @@ -1451,7 +1479,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_m=
em, void *arg)
> >               if (data->is_fbreg && ops->atom =3D=3D DW_OP_fbreg &&
> >                   check_allowed_ops(ops, nops) &&
> >                   match_var_offset(die_mem, data, data->offset, ops->nu=
mber,
> > -                                  /*is_pointer=3D*/false))
> > +                                  is_breg_access_indirect(ops, nops)))
> >                       return DIE_FIND_CB_END;
> >
> >               /* Only match with a simple case */
> > @@ -1463,11 +1491,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die=
_mem, void *arg)
> >                                            /*is_pointer=3D*/true))
> >                               return DIE_FIND_CB_END;
> >
> > -                     /* Local variables accessed by a register + offse=
t */
> > +                     /* variables accessed by a register + offset */
> >                       if (ops->atom =3D=3D (DW_OP_breg0 + data->reg) &&
> >                           check_allowed_ops(ops, nops) &&
> >                           match_var_offset(die_mem, data, data->offset,=
 ops->number,
> > -                                          /*is_pointer=3D*/false))
> > +                                          is_breg_access_indirect(ops,=
 nops)))
> >                               return DIE_FIND_CB_END;
> >               } else {
> >                       /* pointer variables saved in a register 32 or ab=
ove */
> > @@ -1477,11 +1505,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die=
_mem, void *arg)
> >                                            /*is_pointer=3D*/true))
> >                               return DIE_FIND_CB_END;
> >
> > -                     /* Local variables accessed by a register + offse=
t */
> > +                     /* variables accessed by a register + offset */
> >                       if (ops->atom =3D=3D DW_OP_bregx && data->reg =3D=
=3D ops->number &&
> >                           check_allowed_ops(ops, nops) &&
> >                           match_var_offset(die_mem, data, data->offset,=
 ops->number2,
> > -                                          /*is_poitner=3D*/false))
> > +                                          is_breg_access_indirect(ops,=
 nops)))
> >                               return DIE_FIND_CB_END;
> >               }
> >       }
> > --
> > 2.51.0.261.g7ce5a0a67e-goog
> >

