Return-Path: <linux-kernel+bounces-741798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89808B0E90E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA3056531D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726E7242D9C;
	Wed, 23 Jul 2025 03:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgDDuuYt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354DA242D7B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241365; cv=none; b=o0x5sUESXVr6Iyk9ptildW5qpKY9ATsg8rSD1uNRMpptPDSEuxdJITWJi8O3hcCG1IQhPkrCkDUw7p4Ym9g3rOr0pja74piy/pgIVB7jZp7kGaXzhk6chVUN6k+0HlyvN7YowHOBxfvNd75kq9DZeBygrMxX4dF8oXpTGB60hsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241365; c=relaxed/simple;
	bh=SJJ5CneRaxtKMDIEUXqqNF9XrcyVKRQFQumyQuT1MZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDxuvUVa0HswSWVQ1Kpf5MHmrrH9PSBuqaMryxHr07gs4bkhhE8OPEEVhRzJpp79twXhGiIURd2FkiMvWZNvgbJUfGqsWcp0gatGUNOL6cjWU6o/lUke+P0aIzamJuBsaJato+IguEwGX6LBs1UFhlJoMkiseADBL84FFMvE+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LgDDuuYt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMOcNv001674
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GcRiJdqepO/ljPzq51yX3pTfKYPsMIe1eMnpPQHw5lM=; b=LgDDuuYtvjfjdbfk
	ukxxOgRGVQNnf52cnAPhdd4iAIevLrHx1Yei/W/9VA/sv+fb3OznEBFpv6OAUJQ5
	NLmJGZUkinfImkPENSzlLxLfDH4o/0cHkIYWr5uQ+XnQsI0fQqw6QuEB8a/vvKKO
	V9NUegxZMmMuCj1BuidjviST0AdS1BIDmUzIteTbwsrVIyDS+/0ktQxdIsrGWvxB
	jH2KGjInZi+nfOKBaTlUiVWDfwL6SNdxy+uoTLeyURwMRoC3woHNalcpJyuKHciP
	Yw6et6miFkG6Ad/Gg7ZCyGDxNl+fa/F0Efat7CJuOEHaGk0OTZXKvxCJlpeOw+Zk
	YUQHUg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045w20pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:29:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23827190886so67153865ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753241362; x=1753846162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcRiJdqepO/ljPzq51yX3pTfKYPsMIe1eMnpPQHw5lM=;
        b=NHM9m1osgG4xW4PK65tRg/ctbQMBoPiL2Swtfl4x8xlW75UjlLMVOvJ5UeJTVR5f5u
         rh27xIPEM6k5QY3h2kpTRyvjgLYTHSGjyaiy7pyhqDY0MkuPRQf5MSdKgLPbRkdm0lsl
         yNnoY4Zr/7WM+xu5HmIGYx/bESd8dJMcCE/ESd+iqGaiGh8A5yxkxFQr6oBOnfCWkb1u
         XWzCDHPH5ssomdzhwly9b3k6ZtmHkHSLUWfizUOeQ1p5dO/T5e7yCEuHod4U07rmPUjX
         ZCoQreoTv/AmrKRlqxnBaNlkXSAaZbO6MW6tjWvrlBB7iL5m/MTI8/ytWz9PHo/stsdz
         WAsw==
X-Forwarded-Encrypted: i=1; AJvYcCUn3+MPtvPhlit0IjhVicYcsy7FDCESPtrNf9FwvpeXD6hYqrdB21qAND4RmhQzIVMSYCUdhI7rU38HnEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIqFPF6n6zGR7yRzVDSZtSiKdwliwQOwaxDms9u7ckYTxTybr
	E4sX0gDmmcAqIT6bkLOOa8OVRaU6ilUCM0VBQY4pTmLASwFEPWofxNioPgcXx5f05wHGFlgpWXu
	iU4OQg2vt8d+hKsvT7DbFOgXw6zHlKXCsVyZiZ9w5FOPkWWu68oURpy/QdemvEqVAdtY=
X-Gm-Gg: ASbGncsYcLfu41uDw5vpbDW34jW8s5nSrc87F43jMoRNRtG9s2OeLrOosv2N8osDRWc
	sSx+IuDGXIz50pw32pZeM6zm6HlR4G4vkrbfJlL8xeOAfLBaodVDVkEdLr/o5kCST2yhwQBOBRx
	YEwvPgjzF0GJ6R5MwAI4MhHw5yk72nA79xsegwAIwTsh14cmaF1pPHLDSyMloOf4RhYokOVWnk9
	5WDE50oiiZomNUZawhLfTRJRtqSscy1BcquG0/CsG77USEn/7zJOqb0xQmSTD4Lsuj/ffJx49X8
	6WTR0xLWBaQ3IU7ECvilGXiVphxr2d7vhbEmKEkfEijO9sJmiOV9NN2Fxbm8fiF84I9Ej37P4a6
	sv52y6f4cFbJh3xzcf1TsTX8=
X-Received: by 2002:a17:902:f684:b0:234:ed31:fca7 with SMTP id d9443c01a7336-23f981db976mr18720715ad.48.1753241362420;
        Tue, 22 Jul 2025 20:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy1PnWRL2YDKxRY1ylTuYEKI0uH+mVP5x4g+cnb66HuHnPlsooq1YxXsS2pw2RklDksMxGAg==
X-Received: by 2002:a17:902:f684:b0:234:ed31:fca7 with SMTP id d9443c01a7336-23f981db976mr18720395ad.48.1753241361974;
        Tue, 22 Jul 2025 20:29:21 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6f2306sm86067305ad.213.2025.07.22.20.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 20:29:21 -0700 (PDT)
Message-ID: <85cada69-a0ad-48c6-9a6d-42b26a51c971@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 11:29:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND 08/10] coresight: tmc: add a switch buffer
 function for byte-cntr
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
 <20250714063109.591-9-jie.gan@oss.qualcomm.com>
 <CAJ9a7VhLXrdP_CPQPgAYTAGWJfsVUa9SG9Bzv9dLtFzR4nFROg@mail.gmail.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <CAJ9a7VhLXrdP_CPQPgAYTAGWJfsVUa9SG9Bzv9dLtFzR4nFROg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=68805713 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=3p4PawPDRryEjlqJgAUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: IenSEpZSW0aNh_uqQHbqJIqqOj2Whq4n
X-Proofpoint-ORIG-GUID: IenSEpZSW0aNh_uqQHbqJIqqOj2Whq4n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAyNyBTYWx0ZWRfX+rlpLtNUkDpD
 kujrhr5MUKAg/eoU7ZaUE82wvAAtOPO7coWILLVIW7jc3199we2FJyC6stc+fWiaKVkZjutTY27
 3y99lePyi1aamPYfdjfIez/wiWSxoc0nfDIJjktSVz7iexlHAddU1mGsLjETkPOo6DyjmrQBxin
 WdbkvmI+VcFh1gCVmtspHbDrAnrg31f1C6Bg8o7ErU4V4FvtlALooNfT3Ee7m7NpcFcpu/fVfr0
 nF4Lygn3nSwYCupceoA3YJEUgiwni/7RDepCS1ZXH8AHcCXyD/C1gD6owfNBPsXl6FajXUYIfzS
 hoLOeeyH6nmqWOpw39RzuNbdZxjfVD10Eu1+rI+BsPfJMngtaTZNrUotqN03/JHiy8jJPd6uH/0
 uStNE6l8tbeI8C2/hiLieJBFIiCrwlXIoISGfIXA/ALgfIYWy1Qsz9IO71cHN89I69XN/qI+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230027



On 7/22/2025 10:09 PM, Mike Leach wrote:
> Hi,
> 
> This buffer swap code looks OK in principle. The ETR is stopped,
> memory synced and set to be read.
> See other comments inline.
> 
> On Mon, 14 Jul 2025 at 07:31, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>>
>> Switching the sysfs_buf when current buffer is full or the timeout is
>> triggered and resets rrp and rwp registers after switched the buffer.
>> Disable the ETR device if it cannot find an available buffer to switch.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 2b73bd8074bb..3e3e1b5e78ca 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1287,6 +1287,58 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>>          return ret ? ERR_PTR(ret) : drvdata->sysfs_buf;
>>   }
>>
>> +static bool tmc_byte_cntr_switch_buffer(struct tmc_drvdata *drvdata,
>> +                                       struct ctcu_byte_cntr *byte_cntr_data)
>> +{
> 
> This entire function should be in one of the byte_cntr source files,
> not in the main etr files. Please keep byte cntr code separate as far
> as possible
> 
>> +       struct etr_buf_node *nd, *next, *curr_node, *picked_node;
>> +       struct etr_buf *curr_buf = drvdata->sysfs_buf;
>> +       bool found_free_buf = false;
>> +
>> +       if (WARN_ON(!drvdata || !byte_cntr_data))
>> +               return found_free_buf;
>> +
>> +       /* Stop the ETR before we start the switching process */
>> +       if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
> 
> Can this function be called if the mode is not CS_MODE_SYSFS?

Should be ok with called if the the is DISABLED.
I will check the condition.

> 
>> +               __tmc_etr_disable_hw(drvdata);
>> +
>> +       list_for_each_entry_safe(nd, next, &drvdata->etr_buf_list, node) {
>> +               /* curr_buf is free for next round */
>> +               if (nd->sysfs_buf == curr_buf) {
>> +                       nd->is_free = true;
>> +                       curr_node = nd;
>> +               }
>> +
>> +               if (!found_free_buf && nd->is_free && nd->sysfs_buf != curr_buf) {
>> +                       if (nd->reading)
>> +                               continue;
>> +
>> +                       picked_node = nd;
>> +                       found_free_buf = true;
>> +               }
>> +       }
>> +
>> +       if (found_free_buf) {
>> +               curr_node->reading = true;
>> +               curr_node->pos = 0;
>> +               drvdata->reading_node = curr_node;
>> +               drvdata->sysfs_buf = picked_node->sysfs_buf;
>> +               drvdata->etr_buf = picked_node->sysfs_buf;
>> +               picked_node->is_free = false;
>> +               /* Reset irq_cnt for next etr_buf */
>> +               atomic_set(&byte_cntr_data->irq_cnt, 0);
>> +               /* Reset rrp and rwp when the system has switched the buffer*/
>> +               CS_UNLOCK(drvdata->base);
>> +               tmc_write_rrp(drvdata, 0);
>> +               tmc_write_rwp(drvdata, 0);
> 
> This cannot possibly be correct. RWP / RRP are pointers into the
> system memory where the ETR stores data.

It should be sysfs_buf->hwaddr here.
I made a mistake.

will fix it.

> 
>> +               CS_LOCK(drvdata->base);
>> +               /* Restart the ETR when we find a free buffer */
>> +               if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
>> +                       __tmc_etr_enable_hw(drvdata);
> 
> What happens if the ETR is not restarted? Using __tmc_etr_disable_hw()
> is correct for this use case, but if you do not restart then the extra
> shutdown that would ordinarily happen in tmc_etr_disable_hw() does not
> occur. How is this handled in the rest of the update?

Yes, there is a problem here. It's incorrectly put a strict condition here.

I will check the logic here and fix in next version.

Thanks,
Jie

> 
>> +       }
>> +
>> +       return found_free_buf;
>> +}
>> +
>>   static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>>   {
>>          int ret = 0;
>> --
>> 2.34.1
>>
> 
> Regards
> 
> Mike
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK


