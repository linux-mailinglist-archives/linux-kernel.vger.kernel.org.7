Return-Path: <linux-kernel+bounces-727694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837CFB01E38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC95A169F78
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BBE2D3EEA;
	Fri, 11 Jul 2025 13:49:30 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABFF2AD21
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241770; cv=none; b=qM9duvSk0fshO0D3F0Ile9H1ywlG+VwRjptX+UITLZ00MB5TfvlHUlfeeRwMndo3b3M3RywZPL3n30FmFUQQPKuxTFnlrJk/wdXOoqnWg4TMsm8yxpWBtcPd3KKsORVGBc8PCLcXXrxhzQ8dhJlvnLXNHdYUDRBlDPS7QnRD2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241770; c=relaxed/simple;
	bh=8Mob01Q5Z9dxEFBzxXAqG6OQCPQrXsQ1ejOxqLhEdOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drqZQTg7zrj25Yd2chmCO34S+Xg5CIDm2eduIVrFq9LHBUpSCX8TLNb3kOHHRB4Vw3ONdpzIfWV8nmPe4zzCF0lOqqwLFmI2hNT20KkqlR+rJUhbnPYC7WjxDI4xkewXf1gCLamOZSacAsHL5ycIqjMalDqcOmvoQBbnoMB3jTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [210.73.43.2])
	by APP-05 (Coremail) with SMTP id zQCowAAXq1tWFnFoLswUAw--.18300S2;
	Fri, 11 Jul 2025 21:49:10 +0800 (CST)
Date: Fri, 11 Jul 2025 21:49:09 +0800
From: Jingwei Wang <wangjingwei@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: alexghiti@rivosinc.com, Nelson Chu <nelson@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Stop considering R_RISCV_NONE as bad relocations
Message-ID: <20250711134909.GA73430@iscas.ac.cn>
References: <20250710-dev-alex-riscv_none_bad_relocs_v1-v1-1-758f2fcc6e75@rivosinc.com>
 <mhng-7CDAD4A1-707B-4ACE-BAF0-643C281B9AD7@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-7CDAD4A1-707B-4ACE-BAF0-643C281B9AD7@palmerdabbelt-mac>
User-Agent: Mutt/2.2.14
X-CM-TRANSID:zQCowAAXq1tWFnFoLswUAw--.18300S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryrCFWUXF1UJrykAw4ruFg_yoW5uF43pF
	W2kw10kF1kCw18XrnFq3W0qr409an5Kw4fWFy8WrWrZ345Zr1Iqrs3K3W3XF9rWwn3tr4F
	va1akr4kJF15AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26F8l6FkdMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07b5nY
	7UUUUU=
X-CM-SenderInfo: pzdqwy5lqj4v3l6l2u1dvotugofq/

Hi all,

On Thu, Jul 10, 2025 at 11:43:00AM -0700, Palmer Dabbelt wrote:
> On Thu, 10 Jul 2025 01:34:31 PDT (-0700), alexghiti@rivosinc.com wrote:
> > Even though those relocations should not be present in the final
> > vmlinux, there are a lot of them. And since those relocations are
> > considered "bad", they flood the compilation output which may hide some
> > legitimate bad relocations.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/tools/relocs_check.sh | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/tools/relocs_check.sh b/arch/riscv/tools/relocs_check.sh
> > index baeb2e7b2290558d696afbc5429d6a3c69ae49e1..742993e6a8cba72c657dd2f8f5dabc4c415e84bd 100755
> > --- a/arch/riscv/tools/relocs_check.sh
> > +++ b/arch/riscv/tools/relocs_check.sh
> > @@ -14,7 +14,9 @@ bad_relocs=$(
> >  ${srctree}/scripts/relocs_check.sh "$@" |
> >  	# These relocations are okay
> >  	#	R_RISCV_RELATIVE
> > -	grep -F -w -v 'R_RISCV_RELATIVE'
> > +	#	R_RISCV_NONE
> > +	grep -F -w -v 'R_RISCV_RELATIVE
> > +R_RISCV_NONE'
> >  )
>
> I'm not super opposed to it, but is there a way to just warn once or
> something?  It's probably best to still report something, as there's likely
> some sort of toolchain issue here.
>

I think Alexandre's approach is ideal from the kernel's perspective.
This doesn't really seem to be a bug; I see it more as a case where the
toolchain's handling of R_RISCV_NONE doesn't quite match the kernel's
expectations.

I found the large number of R_RISCV_NONE relocs only appear in the final
vmlinux. The key difference is the kernel build's --emit-relocs flag
and the *(.rela.text*) directive in vmlinux.lds.S. This combination
forces all relocation entries, including those marked as R_RISCV_NONE,
to be written verbatim into the final vmlinux.

I traced this back to BFD's implementation and found that during
relaxation (e.g., when an auipc+jalr is optimized to a jal), the linker
modifies the first reloc slot to R_RISCV_JAL and marks the second,
now-useless slot as R_RISCV_DELETE. In the cleanup phase, to prevent
reprocessing, BFD then changes the cleaned-up DELETE marker to
R_RISCV_NONE. This is how, when the kernel specifies --emit-relocs,
these R_RISCV_NONE markers get preserved in the final .rela.text section.

To truly change this, it seems to depend on whether the binutils
is willing to add a stage to clean up these harmless but
useless markers.

If possible, I was thinking we could perhaps iterate and remove the
R_RISCV_NONE entries from .rela.text before the alignment pass.

But if there's no agreement on the BFD side, Alexandre's approach still
seems correct and aligns with the psABI, where R_RISCV_NONE has no
operational meaning.

> Also: if you can reproduce it, Nelson can probably fix it.  I'm CCing him.
>

Reproducing the issue is simple: you just need a call instruction to
create a relaxation opportunity, then link with --emit-relocs and a
linker script that includes *(.rela.text*). :)

For convenience, I've put a minimal, self-contained reproduction case
here: https://gist.github.com/Jingwiw/762606e1dc3b77c352b394e8c5e846de

> >
> >  if [ -z "$bad_relocs" ]; then
>

Reviewed-by: Jingwei Wang <wangjingwei@iscas.ac.cn>

Thanks,
Jingwei


