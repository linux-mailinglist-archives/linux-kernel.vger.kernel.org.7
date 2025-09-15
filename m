Return-Path: <linux-kernel+bounces-816711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8214EB5776F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3C07A149A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AADE27817F;
	Mon, 15 Sep 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUpx8rxT"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34062FE56F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934041; cv=none; b=hy2xdCwslqsSOAiZpwhHLsN/CfJmdtFQM74oWMnNR6XKRiSLWQf8/18xM3AvDwygvTeC/mQz7SpmnPZT2xmmnpdp9XFqdfsU5VKuY+PBON9FAgi08fnQxJMS8WqC7SCqNLfIJ7NxqUK2bK+GQW3251GTDT3c1iumJMZ0HDKov/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934041; c=relaxed/simple;
	bh=i5sgCc01vK4RPSfrnI/Y9ovkRzVT0szN5lG4kf9sjlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvU8Inxt7yeGAS6S0tSThbyB5U8CYVaL89FZDI0gQ6sMHIsSEaZkxKul9/Ggq9FHKZuiHW/XJ4Ly6Lv2iFsddlaUrtoA2j076cJegBIBzDs2uv+clAxXr2PRmlwVKwyeX9YKYgS/R++k+HxI3q4ODBUNMcpet6Pe5CA2m4yvurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUpx8rxT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3dae49b1293so2277957f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757934038; x=1758538838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE7Xq4L1Dtfsz8f3IxnHKAOzDG+X/UjcqwyZapiSDj8=;
        b=cUpx8rxTrGfAhAUS02BT9pVpnxnIYzcbsXcry34hkSeZmwMLAcCj0nDPx2W2hGBiih
         vSk6a98fkN2/VOOzFzZ7eBqCqUaOJScX7+AKFlcgEi7SSevUvKZwvmUF2g9sVEOlcbqw
         XFmW+n/uhJ/ndzvhqB0umij2Oinq80pSqwxhtkRl4UrPpmULchBSchLFyrWzU8XQ6k7G
         sZSr2y44ALdMuSNe8If7jKjFIu6Nc4UFa6YTa9mVzVBr8XuEYEI5o7nGyOI02l1VhNKq
         NlfETCAnyeuULza+MILfbbuABtYdgw0HnFyGw6Mfly0S0YaWwvtyplXUXasCH4sN8Rsv
         JyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934038; x=1758538838;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE7Xq4L1Dtfsz8f3IxnHKAOzDG+X/UjcqwyZapiSDj8=;
        b=wi40znghHbmJlSzg+ZD2qQJ80WqIjXN5Um10/f4aB3Ipak2w+Im4nojDKx9mPpDOoP
         zzKTxCiy+6JW2mv5xzJGKgRKgCj/iwyE2kbB1K46XuVYLr9VF71oqzfB6+ulWh1Cik+9
         N22jr7Z7HMlDIi4hB8FD3I98B33MsIdNXGMZ0mtr/4xQ1e41+NgBJiaWW1bNfUrSbscn
         kmJ3vIfk8/znOfRigQHitRbNoH3ALHGGA8+sP1wHTa/u58x7zMI6XiF78VM4aso/StoH
         4s9ziRhfdACop59xIV6Kfk9f6dIksqb0dgHPHF7DljXGHRxCZBkAYasupwb917iI4ySr
         sInQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxOH5kUNP/Lu3T5bkPewY2pd63zeLOkkDsD1DJkEPewUjK4ty4jJynSIL52D4JLsvPxge1ohIpHApVxuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3UfYvbtB3D6+9m7RktiQv0zKScg+nH/M24YXfNidrxe7kWcE
	DEg3OgHBbhz9QxLr1xRpViqVjaC/+WO6uC/4oYcE51D/NpVL0GR69Ey7KlrhtEC/w5Y=
X-Gm-Gg: ASbGncvarXsB8j0S9jAMFMAe89U65b9NzYW1uJfHqRZpb5znAmW/8Wu6muh1VJWG15Q
	fhGrlTKezektvg5DgSMDfQ/10HM4kutu/TYsU1ykE6x/SmezsGhi7FBZ9r3ZJ1gwI20i2EouBLz
	lU1fhxfJqGWiOXKWWTholBxpynk99sMgUXtunZ4yeJNzlqMYN7E+lks8suahM/CmeGWbqR7E+5C
	LDRmNhOZi3FpZ/WYQUQ4um23hk4OxhfX+r4YqfdlDDB/yN4Gfx1DctRRMybKdsqGD2ZSVQ6VQhf
	W8zePibmr/qJLPX2OI9wk1jjPc1Nfe10mvLv9i5Bn/XGR9ROkuXQ9+2s30TSo7u5rETbAckRVdd
	4knQ8mP13RcYjT2CzSoeG2yKofFkwKQvHsoqdkhxdt/spufQhfLTxRUFAboulZCL1W6PTwK0WK7
	g6dgf8gq+8GmqD5DclINY=
X-Google-Smtp-Source: AGHT+IEWJRcQLHslpmLibsz3O85acgnTfdDU/E/N80/0EiGbiQC80sxLfM3h7gRZBVAU0IOwhNxuQg==
X-Received: by 2002:a5d:5f82:0:b0:3e5:a68:bdd0 with SMTP id ffacd0b85a97d-3e765a26bdemr11811776f8f.52.1757934038000;
        Mon, 15 Sep 2025 04:00:38 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b4222sm175270115e9.20.2025.09.15.04.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:00:37 -0700 (PDT)
Message-ID: <9a91fb03-ee63-49e6-b554-aecdbdc20014@linaro.org>
Date: Mon, 15 Sep 2025 12:00:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x:
 Enable IRIS
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>,
 Anthony Ruhier <aruhier@mailbox.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>
References: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
 <20250915-x1e-iris-dt-v2-6-1f928de08fd4@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915-x1e-iris-dt-v2-6-1f928de08fd4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 11:06, Stephan Gerhold wrote:
> IRIS firmware for the Lenovo Yoga Slim 7x is already upstream in
> linux-firmware at qcom/x1e80100/LENOVO/83ED/qcvss8380.mbn, so enable IRIS
> for the Slim 7x with the corresponding firmware-name property.
> 
> Tested-by: Anthony Ruhier <aruhier@mailbox.org>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index dae616cd93bdf54bf2d3a3d4d0848e7289a78845..e0642fe8343f6818e1e10656a1d8fec8fb09e7e2 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -1026,6 +1026,11 @@ touchscreen@14 {
>   	};
>   };
>   
> +&iris {
> +	firmware-name = "qcom/x1e80100/LENOVO/83ED/qcvss8380.mbn";
> +	status = "okay";
> +};
> +
>   &lpass_tlmm {
>   	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
>   		pins = "gpio12";
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

