Return-Path: <linux-kernel+bounces-773240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C459B29D13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59381769F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF2B30C358;
	Mon, 18 Aug 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYmUCQIp"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB9283FC3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507766; cv=none; b=gXMAMBvu+e8cw26OmXXv6IlrY0OBCT/VmHjNRMGrGYqfU/kgbzSxCWv9GmSBH1z2wkVJjL2U1qg2jR4yiM8jcf2BPxYjJ8GVR4wV1xw+j9bfQRDobXuZ3aoEsWyvrjU+CLfWl9w5MsxiCwlEkXejgtmvTPDQNSiNtElqa/16uc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507766; c=relaxed/simple;
	bh=KHB43Z17LrATDP+I+UcK8mr27MT522jgBABjSbmHMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPqew22EkZBts0dVIdYRcUZzINAcMm4oN37sfI7PCV+omfgA4lD9kTLqtFuEpcrU3hALSJhLSq6+ghL49RaQeRZSUriIPn+YxPO91npARA3E06uQ2FghnY21fEG2RxCVXfNxMytr4UhR+J6J8Hm/fg5ljv/IrEFQWM7hyS59KR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NYmUCQIp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24457f47000so31146395ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755507763; x=1756112563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tw7dbgkD+zT5jAWthzRKn29Iz3U2WQf9p2WltyhBPN4=;
        b=NYmUCQIpI1imdGHzDkPC0xQkhWmc31Ix6vyTpNj5GGjgyKNOKWTHw0OdQ8yoEsIwU8
         bUnp0FFdKY7l6GYnQBdpOan/cFWgG14FPa4FxxyWgDxcknsg6czcPmJy+F0hiI5qxy5s
         p7+lp0xk8ekGyObhMKPcZkiVpxk61j64M+r6UshcqVE7X9Tu2it71NK8WJ4/6Dre+zFG
         O8wVcoIlRaY4eBRyfj2GClven61oBWxPQV+CS2iK/vp/57MPiEky574pRf6+oWucN/D8
         pE0Tpl+/9hO5jotUa2cDQIYpOtwuJF+sp8e9n4Vqq6eiaBcnc3FpPcMi2U/hT6swDifK
         vySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507763; x=1756112563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tw7dbgkD+zT5jAWthzRKn29Iz3U2WQf9p2WltyhBPN4=;
        b=wTCqAi4lzZ/Xf++J+5TQDDenX4A1LX07LG2vsX7K5OmMEw5DzeILCB2XrAGKGxKVH9
         XddvU2lu6UzHTodlPffZthYsMLTwIrSm8i40Bd+ycUkVn7XCNAYiw38wJ05SIPRTCzM4
         fcylw9AJjimWZGqJmIBagZdd2Taj+9qh6rqocGpBdJGDXaB6lg/zCt0ajJXl9GIyc4W3
         CLxQibp0Vump/80sgPksjc31230+Ep/HRCnJPjvHex4KisDeC23RVI1/UaNrBiy6+Fn5
         cqkeBSkvEFSnphbRmxTT4jEfZZBmtbykgqccMbugwSr4uKktXqnhjfdN4kfya/QCT5AK
         bvAg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/MtCsr/8QOZeZAyec9LI3gs/Cy03QmYCdrfeP0vCmEU+wtiLMRaEZCSHPJh3aGpIvGZTC+mTcSPHGps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJXoK7gUOspLDBjjoAvA1IvxndV4kzBW6R0rjnFMECdcOGlfD
	n0yINQOffbQFKI+YnNf5+pK+yEgJ37Jrhxq1cvPph4QfI4Eo0TKaG+cwyBVx06R5s7s=
X-Gm-Gg: ASbGncujrqxJy5XwlWDnWqbKFHNwJRtALzSfZiJa2qjcEOZ+H2wcO5NrvIx2mZpYDSL
	s6eA8e5RoC8kgdXCify2nt4gzi5/0B0i2yR4c0tM51WnBDRhMw76ihdWWYxvPdVtGr1netVXHYh
	VUOZPvXIUiG7OvJl8cFiP/5kBFdkQEzVYjtsH/jgxAGdlGNHjWntgHl9FIfKVUt8+MzEHKtXNcJ
	Dxky66Xs6yXOca/3l00/1YAwWvrhrT9GBxAL53Pn3ZmJkuuyTKCSGixbnSDAvNSuTuAaVXQkYch
	CROzW2FPvYnPcn7ezTnvFDiBcK/pWQeXdxtuvQF7BCX03AZOhlf6ajqdQhRAT5BwIdIRqv1lqZo
	7qPQ+4bhq9CsqxWOW1F3XzTtm
X-Google-Smtp-Source: AGHT+IE49BY+QEUKqeX/ukisuqIYp2KG3N61jubdd/2kSq1yDYk+d5vzKqRZTTbGf4J9qjawWGj9IA==
X-Received: by 2002:a17:902:c942:b0:242:9bbc:3644 with SMTP id d9443c01a7336-2446d9db047mr150258105ad.54.1755507763265;
        Mon, 18 Aug 2025 02:02:43 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d552798sm74284645ad.138.2025.08.18.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:02:42 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:32:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
Message-ID: <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>

On 18-08-25, 13:52, Krishna Chaitanya Chundru wrote:
> @@ -2210,45 +2213,67 @@ pcie1_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
>  				/* GEN 1 x1 */
> -				opp-2500000 {
> +				opp-2500000-1 {

Why mention -1 here when there is only one entry with this freq value
?

>  					opp-hz = /bits/ 64 <2500000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <250000 1>;
> +					opp-level = <1>;
>  				};
>  
> -				/* GEN 1 x2 and GEN 2 x1 */
> -				opp-5000000 {
> +				/* GEN 1 x2 */
> +				opp-5000000-1 {
> +					opp-hz = /bits/ 64 <5000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <500000 1>;
> +					opp-level = <1>;
> +				};
> +
> +				/* GEN 2 x1 */
> +				opp-5000000-2 {
>  					opp-hz = /bits/ 64 <5000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <500000 1>;
> +					opp-level = <2>;
>  				};

This looks okay.

>  
>  				/* GEN 2 x2 */
> -				opp-10000000 {
> +				opp-10000000-2 {

Why -2 here ?

>  					opp-hz = /bits/ 64 <10000000>;
>  					required-opps = <&rpmhpd_opp_low_svs>;
>  					opp-peak-kBps = <1000000 1>;
> +					opp-level = <2>;
>  				};
>  
>  				/* GEN 3 x1 */
> -				opp-8000000 {
> +				opp-8000000-3 {

same.

>  					opp-hz = /bits/ 64 <8000000>;
>  					required-opps = <&rpmhpd_opp_nom>;
>  					opp-peak-kBps = <984500 1>;
> +					opp-level = <3>;
> +				};
> +
> +				/* GEN 3 x2 */
> +				opp-16000000-3 {

Shouldn't this be opp-16000000-1 only ? This is the first occurrence
16000000.

> +					opp-hz = /bits/ 64 <16000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <1969000 1>;
> +					opp-level = <3>;
>  				};
>  
> -				/* GEN 3 x2 and GEN 4 x1 */
> -				opp-16000000 {
> +				/* GEN 4 x1 */
> +				opp-16000000-4 {

opp-16000000-2 ?

-- 
viresh

