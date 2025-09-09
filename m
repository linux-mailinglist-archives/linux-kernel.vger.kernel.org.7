Return-Path: <linux-kernel+bounces-807781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A377B4A923
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D84E7CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00962D24AC;
	Tue,  9 Sep 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GC/z7LbL"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8F2C11D3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411884; cv=none; b=Nm1ZZ9UzGw3cECitw25WoqwveQAaU1rvkhdVn5m9iMv7hZUljDs5tHQkxXQWsFqwdxVfr3BNPBvOzq3xyhkbFak7SB3wRAmAj1fO09EpC7BkJ4jEtm4eGkNHW2nhPIsaYULUfByNTN5rnBFGRvEEY7oZkoET/Hz+tVEtLNEWrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411884; c=relaxed/simple;
	bh=vLeBSs9UlsM0Nvan6ljMar45tgpAptKGKo+XZ+E4kHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfXyhGlMnsHKdBfb6Y3maLFf22TNKtXa65Sbkv9ZAYagC0+C4LdTeW3umPnx/n/HQgC6WLqoUq+TIHOMBKX/K7i/kKKPDvWoMm65t5Q/MyI/CCtBnBRS3p805ACSClJ5ad/9YnybhNoK1P2cPZuR6NN1krjxcfwaqnnzEa1qc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GC/z7LbL; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336b0b3d753so54677041fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757411877; x=1758016677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9Q/SBeaavLyqr+XPkX2WQCCkix4ESkAOHpRDrEhCu8=;
        b=GC/z7LbLUcb/5BJUCveJOtkVK3zmvVB5lRtoPtgATPl0naLYuXllIWPx648j2j2Z2e
         HMA0AfjxfkufcZiOV0Ql5aNw6Eyq0E7qPW/RQEH4Zkp9D1PsBvPnGET9QScRMgM/ix+H
         QJQo65Eezf4ESRf9oZwtG3KZVYgtaxL53cCmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411877; x=1758016677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9Q/SBeaavLyqr+XPkX2WQCCkix4ESkAOHpRDrEhCu8=;
        b=Viqux2CMwxNlkS+ukOOqypZr0ZSc2znC4rw1brrf6Uk44n7cah0/rYHCFZwXa6DDPD
         AKwWJGGAHxMUkeduskFTQzFg6OH6c/pRJdjKJyIvHRRcW7gKLEwnw05FT14M4r7AWtcb
         cWC/o3UIu/V8DivY+e2z9o4WU0l2xrepICg+ZJ2rwdBUnj+d/rSgTAmKKC+cCkK+iMT2
         nMrHiTJf1NyLAX2ijkVWAMavoTYJ68Rdcyi13ndkG/GMHOkqDbfQWfZKIvTSrayJ1Wuz
         KY1S0sY3W1Kx+dA3+HjdwSpTITElSlC5OaQUiG56Cww65FmzOnGLyxmOfh3fRHI42Wwk
         H6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOUqKNmHGa+9OsfZoYpGtSsyuV3i+FM6YFRnQlIylTnMX/wbH/QN0oOxqDgo617P31EeFUR+TkKWCTPVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDB4VcpRRTTI4+QKT/yGvPby6/ouk8HnNuG70F8aULh3MiSBQ
	0KtIjOLM628iHfMKIuna3x28WW0qKivsl0fGV85Osy5BTY++kMUtuEucYP8YNVpugtu3Mksz5ZH
	Etkq9jmqBoTGh7M4s/GCAoivG83iQc6bPEnlrKYUK
X-Gm-Gg: ASbGnct32PwRkDY9HrP19RNkgVy7lrDDAxN0UWBjLUK3Sv+PMuJFrM6S3ZPHyOvjllg
	2k5Whw6b2KcOmDHnaQU+5Ha75b0WAzFpGhO1Fov7tm1xC8uN6jorz4fiOPa9CkGkSbkq/77DbAp
	gUetVDUxn9wx2sTXxvmaC0jaKG9THw3fPmNMIu//WahHb0dWEHc8UQVvjSyIY/uXNAmANhwX+eT
	q83Lwpg0Ns4FUQ+9pvRU8u+o4V+eYIOUwxujI/Dycqj6x6Y
X-Google-Smtp-Source: AGHT+IHtBPyRAgJpbhrMNhQvYhuKCwVHTEcLjpAEXVvG2Qe+VaW+WbYg4882F6R1NtG5see0MuJ+hLu/7q6vsaofizo=
X-Received: by 2002:a05:651c:50f:b0:336:e05c:e3d4 with SMTP id
 38308e7fff4ca-33b5e8f6aedmr36499581fa.23.1757411877143; Tue, 09 Sep 2025
 02:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909073819.25295-1-johan@kernel.org>
In-Reply-To: <20250909073819.25295-1-johan@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Sep 2025 17:57:45 +0800
X-Gm-Features: Ac12FXySeIcZbJr55CfFDecjeH7ZG6WTjgfFt9EkkcubagtMiSJ1iQX0YbRtXW8
Message-ID: <CAGXv+5EcnLJHG_50mYb2YB0_q1XOztF84c9tAJJfKZxSCWuUCQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: mediatek: fix device leak on probe failure
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jia-Wei Chang <jia-wei.chang@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:40=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> Make sure to drop the reference to the cci device taken by
> of_find_device_by_node() on probe failure (e.g. probe deferral).
>
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Cc: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Cc: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediate=
k-cpufreq.c
> index f3f02c4b6888..21537a05785d 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -404,9 +404,11 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvf=
s_info *info, int cpu)
>         }
>
>         info->cpu_clk =3D clk_get(cpu_dev, "cpu");
> -       if (IS_ERR(info->cpu_clk))
> -               return dev_err_probe(cpu_dev, PTR_ERR(info->cpu_clk),
> -                                    "cpu%d: failed to get cpu clk\n", cp=
u);
> +       if (IS_ERR(info->cpu_clk)) {
> +               ret =3D PTR_ERR(info->cpu_clk);
> +               dev_err_probe(cpu_dev, ret, "cpu%d: failed to get cpu clk=
\n", cpu);
> +               goto out_put_cci_dev;
> +       }
>
>         info->inter_clk =3D clk_get(cpu_dev, "intermediate");
>         if (IS_ERR(info->inter_clk)) {
> @@ -552,6 +554,10 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvf=
s_info *info, int cpu)
>  out_free_mux_clock:
>         clk_put(info->cpu_clk);
>
> +out_put_cci_dev:
> +       if (info->soc_data->ccifreq_supported)
> +               put_device(info->cci_dev);

put_device() has a check for NULL, so the if isn't really needed.

Either way,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> +
>         return ret;
>  }
>
> @@ -569,6 +575,8 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_=
dvfs_info *info)
>         clk_put(info->inter_clk);
>         dev_pm_opp_of_cpumask_remove_table(&info->cpus);
>         dev_pm_opp_unregister_notifier(info->cpu_dev, &info->opp_nb);
> +       if (info->soc_data->ccifreq_supported)
> +               put_device(info->cci_dev);
>  }
>
>  static int mtk_cpufreq_init(struct cpufreq_policy *policy)
> --
> 2.49.1
>
>

