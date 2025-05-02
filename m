Return-Path: <linux-kernel+bounces-630194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8CAA769F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E1B7ABEB1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703CB25D20C;
	Fri,  2 May 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5azY2Vr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6589A25D1E2
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201773; cv=none; b=JEg59Qi/eAwhPpaYPhSMIErMvrGkBT/Cr+uVwVezgPAil8BKBvadMF+w11ugKnhixDtpfGYTMzx+rg2U6VBnpaFnF/ahAcj8L1osJvbogiS8tNcHb2+raXbveH2eu/bxdVeaNImn2zO6xp8ScyTKsRcLzM80eNb2D/ylbBKQjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201773; c=relaxed/simple;
	bh=nt7pCl0xKFuZMbcsKuarhpz0f9X8gk1jA/yLJS6JUcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmxwGdQBBSoaEg9k5hXheG/TdsAGDY2TPbFcP3FEMHkuX/Stzvf5sI/c46kvifbjISbOyUdrm1I7kPT562JE0FsuM1w2dig6fa3iQjjxtGiNNoMOvNReGPcX6ewKyNVRsEI+eV7wpbFzqbaU6dxhlgrtOzPpRtJV5BbLRh9Yb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5azY2Vr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542DQgbE016121
	for <linux-kernel@vger.kernel.org>; Fri, 2 May 2025 16:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1frcGzb8hC2GYxGmVc0gjbhl3/lGMlADlvPYUqYXl2s=; b=B5azY2VrKcqp2fDH
	NNgpg0OO9B5W60hqqzqsEwm63kQBYjYPSdS+o7RSFap1rpNms/7emM4fRpIuqACG
	K1vA/G/mavbFcnsWm+vPe2fW387ntQCIKnwZ1yRkXphMgqInW3t0O0eLC+7Z9cy7
	uKzxSMRF1ZAkMvuN1mL4C35QTScS20khcdabXIHw0UvUduo3FvG21uk3ax2earkR
	kx+QaMoSQFt9hgrdSBCCit3G7kahqOKWSzW0Jyp4OIcvi68ssphPqPq5Rl5GHjyW
	UnZ5b/hW9YvmYn8I+NROs9bxTZZT7P1vYjsW8nEasQ2oFfCjC/SJxEy9V81CpAoc
	TGERRQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u78tub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 16:02:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b1442e039eeso1407363a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 09:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746201770; x=1746806570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1frcGzb8hC2GYxGmVc0gjbhl3/lGMlADlvPYUqYXl2s=;
        b=FldTCw6bjFUAlNIIAWxm9cArIWCTHOoBNPCCPVaQcgqM5TSwDm4nRkifDI6LbMfLSC
         cjwk/juFJWFE/KgNycuwQ771bXSyG0rsr2hbGoConqGEG7MtjcFnLrNBEWfxwidWUli1
         5wDxeZaIsDZZRhf34XpAbdehlsMMmowYQ26keMLNXT4bjjpVp5Nam6zLY50DsM2C06VC
         XuEvJk4jaOFXSEo2LJTGMWQT9R588ApiN/RViSnfDtuhSjOMrqep30EMiYoiu7G8o1tJ
         rY6M8jeUDS3wwbtjuxoFfICGL4gyjfH09YJA8uKpqHDrvcMNHtnERJX00RlKOcpWICsI
         CQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCXpqzKctijGx84YvkZ2Fg8bok8lXS8SHy7ByfDdW4+jSEVcAhumJSpExlNsib6VAEW1jAPf8dWq0EPYF4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGs34W9GNQvgVtidVQlbLvpiw+iQthWJSA0CBg4hGuFOblnG1
	QNFeVai34KkyVXLw8p9YVW8mlC9sco1N+ZbA4zRArqPdQlXaZXJInqmbHg0YA636HyQNY/0fOcb
	vOh4fxkyca4amRZBilLR34IxomX3GVzJ+GY9wYTL/5Zd/IcBMoGGDQA5x1+CTTeQ=
X-Gm-Gg: ASbGncvEIEC/A/lDzK4q0B+YPcIb9VlmC/apLZs3eG4HCTHRDADZ2YQN45hYr0CNoDf
	MnyarbSoHohIl6y2f8J0/X942FiCAKEDbCngkV1+zz1Zc8MBnQzhmtujydnnYC4cIqcYMeQAcP1
	lC7f9i67OQphswWEE3cZoRH74yMB9F9fhyhghQMkHTyEGyb1AzsStWc0D7I14xTRiBpGysp1lpF
	/9gIi/F3doOi4/jGF8kn3ip3KCBu6StXVdblaFLTR2PF2/q9b50O9jtX7Hy/wSvqjJhmkJjfuFb
	phbE4F4BXs5jJBakKQK3tdelOIRJSIp+JTAfxCoSOeqkO7wbTJNf
X-Received: by 2002:a05:6a20:6f90:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-20cde952d6cmr4451423637.10.1746201770543;
        Fri, 02 May 2025 09:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+5DGedS7lQxaiS0zztOhBE3vSAm0Y8qu2C3qMH794u9G4iH73tZO1pQYXwyOinkWDLCtVwQ==
X-Received: by 2002:a05:6a20:6f90:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-20cde952d6cmr4451382637.10.1746201770057;
        Fri, 02 May 2025 09:02:50 -0700 (PDT)
Received: from [192.168.1.4] ([122.164.87.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3920e67sm952740a12.7.2025.05.02.09.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 09:02:49 -0700 (PDT)
Message-ID: <41f0eb29-931d-4aad-ab8a-1cc725e9d30a@oss.qualcomm.com>
Date: Fri, 2 May 2025 21:32:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] watchdog: qcom: add support to read the restart
 reason from IMEM
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>, bod.linux@nxsw.ie
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20250502-wdt_reset_reason-v3-0-b2dc7ace38ca@oss.qualcomm.com>
 <20250502-wdt_reset_reason-v3-4-b2dc7ace38ca@oss.qualcomm.com>
 <ac8837b8-3964-40ec-84a6-e25aa06dda39@kernel.org>
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <ac8837b8-3964-40ec-84a6-e25aa06dda39@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDEyOCBTYWx0ZWRfX0OUH7ObKOeuh WEaR/CT44fFxmnvzQ4+sJdZUaAXynqyKvCsbQ1q4XwFglaS40vcFXjkClrjCq7/cxDm75nq74pJ C0XnMPIR5wiuYheS0AmuK0vRma/LMWPYz+/DW3PBHxSbBBtAh9uXSq44EUnNCEYEG30LQ4WIEyW
 RR+62DfkLLKR8Chs/Ojf/xp5KBOSTk1ER3qliiJGOkvW8ciYQZFX9/rT5ypfKbuuu7RPnQCfDcu eTKtnA2q+lohvBtfUhaUJsCi7HcytY1MMOFP+UN6rsMKI6K27zpwvmW/Ci7sM7D6SaTf/zeMWcV G2CheW2bKKsIFJKDP7WgYBZIIjDKKpF6TRBXRvZ0sPBO+Yf4Fhyh56jcFxsGXCvz5W9EqURxk7Q
 G+jjMbBVOJLfL5f4M39jbaWjbZ/7CeGNdQQDjigMRhPqBPLtkm+q04mKokTxYCWuxt7ooDTS
X-Proofpoint-GUID: lqoLGLy_j6PufSaG3EZxsEVr6Hn_YQRY
X-Proofpoint-ORIG-GUID: lqoLGLy_j6PufSaG3EZxsEVr6Hn_YQRY
X-Authority-Analysis: v=2.4 cv=b6Wy4sGx c=1 sm=1 tr=0 ts=6814ecab cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=wj/iefQKNY9P1RSDfSoyGA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KK8y6wEurEKhoEb90x8A:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=930 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020128


On 5/2/2025 7:03 PM, Krzysztof Kozlowski wrote:
> On 02/05/2025 15:17, Kathiravan Thirumoorthy wrote:
>>   
>> +static int  qcom_wdt_get_restart_reason(struct qcom_wdt *wdt,
>> +					const struct qcom_wdt_match_data *data)
>> +{
>> +	struct regmap *imem;
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	imem = syscon_regmap_lookup_by_compatible(data->imem_compatible);
> And how are you handling proper probe ordering? Use phandles and define
> this as an ABI.


Sure, I will follow the Konrad's suggestion.


> Best regards,
> Krzysztof

