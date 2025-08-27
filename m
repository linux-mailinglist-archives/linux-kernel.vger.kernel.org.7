Return-Path: <linux-kernel+bounces-787875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F97EB37CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB132037BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B29321435;
	Wed, 27 Aug 2025 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="JY6Qh7AL"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77830CDBB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281895; cv=none; b=SsrysTsUUjxlkn14j6tlUMQECWDjjB37YJ1uFmdVPlne1Rr0/YBiqys1PyrzIdvpCxuRvkREJMbyLVmn3yGcc3CdM7LlzS6M69JQLJlnZR3vS7u83OYkAFCUDM4QBiTNHKOfR+po9t2Xwc4lB1LFp6LXRAOOAP0gFx4NT6Y/ys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281895; c=relaxed/simple;
	bh=gbcLll/AnyN4KW9wexFQ+zB4uHl2kSWRwMWKLL+G/5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EZHkFvmYp/apDoqJ9mGulyY5JNOZ3uoN7kDDiYqA9sfv3vJDIf3Jh2RAChwgNIxYff0wr2Z9gV9JxiACD+JO1UgIjxi/xWc7nKvugy+8DglZ5V/sS746U4GL6YDHQbTttvkOOc1nHLHkFTRYI4nOoJq455/I3eU/RrVzVvCqN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=JY6Qh7AL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326e8005bso6689927a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756281893; x=1756886693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zjK51+2A52fHet//FxjRNjwkcJGNCioQhxdhxLuT9Eg=;
        b=JY6Qh7ALDARDMDq5mhQDsBmWmGpzjlml1fR/cZ2TdkRkoLWBG7J5qmlnlihRp3sCNK
         xgMYNFAXTdZ7TO9gbm+TWFd2uFFAyAUsqEvPu4wtapE6oV8iCt30Tg/HKxV+hSpzQx/C
         hTKGVXr4ltHRv8cOHua+ETQHSbVCu3rCf07b2KUj6fC6cd764va+uo1SdtKosMhDbUNF
         hIkf6V38j81C0jrqrJkJQ9l+RXaNGeXPLdlTkWWiF0d15dSaTUgxIXBp5Fo2okGVIbCI
         nfbuGY/C7tiP/5DoesvwD05ge8o8WatwaFreLcrm20VnCzT6/C+74zV6JMIAnDi5z3+S
         6JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756281893; x=1756886693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjK51+2A52fHet//FxjRNjwkcJGNCioQhxdhxLuT9Eg=;
        b=EJl+yeewUX7i0w8IyoSqnpaTl7TK4aWueJDiOC+TReHDKH6bnHdYp6lu2+7gwIu8lo
         RvQ3ejX4WPZRp/zHZscW7AdUO0DU9FjA7c82iQiESB0oOaSvTQEPn2UccGPEGSe4KsgT
         d84BbW6dZ/9ij7u9jllP/Tt0yd+BAu2wxnfNKQgQcpTxjxaRx12m6pObED3yYLho5fIg
         lFVAAI2U26gN+isjVG7aIKggEw7BnE2an1Gjbx76IgvFa4bHzZaxWT+rmzyTKQWxEWIA
         lfoAdblgvgVhgpdBLpU804It5D66EweA90FopVKNHBkVMnnvoLLPhzEENLxGt0VrxHc6
         r/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUUCqbmTYzFf/QwtBWJDWqnmsXT69EoOBEPxmTHQYv8KpaP0HC+e8WyC4A4QrdaVlBHLk4p86pcZzuCpLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM2vp1k36a3BQTHCy+h8WX5WZX0TUqW7Hv4nAa1PdtVD+BJ4W6
	Vq9PCHcQ9Wtijy1dWk09ngO/AgjkXeFkJCK9CYxmjc7Z6IXs9sBDO5IGkEFOXKNE7l4=
X-Gm-Gg: ASbGncv/D+2H9E5saU7Z00PrirZ8H5Z5n38aRgM+kMpkOU9G8fD9hMlvD1pYxjfwDwq
	0knDQhku5ZV+UvNrKRjtr/3AdsyrLO/ygLUQIcvUiCz70cu0VHMyQE+/7ZvyfDIfhtlXie9sKWp
	+cCY7h0o3u/HDhAZ61o5FxzwEpozybhU89RAoV1y5LFa8/PlM9KU0aLg4Z5ugxYhUojQtii7KA5
	EG62m3HInhtfjtWyza+JiLScABitjH8xXJ4oMGPzcz5gRclYyQScGjr0BVIdpLJp1rK78hurf8U
	QYHZHPpyHxQM3Qw59dUQkwCf9pMy8HW+IE9zcJY9IO5W888EFNqWwOA154SxyDJzftcTQ7XS/sV
	zgxfHNm4eve3UGp8H/A==
X-Google-Smtp-Source: AGHT+IFmLVeBhKzJEqSUf1IlkeKSrgzItqcCx7zQbQCgDi+N7L9pd7Nncg0iDwIKNaLuKX3UWq7WIQ==
X-Received: by 2002:a17:90b:4fd0:b0:325:c92:4a89 with SMTP id 98e67ed59e1d1-32515e3cad8mr20990981a91.5.1756281892340;
        Wed, 27 Aug 2025 01:04:52 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:c960:881a:73ea:37d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f6b7458sm1367809a91.12.2025.08.27.01.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 01:04:51 -0700 (PDT)
Date: Wed, 27 Aug 2025 01:04:48 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Jesse Taube <Mr.Bossman075@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 5/8] riscv: hw_breakpoint: Use icount for single stepping
Message-ID: <aK68IJPqa4YOo1S_@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPd4Wexw_DtndDqRZzXK0PEOAkb4yWB4x8rf5eRdJOLMS-+8SQ@mail.gmail.com>

On Tue, Aug 26, 2025 at 10:08:04AM +0530, Himanshu Chauhan wrote:
> On Fri, Aug 22, 2025 at 11:17 PM Jesse Taube <jesse@rivosinc.com> wrote:
> >
> > The Sdtrig RISC-V ISA extension does not have a resume flag for
> > returning to and executing the instruction at the breakpoint.
> > To avoid skipping the instruction or looping, it is necessary to remove
> > the hardware breakpoint and single step. Use the icount feature of
> > Sdtrig to accomplish this. Use icount as default with an option to allow
> > software-based single stepping when hardware or SBI does not have
> > icount functionality, as it may cause unwanted side effects when reading
> > the instruction from memory.
> 
> Can you please elaborate on this? I remember noticing the absence of
> the resume flag which was causing loops.

Thank you for your feedback. Jesse's internship came to an end last
Friday (August 22nd) so I will be picking up these patches, but I have
also added her personal email onto this thread.

When a breakpoint is triggered and the kernel gains control, the last
instruction to execute was the instruction before the instruction where
the breakpoint is installed. If execution was to be resumed at this
stage, the same breakpoint would be triggered again. So single stepping
requires a careful dance of enabling and disabling breakpoints. However,
we can avoid this overhead and code complexity can be reduced by using
the icount trigger which allows a direct method for single stepping.

> 
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> > OpenSBI implementation of sbi_debug_read_triggers does not return the
> > updated CSR values. There needs to be a check for working
> > sbi_debug_read_triggers before this works.
> >
> > https://lists.riscv.org/g/tech-prs/message/1476
> >
> > RFC -> V1:
> >  - Add dbtr_mode to rv_init_icount_trigger
> >  - Add icount_triggered to check which breakpoint was triggered
> >  - Fix typo: s/affects/effects
> >  - Move HW_BREAKPOINT_COMPUTE_STEP to Platform type
> > V1 -> V2:
> >  - Remove HW_BREAKPOINT_COMPUTE_STEP kconfig option
> > ---
> >  arch/riscv/kernel/hw_breakpoint.c | 173 ++++++++++++++++++++++++++----
> >  1 file changed, 155 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
> > index 3f96e744a711..f12306247436 100644
> > --- a/arch/riscv/kernel/hw_breakpoint.c
> > +++ b/arch/riscv/kernel/hw_breakpoint.c
> > @@ -20,6 +20,7 @@
> >  #define DBTR_TDATA1_DMODE              BIT_UL(__riscv_xlen - 5)
> >
> >  #define DBTR_TDATA1_TYPE_MCONTROL      (2UL << DBTR_TDATA1_TYPE_SHIFT)
> > +#define DBTR_TDATA1_TYPE_ICOUNT                (3UL << DBTR_TDATA1_TYPE_SHIFT)
> >  #define DBTR_TDATA1_TYPE_MCONTROL6     (6UL << DBTR_TDATA1_TYPE_SHIFT)
> >
> >  #define DBTR_TDATA1_MCONTROL6_LOAD             BIT(0)
> > @@ -62,6 +63,14 @@
> >         (FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD, lo) | \
> >          FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZEHI_FIELD, hi))
> >
> > +#define DBTR_TDATA1_ICOUNT_U                   BIT(6)
> > +#define DBTR_TDATA1_ICOUNT_S                   BIT(7)
> > +#define DBTR_TDATA1_ICOUNT_PENDING             BIT(8)
> > +#define DBTR_TDATA1_ICOUNT_M                   BIT(9)
> > +#define DBTR_TDATA1_ICOUNT_COUNT_FIELD         GENMASK(23, 10)
> > +#define DBTR_TDATA1_ICOUNT_VU                  BIT(25)
> > +#define DBTR_TDATA1_ICOUNT_VS                  BIT(26)
> > +
> >  enum dbtr_mode {
> >         DBTR_MODE_U = 0,
> >         DBTR_MODE_S,
> > @@ -79,6 +88,7 @@ static DEFINE_PER_CPU(union sbi_dbtr_shmem_entry, sbi_dbtr_shmem);
> >
> >  /* number of debug triggers on this cpu . */
> >  static int dbtr_total_num __ro_after_init;
> > +static bool have_icount __ro_after_init;
> >  static unsigned long dbtr_type __ro_after_init;
> >  static unsigned long dbtr_init __ro_after_init;
> >
> > @@ -129,6 +139,7 @@ static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
> >  static void init_sbi_dbtr(void)
> >  {
> >         struct sbiret ret;
> > +       unsigned long dbtr_count = 0;
> >
> >         /*
> >          * Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
> > @@ -143,6 +154,19 @@ static void init_sbi_dbtr(void)
> >                 return;
> >         }
> >
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> > +               DBTR_TDATA1_TYPE_ICOUNT, 0, 0, 0, 0, 0);
> > +       if (ret.error) {
> > +               pr_warn("%s: failed to detect icount triggers. error: %ld.\n",
> > +                       __func__, ret.error);
> > +       } else if (!ret.value) {
> > +               pr_warn("%s: No icount triggers available. "
> > +                       "Falling-back to computing single step address.\n", __func__);
> > +       } else {
> > +               dbtr_count = ret.value;
> > +               have_icount = true;
> > +       }
> > +
> >         ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> >                         DBTR_TDATA1_TYPE_MCONTROL6, 0, 0, 0, 0, 0);
> >         if (ret.error) {
> > @@ -151,7 +175,7 @@ static void init_sbi_dbtr(void)
> >         } else if (!ret.value) {
> >                 pr_warn("%s: No mcontrol6 triggers available.\n", __func__);
> >         } else {
> > -               dbtr_total_num = ret.value;
> > +               dbtr_total_num = min_not_zero((unsigned long)ret.value, dbtr_count);
> >                 dbtr_type = DBTR_TDATA1_TYPE_MCONTROL6;
> >                 return;
> >         }
> > @@ -166,7 +190,7 @@ static void init_sbi_dbtr(void)
> >                 pr_err("%s: No mcontrol triggers available.\n", __func__);
> >                 dbtr_total_num = 0;
> >         } else {
> > -               dbtr_total_num = ret.value;
> > +               dbtr_total_num = min_not_zero((unsigned long)ret.value, dbtr_count);
> >                 dbtr_type = DBTR_TDATA1_TYPE_MCONTROL;
> >         }
> >  }
> > @@ -320,6 +344,36 @@ static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
> >         return 0;
> >  }
> >
> > +static int rv_init_icount_trigger(struct arch_hw_breakpoint *hw, enum dbtr_mode mode)
> > +{
> > +       unsigned long tdata1 = DBTR_TDATA1_TYPE_ICOUNT;
> > +
> > +       /* Step one instruction */
> > +       tdata1 |= FIELD_PREP(DBTR_TDATA1_ICOUNT_COUNT_FIELD, 1);
> > +
> > +       switch (mode) {
> > +       case DBTR_MODE_U:
> > +               tdata1 |= DBTR_TDATA1_ICOUNT_U;
> > +               break;
> > +       case DBTR_MODE_S:
> > +               tdata1 |= DBTR_TDATA1_ICOUNT_S;
> > +               break;
> > +       case DBTR_MODE_VS:
> > +               tdata1 |= DBTR_TDATA1_ICOUNT_VS;
> > +               break;
> > +       case DBTR_MODE_VU:
> > +               tdata1 |= DBTR_TDATA1_ICOUNT_VU;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       hw->tdata1 = tdata1;
> > +       hw->tdata2 = 0;
> > +
> > +       return 0;
> > +}
> > +
> >  int hw_breakpoint_arch_parse(struct perf_event *bp,
> >                              const struct perf_event_attr *attr,
> >                              struct arch_hw_breakpoint *hw)
> > @@ -372,24 +426,28 @@ static int setup_singlestep(struct perf_event *event, struct pt_regs *regs)
> >         /* Remove breakpoint even if return error as not to loop */
> >         arch_uninstall_hw_breakpoint(event);
> >
> > -       ret = get_insn_nofault(regs, regs->epc, &insn);
> > -       if (ret < 0)
> > -               return ret;
> > +       if (have_icount) {
> > +               rv_init_icount_trigger(bp, DBTR_MODE_U);
> > +       } else {
> > +               ret = get_insn_nofault(regs, regs->epc, &insn);
> > +               if (ret < 0)
> > +                       return ret;
> >
> > -       next_addr = get_step_address(regs, insn);
> > +               next_addr = get_step_address(regs, insn);
> >
> > -       ret = get_insn_nofault(regs, next_addr, &insn);
> > -       if (ret < 0)
> > -               return ret;
> > +               ret = get_insn_nofault(regs, next_addr, &insn);
> > +               if (ret < 0)
> > +                       return ret;
> >
> > -       bp_insn.bp_type = HW_BREAKPOINT_X;
> > -       bp_insn.bp_addr = next_addr;
> > -       /* Get the size of the intruction */
> > -       bp_insn.bp_len = GET_INSN_LENGTH(insn);
> > +               bp_insn.bp_type = HW_BREAKPOINT_X;
> > +               bp_insn.bp_addr = next_addr;
> > +               /* Get the size of the intruction */
> > +               bp_insn.bp_len = GET_INSN_LENGTH(insn);
> >
> > -       ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
> > -       if (ret)
> > -               return ret;
> > +               ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
> > +               if (ret)
> > +                       return ret;
> > +       }
> >
> >         ret = arch_install_hw_breakpoint(event);
> >         if (ret)
> > @@ -400,6 +458,79 @@ static int setup_singlestep(struct perf_event *event, struct pt_regs *regs)
> >         return 0;
> >  }
> >
> > +/**
> > + * icount_triggered - Check if event's icount was triggered.
> > + * @event: Perf event to check
> > + *
> > + * Check the given perf event's icount breakpoint was triggered.
> > + *
> > + * Returns:    1 if icount was triggered.
> > + *             0 if icount was not triggered.
> > + *             negative on failure.
> > + */
> > +static int icount_triggered(struct perf_event *event)
> > +{
> > +       union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(&sbi_dbtr_shmem);
> > +       struct sbiret ret;
> > +       struct perf_event **slot;
> > +       unsigned long tdata1;
> > +       int i;
> > +
> > +       for (i = 0; i < dbtr_total_num; i++) {
> > +               slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
> > +
> > +               if (*slot == event)
> > +                       break;
> > +       }
> > +
> > +       if (i == dbtr_total_num) {
> > +               pr_warn("%s: Breakpoint not installed.\n", __func__);
> > +               return -ENOENT;
> > +       }
> > +
> > +       raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> > +                             *this_cpu_ptr(&ecall_lock_flags));
> > +
> > +       ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_READ,
> > +                       i, 1, 0, 0, 0, 0);
> > +       tdata1 = shmem->data.tdata1;
> > +
> > +       raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> > +                                  *this_cpu_ptr(&ecall_lock_flags));
> > +       if (ret.error) {
> > +               pr_warn("%s: failed to read trigger. error: %ld\n", __func__, ret.error);
> > +               return sbi_err_map_linux_errno(ret.error);
> 
> To avoid a flurry of events or messages, it would probably be good to
> disable the trigger.

That is a good point.

> 
> > +       }
> > +
> > +       /*
> > +        * The RISC-V Debug Specification
> > +        * Tim Newsome, Paul Donahue (Ventana Micro Systems)
> > +        * Version 1.0, Revised 2025-02-21: Ratified
> I think mentioning the version number and section would be enough.

Agreed.

> 
> > +        * 5.7.13. Instruction Count (icount, at 0x7a1)
> > +        * When count is 1 and the trigger matches, then pending becomes set.
> > +        * In addition count will become 0 unless it is hard-wired to 1.
> > +        * When pending is set, the trigger fires just before any further
> > +        * instructions are executed in a mode where the trigger is enabled.
> > +        * As the trigger fires, pending is cleared. In addition, if count is
> > +        * hard-wired to 1 then m, s, u, vs, and vu are all cleared.
> > +        */
> > +       if (FIELD_GET(DBTR_TDATA1_ICOUNT_COUNT_FIELD, tdata1) == 0)
> > +               return 1;
> > +
> > +       if (FIELD_GET(DBTR_TDATA1_ICOUNT_COUNT_FIELD, tdata1) != 1)
> > +               return 0;
> > +
> > +       if (tdata1 & DBTR_TDATA1_ICOUNT_U)
> > +               return 0;
> > +       if (tdata1 & DBTR_TDATA1_ICOUNT_S)
> > +               return 0;
> > +       if (tdata1 & DBTR_TDATA1_ICOUNT_VU)
> > +               return 0;
> > +       if (tdata1 & DBTR_TDATA1_ICOUNT_VU)
> > +               return 0;
> > +       return 1;
> > +}
> > +
> >  /*
> >   * HW Breakpoint/watchpoint handler
> >   */
> > @@ -460,7 +591,10 @@ static int hw_breakpoint_handler(struct pt_regs *regs)
> >
> >                 if (bp->in_callback) {
> >                         expecting_callback = true;
> > -                       if (regs->epc != bp->next_addr) {
> > +                       if (have_icount) {
> > +                               if (icount_triggered(event) != 1)
> > +                                       continue;
> > +                       } else if (regs->epc != bp->next_addr) {
> >                                 continue;
> >                         }
> >
> > @@ -477,7 +611,10 @@ static int hw_breakpoint_handler(struct pt_regs *regs)
> >
> >         }
> >
> > -       if (expecting_callback) {
> > +       if (expecting_callback && have_icount) {
> > +               pr_err("%s: in_callback was set, but icount was not triggered, epc (%lx).\n",
> > +                      __func__, regs->epc);
> > +       } else if (expecting_callback) {
> >                 pr_err("%s: in_callback was set, but epc (%lx) was not at next address(%lx).\n",
> >                        __func__, regs->epc, bp->next_addr);
> >         }
> 
> Is this just for debugging or do you want to commit it?

I believe this was intentional, but perhaps it is not a useful print.

- Charlie

> 
> Regards
> Himanshu
> > --
> > 2.43.0
> >

