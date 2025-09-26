Return-Path: <linux-kernel+bounces-833686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24522BA2B32
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E877AA090
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C1286D7D;
	Fri, 26 Sep 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DzaNUATV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C14276028
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871481; cv=none; b=UGI6RGLG9uWymJ9hCDHbFudpcXNEQQZLzr9itsiEOeC3yfQmlAudljkpoPsc+QFMVquLyXIkG0irT/06aNxWNJD8PhY4R3/NMPgmc6BtlAcpEID3kSJKVOHvJ/2mk4/Y7KdzmY1toCH/GCTM1YytrdPPeVLrvERSyolEEkBDkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871481; c=relaxed/simple;
	bh=c2eu+UL9TCmEp29DV0rCPhXtO/xi9h8QVygQHibyZVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8uAUP6DQkP80jHoKJgGZ6U4WptdTu6WDHJjo3UVuAq9EAIdSIpvAgpjQZu2YB6/lpmdafr93iDNRb8Xemi1L6VOMveWJRD1zbBCgPonLqIW2TvT8h5WnFNM++OIuaMhFU3Hc7EM+du3COhH1Uzn8WfzcmG0G7Qn4a81vGX+Hc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DzaNUATV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q70Grb000896
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xahJWVIETX5BgulbVmZ+wNN4Sel4PSrkSaX8qRSlVNo=; b=DzaNUATVlO1Gg7R7
	FrvPqSJJIGWbwHp+bb3iIjTSqI28zM5DONHQJWFuNRPeWeAGKgq+Ejof3czeF3Wz
	AShaUdVw4iggr2N7363Ps1yU11M1y+B2UuEkC3YEYn+4xJwkEM6CsIXIjinRGCNC
	qRnkb5zKtMegdDELXBEasVDZWRw5rK0X0SEAsSy9cwejgdkOEota6ULJ80NbK60d
	5oL40vw6MakX0YR5+FBGormVagK3lCUZWGsx6RmgbWuqFgOKfw1gWnlkHeOuZ4ZW
	+GMoUjkkTWaWmIU6OurCgXr8hZ8Js4MzlUP635Ef959hpNHahQTdRYizbwMt+TQf
	oS1KMQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0tsvqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:24:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458345f5dso28268355ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871477; x=1759476277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xahJWVIETX5BgulbVmZ+wNN4Sel4PSrkSaX8qRSlVNo=;
        b=PkfaAZxE4jWdfKBY3XG1Qe1VBYEjEb36RG1qecb7eLZfJAjdrPXGp5SMu7MoauGABZ
         2DTvX2RELn/l/7NSc3yTclFRfYWZ5P+w9xcMn5YhxswVF93o7AyWjtTYiL4oUWscOL0t
         2MTKEIeWKR+i+5ARZg+oApnNwjUFBSqufQk9EWkt4nFLrhRUCg09icjHngo7Jfe++31C
         baBBn5vF0xXppKl1NjaZddWigQ5pzLD2ER42BS+/yThIG9mjqEFPyV1wRY0Oe230lOFk
         0mdnxEIUo54gH/DZ/w1V6Bxm81/5AAJoNxIqmDEF+oiFDC1Mo3vl5snH94Q59jPekRK2
         kYJg==
X-Forwarded-Encrypted: i=1; AJvYcCU3ALQ+QjEtforEjsh+kI/YMsbgUXsa82HW+hPVSGdoV3k/hG4ahRTUJlKiRtNyGN0P8kSaaj1XIE/k4Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4yeeLFm6YxSkg7Lh0OpXHj/8qvtbRfgqem3EJTYw2L2gXi0R
	jN9QvFNyr+Rft1dlPLK+NRBbnomhFDCy+hLbnfjS9FfFnu5Odb37JmhscSdulCMixGw5XEo7cLG
	pWwfESNAqEeQDZVyq7v5jhVGNI2AkKGtgBsSxmOs4Hd5Yhp7UkRJIypAkFadfcLsQdUs=
X-Gm-Gg: ASbGnctLApLV1AEywpZV05eNEVO1Db05G/B6rJwba2VLfxIQsHh9AklX1cGW9AWQ3CS
	GAvRuunZtQ6qyAclJny2QUYcMKDx4/9kqhbuVMRWgN+HQR+/GXp8A/kQXZzKXhitU8DLuJXHVU6
	SmWWMFkkSShb/fqYJcIyDPfiW5gWw+/jGQrVDH9UmG1plemYYpH7EE2PWFLyHIwwfQKwnQYF7aF
	F3TvgEoGIjeqjdPTJkUqUTxEg5U/gfV1Qd2G2O4NVYbrABNH+gWuNrzKK7z80+3n7YdJcCX4+1I
	nMHnkOJQ90+2Ok4gFQcAXLy8bPLNfnBzWGvj2WkNqZfeek12WPAYO5PYK+9XlquL0xZW
X-Received: by 2002:a17:903:2445:b0:27e:ef09:4ab6 with SMTP id d9443c01a7336-27eef094bc5mr16653915ad.0.1758871477466;
        Fri, 26 Sep 2025 00:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9mU7hMFwtT2lvjIBnrzMBSX54y4ICW695ZcgZtsa6DZblU9rRmj4e5eTtaAR5LsZo4bmixg==
X-Received: by 2002:a17:903:2445:b0:27e:ef09:4ab6 with SMTP id d9443c01a7336-27eef094bc5mr16653455ad.0.1758871476971;
        Fri, 26 Sep 2025 00:24:36 -0700 (PDT)
Received: from [10.217.216.188] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm45147795ad.9.2025.09.26.00.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 00:24:36 -0700 (PDT)
Message-ID: <b01e5413-c8d2-4e4d-af9f-106bdbab6e07@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 12:54:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] drivers: clk: qcom: Add support for GPUCC and GFXCLK
 for Kaanapali
To: Bjorn Andersson <andersson@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
 <20250924-knp-mmclk-v1-9-d7ea96b4784a@oss.qualcomm.com>
 <ba4vkdcbudvyoj3i7eufd27luhmn6ai4mgkefza6sfbjzfwgp7@rvnpins2bruh>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <ba4vkdcbudvyoj3i7eufd27luhmn6ai4mgkefza6sfbjzfwgp7@rvnpins2bruh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I9Vohdgg c=1 sm=1 tr=0 ts=68d63fb6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=U7xz_n88CXcP0GAGSGYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: hKLRccsZHR3K-n17P0aGSmQ470Kd43fY
X-Proofpoint-ORIG-GUID: hKLRccsZHR3K-n17P0aGSmQ470Kd43fY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX18GEZH2hicie
 PB09bKqNiB3atHl0KSTWpIOdRBHgkfpLjAY1JCLG8A/0vwfbSr6wC6IRwGqXKqqF+qZ/IST3gBk
 jQ8qElF2thKR5AXMHafFt7Bq1XQOC+KRkxgDnvAcf+fi47vl6daL9EtHOcn0hT6DZByQv/V+7Vt
 lPZid6KScjGysUJfRekhQTEVBPQhcKBLcjkDBCMk+iqOXpFD/wyng3zo1i4eXZQLEK/rE/CqSHo
 j4e2ZJbGZe32HE9HQZKvMXyqx6VH7q6Ak+LAN3M7EjTl3yab3VTbDxi1G6wp8soZmqYimVT+22i
 GIQVkvGYAr5ZSQlAoo2vVrKPCNubeVV3kDOvR5zF8z7sXGPY4vOkVaEB0b1Wpr624IS6pAV5KtB
 PO+jH5L4HkTA+HqEWrT5GXk/VhEJYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171



On 9/25/2025 6:47 PM, Bjorn Andersson wrote:
> On Wed, Sep 24, 2025 at 04:56:50PM -0700, Jingyi Wang wrote:
>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>
>> Support the graphics clock controller for Kaanapali for Graphics SW
>> driver to use the clocks.
> 
> GFXCLKCTL is a new thing, please describe what it is.
> 

Sure Bjorn, will update more details of the GFXCLKCTL.

>>
> [..]
>> diff --git a/drivers/clk/qcom/gxclkctl-kaanapali.c b/drivers/clk/qcom/gxclkctl-kaanapali.c
> [..]
>> +static struct platform_driver gx_clkctl_kaanapali_driver = {
>> +	.probe = gx_clkctl_kaanapali_probe,
>> +	.driver = {
>> +		.name = "gxclkctl-kaanapali",
>> +		.of_match_table = gx_clkctl_kaanapali_match_table,
>> +	},
>> +};
>> +
>> +static int __init gx_clkctl_kaanapali_init(void)
>> +{
>> +	return platform_driver_register(&gx_clkctl_kaanapali_driver);
>> +}
>> +subsys_initcall(gx_clkctl_kaanapali_init);
> 
> We're not starting up the GPU at subsys initlevel. Can't this just be
> module_platform_driver()? If not please document why.
> 

You are right, we could move it to module_platform_driver().

> Regards,
> Bjorn
> 
>> +
>> +static void __exit gx_clkctl_kaanapali_exit(void)
>> +{
>> +	platform_driver_unregister(&gx_clkctl_kaanapali_driver);
>> +}
>> +module_exit(gx_clkctl_kaanapali_exit);
>> +
>> +MODULE_DESCRIPTION("QTI GFXCLKCTL KAANAPALI Driver");
>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> 2.25.1
>>

-- 
Thanks,
Taniya Das


