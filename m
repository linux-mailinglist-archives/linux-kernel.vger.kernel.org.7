Return-Path: <linux-kernel+bounces-829359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E8DB96E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E77484C61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B82E1F01;
	Tue, 23 Sep 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tjd+jq+y"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8764A8F;
	Tue, 23 Sep 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646388; cv=none; b=ZZB8E1/8csM2AJFE2eXHXfJKGLManiApYRy2FAXIL9MuSR2Ptkhf/gir+/MU1i/q/nqmfLanvs8ndFbblW7+ZdSlq1qFQALoT1cIv9y2V1FQasJjZZvgcqh7Txo0hyMdG+FmZLiqdT5gpZDDm1QoK1BzIhMG88qvnU6SshIeoNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646388; c=relaxed/simple;
	bh=1K1mi/bl+7i2PouXGTsjCEBwlvQksuDiwpDKl4ZTr50=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZWnwjakTP0yf/b7kZjo8sSyMT8DGxugVvZQYpPF1s3GSSegQNAb08vwbwg4pGpCteYHgxT5Q6qhszo4pIjx0h8dpIKHbnOAvceLPDpKMoOntPP1bRO2MrPG1Thei8fnzkHxbddQaQUELtVsf6BK7vKSxmeI2xO90i33O73UywX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tjd+jq+y; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NGldSo1046240;
	Tue, 23 Sep 2025 11:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758646059;
	bh=1SPiAj1VzSaiRq0LoTi8vdftSIjlW0msepkj/D9IkoM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tjd+jq+yxThU2zCSeUzfd5PzURTEfdN/BTASXaztGt+OxOcaW0v4TpAGHdjsG9fW/
	 zYhg+8/QCUhzLUmpYK8g51Y4YbwZgUxC4ChfJWMR4S024nTO7gS/UAowokK0pLLtQ1
	 nx/arhFb7Hr35g7P/7Wq1UwW+mh0knuBft0BgMWQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NGldWP1219608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 11:47:39 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 11:47:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 11:47:38 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NGlcUI350893;
	Tue, 23 Sep 2025 11:47:38 -0500
Message-ID: <fe45ac1d-e49b-4456-bbe1-5a04f400e73f@ti.com>
Date: Tue, 23 Sep 2025 11:47:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Device tree representation of (hotplug) connectors: discussion at
 ELCE
To: Herve Codina <herve.codina@bootlin.com>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: David Gibson <david@gibson.dropbear.id.au>,
        Ayush Singh
	<ayush@beagleboard.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Luca
 Ceresoli <luca.ceresoli@bootlin.com>,
        <devicetree@vger.kernel.org>, Jason
 Kridner <jkridner@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        <devicetree-compiler@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
References: <aL-2fmYsbexEtpNp@zatzit> <20250909114126.219c57b8@bootlin.com>
 <aMD_qYx4ZEASD9A1@zatzit> <20250911104828.48ef2c0e@bootlin.com>
 <aMebXe-yJy34kST8@zatzit> <20250916084631.77127e29@bootlin.com>
 <aMt5kEI_WRDOf-Hw@zatzit> <20250918094409.0d5f92ec@bootlin.com>
 <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
 <aNJVqSpdAJzGliNx@zatzit> <20250923114849.2385736d@bootlin.com>
 <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
 <20250923153646.754e86f8@bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250923153646.754e86f8@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/23/25 8:36 AM, Herve Codina wrote:
> On Tue, 23 Sep 2025 12:29:27 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>> Hi Hervé,
>>
>> On Tue, 23 Sept 2025 at 11:49, Herve Codina <herve.codina@bootlin.com> wrote:
>>> On Tue, 23 Sep 2025 18:09:13 +1000
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>> Ah, right.  To be clear: we absolutely don't want multiple addons
>>>> altering the same nodes.  But I think we could do that in ways other
>>>> than putting everything under a connector.  This is exactly why I
>>>> think we should think this through as an end-to-end problem, rather
>>>> trying to do it as a tweak to the existing (crap) overlay system.
>>>>
>>>> So, if we're thinking of this as an entirely new way of updating the
>>>> base dt - not "an overlay" - we can decide on the rules to ensure that
>>>> addition and removal is sane.  Two obvious ones I think we should
>>>> definitely have are:
>>>>
>>>> a) Addons can only add completely new nodes, never modify existing
>>>>     ones.  This means that whatever addons are present at runtime,
>>>>     every node has a single well defined owner (either base board or
>>>>     addon).
>>>
>>> In this rule I suppose that "never modify existing ones" should be understood
>>> as "never modify, add or remove properties in existing ones". Because, of course
>>> adding a full node in a existing one is allowed (rule b).
>>
>> What if the add-on board contains a provider for the base board.
>> E.g. the connector has a clock input, fed by an optional clock generator
>> on the add-on board.  Hooking that into the system requires modifying
>> a clocks property in the base board, cfr. [1].
>> Or is there some other solution?
>>
>> I was also wondering about endpoints, as they have two sides: one on
>> the base board, and one on the add-on board. But it seems that typically
>> both ends are added by the extension, so these fall under rule b.
>>
>> Thanks!
>>
>> [1] https://elixir.bootlin.com/linux/v6.16/source/arch/arm64/boot/dts/renesas/white-hawk-ard-audio-da7212.dtso#L165
>>
> 
> Hi Geert,
> 
> Addon DT we talk about is not a way to fine tune base board devices.
> 
> For the clock, you need a clock driver which is able to support clock hot-plugging.
> Same for endpoint, the remote endpoint part should support hot-plugging.

Why should these drivers need hot-plug support, they are attached and then
the board is booted. Nothing is hot-plugged here.

> 
> I don't think that addon DT should support what is done in the dtso you pointed out.
> 

The pointed out DTSO is a good example of exactly what needs to be supported,
clocks, pinmux, bidirectional endpoints will all be needed to support a large
number of add-on boards.

Andrew

> Best regards,
> Hervé
> 


