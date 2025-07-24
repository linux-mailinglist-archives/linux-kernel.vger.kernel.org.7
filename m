Return-Path: <linux-kernel+bounces-744257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2940AB10A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51799165FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42C92D12E1;
	Thu, 24 Jul 2025 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IofTef/g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAB2BE627
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360137; cv=none; b=RoZbZ4Zaa+etqLm5EwXfjQaVF2sEhiKw4XEH88Lf/q6b7JH5r+2jr8rebCpkaltOYiVacqx0xKuimPlmFEQsamCMU6a0xhx1/N2gP8huR610NtN83DaZndCuceSFbyyGTD9ur3cRKDlYHyULWDGHqix0Hb+DN/RwWBRMFbd+GOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360137; c=relaxed/simple;
	bh=1oqfCn9o6XS0AyM/usZZOjR2QpFZGQRcynvBkNAXPpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MB+ttSD/oDZjomac1VuFpu8/yetOgPNIU9OxHh/pGjvA66F1f5UJcf8xykF0ccLdAy/DlZpXFEXuLgD31Jx6VGbDCfgR7vZgc7wdCKPlzcCZESJK04DWrIpYOUgeSxfR8xzcP+0XEbwKrSjJeR12512yfujoZ/fkJznLDqsnzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IofTef/g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9XFga012641
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3MaVShJ0VSJDrCoCdu3HeaxwcTF8H32vWjRkGaPxdKM=; b=IofTef/gj3RGDtvd
	ZFdtZbbS2T5vIOLZkn6DCXjHHvBLTe+Z2xyJcQKeA4F9ABCkU3Wab0KZQDOOFIjW
	Jamup/qlCiLl7fK0vdxlyjj/QJ+CsxlvyFINWzzQTqji60+oUUmvR8gr+WXB+q+G
	VEPvZiARmkHs6EdeqWpADE7SwRUKwQVfG2ea4ZI2GH5TtUY3d46BKvVasjXtaN4Z
	ceB+7bk0CQl5BeSp7WyE2weB5wSKCMK3dqAsOkpnY4ETiQoyv744iRSlm9LaMHqc
	EoFUXPmCstZQ0j5RjczKdWDHeNqRzOuY19ETiLPIVlxgwsvrBe4yW2WaNcuKJL7R
	prNSWg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hxppd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:28:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2ced79f97so20126485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753360134; x=1753964934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MaVShJ0VSJDrCoCdu3HeaxwcTF8H32vWjRkGaPxdKM=;
        b=gwoRwsf1XGIs1RtCEudREl+GotJB2CyWO0rQLKi/z2F3i7/L+DG6OavwMVSZ6iG1Jy
         EbTO5KE6lMbh3m8VUsJMwS1hyk2yX+cQWuc653m0AOftBoijv1rLcHhtdp04QlZmGdSQ
         WdT/KJXS4517h4vyCV0eAwuMVjeuYKL0n8+Mxs9gMYDVNf0fll/dt95loCn63+63QX7I
         hkOx5hqDqZD3H6U7GlGpl9Ud8JLyvdDYaw8dAPoyXV8RDtIPW3tXu7AChFvpCMcoxULP
         5taQG6/FK7RlFlLLM/xbkcQccgq97/TfwcOUyV3YGyUZXmEorP5qLlUVU6WncFEQkK+F
         XfVg==
X-Forwarded-Encrypted: i=1; AJvYcCVd7vOgZLT0t8hVqcZIxdALaJhfAO7b71KpOmcGthjxN9Qb4+2tdeQmA7wZdbVMFyeIuHaeFcyJxtFUL/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOd2ZUMBgtfLUa2mlDK0MgMrYEjFn86VQM+Vx/YNoxXfVv4Xl
	rYbNBwHlNPqq/we/JvlH57oTW5C020w9suapZ2dvcgru7x72SYp0xdATLO3pwXW0d1P3BEMOQMG
	HENV+CQ0AfzURBdeuavXVB4vjvRfYZgLSRDi3azMQH9EcvIN7s79Q9Jlt4FLgKyoel+8=
X-Gm-Gg: ASbGncsfEgF/XhfI6oc41PotuvwYi+IqJFYd4zit6LmLqI8WciZgBb0s+s1QmY13hVU
	TAzsqpy0+1ElyobE8FYo3Pgp1oT2/Zi/fbzqGngFQSBPySNjKwFCfQ5Nk9JiYYtQAFxnE6cRmd6
	D8t1AgT/ySKjThJiQMpqDu/yp6S5wzo0jqUgZpL6oAP4mlLwiqjv5csR7hJzRdTVjSEioD0ro+5
	GCNRrHKfSOdX2AKTci+C7kmgLTdfSHrEjMKy5iGHUCK9lXm45iJfrMILEybqp7sf985KFWL0cFZ
	7sfFNYkklOxAgYMku+EGdrNlo7wBjaq0saHvfrPP073whkohfTDU2QJDB/osEkW7xh6h1ORPsg8
	uCES5ukWEfViaWN5CnQ==
X-Received: by 2002:a05:620a:29ce:b0:7e1:a4c7:a819 with SMTP id af79cd13be357-7e62a1534a3mr327175885a.11.1753360133960;
        Thu, 24 Jul 2025 05:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEdsDlVJUbhOpmg2PSQ1ox06mFCUW6kPotDFU+P59DU0DATLsnjHTJattEpZD6dVxX992KkQ==
X-Received: by 2002:a05:620a:29ce:b0:7e1:a4c7:a819 with SMTP id af79cd13be357-7e62a1534a3mr327173285a.11.1753360133346;
        Thu, 24 Jul 2025 05:28:53 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f956e03sm105244566b.124.2025.07.24.05.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:28:52 -0700 (PDT)
Message-ID: <8cee91e3-c83e-4ef4-ae03-af2f01e03dc3@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:28:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: move data-lanes to the DP-out
 endpoint
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
 <20250724-move-edp-endpoints-v1-4-6ca569812838@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724-move-edp-endpoints-v1-4-6ca569812838@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=68822706 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=reaxtgZRAgWUn-9b8AUA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5NCBTYWx0ZWRfX2uEOaek95qJ/
 bxXYlYeHEWuFdyWzMn3JKLnUnQ0HZAgQoZUPDgiIDWjPCHEUIUniCkbWdRFc7h2EmhuJp/8vdRC
 XWSMQVGtGIESerDIwE5AMqQB+Q96YUdy2HbtZpGMHeEwQC8cGPiRoPM+bP5zu5UB+Uhj8sLe1OH
 I0DDPoXJqEXs5scVsn75Y+kaMLPi6rlLJfcucOSkePZUrgepW6UBO4cC3hgTIA4sqoJb4mOKHsC
 XNJXgJb9rosxHExi6duvTGUUXxCxiCP86Bq3dqfgzKrNVShotJmFDdAN7YfXArpkURiVp8/CyMS
 cj9v2Bu5OUYTbt5axlf5iZblK5YjbmI5FiBJjN06wZLwzoATHVHgAp0+DAoCW0+fDltFhjweFxe
 1kv26Aq6ZOcRC4MeXXTBOHwb/pzwI5G4nkWseoqXvvWC8aBjbOiW681wEZWwy1A1lhm4JFQG
X-Proofpoint-GUID: VD8Bu3XaXpksPFV7pgPFZtPTywR0fV5i
X-Proofpoint-ORIG-GUID: VD8Bu3XaXpksPFV7pgPFZtPTywR0fV5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=872 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240094

On 7/24/25 2:23 PM, Dmitry Baryshkov wrote:
> Support for the data-lanes declaration in the DP node is deprecated.
> Move them to the corresponding endpoint as recommended by the current DP
> bindings.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

