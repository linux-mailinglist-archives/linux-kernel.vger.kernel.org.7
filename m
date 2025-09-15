Return-Path: <linux-kernel+bounces-816709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A2AB57775
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6313B306F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DB82F5331;
	Mon, 15 Sep 2025 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OccjbSNe"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729D2FE56F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934017; cv=none; b=OC8psnm60sfuslW6xNoAK3/F2krTMDAS+hW89OSzlJPiJvkq516z/unl0MpQ5XT0GV6jeHw7Mta6HkAYUjh89tNSLhOOCL7cGshJ9bCQECYbctBvxQLW9rfoLtg4EYuXeI+RhJQlTdadBwI8dxngeQduKVzi4I8ME/MZWc/dtxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934017; c=relaxed/simple;
	bh=wfYWp8Pc+UKJ7u8yqUly5+sstAVS3iqcTk4Y694W6tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0KOtj4W3JwVVjxYNkLLeEDHIXCK6aQfTvAl5at9dpW6l27FyYTBOIV6a89xhl8aa+UGRNe0q9BZEiPJ5G82Y1iuFI26nOW+ZL5JApEr7FOxe4FE3VGoyk76IdZSj7BYVR1rIe2u5RzNxa7Zrbn36s7Fl+MxEzJz77h2qKKXYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OccjbSNe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45f2fa8a1adso3518485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757934014; x=1758538814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGG4uvrLGLaqWZFKcwV746KSIB3cs3UMAq8Ovw+PWKI=;
        b=OccjbSNexltgFmncG4Gdh3NfulkzvtRHldiYED47R6s6HgLTiB4TDTszxm5v1F996Q
         oAHedUuZX54v9xKO/wwGoUub/8MT+KOsW+JFN8Gpjp4vR2k1DK1+BFcKEZi80/eKVn+g
         L8VG8IStuRK4mccHbwyG5zlOoL4JAXSs85ENFyUOrSB6RjwUkv3Y9qhPWWS3ZtcmPzv7
         q5p0m/liPRGFR5x2oEkgvZf4GvwNhJe9EH8geAemhIoCerfBeBapYEOf9mqcuP1SK1c0
         SBmC6wtVqqXmfUoRw+qPNedI9uD0pVQOc/DgKmzlYagfGjB7pqPjTOSI7ChaGhJ62dhg
         g9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934014; x=1758538814;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGG4uvrLGLaqWZFKcwV746KSIB3cs3UMAq8Ovw+PWKI=;
        b=b3UI8vR+z7bD2DV7jsd3al8LptWjQXlaKfK6UXrMm47wkCXUM3T57LiucmEwsYnKvg
         MBbR9ZBu2pD6b53lAqpuelLsSoWzKIgev9bpZFbJeLX1PNF9HgRmkylmAaBlhszNYVrM
         hxh/S7FQxIBV0rnF8Nkd5w1TPzk4Xw3Lq9JI9MLeQujAqYJl8yWWWvYQ1/cB71+MfrQG
         CgxbbapwZ/H+8uJ8F5BQeQ0H1ybjICmgiqbdVCFmRpH79JzJiNWqM3HFLXCusRW5PKzG
         E+3YgN2dUy/bTtQNRt4MuQT16LRpthrBJ4QTYLYuxi8ClPGC/g/lE83EfcWwfITTzCBb
         tRNg==
X-Forwarded-Encrypted: i=1; AJvYcCVojNcaSiSg5q1rYsbq+L7clAdkeIKlztdUUeHsf0KTtAAmhiM+PPeS2+zlVdAmPOu3OOUcrRQo1yyr3KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCaTHtJ8CTcyLW6sCuefyHTa22RD36+W9iTc2EtWlbLO0N9zT1
	ImqSDd9CLci5b0XjmXOwHvNaf5W6GNzPH+c/joC2/PvLETnguHN9/sN3tuWmt3bbfmE=
X-Gm-Gg: ASbGncsoVdmBX8kOa8XRH/v8xk+eKL6oKEj+ThuIIxd6LT8Yoy+GyV2KxsMEs+UPpHC
	C9KNGxsNapXJD5myfWL4YrSdOzY3ZO4Hla7Pmbi/3i6xywqD5LhiYvnB6hPp4+VpgB39dRoQ00e
	Y0/zFUytQR1E1CoUwSMe9JKg6HOHBTSzZvWk9MUgDEQktLckeinqUQVACRavdvSoVoX6Gp9RU63
	JLqWx0btEDq2B4ix7JRY1SwCIzStnf5e4V4NYaveiNT3y9dGV1ri3zQGqqPphUDSlqAx6Od0Aeb
	nch08SyYEZer1AvyPKKQIHrqpJ5PH+zrC7rej2AQwMC9RqLgJu7pFJOUTH6aBsSeUAsgBSX399g
	C0FLPpioziDi239Crv+sV/+ZBv1f+EVcCpBq+vg6QV6cnhWDcbjw5b4DULqv4ddmCHFal/DtOGA
	3YxEKBrs6+O0qYhOSsyeI=
X-Google-Smtp-Source: AGHT+IEz91FCTl1nmoK5pFTyflSGIV86EIxriwQSn5dTyu41cWmq0H40aC2oqi7gM/aMoDsw0b0qeA==
X-Received: by 2002:a05:600c:49a2:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-45dfd5e3d5bmr99292885e9.9.1757934013500;
        Mon, 15 Sep 2025 04:00:13 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e014ac1f5sm90871305e9.0.2025.09.15.04.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:00:12 -0700 (PDT)
Message-ID: <e825b2f2-c54e-4189-9194-5604c08cca96@linaro.org>
Date: Mon, 15 Sep 2025 12:00:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] arm64: dts: qcom: x1e80100-dell-xps13-9345: Enable
 IRIS
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
 <20250915-x1e-iris-dt-v2-9-1f928de08fd4@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915-x1e-iris-dt-v2-9-1f928de08fd4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 11:06, Stephan Gerhold wrote:
> Enable IRIS to allow using the hardware-accelerated video codecs. The
> firmware is not upstream in linux-firmware yet, so users need to copy it
> from Windows to qcom/x1e80100/dell/xps13-9345/qcvss8380.mbn (just like
> GPU/ADSP/CDSP firmware).
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> index 19a2604038a88f37e6ab87129a6318db78345339..58f8caaa7258077d2c267048ca048279109ddb71 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
> @@ -875,6 +875,11 @@ touchpad@2c {
>   	};
>   };
>   
> +&iris {
> +	firmware-name = "qcom/x1e80100/dell/xps13-9345/qcvss8380.mbn";
> +	status = "okay";
> +};
> +
>   &mdss {
>   	status = "okay";
>   };
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

