Return-Path: <linux-kernel+bounces-772331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDC4B29171
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52084170FA6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 03:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA861F63CD;
	Sun, 17 Aug 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcVk2Ged"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74281D5150
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755402181; cv=none; b=ksrVGIGp/4qdtKQ9eQ8P2QTpzKxeV4byxgFE6bthWCxOD6eGZfpNIfQroTjIHzXUE13cCR1NfigQkzWaGXjkFBOXrZrtiqe9pvBHxdwkxLYgAwukrrFYm3OzCifwLDUqm1UUFBz6ztra47Sgopklp2H8fFAyUPAGSR9YMkfi40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755402181; c=relaxed/simple;
	bh=qQj94pXeTrj71P/XWbz5Bxq9rt6prcKC1DrYuIz368E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SugJjLTx3rU/gkmi44gEHaLZeNgErnclXATUgesvDrUez6bDUcpsq6rxOQ5xup59kpB5kZrd72AC1H3806zzj17Ow3R58v4ImdYp9KoBKV/STLhVx1jDYQVQ16TPywRuZXO4YOctvnZk0xfGAvVqewNatnQZIgXauEVDmvlbBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcVk2Ged; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD3DC4CEED
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 03:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755402181;
	bh=qQj94pXeTrj71P/XWbz5Bxq9rt6prcKC1DrYuIz368E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dcVk2Gedd6M0hJlpnDlRyBb6Z7T1WcNah8bDj/FO/basbZQ5+UWz7Fr/zp7jKIIWu
	 zD/TR9Wxj/r3pp0tfy8WaYer/x77b+vfIcHFKruZqQuLzTATlqCeyK3+TeTcLirn+7
	 0uPuONQ6H1YdB76q3ADEME3nWczPRn0z5WDoI4/lc9zv5UdGRUmc6cUdX7DmdW643k
	 BxrYJYzA3KYebTw9rqDwkaC9IkRMIRbl33TvNs9FN2mSgOte5ozj2vN55EskD/sQxM
	 jKgjR1fZ62llAQIS9PtwqKH+UIFS9rNcsrVkEHUd9U9yOHfndhPkqCbDF6dZhMQBHQ
	 cCzeoGg/yvg+Q==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61a1c6a5338so572338a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 20:43:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/fsZ6Vw9XGddjCGUMkVIEZ5s7IrFh7l4qei/wE9q7KXuJyxzlQGmb+gA6dPlrnI0yYDQXZu9l7N47UfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/668VkSAs6rJ8Kt12LfYLupy3xtsNdKdV1wVHS8MoQTo6VuU
	BUrvfWNaYf5vDTyx5T9aSKKCWiIVkdQ7S/YW8Af2bDZdPduIWnHPeV02cCqyOGuRTf7lOaePtdw
	CImLCoYoDZDblxEnnpqj/gTDi/S0AYKk=
X-Google-Smtp-Source: AGHT+IHFi381w9JCWuvkXbxvK+O8X8+YNTLgxrpVEgM+QSe2WXYaXUxHr5caKgMrfgz4400zr8tgduCeMrHERXrS79Q=
X-Received: by 2002:a05:6402:2683:b0:617:be1d:4a48 with SMTP id
 4fb4d7f45d1cf-618b050d546mr6098218a12.5.1755402180077; Sat, 16 Aug 2025
 20:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814022810.2917-1-wangkanglong@loongson.cn>
In-Reply-To: <20250814022810.2917-1-wangkanglong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 17 Aug 2025 11:42:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6fMgs+OYc5Sosz7ii0o24NoqTGp37yfehuxVpo2ctAQQ@mail.gmail.com>
X-Gm-Features: Ac12FXzT5-qlXGKZYDqVl8azi-AMekNTTtZLjHpsgmoyR2JS1hkLh4b7g-sro8M
Message-ID: <CAAhV-H6fMgs+OYc5Sosz7ii0o24NoqTGp37yfehuxVpo2ctAQQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: module: Optimize module load time by
 optimizing PLT/GOT counting
To: Kanglong Wang <wangkanglong@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Thu, Aug 14, 2025 at 10:28=E2=80=AFAM Kanglong Wang <wangkanglong@loongs=
on.cn> wrote:
>
> When enabling CONFIG_KASAN, CONFIG_PREEMPT_VOLUNTARY_BUILD and
> CONFIG_PREEMPT_VOLUNTARY at the same time, there will be soft deadlock,
> the relevant logs are as follows:
>
> rcu: INFO: rcu_sched self-detected stall on CPU
> ...
> Call Trace:
> [<900000000024f9e4>] show_stack+0x5c/0x180
> [<90000000002482f4>] dump_stack_lvl+0x94/0xbc
> [<9000000000224544>] rcu_dump_cpu_stacks+0x1fc/0x280
> [<900000000037ac80>] rcu_sched_clock_irq+0x720/0xf88
> [<9000000000396c34>] update_process_times+0xb4/0x150
> [<90000000003b2474>] tick_nohz_handler+0xf4/0x250
> [<9000000000397e28>] __hrtimer_run_queues+0x1d0/0x428
> [<9000000000399b2c>] hrtimer_interrupt+0x214/0x538
> [<9000000000253634>] constant_timer_interrupt+0x64/0x80
> [<9000000000349938>] __handle_irq_event_percpu+0x78/0x1a0
> [<9000000000349a78>] handle_irq_event_percpu+0x18/0x88
> [<9000000000354c00>] handle_percpu_irq+0x90/0xf0
> [<9000000000348c74>] handle_irq_desc+0x94/0xb8
> [<9000000001012b28>] handle_cpu_irq+0x68/0xa0
> [<9000000001def8c0>] handle_loongarch_irq+0x30/0x48
> [<9000000001def958>] do_vint+0x80/0xd0
> [<9000000000268a0c>] kasan_mem_to_shadow.part.0+0x2c/0x2a0
> [<90000000006344f4>] __asan_load8+0x4c/0x120
> [<900000000025c0d0>] module_frob_arch_sections+0x5c8/0x6b8
> [<90000000003895f0>] load_module+0x9e0/0x2958
> [<900000000038b770>] __do_sys_init_module+0x208/0x2d0
> [<9000000001df0c34>] do_syscall+0x94/0x190
> [<900000000024d6fc>] handle_syscall+0xbc/0x158
>
> After analysis, because the slow speed of loading the amdgpu module
> leads to the long time occupation of the cpu and the soft deadlock.
>
> When loading a module, module_frob_arch_sections() tries to figure out
> the number of PLTs/GOTs that'll be needed to handle all the RELAs. It
> will call the count_max_entries() to find in an out-of-order date which
> counting algorithm has O(n^2) complexity.
>
> To make faster, it sorts the relocation list by info and addend. That
> way, to check for a duplicate relocation, it just needs to compare with
> the previous entry. This reduces the complexity of the algorithm to O(n
>  log n), as done in commit d4e0340919fb ("arm64/module: Optimize module
> load time by optimizing PLT counting"). This gives sinificant reduction
> in module load time for modules with large number of relocations.
>
> After applying this patch, the soft deadlock problem has been solved,
> and the kernel starts normally without "Call Trace".
>
> Using the default configuration to test some modules, the results are as
> follows:
>
> Module              Size
> ip_tables           36K
> fat                 143K
> radeon              2.5MB
> amdgpu              16MB
>
> Without this patch:
> Module              Module load time (ms)       Count(PLTs/GOTs)
> ip_tables           18                          59/6
> fat                 0                           162/14
> radeon              54                          1221/84
> amdgpu              1411                        4525/1098
>
> With this patch:
> Module              Module load time (ms)       Count(PLTs/GOTs)
> ip_tables           18                          59/6
> fat                 0                           162/14
> radeon              22                          1221/84
> amdgpu              45                          4525/1098
>
> Fixes: fcdfe9d22bed ("LoongArch: Add ELF and module support")
> Signed-off-by: Kanglong Wang <wangkanglong@loongson.cn>
> ---
>  arch/loongarch/kernel/module-sections.c | 34 ++++++++++++-------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/ker=
nel/module-sections.c
> index e2f30ff9afde..3b22b3c1af28 100644
> --- a/arch/loongarch/kernel/module-sections.c
> +++ b/arch/loongarch/kernel/module-sections.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleloader.h>
>  #include <linux/ftrace.h>
> +#include <linux/sort.h>
>
>  Elf_Addr module_emit_got_entry(struct module *mod, Elf_Shdr *sechdrs, El=
f_Addr val)
>  {
> @@ -61,39 +62,36 @@ Elf_Addr module_emit_plt_entry(struct module *mod, El=
f_Shdr *sechdrs, Elf_Addr v
>         return (Elf_Addr)&plt[nr];
>  }
>
> -static int is_rela_equal(const Elf_Rela *x, const Elf_Rela *y)
> -{
> -       return x->r_info =3D=3D y->r_info && x->r_addend =3D=3D y->r_adde=
nd;
> -}
> +#define cmp_3way(a, b)  ((a) < (b) ? -1 : (a) > (b))
>
> -static bool duplicate_rela(const Elf_Rela *rela, int idx)
> +static int compare_rela(const void *x, const void *y)
>  {
> -       int i;
> +       int ret;
> +       const Elf_Rela *rela_x =3D x, *rela_y =3D y;
>
> -       for (i =3D 0; i < idx; i++) {
> -               if (is_rela_equal(&rela[i], &rela[idx]))
> -                       return true;
> -       }
> +       ret =3D cmp_3way(rela_x->r_info, rela_y->r_info);
> +       if (ret =3D=3D 0)
> +               ret =3D cmp_3way(rela_x->r_addend, rela_y->r_addend);
>
> -       return false;
> +       return ret;
>  }
>
>  static void count_max_entries(Elf_Rela *relas, int num,
>                               unsigned int *plts, unsigned int *gots)
>  {
> -       unsigned int i, type;
> +       unsigned int i;
>
> +       sort(relas, num, sizeof(Elf_Rela), compare_rela, NULL);
>         for (i =3D 0; i < num; i++) {
> -               type =3D ELF_R_TYPE(relas[i].r_info);
> -               switch (type) {
> +               if (i > 0 && compare_rela(&relas[i-1], &relas[i]) =3D=3D =
0)
> +                       continue;
> +               switch (ELF_R_TYPE(relas[i].r_info)) {
>                 case R_LARCH_SOP_PUSH_PLT_PCREL:
>                 case R_LARCH_B26:
> -                       if (!duplicate_rela(relas, i))
> -                               (*plts)++;
> +                       (*plts)++;
>                         break;
>                 case R_LARCH_GOT_PC_HI20:
> -                       if (!duplicate_rela(relas, i))
> -                               (*gots)++;
> +                       (*gots)++;
>                         break;
>                 default:
>                         break; /* Do nothing. */
> --
> 2.20.1
>

