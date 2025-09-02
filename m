Return-Path: <linux-kernel+bounces-795890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A2B3F903
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D67D1889AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86232F77A;
	Tue,  2 Sep 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dx1XUi+l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA826CE39
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802769; cv=none; b=Xn+9s7OvsoHA/Ms9QxB1WrTOo/xM4kbQVJpxMt9YiiSjiDMj3XGzCMtl8140VzKpNFtOuH3MGniUNTvfYrxU8C6npRA/d+xPp4vZ1ggeMykzqpsVNnTFkqtkNZpj3QsME5s06ni3USSmp43+nBok0Kv1pr0ieJtcZv91cLu1BFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802769; c=relaxed/simple;
	bh=IU5KSuERKFOff7YoeQFlF/eDIiUCS3ER4x7/uJbGcaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUPG01qhGpUWeBHH/Vm0LNiY2Tf+rNwH1Ys9k1/nhqyng+X1pYTN+ZnxlJTVgH3YcxvKFFurpkgCeZ1gUvoAei8ArlWhVGwPCDBd5lSti68f9QDU2rMt+sWCT79WBcs68pn+n7fRaoeVysfzXOG+nDKsFU9Wiu6f6ImkyCIGaOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dx1XUi+l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rx0N029702
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 08:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9DdypEXonIxbTZgmqW/GG/QjXoKUlrEkhIPatpNasJY=; b=Dx1XUi+l4Q9OfwF1
	7uWYmq8bXAY7isKIJb/5WqKDMxNpgb795bb530b0V0oplDYsRiu7v3feV1cVep76
	RaTbYmbhA9w9Pam07InUUtwRX2yJa0WwiHqhMfwkHirmidNn0YToiCNmz4f1h2eg
	MP0EkZtd0nArQ876ZxybTl/mx0w1/FjY97Jdnu0ApPCC9waMfAjXj94Fe1V3NwbC
	gzhpSfbYgETbio/rTvT9lYgJsHlE10IiHJ9uD5/QoGXnM11Z3k5IeZ3ez0Qj8F5F
	K9cdQaTuxUoOG5xZsKyH8VYjAc3YuZnwwCDTN6XlId1xWpMzori+NZr5JMyNlr4k
	M+M/Rg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8q4gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:46:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24b0e137484so5877355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802764; x=1757407564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DdypEXonIxbTZgmqW/GG/QjXoKUlrEkhIPatpNasJY=;
        b=miL7xM20M2s02HVilyeVkcPYaQGjrkf0yM7UG79esDM1H61BjJ7tFSy2cZMZFJdsKX
         1swAjOofoyIxflt2vWuQJug3cd6K0DYKMvoiwYfVkVsbCIiz+J/WgKmMQcm4a8xcRddr
         ri15CWibO59W1mNHtYs0XV7mbWvJcHpnR68tF/IxMhPfKi4p0Aq3etC2ycdtrPQoNRQt
         Ns/QgP6u8h9K4aCnmTzdkFXdOFN5KRgsRfJn6Mzta5/804Pc1484zN1A2PmXHIOjSkbF
         Y+6QHD3K46sMBb6wyMqqykResIamUq2ZL9sxuaE1ZCeuMuNYeole4WmMVqVP0AbbrtTH
         ywsg==
X-Forwarded-Encrypted: i=1; AJvYcCXxaUHipR3XMQJv6u/dmsAQwvhvLTKWDoQW0FSSnGZUxUnLx0LTF3PIg18POqnMc02pQJUyEscU7hO7RZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWlwXEXg/DheeUwSABIaXOZgCqdmg4pkZ7w+9KdUrmSfljdPa
	Gp/gyADaAy3UBE7AnddGn10UnOtdsHNPk3/tbLmupIdV/UHxSNVPADXiSHKbx1k7twKxpRFRDmS
	od3lfA3ZaVx4Gj9G+UI5RHUZ7c+BItEV8lc2XwerT7Y/FthrH8HaPayNsMvw7iLVuzo8=
X-Gm-Gg: ASbGnct5FEDfXcLHHALBg9HyTftKhH9uha6zvy8tcYSF6ajZeewOIv3qIRIn5PF27mD
	wmgfIUcdYyOCfUh0aP9V3iUI5GlQzpoXre8pxveaSTqDmh4DRvpb55N6LFKHSnsAtgguMU+DVte
	YUyQMvsLNdU+7xQV5JWUXNjMdaNqFJPBJiG1QKk7tkGkJjLLf/Kcf0kYFZqdh2FK0Fo4z/8CbqC
	llmVmbFnFNTaGTtSJbHc1E4Zt//lZLZHCQHjBVRQn9t9H4WsReg/HgOvIoI33/izMRbRUf9FwfU
	2IKUPDc1EbO1yJ5Oo92WUeGFzcMiPJ1k4RUPvIO2ImhmaKFYhCUChC5lIWKJ6zKuFDtA4JhR+1c
	5xWzBry3UnuhasxYJR8R0udue//ES
X-Received: by 2002:a17:903:198b:b0:248:e716:9892 with SMTP id d9443c01a7336-24944b22091mr134500095ad.59.1756802764447;
        Tue, 02 Sep 2025 01:46:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNIgt7obz4JURxVGJHkvnfA881OlV+TX+JH491+i3sFtiyAGB0czxK7st5H/fPfL/f3sPRww==
X-Received: by 2002:a17:903:198b:b0:248:e716:9892 with SMTP id d9443c01a7336-24944b22091mr134499845ad.59.1756802763900;
        Tue, 02 Sep 2025 01:46:03 -0700 (PDT)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037285b9sm127053325ad.44.2025.09.02.01.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:46:03 -0700 (PDT)
Message-ID: <c79814ed-3e97-48c0-9ad9-cf5337967fd8@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 16:45:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix data race in CPU latency PM QoS
 request handling
To: Ziqi Chen <ziqi.chen@oss.qualcomm.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: peter.wang@mediatek.com, tanghuan@vivo.com, liu.song13@zte.com.cn,
        quic_nguyenb@quicinc.com, viro@zeniv.linux.org.uk, huobean@gmail.com,
        adrian.hunter@intel.com, can.guo@oss.qualcomm.com, ebiggers@kernel.org,
        neil.armstrong@linaro.org, angelogioacchino.delregno@collabora.com,
        quic_narepall@quicinc.com, quic_mnaresh@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nitin.rawat@oss.qualcomm.com, zhongqiu.han@oss.qualcomm.com
References: <20250901085117.86160-1-zhongqiu.han@oss.qualcomm.com>
 <1174ecf9-b806-4c2d-b755-8a3cd594d337@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <1174ecf9-b806-4c2d-b755-8a3cd594d337@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2FQht2W2VCNJZD_gxtoDRxgXQZCl3xd1
X-Proofpoint-GUID: 2FQht2W2VCNJZD_gxtoDRxgXQZCl3xd1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX3WsyEXD+wBFB
 fNSQRXelWLJxhoGAr52p3vAmVjPydHnY0PySJAtgoH6NBo6vp+oRuSw3sDUJT2x+vjE+GFGq6AC
 N/u1kC0oRr24CcaUFLGpK++GZUuMGKDfNXSAkBrj4GwuYixduyr7GYFSIVXPCXf4R1amIppHOBs
 az3TTfqsVvE+kN+uLQxw8o50ipOKuF2XbK1zgpB8AXONL6WZIRuA3P3lg2e9FGCccSce9zvPGP9
 gTqcge6TD3LdoUU9aYD3/Wm+MV98KdpIpLqg/ceh2VknW1bbcBH1ZGyBv+8J2B1RPKePJuwTqGk
 oIphQy1X3t6EsfOa+UAr3+Ahpor8gqz3xPOweyufMrZRLxCwWrFgq2GKOGgds0yhsK8n7HLqJES
 NP5DPX/u
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b6aecd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=JS0ieFr0-Jg96Rwx31IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On 9/2/2025 2:43 PM, Ziqi Chen wrote:
>
> On 9/1/2025 4:51 PM, Zhongqiu Han wrote:
>> The cpu_latency_qos_add/remove/update_request interfaces lack internal
>> synchronization by design, requiring the caller to ensure thread safety.
>> The current implementation relies on the `pm_qos_enabled` flag, which is
>> insufficient to prevent concurrent access and cannot serve as a proper
>> synchronization mechanism. This has led to data races and list 
>> corruption
>> issues.
>>
>> A typical race condition call trace is:
>>
>> [Thread A]
>> ufshcd_pm_qos_exit()
>>    --> cpu_latency_qos_remove_request()
>>      --> cpu_latency_qos_apply();
>>        --> pm_qos_update_target()
>>          --> plist_del              <--(1) delete plist node
>>      --> memset(req, 0, sizeof(*req));
>>    --> hba->pm_qos_enabled = false;
>>
>> [Thread B]
>> ufshcd_devfreq_target
>>    --> ufshcd_devfreq_scale
>>      --> ufshcd_scale_clks
>>        --> ufshcd_pm_qos_update     <--(2) pm_qos_enabled is true
>>          --> cpu_latency_qos_update_request
>>            --> pm_qos_update_target
>>              --> plist_del          <--(3) plist node use-after-free
>>
>> This patch introduces a dedicated mutex to serialize PM QoS operations,
>> preventing data races and ensuring safe access to PM QoS resources.
>> Additionally, READ_ONCE is used in the sysfs interface to ensure atomic
>> read access to pm_qos_enabled flag.
>>
>> Fixes: 2777e73fc154 ("scsi: ufs: core: Add CPU latency QoS support 
>> for UFS driver")
>> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>> ---
>>   drivers/ufs/core/ufs-sysfs.c |  2 +-
>>   drivers/ufs/core/ufshcd.c    | 16 ++++++++++++++++
>>   include/ufs/ufshcd.h         |  2 ++
>>   3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
>> index 4bd7d491e3c5..8f7975010513 100644
>> --- a/drivers/ufs/core/ufs-sysfs.c
>> +++ b/drivers/ufs/core/ufs-sysfs.c
>> @@ -512,7 +512,7 @@ static ssize_t pm_qos_enable_show(struct device 
>> *dev,
>>   {
>>       struct ufs_hba *hba = dev_get_drvdata(dev);
>>   -    return sysfs_emit(buf, "%d\n", hba->pm_qos_enabled);
>> +    return sysfs_emit(buf, "%d\n", READ_ONCE(hba->pm_qos_enabled));
>>   }
>>     /**
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 926650412eaa..f259fb1790fa 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -1047,14 +1047,18 @@ EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
>>    */
>>   void ufshcd_pm_qos_init(struct ufs_hba *hba)
>>   {
>> +    mutex_lock(&hba->pm_qos_mutex);
>>         if (hba->pm_qos_enabled)
>> +        mutex_unlock(&hba->pm_qos_mutex);
>>           return;
> Missing the curly braces for this If statement.

Hi Ziqi,
Thanks for the review, yes, i will fix it on v2
https://lore.kernel.org/all/20250902074829.657343-1-zhongqiu.han@oss.qualcomm.com/
  
The internal test version does not contain this bug; in fact,
the internal test version is correct.

>> cpu_latency_qos_add_request(&hba->pm_qos_req, PM_QOS_DEFAULT_VALUE);
>>         if (cpu_latency_qos_request_active(&hba->pm_qos_req))
>>           hba->pm_qos_enabled = true;
>> +
>> +    mutex_unlock(&hba->pm_qos_mutex);
>>   }
>>     /**
>> @@ -1063,11 +1067,15 @@ void ufshcd_pm_qos_init(struct ufs_hba *hba)
>>    */
>>   void ufshcd_pm_qos_exit(struct ufs_hba *hba)
>>   {
>> +    mutex_lock(&hba->pm_qos_mutex);
>> +
>>       if (!hba->pm_qos_enabled)
>> +        mutex_unlock(&hba->pm_qos_mutex);
>>           return;
> Same here.

Acked.

>> cpu_latency_qos_remove_request(&hba->pm_qos_req);
>>       hba->pm_qos_enabled = false;
>> +    mutex_unlock(&hba->pm_qos_mutex);
>>   }
>>     /**
>> @@ -1077,10 +1085,14 @@ void ufshcd_pm_qos_exit(struct ufs_hba *hba)
>>    */
>>   static void ufshcd_pm_qos_update(struct ufs_hba *hba, bool on)
>>   {
>> +    mutex_lock(&hba->pm_qos_mutex);
>> +
>>       if (!hba->pm_qos_enabled)
>> +        mutex_unlock(&hba->pm_qos_mutex);
>>           return;
> Same here.

Acked.

>> cpu_latency_qos_update_request(&hba->pm_qos_req, on ? 0 : 
>> PM_QOS_DEFAULT_VALUE);
>> +    mutex_unlock(&hba->pm_qos_mutex);
>>   }
>>     /**
>> @@ -10764,6 +10776,10 @@ int ufshcd_init(struct ufs_hba *hba, void 
>> __iomem *mmio_base, unsigned int irq)
>>       mutex_init(&hba->ee_ctrl_mutex);
>>         mutex_init(&hba->wb_mutex);
>> +
>> +    /* Initialize mutex for PM QoS request synchronization */
>> +    mutex_init(&hba->pm_qos_mutex);
>> +
>>       init_rwsem(&hba->clk_scaling_lock);
>>         ufshcd_init_clk_gating(hba);
>> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
>> index 30ff169878dc..e81f4346f168 100644
>> --- a/include/ufs/ufshcd.h
>> +++ b/include/ufs/ufshcd.h
>> @@ -962,6 +962,7 @@ enum ufshcd_mcq_opr {
>>    * @ufs_rtc_update_work: A work for UFS RTC periodic update
>>    * @pm_qos_req: PM QoS request handle
>>    * @pm_qos_enabled: flag to check if pm qos is enabled
>> + * @pm_qos_mutex: synchronizes PM QoS request and status updates
>>    * @critical_health_count: count of critical health exceptions
>>    * @dev_lvl_exception_count: count of device level exceptions since 
>> last reset
>>    * @dev_lvl_exception_id: vendor specific information about the
>> @@ -1135,6 +1136,7 @@ struct ufs_hba {
>>       struct delayed_work ufs_rtc_update_work;
>>       struct pm_qos_request pm_qos_req;
>>       bool pm_qos_enabled;
>> +    struct mutex pm_qos_mutex;
>>         int critical_health_count;
>>       atomic_t dev_lvl_exception_count;


-- 
Thx and BRs,
Zhongqiu Han


