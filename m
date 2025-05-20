Return-Path: <linux-kernel+bounces-654891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7AABCE26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 06:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A393BE84A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 04:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6E825A33F;
	Tue, 20 May 2025 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lywcwxId"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52322258CE4
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 04:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747714336; cv=none; b=eRoFXkjKKSNeTD9fZVdfVWWdjm4VxRFMI5jXCy80vnlINwyprS6JC7K7MIlxoOx8xNx+lHoul25CMFYBxW8WyILCWtds8AnUp2jmXLQgoKtsH2EH/qxf/R9c3LQWyMvCyI+u2k9af2vYqogxPsJfaQkBJUFj9T4xqqZihs5wR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747714336; c=relaxed/simple;
	bh=AA5z1Iv12EICjBiN6kqrFqLyeWGwCCQ1jyhoLxGEHpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cunYP65/Y4ABEyDelMxAMr/gJZqZzAoFwN+jcRyUYLBeAc6bo8QpGkkchTVtFfFyOj3IHpGK4+4p3Ix1usAik+A8zVVV0m2HJrGNguktaNzu+6nOTXOWQiui8OyZ6E0BKTl9c6KrkCO2Kjrs1pCt+1IiJzxUF8E1yFLQ8F7vTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lywcwxId; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JK14Zm025924
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 04:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K3tXKNyZNuZQgUCz+o2yPQ/bI2CEVtZtYjF3TqmtdC4=; b=lywcwxId5OmbcrEh
	/CJqR1sA26WgjKj0WAtXnpSsrQwYfBonv/giChvR+jIHajB/VGcR68mBjrdLQ0NM
	cl2NxTMuRbWyqyqm12gPwb+FY0++nlu4jcsU/NwMZw/pimxeUo92OhrlfRiynK/M
	++t0uan5lGrEB+fyfI6D3Mk1cgBdbo8ata8BQa67CDleiLbiZ7G+QmJSr/cCc3DG
	5yztyiOXyaZTQEMa2vT6fSSvr2EfwOwcUPfZpjtd/Tq6N6vgfbTAi9V5KEjSdF+P
	uhYAOSlAJxKKA0pVNfoWgcMFBkOF50LdHMMeotam+IePGjH1Y5LZRwf+0+z6VXtC
	onRlsQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjkypj5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 04:12:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-73e0094706bso7064933b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 21:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747714333; x=1748319133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3tXKNyZNuZQgUCz+o2yPQ/bI2CEVtZtYjF3TqmtdC4=;
        b=sWlHj25bgFcjmAHfi67rWXceJCsk+WQfCITWgairl+HXtP/TGPjgOAN0plBBqdyldT
         4MHvjOAHm+ct1BTY2ME45rOn6kneAYTmcGq4PzQzprPCd50nmIsstEWepomw+fVB9Gp1
         9xEuKTQGwJQNlnpCqySodtxZhQwQzMggQyxeUTPr6uN1MvZ4AvulhIMPqNiNZvHDWN+V
         IikPn0nt9rNzBcWUwkDcHAOWUZGwSaCR8MYTDh/eIYiLY/5JageZibD6nd26q9xYZAGE
         T4PVTyzq1lT6LYlqGne1tCt/+W+a9dGZLhnv7t9g+0twN14Dtu6uv8DwHRSC9AZSPKfP
         y/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbYaiZBNFrwaG3nxvZ2F7eIG+Y5TDbKRwPKbe/DB9NqNOO59f3qIbFfDInIOOkgfh/hysQ/jVCLnB3HH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZ4N4Xx4VQ8jYjX2PhqqLPjJQZ8inY8QWcedwLO8QDcc0waXd
	ce9vE8avvdJBnWuWwEY8La7glo45r3tXLjadj/2gBqupHTMkgG7O4rZEompOS6LjSb8b6oQk+w8
	i17oXYpBidPzQ/9yjRUgjg8gyNF+m7iH7yjft66pZszwBbpzzyR721Ci1Fm7lZWMBQ88=
X-Gm-Gg: ASbGncuQNnQQJ30Ykx9dBR5p1Mm2CBJRoV+JLb7xl6phlnGblx3tyqgYvaJnAQWYd85
	pJAp60LW/QC2QkdEtXgswE+ohYgyPqZdA4lD5TR4SBBKvi2XZ74DxqOhB7dhwOf8nODZo62b2g0
	nCN9qeUaT+MXs6tFJU912xrL5Q1jWvB/OvKyIHhdFhO7zKj86EmNyYjEwJX2YkXE8oEcVO57O40
	W94350id8pImcAe4aDhP0JBCHBmRFB/3lTbbsDnrBX5CopbXkofL9+B5H4WkQeYEtTO3xIBe3BM
	9z9l8ud36PvzudwKo4idhJRFtpjjJDoM8Y2ZTpdaLg==
X-Received: by 2002:a05:6300:218b:b0:216:1ea0:a51a with SMTP id adf61e73a8af0-216219fffedmr22921479637.38.1747714333314;
        Mon, 19 May 2025 21:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECTNHl0XI2RQjqcne0zYA1ZVA00vadeEtwniXUnY/EXFpPQMXaSNaBx2qH/VBg0UrtXPfDsQ==
X-Received: by 2002:a05:6300:218b:b0:216:1ea0:a51a with SMTP id adf61e73a8af0-216219fffedmr22921423637.38.1747714332879;
        Mon, 19 May 2025 21:12:12 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb082c66sm7092530a12.60.2025.05.19.21.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 21:12:12 -0700 (PDT)
Message-ID: <b3d818f5-942c-1761-221d-af7d7e8f3624@oss.qualcomm.com>
Date: Tue, 20 May 2025 09:42:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 04/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
 <20250519-mhi_bw_up-v3-4-3acd4a17bbb5@oss.qualcomm.com>
 <649c2bb2-d9a3-66ce-8bc5-2735195aaa5e@linux.intel.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <649c2bb2-d9a3-66ce-8bc5-2735195aaa5e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I3y1x8INhKzYKMjLlg4rMf4HRndRe5hj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDAzMSBTYWx0ZWRfX+RNhj9hRDSdt
 YW1hkgaecQUrIC4DbgYD5ap3uqAeh0a6EzaWb97G0ewcglGWyX9IEYKYeGviiGpcaKQTYiFS8o/
 0kp+90ggpTOAOs/Gf0ei+lTXPe8lYQB7bctlvl3FXHJkAZckwDlqS1TF5x9uZwHf1yBjeZWfyYK
 HT2uVLLUUm3SQqqjT/fw+5pOph1UHtOAifin0+84gl6x8LeioR0pGRMxPKBKISpEn/uE3XdasVy
 SupQxS/8+zydQpwccR+A6CPwHinTB85Rl41mGYfwLaL9uLSNVWpXrAopLE7qqWR+8vqCuZFUChl
 JSI+96Lv86FyznYJTiTuTaHI+TcamdE6e4ZLuumbvrWt8d8Us34zun6jm+jRRi1jjhhwOAW4heZ
 RRctMMTBV9DAdo82e84aSSAsRCARze33EW/6ws+ecXxAXg4Uyt+/tA4169l8kySgA3htRV1z
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=682c011e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=cbGetAF2pF-RjulI4vsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: I3y1x8INhKzYKMjLlg4rMf4HRndRe5hj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200031



On 5/19/2025 6:51 PM, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Krishna Chaitanya Chundru wrote:
> 
>> If a driver wants to enable ASPM back after disabling ASPM for some
>> usecase, it is not being enabled properly because of the aspm_disable
>> flag is not getting cleared. This flag is being properly when aspm
>> is controlled by sysfs.
> 
> This sentence has broken grammar/is missing something?
> 
> aspm -> ASPM
> 
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/pcie/aspm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d..0f858ef86111b43328bc7db01e6493ce67178458 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1453,6 +1453,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>>   		down_read(&pci_bus_sem);
>>   	mutex_lock(&aspm_lock);
>>   	link->aspm_default = pci_calc_aspm_enable_mask(state);
>> +	link->aspm_disable &= ~state;
>>   	pcie_config_aspm_link(link, policy_to_aspm_state(link));
>>   
>>   	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> 
> I disagree with this change.
> 
> The problem currently with ASPM driver is that pci_disable_link_state()
> and pci_enable_link_state() are not symmetric pairs despite their
> misleading names. pci_enable_link_state() should be renamed to
> pci_set_default_link_state() and if the symmetric pair is needed for
> pci_disable_link_state(), it would have to be added separately.
> 
I just want to know what are disadvantages/side effects having this
change here, we can use same API to be symmetric with 
pci_disable_link_state(). The drivers which are using this API has
already option to specific the ASPM states which they want to enable and 
they don't need to call pci_disable_link_state() to specify the states
they want to disable.

- Krishna Chaitanya.
> I've some (rotting) patches which try to do that, in case you want to try
> to solve this inconsistency in the ASPM driver (I can send them to you)?
> 

