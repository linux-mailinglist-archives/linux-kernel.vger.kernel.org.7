Return-Path: <linux-kernel+bounces-753576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE84B184C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19AA5A1595
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2686272E6A;
	Fri,  1 Aug 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="I0epg0YC"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A23127145C;
	Fri,  1 Aug 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061319; cv=none; b=r0liw6s56S/Ddl4pW1CuTU6T0QZ5/4BhMiMDKtj58RCX+L3gZlTx8Y/ea3n+OM+z26UaYje8YGMGAQ5gD/Yo1q/lkpivhlzyGY9u24/sLobNjRN2ZARZIrSkOICNj6m5aifB7ZPn6RLOfXIg6mrAo/xTjHsC22rUBqLl82C9+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061319; c=relaxed/simple;
	bh=VTYfzYmwO4fpo4yZZD9Y9kWaeN1XJm5FQpdA3MoBOXE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TznerxYMnM7N6eWKU2cY08Tgke+7t3KkTKH6rYDZckFaMlSzf+QPt+GAUyN5piyvTwpCLjnxMzjQFkMvCXJ009XYvJAyjHpM6DVaZfbJUezBDwTmkFsz/pL6lbfGrANPTzUG1IgOLZNYnx2VE2iOnPEO/DPnqcL0rI7J0u5ghj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=I0epg0YC; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754061307; x=1754666107; i=markus.elfring@web.de;
	bh=xQjBeLy0mdM6gKkGEOZ5/8q0KeBi0JdvRd0pkB0dTpo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I0epg0YCbMXfGdRHZwHFkXEqzv0Wr2/FkQ6n81SpflDiBGGTCfargGaX9iVNFJsB
	 xgXxTd6tq2DV4Fkd1pcP17x2R7AiS5UQNEhRyFazGe9DM4n3WuuYsciQJ69nrSiOD
	 eWwa/jWjDtkrESF3VYukcPWpiF4gBqQPjq1lVYY+eeRJ8biZ8hJb3QXOwLSX/uUmi
	 BuKJ5cShI8A4m+kzrck71TeUN21foG8Tc2VSKSxsa6TwDW9SB0bNhi8ozBbQtc4vc
	 mPZXNsWN0ZBIY+X1PHEsNJiIJsMNGP371ctV6iIVhx9ulvxZ6/sT7jDm1ItJ3aAly
	 pPcpLg5VOqvVUrnyeg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjMO-1unOJ43Y7A-008ZKX; Fri, 01
 Aug 2025 17:15:06 +0200
Message-ID: <2bc87a7e-6616-42cb-ba78-8f037a40ff3c@web.de>
Date: Fri, 1 Aug 2025 17:15:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhen Ni <zhen.ni@easystack.cn>, linux-clk@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20250729125729.798897-1-zhen.ni@easystack.cn>
Subject: Re: [PATCH] clk: hisilicon: Fix of_iomap leak in hisi_clk_init
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250729125729.798897-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w+XQ6m1UYqT8Iykn1KfPdbgTEOBfUX2rEYJavEjCB9R0TkjJp1z
 kCJlp2QWKZSGKKM/y5UieD6VaOxWLwHkQhwQL7upsdLREdw4CiufeUSy+VXG2Ag7b8lZ2SV
 Mb1y6qY0WCubKnNqnKaUMCeRzhBFW1Lf5+vbVUh0f67Xp0oyf4ePd5CaI20GOD8RNiSOBYH
 s22XkSPjDtJQOkH9aE0aA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mXt3WfGJEPo=;q3G7PzwyktFpJ5Ax1nKWMgKL7ou
 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
 /A==

> Smatch reports:
>=20
> drivers/clk/hisilicon/clk.c:87 hisi_clk_init() warn: 'base'
> from of_iomap() not released on lines: 87.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n145


=E2=80=A6
> To fix this, iounmap is added when handle error.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n94


=E2=80=A6
> +++ b/drivers/clk/hisilicon/clk.c
> @@ -84,6 +84,8 @@ struct hisi_clock_data *hisi_clk_init(struct device_no=
de *np,
>  err_data:
>  	kfree(clk_data);
>  err:
> +	if (base)
> +		iounmap(base);
>  	return NULL;
>  }
=E2=80=A6

* Please return directly after a failed of_iomap() call.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?h=3Dv6.16#n532

* Would it be nicer to use the label =E2=80=9Cunmap_io=E2=80=9D?

* May the statement =E2=80=9Cclk_data->base =3D base;=E2=80=9D be performe=
d a bit later?

* How do you think about to replace an of_clk_add_provider() call
  by of_clk_add_hw_provider()?
  https://elixir.bootlin.com/linux/v6.16/source/drivers/clk/clk.c#L4996-L5=
001


Regards,
Markus

