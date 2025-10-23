Return-Path: <linux-kernel+bounces-866483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150DEBFFE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F493ADB32
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C052F83D4;
	Thu, 23 Oct 2025 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwXrVfJn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A42FC866
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207765; cv=none; b=sMg+hLmk/7yRHKZxLMoZsn4hIxKN/KIhoI17U1rAVZcKvqJ0m/acTlSqmRnvF/nrWbEvgonwKC4GaNatoKn1Z6n6UuNVDOfyrdjUhKAmH6o4n/neVO4L42lYCTevthn24R5DoQRCvQS2LDgcei/sCSebfWp2ihRSFgImcwJfDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207765; c=relaxed/simple;
	bh=t24w4DPMahHtB47lcvbqPKJBhuDoe/WR/qA9AK/CzCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0ZNOhvzDXE9Le8fHgEkbNhBdHD0JQfVXsHm21N+EexPiO6YHGVQUY9/Uf3nl2/r8k0OaKT+rKQA3AMHcvrUFx0C7tWaFAiPfzDK+UQHeQ3Yonb4a+WfElGa27kN68WzQ0vaDUETfa/jXVWveF/iOLzTLiT1GLvdZS9jfPidavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwXrVfJn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7YXXj011794
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K4NgzGTqEzB8dTS+vj4Q5OscJECbKhME9FM05+rA3pQ=; b=JwXrVfJnC5SxNroT
	GVflMBI3RAKRv0NmMCdJaWepOjMtALVL9U44IHHQeuH5eWAIDka1Dgcynx5pHyzE
	WllOeefifpEOemyV6kf1p9JYfyD64jX003N7sphlbqzsgU7N/RSMmCnmSYWg4MQS
	OrgxmNPg6zrQOLn6MMSgEyrwtWEfqjaKwGLfGP+1i97SD1uYEtxeD4pypUk6xnn5
	vnZnvC4j70Q0fuQBYXT2ac3I5QywqtnfY36RLNneIv7myopRelXimm7uoV64tvSo
	IcoMVpQSWSqmtlJCOSMKtpmol3quSrgUTvX69Q8SODTVWTwryzRwmdVpKj+ZhePx
	n6JP3g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5249sqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:22:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8934ae68aso2511911cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207761; x=1761812561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4NgzGTqEzB8dTS+vj4Q5OscJECbKhME9FM05+rA3pQ=;
        b=IsiDtlLvn66SEIu2qmCrud2Km10tAHi611J488B0viQ/BDm5PHsX2w6qGvePXtr7cX
         v3icDVRdRsI38aZ8L+J2aCmq0ysOr6Ljr/GNB+rY0oU0E9HNCbPmOYN4U0VdJzZNKs2D
         hCIGpct2359E9mmDT0mO6qoj1g8MzhE1IM3yBGf9lpoT71gGsh7GTpywm+48xPCplrUe
         YveaxCVz/vsA3viG7o4LszBa1x/+A4e6tityXFa1QLcR52kNgAG+E5b6PpUpa4Bbbq0g
         3QSMn0Z77JNelQDxn3e2MqkMYPiS/ZIigy+bpxHv/ltIA5bbN8H1T0LDxjw+TzoZvpfq
         ccaA==
X-Forwarded-Encrypted: i=1; AJvYcCXyG8neF1VPaPaqxM6KH4jYX4unYWqvb8VHSNdJau3gbD1Jx8DGleJnm+hJbutQisVusLrErlfvtIoX3Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BWSNrDi68nQk4CXw3N+c+jve9qvtxP6y4+w7DssFu6q4l0ur
	r2pSH6fv0tjpnJbtxWU4Ki4BBD9NsJqlWy0+mySSE8UsxYi/J5GbTdkJLvTxOQDT8r7xSokCFTX
	DovoXCx02bOlkf1n37LEFOti6c0UANQyVIqYlqrCRshX+F8IVIOQXUmAZqqzEnySia5E=
X-Gm-Gg: ASbGnctqmtAdTySc7v5Ky90gjgcTw3TJKSATpHZpM1vVxwFzRhGd7efOOzCQkWYbsy6
	X36DnwGRfKqCoJg23tdXLv2UqOfrTa8jfIgI5zF/jNaix9aW+IFRO8YlTLyrndK14yQgT3/qR4t
	7YJQ9DIq96AOTkSf74RX6gemgixBGpg0Myxtxhs04toou/SbzVDEPfoZLnbMbMxGONOhNnZOuSw
	7M/fyaj8FVzwFBYPUFIgggnGnIPhLPwwNLICI8NqhCjsdm+UJ4uXKh9DkhaMl4fvAvlUN32fbvG
	iRmN7URqZgjqlV/bU6c2ZOmgdEWnAvSfjO7tmeqlaBAmp4IGF6T+i1lYvsSIbxOwe29YRXvoIpG
	b/FCoDzrdskEycFxYrtXFZYIHggX57kbEN/A/P7xxqdn8QgjHBahvQVOu
X-Received: by 2002:ac8:5e51:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4e89d1f94eamr202274311cf.2.1761207761112;
        Thu, 23 Oct 2025 01:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEoh9odwgEcJ5K/DIdlUh+JcVJr4l9Z1HO2TW/KV5jjqHxmPJPsVObSKYBvA63wzdqXFK5BA==
X-Received: by 2002:ac8:5e51:0:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4e89d1f94eamr202274191cf.2.1761207760689;
        Thu, 23 Oct 2025 01:22:40 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f3348cfsm1093740a12.35.2025.10.23.01.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:22:40 -0700 (PDT)
Message-ID: <207f25e9-3685-4838-a384-e6bfe6f8c244@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:22:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] arm64: defconfig: Enable NT37801 DSI panel driver
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>, robin.clark@oss.qualcomm.com,
        lumag@kernel.org, abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-3-yuanjie.yang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251023080609.1212-3-yuanjie.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX7p/oX0BB8VYZ
 nme5Y6bi88kPmlEhGG9hIleQxiquxBSOSn9IVF3V391I6iK2OK9XuJUQLwncwt/3QYsiaEXfEqB
 eeoHxQU80cE39e/BCbRaa3SANlM7dv/DyU0MW2XX1ceU+VSjpnsxQ28/ciQ0+0KrtZOnyaqO06U
 QEOxvjaF7+ougr8wiiaf586WvUj/zJrEXE5Fks2WEOdekXDvcFTCBQgnRFcB2q4MvAm0nXmZJKa
 2XPFUqU0BFRTD5TAHXmgqIcjuuadfNBDv0q6RjUoNyrzlfpG0j1pmYL7D35NsaFVehl7ks/gRC9
 yutqdGYJaGk6hjR0vHYEGJ/ZsUTDm4E9lx7O6yninF/o7qbzhE3kSpCBLaQyXn6xDYgO+E6kmlt
 lvgWrHYb2wN6B0BB8TW3g3FX7oHtNQ==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68f9e5d2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=91DCyrf_GaaWAzlYtecA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 9W5hlK1XldfdzFPhsNloqbx-0rf9ZvwM
X-Proofpoint-ORIG-GUID: 9W5hlK1XldfdzFPhsNloqbx-0rf9ZvwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On 10/23/25 10:06 AM, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> Build the NT37801 DSI panel driver as module.

Yes, we can see that's what happens in the diff below.

You failed to state the "why"

Konrad

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8cfb5000fa8e..537a065db11c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -945,6 +945,7 @@ CONFIG_DRM_PANEL_SITRONIX_ST7703=m
>  CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
>  CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
>  CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
> +CONFIG_DRM_PANEL_NOVATEK_NT37801=m
>  CONFIG_DRM_DISPLAY_CONNECTOR=m
>  CONFIG_DRM_FSL_LDB=m
>  CONFIG_DRM_ITE_IT6263=m

