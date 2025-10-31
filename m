Return-Path: <linux-kernel+bounces-880735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1304FC26650
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D0AD351F99
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D92A33E37A;
	Fri, 31 Oct 2025 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFwG9B4w"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E533E374
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932053; cv=none; b=nsXsaIzaTix3sHgSMNbWSTmnRIzTPrm0AmopS4XsZG9UjM+nQoqpjdZBlur5am1aYqomQnicM+BBZVqissBaLbfyT1zOqfUUqVXt8JQ+SjgSJEc+x//kSPTVDGbMo9gBUpmlIG64rooTgPnDCQhNWiVs0lNTWh0Lrl6o9Net1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932053; c=relaxed/simple;
	bh=vm2rw9OAVVokG1IKy6SQwFUdmwmv0/uh3ee66zoaA1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzVA4FZjF0tv2S1m+PVY6rW9n/lz+2zTgqjZ0Hf1YKnfDx2i8jIiHyKvS/WWTCHPkfKmFrRIXiLDark9LXpaTVj4q6xnHtlyaq8BXQauv8NAU6EYSg7OJrDd6UbLS7293ZcL/lf2PLc8sP2/aQ0FLpoXh3j49yFO6dIxk04nQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFwG9B4w; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-592f600acb3so3522675e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932049; x=1762536849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6TlDaAKDgJ98uF0vWpMqswF6DNe1E/tMeWskNbv9WE=;
        b=DFwG9B4w5Jdo97RfnkKwZp9wNXv/+3r6IThE/u8soZU1jTAithPYFQHG7JByg70C/T
         JUnnGPlzUAhFWXNtX1MKGXdWagaUxQF3VRhWzkwekGS8+H3qFeeYFkqPvXNkOAjASs04
         CRZxlcPtBjmqo1scG7HGhvOBOZBnH2zaa5nv4bvZLEPc4FVpQLElK9XbS4m6nG98YP+M
         pK8U/B1Un2ntbdKjPkt2rjS9TPMNaagHbTl7RfuwIfQeSj+j4Gs2kbLGu0tDTXnnhyBS
         g1wR4V9EksmFOlbERLUFSz10RLNq4obwYbyhvc94tLvRCSXqgPvnpKRmuEwVH2TzGG9O
         OSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932049; x=1762536849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6TlDaAKDgJ98uF0vWpMqswF6DNe1E/tMeWskNbv9WE=;
        b=o44nagPoq/CZSIhjKsAb0wLbmbE7jR8d7vcE/iJMPwhu835dYYqx8Ltc0B+5oIlERm
         yfRzKEfs+ie6aZYt9knzZzIviMI9ucghi+KVgTirS1kX90uHRC2z1XQ9nnOo8gigEzC6
         Fv1yy6lsUR/HmMjaWmSu0nBBLnsGqOf6kA/Newj2YRcm3zt5egqotby8cw/M2Hv5rK5k
         3ybi2C/b65r1oGV0x1+2Hl+IOCCk+bsBq4caIBtjk0/kxv3gTSeoAdX9zd7kcjWbFcpu
         hqiQh3BkLeJqAQbY/sv0OetMIW3jLsQX0Uo10sXrNbJ59HYrdb96Kx6JpeIXPiofrwGX
         +jpg==
X-Forwarded-Encrypted: i=1; AJvYcCWFgdmb4M1gzO8mW7qxQtwxmyj49hBnR2xT9fjj+FcKy8tZkTYeK9lC4n2IGmL0WLQ2gZ8OQjVtxD9KLVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0IHe7QPIuz2qZU//HPLVpAlKa+nW8oost6TsOxfA0gAmO/hK
	ToTQzwIPkKTqw+r/BsczP0wfp/oxRvdNgSqv7yHjwN2adHEO8ia+CN5N9DXuyy1ex3WEj5koDu/
	SI3JggahWgJC3XG0lbOEbNarBv6xHDNY=
X-Gm-Gg: ASbGnct37O43c7azJ2j7D56UOYT6PtfzWXJ4Ma3ZmjgS8We90gCbFEhwdVHsGRJpqF5
	BIZPlozxvXdorrT18fiVkfX79w2WfqxG961ZcgDXLLVo+TSgujKt0zyEAuTC4wgz0x712xGAzwE
	NJFj40bW7kaZP50Q89jHn99gq26x6LHexLM7Gt2RpBwbb/vjovs9hV92da+9A2FjneXEE5QgSUY
	sQgHVRwCdWoMotLtOpkLJOBsXYC3YjBBSvKtG7Excr1O/E1yEyvofsUJOfw
X-Google-Smtp-Source: AGHT+IHhMeiEyIqzYzHJijcl5TBTNGDRr/d5tb8yS2TDpbW9JbWHSHKcLowQEjw24NE6wUQ1efQ67W+06guv2WUu/pY=
X-Received: by 2002:a05:6512:3e12:b0:592:fbb6:889f with SMTP id
 2adb3069b0e04-5941d52a9bamr1587311e87.20.1761932049165; Fri, 31 Oct 2025
 10:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-t210-actmon-p2-v6-1-1c4bd227d676@gmail.com> <865037d1-c89f-4142-a66f-3283c17bf533@kernel.org>
In-Reply-To: <865037d1-c89f-4142-a66f-3283c17bf533@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Fri, 31 Oct 2025 12:33:57 -0500
X-Gm-Features: AWmQ_bndHaJNZHt0znns91r43ADIO5ad3kOUvwSt-EKT1lzX_wlGtIud0hl6pEo
Message-ID: <CALHNRZ_gvEdkjmum-VZa050HOPPweD8sL4K68-j3PLRc1pCErg@mail.gmail.com>
Subject: Re: [PATCH v6] memory: tegra210: Support interconnect framework
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:19=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 27/10/2025 18:48, Aaron Kling via B4 Relay wrote:
> > +
> > +     err =3D dev_pm_opp_of_add_table(emc->dev);
> > +     if (err) {
> > +             if (err =3D=3D -ENODEV)
> > +                     dev_err_probe(emc->dev, err,
> > +                                   "OPP table not found, please update=
 your device tree\n");
> > +             else
> > +                     dev_err_probe(emc->dev, err, "failed to add OPP t=
able\n");
> > +
> > +             goto put_hw_table;
> > +     }
> > +
> > +     max_opps =3D dev_pm_opp_get_opp_count(emc->dev);
> > +     if (max_opps <=3D 0) {
> > +             dev_err_probe(emc->dev, err, "Failed to add OPPs\n");
> > +             goto remove_table;
> > +     }
> > +
> > +     if (emc->num_timings !=3D max_opps) {
> > +             dev_err_probe(emc->dev, err, "OPP table does not match em=
c table\n");
> > +             goto remove_table;
> > +     }
> > +
> > +     for (i =3D 0; i < emc->num_timings; i++) {
> > +             rate =3D emc->timings[i].rate * 1000;
> > +             opp =3D dev_pm_opp_find_freq_exact(emc->dev, rate, true);
> > +             if (IS_ERR(opp)) {
> > +                     dev_err_probe(emc->dev, err, "Rate %lu not found =
in OPP table\n", rate);
> > +                     goto remove_table;
> > +             }
> > +
> > +             dev_pm_opp_put(opp);
> > +     }
> > +
> > +     dev_info_once(emc->dev, "OPP HW ver. 0x%x, current clock rate %lu=
 MHz\n",
> > +                   hw_version, clk_get_rate(emc->clk) / 1000000);
> > +
> > +     return 0;
> > +
> > +remove_table:
> > +     dev_pm_opp_of_remove_table(emc->dev);
> > +put_hw_table:
> > +     dev_pm_opp_put_supported_hw(opp_token);
> > +
> > +     return err;
> > +}
> > +
> >  static void tegra210_emc_detect(struct tegra210_emc *emc)
> >  {
> >       u32 value;
> > @@ -1966,6 +2222,14 @@ static int tegra210_emc_probe(struct platform_de=
vice *pdev)
> >
> >       tegra210_emc_debugfs_init(emc);
> >
> > +     err =3D tegra210_emc_opp_table_init(emc);
> > +     if (!err) {
> > +             tegra210_emc_rate_requests_init(emc);
> > +             tegra210_emc_interconnect_init(emc);
>
> This looks like new ABI or did I miss something and it is already
> documented? If so please always mention in the changelog that bindings
> are already merged to master tree.
>
> Same question for earlier PM OPP.

Both of these bindings were picked up on v3 of the original combined series=
 [0].

Aaron

[0] https://lore.kernel.org/all/175749727162.29308.12636309161261093675.b4-=
ty@linaro.org/

