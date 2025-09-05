Return-Path: <linux-kernel+bounces-802260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D09B44FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4F11899751
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56E2D836A;
	Fri,  5 Sep 2025 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J9wFGA5K"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151B2D3A60
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057530; cv=none; b=JFsw5/zM6hjaeIw4tHQUwfGIA/7ER+ufn6TZolxp7SPILi1+bKUzl/6Ui+eDUO6zsHIpq34hvSXnyOIjhQa3nlOxwCrjnuO8AJ9RHCSgPO+RVxwSRcs/uDdrBb5pbUQiSG+vCxsQ+5CeaKdWvRpXgflyvy3epWmvvzY+zaz138g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057530; c=relaxed/simple;
	bh=xvwXm3Pv9vYvSSWIuT+Z3MQ1o5JDE7sFfcsSDOx2q9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZh2ZgNz87I9Phys2vTleUf5Ec9Mj7Va+1OZ2SRJK2+fu+iUj9ynL+OwaA/m8Gv08j0J+IPOpEnXRNl4kmmgRqz3Raf2sBdKUHayuzULCHP+PODZXqf3dWDfhLTN0CgpcrR/oEUkwmRu2Vf/g2bvQID72NNTqZHgTB7euOe0+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J9wFGA5K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3dcce361897so1239076f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757057524; x=1757662324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+x/G5OyWmx9S1N11lvbbbjr7uTWa/HEiipZ5biWNJA=;
        b=J9wFGA5KtDV31XM+ieh8kQdvmrz8LUk/itaJLbOsbYThlp9w4j5ZHf4NbnzhddXNB8
         IqKVsoJNEzakXWn2+MCmu0J52X8FH2nJWG3s7oxAnc4+RJps2GnsX4HWfSNzXvQ3rHSJ
         BNEk1Mm/GJRfm8uJOHnw/xkUbq0w8W6D2CNvEJtLpYV5j09bLrAKT5aH2HdL1yH0CLHJ
         kxue972sVbuzLm34daAhHf5DV2ao7cWFCXuShuNjsqUtd5zw8frGNtIBfZplhpu1w0T+
         D4XKTirZ62EVdQXg+EBajKThMaqe6tT3/9TiF3gvku7vhLSKol0g2Xc2P2LKKfppRLIi
         19ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757057524; x=1757662324;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+x/G5OyWmx9S1N11lvbbbjr7uTWa/HEiipZ5biWNJA=;
        b=dUem/gCYlZ5yZByd4CU6TWpkajZ3ctulKscexjbMx8olwDwVyI/9tKCu8+rQcr/B82
         A7P0Zj5bGsBNT4a7IVcCk9p9F1G/+wb+YajOoQj25ZK2REieoNhWeMltLAeRGG/Gw0Sh
         OjgV8RbnWsx1mQnA2c9/6l3LaaDkbrMagJ1JLRbqYJwWP0fIzGCiXuTD/fpf85krZ82b
         rIUm/swRCxV4F7ILSVnix4M9KKLAzfYq+gQY6/bRjYhdrIZjKrV/UEuLnpzmn2TtFpGY
         4wHMgHyXk5NNgeHNRS8kqcXqYZSR9dyjdqCiyZ2O+y7yeyz8VR2nJ/K/rYxzzUfaoxNN
         IjoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3rvxaDYcLxbRCfO0xP/wkvbI2OXuxMIx/qnXf6BzD2YYlTBHeKeNzSoKUrqiJWM6L1uvkv+4CVk5+lXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj00lcnTB+ko3yf4CIPhOOygjsIxeVrXrltKL6ZsFTRDCFX8xG
	8jBIta539IKH8An0XhzBSgO0Vr90dlBkBVnrqX4I2kduw8WD5+Hbz49NDckOd6pYQfA=
X-Gm-Gg: ASbGncvBblUaiuS5H3qHKNDyosaiUk33bxxtAvyHx8Xd9XbeEjPJzb26FQpGvmuQ/Ky
	elyrojYNjYO8zB1uK4Nj/21COr8oQnBJ2ZJXjelsD3Exb7W6bTm1wTCW+5XNhRj1ANCdu0WIOzv
	ohkDND63ok+QPaCTR0mXWMBfIINq0RH/RHg0Bs6nxA5ljNiuTDSdiHB1lkPcmdWe5uLI/6T1/pw
	g2oWzDcQ/FzznQgzO1l7B0YpMf+P5vjZ8F4FdkTwb6d3hjQSccA++jijzKhuNrn1Cakpick9t3O
	1houSw/ZKqVTo3rBpgQEXJLlAneOtism7uYJPhEnhk52xtOqBOhgnqbADnUAJXW88qF+gS5sTr8
	fJJCaZu0orZctO0IKwhz+nw==
X-Google-Smtp-Source: AGHT+IE/edIEyJSVF31RWvvWzi7ImsiFPZN9hfcyP5rc42uQs8rb9WrkD+dUKuAD84MRpef6VXJY2w==
X-Received: by 2002:adf:8b8a:0:b0:3d2:eea2:f483 with SMTP id ffacd0b85a97d-3d2eea2f990mr12656102f8f.43.1757057524391;
        Fri, 05 Sep 2025 00:32:04 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:f203:7a74:e497:6da7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d53fda847dsm21207010f8f.0.2025.09.05.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 00:32:03 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,  Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  linux-pci@vger.kernel.org,  Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  Bjorn Helgaas
 <bhelgaas@google.com>,
  Frank Li <Frank.Li@nxp.com>,  Kishon Vijay Abraham I <kishon@kernel.org>,
  Manivannan Sadhasivam <mani@kernel.org>,  Wang Jiang
 <jiangwang@kylinos.cn>,  linux-kernel@vger.kernel.org,
  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
In-Reply-To: <aLmGBYOVevP5hH0X@ryzen> (Niklas Cassel's message of "Thu, 4 Sep
	2025 14:28:53 +0200")
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
	<b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org>
	<aLmGBYOVevP5hH0X@ryzen>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 05 Sep 2025 09:32:03 +0200
Message-ID: <1jplc54aoc.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu 04 Sep 2025 at 14:28, Niklas Cassel <cassel@kernel.org> wrote:

> On Thu, Sep 04, 2025 at 11:40:15AM +0900, Damien Le Moal wrote:
>> On 9/4/25 11:37 AM, Marek Vasut wrote:
>> > Currently, the test allocates BAR sizes according to fixed table
>> > bar_size[] =3D { 512, 512, 1024, 16384, 131072, 1048576 } . This
>> > does not work with controllers which have fixed size BARs, like
>> > Renesas R-Car V4H PCIe controller, which has BAR4 size limited
>> > to 256 Bytes, which is much less than 131072 currently requested
>> > by this test.
>> >=20
>> > Adjust the test such, that in case a fixed size BAR is detected
>> > on a controller, minimum of requested size and fixed size BAR
>> > size is used during the test instead.
>> >=20
>> > This helps with test failures reported as follows:
>> > "
>> > pci_epf_test pci_epf_test.0: requested BAR size is larger than fixed s=
ize
>> > pci_epf_test pci_epf_test.0: Failed to allocate space for BAR4
>> > "
>> >=20
>> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> > ---
>> > Cc: "Krzysztof Wilczy=C5=84ski" <kwilczynski@kernel.org>
>> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: Damien Le Moal <dlemoal@kernel.org>
>> > Cc: Frank Li <Frank.Li@nxp.com>
>> > Cc: Kishon Vijay Abraham I <kishon@kernel.org>
>> > Cc: Manivannan Sadhasivam <mani@kernel.org>
>> > Cc: Niklas Cassel <cassel@kernel.org>
>> > Cc: Wang Jiang <jiangwang@kylinos.cn>
>> > Cc: linux-kernel@vger.kernel.org
>> > Cc: linux-pci@vger.kernel.org
>> > Cc: linux-renesas-soc@vger.kernel.org
>> > ---
>> >  drivers/pci/endpoint/functions/pci-epf-test.c | 11 +++++++++--
>> >  1 file changed, 9 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/p=
ci/endpoint/functions/pci-epf-test.c
>> > index e091193bd8a8a..d9c950d4c9a9e 100644
>> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> > @@ -1022,7 +1022,8 @@ static int pci_epf_test_alloc_space(struct pci_e=
pf *epf)
>> >  	enum pci_barno test_reg_bar =3D epf_test->test_reg_bar;
>> >  	enum pci_barno bar;
>> >  	const struct pci_epc_features *epc_features =3D epf_test->epc_featur=
es;
>> > -	size_t test_reg_size;
>> > +	size_t test_reg_size, test_bar_size;
>> > +	u64 bar_fixed_size;
>> >=20=20
>> >  	test_reg_bar_size =3D ALIGN(sizeof(struct pci_epf_test_reg), 128);
>> >=20=20
>> > @@ -1050,7 +1051,13 @@ static int pci_epf_test_alloc_space(struct pci_=
epf *epf)
>> >  		if (bar =3D=3D test_reg_bar)
>> >  			continue;
>> >=20=20
>> > -		base =3D pci_epf_alloc_space(epf, bar_size[bar], bar,
>> > +		test_bar_size =3D bar_size[bar];
>> > +
>> > +		bar_fixed_size =3D epc_features->bar[bar].fixed_size;
>> > +		if (epc_features->bar[bar].type =3D=3D BAR_FIXED && bar_fixed_size)
>> > +			test_bar_size =3D min(bar_size[bar], bar_fixed_size);
>>=20
>> I think this can be simplified to:
>>=20
>> 		if (epc_features->bar[bar].type =3D=3D BAR_FIXED)
>> 			test_bar_size =3D epc_features->bar[bar].fixed_size;
>> 		else
>> 			test_bar_size =3D bar_size[bar];
>
> +1

It's what pci_epf_alloc_space() does too. so it makes sense but it also
means the side must stay aligned.

If a rework is needed, maybe it would be better to get size from
pci_epf_alloc_space() instead of recomputing it ?

>
>>=20
>> because if the bar type is BAR_FIXED, then the size of the bar can only =
be its
>> fixed size.
>
> Correct, see:
> f015b53d634a ("PCI: endpoint: Add size check for fixed size BARs in pci_e=
pc_set_bar()")
>
> Actually, Jerome Brunet was also using this weird Renesas R-Car V4H PCIe
> controller where BAR4 is a really small fixed-size BAR.
>
> (Even smaller than the iATU minimum alignment requirement for that same
> controller.)
>
> See:
> 793908d60b87 ("PCI: endpoint: Retain fixed-size BAR size as well as align=
ed size")
>
> But he only appears to have used the vntb epf driver.
>
> Jerome, I suppose that you never ran with the pci-epf-test driver?
>

Indeed no. I've gone with with ntb-test driver on top or ntb-netdev

>
> pci_epf_alloc_space() works like this:
> If the user requests a BAR size that is smaller than the fixed-size BAR,
> it will allocate space matching the fixed-size.
>
> As in most cases, having a BAR larger than needed by an EPF driver is
> still acceptable.
>
> However, if the user requests a size larger than the fixed-size BAR,
> as in your case, we will return an error, as we cannot fulfill the
> user's request.
>
> I don't see any alternative other than your/Damien's proposal above.
>
> Unfortunately, all EPF drivers would probably need this same change.
>
>
> Kind regards,
> Niklas

--=20
Jerome

