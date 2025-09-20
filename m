Return-Path: <linux-kernel+bounces-825435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B2B8BCB8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD11C05748
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78B518BBAE;
	Sat, 20 Sep 2025 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WhLXEWJ3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751F2110E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332219; cv=none; b=QNKYrfGq6RjCGbBcD3N6wVrnPGwU6ZLEeh00J+lACxFjgQZtXZzTIStR0k55bw5nRCjgM6MeCx7d5nInTyRdqngwIYRdSR8TxtRdI60g9+9Yiv4w0FmvbMA86O+JIhveMhNYL5/uyF0hTBcFXUgoPuhBXdR7Ho8hV3rJlqe1H/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332219; c=relaxed/simple;
	bh=j/4mFTzJgP7tkepcmSvCE980zmNsx+gHpYQJXuEh5Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toMqXyBYnvM/yvHz3/4WCCyI/pGpNqqFjsECEBAIjrPZ1Y+P44EKtIC7O0FTKH8l9JWIS9DXHQ+kiZCIoeY3fRZkmsDTEDZAqw8y+b81CsofR1+2yqTWC+SsU/kQHY5eGTBAT8vHtxZuWr11tKWIUd4foOHTucQOTufgF844xPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WhLXEWJ3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JHV8TL013449
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	44CzTWg1c4dMBWiv6waWmGCSk5F+vWUs1TNVMk9ImRA=; b=WhLXEWJ34UyiwkE1
	19poSTDWSPQagduthwL76YKoRERF4FxTHgqpnQ4byKZtVf4rU1e045vu7IBbPkeQ
	PHo+98TXR5hFVZAZws3uxpPXGXKDAmKZ0IptbDOpNyUL9Zt5GDxW6yi0TvQBZICx
	RasrQ6uFj7eGZcFj2XGgX7hP+Ae8ilerG1nqQhG/fDweLPotknC1LL8mfDpWYCax
	gnRuvoOk5ZtDa9wZfWkO0aEadFsm4qUCuw+so7wRHYrv3odzikDRIlGLpKNiUN2w
	bbODqouPH7ThK+O9SN3OGkgmRbJ/VsGXu8/ZeT03XRrFRLhhK0e07CmP6YnYVo/C
	1YUpLA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499bmy12t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:36:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54a2ab0f2aso1867873a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758332214; x=1758937014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44CzTWg1c4dMBWiv6waWmGCSk5F+vWUs1TNVMk9ImRA=;
        b=mOl1Q8azgJRjLiAy6qnu7iknnwplbDpTVa2K7S2/ZWfazEYd/3gaCGt29DlUyvif0p
         JL8yUcCqSLUAJhjB8iiZxzjR61nD+UPTqK75OhNQGDK/kIRf5kpTBSMPPHw41CDWzTPU
         9OGw3A/L6kKeNOldAXXTE2f+G60PvMc7fmd/s9ScGXQp07Nj7i4/hlLAqj3vHINFchTX
         u3Q0Ga1Ud2Hwlj9nu3f5hHtCGgiEBZOKYgM1XN8264RnV5729JNQ3fvytudcNje3+vUe
         FUsh4RvWz4lnfTb8DbyLs/+HYFvg7J9Sy4d7oCoIHzkDZAFkNbUWBVq+Af4QCIiJcn8g
         zJew==
X-Forwarded-Encrypted: i=1; AJvYcCUy3p/z7L+CQFKdTKoXJMO3D3uF3mqCVy/fA6g9IPyJDmgSpm561/c3qBX3n5J0y2xeCCvHtvkfetKu4hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2pBi4Xe/obnCJUisbUvWdYAPLe7rr0ryRevUt4r1ZEelNG7A
	6bPSSm05yLUJS+v2yzxxLt4A9/jS+ANXeRGaYWo20fo0J2hhU2CUXIauTarQ0Yw0Vh9mFCQ3BlN
	zjc1SaPz15jy6Ww+/SI2+WBCBxUuyuzqaszGKxmL8EuTBtUJ8T4IkhyPPR/nAcroQKgk=
X-Gm-Gg: ASbGncswbaMj9XS3YBwe5bA/5Vk2+A+PLmR1ejlTucCO2sO1Hsj0YeEJW9h0O1GIReB
	TFKzqd/S4bSvWaLkgHq3JmoA/0qDQEh1bxKKWavAOZHDFYPS1OiHAH+UtyPpPJiTHqOp9DyPBud
	KBWyX+vnKAPwY+DTvNUfGewIgIkoXbSr1Zex+rxTiVjIdC0LU4ZlkuS8eO2chL2HXJON+HgrP/L
	S0TJa4H1QvlVY/Y43iu/EjcJhF1VqM82X1/H1TyGYdBGxv8p3QyUXv4KO/VdG0M9noHJnQbXQN9
	06a5xioaKFNX2KQ9gPQn/lLk0JZtLoa/+DybTJmvfdTS6UTK7FpvCCXLK95IYamyseuoLJlXR6R
	m3YtNf50F7s1HwpxPGJoM3S05CovE
X-Received: by 2002:a05:6a20:e210:b0:263:767c:28d7 with SMTP id adf61e73a8af0-2921f140ee8mr7571590637.30.1758332213550;
        Fri, 19 Sep 2025 18:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj4mV+QNnbp3eYM/r8Q93KP7UgEreeNVPgSHMISOG0LbCHYSX5DhqDcQD0i/Jm1RbPOGLIKA==
X-Received: by 2002:a05:6a20:e210:b0:263:767c:28d7 with SMTP id adf61e73a8af0-2921f140ee8mr7571562637.30.1758332212932;
        Fri, 19 Sep 2025 18:36:52 -0700 (PDT)
Received: from [10.133.33.68] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55156734a4sm3845689a12.4.2025.09.19.18.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 18:36:52 -0700 (PDT)
Message-ID: <ebbe2e22-e094-4d3a-bac8-b6ed8a8e1ef6@oss.qualcomm.com>
Date: Sat, 20 Sep 2025 09:36:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight: Fix data arguments to coresight
 enable/disable helpers
To: Carl Worth <carl@os.amperecomputing.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Jie Gan <quic_jiegan@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <e1a2ee99-07bc-40f3-8742-a0cb1c273350@oss.qualcomm.com>
 <20250919174932.3490404-1-carl@os.amperecomputing.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20250919174932.3490404-1-carl@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b7gGprfUai4D-uHmSuxuwjcnrOeuH4a7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDE2NCBTYWx0ZWRfX1NEAvt2zX/v5
 KUB+iUAwmFFvQ2qJJ3e48mzenJMqZBPLue71hWKJczyllC5ZO9AHolndDqgN3ePg9hmS5ECp+o0
 xXDgRL2RDX5e7ByRQ7lkUPbGQV+Lq4+Gu2J4sHRvFq1KvSjpn3GRkIhe1qWxlTS451zTsiMqAWr
 cPynyeq/RN4+iwToXxvfdJOFjBcv6WDrEjRAwAWinI85rJTs+E7z+RE5twrCnSl7PPuo7wezZi6
 eeW2M0u37x7+17Co/Q7+ljFSPMenkPJYQ+upui5du27gsUC+Wb3IR1pAE5HPuJXubPcYGkfufcz
 g5+nLhWotr2vj4A4q7bwW2f6joUnRW5dGlB/u0BiG19hRtVFov3CxCv5S9AlBZe8zhYCUiiitDj
 2RsxYK3F
X-Proofpoint-ORIG-GUID: b7gGprfUai4D-uHmSuxuwjcnrOeuH4a7
X-Authority-Analysis: v=2.4 cv=ftncZE4f c=1 sm=1 tr=0 ts=68ce0537 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vzhER2c_AAAA:8 a=ScZMK1ZTS-vwp2uqSIIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509190164



On 9/20/2025 1:49 AM, Carl Worth wrote:
> In the commit being fixed, coresight_enable_path() was changed to call
> coresight_enable_helpers() by passing a struct coresight_path*
> as the final void* 'path' argument, rather passing 'sink_data'
> as was being passed previously. This set the groundwork for the
> subsequent addition of the ctcu_enable function which interprets
> void* data as a struct coresight_path*, but it also broke the
> existing catu_enable function which interprets void* data
> as a struct perf_output_handle*.
> 
> The compiler could not flag the error since there are several layers
> of function calls treating the pointer as void*.
> 
> Fix both users simultaneously by adding an additional argument to the
> enable helper interface. So now both the struct coresight_path and the
> struct perf_output_handle pointers are passed. Also, eliminate all
> usages of the void* from these code paths and use explicit types
> instead to make all of this code more robust.
> 
> Note: The disable function is also changed from void* to
> struct coresight_path* but no implementations of this function
> need the struct perf_output_handle* so it is not added to the interface.
> 
> The existing bug can be reproduced with:
> 
> # perf record -e cs_etm//k -C 0-9 dd if=/dev/zero of=/dev/null
> 
> Showing an oops as follows:
> 
> Unable to handle kernel paging request at virtual address 000f6e84934ed19e
> 
> Call trace:
>   tmc_etr_get_buffer+0x30/0x80 [coresight_tmc] (P)
>   catu_enable_hw+0xbc/0x3d0 [coresight_catu]
>   catu_enable+0x70/0xe0 [coresight_catu]
>   coresight_enable_path+0xb0/0x258 [coresight]
> 
> Fixes: 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")
> Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
> ---
> 
> Jie, I looked into your suggestion of adding the struct
> perf_output_handle* to the struct coresight_path, but I couldn't
> justify adding event-related data to the path structure, which has
> nothing to do with it.

The AUX event only available in perf mode. Each subsystem can access it 
from the path if needed. Since the Coresight system operates by 
constructing a path — and this path is passed to each device as data - 
it’s acceptable to include all relevant parameters in the 
coresight_path, provided the devices along the path require them.

Do you want me to create a patch as example?

Thanks,
Jie

> 
> So, instead I took the approach in this patch to plumb both arguments
> through the enable path, (and changed away from void* as you agreed
> to).
> 
> Note: I've tested that this fixes the bug for catu_enable. This patch
> also obviously touches ctcu_enable, which I believe is correct, but I
> have not tested since I don't have ready access to the necessary
> hardware. I will appreciate other testing.
> 
> -Carl
> 
>   drivers/hwtracing/coresight/coresight-catu.c  | 12 ++++++----
>   drivers/hwtracing/coresight/coresight-core.c  | 23 +++++++++++--------
>   .../hwtracing/coresight/coresight-ctcu-core.c | 11 ++++-----
>   .../hwtracing/coresight/coresight-cti-core.c  |  7 ++++--
>   .../hwtracing/coresight/coresight-cti-sysfs.c |  2 +-
>   drivers/hwtracing/coresight/coresight-cti.h   |  6 +++--
>   drivers/hwtracing/coresight/coresight-priv.h  |  2 +-
>   .../hwtracing/coresight/coresight-tmc-etr.c   |  4 ++--
>   drivers/hwtracing/coresight/coresight-tmc.h   |  3 ++-
>   include/linux/coresight.h                     |  6 +++--
>   10 files changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 5058432233da..724c25d0afa4 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -397,7 +397,7 @@ static int catu_wait_for_ready(struct catu_drvdata *drvdata)
>   }
>   
>   static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
> -			  void *data)
> +			  struct perf_output_handle *handle)
>   {
>   	int rc;
>   	u32 control, mode;
> @@ -425,7 +425,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
>   	etrdev = coresight_find_input_type(
>   		csdev->pdata, CORESIGHT_DEV_TYPE_SINK, etr_subtype);
>   	if (etrdev) {
> -		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, data);
> +		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, handle);
>   		if (IS_ERR(etr_buf))
>   			return PTR_ERR(etr_buf);
>   	}
> @@ -455,7 +455,8 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
>   }
>   
>   static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
> -		       void *data)
> +		       struct coresight_path *path,
> +		       struct perf_output_handle *handle)
>   {
>   	int rc = 0;
>   	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
> @@ -463,7 +464,7 @@ static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
>   	guard(raw_spinlock_irqsave)(&catu_drvdata->spinlock);
>   	if (csdev->refcnt == 0) {
>   		CS_UNLOCK(catu_drvdata->base);
> -		rc = catu_enable_hw(catu_drvdata, mode, data);
> +		rc = catu_enable_hw(catu_drvdata, mode, handle);
>   		CS_LOCK(catu_drvdata->base);
>   	}
>   	if (!rc)
> @@ -488,7 +489,8 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
>   	return rc;
>   }
>   
> -static int catu_disable(struct coresight_device *csdev, void *__unused)
> +static int catu_disable(struct coresight_device *csdev,
> +			struct coresight_path *__unused)
>   {
>   	int rc = 0;
>   	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index fa758cc21827..cc449d5196a4 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -353,14 +353,17 @@ static bool coresight_is_helper(struct coresight_device *csdev)
>   }
>   
>   static int coresight_enable_helper(struct coresight_device *csdev,
> -				   enum cs_mode mode, void *data)
> +				   enum cs_mode mode,
> +				   struct coresight_path *path,
> +				   struct perf_output_handle *handle)
>   {
> -	return helper_ops(csdev)->enable(csdev, mode, data);
> +	return helper_ops(csdev)->enable(csdev, mode, path, handle);
>   }
>   
> -static void coresight_disable_helper(struct coresight_device *csdev, void *data)
> +static void coresight_disable_helper(struct coresight_device *csdev,
> +				     struct coresight_path *path)
>   {
> -	helper_ops(csdev)->disable(csdev, data);
> +	helper_ops(csdev)->disable(csdev, path);
>   }
>   
>   static void coresight_disable_helpers(struct coresight_device *csdev, void *data)
> @@ -477,7 +480,9 @@ void coresight_disable_path(struct coresight_path *path)
>   EXPORT_SYMBOL_GPL(coresight_disable_path);
>   
>   static int coresight_enable_helpers(struct coresight_device *csdev,
> -				    enum cs_mode mode, void *data)
> +				    enum cs_mode mode,
> +				    struct coresight_path *path,
> +				    struct perf_output_handle *handle)
>   {
>   	int i, ret = 0;
>   	struct coresight_device *helper;
> @@ -487,7 +492,7 @@ static int coresight_enable_helpers(struct coresight_device *csdev,
>   		if (!helper || !coresight_is_helper(helper))
>   			continue;
>   
> -		ret = coresight_enable_helper(helper, mode, data);
> +		ret = coresight_enable_helper(helper, mode, path, handle);
>   		if (ret)
>   			return ret;
>   	}
> @@ -496,7 +501,7 @@ static int coresight_enable_helpers(struct coresight_device *csdev,
>   }
>   
>   int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
> -			  void *sink_data)
> +			  struct perf_output_handle *handle)
>   {
>   	int ret = 0;
>   	u32 type;
> @@ -510,7 +515,7 @@ int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
>   		type = csdev->type;
>   
>   		/* Enable all helpers adjacent to the path first */
> -		ret = coresight_enable_helpers(csdev, mode, path);
> +		ret = coresight_enable_helpers(csdev, mode, path, handle);
>   		if (ret)
>   			goto err_disable_path;
>   		/*
> @@ -526,7 +531,7 @@ int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
>   
>   		switch (type) {
>   		case CORESIGHT_DEV_TYPE_SINK:
> -			ret = coresight_enable_sink(csdev, mode, sink_data);
> +			ret = coresight_enable_sink(csdev, mode, handle);
>   			/*
>   			 * Sink is the first component turned on. If we
>   			 * failed to enable the sink, there are no components
> diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> index c6bafc96db96..9f6d71c59d4e 100644
> --- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
> +++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> @@ -156,17 +156,16 @@ static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight
>   	return __ctcu_set_etr_traceid(csdev, traceid, port_num, enable);
>   }
>   
> -static int ctcu_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
> +static int ctcu_enable(struct coresight_device *csdev, enum cs_mode mode,
> +		       struct coresight_path *path,
> +		       struct perf_output_handle *handle)
>   {
> -	struct coresight_path *path = (struct coresight_path *)data;
> -
>   	return ctcu_set_etr_traceid(csdev, path, true);
>   }
>   
> -static int ctcu_disable(struct coresight_device *csdev, void *data)
> +static int ctcu_disable(struct coresight_device *csdev,
> +			struct coresight_path *path)
>   {
> -	struct coresight_path *path = (struct coresight_path *)data;
> -
>   	return ctcu_set_etr_traceid(csdev, path, false);
>   }
>   
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 8fb30dd73fd2..f92e3be4607c 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -799,14 +799,17 @@ static void cti_pm_release(struct cti_drvdata *drvdata)
>   }
>   
>   /** cti ect operations **/
> -int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
> +int cti_enable(struct coresight_device *csdev, enum cs_mode mode,
> +	       struct coresight_path *path,
> +	       struct perf_output_handle *handle)
>   {
>   	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
>   
>   	return cti_enable_hw(drvdata);
>   }
>   
> -int cti_disable(struct coresight_device *csdev, void *data)
> +int cti_disable(struct coresight_device *csdev,
> +		struct coresight_path *path)
>   {
>   	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 572b80ee96fb..2bb6929eeb19 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -112,7 +112,7 @@ static ssize_t enable_store(struct device *dev,
>   		ret = pm_runtime_resume_and_get(dev->parent);
>   		if (ret)
>   			return ret;
> -		ret = cti_enable(drvdata->csdev, CS_MODE_SYSFS, NULL);
> +		ret = cti_enable(drvdata->csdev, CS_MODE_SYSFS, NULL, NULL);
>   		if (ret)
>   			pm_runtime_put(dev->parent);
>   	} else {
> diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
> index 8362a47c939c..73954369654c 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.h
> +++ b/drivers/hwtracing/coresight/coresight-cti.h
> @@ -216,8 +216,10 @@ int cti_add_connection_entry(struct device *dev, struct cti_drvdata *drvdata,
>   			     const char *assoc_dev_name);
>   struct cti_trig_con *cti_allocate_trig_con(struct device *dev, int in_sigs,
>   					   int out_sigs);
> -int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data);
> -int cti_disable(struct coresight_device *csdev, void *data);
> +int cti_enable(struct coresight_device *csdev, enum cs_mode mode,
> +	       struct coresight_path *path,
> +	       struct perf_output_handle *handle);
> +int cti_disable(struct coresight_device *csdev, struct coresight_path *path);
>   void cti_write_all_hw_regs(struct cti_drvdata *drvdata);
>   void cti_write_intack(struct device *dev, u32 ackval);
>   void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value);
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 33e22b1ba043..65c4984d98c0 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -136,7 +136,7 @@ static inline void CS_UNLOCK(void __iomem *addr)
>   
>   void coresight_disable_path(struct coresight_path *path);
>   int coresight_enable_path(struct coresight_path *path, enum cs_mode mode,
> -			  void *sink_data);
> +			  struct perf_output_handle *handle);
>   struct coresight_device *coresight_get_sink(struct coresight_path *path);
>   struct coresight_device *coresight_get_sink_by_id(u32 id);
>   struct coresight_device *
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index b07fcdb3fe1a..2ed7fa2366ce 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1325,9 +1325,9 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>   }
>   
>   struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
> -				   enum cs_mode mode, void *data)
> +				   enum cs_mode mode,
> +				   struct perf_output_handle *handle)
>   {
> -	struct perf_output_handle *handle = data;
>   	struct etr_perf_buffer *etr_perf;
>   
>   	switch (mode) {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6541a27a018e..b6e2b00d393a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -440,7 +440,8 @@ struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
>   void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
>   void tmc_etr_remove_catu_ops(void);
>   struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
> -				   enum cs_mode mode, void *data);
> +				   enum cs_mode mode,
> +				   struct perf_output_handle *handle);
>   extern const struct attribute_group coresight_etr_group;
>   
>   #endif
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 4ac65c68bbf4..450cccd46f38 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -422,8 +422,10 @@ struct coresight_ops_source {
>    */
>   struct coresight_ops_helper {
>   	int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
> -		      void *data);
> -	int (*disable)(struct coresight_device *csdev, void *data);
> +		      struct coresight_path *path,
> +		      struct perf_output_handle *data);
> +	int (*disable)(struct coresight_device *csdev,
> +		       struct coresight_path *path);
>   };
>   
>   
> 
> base-commit: 46a51f4f5edade43ba66b3c151f0e25ec8b69cb6


