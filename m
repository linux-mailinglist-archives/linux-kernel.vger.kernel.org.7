Return-Path: <linux-kernel+bounces-804195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1047B46C71
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CDF3BE732
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF92877D0;
	Sat,  6 Sep 2025 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="I2WNNwF4"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C3284684;
	Sat,  6 Sep 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757160628; cv=none; b=dhMnP4ZblSyeK891BeH67J1y2dt1IOpwKelTLlEdcwTkoOm6dxcuxBrfWtNYDOMckbcGinmcWdaq3VdffZtZHJCrHteFh97YfMaFgZBSWfUEGFnfIRg/+XU9COAp/dimOlfxHNykX6Gt/m2XBMxmXHRyrvNvU2Mwcw8M36yZXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757160628; c=relaxed/simple;
	bh=byIIaNYjmBTmMjH1augUUyia9CWgYF63JuQOxkuOFqw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EU8vN0+9AQWFCqJK7Xpy4fDwp/ONr4tuK7EnTUpB2XndIjQtopGMvw8RmPhoEwncDgVY1ITbB0pB9hm6gvrYvuQqJefKhn2pcJv7e3VfGO7Sy5S4XUjtYX8pv2EZEtV4aEk1kWBFOe3B2wfOXbz6wrtv8gXvxDics0hAbsKwwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=I2WNNwF4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757160623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vADT7opWRct2rqiVIZqiOBr/+HV23dbzmDRf/TThZaM=;
	b=I2WNNwF4OGGTvLxzCQRJVFYSr9v8AEMmTidkPl7lrNUOX9p+fRjbSL5qlvuEvadMuVGNw/
	8+qMS1iCO2Ju4h/qCAtQVAJHq8ygoMPUAfoNUwdBS/5Rh6X+saNi6xCfSka8zUXt/HQybP
	f3ZBdJoupsOKXgY1LWZtQrGnQS8lwq0Ykmu8prGC3CXyVfOsf0DifWm02nqn3C14f3WbTY
	bG7BXzqk21FEktYf42VV8m4rVGmt6zIiP7BMywYJ4brQNtCgwFGpRqJB4BgBJeHNkI8wnn
	5FoSF3/zb3Xe05M+c2Alm5YApbRXiF2IOGYNe4nkeMZXFRDbCB22BG2VTbOppw==
Date: Sat, 06 Sep 2025 14:10:22 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Make RK3588 GPU OPP table naming
 uniform
In-Reply-To: <DCLOTR9Y380M.22GZYL11XXZM2@cknow.org>
References: <355c16ab070688fc6285e0d4419eb54a3f699eee.1757152740.git.dsimic@manjaro.org>
 <DCLOTR9Y380M.22GZYL11XXZM2@cknow.org>
Message-ID: <47cf50f2f497108a923815c12b1f8c9b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2025-09-06 13:40, Diederik de Haas wrote:
> On Sat Sep 6, 2025 at 12:01 PM CEST, Dragan Simic wrote:
>> Unify the naming of the existing GPU OPP table nodes found in the 
>> RK3588
>> and RK3588J SoC dtsi files with the other SoC's GPU OPP nodes, 
>> following
>> the more "modern" node naming scheme.
> 
> Like we discussed in private (without an agreement), I think it would 
> be
> beneficial if the (gpu) opp naming would be made consistent across SoC
> series as right now there are several different naming schemes applied.
> They're all valid, but inconsistent. And if consistency is improved,
> which I like, then let's go 'all the way'?

As we discussed it already in private, I fully agree about performing
the "opp-table-X => opp-table-{clusterX,gpu}" naming cleanup 
consistently
for all Rockchip SoCs, but I'm afraid it would be seen as an unnecessary
"code churn" at this point, especially because my upcoming Rockchip SoC
binning patch series is a good candidate for such a cleanup.

On top of that, I'd be a bit weary about performing at least some of the
testing associated with such a platform-wide cleanup, despite actually
performing no functional changes and being a safe change.  On the other
hand, "bundling" such a cleanup with the Rockchip SoC binning patches
would get us detailed testing for free, so to speak.

Of course, if the maintainers see this as a good opportunity to perform
a platform-wide cleanup at this point, instead of seeing it as a "code
churn", I'll still be happy to extend this small patch into a platform-
wide naming cleanup of the "opp-table-X" nodes.  On the other hand, if
this patch remains as-is, it may hit a good balance between resolving
the currently present naming ambiguity and the amount of introduced
changes.

>> Fixes: a7b2070505a2 ("arm64: dts: rockchip: Split GPU OPPs of RK3588 
>> and RK3588j")
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi | 2 +-
>>  arch/arm64/boot/dts/rockchip/rk3588j.dtsi    | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
>> index 0f1a77697351..b5d630d2c879 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
>> @@ -115,7 +115,7 @@ opp-2400000000 {
>>  		};
>>  	};
>> 
>> -	gpu_opp_table: opp-table {
>> +	gpu_opp_table: opp-table-gpu {
>>  		compatible = "operating-points-v2";
>> 
>>  		opp-300000000 {
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> index 9884a5df47df..e1e0e3fc0ca7 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> @@ -66,7 +66,7 @@ opp-1608000000 {
>>  		};
>>  	};
>> 
>> -	gpu_opp_table: opp-table {
>> +	gpu_opp_table: opp-table-gpu {
>>  		compatible = "operating-points-v2";
>> 
>>  		opp-300000000 {

