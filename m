Return-Path: <linux-kernel+bounces-748377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56803B1406D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931873A89F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75C1273D95;
	Mon, 28 Jul 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vVFi66ti"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA3273D6F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720661; cv=none; b=l3Wje249iKXkjBF6QlN1wleCF+J0pUuiqts9yI6k8FZnJv9T5nAX7dsIcPaY3iVzuxYZHjwLJ8x/uf98/mhEZX8Qd5X9Lvl33tFxA9GHCyxleAfZ9GZdfdlcEki/r/2OEKuxBnXj3weFOVEg4Js16Gvir5Hk0x+m/pd83EyVBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720661; c=relaxed/simple;
	bh=2SCBpxMSnr0Udt96N/nYsntgpWGEdtVpMjRq+5bF/Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcFFUtgm5tO1JgoekyZavvP3oQdglvSVQEMdJTO4V22GUmm5xIsSNeD8F/v9d+uhQ+ktUzbEsA40n5khnA/tcQgY8Wya+gRPx4h6086VY0jmOPO5XPHZ9hG2b9LhQtyY+GPiSHCjyngKQ1iEDXCAth0dI28OiHe3gQg2z+yriQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vVFi66ti; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2403df11a2aso8049805ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753720658; x=1754325458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5q5M+CpT+5kwmRPJ46tyAoXGVagM73LO6ZWHv96bYmU=;
        b=vVFi66tiWkkBaX51T0jP0+PE1SzQWHC6EG7d1SVIMWrkF2yBdpIlKC3y3RISdPsAXx
         flcnb8zEyYmHB4neYpKWddQK7ecUX2I94Ug+w6kTsJq0ghJsZYgBozyi/vHTVvx1Q2y8
         KA0NBn3KpFhFBm9hMWKM47COZ/YgXeE2Uftzc/WwMVYiPjQu5ASRUGzCzwwesTr+3Pne
         vZoMIyMF0epLbh2hyNVUhhiwyayfrbp+L348YyW4gOEKEKw9s8M8pkZmNFQnPoqO5CW5
         NkY7BdvWrxnU9lsmY5jAI3cFu/MX5mKL1XYaw7JCOMF+nT7Sr6Yh/NBCv4sli2t495oG
         YRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753720659; x=1754325459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q5M+CpT+5kwmRPJ46tyAoXGVagM73LO6ZWHv96bYmU=;
        b=OGmUZs7AGtLt05DmC426v0kDbsQIG4I3poRpvGLEnyP4wBsHs25ayNKfp77YjDL+pM
         lSfMv09l31z6GwIE9lHNIs8RwbzTPPm2q3ZgWp4u7R6NwqIeAmDRKRAGor8xVbtP0FOr
         QcM7negPdeSW6AAEQNfbZLeYzHhg8Mav4Pwc7YLO4akThh1yQgDi7Q+8zUVHCk+qiyMV
         GWwAjk40mIATrFMf5U1FjaanhU545Wyre/KE73N2BuU84T00G7Dw6jPNKweou5RZuhQ0
         T/jrVO6dOUI/k3bWI16lLsUO4IasmxZpUrDGGRnu20nGEludeXRQhUqCLkbQFGNs/M2O
         z4mA==
X-Forwarded-Encrypted: i=1; AJvYcCW2KhBtXuTlbCU4t5fiUWLh2kcOFfG1JkDcVkJKVqrUodcBDQcYeADabSIKjEhGTMwfusC/Fcz5oEys3Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/5mUzcJalKoE5Vc+Q11AbvZbaFT4NXHdeoBSGDx9NVE/Jjyv
	MdtlubpMN44ZiOMMCnsEWRSaQkup3cbh23ZLgXhENI0BiMQyyQgkV+e4ZDDppwEOlgs=
X-Gm-Gg: ASbGncuSp1GdIfQcn0d5vcIBZ/Bedq8cOFGDRWDCD8gKDVs0VR3XQpnf4PrZcFwRFIW
	f/y8E4MlH4f943DGKB3tQALYXx2L699nzt3ab5nS6Yb/Is2Sc/Q27eJ+4Rv+J24L95xW2dPMtAi
	FtAY0lLsUNfp7w0oEYwn8VX30atKc7+Bv6gJawuASOvMXRi95UKSTHXXrgRLGADXcLPJ/IZZkUs
	UKzdvImo5WXSN1J+q8KaUMJSzsqwkcEnXcD8rK5l+nhkJ+gIYvGkJh0HLK6p9QEURzTyO0WZzyo
	0HFzhtI2KfY6RSJ2v4jSlItJ/cgpSpkYS1IRN6SPayPeEf912YLqLP0i/zINjBZL/yPpMCyOTeB
	MtGTZd9fVmxOm+0pe45eKBcLvnO6222IJ
X-Google-Smtp-Source: AGHT+IG8PkXREALt2B41+CkCZk4vD0+tX/pzcMfIzczJ6dwSMXqtKdHnRzA6w8eQHSP6Yq5Aix/U2Q==
X-Received: by 2002:a17:903:1111:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-23fb30cd1f9mr182480625ad.35.1753720658505;
        Mon, 28 Jul 2025 09:37:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff3ea7547sm40412335ad.149.2025.07.28.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:37:37 -0700 (PDT)
Date: Mon, 28 Jul 2025 09:37:34 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Will Deacon <will@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Monk Chiang <monk.chiang@sifive.com>,
	Kito Cheng <kito.cheng@sifive.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
	llvm@lists.linux.dev, rick.p.edgecombe@intel.com,
	broonie@kernel.org, cleger@rivosinc.com, apatel@ventanamicro.com,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	charlie@rivosinc.com, samuel.holland@sifive.com, bjorn@rivosinc.com,
	fweimer@redhat.com, jeffreyalaw@gmail.com,
	heinrich.schuchardt@canonical.com, andrew@sifive.com,
	ved@rivosinc.com
Subject: Re: [PATCH 10/11] scs: generic scs code updated to leverage hw
 assisted shadow stack
Message-ID: <aIenTs_D4l414isp@debug.ba.rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-10-04b8fa44c98c@rivosinc.com>
 <20250725161327.GC1724026@google.com>
 <aIdxUpSc-Co8wLYE@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aIdxUpSc-Co8wLYE@willie-the-truck>

On Mon, Jul 28, 2025 at 01:47:14PM +0100, Will Deacon wrote:
>On Fri, Jul 25, 2025 at 04:13:27PM +0000, Sami Tolvanen wrote:
>> On Thu, Jul 24, 2025 at 04:37:03PM -0700, Deepak Gupta wrote:
>> > diff --git a/include/linux/scs.h b/include/linux/scs.h
>> > index 4ab5bdc898cf..6ceee07c2d1a 100644
>> > --- a/include/linux/scs.h
>> > +++ b/include/linux/scs.h
>> > @@ -12,6 +12,7 @@
>> >  #include <linux/poison.h>
>> >  #include <linux/sched.h>
>> >  #include <linux/sizes.h>
>> > +#include <asm/scs.h>
>> >
>> >  #ifdef CONFIG_SHADOW_CALL_STACK
>> >
>> > @@ -37,22 +38,45 @@ static inline void scs_task_reset(struct task_struct *tsk)
>> >  	 * Reset the shadow stack to the base address in case the task
>> >  	 * is reused.
>> >  	 */
>> > +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> > +	task_scs_sp(tsk) = task_scs(tsk) + SCS_SIZE;
>> > +#else
>> >  	task_scs_sp(tsk) = task_scs(tsk);
>> > +#endif
>> >  }
>> >
>> >  static inline unsigned long *__scs_magic(void *s)
>> >  {
>> > +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> > +	return (unsigned long *)(s);
>> > +#else
>> >  	return (unsigned long *)(s + SCS_SIZE) - 1;
>> > +#endif
>> >  }
>> >
>> >  static inline bool task_scs_end_corrupted(struct task_struct *tsk)
>> >  {
>> >  	unsigned long *magic = __scs_magic(task_scs(tsk));
>> > -	unsigned long sz = task_scs_sp(tsk) - task_scs(tsk);
>> > +	unsigned long sz;
>> > +
>> > +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> > +	sz = (task_scs(tsk) + SCS_SIZE) - task_scs_sp(tsk);
>> > +#else
>> > +	sz = task_scs_sp(tsk) - task_scs(tsk);
>> > +#endif
>> >
>> >  	return sz >= SCS_SIZE - 1 || READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC;
>> >  }
>> >
>> > +static inline void __scs_store_magic(unsigned long *s, unsigned long magic_val)
>> > +{
>> > +#ifdef CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK
>> > +	arch_scs_store(s, magic_val);
>> > +#else
>> > +	*__scs_magic(s) = magic_val;
>> > +#endif
>> > +}
>> > +
>>
>> I'm not a huge fan of all the ifdefs. We could clean this up by
>> allowing architectures to simply override some these functions, or at
>> least use if (IS_ENABLED(CONFIG...)) instead. Will, any thoughts about
>> this?
>
>Yeah, I agree that allowing architectures to provide overrides makes
>sense, however I also suspect that some of this needs to be a runtime
>decision because not all CPUs will support the hardware-accelerated
>feature and will presumably want to fall back on the software
>implementation.

Hmm runtime fallback is an important point. Thanks. I'll munch on it a
bit.

>
>Will

