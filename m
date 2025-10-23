Return-Path: <linux-kernel+bounces-866896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0723C00F50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B53B1888FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2931030F950;
	Thu, 23 Oct 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkYZzssF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583730F941
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220975; cv=none; b=rWPdYKlS2kfaTzqhzFT08xdGMGb+SOZdKmdlt6xdpgGjPCpC4XquxB4Qbw4mnYma7miLBIqlnFO04Tv2Rc+yVZlzWIp5o23JTWLaqllbrY4hccSp8abpJIfj++d5jvetpHej9w2EJHipLYUi2GNdlw2CcYIAh4uc2TpTmawiSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220975; c=relaxed/simple;
	bh=hfHWyxVNGaqao+R4E2QG9ynbPUKwYD7iwQ9NJmtkuN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTBagTPTUOrJTsa79P0/N18SoBUJq/iJEvmNN6DopqUdDYr27oQkFn+WMAhO2UWCspUS3Wh5z1GbeFAyBvqbndUMdVE5ozbrUmQa/Pc0+CMK8jAsdSjvDpwGe5V5eQ6eFQEJzUECZnb7HzPj+879n5bfvbeywJobTGV5PT5n5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkYZzssF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6eRMw024594
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y0aZaieSuQfEQiaRXPzHRxz1LHJpL/jxRnElnXAHQ00=; b=hkYZzssFwV2Jk/VP
	Or1UkHDtl+OCssWsyMXSrss8YPIrs8IQNa/xSLaFxmZpL459R13jJTjsil/n4/gz
	qmDEFbNOVKHDFL0zZiduSekArgVsJVv7ingw2y1cM4EMdu8+8ziPdoNH6xKN6zP/
	1qKNWfZEcFQNtNKA1KDOaFxMbg5P9ke3YTC+tlWVVMyDQd7531vcA8Enxm2ElCwY
	8d/hsXzGHGtNMGvBtdGpzHqZjDUCj8TtGVvwUN8pFhcES70OEu6f+hgxgKWXb38Y
	0HK8lhn06ZCpJ7t1tqdsKB/6B4Cdosd6YQU55wSm3w/xWBjfeEBQ7O4n3LANeX2V
	+6F81g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w889v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:02:52 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5569bacec27so4265e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220972; x=1761825772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0aZaieSuQfEQiaRXPzHRxz1LHJpL/jxRnElnXAHQ00=;
        b=AXS3NMIMDQsZF86N1jTy+yQhVwq8QhXA2ooWQcF+4pw+h9T5swOIqRXD17AbqBv2+G
         vZi1DZv2lavo/78zjhe4BNCaOGNN+7vKQoCpQGyIl7xg1nbrbjaSdzPKW0nA2euxh5+t
         WG7DYJYpSNIJI4EoZCJTR+Yvt86aOeB5hufCqPnt9V/yeSluHqEzyfpkx0qxj0q1QIn4
         91RxCn/kokJGGiG0+9o4QinkVICtghjj7yvtAkeg2joy/AInMGYZklPwxeIiuLa+Ixnw
         JOzsqkEd5vCevpxWA+2kW3XMiqo3SeWlQ2vnfRgXWexgJiu0kuK2UFGpC3ZTAzjT6M5Q
         Cwgg==
X-Forwarded-Encrypted: i=1; AJvYcCUgjRe3u5DNTh2gM+pmkSpDzIQ7ruPEtZ/IpO1CYrO/B/v4AVUbI1Z/cLJB3qDQU15yBr0Cctw40TTIaR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCGmnSYA9qiLA56ElQEb2Ip+w0LtmXKTzOsHzpvtTx5MAjr1P
	R3WY1z9G4asQGapk5Inail+0BlhDNuhaUteS8jkUw0026MjAzyZWN6kZMjJDvHoimSGsdiBZ465
	Yx7QgkJDXyYWsCfFmjZ6wrgsziznXgdXv0fCJZyq9KFXgZ0mvQ/J2WJDHdP83Foq8hkM=
X-Gm-Gg: ASbGncsMw/W3gT6dWnD6Eal07j8xXR3ChSJYYyD/Exepe2PH9k0Ag6UTTHT5D3O+C2L
	nXPBQ6jFyzs3jleqx3215JsaQJ6eNjm0CEEXe9Eo1l7VCwVkyj/zwZexXOkZSLnGnNwAM7doHhf
	FGlPiQOC6vggeSNY67+Hrbw3BWIyoEbn/v6M80XwHxySyCgIpdeYj5fLWidcTOHaFnmAv0xdjv9
	AjEgYcLHeVH4WlwsQsA2JmbgG8R5mOM2Le47YeQHzIgN47ku46ze299iq82111vnGq7nKD9PwDb
	6Amjiymwg3xCZKPsy3S5bF40UDPcS/cwKLDb9306diWCdMrnBLx9loFRQsGeHOuYviYNnprfNDW
	qLrJM83jKHNfU976aXxEZpYe/X900xnoC0VQorUOHgj+yBFRDDYVdHEPQ
X-Received: by 2002:a05:6122:82a3:b0:556:8d9b:70c3 with SMTP id 71dfb90a1353d-5568d9b7b78mr1297680e0c.0.1761220971144;
        Thu, 23 Oct 2025 05:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI7NlxxiPR1mSCsIzjh6laRe8aVKmqjEwN4VIQypjOlNUn1ZJqRFIU7gS95HufUjGblo+7VQ==
X-Received: by 2002:a05:6122:82a3:b0:556:8d9b:70c3 with SMTP id 71dfb90a1353d-5568d9b7b78mr1297635e0c.0.1761220970676;
        Thu, 23 Oct 2025 05:02:50 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f322e30sm1526903a12.27.2025.10.23.05.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 05:02:49 -0700 (PDT)
Message-ID: <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 14:02:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
 <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX7qygrdw4yH2r
 Po4i4v7J5m718e4sCheZWcVKY8iIOVifqDz5nCk+xuMZ387IoUP6uv4dGIePFA4olUYPPsTK442
 QBzX0iBdnenk8j5RMc62ERCOxVBk1vJgRpMTrSf0tOVIaIGjhQWEMb9Vp4KirzUabTyDoiQF0Qi
 8j2W8YEM27T9ssJSjxeb6OU6owq2d3e98S4POi9BYMV1vZItXilaYRF7OqX0vJHNwKXbxfnsE27
 i4HxczHVqzOKz7FX6DfQbvuNuNaZSuWIkKXVX5VBnyl6ASnH83hBr9woDQpvuH2e95Cqpsr1nHH
 AM1X2nbGgVKX/30QQaxkL7ioHSyacaJRPUMwtmbuEndGhNMhUxMO6/cPCVa05XXKysCDQod2qEY
 68Ax6mxLNlGZ8Y6q3oJOFfhW1GuYkQ==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fa196c cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=dMqN5BQ3aGG_qev9F4sA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: vM64dQPEtdD7LlY2jfyi48MiVGApBFTP
X-Proofpoint-ORIG-GUID: vM64dQPEtdD7LlY2jfyi48MiVGApBFTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 10/23/25 1:48 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 23, 2025 at 03:53:50PM +0800, yuanjie yang wrote:
>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>
>> Add DSI PHY support for the Kaanapali platform.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>> ---

[...]

>> +	.io_start = { 0x9ac1000, 0xae97000 },
> 
> These two addresses are very strange. Would you care to explain? Other
> than that there is no difference from SM8750 entry.

They're correct.
Although they correspond to DSI_0 and DSI_2..

Yuanjie, none of the DSI patches mention that v2.10.0 is packed with
new features. Please provide some more context and how that impacts
the hw description.

Konrad

