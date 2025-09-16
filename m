Return-Path: <linux-kernel+bounces-818282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8AB58F56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDBAD4E22B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FDE2E9ED8;
	Tue, 16 Sep 2025 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEy/056y"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABDF23507B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008346; cv=none; b=JPQggyz4aPumN1qaLNuaNYa0WF96110tgNpoAW0K+1qqlUBOONhTa7m+quOegS88YWaEhadqAV+9ZKC3Ak9oOQjLQr652BiX7b6uvsYjoThuvHidH16BkxNjMRgSbrEEfh93r0wUhidLds8eFFzMBG2dgYdyQHHyWo4p1EKeAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008346; c=relaxed/simple;
	bh=kmgtCKcaGq1TS6gN6oAVKXRK6ildMc3mt0pNGRwRZ74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En1tSOZPgEO6OWe+r5SqhfZUj50K4T1fW5SGcUytsIZcO0bqqnHZH0exOOc6wGJVnYvM2URlx/PgXg7AUpROHLZoLVQyu5URvTpAiiNcwYfdaLLlFQU4dvRLbDf81uYZdqlFruorgB7ZEmx212nqaZ95Pj2A11XElC4K1EpRW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEy/056y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2fa8a1adso12137965e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758008343; x=1758613143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MRl4H4nkKCFdr5azPJlArKLA0wO/GJIj4KkP3viY6UQ=;
        b=SEy/056ye+DOCLN/SYPytqFIPCYfaKq2rYOToMk9fq5XZ8+3r0bEhsjcavbtvCzezw
         3RdtxvsxyLsYhLrhyw8P/ksGDOMV/ltWriIxGGAiyYswfWVW/XqJBHuGhUu8pLF5NakW
         ab4utn2N5j9JarQ2oy9bz10WGifYvKXvTb535ulpv6euyhIO8qtV2gSfBeU3AGGmM3cI
         SKCct7XNBCDwMEFNGRX/s9p0YEJofWwjgqRBB+TC4IKlAOcQQKV/oU6xTnCXlLbz+kWK
         2EiXaJi8pyp7CJp/hAqPXbAtxeJX8tDN8NftAEWv35oug7400Ey6bhPFj1gzbFRkN4Y4
         LMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008343; x=1758613143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRl4H4nkKCFdr5azPJlArKLA0wO/GJIj4KkP3viY6UQ=;
        b=p+dH+7EFAWAomo/Sbfr9E+U2/irU4uX12Ft9+sGlTBMqC2JCxjx+nVvwPh4U4FLp2W
         qvhU/69MHGNtqs5htRMNp3pWchHVMgKMtMDCp57Ln+xWwri9LHJAks8YmqVyhgdETqYb
         Se05vWjvIxXYkL9Vb1QjSEfzCCJOA5+9kn5SAo2HZ8nAjQB7LS8GcTbYKIVmJEHdPvm5
         +wB+ThEdZRg+Ng0pIgHHz76cZLXIb6okRnKvaH3A9/2E3lwIaj7q6mbMw2pHLydPp0IH
         Y2I0whu8dY3FFSrRapQ68wd+sHdyoI/sKnd6LnL5Nylcj3hQpJEMiw8QJd9c1IsTZYGV
         x8TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDM9mpI4W4c8T6QDpGGU39CiiQaNaDVBUNnGYqhyOl0I31+HDn8vK39J3FlFUO4MOwzysJEv8dA2bgFEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbY0M5A4M/mSqyPZpjS1nrWR5Wd0s/zSd5LGlOK3H+j8qijbl0
	AjSVZjHt5wOQmY2dS2Ax3N77GIqGGboIIDAZOKoAq7zafCoCtcSLsh6M
X-Gm-Gg: ASbGnct0A1CGRJ2T3GSvccfyppVaWapFkwOGUlDNiqDfIF1jzfyWg4ns4PVhwZPmS/T
	S/M0gyajbklkatJ+93R5H8z+FkrVTPFNEKl7LOsTiGnXzHInNsaDcu9YQ8Djc7h5KwvR+2wVHt+
	fSozNNrJfolam63JqFoH27ZBshafJKHsUnVzyF0uumOcHW7+mgBZeUdVSe5OdnWbcAwTOYP3ey/
	e6S2EvMV19g6lLsW3pOHowr3L0qCCqZhjqHYNhJFVoi+u9oEln950yogmcVLz4mqkcMqw4MLIhb
	n4vnfWASMFYaOV5hWSp1hS50MFAPJ5DHwDznRetTUFARDZ80MNSQNw8gES5IvN8Cqt/wbmRLPMr
	74M7/E/Ro+7lrgJ3zl7KCn3Z2tun9fNYE2KADazEK49980UaFgk2HfV410Y4UNa8eZXqEPv7CAa
	V5FYe5U/68H0ZNUrrY+EfdZadzEJEp4sA=
X-Google-Smtp-Source: AGHT+IFIuA/YGnAo2MMqjJ6OKOz5D8aEK5K+VJJantZ/1V3Q0dW2gA0XT5qXdFr3jhNUK3JPrdJnIg==
X-Received: by 2002:a05:600c:c8d:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-45f32d4906emr9146175e9.15.1758008343014;
        Tue, 16 Sep 2025 00:39:03 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e007ab5a3c32e2e7a7c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7ab5:a3c3:2e2e:7a7c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eb35e4fbafsm5922616f8f.41.2025.09.16.00.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:39:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 09:39:00 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH] bpf: verifier: fix WARNING in reg_bounds_sanity_check (2)
Message-ID: <aMkUFNr-0kYLfMNH@mail.gmail.com>
References: <20250913222323.894182-1-kriish.sharma2006@gmail.com>
 <CAEf4BzY_f=iNKC2CVz-myfe_OERN9XWHiuNG6vng43-MXUAvSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY_f=iNKC2CVz-myfe_OERN9XWHiuNG6vng43-MXUAvSw@mail.gmail.com>

On Mon, Sep 15, 2025 at 12:54:20PM -0700, Andrii Nakryiko wrote:
> On Sat, Sep 13, 2025 at 3:24 PM Kriish Sharma
> <kriish.sharma2006@gmail.com> wrote:
> >
> > syzbot reported a "REG INVARIANTS VIOLATION" triggered in reg_bounds_sanity_check()
> > due to inconsistent umin/umax and var_off state after min/max updates.
> >
> > reg_set_min_max() and adjust_reg_min_max_vals() could leave a register state
> > partially updated before syncing the bounds, causing verifier_bug() to fire.
> >
> > This patch ensures reg_bounds_sync() is called after updates, and additionally
> > marks registers unbounded if min/max values are inconsistent, so that umin/umax,
> > smin/smax, and var_off remain consistent.
> >
> > Fixes: d69eb204c255 ("Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> > Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c4f69a9e9af6..8f5f02d39005 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16299,6 +16299,19 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
> >         }
> >  }
> >
> > +/* Ensure that a register's min/max bounds are sane.
> > + * If any of the unsigned/signed bounds are inconsistent, mark the
> > + * register as unbounded to prevent verifier invariant violations.
> > + */
> > +static void __maybe_normalize_reg(struct bpf_reg_state *reg)
> > +{
> > +       if (reg->umin_value > reg->umax_value ||
> > +               reg->smin_value > reg->smax_value ||
> > +               reg->u32_min_value > reg->u32_max_value ||
> > +               reg->s32_min_value > reg->s32_max_value)
> > +                       __mark_reg_unbounded(reg);
> > +}
> > +
> >  /* Adjusts the register min/max values in the case that the dst_reg and
> >   * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
> >   * check, in which case we have a fake SCALAR_VALUE representing insn->imm).
> > @@ -16325,11 +16338,15 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
> >         regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
> >         reg_bounds_sync(false_reg1);
> >         reg_bounds_sync(false_reg2);
> > +       __maybe_normalize_reg(false_reg1);
> > +       __maybe_normalize_reg(false_reg2);
> >
> >         /* jump (TRUE) branch */
> >         regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
> >         reg_bounds_sync(true_reg1);
> >         reg_bounds_sync(true_reg2);
> > +       __maybe_normalize_reg(true_reg1);
> > +       __maybe_normalize_reg(true_reg2);
> 
> We are actually taking a different approach to this problem. Eduard is
> going to modify verifier logic to use the fact that register' tnum and
> range bounds are incompatible to detect branches that cannot be taken,
> and process it as dead code. This way we don't lose information (like
> with the approach in this patch), but rather take advantage of it to
> improve verification performance.
> 
> Thanks for your patch, but I think we should go with the more generic
> solution I outlined above.

Agree with Andrii here. And even without Eduard's approach, there's a
better fix for the specific invariant violations reported here. The
reproducers end with:

  5: (1f) r3 -= r0                ; R0=0x8000050 R3_w=scalar(smin=0xffffffffefffff60,smax=smax32=0,umin=umin32=32,umax=0xffffffffffffffe0,smin32=0xf7ffffe0,umax32=0xffffffe0,var_off=(0x20; 0xffffffffffffffc0))
  6: (2e) if w3 > w0 goto pc+2
  REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0x20, 0xffffffff08000050] s64=[0xffffffffefffff60, 0x0] u32=[0x20, 0x8000050] s32=[0x20, 0x0] var_off=(0x20, 0xffffffff0fffffc0)

We can see that on instruction 5, the smin32 and umin32 ranges can
actually be improved for R3 because they overlap. They're not currently
updated because they cross the sign boundary, so a patch like
00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary"),
but for 32-bits would be needed. Once those ranges are updated, it's
clear the jump is never taken.

We can reconsider this after Eduard's patch lands, but I doubt such a
fix will still be needed at that point :)

> 
> pw-bot: cr
> 
> 
> >
> >         err = reg_bounds_sanity_check(env, true_reg1, "true_reg1");
> >         err = err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
> > --
> > 2.34.1
> >
> 

