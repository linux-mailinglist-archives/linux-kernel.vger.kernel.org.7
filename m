Return-Path: <linux-kernel+bounces-792625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31651B3C6D0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547911CC2801
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16531F0E56;
	Sat, 30 Aug 2025 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAuol+Pf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A62AEFD;
	Sat, 30 Aug 2025 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515194; cv=none; b=cYejZn6rcmYuR0WftjIsptI+dJjrzn/5ymf+6QtkTY/NXxmCVOCwkPEI0v5A0Zbum3PweqCIPw+Kc2mq1DpCVLgbg20SPLd4Gytx2SSBsw1j5WhQjWYyOM3qhrx/YRraH1GgLJP7Xl+PleoJW9jc24f3NtvevemwRCZxAyMNlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515194; c=relaxed/simple;
	bh=4EmD/LJT9GCaWo9JB+Kw/jvyotV9yThSvLCkfBv2+Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP7vIpY1ZNf9R50etN+V418hihqUqKcLOd34oh/SXET9IdqNGNHOQQCCwjSDll8aiEbbSNdZ5WXNQB+lWVtW183qNLpbcHGMgqYWxMjzL5o+ZmqWppKe3MNGriwC2l+Bopg7NbJQ+jLRFfCBL2rgLkca8UBPNaH4JKXIcKmIG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAuol+Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4B8C4CEF0;
	Sat, 30 Aug 2025 00:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756515193;
	bh=4EmD/LJT9GCaWo9JB+Kw/jvyotV9yThSvLCkfBv2+Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAuol+PfS55o1R1f32pdhOULLX8Nn2KGMPKEcTYAyAh5N50fzke5QUy5wa6XNYkFy
	 BECJc9qNaV6xkReyv8+wPt635hZREYfx+UaYT01ByitNs0Im9phNVqz2oaAv+BS4vA
	 6yZnxp7ppwtLeKg4IBqQhW1rjxSJbXQXqzT+pM2clhewMBNPu2GguljuokrashbtVc
	 7f6Jnf1wDBJR13sm3qEseze0HfB3qMYK/Z/YPT4p55M4dB2ZbIz1PqxwKgIzX2tnMz
	 H7u7LxTc2Fk123LuQCQnme6ghEJ6nF8yj3uIcnoVMO7OSIEceZIvVs3W+nN+5ek6/S
	 +GI43Jv2yyncA==
Date: Fri, 29 Aug 2025 17:53:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] perf dwarf-aux: More accurate variable type
 match for breg
Message-ID: <aLJLdzEIGg7tYq6M@google.com>
References: <20250825195412.223077-1-zecheng@google.com>
 <20250825195412.223077-3-zecheng@google.com>
 <aLAC4pKRVyzFR8nZ@google.com>
 <CAJUgMyK2wTiEZB__dtgCELmaNGFWhG1j0g9rv_C=cLD6Zq4_5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJUgMyK2wTiEZB__dtgCELmaNGFWhG1j0g9rv_C=cLD6Zq4_5w@mail.gmail.com>

Hello,

On Thu, Aug 28, 2025 at 02:36:32PM -0400, Zecheng Li wrote:
> On Thu, Aug 28, 2025 at 3:19 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Aug 25, 2025 at 07:54:04PM +0000, Zecheng Li wrote:
> > > Introduces the function is_breg_access_indirect to determine whether a
> > > memory access involving a DW_OP_breg* operation refers to the variable's
> > > value directly or requires dereferencing the variable's type as a
> > > pointer based on the DWARF expression. Previously, all breg based
> > > accesses were assumed to directly access the variable's value
> > > (is_pointer = false).
> > >
> > > The is_breg_access_indirect function handles three cases:
> > >
> > > 1. Base register + offset only: (e.g., DW_OP_breg7 RSP+88) The
> > >    calculated address is the location of the variable. The access is
> > >    direct, so no type dereference is needed. Returns false.
> >
> > I'm afraid there may be cases that the base register doesn't point to
> > the stack.  In that case it may return true, right?
> 
> Hi Namhyung,
> 
> In this case, the DWARF specification for a DW_OP_breg* operation is
> to always calculate a memory address. So, even if the base register
> isn't the stack pointer, the expression still resolves to the
> variable's location, meaning the access is direct (is_pointer =
> false).

I've re-read the DWARF spec and I think you're right. :)

> 
> > I think struct find_var_data already has 'is_fbreg' field.  Maybe you
> > can add 'is_stack' or 'is_stack_reg' field if the target.  Currently we
> > hardcoded X86_REG_SP but it should be arch-dependent.
> 
> Therefore we don't need to check if the register is a stack or frame base.

Fair enough.

> 
> > >
> > > 2. Base register + offset, followed by other operations ending in
> > >    DW_OP_stack_value, including DW_OP_deref: (e.g., DW_OP_breg*,
> > >    DW_OP_deref, DW_OP_stack_value) The DWARF expression computes the
> > >    variable's value, but that value requires a dereference. The memory
> > >    access is fetching that value, so no type dereference is needed.
> > >    Returns false.
> > >
> > > 3. Base register + offset, followed only by DW_OP_stack_value: (e.g.,
> > >    DW_OP_breg13 R13+256, DW_OP_stack_value) This indicates the value at
> > >    the base + offset is the variable's value. Since this value is being
> > >    used as an address in the memory access, the variable's type is
> > >    treated as a pointer and requires a type dereference. Returns true.
> > >
> > > The is_pointer argument passed to match_var_offset is now set by
> > > is_breg_access_indirect for breg accesses.
> > >
> > > There are more complex expressions that includes multiple operations and
> > > may require additional handling, such as DW_OP_deref without a
> > > DW_OP_stack_value, or including multiple base registers. They are less
> > > common in the Linux kernel dwarf and are skipped in check_allowed_ops.
> > >
> > > Signed-off-by: Zecheng Li <zecheng@google.com>

This also improved the data quality!

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> > > ---
> > >  tools/perf/util/dwarf-aux.c | 38 ++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 33 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > > index 920054425578..449bc9ad7aff 100644
> > > --- a/tools/perf/util/dwarf-aux.c
> > > +++ b/tools/perf/util/dwarf-aux.c
> > > @@ -1423,6 +1423,34 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
> > >       return true;
> > >  }
> > >
> > > +/**
> > > + * is_breg_access_indirect - Check if breg based access implies type
> > > + * dereference
> > > + * @ops: DWARF operations array
> > > + * @nops: Number of operations in @ops
> > > + *
> > > + * Returns true if the DWARF expression evaluates to the variable's
> > > + * value, so the memory access on that register needs type dereference.
> > > + * Returns false if the expression evaluates to the variable's address.
> > > + * This is called after check_allowed_ops.
> > > + */
> > > +static bool is_breg_access_indirect(Dwarf_Op *ops, size_t nops)
> > > +{
> > > +     /* only the base register */
> > > +     if (nops == 1)
> > > +             return false;
> >
> > Then it could be like below:
> >
> >         if (nops == 1) {
> >                 int reg = reg_from_dwarf_op(ops);
> >                 return !(reg == DWARF_REG_FB || data->is_fbreg || reg == data->is_stack);
> >         }
> >
> > Thanks,
> > Namhyung
> >
> > > +
> > > +     if (nops == 2 && ops[1].atom == DW_OP_stack_value)
> > > +             return true;
> > > +
> > > +     if (nops == 3 && (ops[1].atom == DW_OP_deref ||
> > > +             ops[1].atom == DW_OP_deref_size) &&
> > > +             ops[2].atom == DW_OP_stack_value)
> > > +             return false;
> > > +     /* unreachable, OP not supported */
> > > +     return false;
> > > +}
> > > +
> > >  /* Only checks direct child DIEs in the given scope. */
> > >  static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
> > >  {
> > > @@ -1451,7 +1479,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
> > >               if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
> > >                   check_allowed_ops(ops, nops) &&
> > >                   match_var_offset(die_mem, data, data->offset, ops->number,
> > > -                                  /*is_pointer=*/false))
> > > +                                  is_breg_access_indirect(ops, nops)))
> > >                       return DIE_FIND_CB_END;
> > >
> > >               /* Only match with a simple case */
> > > @@ -1463,11 +1491,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
> > >                                            /*is_pointer=*/true))
> > >                               return DIE_FIND_CB_END;
> > >
> > > -                     /* Local variables accessed by a register + offset */
> > > +                     /* variables accessed by a register + offset */
> > >                       if (ops->atom == (DW_OP_breg0 + data->reg) &&
> > >                           check_allowed_ops(ops, nops) &&
> > >                           match_var_offset(die_mem, data, data->offset, ops->number,
> > > -                                          /*is_pointer=*/false))
> > > +                                          is_breg_access_indirect(ops, nops)))
> > >                               return DIE_FIND_CB_END;
> > >               } else {
> > >                       /* pointer variables saved in a register 32 or above */
> > > @@ -1477,11 +1505,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
> > >                                            /*is_pointer=*/true))
> > >                               return DIE_FIND_CB_END;
> > >
> > > -                     /* Local variables accessed by a register + offset */
> > > +                     /* variables accessed by a register + offset */
> > >                       if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
> > >                           check_allowed_ops(ops, nops) &&
> > >                           match_var_offset(die_mem, data, data->offset, ops->number2,
> > > -                                          /*is_poitner=*/false))
> > > +                                          is_breg_access_indirect(ops, nops)))
> > >                               return DIE_FIND_CB_END;
> > >               }
> > >       }
> > > --
> > > 2.51.0.261.g7ce5a0a67e-goog
> > >

