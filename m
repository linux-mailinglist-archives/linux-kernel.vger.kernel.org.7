Return-Path: <linux-kernel+bounces-752861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D612AB17BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6C27AA973
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9111E8320;
	Fri,  1 Aug 2025 04:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PdC2tAoB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7680B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022318; cv=none; b=A5xAdPXXvKqdtBNSyBloy4DtytsjNPDejMntJINb7qnBIA6DLb8bm4WhS2+0s8U9q42ylKElfPXv3OgGEQ9viEsSRNFx0D58fmIw9SjEngPJ0KKQ9+mJDcatMVEsENhG7Gtk2jn8bHvTGXBoK4sLjnOYRKmfr5/AsG8s94rZHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022318; c=relaxed/simple;
	bh=uBlorlwIYp1hcEgGWzhSFeKrBrorhnWYZjy/YHECfXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILtJ46i1YYtr1br7Ilu/uoylA9VQshJmLQ635dbC32UtrGWZb5ixyj2+ZHIfRm0uMMDJgsLHr9N7mcJMep7yJnBlRlLQNW/tRJw/obq2rUF3+oO/7HShyXy8ro/bLKgTC4DizS/CFBgqn9UU/ezZM0tlSpYfeeP8Et8MCX1OoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PdC2tAoB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VNvQgC004992
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 04:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zxRRtXcN5asqDedioHABDaioEx42PozHmsddFvNpWDw=; b=PdC2tAoBbSyWFYWM
	rw5Lpp581108vLB9AQws2QgTh/eSPipVej45NFsUmRGzJ6tFyEXfcmswa88EsCq2
	4EOszvfsXOQnHHcHBVVCFLhQ5BxUlPJNmXxO0S1R2DziK0LcLxt778KCSkBnJJq3
	ijPWIpu7tlvmdkWbEsuPfK+AK62CCG0cUqKYxakY/NAC0NAlYS5xjB74v/py+57K
	HeW2cbobabX4iWoriuZsgoCYy6o82hq20HOE9oMOhDM5fQ6qNk1RTX83D0o06CeA
	fl8r6PuWmEhF6MRwqZT4FMAJlDFv8Qw8AwDxER87Is3Pv5czgIOpqm+O+9Pm0Z3J
	dSumuA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q86ancr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:25:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23fd831def4so9596685ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754022315; x=1754627115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxRRtXcN5asqDedioHABDaioEx42PozHmsddFvNpWDw=;
        b=n7ixy3kq/t3RET5hu/ph0FL5TNqxd4gAhlmH1dKvZbP3g36hg4g2Y57rQCK06ycL8l
         5E2XZ0TqeSji4ulE5lF9t1vc2TTkdWo1yRMc/zSm3VaUHdTWJamxhCqpFkezx+YANLR4
         ybyu71P4nl+uES/e2bIF2xXVv0vWU0cDSmye7pgVVilNDrExtRmJchXZLmdQ9PxHKrXy
         wpY1oFyTgW3lIzCF8dk1Ykc3wiYXi5/wiVSzhOktk28YVcDD0lq/lxtldpJ5mmWud6RW
         TnOJC9WUL3QxcV4hNJeDwrQVOL/XkB03bjfqWR28e2YtTHC1WBUQuSomfR5+N6ZV5O0R
         VtFw==
X-Forwarded-Encrypted: i=1; AJvYcCUkqgiOfknm2NDtAaa0JGkmBcBHZhGIApbClBm4pTVkMLgz8awV8XqGrAiwNnDtqgn9MLZBsN4FlWADoC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyroZx/nzNPTZuuBc38+aX0OYJsPO9/eueWfIcMOpAd6EjQu1dq
	X+UEdy8oFgKd94UAMHI1iffYWc1X3iJutlLh2S4VVtd6oTkv3WKraJ56OBy3OJ2irlFdMYKuSnV
	PMtz9CWPOvY6H5gMxvsllP6+Zx2lc1xaEhfAGlyiq13zb0bUUyLzFYpR/aC0gVYjcRf8=
X-Gm-Gg: ASbGnctDWFa7UV3/ZPvUZzM7/6dNcEeVZ9oTmB83tguobY06z5TWAN1Iut1pOE1O8gH
	bS3w/HTWZ88754UW9zWa8lXuMSlEFuG4R40drsqqB43kvcPrtzCkgOPzDycz8hKKr9ZAUEqQS7/
	nkQ40ULs0Azp2WqK1BxnFKJNpMA12QDQFOtE5tfAkKRyMJdg5OEIzRBP9ZMqkZIKHx4OrwdUH98
	ckSChcfYtk1Ckg2EGGMFhMNbpAccPtEJJVDOgybDwoVvGSeRu0F/UIwXOQGDjg1kKjDeJCGX6eZ
	2J4GF4om8nlmFj1ieHxg3SKTeXlLdU3jMab+CG0i7XY4cwUrqSZ6yU3ACn9PUISlbJU=
X-Received: by 2002:a17:902:e810:b0:23e:3bdf:e3bd with SMTP id d9443c01a7336-24096abfe73mr152706055ad.22.1754022315102;
        Thu, 31 Jul 2025 21:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzY+vcz3mT6FLuRg3s6hOjW8qEGzR7nQiQB6+tGHCmk4xO2hr0y7gSoPjaDxIHjG9/RlVWqg==
X-Received: by 2002:a17:902:e810:b0:23e:3bdf:e3bd with SMTP id d9443c01a7336-24096abfe73mr152705565ad.22.1754022314647;
        Thu, 31 Jul 2025 21:25:14 -0700 (PDT)
Received: from [10.217.216.26] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a917sm31713485ad.116.2025.07.31.21.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 21:25:14 -0700 (PDT)
Message-ID: <2b802703-5214-4103-a1ab-e4c26a18ebb7@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 09:55:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-7-227cfe5c8ef4@oss.qualcomm.com>
 <25uelsjuw4xxfopvfn4wvlj2zgivwbjprm74if5ddwvht4ibfz@yctc2kvfmxyw>
 <8b30c83f-5f35-49d5-9c37-4002addf519a@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <8b30c83f-5f35-49d5-9c37-4002addf519a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAyNyBTYWx0ZWRfX2Zjqtetow6lQ
 WIU3eyNjIhdZa0gJ3e6bWm638AswGMaUngvPPyLwgZF3Ix9uzKxd1PFtdeW4E0QbViXBdLzh+U7
 WgNcnAN/kZHNQTHBK2ZlenSOKb95oLuI55DUB0Y0E4r3ZcO6HC++mGU33IXoYWW7GuqG5xKhtZZ
 4iFShL7QWThvxj2kX8LUw1H6/iRkhzrCAq+cDg/yEbBIJymFw7KKvCmkHtm0/fBlSu9HTgJkSMj
 FmFKhfiqYVSJ5EfzvVHGba5Iuzr4lN7DLaEM3k3p6ouc/HTevq5N/FPgv3sAt2coP/+ZED4l0RJ
 tVHxEfvXjOdtdpG5wNrkjvtTipC5odUoDsiNC+e9ogq3+zGwLqYcaT2ZKhuXxjAa/T+QXfGGUkF
 NO7AKXwiLzYvWdKfeM82DznWFNYotHw1xt1eufWE2lw3o2uI2QXG1z8OLaFwzgo0obx9uU07
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=688c41ac cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=-exJQLPiCZ_865CLFvcA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: UHuNXO_ffQ74eu8CqvwlnZuuDiZD_E6-
X-Proofpoint-GUID: UHuNXO_ffQ74eu8CqvwlnZuuDiZD_E6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010027



On 7/29/2025 4:19 PM, Konrad Dybcio wrote:
> On 7/29/25 12:48 PM, Dmitry Baryshkov wrote:
>> On Tue, Jul 29, 2025 at 11:12:41AM +0530, Taniya Das wrote:
>>> Add support for Global clock controller for Glymur platform.
>>>
>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>> ---
>>>  drivers/clk/qcom/Kconfig      |    9 +
>>>  drivers/clk/qcom/Makefile     |    1 +
>>>  drivers/clk/qcom/gcc-glymur.c | 8623 +++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 8633 insertions(+)
>>>
>>> +static void clk_glymur_regs_configure(struct device *dev, struct regmap *regmap)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
>>> +				       ARRAY_SIZE(gcc_dfs_clocks));
>>
>> Why are you doing this manually instead of using
>> qcom_cc_driver_data.dfs_rcgs ?
> 
> I guess that has been merged last week or so, so yeah, please rebase
> 

Yes, sure I will rebase on the latest changes.

-- 
Thanks,
Taniya Das


