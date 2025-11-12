Return-Path: <linux-kernel+bounces-896885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA2EC516CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E59A1894CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B442FDC41;
	Wed, 12 Nov 2025 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CRdelMCq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MagPQcPO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947642FD67B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940574; cv=none; b=DnLDixZBxaz321FlfyORKkgljGLwQc0Pet5zJluxE4Ot796+lGaNFhmGViTuDw/cOW9s5oWMayK0ILC/qUZvYvHRlQrU9Zvidptn+Je4Rp6pYhngbK4enwzU26AhEexyJFwqevLJBP+WQ0T1pUTd6OqOIZp7n/ty4y9Pd/Zdoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940574; c=relaxed/simple;
	bh=f/uh7xMVxW56p6zWC3Gy7P+W5GuXMtMZmawcVdJ3TIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQ1OiH2exjnf151FgKsfOr27WeLq4U4t8Y2N4dLAy/HBqNAYhwL0SBcIyep7ZFQftLYxICQoDbSOwplEVhrPQD0yS3cXvjKIlYvnhkg8Uf7+lR2nQBXkEtUA5G+xJRh21solTyzfPL2WlmysBJ/33+Szf2zPnUtPMhUZeGFrxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CRdelMCq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MagPQcPO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC6SlH7350253
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ESOOWg8JEZjuFVpbTTjzjvm+h9Zxz/dEl8JzPniKi9o=; b=CRdelMCqVNjEradS
	Ob2EU8riVoS5Q86XLzCiEyXVvMOBAv6mH1zZsVhU5NhODAlmKxHxMezzbjfBnO2a
	0VYY/XWsk4lizbM55i0E5EPOfWqLBlQCsnjwYjSvuFLopudlt8dk7iMc56zGM0eK
	sDHsy67N3u51mOn3ozNbf7ntlQUPRJPG4BJmFTUCQT/gEbs4ZQRhOcpKd6gDcFjS
	yUYe+NuJ/1EOiG7CKJGFEYgwa711pWxH6T1OWG1lryFR9MqE8BCk6+catgcuy9AU
	swbqTcMrO803pDSbRGTgcjOer3jgfN+F5/M9JujJBR/kFJGP9StGUDT4mTDt1QuY
	9YpOnQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acn0nrpt9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:42:52 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c7022c3c6cso176976a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762940534; x=1763545334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESOOWg8JEZjuFVpbTTjzjvm+h9Zxz/dEl8JzPniKi9o=;
        b=MagPQcPOdAxZfUl/IE8NbDeZdokAOrXtwTkX6I0lskaovgA0LcDKDxbymVzrYoQZE+
         eJq8NxDvHXb+9F2kbJfRebankWv0hyfDcFP065EssvOc07/0liX5aL8DIyd8p8obe3eL
         Yvk+KuQN/s2Jx+YihPYES1WapfYgZMiqUxqFbaNz+AE02IyDAHIrfw/aIR47VS2/JvUn
         /AT3lDRb52yw3tzcBjjFYMY89yFfz23os9mUhmng3ftKw2k3jHDlRKtmcEjbvvF7kbby
         /v9ySiv2vPsqGqfQkStY1dU7/8MpeucjxXMc3aybwb2SGXPLMD2wSuWXPof5Qlf6Jb2s
         AQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940534; x=1763545334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESOOWg8JEZjuFVpbTTjzjvm+h9Zxz/dEl8JzPniKi9o=;
        b=oRXAFLCI1y/S3WGbn3qY5oWjtozIf9kN7Ftca0kNixBIrS3W9whKdaWlDhdkBA0aHi
         zSJNjgDcRaYewv3ZaKFWIrKF+6cJn9iyHsbono3Q0DXKyLo2n7oHHtLGAyvcZL3/0+S5
         0pp2sROa9QA0pjdGfT49F/KGzcwY50TV44fngxEr57C4WYbp8N+xBmxbO15lYJM6lMvJ
         wvondBNe8BOCkoOUL6sRPIXc7fyiMJkz4XJABAYoOtEdAZzY8ZPfGDNGn/VA4dpFewbd
         P4C+uju4gNprfQPk2451EOZXm+J+ylu5SSTjKh/zuCjEJYvtH4eJmm8mHhGfAwbN0K0Z
         dLJg==
X-Forwarded-Encrypted: i=1; AJvYcCX+bBrj+a2jGQZBoAbWNPRHP3Cbx/aHkrJ84ViwLisxFD7NhbvlpHWDEmpcrG16I69AMhyy0Gt9bm8tvt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfWdR1XIKopiRZDBknbA6VJi0/6ljRwYq1mJfvqamSe1UijB4
	D7u4sbEt36STATrO/KlerxZ5QzF8bIMURU3ad0D6jDJNjz2iNh4om3oqW7PK+96kuI8B5uk7VLk
	ZO/TA0J7Ky7mjGul4b3mLMatjr/qXo9gaj/1sQlcAN4lNkZTMu76RI/UiGdBrSzPfJtM=
X-Gm-Gg: ASbGncsTH9zQ+ukRcP/LmInLuoTAqaD7m5RZzxt9TMekH6xnmlaksdwUK7FjeJLIRTD
	BepiXekDaiJqHypYRgjlaWxzmAvi9vlJXV3hT69CnAlZni96SpUOxpydBhA2MziiXuRYHVx6gTx
	pto/XbkxxMRfkcKVFACrQOBj3mXvs2rCGOKxLuNLwydQJasZVfsPNR7bUdxPHTqKyoCbme3SUBU
	2IubNtiO+JyQwRpCOR0oBO1xT5OFHzhCiIXV+V1Cnzvn9cSMboTrmPKGcbsDC3u1KOJNbCbaZxa
	8roOi0qgtCGr/3otugKoaORDhru+RuFghBxmyhQmwIjhAaEYDXVkH6BDxRYoUoSx063Pe6mr7pC
	Yvqa/TGhyUdorN1TXIgv6M+IOxp0zjWhezJxkeUsM/CPXcAVlMed3Sg5a
X-Received: by 2002:ac8:5856:0:b0:4ed:94e7:97bc with SMTP id d75a77b69052e-4eddbc95295mr20899811cf.3.1762939742857;
        Wed, 12 Nov 2025 01:29:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxXDkLREXGIGU0plkUZzQNFHAnbqVG9tKUgJHlDX4gOeECyx8+IjT5CefAqXJmbC4nZB6Eog==
X-Received: by 2002:ac8:5856:0:b0:4ed:94e7:97bc with SMTP id d75a77b69052e-4eddbc95295mr20899671cf.3.1762939742482;
        Wed, 12 Nov 2025 01:29:02 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d3c0sm1608794866b.36.2025.11.12.01.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:29:02 -0800 (PST)
Message-ID: <5f26380d-4e2f-4de9-bcb2-54ae78495165@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:28:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/3] arm64: dts: qcom: sm8750-mtp: Add SDC2 node for
 sm8750 mtp board
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
 <20251112071234.2570251-3-sarthak.garg@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251112071234.2570251-3-sarthak.garg@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iJur1E1iSropNWoZL2lF0qExE-ExVwAx
X-Proofpoint-ORIG-GUID: iJur1E1iSropNWoZL2lF0qExE-ExVwAx
X-Authority-Analysis: v=2.4 cv=acRsXBot c=1 sm=1 tr=0 ts=6914569c cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=UtbPLzXqTwk2hxi6kqQA:9 a=QEXdDO2ut3YA:10 a=l-yEoJkE5-sA:10
 a=zgiPjhLxNE0A:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3NyBTYWx0ZWRfX+Am2MaIxnyt9
 hjTqJblPO7Y6IhsBFjBGrKpGUghEGCYOXP76+ka224aWDzQE+XAuDPcw3us8jdzJGy1O83ww5pe
 9sSaawbwPuVb5nKZWY2A6e2MKMZRU1m/wb+iooQxTM/wmZk9RAUfkxJpcNXeCrvRmmWxXzA0QBn
 MaWtIBg/NuTl494K5mBlSYscwLzaPCNywfkfAYFmzYR/ekspTqPZbnDTkRLGC3lxEnH+VBST1N3
 seGujCiIM6xBt/92m07lZ+xq4/ckJbUp1GgM5QEqJ+SqYbhmEXfNMDJ4Ebnp6yvCp87fPmfjE+o
 vAP+srO/dlVskfN3Ut9bfuSalni33udIqqe+3CTvF2VuQHPCauLqCcKAoY2RDaQSmO3x0isPiGn
 Dk35lJzMsPJbcPQAVLasMttBt6h/cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120077

On 11/12/25 8:12 AM, Sarthak Garg wrote:
> Enable SD Card host controller for sm8750 mtp board.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

