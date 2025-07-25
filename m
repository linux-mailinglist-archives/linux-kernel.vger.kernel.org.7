Return-Path: <linux-kernel+bounces-746057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2238B12280
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13563561739
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6064A2EF9A2;
	Fri, 25 Jul 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="lMYRbbWd"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C71BBBE5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463037; cv=none; b=Sz0LqK8tbzdDQFKtMneROFVEzhTPbornUhzoz//JaCSCQaJMvMm3gosl+cRQ8u2ueiLlmKN/L1Zb+kMiRxMNTXZBdX/+sy5sfsbGc2efBEiNKhpBjnDGoWjUFuX+nNbo4uBO31MxokkXwfmf0g2hBI94HlsdTs2/k+83LJBuXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463037; c=relaxed/simple;
	bh=XRPXn4b8DSkRHKtIXSlfRWZ/7dKLmVHQ9WRzD4Ora/A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SidbsWG4tw7DaodQ2T4hFPyrRWhlnCpBcjoz5OJdFBpByUDDchD9yjELAEk43YIt3FnIcQT7I2HlHgckoJn8jzagETcM4MDbmGc6/zJUBfRKNVFqO9ZkZ4tsYZUVe9AutkZbDk/13l5PA++FcqrYw2+q5QKrLDmX5zb/5ueWQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=lMYRbbWd; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1753463031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6NaXMg9fbROH9LvIGCHCsqgrXQO+KbOb0QRffIyTME=;
	b=lMYRbbWdVu9phJd7Q2DFv8Z9C2qAH919I0996wblEzzaVBasc+xxHGRU3M3Zp05/pBarYR
	tB2bdt8xpLkn39yB2WOvU6IJWD0DC5EMcw+JgDP4EsDb8Jdld4Ez0FLfLVTYGjZaplAUO2
	YWHNsenPJXB2mqKwteYxOdHxKQHmH4J+/BArnDso+N7Os0hUvCMmo6+8qC/FRW0/h7I6bU
	1P81Lf5C/IEpTYiv5xnCC2RruYkXNWI8Dtqf4J7TzOqI4wNKEh/edzIuFgECkD6YXY0mjG
	KqBQ6Le2cM+47oAUOI/htPjC8cwqHguDZwGRdYlP2Qp9xbe8kGGBfqEcFFYJ9w==
Content-Type: multipart/signed;
 boundary=8c1edd4abc64afa689b98190459caaa658628e964ab805c9823f0dd1a1b2;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 25 Jul 2025 19:03:29 +0200
Message-Id: <DBLARE9EUGTB.1AIKSIZBIXHIJ@cknow.org>
Cc: "Chen Wang" <unicorn_wang@outlook.com>, "Drew Fustini" <drew@pdp7.com>,
 <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v6 1/8] mmc: sdhci-of-dwcmshc: add common bulk optional
 clocks support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Adrian Hunter" <adrian.hunter@intel.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Chen Wang" <unicornxw@gmail.com>,
 <aou@eecs.berkeley.edu>, <conor+dt@kernel.org>, <guoren@kernel.org>,
 <inochiama@outlook.com>, <jszhang@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>, <robh@kernel.org>, <ulf.hansson@linaro.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <chao.wei@sophgo.com>, <haijiao.liu@sophgo.com>,
 <xiaoguang.xing@sophgo.com>, <tingzhu.wang@sophgo.com>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
 <e57e8c51da81f176b49608269a884f840903e78e.1722847198.git.unicorn_wang@outlook.com> <f81b88df-9959-4968-a60a-b7efd3d5ea24@arm.com> <99899915-2730-41c7-b71a-f8d97bb6e59c@intel.com> <DBKCYCNRNTMZ.1XJU81M6EE2D0@cknow.org> <30cb2e71-5e0b-4fa0-b0e0-3263d9aa8712@intel.com>
In-Reply-To: <30cb2e71-5e0b-4fa0-b0e0-3263d9aa8712@intel.com>
X-Migadu-Flow: FLOW_OUT

--8c1edd4abc64afa689b98190459caaa658628e964ab805c9823f0dd1a1b2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Jul 24, 2025 at 4:57 PM CEST, Adrian Hunter wrote:
> On 24/07/2025 17:33, Diederik de Haas wrote:
>> On Wed Jul 23, 2025 at 7:33 AM CEST, Adrian Hunter wrote:
>>> On 22/07/2025 21:33, Robin Murphy wrote:
>>>> A bit late for a "review", but Diederik and I have just been
>>>> IRC-debugging a crash on RK3568 which by inspection seems to be caused
>>>> by this patch:
>>>>
>>>> On 2024-08-05 10:17 am, Chen Wang wrote:
>>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>>
>>>>> In addition to the required core clock and optional
>>>>> bus clock, the soc will expand its own clocks, so
>>>>> the bulk clock mechanism is abstracted.
>>>>>
>>>>> Note, I call the bulk clocks as "other clocks" due
>>>>> to the bus clock has been called as "optional".
>>>>>
>>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>>> Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
>>>>> Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
>>>>> ---
>>>
>>> Presumably the problem has gone away with:
>>>
>>> 	commit 91a001a1a0749e5d24606d46ac5dfd4433c00956
>>> 	Author: Binbin Zhou <zhoubinbin@loongson.cn>
>>> 	Date:   Sat Jun 7 15:39:01 2025 +0800
>>>
>>> 	    mmc: sdhci-of-dwcmshc: Drop the use of sdhci_pltfm_free()
>>>
>>> which is in next.
>>>
>>> In which case a separate fix is needed for stable.
>>=20
>> Adding that patch to my 6.16-rc7 kernel indeed stopped the OOPSies.
>> Thanks!
>
> You need the other patches that it depends on, otherwise you are
> just leaking the memory.  Refer:
>
> 	https://lore.kernel.org/all/cover.1749127796.git.zhoubinbin@loongson.cn/

Also with the other patches, the OOPSies stopped :-)

Cheers,
  Diederik

--8c1edd4abc64afa689b98190459caaa658628e964ab805c9823f0dd1a1b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaIO47QAKCRDXblvOeH7b
bh72AQCh2k0eqJiG8Ya5dmzENE7WFUBjyOZZW10vyWI/TozQJAEAlJekvqK7tuae
XFsYO2aDmaIN1Y0pZTJ7d2kzkrzxwQk=
=ZwZn
-----END PGP SIGNATURE-----

--8c1edd4abc64afa689b98190459caaa658628e964ab805c9823f0dd1a1b2--

