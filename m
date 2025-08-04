Return-Path: <linux-kernel+bounces-755157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7115B1A253
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330BF16F944
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515326FA56;
	Mon,  4 Aug 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l4a5TFGg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56525EFBB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311782; cv=none; b=O4NqxMCEBrBko1sXhfXrfnxOCClxKGST4e8LR/VjzlDpm2ix8ttdD/KwwXrI8fKRq+FYlJ4MClNZk84HjXi+1Tcon2namLc8VmlCO2sTksCXR4mL1X/C7ScN3TmBv1hLLRtkpykiSWFkvHQZTcMl1aOBAn/z69qLZE4YRJBA8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311782; c=relaxed/simple;
	bh=gs2nTfQ71K1FL0/3F/7V99owAG7ux5t21uHkSyspMbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJWVHwEUg4OIHGbr3A0+LquTc45VHae5xLqXrT8zLJr8upEL+Q4afBF+cLvL64Scq2eoaEV3XmpWjMOYXM3+cAaC1XNPaUX+X+GpMdzbtPU0dufgnsyOu4SWkL1jie6ZROKoF+B/Ct/h4AVp0pnYwJ7H+qrxrsVRdytWnLmerT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l4a5TFGg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57498p9t023102
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 12:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HuG+AREz8e9iXy+P66bDzIEPjOCAA2V0u2W3LH+qvX8=; b=l4a5TFGg+aw10qzv
	wNto9gUanW2Wh0M0mArmgfngm8ImtSmbM0h+a1rDPOkS4/qNy7RE66Q+6ljwH72s
	YsQqwj+ByOWV2EZAnOknRG2NLU1iL0z2p4f45SjYoxVAl6YpnMy0rCNP6qhOLE+i
	Fqh6JPBD6XuSdjtVPWRNRID+pIf2aJnIZxi3RipGQ395vVFETD57a0DtZmD6Og1y
	gQsTGC74Q60P7crsBOASFjKy5yC9r2cx90JG5DdmFdK+23Ea97Phxk9o44a8NRlh
	TbLyRxmoxXgiavBa19EiwqzrOTlJff7h/m398tjEMB21KavuwFc7R6JByh3Q3ptE
	ux4PXg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489b2a4wdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:49:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e800094c82so9621585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311779; x=1754916579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuG+AREz8e9iXy+P66bDzIEPjOCAA2V0u2W3LH+qvX8=;
        b=MmUKfGZcaUK6n70gSXmSFJI3A2sKHW5xlK+sxXe4Cr8F9zKuaMQ6I+ZS6D0SSiI7de
         2U/FXWQ3mzU3QR+6AuTFuOQPUr5BeecgiiSHTaAlQH54HhSqR5GcQ5l6Dga1TYfcQ77c
         UfDsgI4BQjzCavJ1BSM1G+mKsKQsHuBNAOJH6lOxiqohYK8bbiY2aDuz438FxGFGWUCZ
         +1RQr6xkfc3KjHel0sbUKN45/SAb75k6zTydLXaMdYwBcMWADSWiLfCHFP1COEyXFvcw
         oZ2Q5+o4BagifEaKrl+NvEnLmgR527WpYWXSdOcgg9t5isXVG5+06wmF6V5/B561NHT5
         u1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCX4DrldWDFB1XeLE6i4GKE+50D+S5vcsxUnTS1F0uMXYX9W7dyWTo/HxjC2hzBN6RLGGh9Etzq+9VfVdKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECHkHiFJd/1lmM2qP5AeHsFdg/MItwcYqWkh2ONbH/elcFIaz
	B7Ckp96rJ1Si15y4eHrM5GvDwaf72VsZ3gBgGLoppjUig1nmhJXVyXowI816qFWj/OhYdgCWJAk
	ZSWu75comgoQo6HlPfYKyouf8DYXh+JPhhziBcvyVuD8ZkhkSiz/qmyW+m0et48NRAio=
X-Gm-Gg: ASbGncsEwlpttkbP6E8jATUPfZmcdsML8btshAwSWfc6iyju95nrTHgaoP/hZNRMUDy
	lUOKJlcIjYuKz4D6rlHkXDth/8qVB9iBENYnPUzwv2/xYEK0f6HzBkio0qEmA/QcgXP3FBhLLBS
	y/th8pfhLtVTc9lfJNCjz1xcSoNuEvefpAhAJ1lqhBeN5dUmSyVwaUXhcGGHy3Zl+Or6f/x/hU0
	QSAnL7cUalFm6WUUNDx90V4IrwuPKSIH64101Yq3m035R+5w5r0fQMglgXuOD2jcp2cjV6hV1MB
	tVEET1YrelPCFclJvo4s/L6kV1MWDP45ZZ6zOzKxNYn3x9b9i1qX3LkiHBFIRFBTs7LVYTT5J7L
	dpWEwk3cNiofQ18xKJA==
X-Received: by 2002:a05:620a:4083:b0:7e3:3029:44c with SMTP id af79cd13be357-7e6962dc3eemr595492785a.7.1754311778783;
        Mon, 04 Aug 2025 05:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXy5F5bapQn0nO71JHnWJEf1UQ9qqolIof6CqE8t9CRANM4N77tCxcRTH3d0X9coKAQaNVnw==
X-Received: by 2002:a05:620a:4083:b0:7e3:3029:44c with SMTP id af79cd13be357-7e6962dc3eemr595490285a.7.1754311778224;
        Mon, 04 Aug 2025 05:49:38 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2436c2sm717085566b.141.2025.08.04.05.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:49:37 -0700 (PDT)
Message-ID: <c96df6e9-ddba-43f7-acea-191f19d5484a@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 14:49:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: lemans: Rename
 sa8775p-pmics.dtsi to lemans-pmics.dtsi
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20250803110113.401927-1-wasim.nazir@oss.qualcomm.com>
 <20250803110113.401927-6-wasim.nazir@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250803110113.401927-6-wasim.nazir@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OKwn3TaB c=1 sm=1 tr=0 ts=6890ac63 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=SmZcuDTjAAsXslZR8aIA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 17-YmLnkzAhQt0gC2cExlE6Xx_rlA0-a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3MCBTYWx0ZWRfX8t7AAYAX0xjI
 D6m74KAVeEWwus5ozE2fljFNrSBIZdMoeQvmsAUO3rpswDEKeIt8WtZ2DMLwfGRPzUAWIrKRkUo
 ASzLhi9g18Z0PmN1cPGb/bG5v/Z63HzK5J0GvQdB8QlIuFZFO/EN+GSiXpuz6S6vRxLXUARuOHH
 I3CIQsDvWE/XfHetLQaSs9PN+T6HcLFT2k6pjDL8mFsyuE4yyJgS41yxt1hn8omuT7Q+XIHD7PC
 vyalENvE7BSxIr1bGyzNLosGJZkHlbNuHXsyhXpOyJHjUaSLSPxcT+cXKqE1xAvyYT1deekkODS
 3TnT8iw7yY0VXZhXV5hb373b9tVBlxHos50O+y+/NU3lKIlytJLoz5KaRhmhYp8ecA+meqPqp8M
 x2LJufXZ4BOj/zPPWbD8TUhrmz1g+tf9RonvNbUewUk+mEhjo9bCilhWmFFj6fhBgaAwjfPG
X-Proofpoint-GUID: 17-YmLnkzAhQt0gC2cExlE6Xx_rlA0-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=738 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040070

On 8/3/25 1:01 PM, Wasim Nazir wrote:
> The existing PMIC DTSI file is named sa8775p-pmics.dtsi, which does not
> align with the updated naming convention for Lemans platform components.
> This inconsistency can lead to confusion and misalignment with other
> platform-specific files.
> 
> Rename the file to lemans-pmics.dtsi to reflect the platform naming
> convention and improve clarity.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

