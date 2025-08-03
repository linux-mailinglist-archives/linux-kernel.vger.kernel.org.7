Return-Path: <linux-kernel+bounces-754264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F315CB1919E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 04:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E90A177D1A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 02:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84F1C84AB;
	Sun,  3 Aug 2025 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="f3oaib0s"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952CB1A2C11;
	Sun,  3 Aug 2025 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754189905; cv=pass; b=s97D928w8Xaj2t93z5QiF5OWhlS3nxOq5nFPCNiGL0zqt1MIITp3+yeIbQ1Ez59U/yjn4wJ/tQ8r8CF3vkg3ZkwyMgA6nIi8ygqeHiBHy9hjEsm7HB6XS4gqVG6EY1THQkgA/Gwjk29SzgPtyPIR+zF9p+XwmwcXqgSd8XRJldI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754189905; c=relaxed/simple;
	bh=xZKHgRz3uSqshLrdkkYFl9Qnm6/OL0+pgAadhN6KXW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usgHa5vzUHFv+EMIzEidyltmawWUTiwsYn1lsQfAJdsarsGvr2/qo2xuLY5QJoIQRXJ6e0GTZ+O5LdId0KvjZM055WbsGzaw+672xIwoRfI1F8TuTaCLKWQMadJa9Uie4vDjU8dEbOrL8ZWewvM2T4FQm0cVmBl4PNYAyYPEKw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=f3oaib0s; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754189887; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LkVdGpsewSq7EUoNkwSZFDq48TcI9YZ9dASr5aKolIkup9zpqRImu/LWAePVcXK1JheZfAtDHSRNNlMEQZGzxAqR4y3j+yaRPTlvhf0Zl0au3tKquKtQ+Sf1Rv5v5noeCI3CCJMe7e+GKIrqHPOs3aWBVNtLnqWrI03PtnDPyzY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754189887; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i0Jx5wsPXVzHcNKwvNaiczllxlJAA25jxDOq/uaaaSM=; 
	b=kToYBY8sLrcxmNM+NeoNfHuK5XmkaeElmo60w+600pWaLxADpC3vG3BLOvPTM7zD89+Z13C03f1eEJNBXHo6iNS9SzWtOrY9e+Yq1D9itN/wkqZ3kSOlKAlC43eUu/OEedOGCdvVN//t8eZF+osIAx1Se62ZuYdrZoEkGtYh9l4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754189887;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=i0Jx5wsPXVzHcNKwvNaiczllxlJAA25jxDOq/uaaaSM=;
	b=f3oaib0sr5t8khGJjviKaV+9fuUvEnxpxVlM7HTtYPOHT0yoi2mD2j7aZdwd7OFA
	3/sTyG5wQ8t9o1QU4epqE+HJzZzjHTx613da8X9x6NRHY8rAkXUh30QLNAxohmvuBJG
	0C2JvkINc/i6YyIF3bli6UZEpd3wrJ7iJYwiuORQ=
Received: by mx.zohomail.com with SMTPS id 1754189881012449.99415784449957;
	Sat, 2 Aug 2025 19:58:01 -0700 (PDT)
Message-ID: <757cf40c-a48f-4980-b638-35a29a91ecb3@zohomail.com>
Date: Sun, 3 Aug 2025 10:57:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] riscv: dts: canaan: Add clock definition for K230
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>
References: <20250730-b4-k230-clk-v7-0-c57d3bb593d3@zohomail.com>
 <20250730-b4-k230-clk-v7-3-c57d3bb593d3@zohomail.com>
 <20250730-laughing-dancing-emu-5540d6@kuoka>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <20250730-laughing-dancing-emu-5540d6@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227eed8815bf276c5c4b75ffa5600006591fb6f11eb539136822dedc845eb4f784c06394fc0181388:zu080112278cb6ca04e82c2e93804d320600000b8ddb55721fc1512e19cc5620ff577603d30229fcb367ab14:rf0801122c266281f77e22f90ba2a807280000940c7b3693dc9be470390b6e4b350d435e079e35d9802a6494db8e13fbcf:ZohoMail
X-ZohoMailClient: External


On 2025/7/30 15:06, Krzysztof Kozlowski wrote:
> On Wed, Jul 30, 2025 at 02:43:53AM +0800, Xukai Wang wrote:
>> This patch describes the clock controller integrated in K230 SoC
>> and replace dummy clocks with the real ones for UARTs.
>>
>> For k230-canmv and k230-evb, they provide an additional external
>> pulse input through a pin to serve as clock source.
>>
>> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
>> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
>> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
>> ---
>>  arch/riscv/boot/dts/canaan/k230-canmv.dts | 11 +++++++++++
>>  arch/riscv/boot/dts/canaan/k230-evb.dts   | 11 +++++++++++
>>  arch/riscv/boot/dts/canaan/k230.dtsi      | 26 ++++++++++++++++++--------
>>  3 files changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/canaan/k230-canmv.dts b/arch/riscv/boot/dts/canaan/k230-canmv.dts
>> index 9565915cead6ad2381ea8249b616e79575feb896..6579d39e2c1690d9e9c2b9c884db528c37473204 100644
>> --- a/arch/riscv/boot/dts/canaan/k230-canmv.dts
>> +++ b/arch/riscv/boot/dts/canaan/k230-canmv.dts
>> @@ -17,8 +17,19 @@ ddr: memory@0 {
>>  		device_type = "memory";
>>  		reg = <0x0 0x0 0x0 0x20000000>;
>>  	};
>> +
>> +	timerx_pulse_in: timer_pulse_in {
> Follow DTS coding style.
>
> Please use name for all fixed clocks which matches current format
> recommendation: 'clock-<freq>' (see also the pattern in the binding for
> any other options).
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1

Got it, I'll update it to clock-50m as recommended.

Thanks for pointing it out.

>
> Best regards,
> Krzysztof
>

