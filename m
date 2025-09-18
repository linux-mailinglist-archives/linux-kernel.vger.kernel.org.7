Return-Path: <linux-kernel+bounces-751393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4852B16918
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5967A6F35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C1232369;
	Wed, 30 Jul 2025 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSSTxRp6"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3E22422E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914901; cv=none; b=QiUBvxHCX9FdhFa/zLeZOSvpk8qnmYQ7REAMNd/LnDR7yc7RnG1DjI2PQVXz+zKA/BCrvFZYaoLDP53l1NusI6Y5ccO+WN14qQkNoYNf7wMdJ3BaJ0kG9BqtLrjW1CXDkhk8XO/HwuIaMb8lkU/lJqzNMfSn+bB+uUY5JQaGAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914901; c=relaxed/simple;
	bh=2fk7Lmp7GQcfI+scgJXRMAuE5War32ra1deNa9zkIDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE+IqhIz2xOgD17GcUe9SC8rrWtW8XEsXU3jKO5oTPC+99B7232oxBv1cACcwUCgMGIAHRMNB/7Xf789T6K0en/W7+13vyNu8i/gdrWE/7wS92uEbXhSoV7dzN4BjU3vDG/fimps7AGboVEs41YjatLYavSLQzAewhlsLKc2WwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSSTxRp6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab86a29c98so104081cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753914899; x=1754519699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8kQ4bfCiQxnkckR4mjXN6hX/e097lJxxAb3MZbkRgNM=;
        b=PSSTxRp6bqR/onUSru6WYLD3dDC2gqK/nr460IeC6lq7FiAm9ScsljRYE7j3ChhFYa
         ybMMnFA9lgzTYoOy38/TlIYSoWSHXNfVTjiVVzUPJuJEeLLEbePZHzfUZBXRB6RkM2qT
         kkTBvm8WJl2jAGmwt3YQtwoClRTy43jc4fblyUgv1DtFx2BVaFAtXHUjqIevXQXUSX53
         foR6sPL4ArTUCns6/Ddn74pcZ/2r/IAWD4vtNNz7SEEbZg4tpefZyW1UN54IPmEAkMM1
         6KIA5TXu5Ri8UouGlNnph3qhg18UUjCeijiJAJyYKFCGjBtWXOX7tyFdL1oAWVhgHNVz
         CO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914899; x=1754519699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kQ4bfCiQxnkckR4mjXN6hX/e097lJxxAb3MZbkRgNM=;
        b=gqEGJyAUG7six4oDUDhrXCsCzE5HakUPN+/cOCtxCFAbjCGQC8upl0o2+zgo44eoky
         0Vk5JazHkktnKgWPrOx7R5XrBiQTaWeYIdWdANhnZIZFeC/YEBubaouPbW7sVTmo8eb9
         g3LphXd4jD5MU89QSO5nv8UkNSqxDYOoFGyF9dcRN/G21Qm/XpZ/jt2psFPw4s6Qg2Pe
         8a2k8WTXntYwWpuYSFuRC+UrjdvuYXYeGHFpGOEh494hOBmjNSICVAAgLESnqIjsA2KN
         Ohk0OvBGRJd9yYy493feCCb7IAHFZQ07JTS5XfRAYhdK9OBLofo7/rORjmSpLs0oPZEU
         OgDA==
X-Forwarded-Encrypted: i=1; AJvYcCUMf+CfzCaUUU9ClDtriZoBlGMnEzzbq9x5pIvyPQdNdmCzbHyRQKrPOMN9PmUpCe8yOl8P6VGyUhI7hOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RCfCgfPR9ohfcluVSI8FzQ+4BW3owrBlAkvK6dvIaxQ7wZ1/
	3FfpSaI+0C8qg3WQgcVo+X9P55S4OcmJ/ayOxfveP85eeHwjXr5ejQ13Loqkgaw7mYl3e4wVf/O
	1arK3KGGfJrpo6ZVUlaAl/cVMLYgCDEhzhfi7yYkI4CiIUnXCH9HHAWe4WWw=
X-Gm-Gg: ASbGncs/Skr6csQlGJ9eCWr9VcHwWpQbaw3Vo+vvbBujrxLggVvoK7/ts4UR0jFK/Xp
	3UsDFs62OL45WH5qJCK/G2HUJfnZIgTSbGxAR9WpdI9bd4RWcUiLyhR9103NQFGH7yQDPovBZqn
	c29KzqUryC9EszCv8lbODb+/Z0EEjOga7CPaSTZ0OlYptEZ/jBmojL7+ejSS+wJxsR0phBOiVl0
	j0cQWs2bA0AnOLVzkelbMBoBD/KcEqxxw==
X-Google-Smtp-Source: AGHT+IGlZnMidGeylHmeMBI9Al3pOpa1i+4rutb6h3joKg0QO4oZntcS55qYmjUS30Z7Qx/HMHcxsZMWn33hnNIJcj8=
X-Received: by 2002:a05:622a:1207:b0:4a9:7c7e:f2f9 with SMTP id
 d75a77b69052e-4aef0376a7emr246241cf.17.1753914898419; Wed, 30 Jul 2025
 15:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730032312.167062-1-yubowen8@huawei.com> <20250730032312.167062-3-yubowen8@huawei.com>
 <20250730063930.cercfcpjwnfbnskj@vireshk-i7>
In-Reply-To: <20250730063930.cercfcpjwnfbnskj@vireshk-i7>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 30 Jul 2025 15:34:46 -0700
X-Gm-Features: Ac12FXzJKlOTvvQVQrnkjqm_RZrHhkujSCGJ9c_8nKLlG-C3SKCPflENeEsLJLM
Message-ID: <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in cppc_scale_freq_workfn()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bowen Yu <yubowen8@huawei.com>, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	zhenglifeng1@huawei.com, Beata Michalska <beata.michalska@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for adding me, Viresh.

On Tue, 29 Jul 2025 at 23:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> + Prashant/Beata/Ionela
>
> On 30-07-25, 11:23, Bowen Yu wrote:
> > From: Jie Zhan <zhanjie9@hisilicon.com>
> >
> > Perf counters could be 0 if the cpu is in a low-power idle state. Just try
> > it again next time and update the frequency scale when the cpu is active
> > and perf counters successfully return.
> >
> > Also, remove the FIE source on an actual failure.
> >
> > Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 904006027df2..e95844d3d366 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -78,12 +78,23 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
> >       struct cppc_cpudata *cpu_data;
> >       unsigned long local_freq_scale;
> >       u64 perf;
> > +     int ret;
> >
> >       cppc_fi = container_of(work, struct cppc_freq_invariance, work);
> >       cpu_data = cppc_fi->cpu_data;
> >
> > -     if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
> > +     ret = cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs);
> > +     /*
> > +      * Perf counters could be 0 if the cpu is in a low-power idle state.
> > +      * Just try it again next time.
> > +      */

FWIU the performance counters shouldn't be returning 0 in an idle state.
Per the UEFI spec [1], they increment any time the CPU is active,
so they should just return their last counter value before they went into idle
(of course in the FFH case an IPI is performed on the target CPU, so even
if the CPU was idle, it will get woken up).

As such it is better to either :
- Check for idle_cpu() directly and return (see [2] for the function)
or
- Always clear the source on encountering an error return value.

[1] https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#performance-counters
[2] https://lore.kernel.org/linux-pm/20250619000925.415528-2-pmalani@google.com/

HTH,

-Prashant

