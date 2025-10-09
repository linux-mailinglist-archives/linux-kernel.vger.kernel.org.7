Return-Path: <linux-kernel+bounces-846987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD7BC9983
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80D0D4FB7E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDDC2EB5B3;
	Thu,  9 Oct 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFl+dQt7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B82EA490
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021027; cv=none; b=K7dQaIcChQsizkAkIiETyH43c80U/BrgVkNM7KrEPFfGzrtoTk3k6mo17UuIaxJ61q0IE0EF5FkueWtRmj4z84cIMGvueE7OiQhEOSWp5Z2ibiVt8X4A3M0rVA7P7UjElHe40PYxVDSjrfUbKv0J1gGxzhqyRtIdf2gXDro1OV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021027; c=relaxed/simple;
	bh=YPRTmJAiC9PVnBhnzgVMwPCuYI3/xLbW6iu/nD0qQM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/B/zjs937GE0zsvNk+sDxLir+k7DXZtwD2zm5LE9YW9OFPprgI/R3JjqRTHVGKxNQz4d4D/Gb3Hmwd4FRbnVb24wDsixn7lXv7Y3RVa5tMsX2OkF3YBZVHy89WvCJMxpXZSMowQLHV/cTP8IBAQD04u1Rvu90d2LwppgEX5bCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFl+dQt7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EQBtp029887
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RAZH4VC4YYHQ6vhW18teDI4p
	FX/oOp/YSqgiS6ax0y4=; b=dFl+dQt7KQmjjst4Rj1u/l1+XUsbjL6mzSC7XGCy
	qH5Lt7HCf3kKnGoq/cpjA9m/7/ZxMFClL4iQ19w01YNYVjdc5Om1p9nWRa8wq3O1
	vZEmPOyKVze4NDs0L+Ej1KcsUdzW5Nj8T5yvdKXhE1fgCc2tbgtu6HA3PyUyyLfw
	nxHBUmGQmqwIy8wtKmzhXQDE/ot8IOLHZ+VR4n23Wot5ofcjBUwRg1yolNS+Kbsn
	Ntk+eUrTIlvTHNNpV8bD1fqpeSwkDKwnOWq0YTxVt1eLqbF2UZQ1XlRQiYfMbnml
	iBBYkSqgtW97vjU23EHKW9wEqNjccxy7w44pwbRVLi4SsQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nb86a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:43:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78f2b1bacfcso29503736d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021024; x=1760625824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAZH4VC4YYHQ6vhW18teDI4pFX/oOp/YSqgiS6ax0y4=;
        b=JDGZvXA9td591+wnpLBvuO8Y3SQv7/fwMaoxdks2j0J3Mj9QSpKaHQkt2/mpupU02q
         PI+nel7ZToUvBC5voP/FfTxDAbjpChc41sjhsntd8mdTqMyB5DBh06tt0Uh/sODoY8M/
         xgzd4ql589O8wHU8E0qgC7PLU2xsNEQehL8vXN+zP4f10aiREgr5oF8QksdWO8WdMKDl
         9Tz3JWDnydwCHACSunaZ2wHc+gmfoi6wViusEUiY6jlj7VMsVb5q8NRxCBQfs5mX1Rv1
         idATo3JB2BdwtbmM45qPdacTkMGnmkQ6f6j/pgd3n222S/HzcllLrci2J0so98+uSG2g
         Pq2g==
X-Forwarded-Encrypted: i=1; AJvYcCVnmR8nO/s+rLGbWDwYJBi6HS60soAMt/vbeNdpmtJDOrCCscZqF7lHCww+wx2EpUzIDH5OF3xcScaIics=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zLzHKCSXXRATCcAWnkwtAX6sgJdXsH0paaH2iN+HNmR9VFOy
	hLVtvwA7iQe22Z9+/xTYiwsKAMHs5cljMvxprlDUk+31rGQZZqxbYMd0wi5q6n7We5fS4fKL40r
	6+kGkZLYvFxtZegvbCgp2wiWNW1DHIjR6/J7cOCcuQF7sdgfkHBTQZEbXGi2nmS3cBoAj8X9x1b
	k=
X-Gm-Gg: ASbGncvWt6pU3njSVCCPKwHj6MwWEx9kygTH/f56yTrD6i8mXaKh4YMSJ6GRdp/fEca
	t4hcime99fy91FCl24rem0wuoIcAyYCx7Misa+RIL9COKJF9wfnEzFYtpQu8JW1+oF1UunUO/EY
	UcgyQqJiKHTJ0Q3JRsaJ7VOJx2YaZc0iHI2JOqSgK+N3Iay0bQyyfXjiD2MB4BNwnfyH38GsBv8
	7YVcQnPLJ1l2qHEgehk4I4TgwCIhn5d/W+HAyRuCVWP5rK1qr7OhjTBOu+w2piPiUI+xu+q6LaW
	eA2d1VXROYhX7YRR7VSxfLP0ingHgSmCg78kKSQJRtRMad3Pmswcmy40t8tYQADrlwcjlAYiK3N
	IWUqL/Dgnp7fvazQEeB3Z+R+W8VSRfm8vkTVEvCC4hsfDllUjN9gExKFMJA==
X-Received: by 2002:ac8:7f89:0:b0:4b5:fa2e:380f with SMTP id d75a77b69052e-4e6eacf39bamr101335481cf.27.1760021023738;
        Thu, 09 Oct 2025 07:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4VQzRJazCe5lQEKqHSB+Ox+znELuwpSDAoZB258VOx5j06Ir/+zHOtX7IKN48V2PCiISpAQ==
X-Received: by 2002:ac8:7f89:0:b0:4b5:fa2e:380f with SMTP id d75a77b69052e-4e6eacf39bamr101333161cf.27.1760021019850;
        Thu, 09 Oct 2025 07:43:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ac00be6sm1099313e87.23.2025.10.09.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:43:39 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:43:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: qcm6490-shift-otter: Enable
 venus node
Message-ID: <si5h3szt3msd7mcbrfdotbs7wxi4bh5cfgp3icoxuqprsz5tqr@tk42ox6okse4>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
 <20251009-otter-further-bringup-v2-6-5bb2f4a02cea@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-otter-further-bringup-v2-6-5bb2f4a02cea@fairphone.com>
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e7ca21 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=7Ovdx5uLAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8
 a=5-T4x24SdKi4UNUJpXUA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TQZWkJv5rNK5-PaLMsrg:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: 7n9A1Y23peQrpO5EKhySCmHHfqqTWTZb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4ZmOAUQ24DjA
 JwBhFtXH9PeUhuOxF4FW43koL2meua4ZLSp+zw6G2UkmsqOWq+z2gO1PaPndCwKApX+Xf146OKn
 pZu/m8Yi+386TWNSHOKW2ACfqALLHbcX0YLxcqx4NWIKysi7vV7uDeO6OZlVVuaHJ20CBXcOnD7
 bcpQih8HAB/f1gVgUitVeqybN57Nu+8sSS89jiki4jeKG9higZlXMW3t4WdwqjLNFdWRMy1KRuo
 5/1qmwExnjrmWOru4xSlyLSsXxtovkgewuHOi9i36YLM3n/v6Q4zAx1FlYDJhWwyrTSkhYb4xvl
 Mq/xCjET5G87YaEkqdj+YLH9yH+tw4eN1T18bOKDqWr7qoWtgNevf5GPdgOlI5eu3iuDNB9mwQk
 9j2Jf/NZ7q/m/MUkFBnqlqPJR2ChBw==
X-Proofpoint-GUID: 7n9A1Y23peQrpO5EKhySCmHHfqqTWTZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 11:06:36AM +0200, Luca Weiss wrote:
> From: Alexander Martinz <amartinz@shiftphones.com>
> 
> Enable the venus node so that the video encoder/decoder will start
> working.
> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> index af6f7b41201d..a3e6b6a96530 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
> @@ -981,6 +981,12 @@ &usb_dp_qmpphy_out {
>  	remote-endpoint = <&pmic_glink_ss_in>;
>  };
>  
> +&venus {
> +	firmware-name = "qcom/qcm6490/SHIFT/otter/venus.mbn";

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> +
> +	status = "okay";
> +};
> +
>  &wifi {
>  	qcom,calibration-variant = "SHIFTphone_8";
>  
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

