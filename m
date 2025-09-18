Return-Path: <linux-kernel+bounces-819909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C254EB7D526
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242AA7ABBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39E2F3600;
	Wed, 17 Sep 2025 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YFlCENv6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718222B8D0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077814; cv=none; b=qBc31SWsoYrAQR1Djz6c1AEc4OuWO2CRExfdVT9XlZM4WdETyKWOtdzLjCXTlJgC0DImRXpkPVDnduIzLaxslPoEU0BCnJTeHfQKIGbvR37lih8acQTeMtktDDqnwFeD+QkkDcEl0mBr2j5TLbfz/zPtyPb8HvmVplC7WC3oJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077814; c=relaxed/simple;
	bh=omCbj6dZ5yx2+4ONvJJLobF882h4sW9IJ3T7omFr8QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flbnumf2s9xHKHblA4Z8cskysm7pyTdIT79pjddDjhJOz8bUEKdIvUFOiFOXixVMFr0loOB0whY0VNRIvLVwewA0gpKtWOCzE5b3EZjXgdA3LAD45DzWrKHhPMTRwn48oD3SFlFLsnbzJhQJTgkSQ7U3iNrsAP/6CL4oIyno4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YFlCENv6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLZken017792
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ejs0DfeIgjCv+z5FoYBCuNGBcmoT875zmGQTHUFovnk=; b=YFlCENv6AgYkfjAQ
	a96MRQT6oo/+q5qRjw3Tq5bQb93E2IHEwA62/okuhO7ckMBCljDhLDNyo+1kbB2F
	u4yPy0web9fEENwi+GcwDfmnaB+A09pEM8V1RTpPh79AifibQWq4q7fkcUg9vurH
	nj90HjiAGqdt0wH6v5VWB3nMqHkDnTBPj0CC/qsb1+OIg4o0AycvaMbT8Cb5atgp
	m6Aii1bFHI6i30Qu8Jj/3HApW+pz9cSqREFGRHWaHX/Ny4b4IRQ4uD1QuSrdYxwv
	Lt7hcXvgj7n6YG4vdDgvkW4+Xh+5/bItwz//zjHTnxP5/rwIbmZHW2wTNhwacSuY
	EvJugQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt0nkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:56:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458274406so119815835ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077811; x=1758682611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ejs0DfeIgjCv+z5FoYBCuNGBcmoT875zmGQTHUFovnk=;
        b=FHaUcdiRiycURyjxHL/2f73dsa9KTRCzgH/IevS1oyy4C1BVUMe18z42XW/plPCidW
         jjydt9E+tH8WkWbDGoYayp1TTGEXf5OJs8k0Py02wpZbmYNnGXo7ZTl41ukGfXjielZa
         u06ymG7Xren7gTVPG4NG2Fmi0g46RUwde9cg11Zk7blO6I1rRPnq6G/ysGhGFPZMFRol
         Arupt+8JM0G9wXtUmm7C4eYnGpfYKHLtgjnbfseFnof3ngUusDMGw+0IxEisiDKSZXeR
         32wRzusFvfQWbNGdtsLG+isi+NfCL6NQwhG/xsImz/PRDTdti/hHnQ3AxERZx/IrlpOf
         CGSw==
X-Forwarded-Encrypted: i=1; AJvYcCWXnST0+gJnqoiL/b+Txv2/Wxh0xQdBTgHVfWAYAOpR8TcjTzLr2zaJ9zys6Waih7HMTk1bK4ELjPP50BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfhup4UeDsEfzmaDAPhoqWE8Pr0tISELIn2F8CUznRErkCCFtR
	By/AE6nnFqOyjtOPDneH94g7hnSy2ffCZRRkX0j319qUS9iKhPKpKUUQoxwO1BHriZ1fUFee+N0
	KoNAzH7Bd2W/Ty8b5cMffRp3663MZvzeoyHWAkaCrZRy2chJiYki+Ilml0H1Dsae1Gs8=
X-Gm-Gg: ASbGncsh+4VY8JXmIKIwLzrP2abh6ddnfA8jrQIqu05aculo+AdgXwq0XtlCq+/z1/S
	lgsiq3OvyGBV9kPP0Hx9KcVAiUHJXBGs2FQYoOyMVqZCgRwLVaQDi5suhlmVZI4XNb0cjGtyleT
	/SXkN0+ySUILP8YoKZDeOnYSZsw8QvgPquHXw9DCgK8wzfTJrMQA0nDDLgOnOImYCcYb64sJh1l
	4QocmDNjvFei4jSwa5ukkxptDJIGPiRbw7rOw497Ehe3ocAvK0Ve/2SXp8bCQWWxiPkJc4UxBz1
	oC/92KOjbonN+X5xemLLbiGwjTBbrSOfUUAhuARTq2mT9GBKnhJDHmWGwfu6AV8kmQaQ8GGOQ9b
	q3g==
X-Received: by 2002:a17:902:ecd1:b0:263:57e7:8950 with SMTP id d9443c01a7336-2681217f3e4mr7419815ad.19.1758077811113;
        Tue, 16 Sep 2025 19:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnnI/XlzVFKrLai7UAMi0WGqhx8P9VAhzfg83kdhSwUBWlQHiBGFrNpl+Fk25QwPynEZGuDw==
X-Received: by 2002:a17:902:ecd1:b0:263:57e7:8950 with SMTP id d9443c01a7336-2681217f3e4mr7419235ad.19.1758077810577;
        Tue, 16 Sep 2025 19:56:50 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.231.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-264c4e98f8csm87739605ad.108.2025.09.16.19.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 19:56:50 -0700 (PDT)
Message-ID: <32d8329f-0d73-fb16-f12d-308e6ee6b45d@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 08:26:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 05/10] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-5-37d29f59ac9a@oss.qualcomm.com>
 <lgoahuqgoajuj352h7rnjfyeeyf24x45pj3qmidc6qqrc75vej@3hrblxle7uyk>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <lgoahuqgoajuj352h7rnjfyeeyf24x45pj3qmidc6qqrc75vej@3hrblxle7uyk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JLHI-T9NPEP1NlJOMbOjlhd1xzDg-Qok
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68ca2374 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=1kWWpRhd3BofgRIEiGpY3A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7WfyLBSIawAVH6obIBAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwknt1N+XkS62
 fRrW4KVSAnxpRvxO3GJuMbgl2rWgZ73EGvQL2bEYbzpxbFFCS4pntP9jS06FfocCHhUlk0nCALq
 5pxT0c4ysf1jDo8FR5RJBwbuMY5gF6MnzR8aqQImJ5XxK27MjQ7O7qVNqbdDnIA09EduyASNusb
 g/ciFS3SSf/5hkQHOrzOMXgSg9vVwl7WGj9eNtXs7x4sYwlpDofKQEFfyJLPCMgxwLwjrcXSAc1
 8QS7e726apNIXYCC57MzROfFFVIrA7PWfMZc39Rd//H1nCxyQz0L9uKyGrh6cI691v9tIUg5Inw
 ZQPKXeNo0sKoIrnTw9GC9sBPN3XF5GO2fHYSh2EbpiJF0NQq55FwIQ+HTQHT6fQmHSLogtvf1YD
 Imeit/mM
X-Proofpoint-ORIG-GUID: JLHI-T9NPEP1NlJOMbOjlhd1xzDg-Qok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/17/2025 12:32 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Aug 15, 2025 at 08:05:10PM +0530, Shivendra Pratap wrote:
>> Currently, there is no standardized mechanism for userspace to
>> discover which reboot-modes are supported on a given platform.
>> This limitation forces tools and scripts to rely on hardcoded
>> assumptions about the supported reboot-modes.
>>
>> Create a class 'reboot-mode' and a device under it to expose a
>> sysfs interface to show the available reboot mode arguments to
>> userspace.
>>
>> Provision the register function with an additional parameter to
>> get an explicit driver_name. Create the device using this
>> driver_name. For platform drivers, use the driver_name configured
>> in dev node.
>>
>> This results in the creation of:
>>   /sys/class/reboot-mode/<driver>/reboot_modes
>>
>> This read-only sysfs file will exposes the list of supported
>> reboot modes arguments provided by the driver, enabling userspace
>> to query the list of arguments.
>>
>> Align the clean up path to maintain backward compatibility for
>> existing reboot-mode based drivers.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 131 +++++++++++++++++++++++++++++++-------
>>  include/linux/reboot-mode.h       |   4 +-
>>  2 files changed, 110 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index ac81b8b0a9b7fc31f8ef21024333a050087ce90f..7ecab050e496af3e1cc01c1a4614787707cb74b4 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -6,6 +6,7 @@
>>  #define pr_fmt(fmt)	"reboot-mode: " fmt
>>  
>>  #include <linux/device.h>
>> +#include <linux/err.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>>  #include <linux/list.h>
>> @@ -23,6 +24,8 @@ struct mode_info {
>>  	struct list_head list;
>>  };
>>  
>> +static struct class *rb_class;
>> +
>>  static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
>>  {
>>  	const char *normal = "normal";
>> @@ -75,26 +78,121 @@ static int reboot_mode_notify(struct notifier_block *this,
>>  	return NOTIFY_DONE;
>>  }
>>  
>> +static void release_reboot_mode_device(struct device *dev, void *res);
>> +
>> +static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct reboot_mode_driver **devres_reboot;
>> +	struct reboot_mode_driver *reboot;
>> +	struct mode_info *info;
>> +	ssize_t size = 0;
>> +
>> +	devres_reboot = devres_find(dev, release_reboot_mode_device, NULL, NULL);
>> +	if (!devres_reboot || !(*devres_reboot))
>> +		return -ENODATA;
>> +
>> +	reboot = *devres_reboot;
>> +	mutex_lock(&reboot->rb_lock);
>> +	list_for_each_entry(info, &reboot->head, list) {
>> +		size += sprintf(buf + size, "%s ", info->mode);
> 
> sysfs_emit_at

ACK. will update.

> 
>> +	}
>> +	mutex_unlock(&reboot->rb_lock);
>> +
>> +	if (size) {
>> +		size += sprintf(buf + size - 1, "\n");
> 
> sysfs_emit_at

ACK. will update.

> 
>> +		return size;
>> +	}
>> +
>> +	return -ENODATA;
>> +}
>> +static DEVICE_ATTR_RO(reboot_modes);
>> +
>> +static void release_reboot_mode_device(struct device *dev, void *res)
>> +{
>> +	struct reboot_mode_driver *reboot = *(struct reboot_mode_driver **)res;
>> +	struct mode_info *info;
>> +	struct mode_info *next;
>> +
>> +	unregister_reboot_notifier(&reboot->reboot_notifier);
>> +
>> +	mutex_lock(&reboot->rb_lock);
>> +	list_for_each_entry_safe(info, next, &reboot->head, list) {
>> +		list_del(&info->list);
>> +		kfree_const(info->mode);
>> +		kfree(info);
>> +	}
>> +	mutex_unlock(&reboot->rb_lock);
>> +
>> +	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
>> +}
>> +
>> +static int create_reboot_mode_device(struct reboot_mode_driver *reboot,
>> +				     const char *dev_name)
> 
> Instead of adding more and more arguments to this, just add a name
> field to struct reboot_mode_driver.

ACK. will update.

thanks,
Shivendra

