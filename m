Return-Path: <linux-kernel+bounces-863529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE08BF80F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028FB405B89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9034A3AF;
	Tue, 21 Oct 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkbfOJr5"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0734A3AE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071360; cv=none; b=Of447NMjqWHLFFwl2y5u3zqpTY0bLmaXyQcnHZqKfA/1lt/NnrGVfuKVKYK4o5ROQT43kibhQZ/S3TDIs5vAFtbPtyTS5fucYuL20CFaMnYcJzvY28ePyiCBZUAFQMOKICN2fODmZXqwl2fGVHNTQwfAC5UXjPVMwOGjt+SHCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071360; c=relaxed/simple;
	bh=/g8ICMa3NefTOG4DzHS614HtprxR6wttp7Od263LK1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6s0v5xeLI1uspYWA/VlimwxBwkvIqWvtR5wG/fHnf/CH4uoEVCNVrK8vhx6lZNNwkoRkL7Y5FnOa9YMoADWjKJZ7UHNzJhvdlxUmQZtA+42iZbCfhedEg5I/a4vtEIPm80OLrlPHNPdU0IvtLP41S3cYkebzgUoI+8H+ozMFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkbfOJr5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-591c74fd958so7380187e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071356; x=1761676156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AEzgCFdwuZqOc4gGaeEVUhxJJB9RlkSUPcJFP88ZeY=;
        b=fkbfOJr5fsI9B2Q2eToQu1vMEdWlKHqKi3DW4fM0PCrTQa8G5x0NnseqI5a0b9KTq5
         Bz5aNJc1NRrBFnle+kvDZ3lQtL9MS2VVhwCKI7tE8ojyenFSML9a4zc4x2E45tr7JCwz
         NP/L+2fSAtNgbrO0S5pWvdedDPkRmcKF7uy0c+ehEZxdT1839jZYScGn/D3C9eKJbawh
         h/sl+9HvQLJoQLGY7i0lE40MQuyP/dkSFJOHkrT8F1/LOY9H3DO4L4FvUQWVlhW2DZy/
         IrlW+ZLgLpJ3Yl/Dr6FzYnRga80jzWgJ38Bh1krWIfmO84raDOmhqu//yW6ihIAtc5uL
         TJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071356; x=1761676156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AEzgCFdwuZqOc4gGaeEVUhxJJB9RlkSUPcJFP88ZeY=;
        b=cBKfTQSkAtnHLwbiK6EEwMHQJGmEWUPrsPavgBVYxxtVi3DChtoADePxxFrPuQeRsX
         PCn4m46Em7NVeXAEmiFPzO6iZe2iHfLuOXBzSWmcH0nZpr4neJrsL4Sg84BTl4zJVgde
         zWRYnIhKbg3Zrfb4RE1BYeCgiRTCiiwbB9L40MlnqJn4JmrgKxx1CNK1ZyY4Jrw+xYo/
         txUTXSRuU8TmeMhcKLVt6G+9H9bjzkd38xX1e0hKV5yVCHyS29rW60jzfbsHtlwfTObC
         ZhZP1JVDCyMiIxzv5BdIi5p93ialGGBym8iuYXDUxtTcXvPacyqOrP/o61vfwjBdQ/7m
         J/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXufNN6htx2fspKBwcPbb9lGtf+74tLn8qIZMbaZBSBnZIVFZkKSXPkoBHHQEA+2mGr+0U+0NTbFYpz8h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9N7JEof33k9XHuA46vEsDQCGQyOej181VTbihREJKQ3wwXguv
	ZFLbTTJJ7fEPV6y0iDmfUQB4Wo6KUrNIg5tSk8TK7DI814j+Ya2P0C0/o53vz79OZ1hNRZAyTwO
	ht1Vj6wQ/JZeifMz3Njp2oZ6eowShsGM=
X-Gm-Gg: ASbGnctyMKgaiSsLnfz9yFEPjBIquK2cxtjftJePXUdjE1YPwkwJVmQ0rSRY4vvvuCC
	dcDASdNiIrpf0ckc7cFDiaIc76y14zO4l4/FXtsVlw/iPSIwKSPHKWYHXx4Va0PF35mP5SS9FMc
	dOx5X1CDwqCpQC7+0YqhH7uevrL3FZVU8dW6mTodHkJ3fcAC4kzZxEi0Qv/00W1tlPyg4+EW1TF
	3yEU9pwj4H4Z/NhZfisMLLu3Jr5iT2OGarOZaU9UXqwU5VCbdKqQU9SF6go
X-Google-Smtp-Source: AGHT+IE/wTYDoubw+GPU8YYzuNwa7ung6G4/CZtRuJ7b77Mhfm1RIszPqiOo7CcLZhXzJawDCk1h0Hdo/OG2RDMbGE0=
X-Received: by 2002:a05:6512:3d0d:b0:590:656c:d11d with SMTP id
 2adb3069b0e04-591d857bd83mr6023093e87.54.1761071355673; Tue, 21 Oct 2025
 11:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-tegra186-icc-p1-v1-1-0d8eede5cc50@gmail.com>
In-Reply-To: <20251021-tegra186-icc-p1-v1-1-0d8eede5cc50@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 21 Oct 2025 13:29:04 -0500
X-Gm-Features: AS18NWBzzsN63DV2cPpVvmQWJjW6cprAp9iS2RsyLDnQKYEFdfukGVeJhtWMhVQ
Message-ID: <CALHNRZ8BKSLi3V6=iubCdde2Hb+84Fj8vzTTcCvmRqA6vS8Z8g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: tegra186: add OPP support and set bandwidth
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:28=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> Add support to use OPP table from DT in Tegra186 cpufreq driver.
> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
> Cross check the OPP's present in DT against the LUT from BPMP-FW
> and enable only those DT OPP's which are present in LUT also.
>
> The OPP table in DT has CPU Frequency to bandwidth mapping where
> the bandwidth value is per MC channel. DRAM bandwidth depends on the
> number of MC channels which can vary as per the boot configuration.
> This per channel bandwidth from OPP table will be later converted by
> MC driver to final bandwidth value by multiplying with number of
> channels before being handled in the EMC driver.
>
> If OPP table is not present in DT, then use the LUT from BPMP-FW
> directy as the CPU frequency table and not do the DRAM frequency
> scaling which is same as the current behavior.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 152 +++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 145 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra18=
6-cpufreq.c
> index 136ab102f636aa57741639ed1909d095881c14d3..35f1c1371f6a1688c35f3ba01=
2b9f008fba83d74 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/units.h>
>
>  #include <soc/tegra/bpmp.h>
>  #include <soc/tegra/bpmp-abi.h>
> @@ -58,7 +59,7 @@ static const struct tegra186_cpufreq_cpu tegra186_cpus[=
] =3D {
>  };
>
>  struct tegra186_cpufreq_cluster {
> -       struct cpufreq_frequency_table *table;
> +       struct cpufreq_frequency_table *bpmp_lut;
>         u32 ref_clk_khz;
>         u32 div;
>  };
> @@ -66,16 +67,121 @@ struct tegra186_cpufreq_cluster {
>  struct tegra186_cpufreq_data {
>         void __iomem *regs;
>         const struct tegra186_cpufreq_cpu *cpus;
> +       bool icc_dram_bw_scaling;
>         struct tegra186_cpufreq_cluster clusters[];
>  };
>
> +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned =
long freq_khz)
> +{
> +       struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> +       struct device *dev;
> +       int ret;
> +
> +       dev =3D get_cpu_device(policy->cpu);
> +       if (!dev)
> +               return -ENODEV;
> +
> +       struct dev_pm_opp *opp __free(put_opp) =3D
> +               dev_pm_opp_find_freq_exact(dev, freq_khz * HZ_PER_KHZ, tr=
ue);
> +       if (IS_ERR(opp))
> +               return PTR_ERR(opp);
> +
> +       ret =3D dev_pm_opp_set_opp(dev, opp);
> +       if (ret)
> +               data->icc_dram_bw_scaling =3D false;
> +
> +       return ret;
> +}
> +
> +static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *polic=
y,
> +                                           struct cpufreq_frequency_tabl=
e *bpmp_lut,
> +                                           struct cpufreq_frequency_tabl=
e **opp_table)
> +{
> +       struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> +       struct cpufreq_frequency_table *freq_table =3D NULL;
> +       struct cpufreq_frequency_table *pos;
> +       struct device *cpu_dev;
> +       unsigned long rate;
> +       int ret, max_opps;
> +       int j =3D 0;
> +
> +       cpu_dev =3D get_cpu_device(policy->cpu);
> +       if (!cpu_dev) {
> +               pr_err("%s: failed to get cpu%d device\n", __func__, poli=
cy->cpu);
> +               return -ENODEV;
> +       }
> +
> +       /* Initialize OPP table mentioned in operating-points-v2 property=
 in DT */
> +       ret =3D dev_pm_opp_of_add_table_indexed(cpu_dev, 0);
> +       if (ret) {
> +               dev_err(cpu_dev, "Invalid or empty opp table in device tr=
ee\n");
> +               data->icc_dram_bw_scaling =3D false;
> +               return ret;
> +       }
> +
> +       max_opps =3D dev_pm_opp_get_opp_count(cpu_dev);
> +       if (max_opps <=3D 0) {
> +               dev_err(cpu_dev, "Failed to add OPPs\n");
> +               return max_opps;
> +       }
> +
> +       /* Disable all opps and cross-validate against LUT later */
> +       for (rate =3D 0; ; rate++) {
> +               struct dev_pm_opp *opp __free(put_opp);
> +
> +               opp =3D dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
> +               if (IS_ERR(opp))
> +                       break;
> +
> +               dev_pm_opp_disable(cpu_dev, rate);
> +       }
> +
> +       freq_table =3D kcalloc((max_opps + 1), sizeof(*freq_table), GFP_K=
ERNEL);
> +       if (!freq_table)
> +               return -ENOMEM;
> +
> +       /*
> +        * Cross check the frequencies from BPMP-FW LUT against the OPP's=
 present in DT.
> +        * Enable only those DT OPP's which are present in LUT also.
> +        */
> +       cpufreq_for_each_valid_entry(pos, bpmp_lut) {
> +               struct dev_pm_opp *opp __free(put_opp);
> +
> +               opp =3D dev_pm_opp_find_freq_exact(cpu_dev, pos->frequenc=
y * HZ_PER_KHZ, false);
> +               if (IS_ERR(opp))
> +                       continue;
> +
> +               ret =3D dev_pm_opp_enable(cpu_dev, pos->frequency * HZ_PE=
R_KHZ);
> +               if (ret < 0)
> +                       return ret;
> +
> +               freq_table[j].driver_data =3D pos->driver_data;
> +               freq_table[j].frequency =3D pos->frequency;
> +               j++;
> +       }
> +
> +       freq_table[j].driver_data =3D pos->driver_data;
> +       freq_table[j].frequency =3D CPUFREQ_TABLE_END;
> +
> +       *opp_table =3D &freq_table[0];
> +
> +       dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> +
> +       /* Prime interconnect data */
> +       tegra_cpufreq_set_bw(policy, freq_table[j - 1].frequency);
> +
> +       return ret;
> +}
> +
>  static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
>  {
>         struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
>         unsigned int cluster =3D data->cpus[policy->cpu].bpmp_cluster_id;
> +       struct cpufreq_frequency_table *freq_table;
> +       struct cpufreq_frequency_table *bpmp_lut;
>         u32 cpu;
> +       int ret;
>
> -       policy->freq_table =3D data->clusters[cluster].table;
>         policy->cpuinfo.transition_latency =3D 300 * 1000;
>         policy->driver_data =3D NULL;
>
> @@ -85,6 +191,20 @@ static int tegra186_cpufreq_init(struct cpufreq_polic=
y *policy)
>                         cpumask_set_cpu(cpu, policy->cpus);
>         }
>
> +       bpmp_lut =3D data->clusters[cluster].bpmp_lut;
> +
> +       if (data->icc_dram_bw_scaling) {
> +               ret =3D tegra_cpufreq_init_cpufreq_table(policy, bpmp_lut=
, &freq_table);
> +               if (!ret) {
> +                       policy->freq_table =3D freq_table;
> +                       return 0;
> +               }
> +       }
> +
> +       data->icc_dram_bw_scaling =3D false;
> +       policy->freq_table =3D bpmp_lut;
> +       pr_info("OPP tables missing from DT, EMC frequency scaling disabl=
ed\n");
> +
>         return 0;
>  }
>
> @@ -102,6 +222,10 @@ static int tegra186_cpufreq_set_target(struct cpufre=
q_policy *policy,
>                 writel(edvd_val, data->regs + edvd_offset);
>         }
>
> +       if (data->icc_dram_bw_scaling)
> +               tegra_cpufreq_set_bw(policy, tbl->frequency);
> +
> +
>         return 0;
>  }
>
> @@ -134,7 +258,7 @@ static struct cpufreq_driver tegra186_cpufreq_driver =
=3D {
>         .init =3D tegra186_cpufreq_init,
>  };
>
> -static struct cpufreq_frequency_table *init_vhint_table(
> +static struct cpufreq_frequency_table *tegra_cpufreq_bpmp_read_lut(
>         struct platform_device *pdev, struct tegra_bpmp *bpmp,
>         struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id=
,
>         int *num_rates)
> @@ -229,6 +353,7 @@ static int tegra186_cpufreq_probe(struct platform_dev=
ice *pdev)
>  {
>         struct tegra186_cpufreq_data *data;
>         struct tegra_bpmp *bpmp;
> +       struct device *cpu_dev;
>         unsigned int i =3D 0, err, edvd_offset;
>         int num_rates =3D 0;
>         u32 edvd_val, cpu;
> @@ -254,9 +379,9 @@ static int tegra186_cpufreq_probe(struct platform_dev=
ice *pdev)
>         for (i =3D 0; i < TEGRA186_NUM_CLUSTERS; i++) {
>                 struct tegra186_cpufreq_cluster *cluster =3D &data->clust=
ers[i];
>
> -               cluster->table =3D init_vhint_table(pdev, bpmp, cluster, =
i, &num_rates);
> -               if (IS_ERR(cluster->table)) {
> -                       err =3D PTR_ERR(cluster->table);
> +               cluster->bpmp_lut =3D tegra_cpufreq_bpmp_read_lut(pdev, b=
pmp, cluster, i, &num_rates);
> +               if (IS_ERR(cluster->bpmp_lut)) {
> +                       err =3D PTR_ERR(cluster->bpmp_lut);
>                         goto put_bpmp;
>                 } else if (!num_rates) {
>                         err =3D -EINVAL;
> @@ -265,7 +390,7 @@ static int tegra186_cpufreq_probe(struct platform_dev=
ice *pdev)
>
>                 for (cpu =3D 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
>                         if (data->cpus[cpu].bpmp_cluster_id =3D=3D i) {
> -                               edvd_val =3D cluster->table[num_rates - 1=
].driver_data;
> +                               edvd_val =3D cluster->bpmp_lut[num_rates =
- 1].driver_data;
>                                 edvd_offset =3D data->cpus[cpu].edvd_offs=
et;
>                                 writel(edvd_val, data->regs + edvd_offset=
);
>                         }
> @@ -274,6 +399,19 @@ static int tegra186_cpufreq_probe(struct platform_de=
vice *pdev)
>
>         tegra186_cpufreq_driver.driver_data =3D data;
>
> +       /* Check for optional OPPv2 and interconnect paths on CPU0 to ena=
ble ICC scaling */
> +       cpu_dev =3D get_cpu_device(0);
> +       if (!cpu_dev) {
> +               err =3D -EPROBE_DEFER;
> +               goto put_bpmp;
> +       }
> +
> +       if (dev_pm_opp_of_get_opp_desc_node(cpu_dev)) {
> +               err =3D dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
> +               if (!err)
> +                       data->icc_dram_bw_scaling =3D true;
> +       }
> +
>         err =3D cpufreq_register_driver(&tegra186_cpufreq_driver);
>
>  put_bpmp:
>
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251021-tegra186-icc-p1-8455e61d453d
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>

This was originally part of a larger series [0], but it was requested to
be split into smaller series.

Aaron

[0] https://lore.kernel.org/r/20250909-tegra186-icc-v2-0-09413724e781@gmail=
.com

