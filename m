Return-Path: <linux-kernel+bounces-878056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9031FC1FAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1585434E170
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA3C354716;
	Thu, 30 Oct 2025 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ptxXamHH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c5ukTVkL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04103546E7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821849; cv=none; b=WvmHEbi10vQCgd4ga7Z+2kiNsTiIwhcQXT5+Tyf9CcMefunUnb0Z7unfEJEdiXB0KzxcXISTWljTbcp3W9074yUtg9xhinEQnjFRuEu3D6u5EuALLwntQEoyI8/nXan1+DR0p78jjwYqSpEdqYd7bPq9QUUZo4kH5ApELu2mw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821849; c=relaxed/simple;
	bh=CpO4cFWeZy8MJxTpQgzEci5n2dWvROiycCuVUOoSAE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToYK1TJO7bjt8xMwwhxQE5DPudnWpAcBxEMR2C3dsxSkKVTvyxir+A0MAis+LOU3l86wPWTqeJ8eMutBcgiSJbqTzt/CFjvUVKQ/qYOimj469s53FL52rEK3G8yA4wAno0HMao0/4KxQVZwQOFh5eDbptlTr/jWyypwlkAfz0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ptxXamHH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c5ukTVkL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9MY983115587
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wI3InEQIECMqkQy7O5TfdepIrBxYkVLDZFE9coGVYfg=; b=ptxXamHHU/1VFGsH
	rLlLxHZVOoWuQ0ks8izQvLWqRlEVkPum8GU4x81voDPLbxgGeeu9AcIX4OJ4MFwi
	6d4cPmHlWMoBce2NVqQwdUPPNeAWxcrIH1zEicO4WuarG/Xbp8kW25nqRuZ3SdS7
	EJ/nqJodV21MyWvrSnhvXtvTtz0E/Hguhi0OQawtbGBhMMDWGk5xf7xyYv6jf05r
	H0H3EX0TfdxhSgBlKOlhiWimyU8N+l4DhNsldulhM3P03DGAueEcb35DlvMAgUyy
	jTCqdRw78AX8Z2attXs+78mJ0pdlSiDEJdYvC+BPx56pX/THeK2rmBD9hcRYbhFG
	XEBidg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b409dn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:57:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a22b021830so27492085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761821846; x=1762426646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wI3InEQIECMqkQy7O5TfdepIrBxYkVLDZFE9coGVYfg=;
        b=c5ukTVkLmQkaVvIRUhDhY1vvgK0EQDDIwe2Do95k5eNQOje6/ScXcJZCqOgsPArJon
         Z6n1Q+Eqg6gRxZA8Y6BKDwsXaFWAQwueJshSKzbXsIa5xnhpDcs94AkTqPNY7F2e2+7h
         3rfeC82eA2lADtQE+28P2BmYs2aPMcRLWG0/FOqLLCIWlaI2h4kXbUXJI+30NTPNW+h9
         L6OqNH2aFVt7vhk2zip2FWkD8x7JaggBsvwGXBxUn61eRBuRadujR1cyrAMjYODUd60S
         dTTMA0wkLjnjvA3SxDKAkoK7sXjTnXd8gkRgRUhhwZX2oqIqjGbYIRI7YZ4SaIDPsW5a
         yrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821846; x=1762426646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wI3InEQIECMqkQy7O5TfdepIrBxYkVLDZFE9coGVYfg=;
        b=dM1w4qD1c8ccMBUL3VZyStcTc7THInmcMV0TjowdkGDbgnkM/k2aH0mZleJF/tn5ET
         rQotoYX49VXIgC4fuNa0i8/zbe2LYv3NLQMdddQ5Q2ZhYBNVh+d1dqawGQuSo8tGpJ30
         0WLNqLwlhyAjStJc+kLVrSRldxjBm6+sA1nvjP49dpnjrRxJQ55z8q+2xpS+IcjbGxd8
         axE29P2sqT0EgKr/W6XPDsMdzNwBK/AtXlnmDy5PNNbHdfrQDDwM8dTE94QeTdwVHSgu
         aJn6A3+t05geDp5RLMj9uTJA09iiR0undSunMAZs/FDAR1qPjRtQwTEWnWpAjWklZvIz
         fy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmaeLxtRNsNspHbQ0CrhG2QKumv7zrttAb8E5VXA3jloQSU8quTj1s33vk0E0/mT+xnmURYd3LyLdBwbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuGtOHT3jJWhDGxWJBDrEMtJc0yBKe8kl7PozEAw0t18KUCVSt
	r01li4sX2W3jplFmk/D41kf8WrVeesiOhBnx3zzA08QKqvQyxzmfpZAbs7s+S7MaclfdkiRvJpH
	e/Yh09FfKBgUD+wQGePzzRm5Bpn9Gpj6TrKakWFz2JdQw8PV/McCeYbRpTJLVf56me0k=
X-Gm-Gg: ASbGncuUPxsL4E1J/coJYi1cGM6T9BxG4CK2zXxPT53JsJjJ9f59u/Pfq3vJP5X22g5
	9r3Fs3bMerDtc8aQBGwupCeFlOSOhRuE81wIkkvZtD1xI2h0nnqXjLAx2LoKu6Eh7GcSZrE2YnZ
	8aXHxfE+lUXEwhoo/NCZQgHurskfpuge63FYP9uieICWZmGRd+Yach5+xb1/vDXquPOXUf3+Va/
	TJ20SIBc2pKwSCwkgQwB5rz9n3OG0ANSnAjD0xleff4jfxmAS/9vHQ6KYi/RXiEbYIePmbj2i1h
	xWs0t9r//WRV/nCktuY0mSCDzYEgVygTMekGPeoQejrQNCGRsBPJuFKuLUJrTCVyRrGp+/tSUrK
	Rz+YdPlIRjOCzRmeovgXMHOX/y4eGZFFpBM6VOqsDxh5uhUCaVvxyUtTq
X-Received: by 2002:ac8:5790:0:b0:4ec:ed46:9268 with SMTP id d75a77b69052e-4ed1e188a7dmr39841781cf.13.1761821845719;
        Thu, 30 Oct 2025 03:57:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl6BONJiKyE7lXcYLZDY1WqwI8TXc3wEg7QiVTOYxQ9Xnr7NkX2YFXbcmSDRDE5nWX4mRkfw==
X-Received: by 2002:ac8:5790:0:b0:4ec:ed46:9268 with SMTP id d75a77b69052e-4ed1e188a7dmr39841541cf.13.1761821845253;
        Thu, 30 Oct 2025 03:57:25 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm1692295066b.55.2025.10.30.03.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:57:24 -0700 (PDT)
Message-ID: <a64bf9e8-5cc5-489c-b747-fcdc36a0b2fa@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:57:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sdm845: create common zap-shader
 node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <20251028-dt-zap-shader-v1-2-7eccb823b986@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028-dt-zap-shader-v1-2-7eccb823b986@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4OSBTYWx0ZWRfXzw103HLLU7wc
 R7pPWh9kth9T5yxbkFy9OSRD93OjkGwIw2ZpuJQkLtBSWZ3rRxjiX3Je+CCO2mcN7OpyuYURNba
 he5SenmRyLqVljbItWib0lx3zYVq/QdMxa2FMJqjcISLlFwWwF9BHVrBmyB6UgAzBr4ndzg9pBZ
 y0w6Gqk1773CyniDUGvdsW2XHJzCD2QOuOgRGrgp+ZulyrRofiSgKq9Kphoc1ASTink+y5aC/rM
 1fkHyyd41lWb1OLphkWlBQ+6OphlFl+kQyrofjXNSHtmNY93fCMjEQ7J/BZNNtkZ1cSxWMMctXT
 9+X/kN0Bw+uknrOWbYCPrL0uxgSmvToWKBESng8VsfHSu86Xq+JZayEjDdEKZKHFy3BIkuCgk+l
 bac5ZWBgMFrY7e/POIgxHE9+9cEmhQ==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=69034496 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3S55o6r4CRsqHmcx2iYA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ir2IcaX7UqpTzHn15Zln6_y-UoGrGCPa
X-Proofpoint-GUID: ir2IcaX7UqpTzHn15Zln6_y-UoGrGCPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300089

On 10/28/25 10:00 PM, Dmitry Baryshkov wrote:
> In order to reduce duplication, move common GPU memory configuration
> from individual board files to sdm845.dtsi.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

