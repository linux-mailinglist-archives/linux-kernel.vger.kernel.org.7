Return-Path: <linux-kernel+bounces-789776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CCB39A78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47DB3A532D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CE830BF6C;
	Thu, 28 Aug 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cc7mZhMK"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122E30C361
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377666; cv=none; b=ljR0w0L0usk1HHRGmizvxBhUCcaxkvomSbXDmMnwCOcMq62Z/7stwCcfHTqwPvW4KwM4rSAr7gy0vGClfQrD43FYAh3BI/4ImZub0FJkehOqiBWwnP7b9ActTBBCbJx4P+1ca/AFMctQNMeWDC0MXlVdByaGJRhEMupeiyammeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377666; c=relaxed/simple;
	bh=uw4c+i8xKaQAYP7o50jrNBNLbmBRrs7CaD4Z51npYbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNKR2sMa5f0/cItPvXVRRSQgUAvfHXoBMOUktVmiqpKRDk6pzYZpVDNasKNDWUddhNi6blaIC2gNKnWNoo0y6w2MeNxgmhUTky4qEXg2dRVpadYa249IIbbr4o9/588vl1rGNNHkvpKAGqJF9sD0QSDrSnIeMvbJUdeMKs8ds3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cc7mZhMK; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e9ff3d2803so1432285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756377664; x=1756982464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EydVysub6WRf2f/POlpq24Sj1Yvi1ca2N5AUKs2yN74=;
        b=Cc7mZhMKuPwSUEKLYdwc2bzcK4eyCvT49wlZUSV+EVbj4wC/ZtBDwosySU/rxZvXfQ
         SmAfaP5ELpj9jiTIgafz4y2dZLlYmkiZMFtsUDXnM3JXgaIK//08kqlXuEkRHS8RfdT8
         zaZlKiP5LHh4WVv5i9ZM3VD+8snZs2hjXfEvXfCJTPNWqP5BeM5PHnpkAerkEuzout4Q
         XqbW0QDZF6hGEbcyJ7pz8dgKnAhXoOHdShZ5UfDLZ7J/QDn2Aq5MhWBCFQbsN6UXmQKD
         wZNb5xVlRV+yd+oPpWNLmeF336luLe77t/IycxvNhRbquIUmkaaQA5SINeqCK2cyzSSO
         M1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377664; x=1756982464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EydVysub6WRf2f/POlpq24Sj1Yvi1ca2N5AUKs2yN74=;
        b=kRGD+eqQ2GK1jVa89ZYBjpmOVJ9Wv3J0pHcYXkkcROToT8kdKklRHYPjy6en3GVJTA
         vXx6kSuTnsZBzj8p9D8Yi2Pbg4LPDLUNSGMNBhcdqmOYsZ7V73rLm7TgU4pCo1XHth+G
         otL2Ghq4ah/TkTXNKDBTtdsup/+Tru2wuWiLk8AV/fFR8bE0DTB3SpmXAeLy0YoV0wyb
         mNG9tnJi1zhMDeVc3vwTQO5PmYBOlyO+bvP2DF0ehqGI+tw1fvLuEZPm8R3eJZa0Xaxm
         o2droWpco+91213bQ8IJNFMKo5wYAVTA2X9ljKsIfy9xuvU7gH80rffpLuely+c6DAGj
         iuQA==
X-Gm-Message-State: AOJu0YzRMCzPp37+7WfOhhQYlenma16nBNbJMjYybdaOpX2g7NFdWE5w
	/Uj5aMgXBNDY11WnFXOHoAvfT/wu7dPm5+z57mzN04XLMzQGZVAQ+j9reyk84x+YqLKexSGNIu8
	mpRxiZC8gDoZYpYTjVupkQR8DDu5vnDNEzTg3Md8bBw==
X-Gm-Gg: ASbGncuE9kk1GqbXOjS5mJaahuWKMG0BqOFaWMmaghMCnErAocRABwrD7FM0ubG/EqS
	cPzm6v+DwMngYcwb8CuyTDoPNlymh9RSp8hKLeoJBOwFDGxtSpC5bxJpE+1z4sueuhVhBNVy9o+
	Jxr0e4pP3AgGI+Nxr6JbTw+W1MQRS3npH2/EguJ+jku9S+4+LpeCRvcCJzx12Zs3iao8RgxD0qF
	QrZHRiINc2z7jy5
X-Google-Smtp-Source: AGHT+IE4bAuEW9ouUAxu2MG7S4mY4Sa0rG4XXjaFyEoJM05F/h+YGpiGYd0qZuUP43lUZrkbFMhLhuVFPQZ3xAVR+ck=
X-Received: by 2002:a05:620a:a11c:b0:7eb:b179:cf18 with SMTP id
 af79cd13be357-7ebb179cf73mr1352900785a.0.1756377663827; Thu, 28 Aug 2025
 03:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com>
In-Reply-To: <CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 28 Aug 2025 12:40:52 +0200
X-Gm-Features: Ac12FXwg7V6NAoK1bwozm71TrmcFepHUZqBu0bygtHChH0GZxXhOVks4ofdYiC8
Message-ID: <CADYN=9+Pnw+7bYGr=QnSWqF1YBoB8CbtgkdmDqeY68DQr3CVDw@mail.gmail.com>
Subject: Re: next-20250826 gcc-8 compiler_types.h:572:38: error: call to
 '__compiletime_assert_478' declared with attribute error: FIELD_PREP: value
 too large for the field
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 11:55, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following build warnings / errors noticed on arm riscv mips with
> gcc-8 toolchain but gcc-13 build pass for the following configs.
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> First seen on next-20250826
> Good: next-20250825
> Bad: next-20250826 to next-20250828
>
> Build regression: next-20250826 gcc-8 compiler_types.h:572:38: error:
> call to '__compiletime_assert_478' declared with attribute error:
> FIELD_PREP: value too large for the field
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> arm:
>   build:
>     * gcc-8-integrator_defconfig
>     * gcc-8-omap1_defconfig
>     * gcc-8-footbridge_defconfig
>
> riscv:
>   build:
>     * gcc-8-defconfig
>     * gcc-8-lkftconfig-hardening
>
> mips:
>     * cavium_octeon_defconfig
>     * malta_defconfig
>     * defconfig
>
> ## Build log
> drivers/pci/pci.c: In function 'pcie_set_readrq':
> include/linux/compiler_types.h:572:38: error: call to
> '__compiletime_assert_478' declared with attribute error: FIELD_PREP:
> value too large for the field
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^

Thanks for the report. This should be fixed by my patch here:
https://lore.kernel.org/lkml/20250828101237.1359212-1-anders.roxell@linaro.org/T/#u

Cheers,
Anders

