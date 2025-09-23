Return-Path: <linux-kernel+bounces-829687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBCB97A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463AC321174
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11E30E847;
	Tue, 23 Sep 2025 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iBMX5KkT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81E2F657A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664283; cv=none; b=C4OL0ePfFcDB58kx8faQBMyU1KENQhAW46/VvlvAjoyS5snvARn2iaQwFtFzfF/luThfL6xsqVckA8eRu3nhX6KzGg+0jlenhoum3FTCXnziacwv+t26Ri5ZddlJ8nGmx4CbFUBDWLdNS+SGvoX/dn0qUljRlorw4f95hYTW85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664283; c=relaxed/simple;
	bh=Phi3PYB3KOmm3zJUanSEv1JY6ERzYhkvkqz9KTEqZ1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYTe/BOgaBP4CvE3Qf2WUhhadelGGFyNk1wDsZiG8AWav1XPkPhJXrtPWTt4JTAE4JTvGml2mOfxt0ym8Xs43gszi8VSGbftZ8wQMIO/6NQTXA9WPxeMsWEWfn/vC7V31SJcHgcoqXo5F5mzSlfIQBmkMq0hqCfZbqoVdzwnHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iBMX5KkT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NFV5tt007944
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aiAQHIOrW59pXHLJaujV2OHhsUSTiYkKFOKLz/FR/mI=; b=iBMX5KkTaqhWAkUg
	BRxtHF1eehWCLziLrqUynIjhqx6oYcX+abOt75b4L/d6rVjzpOHm9AeA5SvMKuyB
	PYRbcQvR3Lxuy9O54ATDejhjK7CMOh4hv7/SnP6VU8RF5Tg+2OfHhoKGOqZyyYt+
	yFackzvt5dgAIt2CB8tS6HrXmyNr/jyS+9fbXVl8CMQ+1PmtCcWmujNkibu6v+fH
	/FIAc/2hxyu0r7EhpRirzxzUSLfjLTyCkLvyyOCCKDSFUTQOxSgWR1mXYjyR6SGe
	wT5jMYkmxu01p91Cscci0WUT4hEBJHYnr8sa+vbBVyBIQyI+Z1WoxuFAdHhlAhQA
	8+kl0Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98j5c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:51:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f2d29dc2aso2133309b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758664279; x=1759269079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiAQHIOrW59pXHLJaujV2OHhsUSTiYkKFOKLz/FR/mI=;
        b=MQR9a+Ysyvrobs/lUxR1j3tpYAC/BrRN28F/JdxN66z7mIzs4sKSzLd1uGo0Z/MoHL
         Bw96WWMJlfPnkB/GeiLKW6tsvnaR9iQOZWpOtWgSDnjXQKWWbMHUifMLf6NLJPMBD6aB
         hOTtZ27OMaheJ4PCqQNkWRBEA9D3WauuWlhh+cC+6YzCykdjWHiukvXk+1cHNEewmn+4
         DOalWcFGFazaGAunkciD69PDg6mqNldRTLARJBEovro2nSPv0KJj5SbnnKpa/eBLtA/L
         d/5HxRRA+KQxdiFGrAhNkaUHDXkPXhFZBpXbmv5rH5VrukARm42vSLndMQ0NGmyNyTrn
         VYDw==
X-Forwarded-Encrypted: i=1; AJvYcCU0yy8looZ25mruha+mLjOEFcgmau7eGGSpFrqzjIpv9a44vWxwFhBn/rhaQ/duVt+ULPb44Ur+5F+usAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmMhSfyRQUsT4RZE9TGGk25V6iPmft8fPARmE8ZaLJtX3+OMM
	+jLEqTvHjmbPnUe3A0DWYW+FCnLqCtMQqDbOUTFP8iomLyp4OLCQiwAuLKjbxSa6fzXPU35Rerx
	+NEAUkQEyO9ibe5ozYFCCvo7KsOvfG3GWvVnVODWo/SAPI8Frhtcko5PMZ29CmQSF2/4=
X-Gm-Gg: ASbGncvvPgd1yOfdayJUvVPKNNz6Xft6KOiqj7yUWuxCSSFZON1mJpBhuMMqW4iuIe3
	+JOwW0CM1eE/+6Hq6mPHzKnI0uWiBY+tSS6zwzBcICVTjYL/2kmoH4F4OzpBhgfaUJLff7SdGL0
	XWp5bVAp9uuNfM6QR/OrQxojEn/chSwRqpk+LsCm1VRl18dzod8qS1sZfMIw1R1/3/Cs1wxbRUd
	aWVmwYZt/zB/xfcqAhSni3FUuMWsX5y+CE8kQuc7NJpt96YSAUep8HkWJ6sm/zc43rR0kqsyuqA
	nFfJ5jhFjvP5jA4YOZf4ECWysjbH5xqq2e48Rt88cJaahB+Hls240g2JaDfqA35dyt5VmMg21XQ
	yMrPglQ==
X-Received: by 2002:a05:6a20:258b:b0:249:d3d:a50b with SMTP id adf61e73a8af0-2cff4209b23mr5529431637.59.1758664279136;
        Tue, 23 Sep 2025 14:51:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq5Th0MTaZw84UMrVLMwE0MdUEOMsSuPcioOUVzMEkQngd4fbtEd7mUZH6sG5VPITkCIAgJw==
X-Received: by 2002:a05:6a20:258b:b0:249:d3d:a50b with SMTP id adf61e73a8af0-2cff4209b23mr5529405637.59.1758664278734;
        Tue, 23 Sep 2025 14:51:18 -0700 (PDT)
Received: from [10.73.52.96] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55396db81fsm9565146a12.19.2025.09.23.14.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 14:51:18 -0700 (PDT)
Message-ID: <1b51550f-90db-2ead-0ec5-93ce786ffdff@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 14:51:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/9] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI
 PHY compatible
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, krzk+dt@kernel.org,
        conor+dt@kernel.org, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-3-wesley.cheng@oss.qualcomm.com>
 <7gvp6pshp4eiugk3qodg2ub3azu365loturidbkxqly6nhtgq7@bxnkxeqzarkv>
 <4116b593-d36d-df10-6101-4e3539b8b812@oss.qualcomm.com>
 <aNJL1YEXx6IabTos@hovoldconsulting.com>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <aNJL1YEXx6IabTos@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DOYBEBD9sPArY8EudjZ0LU-y-DMN-baY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX60EN6S4Q0+8W
 8Bg+Wbi1oLl8g+xOVvEFRcfLUO9Dk9hP0Uz0xLP+dLiVzkqzVPY9jUHHnnPF9rOKbSZyw9sAwv6
 z5LLxBlJEIyMsdlVZdz0azN4JR8+zP4sY/j5vHi6+FRFyJ6wVzksuqbS7gtgjxev6WaQTB+kok3
 ZQ1mDQ6e08jMYuF7IATpByhqhXP57zQ18m2jGbnrHUM2zXjppoNy7LGxzbZCYKWZ3Fti+zjLosf
 vgiDs+ZBmbcQ6TlASl8GX9qfkinLgTD34oAWeOTiZsnnmjRHOhw5ej/sVBzEUPdM5iGHSoUOojO
 ZfAQFarB4psY0ZNqMenn5U/EJFS0lpymbbFZ2vEJUXLWeeXoqzFfNm+a9yTr2+5+hl5Bk00yRg1
 bH8uAtTr
X-Proofpoint-ORIG-GUID: DOYBEBD9sPArY8EudjZ0LU-y-DMN-baY
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d31658 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8
 a=A-OFauQzm6gaq6ZTC9UA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=xwnAI6pc5liRhupp6brZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_06,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018



On 9/23/2025 12:27 AM, Johan Hovold wrote:
> On Mon, Sep 22, 2025 at 06:00:04PM -0700, Wesley Cheng wrote:
>>
>>
>> On 9/20/2025 8:22 AM, Dmitry Baryshkov wrote:
>>> On Fri, Sep 19, 2025 at 08:21:01PM -0700, Wesley Cheng wrote:
>>>> The Glymur USB subsystem contains a multiport controller, which utilizes
>>
>>> two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC.
>>>> @@ -16,6 +16,7 @@ description:
>>>>    properties:
>>>>      compatible:
>>>>        enum:
>>>> +      - qcom,glymur-qmp-usb3-uni-phy
> 
> Odd indentation?
> 
>>>>          - qcom,ipq5424-qmp-usb3-phy
>>>>          - qcom,ipq6018-qmp-usb3-phy
>>>>          - qcom,ipq8074-qmp-usb3-phy
>>>> @@ -62,6 +63,8 @@ properties:
>>>>    
>>>>      vdda-pll-supply: true
>>>>    
>>>> +  refgen-supply: true
>>>
>>> You've added it, but it's not referenced as required. Why is it so?
> 
>> The refgen clock isn't always required on each and every platform unlike
>> the .9v and 1.2v rail/supply, which directly power the QMP PHY.  It only
>> really depends on how the refclk/CXO network is built for that
>> particular chipset.  The refgen ensures that we're properly voting for
>> the supply that is powering our CXO buffer.
> 
> I thought we discussed this before and concluded that this is not an
> accurate description of the hardware (even if you now call this supply
> refgen instead of qref):
Hi Johan,

refgen and qrefs are different things.  I will try to clarify as much as 
I can from the discussion you linked below.  (based on my understanding 
of the reference clock network)  The refgen is the main supply that 
controls the reference clock (CXO) into a specific branch.  Within each 
of these branches there are clock repeaters that are supplied by QREFs, 
and is basically the supply to the clkref switch controlled by the TCSR 
registers.

The way some of the tech blocks are connected, the QREFs/refgen may 
share the same regulator as some of the PHY's core supply.  Some may not 
even have QREFs at all.  One example is the QMP PHY that is associated 
to the primary controller on Glymur.  It has a refgen regulator, but no 
QREFs, hence we only need to vote the refgen accordingly.

I don't know if that helps you understand it a bit more to convince you 
of the new regulator addition.  If anything we may need to add an 
explicit QREF supply also :).

Thanks
Wesley Cheng
> 
> 	https://lore.kernel.org/lkml/aEBfV2M-ZqDF7aRz@hovoldconsulting.com/
> 
> Given your description above this still looks wrong (at least after a
> quick look).
> 
> Johan

