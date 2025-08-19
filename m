Return-Path: <linux-kernel+bounces-776325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4910B2CBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D135A2EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F030F526;
	Tue, 19 Aug 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IMOWd995"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BB22F757
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627953; cv=none; b=mOkfHowIL7VqubpoDpYH3lczB1TMM9IVT/c+gr8dn0OcBNFJUFKP0oM+WrwYwLGP1LauxLarU9ge+6V3IIP6E2Cd2fGdZtU6EH7VY/7SqPPVM6NajxCMlKFWjIWCfpLjeqDoCR2MU9xvN9fJO3B51nFRnN0H3GrQwEbVv9ocKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627953; c=relaxed/simple;
	bh=nGvilOwUg1ObIwVHBF1JacpUkDn9sYUWH3In19bCuK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHP8keULNE1dVBSyesjLO4bU7RnfMRO+I16XtOBuhQknbOcaQ13dM9RiOKQu+9G6kAVfdWmQqTUmYOUSTRk+AdhTdHAzp9CppsiPnZ+xTNulqC0o0ZzJMQUkhafZBXAtiaTMaMpzh7ZAopKFFlh1wffDErJQ7cqEyeYcCQ4RwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IMOWd995; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-88432e6ca05so348261839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755627951; x=1756232751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjcLjUdfx2b5kyu1zQdvPBjWREHanlpzr8pf7Mlw9+s=;
        b=IMOWd995i0eUvcswyHZUn+B/8VsayCr2A6O7aVLoccRYmQG4Z5SQISmPzWqmeUuMkV
         aW8bhPsNihUSm6MtIpvA6kpgorvL96XDkPyD3JPcm62l7iNCosIp+ALnMhQi4TNjcvin
         RZLp887KRsFzJLwnCGQsDKiMelmlpjX0xyW96rt97lNUDZGSthdl44rQvajCR+zMOWGG
         +3OcXkJ2vrZQErmffRG0JqYAWnRx+1EMOQm/PjORCwBS9DYJvYbK97XJKr0gVkbPXDQZ
         P5J8ClfrqnP5NYtFSLI6ynogMr5F7etuxGvaoYUZ+9cxmNrfawOmNfdL1EfpyLKmqx+D
         NcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755627951; x=1756232751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjcLjUdfx2b5kyu1zQdvPBjWREHanlpzr8pf7Mlw9+s=;
        b=lxD3ltU5MnVZd7lN8Vd9fk2Fc2F1yLGFJLXzlB/vAFEA7J+tVV2u7Xot5Ad9rTAkKf
         5Y/R+y3Gt9piQv+8wVmZu5kuo5FG6WA/WZEeO0+5cVm6TwL5c/u6xHROdhyB2Gj2xux9
         UaGR3NVlR316YO/BPgnTC9oPkQTC17fgEjvYoi6HGfl03rKNaIFWaaPQaxUtdavT9JAQ
         TNedy9U1ts+GCYe6g9TLqxF2nimE7Rd4H/5Dx7DyN9oclUMau6zADoqJ1DyxZi/EHmXT
         MaQCu9e4ennihRH3dhH1iZFbH3e59SXwPxrPtWOJwxjvMOh5PLRBHJrPCJWTrn808QuC
         VEPg==
X-Forwarded-Encrypted: i=1; AJvYcCUhCfbZ5b0NzcG1cs5EVM6h7Al7yD096Wej1JhyrETPOkhg2pKzVxvrQrOjiuOYYzgx/4q95GLOpXI/2zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXWBLFgcRydgBzxkWxedOeyCKuRGJ7z0+GTc9IjBY7Kd0wXixv
	KWTi/SOcOliKO/zfG6pax+I58FmmT/dniwc3hNAlBgRdA9ahs7W9CFSclK9jqCglPr0=
X-Gm-Gg: ASbGncv0u8dd2kZPipwwQCAkG2+Mr0Jr0QJmLk0G376J1J4pb6PDAaA1Gegb0YKSn5a
	Vo5tnv9zrdl6x5Sd8sFE3W6j1PbtKz3bcYpBfUtsgY77MtxsB0nOC5UacHYI8s6cjIKfTDqdeCE
	uqeOgtALgy8/PT8YgKGY7qqF9GT5MhHGuHTvIghpMxBpL7rEBLatfvjk9swlNIn87I0n0S5qyzZ
	nhSYk7x10NQvw3d0RvI+PgRKXFeVJgxsuZ7u1FlGRFdJ6NxU/oNzBfz71cbs0AwT4PtCn8vlUi3
	Uaw43EmN5T9/WffPY6XRUQNCN/R4DXBx1qaDCS/SNM809zov24UfSQO0Hkz2KSxAgyL3ftiQMjK
	K3DEZeImLwJsf5OBAl4oby9WG
X-Google-Smtp-Source: AGHT+IE6fqIEj5m/DaNqdyH4siLxHSicGC+isWwpsiSl3g9mfo/W7KkG9POZskmo3mstpG06/kTUsw==
X-Received: by 2002:a05:6e02:2506:b0:3e6:6b01:ebd with SMTP id e9e14a558f8ab-3e67ca2ba4emr1836755ab.18.1755627950635;
        Tue, 19 Aug 2025 11:25:50 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c949f8038sm3584125173.80.2025.08.19.11.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:25:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 13:25:49 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Jimmy Ho <jimmy.ho@sifive.com>, linux-riscv@lists.infradead.org, 
	ziyao@disroot.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, cyrilbur@tenstorrent.com, cleger@rivosinc.com, 
	charlie@rivosinc.com, kees@kernel.org, ben.dooks@codethink.co.uk, jszhang@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: fix using wrong load type
Message-ID: <20250819-aa072701b64fc0f42795e491@orel>
References: <20250819071318.21103-1-jimmy.ho@sifive.com>
 <B1669DA80470EE6A+aKQldVbfZ9rnlD9o@LT-Guozexi>
 <D49B33DEEB859CD5+aKQltEZ8Ef3v6rB9@LT-Guozexi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D49B33DEEB859CD5+aKQltEZ8Ef3v6rB9@LT-Guozexi>

On Tue, Aug 19, 2025 at 03:20:20PM +0800, Troy Mitchell wrote:
> On Tue, Aug 19, 2025 at 03:19:17PM +0800, Troy Mitchell wrote:
> > On Tue, Aug 19, 2025 at 03:13:18PM +0800, Jimmy Ho wrote:
> > > thread_info.cpu field is 32 bits wide,
> > > but is accessed using an XLEN-bit load, which might be 64bit load, fix it
> > > 
> > > Changes in v3:
> > > - replace space with tab to keep it aligned with code block
> > > - Add "Fixes" tag
> > Please add previous version link.
> > 
> > > 
> > > Changes in v2:
> > > - add a comment to explain why use lw instead of REG_L.
> > > - correct commit message
> > ditto.
> > 
> > Additionally, I see a patch here that serves the same purpose as yours,
> Sry I forgot to put link:
> https://lore.kernel.org/all/20250722160556.2216925-4-rkrcmar@ventanamicro.com/

Ah, yes. I forgot about Radim's patch. We should go with that.

Thanks,
drew

> 
>                  - Troy
> 
> > but it's more comprehensive and was submitted earlier.
> > 
> > In any case, if you'd like to proceed, here is the:
> > Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > 
> > > Fixes: 503638e0babf3 ("riscv: Stop emitting preventive sfence.vma for new vmalloc mappings")
> > > Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
> > > ---
> > >  arch/riscv/kernel/entry.S | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > index 3a0ec6fd5956..492ae936dccd 100644
> > > --- a/arch/riscv/kernel/entry.S
> > > +++ b/arch/riscv/kernel/entry.S
> > > @@ -45,8 +45,10 @@
> > >  	 * Computes:
> > >  	 * a0 = &new_vmalloc[BIT_WORD(cpu)]
> > >  	 * a1 = BIT_MASK(cpu)
> > > +	 * 
> > > +	 * using lw instead of REG_L is because the thread_info.cpu field is 32 bits wide
> > >  	 */
> > > -	REG_L 	a2, TASK_TI_CPU(tp)
> > > +	lw	a2, TASK_TI_CPU(tp)
> > >  	/*
> > >  	 * Compute the new_vmalloc element position:
> > >  	 * (cpu / 64) * 8 = (cpu >> 6) << 3
> > > -- 
> > > 2.39.3
> > > 
> > > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

