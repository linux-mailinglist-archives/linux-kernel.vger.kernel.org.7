Return-Path: <linux-kernel+bounces-800020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235DBB43285
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5422D7AB13D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B13B213E6A;
	Thu,  4 Sep 2025 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UUBraTIi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9627586E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967761; cv=none; b=E/zBS0LtCJSRisIm8WbkC9EW5la8nj8aB+8ge6NMUCSeNuQTvIjN8SiMXZojaaTqCoozxrnMrJPDUgCKEhwc+Rl9qIJ/Mp9nrjcbtvFScmZt80cM3PppSKTWHWFfbbtp4mSTSrl+2/YS5vujcpKcWV5IAlNGxTNTZpwo8S5QMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967761; c=relaxed/simple;
	bh=UJ0KZK1xnQRZT7iijdpjHkkIB/eIpt+SFyHW2s2cSnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhlJNJab+3w2FRun4/KXVzmYZHMNDXPLo7PNFLF13zmZd22OIsKpStnnRWvH9ucYr4mywriU9fqDswL5uUPgYTXzNqKdx0qj9UbYznjfACh/fe9W4nC5EqN/wi0hcU157lXV3TXwPHVAKRI+IGbZYP4mGhuzwDl6v/Q3/EsLgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UUBraTIi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840Xbi7029049
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 06:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kWQHe8aTqvkPbjKWyJC9RECFwkQ22fnfERhVPTlFZgY=; b=UUBraTIiFcKJ6O5N
	918tFPm4wsDxLklKZtmyxTos6whJ1M2uIltlFrYEOlQKn9p+tYRzNJ4Qy5LKIYUQ
	OOwaMHJIH2+ZEqTVRJtydZy8ifR/h+dRWXcIZ2bW8dshnckSC2gf6aAfvoRfpZnZ
	OLkVucATNaBNeSRfan/+aY8UUJSSWabrf6WOtHoxqAWYMSkzhobJ+E7lv+uXKih3
	Y6GGHc2l6bGbDwT7PhNO6ribX19Nq3teOnAhwWK/ilIdYiC0P8XeJqK9veAPeOcl
	eKfr6HcHe0DAGxARIgmhYFahTMTkiIGU8pDQtLoeHkQC2TizaCZNfHl4RM7TzKny
	9tjN5g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw06gdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:35:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-327b5e7f2f6so831789a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967758; x=1757572558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWQHe8aTqvkPbjKWyJC9RECFwkQ22fnfERhVPTlFZgY=;
        b=D9O74ipC3NKnW4tLh6yZ23xDhT+ZVkreehw6CtFW6sDP6gpTgF/0MOoB2EwjHzk31C
         hXPOmpKDSxPWhZqxw6mfSG4R0KKcjJucqQ0z9tvta2QATeyotnDZMUgQFHpSJv5DuGQV
         /horatMrpWHNK2u54O6Jfh6qcXWwfnvz0YUS8ABWTpd0YHRZvdKeA2eS8O1H6jOUYnxU
         3Oc3TWjVBjRbrPdq2oAVVUMPmL0apwoXG5UO0RFTQm7UHx9/sR4wBMP4/ce1SmluZ3fi
         siVCUSVWGvt7NLRYfWz1uRgvPaLWU3KebnrH8F4t0wk3WBgYomQq5TrsD3WNRVGaJRyL
         5DEg==
X-Forwarded-Encrypted: i=1; AJvYcCUkQPM+stAuoTyQk+VbBM3SMlmJJPBzErMrzLkF0pl30vKZpyoYEy8XiMIVH0u6SZdCYj/ELwzvvAa/dDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg05zFGE6kob01AJ00omV7TXkob8v3Sv59WvqkIAyq1xzvlHWp
	/sfnK+H/SUmDoUhSEJMasKLCI5qgZlnIFH34x3ngIhvSVSzXG0NCo1HIEyULSD0brQQZqbIZIJR
	ue2BmpO/CjwKvLBgvAg4+YRTrYIIYeTj0tlFqvMs/RAYUJoXSs11xE9zm6meUVf4mBRU=
X-Gm-Gg: ASbGncu4SE5OlY3l+Yi2JE2QUS8cusOE8Mtle246FI14cWZdgAQpbsraWQLknJmE7K4
	BHc6VHjLKH1SyCZzjqoY6kecjKO5ysSZbIHJOga62T35DdIi0esDWDtcPRFoyiCPLD7nY7jgeks
	KDIemajrLrMiT7VE2+nlVZLjCXV7Ky97JGTCTLP3/Ajwid/OXa7XhQLw8EWaq5jfecW7yK1rkSa
	7sNmZLIrC3EX/MZWHVDPt9MyGYHUHuWc2uIbMcYiU2xRz7CO8cfz5Pu85rnBf5xelWp5wlCLo7L
	Js8sx3FicI16PJDrJa7Nyao8+WXI1NhdgeeGQRT5VlyFnvpkE5RcSxNiJPU76k86Whnb1h43DQY
	dGTIUkJ0LzUA7uPgVFG573ge9SORxtw==
X-Received: by 2002:a17:90b:2245:b0:32b:90a5:ed2c with SMTP id 98e67ed59e1d1-32b90a5f1f2mr2536802a91.20.1756967757709;
        Wed, 03 Sep 2025 23:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0AZclcAiAIE/RLioDWTNitUCYKwiFoqEf+Fx+HDf/RA/CibTj/rrt4B/KuNcWo8T1gpG/rw==
X-Received: by 2002:a17:90b:2245:b0:32b:90a5:ed2c with SMTP id 98e67ed59e1d1-32b90a5f1f2mr2536773a91.20.1756967757183;
        Wed, 03 Sep 2025 23:35:57 -0700 (PDT)
Received: from [10.133.33.41] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fa1f21415sm4007673a12.18.2025.09.03.23.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 23:35:56 -0700 (PDT)
Message-ID: <25379ac1-4559-4803-b03c-bd24355d3b4a@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 14:35:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250901-qcs8300_mdss-v10-0-87cab7e48479@oss.qualcomm.com>
 <20250901-qcs8300_mdss-v10-2-87cab7e48479@oss.qualcomm.com>
 <j7whxaqfeyz6fqwg54h2mivobbvo3plvxxzor7whmwjkhavndw@ulqfidkwwn6j>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <j7whxaqfeyz6fqwg54h2mivobbvo3plvxxzor7whmwjkhavndw@ulqfidkwwn6j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2qMQ_1PwduRc0naaDraiuPML7IDpYI5v
X-Proofpoint-ORIG-GUID: 2qMQ_1PwduRc0naaDraiuPML7IDpYI5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXzX0iqRg2dheV
 BBMKw/hmW8bJS47bfliU2p1etuccFDM/b5uGH04+7ZfjuYfdjh+I7VPfXA65eCGVkFQwr30/HdP
 J67khDbHLDrVb78/e94D2bGVahzOfKlURvPcHaqva9dR09BWOn6BK6h6QoQVU9U4WOZZrhrpOME
 cdVpF2Z+6OxPJvGpyZw4zY5t/PHElJqIKfjJTfR+MUpDw/4+VHS25QejhE+Ub5QzThYjQixFWjA
 5RNZi4GUQcO7NzXHQbwMupa/AXgCY0SdqTjuZz6BUzLNf8UxEZiDgX3gvd3y51hQ87Te7/KaI86
 NN0Lpkj4gmguBoEmMFoZ2xozWoxsmpuY4yWcmdvlqyj3tBM7R1yeVvvucXhYqq5pGYKkCowRY+D
 oG5NrdKb
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b9334f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Ik-895_utKsnK2WA_CQA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027



On 9/4/2025 7:45 AM, Dmitry Baryshkov wrote:
> On Mon, Sep 01, 2025 at 05:57:30PM +0800, Yongxing Mou wrote:
>> Add compatible string for the DisplayPort controller found on the
>> Qualcomm QCS8300 SoC.
>>
>> The Qualcomm QCS8300 platform comes with one DisplayPort controller
>> that supports 4 MST streams.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   .../bindings/display/msm/dp-controller.yaml           | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
> 
> I've picked up the last version of the DP MST patchset. Could you please
> rebase this patchset on top of it, hopefully making it finally
> mergeable.
> 
> 
Sure. will update it.


