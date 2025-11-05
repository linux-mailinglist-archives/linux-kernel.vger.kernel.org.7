Return-Path: <linux-kernel+bounces-886159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A01C34E03
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E998D562C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A0D2FE584;
	Wed,  5 Nov 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aZJ9w/JP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A896A/tK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669342FD7A4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334980; cv=none; b=sCqbCJJ/Ipf8t4FhY4YLO4w2kGbmHyIqmAFR58Fpej318MQrKH6yz+sIYsmBzhuMStgF7bCnsbYEEWUPTBDnTUXMQxg5OkcxeegFFV4Vq90aKlEq4m+OQwAQzEwOXWfSYpuCLci4VSCupEzx8JWVaxxEIzK7vq7dSaL4r2Aq2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334980; c=relaxed/simple;
	bh=MdnyFwQzMMsBUv+jMD/mv+gYrCbsSHd+o7FTaANgyCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0ET6qPHn6Pg2tvQi/SFsYPq/NibVBIPH1HAfvf9mdmWMRCnhMOPLZep5qkZYRGr4cc/sMQJ3ITjqEEsuA2r3ynfKK1ZeIG2KjlDDlDT0h2PVPcxa5zBIUFiiT92vkh2xvpMV+rERFuZRaQMmtsvAYUUBSCueV3GAwMzdlQeaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aZJ9w/JP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A896A/tK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A54Y3Ao4011377
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 09:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Kpv3giOGr7w2BqYrDqhgbrfM9FEqK+1o0jUct5+PgE=; b=aZJ9w/JPaQ4Jnyoy
	m1eF2uSbCJSvhfo3OYFg6lY8f0vyDxra0Nue/BqqW7yLXtbhaM85NJXrWJDbdh//
	qi82qEfbZBtUSnT8gRJN+cWru98A7fKUXocdovtW4lo8HVNZO38QB+dZg+doabEL
	VsgtJocyj0LevqLYJR0cJnBiSJITqXLmVcWOe32vEcXLaXR6C4tyh4TI3QmI+eDe
	297ImllNURBRyF+3WxIPrpROh7DTJTY8Y26rK3zOnVULj5/kkygL0dTVcc1rRoLC
	wFq2SFqYdSCYM8Z+NXGmD8c7T9TimB2oXV8uPxyutvK2jy+Qo/ZH2s+ycDMGTX4Q
	GNs3Pw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ynwrrf0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:29:38 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8801e2653dfso15251446d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334977; x=1762939777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Kpv3giOGr7w2BqYrDqhgbrfM9FEqK+1o0jUct5+PgE=;
        b=A896A/tKfzE28klygaywtq44fXwRMRpB0h0RDBkDJB79isbRxlFhhbKxlbYxRmehdB
         HP0oMTT12z2CQD2MjxJMdzpReGLDaiaK42fUaCb16VIpm1LLB5Tv+USvQI5JBs2vUVLm
         AzXmvFR2g7Y7ML6glv6HglSFl7nDOYMAqdNQojb7JuE5vp3nCoaKRKyMiPqAkp4Cko7x
         yjaa448S41nuUc+waMsv/agb52ELn2BjMMLoL7CFfTW8ksIimeemwk6B3bxNZGg/h2gc
         PcbKgJ/3LyJLJHAdhDnL8372VvgYQl4Vkl3uzf7kcOLO0TvYLLuKDM0xmtI/0auUgTYy
         rKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334977; x=1762939777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Kpv3giOGr7w2BqYrDqhgbrfM9FEqK+1o0jUct5+PgE=;
        b=PluIpmVBs4CNExVzt4BvrgiXuiIsqpUseFZMBu0eCrirraX+HQYE51Rp5NSmF+fg1E
         FFXS51UHYsGKbV0EYBOKWpB+53J8lei2vOEOmS36K5wJgpByfV0PikMZwMxseMOL6Mjw
         QBElwcOQtevoN/JPIJqUAr/OIdjl+V4phiTiOFWVd7nAaKfqnEpnFB2Pzi4Kq3yncfhI
         nuSTpwHWakN/VRNdeNZQznvgAkoHu70kiROrHoBP37HxKFkuJfrIMov28/JjxaUUcQ6u
         oI9DP85+zrewPCjO5DLzzo00zulMY34iNka+rPHVb0apDuJVVSPMrVmuygJuJxuktn1G
         bAqw==
X-Forwarded-Encrypted: i=1; AJvYcCXCTvMSMXYjfwWp1ALc8NjbJ+MkuGugOIV1nMQOilfEWTsd68E77VHb1TtyFV7iJaB+cStkLMbX9CZ/9jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRKeYSVIoJCfIfOP/azSiY1nHg+5IKWH1k0BRJQq/ol4pJ49I
	KyWhluGk5gkypsNrEV0e78vuf3SbHGKuCONtNw4hpedBWzykeoxDlCeAQNPYj0YeQyu1emYiiNk
	dxf8tFoga1SnBKhNHZUUqVp7aiwInc+bliae/k4SJmOFXK0vEIB6vvXIyjG2IPeY4I4mEHF9v2V
	I=
X-Gm-Gg: ASbGncsjJop7TVci/eV1QE2uIaTqUVAuK2Ui22qT0npd/KsvI5w6Cpp0cekb3o2H4Pl
	yB9kvdzmZy4f+wGcHhqI8Oy7oqSjk+iE0094l0tW9LWB7aZbuiIGNPiZQRxCyByMKj0JLBIBsuo
	tdY0FCCARthBDRCqwpCwFZwRqn1e67+IOcoGdBW4RZP6cvslJYUu72MHHgKU+SBiAqldLBmXZKu
	px+NcDS+Ic4Ihwg5rC4P5QOagS+Yn6/bu/cwxyTztvXtKIXvMcRd7E9mzMS6XDu9ORRAJVbQjPe
	pAsqMbMW/rT9Cz/NbrhNtbHimIKK938nxvururBouZt1EqVNfWHaFTiLE4YCOI3qnZyDMkYOuKO
	MpGq56/3QlqTW9XO9QEiLiGtEmWmajBUkn9r5jdmvPuRce7F44ybEX1OO
X-Received: by 2002:ad4:5ec9:0:b0:87c:19e9:c3f4 with SMTP id 6a1803df08f44-88071190ac6mr23651106d6.5.1762334977576;
        Wed, 05 Nov 2025 01:29:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR5yLUbe+kckPs9cTX6j+3wagDW4PTjqIqd7gs5WtMozLhEkOR7ADTQz7OZxdb5NaChzR+8g==
X-Received: by 2002:ad4:5ec9:0:b0:87c:19e9:c3f4 with SMTP id 6a1803df08f44-88071190ac6mr23650946d6.5.1762334976987;
        Wed, 05 Nov 2025 01:29:36 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7271f2b678sm64135166b.3.2025.11.05.01.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:29:36 -0800 (PST)
Message-ID: <9d04a61d-489b-4fe0-b401-08a40c692c2b@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 10:29:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: HAMOA-IOT-SOM: Unreserve GPIOs
 blocking SPI11 access
To: Xueyao An <xueyao.an@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251105054548.2347569-1-xueyao.an@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251105054548.2347569-1-xueyao.an@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA3MCBTYWx0ZWRfX3GspTsOOt5jx
 b9ba/+s33sz7maORIULLxt5jVQ+U08RnU9WcJwBeGGMaJAPhxsExaORPZ3XxtvuEPsnOuk6T2qq
 E4BiOMElD//fdJXQne4X89lCWWfmNKNSWkZMIyUq8gHeo0ZXdGhcL+NmAJ5U3HKwm6pn4ZMfsN4
 I6G/V3OZXr8SkQmWLiLWMQ74Cx6ajjRZaOJgS3LyvOPwlFZrU6742IHVO2oQFI8HrOMMcirtWOt
 bHIVcWgKnk9P1uFr0nK7UWk8AIHbslV72L5ObwaqaHiWdA0f3xhiiFYXXl2/+5WUZxACNQy9Jya
 wkN1hTOLwZe08DB26BhaioQcDu2nheeJHrKIl2rAawEGN8wM12d7zUU3zl/qSLlD6rH5qlSg44+
 gLOKRSKYoTbOLrcka9RJsT/CFcsdAQ==
X-Proofpoint-ORIG-GUID: _jmIh6l5wLxPvinKU78wOXzGg_r-PiQl
X-Proofpoint-GUID: _jmIh6l5wLxPvinKU78wOXzGg_r-PiQl
X-Authority-Analysis: v=2.4 cv=IpETsb/g c=1 sm=1 tr=0 ts=690b1902 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rx43dS7NxoJ6fGjPFHwA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050070

On 11/5/25 6:45 AM, Xueyao An wrote:
> GPIOs 44-47 were previously reserved, preventing Linux from accessing
> SPI11 (qupv1_se3). Since there is no TZ use case for these pins on Linux,
> they can be safely unreserved. Removing them from the reserved list
> resolves the SPI11 access issue for Linux.
> 
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

