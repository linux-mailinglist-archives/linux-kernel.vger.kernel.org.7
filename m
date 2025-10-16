Return-Path: <linux-kernel+bounces-856688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06BEBE4D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EA2586C12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93B23EA9F;
	Thu, 16 Oct 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gohw4ps1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106751FF1B5
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635186; cv=none; b=czloiBDvicZsLHM71zlXlZAJ+s3BdYcptM+X6Std/VM0mII6mqQu8AZ7OMHR9HsLU0cJTDKhkeqx9hp4c9FF2h6LO7Yx+iE7SSr1f7c5kvH+PoiebNWpQFiBdJVcLIIUG/JkkCMfCwGeP0pJSMJqB5chNta11c6itFuC7quKQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635186; c=relaxed/simple;
	bh=iCjjuLaISQPhiPCfSVOWiLqhl9nvQ9Mx8UGWwvNy8QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET0jEBUEEunZiSZXZ8LDOLl0L3C1XaO394kA4iEhkMbWMdhmWnl0lz78eW4zFSAriCBe7/iwRUi7jqKddLFerkVOv7fR0ixYpNElV05yMrlucNRd9doeKklNjZAAhEIQBMof546M4j8nRbG7lbd+zBRg9oQJ37Ize/zT3utbR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gohw4ps1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVTNH003535
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ax94yOZGpPbJi/xkHkGG7O7SwfDjw1ym9nOUmMgbPc8=; b=gohw4ps1ahNQxtjY
	g6HwKuJdWImMQBH6Aa7c0ZA/c+8LQdaiGrfY9ChqFh/Ei+np3e02R7TOn/kqd0a6
	8FOsqmqtGAqrFyXEFn+JBz3bTgFQFceGi2CbXY6/Z490iaVL7L4RRiKyj3NBCSGU
	0OhgQnxhh4OBjFxPAINLgzVuaQ3rtOqTgomhenXRH4SlZSd4A3DKe5WOMisk0AoF
	uLHer1wLpjUwfMahIOTLgk6cUB5gCbfyYeNj1EDyOQ38cYZp8mPX2uGssJWx1K3w
	Xlstm/3v2XABbh1YLdullQ3cL4ptI92ZxF/IZlId/CXQKp6cRg+GY9tOqmheutIK
	gXJiqA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8qu1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:19:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so1989655a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635183; x=1761239983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax94yOZGpPbJi/xkHkGG7O7SwfDjw1ym9nOUmMgbPc8=;
        b=JKDr2SZ7l7vdUsHe7OaqzoPY4TGMcylIlR1AUjsdDgNuRo+YQvt0y0ulHBOYa4t4In
         ooa8GTq5ZyIgH4SRRj5jRXRHAy/pepj4CwBNEYVXAIjUZi+iYfEs6f1lPKwq3/PpYpMg
         5zYuSJl3P8VTQdtiUKyxTTzWWBV/wzvDM4ud333bZv+Rqqbhe8WQub1/v6JYyj7c8VJN
         QkXsDIm64OAHOUjjZjjyJmvDkBmCe74+0fxhLv3E+sFcecaT91xhbT1GG6BocTS/9Xh4
         PjDkZ7WUhXwFRgVGWd4Ze+ZfG4i1oEJEFRgP51/S6v5/ZAWtZsGibtunuCQ2Gq6C1R/X
         e5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV/2oimhFwDWmxI6r2BY4oEazc2J+BYP5lZrF8pkuvegcrkd2YZcE3Doy6Qv9wtuDi2uCl6uNqvRqck0m0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5169EuoWPsy+lg7FXTNKwR6Mof9YPXovgXYHxdAO/zKFeUcW
	TPH9vlFcpWU5rnMNmM3eXHKTTn+jowi7/zO52nHE1nv8XdRqCP3XNDGsuZ5obkw2zNzpFrUUWoy
	kySrXxl7CnPwOL6GBPMvwpt/lYiOGF13nszCUU3HJYTEr2kGD2gAVfixo6uSSQHSu9YE=
X-Gm-Gg: ASbGnctVDnKgipe3GkWshQCDdBUyJO0iok9+jn6Z6tPORDyT5ObmnqIKWOOLAPMAfiF
	HoQAErm+ZaR2gsRwblmQp+y2O0FuEtcenNKN9lgxWUJMPrCGUbsTXWWmti+2NCIFc1TXd9WlAt3
	t9D6c2oOKIqhaOu3Zw8s43iQ78oIDczEJurDVV4ocNodFO3Qh+H3rCZVmvP+XUfJkq/E8pNyRJk
	QFGXyzbS1tvxvBjlECjxM+x/ySMmC0ZSF/z6V0UVpNmGMxhSMU7x6uJ9meMrD77q+503Dbcgcra
	5p0GVRm69x24Kyuzhe4q32CYnZBhi7XbitbA8sf482HMpcrX+1+4TwrXE+UMxmYtl+lyPDfwMge
	Os6wYfEVexN2b340mIjQgNhmafLs9vV6k
X-Received: by 2002:a17:90b:3f8d:b0:33b:be31:8193 with SMTP id 98e67ed59e1d1-33bcf85d59dmr763824a91.6.1760635182598;
        Thu, 16 Oct 2025 10:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1rRrAo2QPBaKZifUQLJIoZpvDEaFp+zcbkMAZ+fOe6tW2DlqTpsxyKkKUiFkWY1Ph4rjsWQ==
X-Received: by 2002:a17:90b:3f8d:b0:33b:be31:8193 with SMTP id 98e67ed59e1d1-33bcf85d59dmr763793a91.6.1760635182106;
        Thu, 16 Oct 2025 10:19:42 -0700 (PDT)
Received: from [10.216.0.133] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb65222b1sm2611494a91.6.2025.10.16.10.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 10:19:41 -0700 (PDT)
Message-ID: <fa42adf0-8f15-ad4c-3788-578b1bee1c72@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 22:49:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v16 02/14] power: reset: reboot-mode: Add device tree
 node-based registration
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-2-b98aedaa23ee@oss.qualcomm.com>
 <CACMJSesvTLe28Jz83b=zfHD2rvmf7-i_2+2DoV=dgooVqFEYbA@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSesvTLe28Jz83b=zfHD2rvmf7-i_2+2DoV=dgooVqFEYbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BT3Vl7oVpe1gbYV0wKiq5o5QDlL5pz7V
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f1292f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8ps4eDoI1eVci98EcxQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfXzcSFQlqDeO3f
 ahcQfYYFsrRTcK0P7VdtXh5mVnIg1f3tDZUcSw0vxy33IA7EP76E5XkQEcTDeFhwlwrDzrjIgQ0
 6LYahfPzyTqWYUBWRZVDF5i2t0P0tT30crQqB+zMSwFossYC2zvQNQZAtieY1xt22oiDVnow/Ub
 CB7pRV7HKeQqT2EcyeFvcYOrtOvpEvY4BzPx6qSvTaINTl8Ch4/G2/c5yGSEStoU/tPG1cvqzAu
 3SZGNJXSp+a8cJ6ucozTs5PUjuS6dRx1LnlCOLb++1Ys8OeR8rBpucSckYiHteO+ACvKl9xyZfR
 asEkQrcU9YtG28VCwSxPzoVUmLXgQAPDQzj/vhv2R3HPq3p5ZT8Y6spfheSDpO7kkqQCvjoxSNJ
 eLZ2Ck5g2EW1txxDXH+DqT5d5/hCXA==
X-Proofpoint-ORIG-GUID: BT3Vl7oVpe1gbYV0wKiq5o5QDlL5pz7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134



On 10/15/2025 8:10 PM, Bartosz Golaszewski wrote:
> On Wed, 15 Oct 2025 at 06:38, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>> The reboot-mode driver does not have a strict requirement for
>> device-based registration. It primarily uses the device's of_node
>> to read mode-<cmd> properties and the device pointer for logging.
>>
>> Remove the dependency on struct device and introduce support for
>> firmware node (fwnode) based registration. This enables drivers
>> that are not associated with a struct device to leverage the
>> reboot-mode framework.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  drivers/power/reset/reboot-mode.c | 45 +++++++++++++++++++++++++++++----------
>>  include/linux/reboot-mode.h       |  3 ++-
>>  2 files changed, 36 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
>> index 8fc3e14638ea757c8dc3808c240ff569cbd74786..c8f71e6f661ae14eb72bdcb1f412cd05faee3dd9 100644
>> --- a/drivers/power/reset/reboot-mode.c
>> +++ b/drivers/power/reset/reboot-mode.c
>> @@ -3,13 +3,17 @@
>>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>>   */
>>
>> +#define pr_fmt(fmt)    "reboot-mode: " fmt
>> +
>>  #include <linux/device.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>> +#include <linux/list.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/reboot.h>
>>  #include <linux/reboot-mode.h>
>> +#include <linux/slab.h>
>>
>>  #define PREFIX "mode-"
>>
>> @@ -69,17 +73,26 @@ static int reboot_mode_notify(struct notifier_block *this,
>>  /**
>>   * reboot_mode_register - register a reboot mode driver
>>   * @reboot: reboot mode driver
>> + * @fwnode: Firmware node with reboot-mode configuration
>>   *
>>   * Returns: 0 on success or a negative error code on failure.
>>   */
>> -int reboot_mode_register(struct reboot_mode_driver *reboot)
>> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle *fwnode)
>>  {
>>         struct mode_info *info;
>> +       struct mode_info *next;
>> +       struct device_node *np;
>>         struct property *prop;
>> -       struct device_node *np = reboot->dev->of_node;
>>         size_t len = strlen(PREFIX);
>>         int ret;
>>
>> +       if (!fwnode)
>> +               return -EINVAL;
>> +
>> +       np = to_of_node(fwnode);
>> +       if (!np)
>> +               return -EINVAL;
>> +
>>         INIT_LIST_HEAD(&reboot->head);
>>
>>         mutex_init(&reboot->rb_lock);
>> @@ -89,28 +102,28 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>                         if (strncmp(prop->name, PREFIX, len))
>>                                 continue;
>>
>> -                       info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> 
> This change is good - devres should not be used in subsystem library
> code, only in drivers - but it doesn't seem to belong here, can you
> please separate it out and make it backportable?

sure. Just to confirm we should separate out the devm_kzalloc part of the
change and add a fixes tag.
 
> 
>> +                       info = kzalloc(sizeof(*info), GFP_KERNEL);
>>                         if (!info) {
>>                                 ret = -ENOMEM;
>>                                 goto error;
>>                         }
>>
>>                         if (of_property_read_u32(np, prop->name, &info->magic)) {
>> -                               dev_err(reboot->dev, "reboot mode %s without magic number\n",
>> -                                       info->mode);
>> -                               devm_kfree(reboot->dev, info);
>> +                               pr_err("reboot mode %s without magic number\n", info->mode);
>> +                               kfree(info);
>>                                 continue;
>>                         }
>>
>>                         info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>>                         if (!info->mode) {
>>                                 ret =  -ENOMEM;
>> +                               kfree(info);
>>                                 goto error;
>>                         } else if (info->mode[0] == '\0') {
>>                                 kfree_const(info->mode);
>> +                               kfree(info);
>>                                 ret = -EINVAL;
>> -                               dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
>> -                                       prop->name);
>> +                               pr_err("invalid mode name(%s): too short!\n", prop->name);
>>                                 goto error;
>>                         }
>>
>> @@ -123,8 +136,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>                 return 0;
>>
>>  error:
>> -               list_for_each_entry(info, &reboot->head, list)
>> +               list_for_each_entry_safe(info, next, &reboot->head, list) {
>> +                       list_del(&info->list);
> 
> Same here, not deleting the entries currently seems like a bug? Do we
> depend on the driver detach to clean up the resources on failure?

sure, so this should also go as fixes? and should we remove the other
dev_err(printk) also as fixes? or that can still got with the change
where we add fwnode based registration?

thanks for review!

-
Shivendra

