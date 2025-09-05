Return-Path: <linux-kernel+bounces-802120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C2B44DCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC4A1B27284
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A04283FF7;
	Fri,  5 Sep 2025 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vhm/v+v6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9915E5C2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052153; cv=none; b=bBlgQ0uhTQ255gW+lMFakvYJwrn+uHk9Lm2PxXLJIdOihnE2kx63ljO9BO61flV8uQ083KIoyRB7Ds+dXmz6tQgqHCLAMdmfsOhyHjDqjbo1B6qCK5unC2QuITk9rp8CcspyVlrIsx5TgDkhl+bJAzXGI0yk3TI5ooyROLr2TJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052153; c=relaxed/simple;
	bh=QOXC0C8/WIz2fz71+bqj9GlO9PGqMtUE8hOOjvW1hgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5dLrBdxpI2VCtu8ewgQTMJvcww2FqWN6bm/qSpHajOppVp02RJiB0RqkzDLju4uN5HhLSzpLLwTwlOp9isibqCK5Y52ipxaDKAHswal/WZsvTeIqB0AZzg47/qyMROudu0FRhNyWoi3sret1f/H77Dbd355yMWfsQgxV+KknCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vhm/v+v6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IgG3C007841
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 06:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qZH9lIF3fgvVGyAHWF02tecHiGxdQTdnkW7mNs/prpY=; b=Vhm/v+v6rR1tjOgT
	wzZQmtsHZjHlJQcCprf228A3ZzKGQSs5wPg/6w5MuAXxWpcfT+p9i1nG0vMzxdpD
	WEL4/6ksoLK9VqD9bk2Q80qfiCT+vobtXGe1D9m6iE/niJR+soXwGUApKCj1Xzdq
	1hfI3AI9ToQ+2VUbZAkCKKzfgQzavsu00/q+9gj0uHT0e/24X7lXrgW2UWjebpZb
	7e7YWGIxtcpY1cEiSzo5IY4WLs6hDDW9unQ43adD5dEiJmlBndJPyjC7X9HhcOzr
	p+ZApsel3t8C6jvphFsdnzOox/dbj7gxKy58jW57bdtJ0YN6HSkaCR0rSbWAkqjc
	JpQ6Kg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura91wwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:02:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ae30bd2d0so18630345ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757052150; x=1757656950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZH9lIF3fgvVGyAHWF02tecHiGxdQTdnkW7mNs/prpY=;
        b=WFpqpjeuWYJCf4IUL3JhPusJQyNlHZeVO8yB2yPQ/pvSckNWYrc9FP1T8PJryYR0Ix
         O6DFPUsgSby1U4Fh/cg3pcN9xsaLVeHdXG1SVSkYr/8KWdj5S+2q520oRlEHsPzoL+Zn
         MZoT1XXY6CpXiCF7MP1Rj6Zz58mFOL/yUqrpmrw5+fDWu6V6SZawXtiIBx/CVWKPPi00
         fLBnOMftJf6zCIAJ+BjMaPRnJ6eTf1fk0x9rHgHyLZBOUvOdurXC9odmqEy+jbUZyWj+
         FskRqAYxXmMZmKmJBuGN7NCcC+KZP3W9H3Q2x1kElWyYscY6dpCZMIVCbMRnIiMCjOxT
         9OOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSdC75kkfAYMIXPRd3/KJuQOLn++W8yjN9c1CcQlUXN2dwwwYsUgWuc+onKzbJ8jcInkemjAoc+zrkm9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiRrVPQOn4e4z6RF2doaI0wM5ArSbsQS6zH2TgjOhSAwDZdo6
	D+9Sk/BGGK6QYJxOY1i0x7tjWOUo9QDzcvIfX+i30XEKw+HEeS6dyGe2ziLEFpEydwnxh2fyZil
	f2CzaaKL7mXrzyqLL35C/xqC2o3lZuBu6e6vo3BG6pNIWx1ANFTBBBjpugUD/p693SqM=
X-Gm-Gg: ASbGncumfwCST/h1vh3yABUWrHa97Wcd9BJrNYCwRai0r5lpKvWHkivRi8Skk0RQP9M
	t6g/TflyGy5QrT25SFUPN6L+0FLTYNqer0hFjo9XoAmWBQLXEnLugKJppCVNJVTk4V2/zFM2KZN
	6ImsKMltfmesvfV3O4o5bFqsGCkgAfFHtYO8RuCYGC8tepy3G++IXyAzUJSgrSGJtMhOmFALm4g
	C+vrSaFi7BCpfhAytW+iQzz7U5qrzsDrMPurCDOlL3GBOTNuk3XmD1AeM4Sp4lDNtOt0mGoPhtS
	aBLKD9vthRU62OAsTajmx4POZ6FeqPh7BOSjVJNa7pXNLSQ9LPrUAP9AiHCJLZXYoh1X7bF/qE+
	8svdn10mlIXgC8JRfJrvc3hhoyAqxK5hB
X-Received: by 2002:a17:902:ec87:b0:24c:cfcc:1743 with SMTP id d9443c01a7336-24ccfcc19b2mr50067475ad.58.1757052149611;
        Thu, 04 Sep 2025 23:02:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSYQh1zkche1JAhu7gVqowdhWZNvXsmqj3qV6HkBZmo2m97d1DJLGAJgibALfxfVc6L7PnqQ==
X-Received: by 2002:a17:902:ec87:b0:24c:cfcc:1743 with SMTP id d9443c01a7336-24ccfcc19b2mr50067225ad.58.1757052149175;
        Thu, 04 Sep 2025 23:02:29 -0700 (PDT)
Received: from [10.133.33.61] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cbe170977sm37480055ad.42.2025.09.04.23.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 23:02:28 -0700 (PDT)
Message-ID: <3f563a3f-08ac-449c-9d55-2537f67cea7b@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:02:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250904-hamoa_initial-v9-0-d73213fa7542@oss.qualcomm.com>
 <20250904-hamoa_initial-v9-2-d73213fa7542@oss.qualcomm.com>
 <2o2ypmxo6wbohrb5edkj27ueqpgbqhsnqu4ofzfubtfwg7vyri@mdsu4ca63fr5>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <2o2ypmxo6wbohrb5edkj27ueqpgbqhsnqu4ofzfubtfwg7vyri@mdsu4ca63fr5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: is2FJC3JDxN49yvm58wrPrlobQB5c5lx
X-Proofpoint-GUID: is2FJC3JDxN49yvm58wrPrlobQB5c5lx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX8vyS7pOXypH6
 1pLxMOIx2X7b+2WnT0K+EPj663/WrxXrDMZM8lpJxC2h7v8XLfqZLibtUYVS7v6/Wb4JBWqbTnY
 27seOFRyBOe7cmUoDQfdgKVIzGyQCc+nEu4wcQjnAV73KFRpP9KUN4lMK+39I22b3aWFr0xSi65
 kR3gwPpPW9Sr6XyFrSR03+P9hvzxh6znOrvIprIe2jgaNykhDuzzIoGz+CGUFk0oegbgC5VSZgx
 pICMaJ5SKdGwE3c6fmLsb6gbiOHesIVpr0RtPdGPY53k+o5M65hDES7ngSvrsAiTc2ZaznziDHZ
 5Gk3SZ2geZrr/sapw0IZrTAuIuAgZ2mBGVszz/2QKeTfDUZG2dC+DmA3ie695BDr2Ch7garbsFp
 7jcfN3TP
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68ba7cf7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DGOirDVRF9kFrzJQLnUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020



On 2025-09-04 21:52, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 03:48:33PM +0800, Yijie Yang wrote:
>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>> on Chip (SoC) — specifically the x1e80100 — along with essential
>> components optimized for IoT applications. It is designed to be mounted on
>> carrier boards, enabling the development of complete embedded systems.
>>
>> This change enables the following components:
> 
> Documentation/process/submitting-patches.rst, "[This patch] makes xyzzy
> do frot".

Will update.

> 
>> - Regulators on the SOM
>> - Reserved memory regions
>> - PCIe6a and its PHY
>> - PCIe4 and its PHY
>> - USB0 through USB6 and their PHYs
>> - ADSP, CDSP
>> - WLAN, Bluetooth (M.2 interface)
> 
> No, you don't. WiFi and BT are not present on the SoM.

Will update.

> 
>>
>> Written in collaboration with Yingying Tang (PCIe4 and WLAN)
>> <quic_yintang@quicinc.com>.
> 
> Co-developed-by, Signed-off-by.
> 
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 609 ++++++++++++++++++++++++++++
>>   1 file changed, 609 insertions(+)
> 
>> +
>> +&usb_1_ss0 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss0_dwc3 {
>> +	dr_mode = "otg";
>> +	usb-role-switch;
> 
> Please check with Johan or any other X1E8 developers and make this into
> a platform default.

Sure.

> 
>> +};
>> +
>> +&usb_1_ss0_hsphy {
>> +	vdd-supply = <&vreg_l3j_0p8>;
>> +	vdda12-supply = <&vreg_l2j_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss0_qmpphy {
>> +	vdda-phy-supply = <&vreg_l2j_1p2>;
>> +	vdda-pll-supply = <&vreg_l1j_0p8>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss1 {
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_ss1_dwc3 {
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +};
>> +
> 
> The same.
> 

-- 
Best Regards,
Yijie


