Return-Path: <linux-kernel+bounces-888973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F130C3C653
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4825605B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F5528467D;
	Thu,  6 Nov 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yUHM0SOV"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2477D14F9D6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445740; cv=none; b=ovT/HiuaXnqA9D0b+r6bixQqhfMmQuAdkV7oVhar6MVPkHKI6J/YcVr/Z3/NFL84t1hO1ucykMXhWJ9euL/Qgi57Sb/pQzI4njn4gP7NJZ109Z03RtY3zFF0ljz0SaR3Mcps5J3dBW8/nkQ35Vm7piU+R1BZUJKYfC6j+/28mK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445740; c=relaxed/simple;
	bh=OxjLnOQTPzjwH5+2YtULlwpAtYzlDGYjFAqJCWsGq/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZbDFh1yvisDjXS7Q8cT2WhRJVCEucOwMi5aJtMCPh4OrO8FdoAxSfcUOpLwhl1C5RR1554YgAi1llCMGQ965cVwQWwkQ65j8tt+C9l2Qcj606ani1kVhE8x9XE2NaLKGBMXCFL/PkrqlQFHnDBAopOPT78hqiGZeK/Lj1MBPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yUHM0SOV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso2017374a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762445736; x=1763050536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPoQivoj0bwUpJuAKFBN3YZX3F888EB0gmOCY9Z/+Io=;
        b=yUHM0SOVboglHcFG3VcUNNbw0dgGfRpbs0DtJJoo75dXsRIDsRphxhOIXNeAL01Ay9
         f3t8dmAw7HTmXfTm2mB66+kZGdILrI/UhSXN+rH8/naYV3MddPLz4WoZsFMeYn1IWUMv
         Kdl8mE8pIROJxDR7DE/yfkwOB2xi2ejoMeRu5SY6T+u7UPSCt2+lbUGgJ4q27btRYHTk
         4VJDLtbooHPkEcfrRsmfVIKZTRmzysrAqaW3wjrNUOoGVrJQkA8d+WcggZ2jEH2aIOqc
         4YF2Ljr/Z7agpSyzP31YgLN4jSu2SAyLsHEJXJtmzronYvml2X28Mi1BkSQuJkaHk+LE
         kMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445736; x=1763050536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPoQivoj0bwUpJuAKFBN3YZX3F888EB0gmOCY9Z/+Io=;
        b=YpV7Kr36+cPhQyP3ZzaRQjUGTpWJt8bKaVxGZtX6aeAlF6q9ygup1AUnXpofiCe4jT
         01cAhQQkNFq1Zen7IvOF1ifUdHSdztbabzWa3fXAK0qp7y+Khgomt5ZrZfiCeb211yGI
         mxGwrEf9NqaDY5zjX3Sr1Ga/UshhVv/xhhd9cnCBXTcZ/MQ/Gz27aFBKqhb+47OM/e7R
         hU7WZUe67HMRD4Sl7nQqndGENEtPYtCEEA9UWUwAAVG9I1BPHpBLuXpUlvG9SSOShg5C
         gBmN50OxKizw81uGoAL3xTPhIoGt7SGaNolIsoxWL9x+6hIuqfNeMq5jqHmK9Pjrn01N
         zd4g==
X-Gm-Message-State: AOJu0Yw6akQ9e9mfOEZIp5zfVXapVb88Faut/3HYMrKemZzj0qbVgOhL
	3g7NyT58CKLY4lnAe2xAStOXYSMESYVfqgP8oBNSlKV958zh4YNO4eAWjzP5zUYJaL1RJw3LiIL
	nt+BcwulI2WiMXovjjh/o7T/4/VuJb7M9yvpTr+EZ
X-Gm-Gg: ASbGncvyyZUi3Enfcn5NmWTFOJlC36Rd72v2Qvw6V3HsT8HMTz9W/wSMJIE4Y8hP2L5
	O911ziMjkFO4VlJFoNTPOR/qybYQ3EoGhW3dNfNaV1Fn/GaKFnk/iG4AhgwZ0WHV4C1kWy6qs+W
	XmskobwRmxwhtvLmfJMVZ/rFSYiatbCkI2LLiSEjrNHfnIo+/zN3QyYnNo6N7Tawn6WEIdksB52
	p/+wQBibZLiz6hkR5S1Juvz5qeuPySlQQXZ2gfd+LRzAeczyEkgPtYIG52gQ+IxrqxlV2EqXp4k
	h9HHXimb0euTJl9d5+R8U8XqKkSvbp4Gke7JWRn804cNYl4=
X-Google-Smtp-Source: AGHT+IG1Ov7pFXZaXVB28owjtebImD4qpmyq8jDV9Ajg9ePMC3Z2ezu3r4M3Fi3zUR5W25bem+LibNeSUkoSsiLYH1I=
X-Received: by 2002:a17:907:c89a:b0:b72:ad95:c1c2 with SMTP id
 a640c23a62f3a-b72ad95e38bmr159947966b.11.1762445736030; Thu, 06 Nov 2025
 08:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017185645.26604-1-james.morse@arm.com> <20251017185645.26604-27-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-27-james.morse@arm.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 6 Nov 2025 17:15:25 +0100
X-Gm-Features: AWmQ_bk1VJkZkQ5a_WKDE9YukLtljH9rcbobFcoQ7adNDshEM1jjBJbj5ZmMVU0
Message-ID: <CALPaoCjJXHD+HgFizzvNEvBorbUcJLTngLb7UJy-uMdybhCfrg@mail.gmail.com>
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

Hi Ben (and James),

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

The fallthrough above seems to be problematic, assuming the MBWU=3D0
being last for 31-bit was intentional. For long counters, this is
zeroing the counter before updating the filter/control registers, but
then clearing the 32-bit version of the counter. This fails to clear
the NRDY bit on the long counter, which isn't cleared by software
anywhere else.

From section 10.3.2 from the MPAM spec shared:

 "On a counting monitor, the NRDY bit remains set until it is reset by
software writing it as 0 in the monitor register, or automatically
after the monitor is captured in the capture register by a capture
event"

If I update the 63-bit case to call
mpam_msc_zero_mbwu_l(m->ris->vmsc->msc) after updating the
control/filter registers (in addition to the other items I pointed in
my last reply), I'm able to read MBWU counts from my hardware through
mbm_total_bytes.

Thanks,
-Peter

