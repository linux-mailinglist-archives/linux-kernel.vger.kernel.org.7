Return-Path: <linux-kernel+bounces-725603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383C0B00149
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9231C85314
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FFF24394B;
	Thu, 10 Jul 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="BWcboYfW"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F2C24A05D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149476; cv=none; b=usdAiiRpNQ+hT06gJN1u6SbxEsdHX2DN/FLT93DGGWAyv8h368jfFtwCRdQag2gGSrvKlm1en1fmcitMFIn0NbngBRWCTpOH89tZRicEg1PLmNGJdWZA9XUg2ZcpTNygbqOp4WO4cJEWTVSqHXY8x7lw+GWN+ZgksQTnnXDaar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149476; c=relaxed/simple;
	bh=CmjdvA9M9SqmEjXC4wh3Ab0CAkZBlhlktffFjr5dWEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGbs0KAv5V9pbw/L9AAZ84W20yYxr81qXPlU+a5YV01YDVTPpkWW2QtDw1zRQRxJd8gSeVl/YL8eMrgmDULLLxNfPdmx2UmRX0e1lIKRcCDqNj3MdUjb4jowVdUuOzZodrUnV6gjUr+xisKZ7vTT6LFWKT48zhNQBqY1B0ZK46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=BWcboYfW; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752149468;
 bh=4ye2+oNmz8kEE5esPvhfl5gldth5gpMh/JZU9swTrNk=;
 b=BWcboYfWlVH02XxSXAEFdKXxVjOCRRO0SEaYgpedPB1gKPiHovv/9NrZIVlHd5muThKK6NO04
 CI1TKO4MFCcm8KMbMzkRIRkEtmZqf32Ts4GO6dl6c8xFC+nnECH+e9W3A2pS1CuXeeZ0kcznCEt
 LeXFvHn3iifPX3rS2v26LWNU8cG+8xufG0cjAEilt0bq5rKrWrbU5IPsGscK4MewSn/QukJwny+
 XfyN3ACDDD5XIIWgkydf3bKoNjSS8rLA34CgCCwH/RyNeDgIl7ApdYcmdX60Z51NosjrjaOVGM6
 XLmNdxnL4KmjrRBnEesaLCdTULlnBatJtw88WfGJzjXw==
X-Forward-Email-ID: 686fadd9ea2ef028c1d7bacc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b6f8f705-f661-46cf-9dda-6f18f8658622@kwiboo.se>
Date: Thu, 10 Jul 2025 14:11:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency
 scaling support
To: Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250620100010.1291658-1-amadeus@jmu.edu.cn>
 <20250620100010.1291658-2-amadeus@jmu.edu.cn> <5025631.aeNJFYEL58@phil>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5025631.aeNJFYEL58@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Heiko and Chukun,

On 7/10/2025 1:45 PM, Heiko Stuebner wrote:
> Am Freitag, 20. Juni 2025, 12:00:10 Mitteleuropäische Sommerzeit schrieb Chukun Pan:
>> By default, the CPUs on RK3528 operates at 1.5GHz. Add CPU frequency and
>> voltage mapping to the device tree to enable dynamic scaling via cpufreq.
>>
>> The OPP values come from downstream kernel[1]. Both 408MHz and 600MHz
>> frequencies use the normal PLL, so use the corresponding highest voltage.
>>
>> The voltage used for other frequencies can't be less than above (875mV).
>> Therefore, 816MHz to 1200MHz also uses the corresponding highest voltage.
> 
> There has often been the argument that selecting a frequency that has the
> same voltage as a faster frequency does not save any power.
> 
> Hence I remember that we dropped slower frequencies on other socs
> that share the same voltage with a higher frequency.

One possible difference here is that the actual CPU rate is controlled
by a PVTPLL where TF-A will configure a osc ring-length based on the
requested rate and Linux only configure the regulator voltage.

I have no idea if the configuration made by TF-A will have any affect on
power usage, but I suggest we keep all opp here because both TF-A and
Linux is involved in configuring the CPU rate.

The measured rate can typically be read from a PVTPLL status reg, it
will be different depending on the ring-length, voltage and silicon
quality for the rates >= 816 MHz.

> 
>>
>> The remaining 1416MHz to 2016MHz use a voltage close to actual frequency.
>>
>> [1] https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>>
>> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 64 ++++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> index 829f980ea353..5cb7f10b79ed 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> @@ -53,6 +53,7 @@ cpu0: cpu@0 {
>>  			device_type = "cpu";
>>  			enable-method = "psci";
>>  			clocks = <&scmi_clk SCMI_CLK_CPU>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>>  		};
>>  
>>  		cpu1: cpu@1 {
>> @@ -61,6 +62,7 @@ cpu1: cpu@1 {
>>  			device_type = "cpu";
>>  			enable-method = "psci";
>>  			clocks = <&scmi_clk SCMI_CLK_CPU>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>>  		};
>>  
>>  		cpu2: cpu@2 {
>> @@ -69,6 +71,7 @@ cpu2: cpu@2 {
>>  			device_type = "cpu";
>>  			enable-method = "psci";
>>  			clocks = <&scmi_clk SCMI_CLK_CPU>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>>  		};
>>  
>>  		cpu3: cpu@3 {
>> @@ -77,6 +80,67 @@ cpu3: cpu@3 {
>>  			device_type = "cpu";
>>  			enable-method = "psci";
>>  			clocks = <&scmi_clk SCMI_CLK_CPU>;
>> +			operating-points-v2 = <&cpu_opp_table>;
>> +		};
>> +	};
>> +
>> +	cpu_opp_table: opp-table-cpu {

This node should be placed after the firmware node for the nodes to be
in alphabetical order.

Regards,
Jonas

>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-408000000 {
>> +			opp-hz = /bits/ 64 <408000000>;
>> +			opp-microvolt = <875000 875000 1100000>;
>> +			clock-latency-ns = <40000>;
>> +			opp-suspend;
>> +		};
>> +
>> +		opp-600000000 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <875000 875000 1100000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-816000000 {
>> +			opp-hz = /bits/ 64 <816000000>;
>> +			opp-microvolt = <875000 875000 1100000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-1008000000 {
>> +			opp-hz = /bits/ 64 <1008000000>;
>> +			opp-microvolt = <875000 875000 1100000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-1200000000 {
>> +			opp-hz = /bits/ 64 <1200000000>;
>> +			opp-microvolt = <900000 900000 1100000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-1416000000 {
>> +			opp-hz = /bits/ 64 <1416000000>;
>> +			opp-microvolt = <925000 925000 1100000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-1608000000 {
>> +			opp-hz = /bits/ 64 <1608000000>;
>> +			opp-microvolt = <975000 975000 1100000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-1800000000 {
>> +			opp-hz = /bits/ 64 <1800000000>;
>> +			opp-microvolt = <1037500 1037500 1100000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-2016000000 {
>> +			opp-hz = /bits/ 64 <2016000000>;
>> +			opp-microvolt = <1100000 1100000 1100000>;
>> +			clock-latency-ns = <40000>;
>>  		};
>>  	};
>>  
>>
> 
> 
> 
> 


