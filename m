Return-Path: <linux-kernel+bounces-888824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF0BC3C06F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73A43A8471
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192F2343B6;
	Thu,  6 Nov 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2tZ3/SK"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2325CC74
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442345; cv=none; b=OYTX6f649lrnP/N5AO93OFFnRahy9Z+1oMHclJNJdu3rwd6j/TcuiGJZOhBr26sQ/ND4muS27N2vvrWeOPwLZKi9bltZJ2DRHtHs68ajJ1RSjctVwelGFiYVXlGwqLj8Fe7dCRDz0moO6pn5Bg5crQBYDJyCSXG1Dv7UD+/ZgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442345; c=relaxed/simple;
	bh=Kj/nfYUAcDS/356GAgAZWyqIIaaqZPCTfPRT8pbIEac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SutD6UayjASXSD8rzVCE3NwCq5VXXLALX3Qpb9CNzV5/F7NR16PMZiEa0BD5uGsjnSYz7G1XXNU4HD4px5xvAw6K7yk8jLqcrs2cHDc623Bt8Rp2U+p5srAArb+iuKenwUL8A9r+JKkLOGyTmzG6orVnpVxtFfLhRK7D+WVcdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2tZ3/SK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b729f239b39so78780266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762442340; x=1763047140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/A/N8vcwKdT8TcSs16ZitfAWE/4Ic1WBoYeYHx9o7uA=;
        b=E2tZ3/SKvzxDjqjDaZHBUeSVzJmS+qZqHuywJiwW2Vyf0U9AftDe61fj4JMohDKAVS
         9ddUeh4hGiHTscfZGLS0b3XWfknaYgQgpnqCfbrtWY4Gdvhu2mSDDq5fkA3kwWZgsjqu
         GMrqYrNO2CQRn0ZaXLYGa+Z9gtZOGShJUj25w99cukzGXuHv2veOC8WQd08AoQbgTAeC
         I48MxEShdX6oz23I6NIYuG+mdbELfuXo8HOYzndz7/c8rkbXkNfTR8Bzi1BOmdDRSIK3
         lBTSdM2CX4+tNiuOdq01PSb9Lsovj3IeVAV+1+YU+yDhkDThTnkNG0xkBHtNWAEh4AhA
         eOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442340; x=1763047140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/A/N8vcwKdT8TcSs16ZitfAWE/4Ic1WBoYeYHx9o7uA=;
        b=e3DhybBATzrurzz8/RHLLT4IerycBXy2y8YPWwy21keSTU0S5F1ELXnNqJjBjuuXRI
         17ujbvGFtThi+El7a3qQOOO7WAEWkvGRnEb1pa7QQqqsxn0OouTXyCn/iHi6dOE306ZO
         8bAzh+Hy2OdgT94K8akW8d5rGdO8zaDvHRxJ9j2rLol5JojlJBybJWn/o5kCqKvX0I6d
         QO4WSuMYR3C2PTLi15Z64EPbS4Gl2q14jqcurafvDtZ55fdv12O1FKZf/n6SDHsw7UwE
         IKQyZ4H08k0aB9VUTeUdwnOyUN+58FvSBGtQRN5C0zx4G5tupDMoBUOr4aYExoJoGZQb
         /CiQ==
X-Gm-Message-State: AOJu0Ywnjxudu63k+1E2i8OQPUCqQeW4lUJ3/0VchL91YOpVMsrtn7XM
	vnr4Uwu9OzwAPTWL+mn8DG1IjMVOES8vExX/Bxoe2ElkXB/LjQDXtQ7/SFF4xmtdBfIQq5LSFcc
	7iPF06IU3yA39zoMyTEKExc9Vf4VLPAenvJjAseTg
X-Gm-Gg: ASbGnctkU6MKsmtDJPIXoqgOIfeKtkXdNdRNg6kECoiG9Wz4KyciJPilQXtC/qiQN/K
	xviu3YsUe6QTpr7/QwTDehN0GPfKQP/4GcJkAVKT4txCmO1jfQwK5a09/rHbcwFWtv1HFN8whQN
	/i+qMxa8avpMUfAhpud1qYBMFz5EaOKrWfgnsHY0s50Zoj2iT2btvFIYKJdcarTXQ8pnzoj/CF/
	4bOkbr2kWz9HiUHbUu4Ne7jtEt17Hn4TioNJGfEEY0eQzi4CXZR1i4aJ2UYft4y/S2lesg05S4a
	4zSsOpoU37GcF9EX3vZfhyfIvw==
X-Google-Smtp-Source: AGHT+IF6Lll39KroNtxrdzA3gXGbJk/g7xVSYA1QFmn3GNRu2l+pGUrp6SFXaJvuJgPAcXhUpJgSt6CYI17zoKm2B0Y=
X-Received: by 2002:a17:907:3d4c:b0:b4a:e7c9:84c1 with SMTP id
 a640c23a62f3a-b72893578ecmr431586766b.7.1762442339871; Thu, 06 Nov 2025
 07:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017185645.26604-1-james.morse@arm.com> <20251017185645.26604-27-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-27-james.morse@arm.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 6 Nov 2025 16:18:47 +0100
X-Gm-Features: AWmQ_bkGOrB1RKIT7idbIMCPIItvAN0p_zrVirGPYYJwN3Yf4xWvxB7PQou8e6U
Message-ID: <CALPaoCgO+NW9Hnb0x-eL7oR-Yj75V14hOW=LxAEYUEeK9SMCUA@mail.gmail.com>
Subject: Re: [PATCH v3 26/29] arm_mpam: Use long MBWU counters if supported
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com, 
	lcherian@marvell.com, bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com, 
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, 
	Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com, amitsinght@marvell.com, 
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com, baisheng.gao@unisoc.com, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring <robh@kernel.org>, 
	Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>, 
	Ben Horgan <ben.horgan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, Oct 17, 2025 at 8:59=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
>
> From: Rohit Mathew <rohit.mathew@arm.com>
>
> Now that the larger counter sizes are probed, make use of them.
>
> Callers of mpam_msmon_read() may not know (or care!) about the different
> counter sizes. Allow them to specify mpam_feat_msmon_mbwu and have the
> driver pick the counter to use.
>
> Only 32bit accesses to the MSC are required to be supported by the
> spec, but these registers are 64bits. The lower half may overflow
> into the higher half between two 32bit reads. To avoid this, use
> a helper that reads the top half multiple times to check for overflow.
>
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [morse: merged multiple patches from Rohit, added explicit counter select=
ion ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> ---
> Changes since v2:
>  * Removed mpam_feat_msmon_mbwu as a top-level bit for explicit 31bit cou=
nter
>    selection.
>  * Allow callers of mpam_msmon_read() to specify mpam_feat_msmon_mbwu and=
 have
>    the driver pick a supported counter size.
>  * Rephrased commit message.
>
> Changes since v1:
>  * Only clear OFLOW_STATUS_L on MBWU counters.
>
> Changes since RFC:
>  * Commit message wrangling.
>  * Refer to 31 bit counters as opposed to 32 bit (registers).
> ---
>  drivers/resctrl/mpam_devices.c | 134 ++++++++++++++++++++++++++++-----
>  1 file changed, 116 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> index f4d07234ce10..c207a6d2832c 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -897,6 +897,48 @@ struct mon_read {
>         int                             err;
>  };
>
> +static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
> +{
> +       return (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris->pr=
ops) ||
> +               mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->pr=
ops));
> +}
> +
> +static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
> +{
> +       int retry =3D 3;
> +       u32 mbwu_l_low;
> +       u64 mbwu_l_high1, mbwu_l_high2;
> +
> +       mpam_mon_sel_lock_held(msc);
> +
> +       WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz=
);
> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessib=
ility));
> +
> +       mbwu_l_high2 =3D __mpam_read_reg(msc, MSMON_MBWU_L + 4);
> +       do {
> +               mbwu_l_high1 =3D mbwu_l_high2;
> +               mbwu_l_low =3D __mpam_read_reg(msc, MSMON_MBWU_L);
> +               mbwu_l_high2 =3D __mpam_read_reg(msc, MSMON_MBWU_L + 4);
> +
> +               retry--;
> +       } while (mbwu_l_high1 !=3D mbwu_l_high2 && retry > 0);
> +
> +       if (mbwu_l_high1 =3D=3D mbwu_l_high2)
> +               return (mbwu_l_high1 << 32) | mbwu_l_low;
> +       return MSMON___NRDY_L;
> +}
> +
> +static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
> +{
> +       mpam_mon_sel_lock_held(msc);
> +
> +       WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz=
);
> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessib=
ility));
> +
> +       __mpam_write_reg(msc, MSMON_MBWU_L, 0);
> +       __mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
> +}
> +
>  static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>                                    u32 *flt_val)
>  {
> @@ -924,7 +966,9 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m=
, u32 *ctl_val,
>                                                ctx->csu_exclude_clean);
>
>                 break;
> -       case mpam_feat_msmon_mbwu:
> +       case mpam_feat_msmon_mbwu_31counter:
> +       case mpam_feat_msmon_mbwu_44counter:
> +       case mpam_feat_msmon_mbwu_63counter:
>                 *ctl_val |=3D MSMON_CFG_MBWU_CTL_TYPE_MBWU;
>
>                 if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->=
props))
> @@ -946,7 +990,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *=
m, u32 *ctl_val,
>                 *ctl_val =3D mpam_read_monsel_reg(msc, CFG_CSU_CTL);
>                 *flt_val =3D mpam_read_monsel_reg(msc, CFG_CSU_FLT);
>                 return;
> -       case mpam_feat_msmon_mbwu:
> +       case mpam_feat_msmon_mbwu_31counter:
> +       case mpam_feat_msmon_mbwu_44counter:
> +       case mpam_feat_msmon_mbwu_63counter:
>                 *ctl_val =3D mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
>                 *flt_val =3D mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
>                 return;
> @@ -959,6 +1005,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read =
*m, u32 *ctl_val,
>  static void clean_msmon_ctl_val(u32 *cur_ctl)
>  {
>         *cur_ctl &=3D ~MSMON_CFG_x_CTL_OFLOW_STATUS;
> +
> +       if (FIELD_GET(MSMON_CFG_x_CTL_TYPE, *cur_ctl) =3D=3D MSMON_CFG_MB=
WU_CTL_TYPE_MBWU)
> +               *cur_ctl &=3D ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
>  }
>
>  static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
> @@ -978,10 +1027,15 @@ static void write_msmon_ctl_flt_vals(struct mon_re=
ad *m, u32 ctl_val,
>                 mpam_write_monsel_reg(msc, CSU, 0);
>                 mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_C=
FG_x_CTL_EN);
>                 break;
> -       case mpam_feat_msmon_mbwu:
> +       case mpam_feat_msmon_mbwu_44counter:
> +       case mpam_feat_msmon_mbwu_63counter:
> +               mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
> +               fallthrough;
> +       case mpam_feat_msmon_mbwu_31counter:
>                 mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>                 mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>                 mpam_write_monsel_reg(msc, MBWU, 0);
> +
>                 mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_=
CFG_x_CTL_EN);
>
>                 mbwu_state =3D &m->ris->mbwu_state[m->ctx->mon];
> @@ -993,10 +1047,19 @@ static void write_msmon_ctl_flt_vals(struct mon_re=
ad *m, u32 ctl_val,
>         }
>  }
>
> -static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
> +static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
>  {
> -       /* TODO: scaling, and long counters */
> -       return GENMASK_ULL(30, 0);
> +       /* TODO: implement scaling counters */
> +       switch (type) {
> +       case mpam_feat_msmon_mbwu_63counter:
> +               return GENMASK_ULL(62, 0);
> +       case mpam_feat_msmon_mbwu_44counter:
> +               return GENMASK_ULL(43, 0);
> +       case mpam_feat_msmon_mbwu_31counter:
> +               return GENMASK_ULL(30, 0);
> +       default:
> +               return 0;
> +       }
>  }
>
>  /* Call with MSC lock held */
> @@ -1037,11 +1100,24 @@ static void __ris_msmon_read(void *arg)
>                         nrdy =3D now & MSMON___NRDY;
>                 now =3D FIELD_GET(MSMON___VALUE, now);
>                 break;
> -       case mpam_feat_msmon_mbwu:
> -               now =3D mpam_read_monsel_reg(msc, MBWU);
> -               if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops=
))
> -                       nrdy =3D now & MSMON___NRDY;
> -               now =3D FIELD_GET(MSMON___VALUE, now);
> +       case mpam_feat_msmon_mbwu_31counter:
> +       case mpam_feat_msmon_mbwu_44counter:
> +       case mpam_feat_msmon_mbwu_63counter:

Should you check for one of these three features instead of
mpam_feat_msmon_mbwu further up in this function when checking for
reset_on_next_read?

-       if (m->type =3D=3D mpam_feat_msmon_mbwu) {
+       switch (m->type) {
+       case mpam_feat_msmon_mbwu_31counter:
+       case mpam_feat_msmon_mbwu_44counter:
+       case mpam_feat_msmon_mbwu_63counter:
                mbwu_state =3D &ris->mbwu_state[ctx->mon];
                if (mbwu_state) {
                        reset_on_next_read =3D mbwu_state->reset_on_next_re=
ad;
                        mbwu_state->reset_on_next_read =3D false;
                }
+               break;
+       default:
+               break;
        }

> +               if (m->type !=3D mpam_feat_msmon_mbwu_31counter) {
> +                       now =3D mpam_msc_read_mbwu_l(msc);
> +                       if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy=
, rprops))
> +                               nrdy =3D now & MSMON___NRDY_L;
> +
> +                       if (m->type =3D=3D mpam_feat_msmon_mbwu_63counter=
)
> +                               now =3D FIELD_GET(MSMON___LWD_VALUE, now)=
;
> +                       else
> +                               now =3D FIELD_GET(MSMON___L_VALUE, now);
> +               } else {
> +                       now =3D mpam_read_monsel_reg(msc, MBWU);
> +                       if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy=
, rprops))
> +                               nrdy =3D now & MSMON___NRDY;
> +                       now =3D FIELD_GET(MSMON___VALUE, now);
> +               }
>
>                 if (nrdy)
>                         break;
> @@ -1050,7 +1126,7 @@ static void __ris_msmon_read(void *arg)
>
>                 /* Add any pre-overflow value to the mbwu_state->val */
>                 if (mbwu_state->prev_val > now)
> -                       overflow_val =3D mpam_msmon_overflow_val(ris) - m=
bwu_state->prev_val;
> +                       overflow_val =3D mpam_msmon_overflow_val(m->type)=
 - mbwu_state->prev_val;
>
>                 mbwu_state->prev_val =3D now;
>                 mbwu_state->correction +=3D overflow_val;
> @@ -1106,13 +1182,26 @@ static int _msmon_read(struct mpam_component *com=
p, struct mon_read *arg)
>         return any_err;
>  }
>
> +static enum mpam_device_features mpam_msmon_choose_counter(struct mpam_c=
lass *class)
> +{
> +       struct mpam_props *cprops =3D &class->props;
> +
> +       if (mpam_has_feature(mpam_feat_msmon_mbwu_44counter, cprops))
> +               return mpam_feat_msmon_mbwu_44counter;
> +       if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, cprops))
> +               return mpam_feat_msmon_mbwu_63counter;
> +
> +       return mpam_feat_msmon_mbwu_31counter;
> +}
> +
>  int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>                     enum mpam_device_features type, u64 *val)
>  {
>         int err;
>         struct mon_read arg;
>         u64 wait_jiffies =3D 0;
> -       struct mpam_props *cprops =3D &comp->class->props;
> +       struct mpam_class *class =3D comp->class;
> +       struct mpam_props *cprops =3D &class->props;
>
>         might_sleep();
>
> @@ -1129,9 +1218,12 @@ int mpam_msmon_read(struct mpam_component *comp, s=
truct mon_cfg *ctx,
>         };
>         *val =3D 0;
>
> +       if (type =3D=3D mpam_feat_msmon_mbwu)
> +               type =3D mpam_msmon_choose_counter(class);

`type` was already recorded in arg->type, so the result of this lookup
will be ignored on the first call to _msmon_read()

If mpam_feat_msmon_mbwu can somehow still result in -EBUSY, then the
repeat call may use the right type.

Thanks,
-Peter

