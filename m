Return-Path: <linux-kernel+bounces-825226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA783B8B536
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453C6A02AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8B2D1905;
	Fri, 19 Sep 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUt3O2Zl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420162D0617
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317012; cv=none; b=DX0yWS3sYv0XDFHtfWN9ykdn6pfDMcB7Uw7Ibe/hGVQbwpdd4HfkIuhYN4/0y5djMKGszjElf8emW4jF2gfMrRuX0wB9nQV4/fjx61WLuAqg1Voni22aEUGnl7sNNh/Et81VEpxrIDKv2bXvUrPDM1fI7yjE1xgE1PU+bHMyPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317012; c=relaxed/simple;
	bh=Mus4C9esnPUAx29I8Ebsex+Cx5Mb25n/skDJMlwEYWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F04O2EHEz28B+j2mscadn/H6oS3+LRdimVzR4uaVVW7Z2kfV8Q1g2z6XdOukB/D0AOUipghyn9y6pvNeB0pdAN6zixgFwEKdPm3i9nnMooXthxE4CYc35pJ5lifjG1otJPtE/vVS7Q8msdYdC2B8V0Dnrt8sRaeYmEy4cuMSI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUt3O2Zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2681C4CEFA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758317011;
	bh=Mus4C9esnPUAx29I8Ebsex+Cx5Mb25n/skDJMlwEYWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PUt3O2ZltJFMDOto5TUuBLGCXN69100NbGt9ksqtjCqEiGg5ayjnrtY+2EDFA3bnA
	 7CZ9G9HebqcsQmUTbFvkzjBYdClvfXYqA0e6cIbK4eVYI0YDNaq0HviEJV4QT+npQd
	 7/qxx7Ia+45cSTHHj+sFwG3f9KePscGdv8sg6PHxnF6VvdVah5+qQEnLZvN4j7AUzH
	 l0r5panWybfblueub9x7FWacjIxoEOdixqD12VZ6hTYgXiq/nkJt+okY/gomsc2450
	 CV2ycSCnoAKe8V7Gd89Vx9PgoBhLx+qAkYEx+lk7CkhpkMuYIwfwC6zmfbIkTTdKE5
	 qAIk+7pzpxkvQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cce5be7d0so1206959fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:23:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlpEfelaKri/IkkUM5B5pkqnlZlMusdIIRzfLuD1Hp6iwD5JmqPytbGTAq6auq7f3ccGCRl4tIQJNyfTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVXJrPEUskus1jUXRzm4DVUX1IuXfthgdo+qt5zxFc+KDiQjN
	tO0utPZpwcwnL0W9yVVQxkpzp2CUMp8h9iQSOdxyqkLCmu3o0IsjfNQ5FvY0lOWVdMdQYO2sSh4
	HhoeivNaWCkHsCSxUdhigw00HDiNWd2I=
X-Google-Smtp-Source: AGHT+IE7ElRHaRGRktvVK45BptE2BVF7iG4w75CjDKLH0k31Wvji/o6p+tJtDxVaRRPQEDgd4RIBbt9jHs4wY6NlADU=
X-Received: by 2002:a05:6808:bca:b0:438:8c9:5f4 with SMTP id
 5614622812f47-43d6c19c11bmr2321873b6e.19.1758317011042; Fri, 19 Sep 2025
 14:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912073502.743735-1-tianyaxiong@kylinos.cn>
In-Reply-To: <20250912073502.743735-1-tianyaxiong@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 23:23:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwyvdiuiKhXh79jwQe=1G+=mohrdtnSo2f8+s6-KZWjg@mail.gmail.com>
X-Gm-Features: AS18NWBsNWC5hi6eVw9L4pzpnBy4Mqr8BLjyCBprj5irs95Urhyiv8ZP-KTDmyI
Message-ID: <CAJZ5v0iwyvdiuiKhXh79jwQe=1G+=mohrdtnSo2f8+s6-KZWjg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use likely() optimization in intel_pstate_sample()
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 9:35=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.c=
n> wrote:
>
> The comment above the condition `if (cpu->last_sample_time)` clearly
> indicates that the branch is taken for the vast majority of invocations
> after the first sample in a cycle. The first sample is a one-time
> initialization case.
>
> Add likely() hint to the condition to improve branch prediction for
> this performance-critical path in intel_pstate_sample().
>
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 2519eb527468..d540f2ab9a52 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2531,7 +2531,7 @@ static inline bool intel_pstate_sample(struct cpuda=
ta *cpu, u64 time)
>          * that sample.time will always be reset before setting the utili=
zation
>          * update hook and make the caller skip the sample then.
>          */
> -       if (cpu->last_sample_time) {
> +       if (likely(cpu->last_sample_time)) {
>                 intel_pstate_calc_avg_perf(cpu);
>                 return true;
>         }
> --

Applied as 6.18 material, thanks!

