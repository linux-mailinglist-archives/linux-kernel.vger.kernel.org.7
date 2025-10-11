Return-Path: <linux-kernel+bounces-849130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F2BCF445
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED29E4E9156
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DD260586;
	Sat, 11 Oct 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQbmF7++"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED51224AEB
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760181419; cv=none; b=Uap9y2JB/lUlQvmQ/D/yXAPBVXeWpNwgyCzG12RHf+zyBzCVhn1U2Lwjo6yNBhvsTdZ4r9sLMxzdwLhEPRJdu8CCkvv4/wP/XqVQTGrRd26gVlXfS8eo0RjXLCvY2mrE/BQaa2Wnrwwnczt3y3QupNouqQB5iYn43VKeROLcl6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760181419; c=relaxed/simple;
	bh=UyRiyzPF86gOcbq6CKPEBOWNiK5DI6edannG01khOFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5nWomvnONdrSHyf27hWl6HrPLAM4R72JigClIXLBAPLElV6mX9nsPAlzehsGjpi+zzSN+bwXUeaFN6sug8vk5XwS+z15pal8kyoHSBktOKnbYPUxsuvMc7pvb3MaUD34xzFNmCg+cJDz/H2h3p3kHdc+NPSgukb2qI+0K6yt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQbmF7++; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso2085000f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760181412; x=1760786212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOXB6bw6WrZEaodB98TvnCTQEl4lj2dhph53IPTTOz0=;
        b=UQbmF7++HHa82AGTEBsriicSmXXacy8b9HBAyx74/JmnFKDUoGKJ5B8fap/3obxpEE
         pdsEIZbDkrfYdx7F+TTcsoxW1tPB7ltAii9KSzpEeT2f7BrdTHQ5f3xbmX3c7+BMeiRB
         IL/7x3dL5+BoRjDtqkgus+csNp207Zux0OTX5Q368RfGyjO3casEWj+zHAkMGuOT/dFC
         zxJdROehGxUoGed7jRf/aHatk0mDbpa7f10SlHqpuBrXbJSTT0+Wq129m5O92/ogxMku
         VEG8ok6yFCYhXNqQbaQmEwBN8S/tCFby6MBmHBS2AlzIGxSsoR8dOsJVXcxa7GNGWOkh
         FTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760181412; x=1760786212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOXB6bw6WrZEaodB98TvnCTQEl4lj2dhph53IPTTOz0=;
        b=umsObPbs7LIDQCaNQzMlIWzf4y+sTyDGgJjgO9p6kh+EObELb32I2biyBQ6b3+FwBs
         3sMFLcQGreliUADTnaVncbKIv4SKF8V8vBSpkKkSYmXfWiyStYPfK/qH/7j3IIyNseGV
         6FIBVtkPM0LhUG7mO+rYTaWhDqSXUFxsMMjDyuDX7vHNF85sligvttDgYGTm/LGPSYNF
         5dCRkuv8s+8mz50vLBxJGHH0SapM9XE6QKr+sgAloqH6h8REuL1tiyBzVcx6FAS++he1
         qf/31CHwdl2IyFJCdIDvuEvqsICB65HQ7GHzzIBrWtZ0JzOTGdHT8AVYnC9cUcXZkVTS
         eQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGT27uW+pRQYMKvxesdIZMDhbiUj3/zXo5L1WFIPQ+KQSX1RugcKCG6X94zeyzjcKZ0HXRXCUKOnoj6mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1EUa0cJr5AX4t8DtbUQeNTzKCwFzAEflAyNwhp4g9Gzvmndw
	04qNiznxl5Y8t3waWpvvvvWw20FwK/QVrAFkHygIxRVf9Z7V0DsMSsN2Hg1fCmEN9UM=
X-Gm-Gg: ASbGnctLfuhauebrcYBhFmOSmeixmtwlja9xz7W+NnoqRPXna6jUn3NvuUA84Fi0hw2
	NGUGMV//apqArc4BoyMQNfTtxy/lVgEdKqw80hQxkLFjIqv4o3GV/CjlW+s1C1xT+5P2G+0wq00
	7gkoFqgTVKAXajHI/P7RKRk9JyMohrrQ5dEYkwiAoQjXNWtu06zasNUwdnkyAoWpq/Dsqki4h70
	tpsa8HxGznq5Twpf6RIm92Y2XyKVvUeqXN17F1aMXtlE6Mor/FMwc1oqA6jzlbY6gwQeiytxkwM
	pxURgnRMA3EMfigBXanYRoEntD8V0QImpcWx/jc50urywsiQc+VGTguR4StiTLxlnVIcJ6npejC
	tP1DpgA9eld2u9JDy2K1cxMdfQzITvbjK7FYNkY4A2A==
X-Google-Smtp-Source: AGHT+IE50h2WW1YMKbq5LDos11XdACJTjQ1oP8AgsbZASw+0k7tw8uRNklw1VJHaAPcv0n0I8qhmOw==
X-Received: by 2002:a5d:5d03:0:b0:3d1:6d7a:ab24 with SMTP id ffacd0b85a97d-42667177c28mr9839516f8f.17.1760181411884;
        Sat, 11 Oct 2025 04:16:51 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe4esm8331705f8f.26.2025.10.11.04.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 04:16:51 -0700 (PDT)
Date: Sat, 11 Oct 2025 14:16:49 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Subject: Re: [PATCH 04/24] arm64: dts: qcom: glymur: Add QUPv3 configuration
 for serial engines
Message-ID: <bkenlzhh5fwspxkrq5jdcpfaxtc5hxg7w6sb6i46ohicdomed2@r2zvqvffmegt>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>

On 25-09-25 12:02:12, Pankaj Patil wrote:
> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 
> Add device tree support for QUPv3 serial engine protocols on Glymur.
> Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
> support of GPI DMA engines.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts |   43 +
>  arch/arm64/boot/dts/qcom/glymur.dtsi    | 3041 +++++++++++++++++++++++++++++--
>  2 files changed, 2936 insertions(+), 148 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index f1c5a0cb483670e9f8044e250950693b4a015479..8674465b22707207523caa8ad635d95a3396497a 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi

[...]

> +			qup_i2c22_data_clk: qup-i2c22-data-clk-state {
> +				sda_pins {
> +					/* SDA */
> +					pins = "gpio88";
> +					function = "qup2_se6";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +
> +				scl-pins {
> +					/* SCL */
> +					pins = "gpio89";
> +					function = "qup2_se6";
> +					drive-strength = <2>;
> +					bias-pull-up = <2200>;
> +				};
> +			};

Re-write all of these like the following:

qup_i2c22_data_clk: qup-i2c22-data-clk-state {
	/* SDA, SCL */
	pins = "gpio88", "gpio89";
	function = "qup2_se6";
	drive-strength = <2>;
	bias-pull-up = <2200>;
};

Just like we did on X1E80100.

