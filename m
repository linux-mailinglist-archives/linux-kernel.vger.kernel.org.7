Return-Path: <linux-kernel+bounces-896846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F659C5160F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38F994F8F13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8CF2FDC27;
	Wed, 12 Nov 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j3xbodKG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BGeXR9b6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6162D7DC2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939755; cv=none; b=YcI8GQkYCiQd252a07OT/dJh7mzkQMCDywyAMzhxmTnRkoE95Dw2fByNtXGFWhDL6pYEFUoZJ36PYeBr45nP6JuvVJda9HoUaBxkb+78ZnshI3Tam1Snt8H58qm4djkNXJpfgRmFClRZO7hM89FPgy2VDPGHutDA0bJcsRv/oes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939755; c=relaxed/simple;
	bh=Pm0KcGLdkUyYMLvnx9ZOl4Og/wEoF0xNClvZWZLEXWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWJi+LumV40G6ivWiBNVnRCzoyz6uu6WrhDwv9CAesZ6TbC4eWw00qtj+QkzO5sX3NCpUzwo6/TlhY201eR8Y4Gsm1c6jxHMubgW37mHfszi2f4RXQG6i5+NrsyEd18bMNsFShJKONqKs8Q9pFoa9zFwcO7RyTlSUKsrmxLEbNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j3xbodKG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BGeXR9b6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC7baCr3503482
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Th69YKPq2o8N+ogj+emLojAGgDHwBfgYI/xXUfF0z4k=; b=j3xbodKGGdYS/RVC
	JvpIgMvofdY2F5xxtIvNLjjbc2+3PkZ9ZPtun3h3jWl0SGhM8jFfXGNPkltsrZLB
	lp/by6zszbPcDeXGXo9QCIW4e6wVuoUXovJTHTcf4BLY4y97twD3v9EEca71laly
	tIS6rxoBDXzjYjT4F5U4idZ3iNZ79+Q4PiAWDWxAZGAAfcyz/u6OJ8s0DT5p7KXd
	VR30pGRsl2O5rbyOKexAS/XHOSkzKDu23fTXzW65WSZYyXuchFh88C+X74r1imN3
	sk2hG4AE9hrvko6lKb2zXpO7bzEqu0ZRI72A0B4gwPYKwP9hj8nyig+QJee7jQ0V
	lxZqyw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acdcc1rtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:29:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ede0bd2154so605981cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762939752; x=1763544552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th69YKPq2o8N+ogj+emLojAGgDHwBfgYI/xXUfF0z4k=;
        b=BGeXR9b64Gez2nQdMZA7mj5cy+bDR4rgjRcVSMmcc9woJ9gzjsFGwc8XbXtWKvWphV
         2VizsfeJby/573uAcF756o616Kd6elwigngP7rKOTBT4kwtZ2Q6lYEoGPhrVZ5xSiGsm
         7NgUxilSdafs1L22WW90BbsY2iK0QjbpZIgqofLtWigTWbYBZjpWdfjv4J0OjGb5Olsi
         IN2XsVDWq22rexxmDyNQoimHDl8c7EtjrYDvzKMc1J0bDMWmpJz3J7TkXvZSyOiDw1aL
         tI8IJdUw0W8cxBPOv6jfsKOwfnqSIS4JeQvwa0eP4sWZ2ddUSgRbXARAaYv6XCpkKfWo
         y+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939752; x=1763544552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Th69YKPq2o8N+ogj+emLojAGgDHwBfgYI/xXUfF0z4k=;
        b=imU2olg7HVDrWRfQ5LrTHcn9V+S+B7TIxipbKtRbz+/WADIB7BoWFPxGyM8NXrPZGG
         4zp7BgdRX++TD2RfOqsbP/f3ijVXuSOejdHX3owQxdAOtV9qPAI9ePPNPUa6vgeNfBud
         uEdLQFcphWnsyGeEloh+LXHfH07l0lVrUEBKcIRvh0IgAY2t04RyuK8uVnM4m7YX9s7s
         PQleuO7kguocwOxkQ+0JtFmdm3Wo3D+U1z49fgD5jIGfFVX28ADs61Gowb7zUoHxxS4Q
         sXDnXCiivPQ0EGRAGFWZWxqJ30UtS+y+Uro6RBvWEQT/8KcJvqUMsZCErY7Yo+k02/kg
         MIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZy0UPShDC2/R4tQha2PlEMVkMc2YXfHrl7btajILq4D9OfgRpzTZ02ahd8JGr+sJU+PzqON2ifIgk348=@vger.kernel.org
X-Gm-Message-State: AOJu0YznnolrtcZ0JEBdtTF0P6KTzEbO6dQDfiD7yE5NYUc4fcm7WFhB
	KjoUn+WY6GhWaSFKmlCQuTOkk6LOrDhvSdbRm8Rz8II8NiJBx771Bc7DxXpA5q7Y3pmR7zdwjZX
	ONy5QxnaEgoca2gmnvPu3E/4qGv8PWCWyQ4mlA3UQMQNYvObEWg3H9wyemKt7Rj8BTY4=
X-Gm-Gg: ASbGncvPBmI9HyGZQfxZJ7FQIc+BKUxnGwSbdSE9YG93JMPFQGRvABqaIG4/ZkFXaYp
	MLHPHVnHzQ3Kd2WAmYkDWViOG6LHwZEbF/ZPJv9J63l931ChmdFS3qN6Cvdi8O8+08jlNSwpoOk
	c2A4I0Vdr8p0HsELOpUqMQveK0KIVLVNRzMvySJkZS9swJRFTj2ASmkVC1Ch7R2psvvrKu62UC6
	D9u96Fy5QjteimnwCxJvgT431dB3tD3k3nVLFAVTqH62Yj3ZJcQ7OsWPRh1hwrgUjQLYuPFjLZM
	efd0yaufOFupGyc/YDp7CbybemLYbluiMm+P+OBZIhVo5PaH+iIvCD8Ku/sErvcjKg6t3gvMy25
	LLh4Sr0igUQY7R8sN8K+Hs6JrlElHEeYSkvi9Zd4cOjijNez2RVyeK55O
X-Received: by 2002:a05:622a:1808:b0:4ed:3cfa:638a with SMTP id d75a77b69052e-4eddbd6f1bdmr17958821cf.8.1762939752202;
        Wed, 12 Nov 2025 01:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqlHgXC45rT8J+7YIfCSleUn1AIbYKCpDCT55SsVNBiHkKcHouXI74qE3/rDIrYIBNFZHQdQ==
X-Received: by 2002:a05:622a:1808:b0:4ed:3cfa:638a with SMTP id d75a77b69052e-4eddbd6f1bdmr17958671cf.8.1762939751809;
        Wed, 12 Nov 2025 01:29:11 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf7231dcsm1551653366b.31.2025.11.12.01.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:29:11 -0800 (PST)
Message-ID: <9d959c15-5b19-4173-9a02-4dbeed2609de@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/3] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for
 sm8750 qrd board
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com,
        Abel Vesa <abel.vesa@linaro.org>
References: <20251112071234.2570251-1-sarthak.garg@oss.qualcomm.com>
 <20251112071234.2570251-4-sarthak.garg@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251112071234.2570251-4-sarthak.garg@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HY0bQULUuXBiv35hsP_VQ_ov-n53EgRZ
X-Proofpoint-ORIG-GUID: HY0bQULUuXBiv35hsP_VQ_ov-n53EgRZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3NSBTYWx0ZWRfX/xvaX3EE9KCA
 Vi5/WEoqtr0u0lBxA/bRcEZNpCyjnnnikq17pe2+J6J5yw2RcMPJ4OjmoZ8bsUOtcx33iXCgqsl
 ZfH+izEq1wsxFn9Xe11CQ1itIwvbW8Gt1uGTYRlFWT31aLamxJH8390E+Ij9pDcT0ig14y0sl4d
 QzgydxegOFoEihm1+M1slLrAn9KNxonQmdpVB0qILSy0eE/cpiwalvr5hhGolXPDxxVYIH0KsN4
 f9vl6CUtBUOhk4Ci6gw1YOUpXgU4tWDZurBeNCIW0c50XYUQSmWg2tkIsrJSODF7iw4NO8EQAqN
 vJH6m7mXEdImAFeviZ2S352evkPS5bvKgEGpT3Ff9JLjTBKHEuQAosCER0BP3j9R6jMGrFj1M4c
 Tf6Npvw+vd+fntQCrJez88xNs34ZpQ==
X-Authority-Analysis: v=2.4 cv=L/0QguT8 c=1 sm=1 tr=0 ts=69145369 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=UtbPLzXqTwk2hxi6kqQA:9 a=QEXdDO2ut3YA:10 a=l-yEoJkE5-sA:10
 a=zgiPjhLxNE0A:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120075

On 11/12/25 8:12 AM, Sarthak Garg wrote:
> Enable SD Card host controller for sm8750 qrd board.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

