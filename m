Return-Path: <linux-kernel+bounces-852324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375AABD8B09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F29F3A73C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E4F2FB98B;
	Tue, 14 Oct 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENOCMBvR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC916F265
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436652; cv=none; b=B7Cu9sO32PqkTiemf0+G5eJpIvHWLw0hehHnZI50ECUo98Lc68GV45dMFPjG1CSAWZmUGJdr6SmKPVRIDPu6eGJkVb5rkWoBXE67cUZrVpKs3gAg3k5v3aCPFIGwFVIbXo7FRYUb19W8GRhaLtT/CcuLR+5WZrMLEFBKkK746B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436652; c=relaxed/simple;
	bh=6UNxFkPs7S0fth1zlm3KPMvDq2slzrLkx1c/5aAf7/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijTqS39l0/J5JKMbyrOCllelQY4gEFAHMP21bk7BtU9g/FTBYd2CtP+7t/lLddqwEJtDn0e2WZMnATXd986DeCasHGB1Cw4scU6DFhA7GrdOIYpsDloB8YZH9tW2nlf6d1G1u/9eGL30KNmZahZ5b4B061C8eyXSUfkkBonTozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ENOCMBvR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87HIs001466
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+GDf+gAOY9mdDvVU8qCaZ3Le3uxmX96IsgcRA5hA398=; b=ENOCMBvReXNVx7ga
	EOmOXAyXdH53PeiVHByaKn5Kj9ItG2NqsAfiLnOYhYzzWx4blee9BcF02t4kmF1V
	rpN192Yfde/xFzrBfqmsDIOYMdb1zNfWRDZw4AFZ7yU/gDklvhabmz0A86zSctqW
	XLFZILWJbSNltVWQ+DvyvCqzRtg2swzbAa3EjoYA9PfAyjtWBHmKVFiBVT1e01Eo
	/HAgtSa5LWRik0bYhf9R55jn9rgUNXmrrDwkO2trHXRiWo9DEV6ZMtQTZbokyRve
	SCKnXwaHDDMYqJYbzLbxDwhg8sLi7PHvg3lCVk81BI6ghjhO4fnO7QqZLA514ONs
	cRGK6g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa882jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:10:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78117b8e49fso16102083b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436648; x=1761041448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GDf+gAOY9mdDvVU8qCaZ3Le3uxmX96IsgcRA5hA398=;
        b=JI+kdV/tkqlNawKU8rkHNFw+Of1ebPGII2bkXXbqqtHbZrEFEqp4tC2mlKNYEjESyq
         v5V+d06oym66FaNVMQkEuaCN/r0x85knSXI5CfgHiSWYOrZgB9R+p8N5qvcNhZrq6n9H
         s3ZENc+XGpHYZ0J9euovya5U09i4SK7XNveDs76BY/9+9xEa3YpY/UOtiWNZ0nUkApEb
         DlXOJcTPSLwkvnC7nw1lz/lt5SWNCnIMtpjCdKA8a8Q4W3AWShn3hoIrK4PkmolbEbJU
         mZWV3c8YIfvr4GkBJ2QLj8fAeF7mF2haPrfpOLCUyq2UwebWZCL+BhsyISoFNjzgh+0s
         jB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgUNWKfHOPjqxcZBctKIQPcULbNXJ1+vPYkjbd0E4fdQkI/PAk+grMpd3vf+iw2QjAC/PIcCsfKSRhWIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQ83VLPdqwrHQteudb0hGjI5w4xiMcAV+StIi/YTV4jaPv5me
	xyCfAVITcKYUdkb6gGPipurpbRVKCMTSV+dP09bIk+oTZ6chhji+3CmMdjrkXtEkIEO1KJZmWNl
	7W0d1iG5dWXFXRmTRjyA1ZDih+rhYOAQpzFEdsDRWMbdxjiEAvDhci6lHGwnYbfbAD4o=
X-Gm-Gg: ASbGncsdGUYQ0hno9d0kED3slH/7g0LxnJW+Ov3tHrz7BOAz0wFURrLf2Sb4GWrbWuD
	2frHBond7Snebq89kQp2U24xAPYVwl4/7w3jJC2NIR6Tjqbk8AVhj1Gj+vqa/7BcYZgpCM6rvl0
	FEeT1RTyF/+uQ8dm53mXpB5Yq+UpqLzymNiLti+hTbSDVj4k7cU7VQ6L/r/39zTJi3LZWR7GQcJ
	EvNE59kF0+MVrZPmkOEwF4GQf1qoLzu+H5JgS6E1oU0AcqCvbQFsyia9uFY1Lkbjgxsznb83oJ9
	kyM0eKvHtSo/DnHjDEJYglTgYgI+f+WCdL2qyNovpjfLjLopG8GP7b+ejSNGMio6GDPxRhY/
X-Received: by 2002:a05:6a20:2451:b0:24a:b9e:4a6c with SMTP id adf61e73a8af0-32da845e56amr32763015637.44.1760436648456;
        Tue, 14 Oct 2025 03:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4+I2XVu7f/J1cjzoxMqKeCVBL6tL6m/uv3wlVqh90v+MzZWe5SVtdgYsVmRmojAWrthABug==
X-Received: by 2002:a05:6a20:2451:b0:24a:b9e:4a6c with SMTP id adf61e73a8af0-32da845e56amr32762977637.44.1760436647980;
        Tue, 14 Oct 2025 03:10:47 -0700 (PDT)
Received: from [10.206.101.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060962sm14772927b3a.1.2025.10.14.03.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 03:10:47 -0700 (PDT)
Message-ID: <2d581ed7-f240-6b84-3bd9-eadc3c1041fa@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 15:40:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 7/8] media: iris: move common register definitions to the
 header
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-7-def050ba5e1f@oss.qualcomm.com>
 <b7eba4b5-1189-7506-4767-0ef3234fc6f2@oss.qualcomm.com>
 <dzorzudzpjipvlkwik3uylomwi2dy5ticxromzegzgi2jhibot@reqv5ul5ifuc>
 <3802fe42-0c94-8c10-7b6c-6c3adf863ef9@oss.qualcomm.com>
 <t5obao7tm34uilnzoa24shknvdtzqkc5uwek4cxwbof3tgqylb@jehfugyxvups>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <t5obao7tm34uilnzoa24shknvdtzqkc5uwek4cxwbof3tgqylb@jehfugyxvups>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Rhc5wSaGeqAwu0Y5YcAkg7TKKlLTPHX0
X-Proofpoint-ORIG-GUID: Rhc5wSaGeqAwu0Y5YcAkg7TKKlLTPHX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX1IxNWhIMfwrT
 ONpO/kAvh6mL5z/vo/yUsS3UhTfznFc/JEbmIbbNKoLFH6JW2d5RECTyn8Y3Y9Y/U01keMI0Lj4
 rJoCsoQrvsHrVrTf8bp2D9/YgQuk4AvI+6G8F0XBibwIcS6UIBJRD0atOVYtWNS+Y1Sst6YPxzn
 Jvm5NWgu9r5nDLfwPt175+lkH1YtG98nlk6i2r9y6Qky2aKcIGwuAuGl5uOrHM0REpZKslvlr9t
 9J9CGwSoZY6GgtLS07Dj8JL0i29zYTUNU4m4Xox31wMt2XcXEGogCpeeyA7WPDNHR8vvvRDq3mC
 0Nuimjy7oPK7Ol0fKfwJVOrLkLr2bC/rzFNkKNwU0MsIGDYamHHzE9Y7+qnO8lPkZsacLBgy8ix
 26Pg0++hNq/NHUS/FJaMTQZ4bjjfXw==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ee21a9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UHACNdNzX4dSgP2fR3kA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017


On 10/14/2025 3:21 PM, Dmitry Baryshkov wrote:
> On Tue, Oct 14, 2025 at 02:43:56PM +0530, Vikash Garodia wrote:
>>
>> On 10/9/2025 8:18 PM, Dmitry Baryshkov wrote:
>>> On Thu, Oct 09, 2025 at 11:40:25AM +0530, Dikshita Agarwal wrote:
>>>>
>>>>
>>>> On 10/8/2025 10:03 AM, Dmitry Baryshkov wrote:
>>>>> Simplify adding new platforms by moving common registers definitions
>>>>> from VPU 3.x and "common" file to the header with other register
>>>>> defines.
>>>>>
>>>>
>>>> Similar to
>>>> https://lore.kernel.org/all/20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com/
>>>> ?
>>>
>>> Yes, but moving more registers. I can rebase on top of that series if it
>>> lands first. Or I can just pick that patch into the series, to remove
>>> the dependency. What would be yours / Bryan's preference?
>>>
>>
>> My vote would be to rebase this one on top of earlier one.
> 
> Ack, I will rebase. Seeing that none of the patches in that series are
> in R-B state, I will probably pick up just that patch into this series.
> I hope it's fine with everybody.
> 

Should be good. I can keep the patch in my series as well, in my next rev, so
whichever lands first, Bryan can simply drop the patch in later series.

Regards,
Vikash

