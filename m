Return-Path: <linux-kernel+bounces-835768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2BBA8038
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B7189AE25
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F20A29C343;
	Mon, 29 Sep 2025 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TIHEcR5x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6029B8DC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124643; cv=none; b=mpQx9YYzQNkKRLrftOAIBtu1CDp26pgCvcQjEWjQJonw9AuL5vSykyeNeAM8No5VebZpOYch3/jzzmcXDRV5bfWXpsvQW7M5mrDjIV910c600i4PL1M+bo15oaTjeS7P+r8ao/mXOm1yNzVKejnHojeqdZzKBF6ZSNbC9e++XFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124643; c=relaxed/simple;
	bh=HNiufS4QgvTOpQO6FbL535zp3vDJ1un9gKIOCDv3sjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEG1qcZ5MAgNHOSg3cxj12VHmuvZfmALIdEomh7HqEoxW0l+VNps1lA1/gJdb7zizPmwLV+MqExcoVkFo1u/ac3ltbeMVj+V8KYtURKyMUEUnP6fBe4AFfAA6YuKBdWETOT88LI68T1QBXOE3LndnfxwyExg9+ON1VIVCpzU0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TIHEcR5x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T0AgEN016746
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0shxXdl1M5m67yzuv0GXcdasQMNMQSFmS4e9Kkqn+q0=; b=TIHEcR5xYDni68va
	mvFrbiD3QDfdFSWmiApYHdvRZVAKo3xoMvn7BRgUZyj96EoyHLHafET5Jk1vWyiz
	j8Kiw9bRu4abl1Cd4hFfMrUIwujTUOOz4xgETwjcb3bYRxze4ZzcStp6VEJbBGTZ
	3w15+a4okVTN5AN1oWwH91AV193U8Q3+UIyr3yLd9mrVdcganr+AxTWfKebM/RlZ
	uwUyHsq7fNC4TJVow/cGF47G5uyHUAgt2MoTORl3TvCE+gsLXDoX3hLJ72u0jL+U
	Pvt7hjNYdqpXx/yePxgZbNcnYkES/Q9mG79E7vUFuFl21W3v/HHZD3xbVdPBYluZ
	AeNgJw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mcm8hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:44:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3305c08d975so4451862a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759124640; x=1759729440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0shxXdl1M5m67yzuv0GXcdasQMNMQSFmS4e9Kkqn+q0=;
        b=eAZfoGT7nuI1BPMLwFtoEo9Lxo8JXncTesrDdhe8qwlqxegMf88SNn8i3zISuhiyBC
         OC4d9fFtJVH862koBz7iqBS4VK7mrCwqP5pOdxfgVc3EXf+2briQvis5I0HxqzHDCGk8
         UxdbKkN4Cu6hNlTIxonmjuH+xv4NT/dYssvrOzl2hdc0F6FFbAVhIeP32LEqThMK1rnH
         gYWTkmcXp7ljo1EfXAvxBUXiGKz73Zt48UBXwq4jcf+OeBbLvadCzvRtVA8Afx+HZ+Ge
         2MP7uoOOdhSAoSvh81B3apZ6bDDv5dqRWgxUGNM+bRTRgejhqXzw3ygmMGHw0ugMteDb
         6uAw==
X-Forwarded-Encrypted: i=1; AJvYcCWt9ECj5zpMdtnJHKSbu4qoFsYvXzZb13g8/oLsoaOAGufjIpeOFd5oHBxQxq+evswe5Ux32LlSiCOGbvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxblulDkSNMqvRUzPeXH4we//bL5C2Z3a8AsvvWHTu4lTj0X4
	Tw6ztslreWDpSvnQyS7mM4ZscJZn+nzFgvvudvldJHGtqmdCI67xl90SG5VwcJJqk4E2atENZE+
	DIzcorchPnkqevkXUuU2UzV67UHX5TwUoLtfaJerd8NTRVpnswqbkp1Z5alCVddzF0J8=
X-Gm-Gg: ASbGncs9mCE4fecaUp1XFZq1OvI/Ch6O3azvco36VWqAdeVhMJsiirDtUH03sQeAc+9
	anRo+LQyj6/+EyCFOkXEvjrDzLgy8kBM/7LCJkaHsE+d7WG2oqV03akggg3n6WJFCHXPj5yGuzW
	I7I/2oBOnyfpf6I1lMNekD+qTAMUNohV0iOpEbRpLTAV9dzZbDpjbpVGFKwPphMyuTYJDR2K06+
	/2+LrhTe905bx5kARcb2f8ijliAWYfFrjRCunpDAm2/vhR5ZZDKlOshktarSDvLPWsT8VR8O4qU
	XUKru19VDmVBDJtvT+Xy4P07i/WHUFU8/P8y+gduHLK06cq4GnwBthJ3J9+4uO8IwZsqeELcR4A
	DW+hvZVf9a51Owrs9EoVpV9kt+11+NQdXzxg=
X-Received: by 2002:a17:90b:3852:b0:32e:24cf:e658 with SMTP id 98e67ed59e1d1-3342a22cdc9mr16537640a91.3.1759124640454;
        Sun, 28 Sep 2025 22:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl7IE2Pt6RQ3vYJq5zb9BDkApqE/UvUl6n0SAk0jFAYj2ocsRLqMrO3x/ZsK3UmEKV+StagQ==
X-Received: by 2002:a17:90b:3852:b0:32e:24cf:e658 with SMTP id 98e67ed59e1d1-3342a22cdc9mr16537609a91.3.1759124639982;
        Sun, 28 Sep 2025 22:43:59 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33435b4f180sm6031452a91.4.2025.09.28.22.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 22:43:59 -0700 (PDT)
Message-ID: <65338db5-d255-498f-96cf-bd037aedcc36@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 13:43:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ASoC: codecs: va-macro: Rework version checking
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
References: <20250924-knp-audio-v1-1-5afa926b567c@oss.qualcomm.com>
 <202509261315.O9CiiXjb-lkp@intel.com>
 <e7843f88-71d5-4f7e-9f99-df06630e02fa@oss.qualcomm.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <e7843f88-71d5-4f7e-9f99-df06630e02fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68da1ca1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=H6HILBvNmDOxdPU26TMA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-ORIG-GUID: CSxMHzSBX6lxHGmkWtiMLgvkNt1eSYV0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfXz1rpQygNMfuL
 uiiQma3JKvyx/GgRZ+GP19IpOvCPlZLLv3C+b8optmmu2fbV+njobA6eYetBHCvn4EVS5SX2fxC
 uM9SMVpLDDajg5g0rIW5LAMWnyCNvHeuubOhdYWXzpKIp/JgjnvfSZETsfWIP0qKXGHKb+hnEK9
 LKDbyTZqzWcfwEDiPvKcMb+v1eAVrmRGSd0+wtjXiHMxBwCdkDU9Iu3xEbggv8RK9C+WUEZDgtd
 sX/n+PPw1cb5DSnqgElYO7/d/Jq3m0Qbf9dShExGtZzJUNUArXOlumTIUzDf0E4fgnaRzjbyRgV
 IPQdBWUgNkNPq/euzNb+2OIcjEFGeMoveE91oTYEYsY5Pc2x+p/p/W5d/rC980MHd6CyYiWe8p7
 1RvCatqzuwCylPQcUKI0xTpe3+xRMQ==
X-Proofpoint-GUID: CSxMHzSBX6lxHGmkWtiMLgvkNt1eSYV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004



On 9/26/2025 4:50 PM, Konrad Dybcio wrote:
> On 9/26/25 7:36 AM, kernel test robot wrote:
>> Hi Jingyi,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on ae2d20002576d2893ecaff25db3d7ef9190ac0b6]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Jingyi-Wang/ASoC-codecs-va-macro-Rework-version-checking/20250925-080338
>> base:   ae2d20002576d2893ecaff25db3d7ef9190ac0b6
>> patch link:    https://lore.kernel.org/r/20250924-knp-audio-v1-1-5afa926b567c%40oss.qualcomm.com
>> patch subject: [PATCH 1/5] ASoC: codecs: va-macro: Rework version checking
>> config: i386-buildonly-randconfig-001-20250926 (https://download.01.org/0day-ci/archive/20250926/202509261315.O9CiiXjb-lkp@intel.com/config)
>> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509261315.O9CiiXjb-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202509261315.O9CiiXjb-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> sound/soc/codecs/lpass-va-macro.c:1479:8: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>     1479 |         maj = FIELD_GET(CORE_ID_0_REV_MAJ, val);
> 
> Jingyi, could you please add:
> 
> #include <linux/bitfield.h>
> 
> when resending?
> 
> Konrad

Will add in next version.

Thanks,
Jingyi


