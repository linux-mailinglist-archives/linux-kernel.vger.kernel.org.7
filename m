Return-Path: <linux-kernel+bounces-860612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F01BF07F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BD4C3452AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E402F60D1;
	Mon, 20 Oct 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pV5CSYP+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04BE2E8B98
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955513; cv=none; b=dnZgCKniStdh4iB2nQNKft1OUfOR8bikw4Nqmwvy0U2xJAlXQMzJi9ZD+EWgAiEWfak5ltDl/sUBBRgiZdL6kzCwO/pBxj0NoB+mZdctYHPH02gFWDV8PdV1+HehOHQYuTxXmAgAyIzthXVrfhV5ggRwSYpNyF68450q9kvBLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955513; c=relaxed/simple;
	bh=/E+SfbR33yMO0mxzan3DYGlz5eyCLJVfKAVH/2EScKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwV39pFYBvBFQNxg1ADjCOG/1Eles7F1DFf3E6jW8eykObNyjdVtxbD6k8a2R3fYO8xJaUJh1q+197xYAyaK5pEGRb0PDsyuvPW3fcCzDqLlwY2HmrE1J4rv9FVWqvObO9UdboQJcW9imSP6/1f4k4+m6H9a5y585Es0mnDJev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pV5CSYP+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNtVYK003762
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fKPdzEZBD9QZXB2s1p9qSuBi/92rUnMqY86HToXptQI=; b=pV5CSYP+uzFp1Zi9
	5u/T6O6qsNm4Ccr6Qlq9YWvi83O3re54PZcgni1wqoNDqTOTz5mflncHE2xmA6d1
	UcQ8+wmxF3THLY1ABL9vTvg4kFnKeja2tjEbsIkt1I+Wu5hb0Pp1b6v8mTTVOQLu
	vLChCG1QOfq9imXdzdouD0lkcDBXynkJDqysl34r9BhwKsVW0YHOL5hOw5tTx7PG
	7hmratWjUkguKkbagd7DkOWUOodzueujtdC36/Zg/jtnFTFXXL13oBZ1cbVKj41H
	4gbBhUE/VALmRapKMvPGmdEwbcZDIDOK7QU2hxd4A3tY1BHr3MLFAnUJDLDl3LDC
	x2GP6Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfccrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:18:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33be01bcda8so3355217a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955510; x=1761560310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKPdzEZBD9QZXB2s1p9qSuBi/92rUnMqY86HToXptQI=;
        b=lrsnGtY+uF+lBHP3SR+srX9NXCctzOkE8DjArlph6Bywnqs8PMB0UHoy3qwUcHCK41
         P9FY5tu/nPlUXw9miDHjTafMLSDha5P5sDfsMSbTRDIUrxTdkL6NXC4RxRehiTWOEgFy
         n+VCZSR5RWcOBT6ny5WtNfNmyzDS9FPMG60ooKExGAiqXA4LQnzMpEUhs0cVIOxPzhvG
         4AJyOG0MosZ8jfC4/LdOvDPAcuTTvmOr6ZYayMLmCTDvRR9cy0KPetg8DXnucvSiwkHP
         U89ZW0C/mIH1HRVksP3UoOhbF56orVBmArTcvo9daa0fGxXjvnqX8kKJXlAp5pYH00O2
         TZzA==
X-Forwarded-Encrypted: i=1; AJvYcCW43IvptTTwpEpYj66u0MqGKveF/ER90j7sm9274A3zF4Qww/ygaTVO6td+BAIeldYUPCrJ1MXhXb6Yq3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LxlFwmJ070SS6aeFaR8KXp0chPIxk+isUrmbBSCuUAmwuOiJ
	uPE/wo7WAd5R6+4b56miBhybZ17VtiYJMGAuuur3Xtj0/QBsXHLrMf2mmjMDM9lM3qmJd0/cqJ/
	c2/yGwHCFKsBv+ye2K/lux5kzZ0m+TsLwljTZgLA4nKpZhPENCaO1QcNLuXDVgG8eHuY=
X-Gm-Gg: ASbGncvJD0hb/trTk9E6N9/g8pmNdmHO+CA2pklH+UKOrWwvA5tZfson7whOft3n5hs
	ZrXW0qr3lKK0AzHwaEUFo4krhnIQCzkPn+CHdPndtP+0OmJgahqqibKHiZE5z05tzaoJqfbP4qD
	+YD3aLPM3kMWs9GxRVsUNv0wVizbzkSQOu/sclZofc+Q8YN7K0HU8azAYiXvObzo05vKAFz8omb
	3rdlTSF4hklLvBibJyFsHIo9RajB02b65kEFVG651HSK4xj4CKx/NVZgB9aw4++fO9fyhr24U63
	9kx5U7IzpSk1f7IpMdCLqv1xEeNhXj+ff/8a+sGUhx4JXmJmHIhScnpk98e8M/AQ9Ut0baOs8qv
	joo+7Pi969+GYcK6o8ryeyfCD6WDBWhfLOlbO2y5KJSFDCk0VxRsNhYkiKC4uZd7G
X-Received: by 2002:a17:90b:3fcc:b0:33b:cb9c:6f71 with SMTP id 98e67ed59e1d1-33bcf85a9f4mr15151457a91.1.1760955510401;
        Mon, 20 Oct 2025 03:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFILSIB5MLwkoW7cfHXg7NftIz20LOIacIG5ScdX4N/6wkENYhBKa3PrdVR/37Iv/EgLjInQQ==
X-Received: by 2002:a17:90b:3fcc:b0:33b:cb9c:6f71 with SMTP id 98e67ed59e1d1-33bcf85a9f4mr15151431a91.1.1760955509968;
        Mon, 20 Oct 2025 03:18:29 -0700 (PDT)
Received: from [10.133.33.105] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm7181125a12.10.2025.10.20.03.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 03:18:29 -0700 (PDT)
Message-ID: <5a95ad38-0b32-4889-a8fb-af7e79c2e862@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 18:18:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: ETR: Fix ETR buffer use-after-free issue
To: Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20251020-fix_etr_issue-v1-1-902ab51770b4@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20251020-fix_etr_issue-v1-1-902ab51770b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JZaUnWKCKz2UuHo-EE_gTXVWxMfokvp3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX+wevYNSBrrRI
 gIJ16qDJpEViQgJZodLAhqOPuS0KrkBA4tEVtTqH0LjM+tX3tGXrQMyrOgXsI5xG8MoLPvsDhjA
 P0v2uGdh4/JbxWLxnTMtx/q8fVnhmW67gJasBMWuDfzHFmcxaNfuCERYUC8Py2/uAw9OgzSLzqY
 6ZF5nY1XnkcUmXRLEHfd0ziTV53G7iSGvjetWCEqccrvyL9ENxw3rAt/rsM0Hv3IurWPRC88aEj
 xgSxG6ojYZZMjoSbqENvXlRuMKOv3pTQXE6MTj4ogeSnn/vclgLJC9GW2Z6xbTrjryF+KlYYg0A
 FezFMtpggPmlX90RrcYQxkwtQXQH84TXi44s1StEBLhQPMwdm7aMLY0+lfNvhNQppv6/ptk+CJI
 rdxuf/JyGpro3PQa5jNp0dLaHbZhUg==
X-Proofpoint-GUID: JZaUnWKCKz2UuHo-EE_gTXVWxMfokvp3
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f60c77 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=yZ5FxKY4llv7UqssUvUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027



On 10/20/2025 5:06 PM, Xiaoqi Zhuang wrote:
> When ETR is enabled as CS_MODE_SYSFS, if the buffer size is changed
> and enabled again, currently sysfs_buf will point to the newly
> allocated memory(buf_new) and free the old memory(buf_old). But the
> etr_buf that is being used by the ETR remains pointed to buf_old, not
> updated to buf_new. In this case, it will result in a memory
> use-after-free issue.
> 
> Fix this by checking ETR's mode before updating and releasing buf_old,
> if the mode is CS_MODE_SYSFS, then skip updating and releasing it.
> 

I think we need a fix tag for the fix patch:
Fixes: de5461970b3e ("coresight: tmc: allocating memory when needed")

minor comment:
Since ETR is enabled, we can't switch the sysfs buffer, can we exit 
earlier by checking the CS_MODE to avoid allocating memory unnecessarily?

Besides,
Looks good to me.

Thanks,
Jie

> Signed-off-by: Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index b07fcdb3fe1a..3e73cf2c38a3 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1268,6 +1268,13 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>   		goto out;
>   	}
>   
> +	/*
> +	 * Since this sink is already enabled, the existing buffer should not
> +	 * be released even if the buffer size has changed.
> +	 */
> +	if (coresight_get_mode(csdev) == CS_MODE_SYSFS)
> +		goto out;
> +
>   	/*
>   	 * If we don't have a buffer or it doesn't match the requested size,
>   	 * use the buffer allocated above. Otherwise reuse the existing buffer.
> 
> ---
> base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
> change-id: 20251020-fix_etr_issue-02c706dbc899
> 
> Best regards,


