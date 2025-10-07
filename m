Return-Path: <linux-kernel+bounces-844778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E09BC2BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5CD3B38C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F51246BB8;
	Tue,  7 Oct 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFJabBYv"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528323C513
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872590; cv=none; b=gxE0Wfx67PcpG808k/TH1PcHlYxAbaY7NBixpS41VJoCnPDyv0AYUHw4UJ1xfwfqzonWjb7T3swqCoLYrXIwyC4dg+t7DS51SD2JRVFXq9qUoND4ysoE7ggtEjj4ZDy2KlPO3JCcEu79cPILYOVE5AR50oQaWHsE2Gym22obLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872590; c=relaxed/simple;
	bh=+HVL5amwd75u1SIcOSXwcpsvXBwkNuSBd/TjKL83SP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhKBF3AhwGmpRaaOoajySGoGQiGuH/2KpSNDl2tn8Y7dqqJmB2lS8OyXhkYIkbZxf/lvUI8x065PrU3tMLIWbNA90ezPbIL6vP4i+dPLPyeNGKH/rbNibg+pn5JFNXw1DVnuynzAYiKKMU3/SkETVEgTdG1W2JSImo4dH34DNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFJabBYv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5797c8612b4so8969473e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759872587; x=1760477387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HVL5amwd75u1SIcOSXwcpsvXBwkNuSBd/TjKL83SP8=;
        b=dFJabBYvK5wV8APxqRc0qQdzzwcYR7qHKrRBAtehrUEsWh4DcQXmk1fAnKd97BRwk1
         znmGBz4bJXS4J+mo5aCyUkHLchsIVLVeJlKNtPDexNcSq/pxnUMeXSiJSLSH1EKOUO5X
         W101cVnFwKJ3OmWWyuBLcCPXvquw/t+4NHgtXnU1lCa40VMBL2EvrmheYXk3xb3S7B3v
         V9IT5sVrwFDktt2Juyw6qtePqABu+XMVmun4uGlwcFyhbGJSRll28B3q01kR58VQ1abN
         4luL1F/vD3gAGuoAEFKJ9VvXyhgYF20w7iAb69In6eR8Nw728dRB8GPIXzH+kAM6BVR5
         5F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759872587; x=1760477387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HVL5amwd75u1SIcOSXwcpsvXBwkNuSBd/TjKL83SP8=;
        b=ElojnSe6MFijLlzH/DD1h7OwG3HWzt8G3TJL4E0Mse+XfW5Jiuf1EYW+2/mZyXMAUn
         tGfafm3bHx0eftOZs9QhcJdSeqkvYEzbZ8M/80bdQ28iv9UDN+mzjmX786Pm8pRHVcD3
         Yaumy5EURUQHAjtMWyLtHtnfk/SzM466Mdgc5Gn0YV+W3DEIR7z6hfMR5VR5WU8lDMkC
         d0H/P2Rt49TxFyqDDImmyh1zU5JUFZ27XbwuPBK8F8A3VKe7ua5DvljKQAp6NuAhCbOe
         zIJO3xgX1fHxeekj1S0b5NbYGNDbeHL9XHXenmPQif0t8V8iu7E7+80fPNX0fyy73vxg
         YW7Q==
X-Gm-Message-State: AOJu0Yz9yTFjPLmm4JtEx6nfqJ9KTx46reppu8fKhp04oOYRExiRVNja
	4218ei8XOyAHgQl535N9vIzX6nKdfmAuN9PZSCB2l7dMJoF9A0x88aRYQrRa/oWyflag049BGR2
	uqIwDZRbPOHGw1rnMdXO6vSEjGuHZH/A=
X-Gm-Gg: ASbGncufN4VcQK+8BFw5glSLmqkupxCGepzlfysoUsWj+8TU5rIFlRHjddLPLceON0+
	JiqnbPKl65hmsSRMMVMaet7w658UtGjJfsrWyWixncplSixybqtvVh/pCRdOBbDqTERizbb6pLF
	1DBXUfkhsUJSJixI+tL/Y/n4IcuX+pmrtKutvhdXY2AQfPSA/Crh+Hbb43nD/ohmpj2rjZ9TAGI
	F3lDLC23/J9+18jbHdIIqCoQAGxeVxfFS/1lD6Chz/rnONlV9Zmt68qEQFRavDSUokB5qR1kA==
X-Google-Smtp-Source: AGHT+IGAr9YRBhwPAzyxUEfsVu7aZ6qEmFD6ZEnR9Ero1w7HrPSPChSumgGn268pSU/Rrvxi2TuPaEIhhwO1CkmumX8=
X-Received: by 2002:a05:6512:138e:b0:57b:5f02:e9f1 with SMTP id
 2adb3069b0e04-5906d896eccmr340175e87.6.1759872586872; Tue, 07 Oct 2025
 14:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
 <87o6qjaiz7.fsf@osv.gnss.ru> <CAOMZO5BwoAzf36-L0uCTdKriGaUHg1MqZoKg56Fvob6S4coMBQ@mail.gmail.com>
 <87jz17afpb.fsf@osv.gnss.ru> <CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
 <87bjmih0nz.fsf@osv.gnss.ru>
In-Reply-To: <87bjmih0nz.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Oct 2025 18:29:35 -0300
X-Gm-Features: AS18NWB67zzpY7_fFCRfrZu8VHBmqUEag_Qkx4euXc7f5v2f4rZrohoyJsl49GE
Message-ID: <CAOMZO5Cmxqq6K4k7_yPjGOtMTOgv7WmpN9O2dZiX+UWies8mow@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Tue, Oct 7, 2025 at 6:17=E2=80=AFPM Sergey Organov <sorganov@gmail.com> =
wrote:
>
> Please see attached minimum DTS. Maybe it misses something? Shouldn't
> DTS describe how eMMC chip is powered, provided it's powered from NXP
> MMPF0100F6ANES PMIC? I didn't find any hints in other DTS'es.

Yes, the dts should describe the eMMC power supplies.

The properties are: vmmc-supply and vqmmc-supply.

Check arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi for reference.

> The point of hang is not entirely deterministic either, that suggests
> it's some power problem indeed. It may hang after random line among the
> following depending on exact build and sometimes even from run-to-run:
>
> ...
> mmc0: SDHCI controller on 219c000.mmc [219c000.mmc] using ADMA
> Loading compiled-in X.509 certificates
> clk: Disabling unused clocks
> PM: genpd: Disabling unused power domains

Does it hang if you pass "pm_genpd_ignore_unused" and
"clk_ignore_unused" in the kernel command line?

> check access for rdinit=3D/init failed: -2, ignoring
> Waiting for root device /dev/mmcblk0p2...
>
> Also, I just tried to compile entire kernel with -DDEBUG, and it starts
> to see the eMMC, though still hangs not ever mounting the root FS:

I saw Ulf's response about a potential regression in 6.17.

Do you see the hang with 6.16?

