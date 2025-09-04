Return-Path: <linux-kernel+bounces-800345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB5EB4368D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88594545995
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC7C2DF15E;
	Thu,  4 Sep 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jK24o6/N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C32D5C95
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976614; cv=none; b=Fmcb15u2rMVU/ip558FB8GUAFYsaWlCRPvrvy6znO8zfsN2YfLAT8jS3lfiPtQD/TYKaOZC/xfB9D1ZdQB8wHCePTgYKUMiQ3gx1VYhSh/35SDs54fs5f4axovm4nBoV8nkPU26HJS5rTRY9E11R0lAnVAKcTGvEow71/Ur4TNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976614; c=relaxed/simple;
	bh=IVzwfa0cyK2af2bOYqny0faBlTnNIUslY2W3man3aIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZyZ8w9Ys3EAmwgN966/e2ngRccyDF2pDLP/VVw72w0Xu9eULrsc11UQtetzhgvbQD7ZJsA5H6ATWZnlSe+HidWJUEPIrC5BcvvFd8n8LIk6SWS+1WSixt0d+lVy3jIKIf1c4hEtMfygA4Bmnz0Lw8U2KAYafAWF4PF4N6zOKeBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jK24o6/N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841WMeI029667
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 09:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lWwqMqDYUMELEgotQt9i8NAGChCL1/B8NG1wqMIp3dc=; b=jK24o6/NqhbReMoE
	JYhW5T0PXYphk0S2H6fv9Tq3kQxrsoiMtzgg9ncpn12D8IIyWVB3s5FmXAkYA7T1
	8otmo2hFSRGa2Uyi1jmz38PFzmes2atu0Bmk5JAGv5gMNeCQ9ZRE1FNfpT0gpYWM
	ewI74Zo6DVRzfnzaZTUz3pr8KFJS4uvdYQaR+4wfKAKnugLXX+PtLq8tB6sBlNRT
	heBEd/kzpthXVNIYKF/hIahaX8BI9lDBAuVK43M24u0d572M/54uRhDS8Ert7fKa
	oTmd4IaTjifaJRMYD6azeIU+7bgI9FnoYNMOs5voI3rSK+o3D6t3jHLP6t51H3uR
	kdtPzw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw06x99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:03:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3037bd983so3333731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976611; x=1757581411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWwqMqDYUMELEgotQt9i8NAGChCL1/B8NG1wqMIp3dc=;
        b=NPnPTPbHQJMk4YK3op1i9SKuHiqtwo92h2EnCiiD8KKYr07On3bGxVC8wclV6dj0eQ
         9cb6AW/YZAwWBlS48JKc0BlByqQVHigUL8MtjTYO4Sq2ay/wbvN96joT+gf18CBsNwd5
         jmDCrk/T0Lomkojjv4fY2WcdxJlb5H39AkvL2usP9HSQMB/yIRqyafQSMu9HwvVxqL+R
         JzoFFefmRHwqOSl417pmWwe6Un4hZCA9TLiKZGp821TBPQST2zTNyCF487p6k08m5Krv
         b97evFZN2AjEpyaZhTjbO1rBPeKI9HuIG3sthN1phwhPSY2lxjThNSzjRhncFWz6Uha8
         BJvA==
X-Forwarded-Encrypted: i=1; AJvYcCVPI/haRiV9WCAhwymuwo6u/Bk/PDm46u+l2+7JN97rlPs6csOu17ydC4AYhuwfD8e+kd+mBL7j8hXKkPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmMa1Rz/94ph8Mgfiuf34twYpHL/vuHXylAV0zKy/LUpTBRaG
	iy2NPqXqBvm7MwLVkMqLOJYh0uUQYO2Nm3B4waLuyMPislxbxayhXphjG77fJu9L1qLm7YuW9pO
	lH8+EpWiwdx0S28qPmd8zROtT9dN+zMGXnKWof6Gxs7amzDTbjpOuuCBCAikGZuMP5ETeojtgAA
	Y=
X-Gm-Gg: ASbGncuhIqdiVNdjQUEdC2wOMcADMPXxx+tQClbmTRd4AvMzj4rRxjYmhGWRN48kbO9
	lyxLXGW5LCvJ7zFk5b1BOkiEgwPimQtpO0s5RVJxCTxEyRsFiJulREu9rEMOq4fThhWyXxEcVsH
	GNPGBo6DOJx04Qc/kpIHC27AIT8GSI9F4blL+Gv/zWU+A9ZeC6SmmqOZ1hyth1K3pzyS6VsHVfL
	SsLdDrgeIO8xLaJ7OoAVLDsgtpOQLUsb7ys42W9KpE/odYqReZBXgUIo+TJezOkDCrUfu7OfPCd
	LgiRlUzZhmbd/ZfGsTXlNifZbQfZLaN5jCgmju6AOY6HMrpXKad7l54myZm1N82loj4i+YjrHQW
	r11q2mgr7Ox/qXah5TRAiuQ==
X-Received: by 2002:ac8:5d12:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4b313f0e6e7mr174825901cf.8.1756976611293;
        Thu, 04 Sep 2025 02:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPKiEKZh6NWDFz0ZS8SWyyDrrLkUhhVstCrbbkOo4YxnyhnPN1DeFHT5gwS7q8/YO562HX6w==
X-Received: by 2002:ac8:5d12:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4b313f0e6e7mr174825651cf.8.1756976610726;
        Thu, 04 Sep 2025 02:03:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b02a090339esm1261940766b.37.2025.09.04.02.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 02:03:30 -0700 (PDT)
Message-ID: <ffd13df7-814e-4d5b-83f2-f161f78b7c15@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 11:03:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: apq8016-sbc: Drop redundant HDMI
 bridge status
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904084421.82985-3-krzysztof.kozlowski@linaro.org>
 <20250904084421.82985-4-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904084421.82985-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eqLpQbOySQKUVyTs9FWVjhQA8ryV0HWs
X-Proofpoint-ORIG-GUID: eqLpQbOySQKUVyTs9FWVjhQA8ryV0HWs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX+ZHWCh6xNuk1
 hXnyBTElgQD5ajCnHX2LYxBpxrrOZE5bJSIIsO0vxww1+lpbiLngz+uJP6OzOJFL0lUIDUllfyd
 Xj/7Ecwi48OREAcAlc67CpuyviTjGGgtJdt6E2QjKcJpArxZfSUud1MpaatVWShhDFOuRyCwujD
 /5oUPwrcv8edY9xng4CsBPbD49AQNL6/VyP59syrMfbU0o87BZEw4sCx6bE2wiCskjdEQ4j/MxX
 8bE2KEJE3O1VFsIiTR4d4L4iNq3McvPw14scN2+pWMaiTXbrKUkwJjF8Tyi8Rlu2ioHVMB0vIk8
 Lvme1lwqH0TTtuJWpFNmPSirQMfLQngPW+3QBEXVOgrsxEwFOFT5tW1+ciC31qFfFvt6Y6dAPVH
 b5BzBKdU
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b955e4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=RsmVfDL5kbmPRNFfNewA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On 9/4/25 10:44 AM, Krzysztof Kozlowski wrote:
> New device nodes are enabled by default, so status is redundant.  No
> functional impact, verified with dtx_diff.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

