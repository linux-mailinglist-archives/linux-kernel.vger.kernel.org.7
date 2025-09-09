Return-Path: <linux-kernel+bounces-807141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697A5B4A09B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B1F17F847
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978BD2EA16B;
	Tue,  9 Sep 2025 04:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgPKZvhZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFE2E2DD8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391727; cv=none; b=ok4plicohYxdt9srrODtDancCwmi8V5ijExqaICTbEqnfjXwReT17MGuoJcfvt+vs5e9XSkmtoz0wtxrGAK6I946t6vQmCDv7PDmwyyn+g6m0SKh4AkA6xTNiz7BF37+p3qSQrkMdi8LoXNjqk+dXPcaIICtVa2wpZHW+mPRVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391727; c=relaxed/simple;
	bh=j6v90dYYiet2HvZxdeUO27siJR1XjbCkPbyzxTjgQV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTbzAihGXQh5TstWC7Pzw5Xi8N7L3rmboiBMkO/l7SQzLV2eHv2laHnm4vgZEJAwh36uq9ihqszloumcF6AEraLRW3UNDA9FI21s+TVQU7W2aysWi/liPFOHqxilbHRNa1q119VQSzpvpv+bQT5gOb7lqaky7SLUz9cZ/l6J79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgPKZvhZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5894J50a030597
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 04:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2RNlYujfUAP11t9Hv/ZiOCiQwfDezWbTlUXZc80dTq4=; b=fgPKZvhZhRZBjyZ7
	7Vbq2I3hMwCNZyN/8VbLNdJRhVWQCcCuC960Wz7Vb8IIJsrJ9F+ALL0aMQBzTCYk
	4YRvVm1p060W+7X1sk5xbO3RDFEwCGrNRzsiyPs4vuMJ2hTs1WBX95RjVDQBs9wg
	chzZAOe75oxBhkEWkJ390Wbf6aruVokZtnTBY1P5vs+zpVGwVAoiFAOKwtE2CIH1
	4oq3KO5fzZX8aAgfClM4g4fCI/ZfMuHoFxqg+EQPcG/yUOCx5JyBfDPoNW4z6gDD
	DMqLSksEHkADblPTr0PhG9W88GfOsi2jcXstb2Ctrs0aqnYC6NDJ7eJCzPfhI2Kh
	tM6OvA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8evgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:22:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77243618babso5151875b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391722; x=1757996522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RNlYujfUAP11t9Hv/ZiOCiQwfDezWbTlUXZc80dTq4=;
        b=Kbb7C4jJzHCVu1gotSEcpzziZL7S/vr4iIpc2bEPNIvAru7sTH05Sg/ny/hDofeUJZ
         1Rr0nm+kyJxES3JE5LDK2+jcQWytS+ZtWISeeW1uuIf8/w9gdXIADA4bjuE6c0XktD3B
         kHNHY7/bo1bU/XwcnhRMhsTmUSPCdeTMDKtHiBsxAGywFx5TJQjxLvdgN0jyKEElcOKc
         /p5EjoN3wBMstybZyNADLNOTqQHYF1mMWw+MUOP+oP4Vv0dIUVFQC11SAhOXmNHOg+mo
         qDG95Gk0r8/Y9LaEGJzc5WDvwHDOLnTosFjdtYIaIJ3jJSAEqHpli9c+P31es8XJHePm
         VQxA==
X-Forwarded-Encrypted: i=1; AJvYcCWasbFKQfTACwGNALE+/l/C9b60ioca8bh56gwTlDrlh66Jy5tAj29vXAYPGbXcpydEPeBwFnTEYgReJd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNA2PSjynYA3Nnnd1oeuNEWbNKWiEayTB05K4i27B+XKmfePfq
	6szIB+xl6S6F0v1K2vrEdApC6Zmuie/GUGWVD8jbZBFtd4YM3TmmdmwxCRsNDHBR+0DsqY62mct
	8fEnchdo26evMXnK5PLBBcHiwfxo2Atue4Ra/+0OqVtTEa8EWXlvqdvuf3pogc9RMLr0=
X-Gm-Gg: ASbGncsGQUC6dcyBqJGJiccdFIKGlFYhsI1HINCeUdrDSreQ7k05loKt/Z4X8S041bL
	kdYPcupUR9ARxEY46sEGo3pPJbDwUoZU7wIsjTNxJpOqaKMk3kTqc8Dlfm0YofGXhD4V+bgwSTS
	Ns+Cgy+Jcyyfho9bXWzgqIYNFZRDE0E3gSCxCfUpY0P4N/hu0ELDoF47SyGQkfxrdRMs0aj1Jjv
	2LrM7qDVIfVhnBwPJQ3avBfPhIdkiOYyk57apUwyrHTxwISYaMTogOljKJw6AgwyTC4Q4ZHU0Lp
	lVOJ+OwKSDoRyjrNlmVKgcJZl3jG/GHcYGcW0nplMzBm9WTHNGqeAxiHu9VDC+av0BHcn0DWFw=
	=
X-Received: by 2002:a05:6a00:2d05:b0:772:6493:7e67 with SMTP id d2e1a72fcca58-7742dc9d3f9mr11891630b3a.3.1757391722079;
        Mon, 08 Sep 2025 21:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKNi7lH3vplxeGbCsFdMO6FWGGFqXVVmUPa3BBSL8XFQGpLBRslXI40zUkoJ5rmhaumi2dvA==
X-Received: by 2002:a05:6a00:2d05:b0:772:6493:7e67 with SMTP id d2e1a72fcca58-7742dc9d3f9mr11891598b3a.3.1757391721567;
        Mon, 08 Sep 2025 21:22:01 -0700 (PDT)
Received: from [10.218.1.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774668f302bsm482513b3a.35.2025.09.08.21.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 21:22:01 -0700 (PDT)
Message-ID: <8d8fe2c8-6b56-43a6-8a28-5150514da691@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 09:51:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] usb: dwc3: qcom: Implement glue callbacks to
 facilitate runtime suspend
To: kernel test robot <lkp@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
References: <20250907181412.2174616-3-krishna.kurapati@oss.qualcomm.com>
 <202509090115.dVhd78BE-lkp@intel.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <202509090115.dVhd78BE-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX3T1BguVEUs6Y
 jgERYaiRUjAc/VZKf51ay0dBPF2aeUTZHuIO4BE73mYsz72SWwZPK178TdOCDLK9Wtlo72Fbikc
 rTMNY5SWTRvrJqg2HtfnhnuDJJ1Qi9WD1zeS0YMb2HoSkRD+aSroCFlodPTI/07jIJAIoL2nrXX
 ECw+LTbtQXRW1E8f2JMigiHPLsqbuKXIM3zFzcx8XeZeJ4tAvDJZ+jyPMhsxKK3tDIdl3gDMXsb
 3/YA8uZCzgf9xIGVSjeZM/3hbRe//hQNYX3GCP3z/kMsl5cU7ChScsgOTahQwXnI/UKxH5Zlazi
 OtAMlhRTMW5mVqadlLuEA750NmlZtCCPYx3aHN4WyVPKR4I68axlBbIyFk1REPFOyku4xwYvIbH
 ovKrNd0g
X-Proofpoint-ORIG-GUID: sP1Zt5qeDEoeFaj2ZctbHbiYdRUwXZt1
X-Proofpoint-GUID: sP1Zt5qeDEoeFaj2ZctbHbiYdRUwXZt1
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bfab6b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=anyJmfQTAAAA:8 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8
 a=X9NUYyb3VNRp4TtMdKMA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031



On 9/8/2025 11:55 PM, kernel test robot wrote:
> Hi Krishna,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on usb/usb-testing]
> [also build test WARNING on usb/usb-next next-20250908]
> [cannot apply to usb/usb-linus linus/master v6.17-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Kurapati/usb-dwc3-core-Introduce-glue-callbacks-for-flattened-implementations/20250908-021710
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> patch link:    https://lore.kernel.org/r/20250907181412.2174616-3-krishna.kurapati%40oss.qualcomm.com
> patch subject: [PATCH v5 2/2] usb: dwc3: qcom: Implement glue callbacks to facilitate runtime suspend
> config: hexagon-randconfig-r132-20250908 (https://download.01.org/0day-ci/archive/20250909/202509090115.dVhd78BE-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce: (https://download.01.org/0day-ci/archive/20250909/202509090115.dVhd78BE-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509090115.dVhd78BE-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> drivers/usb/dwc3/dwc3-qcom.c:605:22: sparse: sparse: symbol 'dwc3_qcom_glue_ops' was not declared. Should it be static?
> 
> vim +/dwc3_qcom_glue_ops +605 drivers/usb/dwc3/dwc3-qcom.c
> 
>     604	
>   > 605	struct dwc3_glue_ops dwc3_qcom_glue_ops = {
>     606		.pre_set_role	= dwc3_qcom_set_role_notifier,
>     607		.pre_run_stop	= dwc3_qcom_run_stop_notifier,
>     608	};
>     609	
> 

I see that the usb-linus is missing the following patch:

https://lore.kernel.org/all/20250729092708.3628187-1-krishna.kurapati@oss.qualcomm.com/

Regards,
Krishna,

