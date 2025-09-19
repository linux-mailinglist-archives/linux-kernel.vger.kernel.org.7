Return-Path: <linux-kernel+bounces-824415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BEB89261
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A1D1C8223F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAED309DA8;
	Fri, 19 Sep 2025 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NalluPQd"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D5B244668
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279152; cv=none; b=QE1TdvuOxGcDyPEABROOF8AEFcjVweRXRS9wW4wnM4eYJFxsh59ezzcVw+gbutoP0aeWWuiJFA0nKrzdSnvkmXU36HOdR4j4syMy+euxOu3kC4Ik4LNafVWqk4GtZHUoFha/DTVlxGQQxXGz+ZQ6r9ZbGG7HN0qt79GrbMIxbqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279152; c=relaxed/simple;
	bh=Uh7RA+SkqfZ23yJNTc2e3SnZ3wd3GErf0OaU341/ICM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJHn957DRyVArHu6U+NFjQA3vlSH2TZ1jOCAl+fCmfQo2Tu5aw2Fv6F7fRbxr7PLEEMicQ+1AG2UrpEwCCuBV+Fwsh8ibYYGieYxxBqOAGDe4afQqLpBgA+ZMwpTWpalMovRT+z9RWSQCIl37wrzqPj6QageDlzx5yTfUtWhBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NalluPQd; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea856357c38so605074276.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758279149; x=1758883949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzzD9mUUMKzw0ugA88AiWwEs70VRCzFRfuxqcw3uI/U=;
        b=NalluPQd+xpui/McZFiH5eDsZZOgNdvLbkiZaPoYffERpDGPIMK1jK+JnCNnJPMGXS
         83XTY+Po/9JzwFdYRKwuobHZfi4nB0giKzlHWaMUv0ZZRNCFcPx+onM7uux98Ky0Xsfs
         n6+Jl1ympyLMiEjazlJ6fxzHkA9mOBBxCqc5C2fhA2uTGtmn5+9RS3t7xJTqnKwAm0ah
         /u6vW7l78YVNZFJn02uCNM5jtPfb7ukWHmVNY2jmXnAeyIeAsM+DNAb3KyUFHo8g8do5
         VlqE1ZphnZQzIwKlgVgFoq9S67xY2AJe/H3fCvN4TzBUGY3oGke8z2cwNELGt1GpR7rr
         IadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758279149; x=1758883949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzzD9mUUMKzw0ugA88AiWwEs70VRCzFRfuxqcw3uI/U=;
        b=LdoGe57a37qliJDPcvVmxYOF+GYKKg7jbluoTM8izfwPGme9rrMMXILk02hasLf4p1
         Ec/QQuCiovsa85dmZNU1scWV/DDpQgSZPq0oQnBHsuFBYAkHPeozMeqxTJ06M+lPXatU
         aaN76kgnk5XLDIBPzzll/4FTeSh9anwQDgSTGi77OLAjKLDaPXyrd6Cjowa1uXYeVf2F
         nleNi2nfSd0+hRIT0QXYmXu6A+k0eoaixs0iNhWfd7XuvjA32/dMDQEmk6/lgISSbesY
         5l9PSdYQFwvIyqGcBpc87e8dnV5cXY8rl3Nyr9V+1Hv4yTN3/LNyydOcL5ngQc6VWh6U
         QTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAy3F1T1JFdmFw7Jtj7YwVnsP4BJFA9MzWKL5ELrUm3z80MTAnMMVYe28iX/mKgx7+kOAZFU+9MqNmY9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWBrfsiGDb7tYlGapsYtfebW5OfxL345Z1vE5A8eCL2lIbRFC
	Nrj86ncCEHxSLYOWMwOt92CySGI1xsYzuSYcl2cTT0w6TXT29Lfx4n7hXPKnevRjU4Z1ntnpel0
	NXIYfxAW+a2FrDYRrHr2SUnaTlQk+zg3SNPU6OMG3Ow==
X-Gm-Gg: ASbGncu18Es0528fsZZC4ycDntPrkVrXGHdUqeUMM6AjHaWN7xFCTNHrtA4YFFyo0if
	ctMzvLAaByztO1P/+Ot0IOe7UwItZXRcHv56RIzCwZ6ccP/J9QOKKNplc7zP83VNUEVSYO0xYXW
	8x28z5WpeeNMRyp8GynMmkStKe8hCMiRWi6ul8JX128/sZHXg3JhyNzIOAAPIX2D1VNOXIwnsKc
	8SnJRfz
X-Google-Smtp-Source: AGHT+IHI9nO8lq5Pp2KudwoTpRKFpuZ3FdUKlTe15qwsxTFT/SmijXYfhYuulGFKS6hWzbTrYiBzrkFA3kl3zO1cVww=
X-Received: by 2002:a05:690e:1449:b0:633:b7cf:cb16 with SMTP id
 956f58d0204a3-6347f5937b3mr2337155d50.26.1758279148519; Fri, 19 Sep 2025
 03:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912084112.2795848-1-mikko.rapeli@linaro.org> <175822973684.1568500.2874531983654815490.b4-ty@sntech.de>
In-Reply-To: <175822973684.1568500.2874531983654815490.b4-ty@sntech.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 19 Sep 2025 12:51:51 +0200
X-Gm-Features: AS18NWAi0MBQy69KlaoQfcok2GqNKVNbSAgXUL0xqECXbJKR8EN79nmBjPlkClA
Message-ID: <CAPDyKFogz=nym2CGh0LJpVad5hmycdfeoYta4DPfY4b4ozDMVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: select ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	linux-kernel@vger.kernel.org, adrian.hunter@intel.com, 
	victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	geert+renesas@glider.be, angelogioacchino.delregno@collabora.com, 
	dlan@gentoo.org, arnd@arndb.de, zhoubinbin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sept 2025 at 23:09, Heiko Stuebner <heiko@sntech.de> wrote:
>
>
> On Fri, 12 Sep 2025 11:41:11 +0300, Mikko Rapeli wrote:
> > On rk3399 based rockpi4b, mounting rootfs from mmc fails unless
> > ROCKCHIP_PM_DOMAINS is enabled. Accoriding to
> > Heiko St=C3=BCbner <heiko@sntech.de> all SoCs since 2012 have power
> > domains so the support should be enabled by default.
> >
> > Failing boot without CONFIG_ROCKCHIP_PM_DOMAINS=3Dy:
> >
> > [...]
>
> Applied, thanks!
>
> [1/2] arm64: select ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
>       commit: aff3de3b9a597763bec5d1c56c11b56fb2613085
> [2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
>       commit: 47c9bfdf7376e8b1842699b064ae3b052e2c3c1b

Looks like you picked the old version of the patches. Did you intend
to pick the v4? Then it's the one below you want.
https://lore.kernel.org/all/20250915083317.2885761-5-mikko.rapeli@linaro.or=
g/

Note, I have picked the other patches from the v4 via my pmdomain/mmc trees=
.

Kind regards
Uffe

