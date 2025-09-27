Return-Path: <linux-kernel+bounces-834878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BCFBA5BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FA54C507A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FECC2D595B;
	Sat, 27 Sep 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXF2nlsi"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4DF2D593D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758963544; cv=none; b=QvugSDsk6UEI6mgoNnGTflDgHpyoJDxS03+UnI93MGm+IyPlO+BNCkUDXQGlXSNOjYMhFKV6ifTVGv6x/nXR4Uk9GIUZ/Bz9jEKzLhb6VnA6Ijl/x5Q2+VFEse61scIwqwl4iRLnJOaB0dZastqNZPSQ1uB3nzBedFhzj+H3Abw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758963544; c=relaxed/simple;
	bh=Fqv0rk2xEnCxMxdyvu6LEpbT7k7Ly6+YLv0Ia7aryGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rsid9U3mNqxluQVn233LnklktceqRzkd6Gr+JD+tXXaq9PgE/vFjq6X4PPc1lzAnnX7Ji5qMd6fiwcaKaGKh7w1FO8CMCk700PcoZAuUXR5Cu+K67FYuThV7gcwzUA7KiJ98/7tA29Z+7cYsSu7NNeQyjXC03JuHivlr/5zy0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jXF2nlsi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee1381b835so2523788f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758963541; x=1759568341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x79LHukRr0nnGPYI9WtBJE+PwBazgPmAPIbZ3yhdhJk=;
        b=jXF2nlsiXp4XwMXUS6R7iD7Ch3SttM/9WsoAWHnZQjXW1xoNMlsWHd386HWLL3kyOk
         W4xrQeGkmIzhakH0t28nKgrJkEUngS4NO6Ylz+LuGG/FhWjOhbRLv/ERi4Fk9fhUUrDY
         7/Q3zl5LJP4MkmEXSv533nccYvKKOfwnBWarCjW2mkZvMM3/XjSJ1h9/uQPfzesPb2On
         TJFjqIefYOg1X2b6NOzc22QnCM3+PBxDrIoJPcGQdkp0DPtshxJ6kIA4Ta7IVAFzpYNj
         EjiJQaVvDOi86G3Sk+7EqK/OC32WCPThH0aorG/oG1J6wYJkIFpHQ4Dazea0TjhCkJ41
         M5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758963541; x=1759568341;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x79LHukRr0nnGPYI9WtBJE+PwBazgPmAPIbZ3yhdhJk=;
        b=V+qVeGltxmthcDbQrAn7DZU/DY3IVIhMHYv+wbKofA2wUTrlhp7fgW7893STCyA45N
         OgCiNi5g3B8bdF+sh1pfBIIU3kY0F3HPTXodEj0QLpXenU1YdUYz3faOsgb9pTkNqC2P
         8J06VPqTcwDJmJ6B1wguMEB+7DKvCW8xNyWyBYiyOgSPDfYope5e8JhSEPC4rKdmYPPj
         1CTpWhB32exedBxgW37GJd3a0GFwP1ThT47fZQNJHRIuKpgiOiyXnbdTzsfWoh9Y9V2O
         lJG9Bp0+XJ8a1cb7GRPrQWl4o5q/dLx4LFEwm7whItasVy3Qv8hKa8FK5XU7Q8uf7h9W
         9nkw==
X-Forwarded-Encrypted: i=1; AJvYcCWe30NOxURoSogI/pk67hv/U0Z4o5QeYJQssR/L4xoXTKoIyMct5NkybA34ypyq2AOhz0agMzLcAw30h7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZLDAWZ8exA+JOxvus5lBinmCM2zlR9kzCoVfgtZ/GN6huDYr
	GawYkfWPXhCqyOYKhBk82j3k1xLxUQvUCdlYnNmPv+msuF8U2tFz1x0UkeYtshmvLIA=
X-Gm-Gg: ASbGncvqkwk6XNHai9+Id3gmxzydqxdp7jrrujNoGcllYEJe8sjcT4zSvX0sodoKAK8
	pV1FmKIVEfH7zFGnZi3p9sF/bvvuoB1Qep0Lz01T/foVm0hBaoKjB2zfIfY3M/16uRDsppK2xsT
	gzr7kzb/pmuZ8an2e2yi5OKWs7FnpV5fNL0N2G2Cvs4S/4mGBGqmK6l54ZF8xR54+kJPnaH3H0m
	XX3uv+RKVvyHITEM5xYFNGIkR5GzjQKaOiJX0lQeiSU/1MNVydwVVkVqc0K0Y8FdQvasx5XytYT
	2em8+n83lO0PGb/3yjrZWL2U50/Qqyjg1Ofv7b5YI6pR3ddHsFmOup+luzoAZ1TeQ/RQaP1ti3Y
	NgAbqU8dSlW/jiPhBmzJBb5t+WkadXDFo6ciCpCNvI1+pa35ZhrFmSUi8n1UrPN29n+aMyXdnny
	StCBvPHDXQ7FiEQrZZiZ0vSx3w4lZebQo=
X-Google-Smtp-Source: AGHT+IGfnon4MSQqIVTAixxjvIFsxE8Oezc5BNxym0Kqm+h8CrAyJE0vkTIm4xnHCIpiDfBBZXcogQ==
X-Received: by 2002:a05:6000:1884:b0:3eb:4e88:585 with SMTP id ffacd0b85a97d-40e4bb2f61dmr8701044f8f.29.1758963541203;
        Sat, 27 Sep 2025 01:59:01 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fe4237f32sm10058496f8f.63.2025.09.27.01.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 01:59:00 -0700 (PDT)
Message-ID: <b6066559-72f0-4f1d-9134-c93f732fa6dc@linaro.org>
Date: Sat, 27 Sep 2025 09:59:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1-dell-thena: remove dp data-lanes
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Laurentiu Tudor <laurentiu.tudor1@dell.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250927032240.20759-1-val@packett.cool>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250927032240.20759-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/09/2025 04:22, Val Packett wrote:
> The commit that moved data-lanes into the SoC dtsi (458de5842) got merged
> in parallel with the Thena dtsi (e7733b42) so these lines remained.
> 
> Remove them to enable 4-lane DP on the X1E Dell Inspiron/Latitude.
> 
> Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>   arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> index d71b67824a99..ef83e87e1b7a 100644
> --- a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> @@ -1090,7 +1090,6 @@ &mdss_dp0 {
>   };
>   
>   &mdss_dp0_out {
> -	data-lanes = <0 1>;
>   	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>   };
>   
> @@ -1099,7 +1098,6 @@ &mdss_dp1 {
>   };
>   
>   &mdss_dp1_out {
> -	data-lanes = <0 1>;
>   	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
>   };
>   

You should include those commits in the style of below

commit df8922afc37aa2111ca79a216653a629146763ad
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Sep 18 13:59:15 2025 -0600

     io_uring/msg_ring: kill alloc_cache for io_kiocb allocations

     A recent commit:

     fc582cd26e88 ("io_uring/msg_ring: ensure io_kiocb freeing is 
deferred for RCU")

With that fixed.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

