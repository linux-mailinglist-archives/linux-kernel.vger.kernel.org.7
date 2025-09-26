Return-Path: <linux-kernel+bounces-833673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE7BA2A01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87C11BC2C42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914282857E9;
	Fri, 26 Sep 2025 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8+gxCT7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1F27467F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758870447; cv=none; b=iinUC8nsiG4KbuyZusW6sGIA8HoE4B5Ml1XnL12+ISG1ECknQ8roe/TdfeHGhZTSUq32DKrVk42UdqpjL9bTX6QUpdtBA7G/J1SfVXPnA8EyUK3BSz3kNX1aqANv0a8yyxdKpxGn25tljcozqe5JVoLxsT3Ga6UB6APRC2ZlOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758870447; c=relaxed/simple;
	bh=AxaZdK8R1No79fE6Qy5I9BNl3aGBjCXFKR8l7peMY8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6NjiMbF+XCtznLL/jyfA2fAtQmHO8yZsmGRJ/O0H0YjVzZmc20+Poo0hrjGsMiDlj7a36HLCPLMxmG38x2hK5w3icFtcWG4R2WOJpF6PQWNprWJdrrDRJ3h3/jJvpWPQn3PQxnThNN7d16CuJVR1JXmd8S+NQUKRftR8Fzsofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8+gxCT7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q71df9025387
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nazwzXapRFhXWyirBrA7SaFITLf8VA7VA3yOttfzeV8=; b=P8+gxCT7BT+NRCvi
	v+0eEBmZ7jN4+TVgBAJQ19YHKI0Sa1ENMhlSOh9GXoEjyYXf0jyVjBRztSmhj3Os
	ogYYGX3GouNkIp2IAdiiGKYmzYBd4Svtodg5HG0wnjjJXmTTsHlGw8vQx0wVX3Fb
	mgcv1fCUkB67hvvNHzgzixsXUCueX8tExY4/5xht7FYNGnA/Yv6vmtylt2zuf2CJ
	2hKoPO2piPi1xhNGnUa3IxSutm9vcJ7QVDh53ZwKLoUPJQc2z+qG1oW2rc9gpnRy
	uYDukiFMzoJNiQG1+VgsbBSbBlX+2k6/99VLwCRb6rxeDtjqbeAIxVn1OsevSaPr
	VBsJfw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u1sgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:07:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f68c697d3so1458213b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758870444; x=1759475244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nazwzXapRFhXWyirBrA7SaFITLf8VA7VA3yOttfzeV8=;
        b=HmAqUmRsEUNAeO66TsYnX0oZsjTyNM358Fh2x8jS7WD/2/Aq0rWQuUGe7LZqBhUhKm
         7XIX6jdpYdAOMCSRRfcxBoIlavsbiPdYZzRDbfS/Oh9bEArH+yblzMUmqlDoivTPIgEe
         8WZPO1rkX4gjPJuVNv6jKFPhepjqAsAfv+GytZstgzGqt8wJtFIBNatwTAyjY4hkzHB4
         ga8SHhkHhQPflgWG8JcwOvsd8Tt0muN8qRVmdIUaKqi4GeZWmuKFUQ26KnzvyjC71b6W
         MfwL2+AZPR5pp0AJaYdQDO3uk+P3aasje29EXShL+XNgnWk8HIHdCOPsSJw8qDOMkTVj
         Nctw==
X-Forwarded-Encrypted: i=1; AJvYcCVRegYrp+mA3SPUYKbpfD/mTfib4cGnTxuRQNoRguhLhTlMhXUn0uTkR9uzBs+fyc/4tYCWRIJSTWeHUZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXq0SoMH1EanQxAFy6V3dPpaiFE006PgsQYhAJelNhGFohDqKJ
	smUHK/vOdTlS+75SC3UL2270Qd30X6hUt/7byGjI6CpoJtCNxz/eIsDAmBHRSH3myEnl9UyYN6R
	OyAMtJuoYCQzU+T3Bc8R8m2Q9WEFhqyaWgwjt2hOQKatfheHDu3j76aKIAbvLLMiHML0=
X-Gm-Gg: ASbGnctNW+e7ACvSxWQD6dkwp8hmBMa4vjbXjUut6VrUCblNdGM0G1YENjtJ4wnYHs1
	ph7rt1M6trl/ZzdJn1I9Z+Gg145nzuUsZgf3/yeO6g4VbpSuaW2DZH8Uwoax+CYMVp6D+Pvtm1W
	CyKwAVRf9NLEvxn9GKGaagiOphs3VtZzWYKa8wNkEtjSGMfUlY7b6+oyauA0g0qzNoXvA16lSX5
	H6Fgaa9wGQCVDJwYGeoTWBfZW4HEub93CjzfbyCQvsHw2Yu9RqKrHeABJbD+hYu5ipoqU82ZR23
	o6+71GTKnDUkMx8qmNJIHNrjTgX3lzCF/kxwXQ9+BkGKQUlHR1jols7K9Ls7MdqEsoT6fhkbkAa
	PDCWSMeMk3EYobRVvkAighIhQfTZrQvIdtvCfExAgF3P4Q/WKb8FvWow0Vw==
X-Received: by 2002:a05:6a00:2b1:b0:781:eaa:9801 with SMTP id d2e1a72fcca58-7810eaa998emr2582710b3a.24.1758870443803;
        Fri, 26 Sep 2025 00:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyg10xK9jYOsHHo0lMszH8thVw+Soa7Y719quhlAlIVZ3yhfSr4Ayhi+M2wkiXmukMqkITHQ==
X-Received: by 2002:a05:6a00:2b1:b0:781:eaa:9801 with SMTP id d2e1a72fcca58-7810eaa998emr2582690b3a.24.1758870443307;
        Fri, 26 Sep 2025 00:07:23 -0700 (PDT)
Received: from [10.79.195.132] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c8ec7sm3730797b3a.30.2025.09.26.00.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 00:07:22 -0700 (PDT)
Message-ID: <7eb0af93-7cc6-4b1f-beea-d5663c1bbd59@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 12:37:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/24] arm64: dts: qcom: Update pmh0104 dtsi for Glymur
 CRD
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v2-13-8e1533a58d2d@oss.qualcomm.com>
 <CAJKOXPfCFS4UDbN_SejG=zJt1Dt_mtz_p_+MGAaEr5SpK3ydRw@mail.gmail.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <CAJKOXPfCFS4UDbN_SejG=zJt1Dt_mtz_p_+MGAaEr5SpK3ydRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 10Vej2mBCoNePtqVqo9UTCCjFpHy7hM1
X-Proofpoint-GUID: 10Vej2mBCoNePtqVqo9UTCCjFpHy7hM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX1VWs/WNP/iID
 DOs6LIcodGJXekpRVgKEpZPlmwqaTvw7FE+I3bqqPhV06yaZ/U7Mp3jvTnoovwB0lPXY/xBVtnL
 xLS9VZwShK1dP/lytYn+BUq9dpLnZqo865f5NpFf6ACrlU6hPuaDrVHiKcP2Ew6KT6BYi0iz/x0
 /VwnoYVARpVoSTyAT6xB9gvFUIH+S2x61TtOEHY4EuwTRt4ZZ+bhGQVHGta3wiVLrDP5E/dm0TG
 2l20Pz+6+77UMDqf75inHcF8Y4AEkpu1hTdCLue6hcQe3AwVVj4HoPj+boTVNppKZg+sl+AMTtU
 YrUzejRmaAfUHQHTn1NEg2cdFeyTUY/ofDeAwcZPufImeLbNIqq2CzerdnFsPua/OngYHSmB3pE
 20EdguKIb0P5H6aU9vNStaBNgmDvMw==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d63bad cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JSSV1tAL0pHps8jy9LMA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/25/2025 1:25 PM, Krzysztof Kozlowski wrote:
> On Thu, 25 Sept 2025 at 15:29, Pankaj Patil
> <pankaj.patil@oss.qualcomm.com> wrote:
>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>
>> Update the pmh0104.dtsi to include multiple instances of PMH0104
>> DT nodes, one for each SID assigned to this PMIC on the spmi_bus0
>> and spmi_bus1 in Glymur CRD board.
>>
>> Take care to avoid compilation issue with the existing nodes by
>> gaurding each PMH0104 nodes with `#ifdef` for its corresponding
>> SID macro. So that only the nodes which have the their SID macro
>> defined are the only ones picked for compilation.
>>
>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/pmh0104.dtsi | 84 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 84 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pmh0104.dtsi b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
>> index f5393fdebe957ea0caf4bbc16117374b4759bda3..d3ea7486d842ec813a79268fc1466e1513426d78 100644
>> --- a/arch/arm64/boot/dts/qcom/pmh0104.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/pmh0104.dtsi
>> @@ -6,7 +6,63 @@
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/spmi/spmi.h>
>>
>> +&spmi_bus0 {
>> +#ifdef PMH0104_I_E0_SID
>
> NAK
>
> I'm surprised you decided to ignore all existing discussions and my
> clear point in this.
>
> This is neither readable, nor maintainable.
>
> Please join community in discussing this, instead of coming with
> another invention which I already said is poor.
>
> Best regards,
> Krzysztof
Please ignore this series, it was sent by mistake as v2 prior to v1.
I've replied to the cover letter mentioning the same.

I'll update the v1 and re-post with all the comments taken care off.

Thanks,
Pankaj

