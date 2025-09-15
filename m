Return-Path: <linux-kernel+bounces-816193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC6B570CC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CCE3ACC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF026E17F;
	Mon, 15 Sep 2025 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b53Eb5oY"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414B2DF68
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919712; cv=none; b=tmGYGK/RWROZVa0T4zvxBEMuchwV9SzcomfXemrvEX+c82T88g8z8+6DNXwU29Ov9BcbIjrFbuHJ9N7q9Szzj4Fuy5mKKmuzdVPJJqX2EsbefQjh0eo08+pqbeHqibHFkP4As3+dJ5ORFAYdfKtnT+d22/OI2CLhksweXc6wx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919712; c=relaxed/simple;
	bh=IIUGO/dEbzBpZ78hDxZU7VRxbR2Zz8U9O9qbR0A0xAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MVvPc1YeVvDAL0mtNB9syJkiWwkfhvLNzMyI4q9F5/8sTuC1prYeolcsPajnhAM2hinaBL1aMvtGxDOUqinRyLQnrtsuv0+wxG2PsQlf/GYgskJ1yu9Rb7SXhjyOMn7lSvvdrt6aGwmckksJ0hv8YihzC4BgGiYmDgZiTD1Qnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b53Eb5oY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso4372444e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757919709; x=1758524509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqtUFtQXqrY0eT8Jyx/HTyjcTDqiPb75irXtglfsEWg=;
        b=b53Eb5oYpuBSsOx2ParcturEh72/nb3ofTLo/DK42iVJLmgHX1sDFdq5u9YN2aALKk
         ag2EyRDeZ45viEIBTLiBfdXsieaT1LviW2aM4cvsbcY8C0LL1dsdy2whg8ImEqAA+pGX
         KURGaQKWjf39Z0qfoiZvBKOxdMkLfOedoPa3iKgpQ0Bq+I0hx1pyqdme/fn9/TIP4lf0
         tA5u2xfY8MH+JRI/uz7WsWp0DjhmlM6ThRkC8CegY+x5qdxSyWhqEnWVW6bSSXsK2ueP
         HElmdsRVkdPWT6NpX6bcHm1vmuzXTaMuzmauG72wSTfHHqlkn4BtQbP6bfYJRKPmI8SV
         BTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757919709; x=1758524509;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqtUFtQXqrY0eT8Jyx/HTyjcTDqiPb75irXtglfsEWg=;
        b=w5bfW+Yq3R6gRcb7AIc+IjqytC7vHsdn8JG0Bw7ifuAM23XF/cmLSe0ugbK4C63ij4
         Nxxu8TdHxBMH3N9JiqFPVdJoVeMZDi4eainydp1wYQRikmiSwogkV37ikhqwlwvzKEuX
         gwGcjx+1W85aBAOw+2xzntLYqMJM1oYaWr8y9FShTP2FNhLjYjPlzATIZHlCnbmGyArP
         xNQIaL95M5CvMWtH3A55gwo2ZmnbWtu0qujAHjsuHAClEMAFPSQ5qwEvuxC3J3JhQ7N8
         PZJFs9IUP/s/Qd3Ckwk6Qze/wEAvVrm9d8a3KyL/c0fKE0fLgScWujia7THfVuzEL/BT
         xXuA==
X-Forwarded-Encrypted: i=1; AJvYcCUQz4o6yDus7L2UppZ/bWsObY9Yu/llG+oQkmlqZd9FHQ+NClgMaO7iVfstuRAAU7z876rSPHhKSVWKpow=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh98IGjmX/ouPZI1PhKTsScEgv1aisLnEqXxG1olNh0ehqZvl8
	nvArHxx42fzozLDDY8YvBDtstn1ppp30BEE0xWhl+8yf6LoklhBN3WJ0XLIOpr0z4R4=
X-Gm-Gg: ASbGncuZIGCUgDkktvtm3VFeCg3VPV86MmqDIpYRocON7KErZf+buNCvm4db1Ro6HMK
	nUhWkB8szYOQ4PWGFyN+FRaunm2Xn1Aer1oLRDO3f1kCp2nBp49vSKntVs70kCywuqVMTpteUjj
	lYvJpSm+3ezXxcmpl06E3NK84XQQWwCaj9tm5cMfGzc5pwXtiHgcS+FQNSFwNdVnQQMQYvXmESa
	ChhcfcaxizUR63jEMxKY9UmVdHWcCgIc1kb7NOUBGXWaxNPmJAvsWi3vWFNYfiMpO80TmCe3dBp
	vXJ7en0suqDIcz5qnFVToDlPbKXxccHbSRqLC9DYwknLsFTX8jxa6s9/ZtL90KKrb7mGaJ/SuBB
	m8/KdTJLSQ0rOuCqrsz8F89lbjFTlYv7+/h/JlpC7Qnz9PbXFYvg2PBo=
X-Google-Smtp-Source: AGHT+IFBdmNQEzyswHDpGv1SoR2koTptT4AXtjV5Z/8TKUtFo7V4yBDALIrdg96iQz/TMcSidgZeMw==
X-Received: by 2002:a05:6512:79a:b0:55f:3f25:f036 with SMTP id 2adb3069b0e04-5704fb86967mr3095602e87.34.1757919708816;
        Mon, 15 Sep 2025 00:01:48 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5cf300b7sm3394559e87.45.2025.09.15.00.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 00:01:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:01:46 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>, Binbin Zhou <zhoubinbin@loongson.cn>
Cc: "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yixun Lan <dlan@gentoo.org>, zhoubb.aaron@gmail.com
Subject: Re: [PATCH v3 3/4] mmc: remove COMPILE_TEST from MMC_LOONGSON2
Message-ID: <aMe52k8wtQBU-eyN@nuoska>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f09322b-6bc5-437b-88b5-dec306748d80@loongson.cn>
 <413a49f5-91f3-4334-9128-29297293f953@app.fastmail.com>

Hi,

On Fri, Sep 12, 2025 at 04:50:38PM +0200, Arnd Bergmann wrote:
> On Fri, Sep 12, 2025, at 16:22, Mikko Rapeli wrote:
> > It fails to link due to undeclared dependency
> > to regmap which is not enabled for COMPILE_TEST:
> >
> > ERROR: modpost: "__devm_regmap_init_mmio_clk"
> > [drivers/mmc/host/loongson2-mmc.ko] undefined!
> 
> Nice catch! I assume my normal randconfig builds never
> run into this because there is always something selecting
> REGMAP_MMIO.
> 
> >  config MMC_LOONGSON2
> >  	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
> > -	depends on LOONGARCH || COMPILE_TEST
> > +	depends on LOONGARCH
> >  	depends on HAS_DMA
> 
> I would instead add 'select REGMAP_MMIO' here, which is what
> we do for other drivers using this.

On Sat, Sep 13, 2025 at 12:58:00PM +0800, Binbin Zhou wrote:
<snip>
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -1113,7 +1113,7 @@ config MMC_OWL
> >   config MMC_LOONGSON2
> >   	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
> > -	depends on LOONGARCH || COMPILE_TEST
> > +	depends on LOONGARCH
> 
> How about add `select REGMAP_MMIO` instead.

Sorry, my bad. I just checked drivers/base/regmap/Kconfig for COMPILE_TEST
and since it was not found thought that it's not supported with
COMPILE_TEST.

I will add the REGMAP_MMIO dependency instead in v4.

Cheers,

-Mikko

