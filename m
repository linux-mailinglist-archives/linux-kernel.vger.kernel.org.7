Return-Path: <linux-kernel+bounces-796436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE7B400C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B903A92D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92B2253E9;
	Tue,  2 Sep 2025 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FiCg9BPE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E309221FB6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816426; cv=none; b=HzLP0Now6iXQqwC4qDq26PFjToXXaWifMO7Df7VPUHWBi1pNwYmJkfnDimD/KHq6Un+04g2mktvxDxfSPSX+LLP5nK8G+GXzgllLlhMWtOQWcS4ujuV4oc4TLFw4P71QvBW7FNHTy6zHvmLkI8o+U7y2j5b+/NBCmtQhdn08BwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816426; c=relaxed/simple;
	bh=kvqOVMR4o0pU7F93TYucrMso0qNifJEbmyq3RetMaR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7ppzdW5krRQlxF5NcV0vwKqck0VKH5bY6XxJd4BrOSDomqGZ5alPg67xSZfPqAaNiYTV3sto3G+Vu4Yy3jDXMpoBrIXB9tv2SB24yaFETem2uKZXwKwuHNEjZTkOSI0NeFOyFraIyu3hwUvRrJW5Y4CGb0hyVi0DAID+MyZseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FiCg9BPE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AsG8Z010112
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ePZTdmUf6KFfxyF2pqsIlm3pu0OeNHUO0L61l+SXJy0=; b=FiCg9BPEpK6x7I64
	7RRmIzepKSW/QHojczkj664kePHY5HOIvzZcEhp0VvJmYYpKFV1Xclh0BYfNH6zE
	1D3DyHLkHD/Ublrmy+LSVnoe+lNv0eBa39xBzrm88qQVKFz6XRivu/DeMg7xvsiW
	KQ3MRPDTn+kq+zTg1WmCEXBobGmCLN08gZdQWvpPRa4GGZmoLHrknQqMTQRbSriZ
	VAOw/LXH4NHLKD2+D0zSLWsRRBUHvLfPz7n1W4Xb9xtPV2AMlrwJcNzjt0gRX3aK
	WHIqh+o1hV1cOyXyGy+YFnNKd/gyC0/92DF/rKEemmICLN5Ln1uBaDHvCFgSVlvM
	/LjrlQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjfrn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:33:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4717565ec5so1213314a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756816423; x=1757421223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePZTdmUf6KFfxyF2pqsIlm3pu0OeNHUO0L61l+SXJy0=;
        b=RVYgeKy5v9Unl7P1/4DXkrJF6nnFHu0Af5peAU9ay1AgU9dHeRdeqLXnyC2Zcl5e4e
         z7x5z1FYgSkrOi9VSoxot0vG/UqV3saqRSsUZHCiF+xEQEeTcq909B60DmyL8V0fRCdk
         LISUMbCATVj2RIPB+LGcciC3hygGjdxK8Xul5fQ7QGJg5cNbfLKPOQnnefq0xDb4i2E/
         a4Wi2Xwvu39Mb9ZJgTnahIJmMJVYMyNaXyWLNvL3E1vBWAtD6Vsj1PCnxfK4HA4Q6l9n
         TfuDCze4pRfIwvYKYAd9z/XCdtdjHfZy8SKqAvThu4Yy0MkJPmawEwfu6Z2+1mpQBjEH
         /OQg==
X-Forwarded-Encrypted: i=1; AJvYcCVU/C7FWnSqu3q5xD7MzhKO+DCWwV0aONWX+CsrXEAKMfordzhPgSmiKS2X411FqRKw0Ik/PQ+TV4+oD80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDH5dK6Bez37PAsGug2NbaRJ6u+uPpTprHLEdOWoWJUXGcqyyb
	Sd4bqkj5AMaFsxaeBXINONvUC066ubud4hzwjuYsQAPVeZ0p0OvR5gJaaS8BtdFhe8lW8aJfuHN
	unxjUNSqR3XG37DAOYWLGk8gcqnG8ovdsl/PzVE8Ec5FV2BAbfgW+AVVgPVyta0fTdVs=
X-Gm-Gg: ASbGncv4iBKT+85jjifsL794HPW8BsYNlVzzXEOx38M2a6unoAK8vJ70qzVqQeICBv6
	AdVvJI4gsLdQVLFGZeRTw9B5dCXGSLLQeUIWwuRXLuuEhFG6z8TzAH47ANEAqYCS7iyI5cI2O9t
	UzlQVCbnKwTxn6eeN7leNARPM6Ed4nT+PLyiYIXobmYm7utkRkbrvzLmn6SEfjsohYsO8o8bCf3
	CRbUTbDUnlOmSTmc8DklInINsHKYd+d3UIXOjwukZUJSqX2/Yhe55Jtpwv5rZTpZr/LPUCUC0DE
	YPEPi63wfMOqOixnSkV1PhPGOrvrBW4x4N8ccLjFFJTVzQsmWDXnExgkt0TE/UwSxe5Y
X-Received: by 2002:a05:6a00:807:b0:737:6589:81e5 with SMTP id d2e1a72fcca58-77232745936mr10198807b3a.2.1756816423269;
        Tue, 02 Sep 2025 05:33:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0JLLCl24/XxHtW1P90wzr3zdEuQgG78e3OMvXqmWWovPD7etmcGpFWIC0dv3MhgBiZkmg1A==
X-Received: by 2002:a05:6a00:807:b0:737:6589:81e5 with SMTP id d2e1a72fcca58-77232745936mr10198784b3a.2.1756816422782;
        Tue, 02 Sep 2025 05:33:42 -0700 (PDT)
Received: from [10.218.41.33] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725f0c4008sm5258376b3a.35.2025.09.02.05.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:33:42 -0700 (PDT)
Message-ID: <31fdcbd6-2cb1-4117-8201-f49c749dd357@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 18:03:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add Monaco EVK initial board
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Arun Khannna <quic_arkhanna@quicinc.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Swati Agarwal <swati.agarwal@oss.qualcomm.com>
References: <20250826181506.3698370-1-umang.chheda@oss.qualcomm.com>
 <20250826181506.3698370-3-umang.chheda@oss.qualcomm.com>
 <20250829-clever-analytic-pudu-96cda0@kuoka>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <20250829-clever-analytic-pudu-96cda0@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b6e428 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=UXIAUNObAAAA:8 a=Xc56VXtM65tYru8N8fYA:9
 a=QEXdDO2ut3YA:10 a=bFq2RbqkfqsA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-GUID: K3s93awb6BxCvY748RaPeHGfpDFlCdAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXyToXK26arO6e
 M9bY22oqX+XKfSRl564UihPcmksUQqAQ3iLhQTHwh3mqYu3NAIhr9ZmcysGkn9cIJrzPBItC+h8
 FwNyv2TQ9JUkAoH95XsYO8p2FxJ36Ycm7c0Oy9W4GxAW48b5EDCO96y5Tf8ntIgkUjZKWOOol6Z
 H7b1zLSWTG88UR0YMFJ28NZQ1cnPiyG10oaiNuyFHMcZrGCEfi8TMohxXLb1GxeX2YjeLUAdsIY
 J+vkU/YS7O+2wEaqJPA5yAxWwd+wwi/ARRz2w75+RlglSrM2XjWVrdqTBN3jZGdnCyXHTCza+xm
 7u/UGn6zG31R3CByhHixQJbLu+xokzNVkiuUz6nbkV6EmsaZ2jsgl7joDMHBqu0lOa7i3AMIscO
 Tb30TDcs
X-Proofpoint-ORIG-GUID: K3s93awb6BxCvY748RaPeHGfpDFlCdAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024



On 8/29/2025 1:29 PM, Krzysztof Kozlowski wrote:
> On Tue, Aug 26, 2025 at 11:45:06PM +0530, Umang Chheda wrote:
>> +&i2c1 {
>> +	pinctrl-0 = <&qup_i2c1_default>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +
>> +	eeprom0: eeprom@50 {
>> +		compatible = "atmel,24c256";
>> +		reg = <0x50>;
>> +		pagesize = <64>;
>> +
>> +		nvmem-layout {
>> +			compatible = "fixed-layout";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			mac_addr0: mac-addr@0 {
>> +				reg = <0x0 0x6>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&i2c15 {
>> +	pinctrl-0 = <&qup_i2c15_default>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +
>> +	expander0: pca953x@38 {
> 
> Same problem as in all other recent qcom boards.
> 
> I heard that some teams in qcom have weekly meetings and discuss what
> did they learn from upstream review.
> 
> Please organize/join such meetings.
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
> 

Ack, will take care of this in subsequent patches.

> Best regards,
> Krzysztof
> 


