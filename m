Return-Path: <linux-kernel+bounces-879199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA1C22826
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA943A913B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBB53385A7;
	Thu, 30 Oct 2025 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo+/DM8s"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5AB31813A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862001; cv=none; b=sCJ6Mfuj+Xb+btsCk+xidq5wqwrIBlF//HgD6Fksf6qQocBBGZgkzlX3B+9zJAUvXq9pnBYYYgXg8ukNFLSdNtr/zoYgrUg0y8uziQy9tBcJQSbQ1cNpPOufkDe4zwTouo4qtaNBeWqKYUryYQV5KV6EHJpZnQp41jh510sl0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862001; c=relaxed/simple;
	bh=775JFgGFr4UW9VpPzLFJHF884jKX3r9AqaWx6Gn3pb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL7mJjmIE8hUlimPN1ycmUvWZAj94WWgEDsmvYDj2yFw7+tr4FOnXeSaWcSnLIg+09ePhCixpMdkZ487T7sCGKlIVtAf0F+wfKngGnYBYt0LQ4sb17uY6wRAulReXaPuCJWxJpP9lEiA7+2/uU8CxOcVs0pkBwuMgwVLI0PPSKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo+/DM8s; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so220488966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761861995; x=1762466795; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BFME8hHxHQNkuGOVwLthIkcP2SAdz5dPSExiMuGgtdE=;
        b=Eo+/DM8sQgNxm2esBkuL1vDZZQiXDD4CO92UTga2gmS69cjYizZnrYyhKo6GoADoF3
         i7XdnPPR+FAOewXq2tIu/vL/+RKZ/rzeK68kX1RBiglETM+Op+QkNmcD7BlSAPlScSW1
         ZYjQr18qFWo3cUWaRsm49hz45yhX2d6IOifNv5d/5q0RDy2g42spAKVc+kx2iY6hZhZ1
         dlgnB/xHasg5+j/WFDcb9wV/Yt0ZuyyEXbz8rgob+JvXQ877NYG2kYZSS/qCdC1cd+Uf
         kwub+rfHpYU0cXPd/ntHYOeyXlP12g2VeMg20U5lTPNS4bOd6nA2LBl8+NMfD/L7RCYb
         SYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861995; x=1762466795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFME8hHxHQNkuGOVwLthIkcP2SAdz5dPSExiMuGgtdE=;
        b=SemWmYq88JrXUPTj4y/Ixsp2OY8zi6LZfmGFN0GQ0qN9lQKvV01Y7i/cLICDd5spHj
         bo3HoGLFNBUiUme6CdlW9JTdS0nAmQOzvL5Y4ZVA0QqfmJzGo95UqQUeDkW6h2EQPnvl
         DMyjpeeyLB26His8pQQOwKjUY1vbdbX71zaF9x+4kjoLtCq/gCKcXNUVYVJ6zhepwpE1
         jQJl9fTUm54oJ521F+OO9IS9+806Fz/pQohfYpa8wlyluaCP298+myYjzUzHPj7+HASU
         RRLcivbRzTZ9VYX/5owH34O92o4tpxwuujAWgItMFDeNbwyoCIqnQuz/e9067K/8efPg
         Ys4g==
X-Forwarded-Encrypted: i=1; AJvYcCWosJW8E2LYwvusRLU9e7JfWPoBnv0tGs++vqRpGAoF1ekVDnjP95I9ln0DKbxrc5Amm/URb1PKz3Eb4WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtvnHaFeuBiTs3qIkDeaFP9EN++r/lnuFqG02nugeMO8t60q3
	4+3bY6sg5+afII116P0J2YhL0FqD7EcI+Zh/bgnALSz/wzQ/h84MRrMQ
X-Gm-Gg: ASbGncvAoNvzA2DKe1QCuKLhvv00HpCSnRA84DbbqsT8ez4RDptUeyC/vSIs6Qrb3A6
	3TAwHNKoA6jhA7UcZYt+b8RQNDmWoxW5Si0WLRcw0wdHAWeEwThLABQvTvJmtaSXsNjMG/JOYdo
	GL3SSwX9wxytNCI4VixjpnXFl9QTwie6wfd/yQLV6tiJE7qqh8FzsQuLdJ9GZlcMf+i3Z3p+R/v
	UoaLGmnN42Uyb6FxUevzVirxUGkgq+isRKvqGmQmqG8MtiSxngsfm9yIYFR7vEYPgDU3CqxrqgG
	X3DdCMZP9CLZtNn9jyc2EhyxfeUkiD6b+1txLau4yKNaUrp3wchlOqEkbV1vgKE0rIV7j8dqZym
	26OMdYePjbiuEHNOJvCmBLGCPJN8wftZvNcceeDY5gMABX3yXeaS/EvOZPmvTOIqoKPqKU95rMx
	XdvdBB/keiKthvmfdzQTgjRhnOfaA2EtQMfqvKGH52h5Zw4g==
X-Google-Smtp-Source: AGHT+IHySut1aFgKvqA1Hf59IIwmMKdY6To9ybgxV3cQVzl7nyrilXyziJcG/FcMZx/3Wh/PNgYOLQ==
X-Received: by 2002:a17:907:2d25:b0:b3e:5f20:88ad with SMTP id a640c23a62f3a-b70701c3f34mr119156466b.28.1761861995404;
        Thu, 30 Oct 2025 15:06:35 -0700 (PDT)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7067d0f4d8sm174892066b.70.2025.10.30.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:06:34 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:06:25 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
Message-ID: <vi5eesl223u6s3zqb27kyaojnncsro3725escqp2mcrd2mhcbx@hbmfepqluveh>
References: <20251030105242.801528-1-mjguzik@gmail.com>
 <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>

On Thu, Oct 30, 2025 at 10:39:46PM +0100, Mateusz Guzik wrote:
> On Thu, Oct 30, 2025 at 7:07 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > [ Adding Thomas, because he's been working on our x86 uaccess code,
> > and I actually think we get this all wrong for access_ok() etc ]
> >
> > On Thu, 30 Oct 2025 at 09:35, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > I don't know if you are suggesting to make the entire thing fail to
> > > compile if included for a module, or to transparently convert
> > > runtime-optimized access into plain access.
> > >
> > > I presume the former.
> >
> > I think *including* it should be ok, because we have things like
> > <asm/uaccess.h> - or your addition to <linux/fs.h> - that use it for
> > core functionality that is then not supported for module use.
> >
> > Yeah, in a perfect world we'd have those things only in "internal"
> > headers and people couldn't include them even by mistake, but that
> > ends up being a pain.
> >
> > So I don't think your
> >
> > +#ifdef MODULE
> > +#error "this functionality is not available for modules"
> > +#endif
> >
> > model works, because I think it might be too painful to fix (but hey,
> > maybe I'm wrong).
> >
> 
> In my proposal the patch which messes with the namei cache address
> would have the following in fs.h:
> #ifndef MODULE
> #include <asm/runtime-const.h>
> #endif
> 
> As in, unless the kernel itself is being compiled, it would pretend
> the runtime machinery does not even exist, which imo is preferable to
> failing later at link time.
> 
> Then whatever functionality using runtime-const is straight up not
> available and code insisting on providing something for modules anyway
> is forced to provide an ifdefed implementation.
> 

Here is a build-tested diff for bzImage itself and M=fs/erofs on the
x86-64 architecture.

It keeps access_ok() inline for demostrative purposes, I have no opinion
what to do with this specific sucker.

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 8d983cfd06ea..dc3273ac2034 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H
 
+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif
+
 #ifdef __ASSEMBLY__
 
 .macro RUNTIME_CONST_PTR sym reg
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c8a5ae35c871..ce8f6be1964e 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -12,13 +12,14 @@
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
 #include <asm/percpu.h>
-#include <asm/runtime-const.h>
 
-/*
- * Virtual variable: there's no actual backing store for this,
- * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
- */
 extern unsigned long USER_PTR_MAX;
+#ifdef MODULE
+#define __USER_PTR_MAX	USER_PTR_MAX
+#else
+#include <asm/runtime-const.h>
+#define __USER_PTR_MAX runtime_const_ptr(USER_PTR_MAX)
+#endif
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -54,7 +55,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 #endif
 
 #define valid_user_address(x) \
-	likely((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
+	likely((__force unsigned long)(x) <= __USER_PTR_MAX)
 
 /*
  * Masking the user address is an alternative to a conditional
@@ -67,7 +68,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 	asm("cmp %1,%0\n\t"
 	    "cmova %1,%0"
 		:"=r" (ret)
-		:"r" (runtime_const_ptr(USER_PTR_MAX)),
+		:"r" (__USER_PTR_MAX),
 		 "0" (ptr));
 	return ret;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3ff9682d8bc4..5a3d89ed75d1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -78,6 +78,9 @@
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+unsigned long USER_PTR_MAX __ro_after_init = TASK_SIZE_MAX;
+EXPORT_SYMBOL(USER_PTR_MAX);
+
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
@@ -2575,8 +2578,6 @@ void __init arch_cpu_finalize_init(void)
 	alternative_instructions();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
-		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
-
 		/*
 		 * Enable this when LAM is gated on LASS support
 		if (cpu_feature_enabled(X86_FEATURE_LAM))

