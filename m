Return-Path: <linux-kernel+bounces-862195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DA1BF4A80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869B5467130
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3F2571D8;
	Tue, 21 Oct 2025 05:39:51 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2180246BAA;
	Tue, 21 Oct 2025 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761025191; cv=none; b=Bzp3WxQhLzURrBeyPSB3ODdAu7tqbbQjoc0wHJseXbV6X1tgzJszBheyQQl+GfjEhfoQhvxa6Vp3J6qtttzfEjgxe0NFPcCGGgLVJXlydqxUHcWPgFGtitNLbFuPrLwYmwXsxrlZeOyjCwH5/DAuD7nqGRhLFzFEUvKsAp3zWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761025191; c=relaxed/simple;
	bh=BSruS+e+1mMM0hqPQrzFkBHtZC+eDjaFGPxLazb4w+w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rU5ke+mwQbeu5BWD/9b6wLPkHMvF+WaKYKJFJkPkiddKeOF5YIFgPyGna2WQZHQQperzaVzVeTU/XQAuEXVU4cvXMQtvgjD6KlGQrK3EEVAmWFRL/KGCw3vaglmgLTIwLl3c0FUg0wamuVA8rDyRH9j9GVdbHjp7FOsvnmrVivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.85.109])
	by APP-05 (Coremail) with SMTP id zQCowAD3lhB9HPdoosmmEg--.36897S2;
	Tue, 21 Oct 2025 13:39:10 +0800 (CST)
Message-ID: <52693a5b-e564-41f1-b430-b87784e0559b@iscas.ac.cn>
Date: Tue, 21 Oct 2025 13:39:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: dts: spacemit: add Ethernet and PDMA to
 OrangePi RV2
From: Vivian Wang <wangruikang@iscas.ac.cn>
To: michael.opdenacker@rootcommit.com
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>
References: <20251017100106.3180482-1-michael.opdenacker@rootcommit.com>
 <20251017100106.3180482-2-michael.opdenacker@rootcommit.com>
 <002e0b15-57b6-4433-a9fe-8b7ce4b8dcd9@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <002e0b15-57b6-4433-a9fe-8b7ce4b8dcd9@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3lhB9HPdoosmmEg--.36897S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy8CFyrGF1DtF17Xw4xZwb_yoW8Ar47pF
	W3XrnxJr9FkrW2vrnIvw4kuF1fuan5tF43Gw1Fva48AFs8tr9agr18tr45JFy3XrZ8XF4Y
	9FW0gas7uFyqyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07betCcUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 10/20/25 17:07, Vivian Wang wrote:

> [...]
>> +	phy-handle = <&rgmii0>;
>> +	phy-mode = "rgmii-id";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&gmac0_cfg>;
>> +	rx-internal-delay-ps = <0>;
>> +	tx-internal-delay-ps = <0>;
> The hardware design of OPI-RV2 is not the same as BPI-F3, so the
> parameters here deserves some scruitiny. Same for eth1 below.
(Apparently my spelling deserves scrutiny as well. Oh well.)
> I would appreciate at least iperf TCP tests in both directions on both
> ethernet ports. The expected speed should be at least 940 Mbit/sec - if
> it's much lower than that something is wrong.

Okay so this is not *necessarily* a problem, but just for context...

If you look at the DTS files provided by SpacemiT [1] you'd think the
OPI-RV2 also uses RTL8211F Ethernet PHYs. It does not. The schematics
(linked on the board main page [2]) says it uses Motorcomm YT8531C.

This doesn't mean that your DTS is wrong (because we don't write the id
here when the PHY-sent one is correct), but I hope you understand that
what I'm worried is that the electrical characteristics have been
changed since they have changed the board design. This is why I think
actually taking the time to check the delay parameters would be a good idea.

And yes, it would not be surprising if the parameters for BPI-F3 also
works completely reliably for OPI-RV2. The delay tuning has quite a bit
of margin for wiggle room. 

Thanks,
Vivian "dramforever" Wang

[1]: https://github.com/spacemit-com/linux-k1x/blob/k1/arch/riscv/boot/dts/spacemit/k1-x_orangepi-rv2.dts
[2]: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-RV2.html


