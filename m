Return-Path: <linux-kernel+bounces-849904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A01BD13B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1D31896813
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18627FD64;
	Mon, 13 Oct 2025 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXUl1n8I"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F71F419B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760322770; cv=none; b=MkqtU/O8ugojEXe0vhbZVS9JFg/nevIlfywOZzg7yRFa/Wur+hhhdMJhA3fdnWuJ8+7ak/PvKJRvQYox/ZmUEEQHm2x1ey2DObNMAqoBck01n+e+LlNP28shf7zfiKIIkP781RzYSMgzW0fpIFPzn80zbFgr2VLEoxsx2oz/N6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760322770; c=relaxed/simple;
	bh=Mobd2nPQjln/iaGH+phCc81JbmWHC6V+ZX+OEP8c6WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZ9WRnt5wobppYpKKRzGcAkCKU/EmavFa/tA2rzSWnYmFE8pmWoXIyoLB/HC1kAi+nbCvjOXjiqBTl6G2dNZ6UIkEYJfCbEFSfBn+agFjN4h0DFXI1FH0pqJdRppesYQFMBXt3O12xBsDfI85NUF1hSK6SJvE7o2dZ86ZlQcT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXUl1n8I; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59070c9111eso4546321e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760322766; x=1760927566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSyKix+dExsW53zwh7yt2N4OdGXjl30i0H4cWLjWmaI=;
        b=AXUl1n8IHV3cVpOOSU6jhy5H9gRtJCqQqlFmwpSNEXYIIAxjniKANxWCRPkgyI4F9b
         FZCYvgFHjRlFhzyElVY9ULVvkhqDJUP3I5K/6ywQpgL82np+hl++/lu8EkH1Ycdxp/Kd
         aq9ZDSEqmTi1mVpQQBhurmmsq7UX0Sj806RIM2uqwoLL8H0k8SC4gfrz3ZTbKsQdRayu
         IhraNnBEIsv/XDqbqvjo2/Xwn2pBVg/Mqcp/kwj1PD3fM72o1zTf2+DRxr+W1PajRVRd
         O2osOnO4xKgLCkIDgjNrNuGMYbWlbwiubp+/O9q7GJz8tzKH2wpj4yZGIEHjKxBrpjbf
         UC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760322766; x=1760927566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSyKix+dExsW53zwh7yt2N4OdGXjl30i0H4cWLjWmaI=;
        b=Ag7IMssqW7YYKru3XfB6A5dUYTcT8N4e3n+hD2t0ghGR13avcHp9ZbZlPINGIDE1s7
         ImIEiBRgn2KkP5+xO9l5ZMkQ/yBiUHhgBzkKKqE5TVb8GtkA2ysyett9K0Yr6eAMYct/
         NYkqSp9H1S0PzEMzj0Ff64VXQiXbJOP7sHEqWfndHApaPVQUU0j8p+Ru/C4+4snwn7iR
         /mdQ8w/rjNX4TmI1tYf+uE5inY9QTpFaeYt+iudE+olV3V8JzoaEPDKIB2AhgeuGbBk1
         DFXTLMBq2tmrYhBIg2kNBR0af08RJwGbbqninSv+J+zI91HVjYtTjZhrBY3pL0I/e5fe
         QyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm9abTUcb89o0kHZdWhAqmqfycwxP8sofybqJ9UrOwpX/X/ztJBO3wTuO4RIng3KpgdVWlibT98MD/k/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YycqxOERu8tYAV1fAxdN9huzO+tQyVOX2MclM5C5HJEGnvVvzAZ
	ut/aXwaj5lfjWhmmuB7FA6vHn7/1h+XIOtd/puxeUzwy8s3QLZheuTJT8UI2XefPwqMlu65jbgJ
	12Z+Z52tyfwBX9sLyNo9iKLmcHTusWH0=
X-Gm-Gg: ASbGncvcIwpm7OrQbipT20EafXw9po33aimIEbu93U30xuVqw5EqKenTW/OV9qDUwA8
	vTxGYDcHz6r6IEhY0WW7P8qc7ouOb69/DoTXrlL6E+itwYbJI8ZvUqOP+wljYkVxCsdER/KANv9
	aAHqyvuqBwry9+GoDkaf6AfD9N51DBSZ94HoE9QlywL6ylkaghq5aagCsi9pqhb+FojnDpKUnWw
	ulfrji2f41LebO4wGDI+hhKuw==
X-Google-Smtp-Source: AGHT+IHWj20Z//Zd/Bj3pk8xg9qchfT20FaF7gZ8rC2cQFm5rgDMz1ihnaPh6KkjuMjFtQn3GvJXwEat84MrHNsMau0=
X-Received: by 2002:a05:6512:31c2:b0:57b:7c74:67e6 with SMTP id
 2adb3069b0e04-5906d75f85bmr5366512e87.2.1760322765941; Sun, 12 Oct 2025
 19:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
 <20250909-tegra186-icc-v2-1-09413724e781@gmail.com> <20250930103006.octwlx53p2shwq2v@vireshk-i7>
In-Reply-To: <20250930103006.octwlx53p2shwq2v@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 12 Oct 2025 21:32:34 -0500
X-Gm-Features: AS18NWDaKTgv8GyE1hN1DRdGL5_G-8YoPjy4LzB-vGT0ghwtG2kFi7JSPl6_Rmg
Message-ID: <CALHNRZ84s8rxQKWZeF-bfS31nK6ay4_MspmYa4+qapf9gtk+Fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] cpufreq: tegra186: add OPP support and set bandwidth
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 5:30=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 09-09-25, 01:21, Aaron Kling via B4 Relay wrote:
> > +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigne=
d long freq_khz)
> > +{
> > +     struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> > +     struct dev_pm_opp *opp __free(put_opp);
>
> The usage here looks incorrect..
>
> > +     struct device *dev;
> > +     int ret;
> > +
> > +     dev =3D get_cpu_device(policy->cpu);
> > +     if (!dev)
> > +             return -ENODEV;
>
> On failure, we would return from here with a garbage `opp` pointer, which=
 the
> OPP core may try to free ?
>
> Moving the variable definition here would fix that.

If the var was NULL initialized, would the free handle that correctly?
Keeping the declarations at the start of the function reads better
imo.

Aaron

