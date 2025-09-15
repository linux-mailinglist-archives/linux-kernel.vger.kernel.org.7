Return-Path: <linux-kernel+bounces-816703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C0FB5775B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AF33A33D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A1242D88;
	Mon, 15 Sep 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kF8smMcC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9121B4F09
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933991; cv=none; b=Sh1e9VTaEF55QWYezWpLQL1x95v7+qJuGyJ4RpXif7yHb3/faE5qLR5JrFZE7c0uiabdpMYbG/sqKKvCH5RE8h8vvE9q3OZ5X0fRa5V31zI7jMLvS6drRivh6NE5gg80d7RuvfK8S6n04ct96B4EyIWUcQvx9Vj1axdyRN0oyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933991; c=relaxed/simple;
	bh=z4vIa1+jE/4b0HDhWypNczdB6rHMWQ9tTqETYOZ0tXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o149dhLV7C3J77Fr5RiB3pqDVmbBMEOyqM2V+jbtMf92AWbETXQ4raIb/+kppTdLp83Yjn65AXCX3nwNt8uwtSULjEnqi4yrLFu4M+/mbYz6lBZgFvx6dM7wNzkdgLSDGbrr3z//+urirS/ZYIQfZOGrC05sVFKnpxRDmCPljZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kF8smMcC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45de56a042dso26337205e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757933988; x=1758538788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZJB/Bsvr4A7muWR/f1MBNyM3K9e22kPh9FuXwE8xe8=;
        b=kF8smMcC0+oM7wTAe27jeUKbCTQKfQdDTRJ1f8BDnnIa8wcCbEUx1HcMPRvub1H6rS
         ddXK14vbIMjUQzyK8+vpY4YnO4sX+SeCC2ffpUUVWFhMuYvqEwizzkm0jFLeiDnf2WTR
         S1i0E/BP3kVP3gmKDWoHVZ+/j4BZ9g+iHzHVPrMOJ+xWOUTSkJ9MNqOnx3U2gZW/XKiW
         UWfNPg2lHeXnWP2sRc1QPmf9LV84DTY6+v3iJrXqsVWHc8aWDcjCpxKegVxWD/UqPPO1
         jrSJ+XGb3PYdmrX2Lk5dQkjgRiO1Ah/4LL3pjrdMiY0jw/ZBXYLur8R8NgIo2tVo8vpH
         bvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933988; x=1758538788;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZJB/Bsvr4A7muWR/f1MBNyM3K9e22kPh9FuXwE8xe8=;
        b=QeQsVmIQ1UASEnsE/q3CvFl0TYXpoHsU0Hyy49ob3ifkuFp/X2eA81W8MI1Ke1gjtO
         8F4xLmFwJPBZ0vhL/OwJOpc1mt7dWiXfts2Y1EKKGIb0XvcgApd5HygmJeNmMb9UMCSY
         4SpB0UqcB0IfgVbjSVITUp0wFGTts9G5AKXItOtHQV/aG+/HgIGYWVGKLdEgBPE+JOs9
         qHkf0SswQVxyp6GB0W8+RX2/wEWzbpipq+VGkEwTBCr2vZCJUCfOYs/pflb0z1FvkjkK
         cYrW/3ymV6Y5xDBhOGiDXIFfN6xNqXquAxTXIIHZ2R4xtPgKP7zMegrJJpbgIhXOAs5X
         7CRg==
X-Forwarded-Encrypted: i=1; AJvYcCUhq0VDpKPhinNiO0QpBs3AKqYR7KbAh0Dbwy+Cx1WQE4kHO9xBROiS+ZIeWF4UySblSLkrRt/DzCZX7Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcu36DvXH/GTLtU4CHG87Or5ikWWC55qlrKisgalOqBLb093L
	4cnopnFRTsScufCG0ofXjaKRub+BgjDsUCUox3O0Wpj5PcIP9G6ibBaomIPTE3z9M/g=
X-Gm-Gg: ASbGncsJrXTEBo/ISWsmyS/2EwGmGqlkh5bTLIUUpjHgIulq2MovhgyGDfBOUmIKUi9
	dvU57lrSNur4Nc5C0aGqxqTBeO3XqHHrhAfDiDcj1gZOFd7raZqRBy8Ouhos+6U5VSque8ET3fF
	JAduLF1UpXZj6kt5VYWpjRaSnbk7jFEk4CwsJW0tWfxkuoHpXUZ6Y/9xJgu/oCrF46F47/lt+he
	pt3PAvWhCb1BO1Ds3s3C0nlcPd3CaGTE4l/CGIW1JliecucsV9JbVqoB7GgoWnDQmkWldX015ol
	WIkOz4YNN7khx4psJmbA3QkE3XYkIIb5+TZs9DNIE73Xl9dVpKqw6usa4ejxpzSp+qp2dx5eQNg
	NxQi/gnvlzEE56hSOAH3uz2xEZCMI04cIjdSqSSuJoKIJxdRPWjvRkWmKBURP+ZQCAUQMzm7wKb
	BDMZvLhSvD4HZ6ZpYk8eg=
X-Google-Smtp-Source: AGHT+IEv6c5FUwwLFSVhJG3Y1Sz4/h6bMTRmTq6A63QYOpaJO9qwKgFhy/icrtsmblyY/8eaAxy/eQ==
X-Received: by 2002:a05:600c:6812:b0:45d:98be:ee91 with SMTP id 5b1f17b1804b1-45f211d4f1emr107824775e9.9.1757933988224;
        Mon, 15 Sep 2025 03:59:48 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5a16sm175947125e9.12.2025.09.15.03.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:59:47 -0700 (PDT)
Message-ID: <1b322807-ce6c-413b-8f84-3a0df4eaabb4@linaro.org>
Date: Mon, 15 Sep 2025 11:59:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom:
 x1e80100-dell-inspiron-14-plus-7441: Enable IRIS
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
 <20250915-x1e-iris-dt-v2-7-1f928de08fd4@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915-x1e-iris-dt-v2-7-1f928de08fd4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 11:06, Stephan Gerhold wrote:
> Enable IRIS to allow using the hardware-accelerated video codecs. The
> firmware is not upstream in linux-firmware yet, so users need to copy it
> from Windows to qcom/x1e80100/dell/inspiron-14-plus-7441/qcvss8380.mbn
> (just like GPU/ADSP/CDSP firmware).
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
> index f728d298c72f4bf2ee151698e36108fdd7a8e5a5..cf2a7c2628881e44f093d73e6496462c22326d9a 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
> @@ -37,6 +37,11 @@ touchscreen@10 {
>   	};
>   };
>   
> +&iris {
> +	firmware-name = "qcom/x1e80100/dell/inspiron-14-plus-7441/qcvss8380.mbn";
> +	status = "okay";
> +};
> +
>   &remoteproc_adsp {
>   	firmware-name = "qcom/x1e80100/dell/inspiron-14-plus-7441/qcadsp8380.mbn",
>   			"qcom/x1e80100/dell/inspiron-14-plus-7441/adsp_dtbs.elf";
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

