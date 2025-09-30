Return-Path: <linux-kernel+bounces-837106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4A1BAB638
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275EF3AD3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89D258CD0;
	Tue, 30 Sep 2025 04:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJhhCOqZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989A72617
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207242; cv=none; b=gnQgODnhYJ/KikEtiVtHJVSSJKqBJdUX1gKMU7pFIENurD5ZCn5Z0VX6aKLlqsCL+yNotVZgGSwymywRqDcD1UGFGyrPxqi9bKQrdtDPk2v1zlwByPiU0u/fd0XtN50eLAoAV4H3xEESqWyR/3qarVgNyz0FG4YVMR3GNrXk68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207242; c=relaxed/simple;
	bh=PpVmMYSb+/tXTMGNCXlspmC9JlcWSE+EmOiw9BxPBco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOmk1lPxRsn7Di1IYFzOjx+ctjvi+Nls3RtRi78rYt5Gnnvz5tT86PNLJr7Cj5/xWyeg4KrGPHB7iFJWYYTMUwmRy54diAcjjledrVkfHXe2TxEnFxSwxPQPd2udqpsUGoqcQyxKNpjZn22Eeu0+Gm3M5H/vSVu0QoENFthJk8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJhhCOqZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4I0EE027982
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9otk/yGXgsUm0pXvg0F1/ZcIsa5wQIuaLE+2nOJ/oEw=; b=NJhhCOqZw8CRTxSA
	5ZJvcIEy8RSG5o4+4tRgPUI+Db6XpniPWM0DmJ5mv2cWDSduU4Do9/LQbo8pX3NV
	doJhS9/pVq+BH1cy7xNCiAgOpLze9Aquk1mTNuPvyazcYjQGlY7kk1MQ4WtHROP0
	1xkwlAnKIxsIuOLtn6/HhF11Bj8KhgcbdvFwDTljjc2wXp0CA8lXP9U7+6YQGnOj
	JVJ/569zFvQm1YtIeLiJxLl8An8OCHskF1JfrQUhB255au6HhPArm5VK9GofHTdg
	YhGq027steHn5jCQz/n5zqAgVuERLOD1f52o64LE6WUSaYm2gAoy2NERh9JrQzpc
	gG0NnA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851fjcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:40:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-268141f759aso52045935ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759207238; x=1759812038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9otk/yGXgsUm0pXvg0F1/ZcIsa5wQIuaLE+2nOJ/oEw=;
        b=GQuLiaZcuzXr0LM0p5KlYQoUFrqoidTB4OHgTizvbfi4f2eSq0as1YJpKxG1MDSgKQ
         Rw8kvBDrIAMWk1ibTAkAKZeURuODzhi/svMzCBJYF7+SmwO/4fgjlpg17DbDMhYOLdjk
         AjdRC1VYnGtpyOFMC0KX9yNk1343nzeKAkZuH7GbzPSFSk2YXP2EW8JKC2EB+4Fw1VLO
         81WWWYRUtEuP0BjPM+yNPnjxNaXz++XiBxuKmGDaMvZczeI/iOehRQg6J/O/jSYEOL3k
         bUkIewda8cR0nLzTqqpqJ0Cp01/DSjRaOf7Zz5L6CKF0teI7EAheAQDdK06btss+MGLh
         2BwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQiHteOZ2L+JRvxn/0IaicGZaMxps3pi/5KaYfrrAz3fMTx5XIINPoqCJOAr0Hd03Hyz4kjMcN98OTuak=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDD8es8RqRRevcEaYXKF9s2FPta2K/xx8QrHazTh4skTnluZa
	Bv5aTL04JeIJU/pFeIoXWqUjI0FIPsrZy7bjNcjF30hWZblAu+r11+r6n7y6iNMUdZnQPM81KlS
	2WamAUxxeL6Vu+3Df/fc+ip37c8ZhB83GzrWhD0vU5c3EO6VWB+xQLrUAY+Fx30SVwKQ=
X-Gm-Gg: ASbGnct7IQYD9QxG2iQOwg104A/oGcwjfyUm+lqO/fw0B4SWXHPIjm6DJ3j+VG7IK6s
	mF/mNXvFLfLINFVgtbi0kLousdTIRYb2xE3v45NrDx33VCYF+PUxUplRBEr0m2M7heQn4nEVqPM
	/j5MHhjMvErXIMVLFlFuDiSX+JsKnGxd6q/bvGx+IGB4mTVMue1g7prANnqtKRHZRw37TlQ5K6j
	H7IfRT1Cad85LtwrWQtGfTKvWfuVH2Z7VwmNoLQEhcqahyoABr/S1EJHAK7I8SsD/GzEoHSbomW
	ImVAQsoWStqO1jKIZiItdhESmJ+XqNK7xGxmvT5VE9tY1qoN4zQ74lXITTkPtk2+o4SD3VHushn
	3
X-Received: by 2002:a17:903:ac4:b0:28d:18d3:46cb with SMTP id d9443c01a7336-28d18d34807mr26815125ad.20.1759207238521;
        Mon, 29 Sep 2025 21:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHurZVJdThhSMRhfXgQ+q0mqPgl7u6/CKCTRFKAXoWSFaDtn5ulaKgD9EWxKFZKgpufC6A6w==
X-Received: by 2002:a17:903:ac4:b0:28d:18d3:46cb with SMTP id d9443c01a7336-28d18d34807mr26814245ad.20.1759207238067;
        Mon, 29 Sep 2025 21:40:38 -0700 (PDT)
Received: from [10.204.86.68] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm146897755ad.9.2025.09.29.21.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 21:40:37 -0700 (PDT)
Message-ID: <37ac6311-bd88-4b8e-bf78-06fcdd8bdf6f@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 10:10:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] misc: fastrpc: Add support for new DSP IOVA
 formatting
To: Arnd Bergmann <arnd@arndb.de>, Jingyi Wang
 <jingyi.wang@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com>
 <20250924-knp-fastrpc-v1-1-4b40f8bfce1d@oss.qualcomm.com>
 <969bdb49-0682-4345-98f7-523404bb4213@app.fastmail.com>
Content-Language: en-US
From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
In-Reply-To: <969bdb49-0682-4345-98f7-523404bb4213@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68db5f47 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=bqvQEXuXJtI6iJ33JrsA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX2nY2TqH6aa0I
 FP12Gs7ag05r1Qo07dJU/PmFm8/WXUF2AZYxmf/ewxfq4FDKa/miUEZTTTfNp7qBisyfqgQRhOD
 ZInIBeyyMsYl5SzcpDgdn8sWl3m3Sv+WzL5DSEmha6/wNxtBzd2hTfyUv3dfTtF/UZmaZPcf22H
 BezujEVxjSuem/+hi81F+CpGoKmsdpM0zUASAAOFBUkqPJ8LY+gVjYyDu8ZsorFtC8gCr4+Wkl6
 Ew0JgdnCnlEc5EN/fr/Be0YXdket9QmjLD1SwU3e+Uko/YdKGqgz7xDFIxajwKpyoAutwVQmyxI
 EnRLGqIj4S4cHtH98NjGpioQVa5jkl9kXURPOh8LudMVs26n9GZiQl+Q6YbY5sNjuAwJiVh5P30
 ilUAEY6d6QlmAYPpUht5ypli0kr4HQ==
X-Proofpoint-ORIG-GUID: RGCkSmZPKHunHOpT8C341ZoT9tT3y-EU
X-Proofpoint-GUID: RGCkSmZPKHunHOpT8C341ZoT9tT3y-EU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032



On 9/25/2025 11:54 AM, Arnd Bergmann wrote:
> On Thu, Sep 25, 2025, at 01:46, Jingyi Wang wrote:
> 
>>   	dma_free_coherent(buf->dev, buf->size, buf->virt,
>> -			  FASTRPC_PHYS(buf->phys));
>> +			  IOVA_TO_PHYS(buf->phys, sid_pos));
>>   	kfree(buf);
>>   }
> 
> I understand what you are doing, but the naming of the macros
> seems a bit confusing: dma_free_coherent() and the related
> functions are designed to take an IOVA argument, not a physical
> address, so calling IOVA_TO_PHYS() before passing the
> address sounds wrong. This is made worse by the naming
> of 'buf->phys' that is not a physical address at all
> but already transformed twice into a dma_addr_t and
> from there into a dma_addr+sid tuple.
> 
> Ideally the SID handling would be abstracted behind a custom
> dma_map_ops implementation that treats this as a custom
> iommu, but if the fastrpc device is the only user of this
> address format, I can understand you want to keep this as
> a local hack in this driver.
> 
> Can you try to come up with some better naming here, and
> replace the 'phys' bits with something that is more fitting
> for an iova/dma_addr_t?
>

I will improve the naming for better clarity:

- Replace buf->phys with buf->dma_addr throughout the code.
- Rename the macro IOVA_TO_PHYS() to something more appropriate, like 
IPA_TO_DMA_ADDR()
>       Arnd

Thanks,
Pallavi

