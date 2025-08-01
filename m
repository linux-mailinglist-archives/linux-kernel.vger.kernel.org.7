Return-Path: <linux-kernel+bounces-753064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C374B17E49
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6E74E62C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93320F087;
	Fri,  1 Aug 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxIVFVQu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC25218584
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036892; cv=none; b=KuEyom5GGRs+vuuvspHpWuypI2V19YSVnN7/PgkoSODJajN5sTPsLpQjxx7kkqCIAuLZax7MTHnGKhm+rwf7hsw0+1Pt99W3mfX4fm9d0JyNlLDqmhyky8Izd9dbFHcN5yz3yaMH4u2k2YyZfPzYRbUVg9dGux1IbSdiJ8Mx2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036892; c=relaxed/simple;
	bh=n21FYt0R2MUIO2Qf1PzQwL42JjC+OUvtksC+UTS2eYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDg2otNuOk8I6u5QNkelVN2EGsVVcnlOjd1vkm9QedhxK8Ju0KTBXbstkdrLWl6aaB761PJScRB1DY9NFadhpFyuBafZ104loj+hY50P540lX2EZY0ZIdkhSA2dk7YjCGB8P3B2rwI5dNsm4jctmbq0fex69s37J8kxoLstTNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxIVFVQu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5710ZLHA031981
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 08:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	maSw2CmMyXYMAvKmdoOc+yYzrI3pcEaJZUjifnEuM/o=; b=BxIVFVQuqV0jyujy
	yHXB+wfkRrSKT9aqMVbG1hqlQELgHhIU31sT9BQBmkigZh8NjIwCOHnODCmxojIY
	Gfy2ZJPhYzSTY3CRBhu9ZbavBhYXZa8QcaqBE2pfcfjfvgbUePgFM1I7cMpPt1tw
	zytn4BNQ6goS4nTh1UZ0W7CrGekoKs8dbm2Ch9fQsgIC90gKTCj4Wb5MSSuoD0+N
	tKHXl/Q7dpaHp5IFWzq8rcv1U33Pd4/W81yOWNiH/bK3MvUH8eYdkxmVDr9ltYfM
	nULozSQZwOj6UluFGaBsoZrYYqmNp21Th9zb9KOAUvMs3iCZtXgoaSZZyNGoaZxz
	r9WgIQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jweyfd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:28:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24011c9da24so15962295ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754036888; x=1754641688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maSw2CmMyXYMAvKmdoOc+yYzrI3pcEaJZUjifnEuM/o=;
        b=X5HNOUU5UUPhBZ2RhDHTqlwYYtDx/JIxWFzesuzdEJhvPhd0dcScpSQDtwQ307vsi+
         iaHW1fLihrDAjLwo/P6GXHUgMJW20sHzrrLl6K4d2rA7sRVNXDLt74XCpWGvYZl6fEwv
         EcgrnKHftJ12U5ZqklSh35zw5Xuaoaprso5xOop82YjW7QbYm37ECGMpVeXP/35JtLq2
         XpS5FTlj6b5qx+SuYAG8x7du+pRMWHjOJbR2n+J3f8greajHoC+nOMvWywnOFLUSJHQT
         WxViMSbsMX/436WkVmaCLjkHCIYcIkmqEUgjYtWtRQpXww/QZ2iiXHI56wvusgN8qACo
         16Ew==
X-Forwarded-Encrypted: i=1; AJvYcCV4BCxHbGV+vmZ5nbiM2U+J3KzfUymHRjgJWMzaK5HkoRuGeiSYl2m5gcAbQiv652OfbCYh+6JF7CmvxDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHUo68dZGtrqjDhwt/yH8mro5GIzRwrLzFmSvqUJaD8VIT+OZw
	BqxU8DY4PlSidtuLAunYwcdrvEz54WCoYvybIsgQ9rcR/CLH3qkNG/KqzGothJqHfHArw4LimE0
	h/Eu2r0EOMc5lWja8Gg0dpaSeQOdmv3bfb1pRaOt2ClXsEluzYnXhbOr7ST5obGSmlDc=
X-Gm-Gg: ASbGncvdy/7OptLwqaaJ2JeOQ5DBT/4PF5pLn1TN/TfAkYGhXm5O2Prc2nXdd7xQlEn
	FEpSSnQTzpXWF9s5YasVMjTGytf89gqo4pBgrb+Y9Qo/0/5B2LchhInkexHk/iw8+kdyEq0vUTL
	dMFq4O/PYWNzn4N8DW3RehjIFprAsKK0PAGd+eU+mEnOGY8kuBrfgzidxcnHl/UQIL2QjkmRLB9
	YrRqW5wCNtI8LUjZNHJiYxtVT7yuYvPWhJ09oDgkZy9zioYSUGTT0qfNoCmYMDqPObDkhNUZEQK
	rMv8uekC3snTnS42wc63x2BviVFY7Xdy7bHPKUdRO81qLuba/nGrmdp4zbFA7UXGoHgBhf5l/A=
	=
X-Received: by 2002:a17:903:283:b0:231:c3c1:babb with SMTP id d9443c01a7336-24200b0f9f0mr71691915ad.18.1754036888079;
        Fri, 01 Aug 2025 01:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXzVMpoNTOUr+QJdVXJ84SNHSBTQYxIJbq36BDLV4wmlovxf8sqtvX2B9vl9qw1lN1AHJg7w==
X-Received: by 2002:a17:903:283:b0:231:c3c1:babb with SMTP id d9443c01a7336-24200b0f9f0mr71691545ad.18.1754036887597;
        Fri, 01 Aug 2025 01:28:07 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a3acfsm37009225ad.146.2025.08.01.01.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 01:28:07 -0700 (PDT)
Message-ID: <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 13:58:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hT0bJIwt6H4sybs6qSEl81H78IN2B1O7
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688c7a99 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=9P8yD98ns4tQo_T1VPoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: hT0bJIwt6H4sybs6qSEl81H78IN2B1O7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA2MCBTYWx0ZWRfX4sluENBoTEeQ
 ky6MjANA2EfSH8YxonKub1P0onbqQmkdFMq73DzBXKErftP3wC10OoUn9zxbAWPU/7P+q16ufif
 2+RzWiUTMs1fRCjbeSeqRG1NqCCON9J73TD2tI6mFiO2p7fLEfSWmn/Q8c7sclTNtGVEnhSF5xy
 Pz6IQj3gdEpUz8OgjKG81IkQApHdCqC7+3QXkJHEVY1QMtuc5u5AJ6bRZ4CJzoXwmtsi/EwrJb8
 4EcsyvRF/2GIRCDVsSt8jNwtJxGudqHuiCSKLUzEvsWToDJjMuZIple0QskpYrbspkmKT+AXQE+
 pf48j6j8/hLvUCipjw6hS3xkwjXNcphXkwBx0EiguPusoMDzj1mw/ja+jqH+B9Uf4Zvh4TpB8Mc
 WeoopqJhepHDhT0koBMCj1zXm+1YrjCZEqOt7wTDRWFICWeVdPlGYPcqz5qojV6fV5mKJtsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_02,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=800 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010060



On 8/1/2025 12:58 PM, Viresh Kumar wrote:
> On 01-08-25, 12:05, Krishna Chaitanya Chundru wrote:
>> Can you please review this once.
> 
> Sorry about the delay.
> 
>>> The existing OPP table in the device tree for PCIe is shared across
>>> different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
>>> These configurations often operate at the same frequency, allowing them
>>> to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
>>> different characteristics beyond frequency—such as RPMh votes in QCOM
>>> case, which cannot be represented accurately when sharing a single OPP.
> 
>  From the looks of it, something like this should also work:
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 54c6d0fdb2af..0a76bc4c4dc9 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2216,18 +2216,12 @@ opp-2500000 {
>                                          opp-peak-kBps = <250000 1>;
>                                  };
> 
> -                               /* GEN 1 x2 and GEN 2 x1 */
> +                               /* GEN 2 x1 */
>                                  opp-5000000 {
>                                          opp-hz = /bits/ 64 <5000000>;
>                                          required-opps = <&rpmhpd_opp_low_svs>;
> -                                       opp-peak-kBps = <500000 1>;
> -                               };
> -
> -                               /* GEN 2 x2 */
> -                               opp-10000000 {
> -                                       opp-hz = /bits/ 64 <10000000>;
> -                                       required-opps = <&rpmhpd_opp_low_svs>;
> -                                       opp-peak-kBps = <1000000 1>;
> +                                       opp-peak-kBps-x1 = <500000 1>;
> +                                       opp-peak-kBps-x2 = <1000000 1>;
>                                  };
> 
>                                  /* GEN 3 x1 */
> @@ -2237,18 +2231,12 @@ opp-8000000 {
>                                          opp-peak-kBps = <984500 1>;
>                                  };
> 
> -                               /* GEN 3 x2 and GEN 4 x1 */
> +                               /* GEN 4 x1 */
>                                  opp-16000000 {
>                                          opp-hz = /bits/ 64 <16000000>;
>                                          required-opps = <&rpmhpd_opp_nom>;
> -                                       opp-peak-kBps = <1969000 1>;
> -                               };
> -
> -                               /* GEN 4 x2 */
> -                               opp-32000000 {
> -                                       opp-hz = /bits/ 64 <32000000>;
> -                                       required-opps = <&rpmhpd_opp_nom>;
> -                                       opp-peak-kBps = <3938000 1>;
> +                                       opp-peak-kBps-x1 = <1969000 1>;
> +                                       opp-peak-kBps-x2 = <3938000 1>;
>                                  };
>                          };
> 
> The OPP core supports named properties, which will make this work.
Hi Viresh,

When ever PCIe link speed/width changes we need to update the OPP votes,
If we use named properties approach we might not be able to change it
dynamically without removing the OPP table first. For that reason only
we haven't used that approach.

Correct us if our understanding is wrong.

- Krishna Chaitanya.
> 

