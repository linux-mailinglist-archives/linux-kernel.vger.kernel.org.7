Return-Path: <linux-kernel+bounces-741795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C852B0E90A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8344E4932
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC192153E7;
	Wed, 23 Jul 2025 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ITilmGC/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4451798F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241091; cv=none; b=KxcXR0Xl61hc96HtMUyoPcopvFiEZtBVuKaOLandh+rYClyXffSBzkyouTVq5ExaqbPU7hlk5nBe2BtDzQyh5WwQOMlrJDcXfenO51TWCg+ePIsUi0dBUH45h1/5MrUsXeiREMdgUQEZnLWZZyH4qV8SF7ZZp1D7Qj8FZ5HMeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241091; c=relaxed/simple;
	bh=R2Dmdr9tuOF+l9Khf4bJW2DCkfXlv7VUNcZi4lQg55M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAuaEKB6htjUu7PsnRUPRkgLD8gYzFDnXrAy964Cnvxt4c28FquhwNZ0me6ASxRswjLGtINhndVFJCNufBHu0fJrUDemvSB0uhD1A0IewyK669zlW394l0IMOUqUQmiu2y40EbTO/7fOGmR22L9j0Y7jmaPNp+xzFwiPjk5WZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ITilmGC/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMOaaI001641
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8n+8uWujLuYMvL3SLvYwqmxBDPimubslCt++8eneS4=; b=ITilmGC/2thWYfXl
	EKjXyHMD/U2WFBXMqBZANPXoiUkFsoWHQ0Qvmzc/iqHkSiwPPSVfY5Pv7I0aQ6Dc
	2tRhKDnqF43apHRTnNXInW09cZ8ZqzD9nzWfKrPrgZGEDp9vEvjCFFxaTaMqvkTN
	6uidnZXFFnkyxr8Nm+JEC8aKynlMx2pmlSQOpXhViieVOULpIuskZ9I39P+11lH7
	v52Yyxg3SODXeXAe1yAH19lJWWcOMyRdpquR5BSqvTPzZ5ZBLNNeHrwpG3KguaUT
	110mHatTtwXkvsrDzfNEBNJpYiGxAY0H+POrxklAZCaWwseGpGOOp9uz9E3gAh5Y
	6b5EJQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045w20d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:24:48 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-756a4884dfcso5986431b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753241087; x=1753845887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8n+8uWujLuYMvL3SLvYwqmxBDPimubslCt++8eneS4=;
        b=S0poj+b+r5MXscKPMQ3mLMdSYNEsHMasvhUS0TR/AvCO7/m5OjWTbjHgI42NYKIkq3
         VOM2Rj8geqDyVU7XuiydxxLy6Q5eid2dve90RcrdG3AN6PQe+VAs/fHSmSsYwxRRw3H2
         e5nmMDN18RzSBQir3JFt/+oU6c8qtH+4c8lrES9hCMFeZpjqH7m5QAXooga8zN2LRDYs
         whvd9wK2YCMhj6OAcPq5B0QFFr0kt6ymgKP2I6QKxQ4nG9FimsEkZplKQCEFOoNlUr5X
         EaY2R5zLVGbgjiU3Ao3zTco9h2igFc0L7NCS1NFRp8aWsWyONbqU0icloRlsQwDu201F
         fUWA==
X-Forwarded-Encrypted: i=1; AJvYcCU9D5yP7st11FndJRmi7wVqMZnVCOrTlN34j7f+zEHPZop9dwPM6Yw01VIvFQZMM3jGHKW0v/UgkeC3RuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMaS+XIYdBJaTUiiHukHVbksjmlCof7tliZ7dLJUP+kSxW1onk
	oZsOKwHfDHqSn5JFxxAF27udzeDPS8c2IEflpEso60uPgWuaPQaDDSG5yBPffX4z11UffK2KEXi
	0u8MguOpPReoibnLVpz9UoFuphFLBerDSdjgDEvQgsjhsvU6eWTo1WoUlyFmVETAxbKg=
X-Gm-Gg: ASbGnctajlHgaoJ7A40v9iCg4adSOb9Z72DOsA6JA58vCC/URzUOH9vJkyd8YD0xYZZ
	EzI5nXZzNfExKpj1x7ZUQM14IlhM9vLuH3o6gFtOdSDurpZf11CvQhqttY9rQ3tCMI/sYhDHkFK
	oB3l7s6GOyB1etY0J1EMemjtBsK668hlgXg1XqekMya76t5frZtC4t3oviTG9oLvPg0XkNhnydn
	RG3an8H3aR7NRrh0Ivt2Wti0D0PkmcpUdUPivQ7PBabaqwGEToAU0gqZgSdx0D+SZp5bvMAvrT+
	BviX2f4qnVG6oF3oJUt4Mmv3qcOI2GEieBH1SjmgT2bPMYTsjPkfujLq6Tl9J2sIUzNnIiOBWzk
	r+oBgZMStjCWW1NRr2PDSiH0=
X-Received: by 2002:a05:6a00:240e:b0:742:a91d:b2f6 with SMTP id d2e1a72fcca58-76035de66e4mr1927073b3a.13.1753241087174;
        Tue, 22 Jul 2025 20:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1W9dErGsuen1JMFdnRN4+DUuAUP5DslythGcHBqzx4Q1es9M5TIOjeZXeBgD1kq1Bn+Y8AQ==
X-Received: by 2002:a05:6a00:240e:b0:742:a91d:b2f6 with SMTP id d2e1a72fcca58-76035de66e4mr1927035b3a.13.1753241086641;
        Tue, 22 Jul 2025 20:24:46 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e25besm8519102b3a.2.2025.07.22.20.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 20:24:45 -0700 (PDT)
Message-ID: <f7eb8a35-e17b-4324-a1a1-38a097d4b3cf@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 11:24:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND 09/10] coresight: tmc: add read function for
 byte-cntr
To: Mike Leach <mike.leach@linaro.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
 <20250714063109.591-10-jie.gan@oss.qualcomm.com>
 <CAJ9a7Vj_NfO7D+j11_7DbgWD-Cn9cQp4g=r9EqHMZiAU63NomQ@mail.gmail.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <CAJ9a7Vj_NfO7D+j11_7DbgWD-Cn9cQp4g=r9EqHMZiAU63NomQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=68805600 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=8LhnbAA9U_lrlzpm6J0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: LW2PlEV1j7RCeerxIsRCNyodACwOZvvo
X-Proofpoint-ORIG-GUID: LW2PlEV1j7RCeerxIsRCNyodACwOZvvo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAyNiBTYWx0ZWRfX65vpL5hUhYY/
 p0ELLReycjrgxgmrBVcoypKt+VrdyXKFMFAWZH13r26a5+pJlExN9LhMadWYqr1dA7tdPME861y
 tAauOYGCyfN910WPTQFCIALPA62LNrWjnnXeYgqdiNEV/MGPU3Zb7nOFoB02PhvvgDME41zMbEa
 i9pM7KxJ1YYPz0MWOh1j88KABlUYIILb9EhIw2712Hv37tGm9xYMxzktfU93ZypUHv73LXcXIbX
 dEtjvZ8CdFS/jaJNikMCtw3iRdAON1fF5w0fqcrSs/0SfIN4Ql/YfsOfIqrtGqqMndAMrAmPg5/
 +X84wjbVq1dI95GgrVNiUYxKoclnnY0yhTncdp0jxWyqwsC4Z6Ifjw3wiRERmvMZ2u9aeDVQP7P
 c7W+3CGLCQGaiYlFT5fSchGBkrQLepzMnDj8u4B/xnLAixohIOkw53YNkyc0oRKBuNsK+/Xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230026



On 7/22/2025 11:01 PM, Mike Leach wrote:
> Hi,
> 
> On Mon, 14 Jul 2025 at 07:32, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>
>> The byte-cntr read function always reads trace data from the deactivated
>> and filled buffer which is already synced. The read function will fail
>> when the ETR cannot find a available buffer to receive trace data.
>>
>> The read function terminates when the path is disabled or interrupted by a
>> signal.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   .../hwtracing/coresight/coresight-tmc-core.c  | 31 ++++++-
>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 90 +++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tmc.h   |  3 +
>>   3 files changed, 120 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index 354faeeddbb2..3ab25adc4e4d 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -318,14 +318,18 @@ static int tmc_open(struct inode *inode, struct file *file)
>>          return 0;
>>   }
>>
>> -static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata, loff_t pos, size_t len,
>> -                                  char **bufpp)
>> +static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
>> +                                  struct ctcu_byte_cntr *byte_cntr_data,
>> +                                  loff_t pos, size_t len, char **bufpp)
> 
> Don't change "core" functionalilty to add in bytecntr parameters.
> 
> Use helper functions to have a pattern such as:
> 
> if (bytecntr_active())
>      call_byte_cntr_fn()
> else
>      call_standard_fn()

got it. Will fix in next version.

Thanks,
Jie

> 
>>   {
>>          switch (drvdata->config_type) {
>>          case TMC_CONFIG_TYPE_ETB:
>>          case TMC_CONFIG_TYPE_ETF:
>>                  return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
>>          case TMC_CONFIG_TYPE_ETR:
>> +               if (byte_cntr_data && byte_cntr_data->thresh_val)
>> +                       return tmc_byte_cntr_get_data(drvdata, byte_cntr_data, len, bufpp);
>> +
>>                  return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
>>          }
>>
>> @@ -339,7 +343,21 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>>          ssize_t actual;
>>          struct tmc_drvdata *drvdata = container_of(file->private_data,
>>                                                     struct tmc_drvdata, miscdev);
>> -       actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
>> +       struct coresight_device *helper = coresight_get_helper(drvdata->csdev,
>> +                                               CORESIGHT_DEV_SUBTYPE_HELPER_CTCU);
>> +       struct ctcu_byte_cntr *byte_cntr_data = NULL;
>> +       struct ctcu_drvdata *ctcu_drvdata = NULL;
>> +       int port;
>> +
>> +       if (helper) {
>> +               port = coresight_get_port_helper(drvdata->csdev, helper);
>> +               if (port >= 0) {
>> +                       ctcu_drvdata = dev_get_drvdata(helper->dev.parent);
>> +                       byte_cntr_data = &ctcu_drvdata->byte_cntr_data[port];
>> +               }
>> +       }
>> +
>> +       actual = tmc_get_sysfs_trace(drvdata, byte_cntr_data, *ppos, len, &bufp);
>>          if (actual <= 0)
>>                  return 0;
>>
>> @@ -349,7 +367,12 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>>                  return -EFAULT;
>>          }
>>
>> -       *ppos += actual;
>> +       if (byte_cntr_data && byte_cntr_data->thresh_val) {
>> +               byte_cntr_data->total_size += actual;
>> +               drvdata->reading_node->pos += actual;
>> +       } else
>> +               *ppos += actual;
>> +
>>          dev_dbg(&drvdata->csdev->dev, "%zu bytes copied\n", actual);
>>
>>          return actual;
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 3e3e1b5e78ca..174411e76047 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1163,6 +1163,10 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
>>          ssize_t actual = len;
>>          struct etr_buf *etr_buf = drvdata->sysfs_buf;
>>
>> +       /* Reading the buffer from the buf_node if it exists*/
>> +       if (drvdata->reading_node)
>> +               etr_buf = drvdata->reading_node->sysfs_buf;
>> +
>>          if (pos + actual > etr_buf->len)
>>                  actual = etr_buf->len - pos;
>>          if (actual <= 0)
>> @@ -1339,6 +1343,92 @@ static bool tmc_byte_cntr_switch_buffer(struct tmc_drvdata *drvdata,
>>          return found_free_buf;
>>   }
>>
>> +/*
>> + * tmc_byte_cntr_get_data() - reads data from the deactivated and filled buffer.
>> + * The byte-cntr reading work reads data from the deactivated and filled buffer.
>> + * The read operation waits for a buffer to become available, either filled or
>> + * upon timeout, and then reads trace data from the synced buffer.
>> + */
> 
> This entire function should be moved to one of the byte-cntr source files.
> 
>> +ssize_t tmc_byte_cntr_get_data(struct tmc_drvdata *drvdata,
>> +                              struct ctcu_byte_cntr *byte_cntr_data,
>> +                              size_t len, char **bufpp)
>> +{
>> +       size_t thresh_val = byte_cntr_data->thresh_val;
>> +       atomic_t *irq_cnt = &byte_cntr_data->irq_cnt;
>> +       struct etr_buf *sysfs_buf = drvdata->sysfs_buf;
>> +       struct device *dev = &drvdata->csdev->dev;
>> +       struct etr_buf_node *nd, *next;
>> +       ssize_t size = sysfs_buf->size;
>> +       ssize_t actual;
>> +       loff_t pos;
>> +       int ret;
>> +
>> +wait_buffer:
>> +       if (!byte_cntr_data->reading_buf) {
>> +               ret = wait_event_interruptible_timeout(byte_cntr_data->wq,
>> +                               ((atomic_read(irq_cnt) + 1) * thresh_val >= size) ||
>> +                               !byte_cntr_data->enable,
>> +                               BYTE_CNTR_TIMEOUT);
>> +               if (ret < 0)
>> +                       return ret;
>> +               /*
>> +                * The current etr_buf is almost full or timeout is triggered,
>> +                * so switch the buffer and mark the switched buffer as reading.
>> +                */
>> +               if (byte_cntr_data->enable) {
>> +                       if (!tmc_byte_cntr_switch_buffer(drvdata, byte_cntr_data)) {
>> +                               dev_err(dev, "Switch buffer failed for byte-cntr\n");
>> +                               return -EINVAL;
>> +                       }
>> +
>> +                       byte_cntr_data->reading_buf = true;
>> +               } else {
>> +                       if (!drvdata->reading_node) {
>> +                               list_for_each_entry_safe(nd, next, &drvdata->etr_buf_list, node) {
>> +                                       if (nd->sysfs_buf == sysfs_buf) {
>> +                                               nd->pos = 0;
>> +                                               drvdata->reading_node = nd;
>> +                                               break;
>> +                                       }
>> +                               }
>> +                       }
>> +
>> +                       pos = drvdata->reading_node->pos;
>> +                       actual = tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
>> +                       if (actual > 0)
>> +                               return actual;
>> +
>> +                       drvdata->reading_node = NULL;
>> +
>> +                       /* Exit byte-cntr reading */
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       /* Check the status of current etr_buf*/
>> +       if ((atomic_read(irq_cnt) + 1) * thresh_val >= size)
>> +               /*
>> +                * Unlikely to find a free buffer to switch, so just disable
>> +                * the ETR for a while.
>> +                */
>> +               if (!tmc_byte_cntr_switch_buffer(drvdata, byte_cntr_data))
>> +                       dev_info(dev, "No available buffer to store data, disable ETR\n");
>> +
>> +       pos = drvdata->reading_node->pos;
>> +       actual = tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
>> +       if (actual == 0) {
>> +               /* Reading work for marked buffer has finished, reset flags */
>> +               drvdata->reading_node->reading = false;
>> +               byte_cntr_data->reading_buf = false;
>> +               drvdata->reading_node = NULL;
>> +
>> +               /* Nothing in the buffer, wait for next buffer to be filled */
>> +               goto wait_buffer;
>> +       }
>> +
>> +       return actual;
>> +}
>> +
>>   static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>>   {
>>          int ret = 0;
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 1dbba0bc50a3..4136ec5ecaf7 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -364,6 +364,9 @@ int tmc_read_prepare_byte_cntr(struct tmc_drvdata *drvdata,
>>                                 struct ctcu_byte_cntr *byte_cntr_data);
>>   int tmc_read_unprepare_byte_cntr(struct tmc_drvdata *drvdata,
>>                                   struct ctcu_byte_cntr *byte_cntr_data);
> 
> Declare this in a byte_cntr header file, not here.

I will add it to,for example, ctcu_byte_cntr_read_ops->read.
So I think I dont need define it in any header file in future.
Will remove it.

Thanks,
Jie

> 
>> +ssize_t tmc_byte_cntr_get_data(struct tmc_drvdata *drvdata,
>> +                              struct ctcu_byte_cntr *byte_cntr_data,
>> +                              size_t len, char **bufpp);
>>
>>   #define TMC_REG_PAIR(name, lo_off, hi_off)                             \
>>   static inline u64                                                      \
>> --
>> 2.34.1
>>
> 
> 


