Return-Path: <linux-kernel+bounces-644492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E922AB3D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A7518880D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC024BC09;
	Mon, 12 May 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KXhXSW/W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38312248F48
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066395; cv=none; b=W9LIPj522evjiFrY9qm2A1IgLe0KjWjxT1q0fcF7KOUreulFs0AhgUyrpcn4JXiPicIv0X01qPPCEr0BjH1aAppgoArr9eX9GMtBEgy/3oUbNubdJ7vqoVzCNvKoBNgqJAF25TLn+WcIb49oOUhLg1oYi5pIVNAnJD/6ExjXses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066395; c=relaxed/simple;
	bh=wSscZFDci+GklEPP5sxWeodE9FH+E156G4E33TsMtNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONRvzeKzNu3Ht3jzI1skJ7hbcg/IcxVi9ySdsoSOlBE/dcIy+KMKHjHY7mXinnOwQw+HQRZJI5NIOf0Py03CmKtgGNm+H51sjzG70miQsSL1TKPDpxYrDb5jO6OVlBT4Fc3E2WPIOs3TTL8KYc+03MqcM7B5UzgdA0BRdwmRNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KXhXSW/W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C9OwLQ023949
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 16:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	amvZXBUJq1R79vCZLDOP60gn88BreJJlf8jn55KXh1s=; b=KXhXSW/Wa5PkzgJi
	vpfsYcG9JMoMwQqq0GCzYCrwKoCav+21jzMRgOREA1Wq2fWy5iBEdm8w+b/mhbxa
	1ZMX8mia1yDAGIPHFa3Huw9Is2RKf0wLa3u919x25OMudRblHwkCGx+slbyGkxyr
	wKYuh4yimY9lEQlnRUGY8fTIOW4pZcorEkt7dqFVtqZJE8+UZFTyqQeMIFWKBhAw
	5Hhn5ZK+6c9dm5/f79jMGDRlprIPH3vLthC0sBpQYD/+Cy9L2UHk7tO2zUtNn5bb
	n39JX7GjXsCHFNfQ9CuCPR/6xsaazpagF2HDrH+4hh9Heez8PVXxspQ+KwHKtXvc
	KV6Yhw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hy15vwmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 16:13:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b1f71ae2181so2647164a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 09:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066391; x=1747671191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amvZXBUJq1R79vCZLDOP60gn88BreJJlf8jn55KXh1s=;
        b=JRXmGf/lGczYRevov2NGOaoY5uV2mio7Z/jAAp+uZmXBEEZ9S2mxn1Sn5aejo/d8yC
         BtpOhhbBqTAtdTImJ1V86XAFg3/b3fzmmsrHLQwPVIjuI3EDb8+Kyl7ZdcRTiajS1PAR
         tQq+KqxLKqgb5NuAJDSp4LPNGgy+NzkEQGpkzqs7tB6OyJEEknIqKMgovJ2ZwWlzsL6f
         YUdMORohyB57yNUJundDxKKnaOqkQUTfBPAFcCTFozMLcMnYWrTgv8DZyu6YO9v9Ma86
         EEkXVBg7xoHpduLB9FNPnmzSEv6vOAKK767jJGJxJJLJ3h8i/vwrBZ2oyfatXDeKGqU9
         Nz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXemv5BTsZs7GtjolvErgTYQixCTpWeBYsIdbgKas0kGwPYgbkpuHjBVSUlY2R9IQCWsL1OQZKyj/5o56Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgcdPQd4XQXCD/kb00xVDKIxL8GpilMin+ww+5rt+nrD2fixe
	7307FgSb8yhOTQ6mgeDVSoemPNhYlDFhDd6umqw0s4S3Rh96QqXT1gqB6nh/2zlPuJp4j2QFoD3
	M7zJ4Zf1bct8QBqrlkzic4QjJHGPNdR/j4rKGuw2szdfia4qMzOlCj+0AF0neO6I=
X-Gm-Gg: ASbGncsG0p5guCEoCn+nNXwot+I++wBFvj1Wi7Q6XAUx8OB4XzlmwCXx0AqD3peNrgw
	g2tLUKW29U3RC8p1XQ2CBkEjVFn03vCuiW8TqiRTW2/SR8x5YtryRmMF4fCng1dbxaQM7ipmaim
	UpCHaGC9tAY1mbLQunHCl2WrjS0/FXOBD+pR/QjFDxtHx9n4+tRiDPVLD/yM01xsV6DP9FHw0H6
	edWpkLDMJ0/VSuLYVD9NSZRbLPpNIobVNp0XqNv7/T1jORrcpBzkLrxSdjWIDtm8D6Zh7AtBm/5
	l8pjFbaJHP9jMx5T2qIE1aamCfpKSWUvTBHouoy7nks=
X-Received: by 2002:a17:903:32ca:b0:22d:b243:2fee with SMTP id d9443c01a7336-22fc8b40d39mr159152545ad.13.1747066391123;
        Mon, 12 May 2025 09:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwPmbiDVlVug0D2IWmcYoJ0j6J81nupU7Z//T3IyuBHPPGKeZRZFhpNIYZOdqwqFyHk05FWQ==
X-Received: by 2002:a17:903:32ca:b0:22d:b243:2fee with SMTP id d9443c01a7336-22fc8b40d39mr159152045ad.13.1747066390629;
        Mon, 12 May 2025 09:13:10 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.230.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82705e5sm65497445ad.120.2025.05.12.09.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 09:13:10 -0700 (PDT)
Message-ID: <9b662513-2c71-8829-3ec8-c789a919809a@oss.qualcomm.com>
Date: Mon, 12 May 2025 21:42:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH v6] PCI: PCI: Add pcie_link_is_active() to
 determine if the PCIe link is active
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.o>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com, Dmitry Baryshkov <lumag@kernel.org>,
        Timothy Pearson <tpearson@raptorengineering.com>
References: <20250509180813.2200312-1-sanastasio@raptorengineering.com>
 <84ce803d-b9b6-0ae7-44fa-c793dca06421@linux.intel.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <84ce803d-b9b6-0ae7-44fa-c793dca06421@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JblNe4wpM3x6xJJcEl0GS07KPYIwDnQB
X-Proofpoint-ORIG-GUID: JblNe4wpM3x6xJJcEl0GS07KPYIwDnQB
X-Authority-Analysis: v=2.4 cv=P9U6hjAu c=1 sm=1 tr=0 ts=68221e18 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=m9Fid+qPLYWXQ4ltJ96dlQ==:17
 a=DLE-xEQoUa54y48t:21 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_AprYWD3AAAA:8 a=EAN-j5rC4mQB3tSf1cAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2NyBTYWx0ZWRfX1hpjY+SW6mhL
 FUy8GJy4iFluI5b2L21HOOSgBBMkgwx/9Z4LbpfJA9mrL3OhRIR7lKorDzDC/i8EwiGdqsAjGq+
 Y/t8btkoIbAKl3QlPz9iT3k8zhktarEMyGBTodLSa5N0deTCDMLQF4Va+Y9QG+xIhYEWjHQrzQ+
 u/VAD1OYsQzNRkbhWC9Cq3165cCm1drn//aOgdhrqlGmJxdZOP+zmswGRjEx96diqFLmZ6LzVtt
 EWeixywh9KRksKAhl/DQe/+anCwYeqFRIOdOkLnAxBahdcEQfkkTjZgVCTNLpvTbDY7ZGnbK6rh
 v6hkhYfU+Q76ZTRwvmR+M2gXMSmdchmyaGPlTBdQApOET6U3AFO9XbkrK/2i4xewXmm9w7Mixd8
 4z2hXOoDlzsixwmU9U3WnbbNHwlMiHv/I2iTTxDlj2f2hs541OeU2VP0HdaSqA1OLeXIj0v/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120167



On 5/12/2025 5:20 PM, Ilpo Järvinen wrote:
> On Fri, 9 May 2025, Shawn Anastasio wrote:
> 
> In shortlog:
> 
> PCI: PCI: ... -> PCI: ...
> 
>> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>
>> Date: Sat, 12 Apr 2025 07:19:56 +0530
>>
>> Introduce a common API to check if the PCIe link is active, replacing
>> duplicate code in multiple locations.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
>> ---
>> (Resent since git-send-email failed to detect the Subject field from the patch
>> file previously -- apologies!)
>>
>> This is an updated patch pulled from Krishna's v5 series:
>> https://patchwork.kernel.org/project/linux-pci/list/?series=952665
>>
>> The following changes to Krishna's v5 were made by me:
>>    - Revert pcie_link_is_active return type back to int per Lukas' review
>>      comments
>>    - Handle non-zero error returns at call site of the new function in
>>      pci.c/pci_bridge_wait_for_secondary_bus
>>
>>   drivers/pci/hotplug/pciehp.h      |  1 -
>>   drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
>>   drivers/pci/hotplug/pciehp_hpc.c  | 33 +++----------------------------
>>   drivers/pci/pci.c                 | 26 +++++++++++++++++++++---
>>   include/linux/pci.h               |  4 ++++
>>   5 files changed, 31 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
>> index 273dd8c66f4e..acef728530e3 100644
>> --- a/drivers/pci/hotplug/pciehp.h
>> +++ b/drivers/pci/hotplug/pciehp.h
>> @@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *ctrl);
>>   int pciehp_card_present(struct controller *ctrl);
>>   int pciehp_card_present_or_link_active(struct controller *ctrl);
>>   int pciehp_check_link_status(struct controller *ctrl);
>> -int pciehp_check_link_active(struct controller *ctrl);
>>   void pciehp_release_ctrl(struct controller *ctrl);
>>
>>   int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index d603a7aa7483..4bb58ba1c766 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -260,7 +260,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>   	/* Turn the slot on if it's occupied or link is up */
>>   	mutex_lock(&ctrl->state_lock);
>>   	present = pciehp_card_present(ctrl);
>> -	link_active = pciehp_check_link_active(ctrl);
>> +	link_active = pcie_link_is_active(ctrl->pcie->port);
>>   	if (present <= 0 && link_active <= 0) {
>>   		if (ctrl->state == BLINKINGON_STATE) {
>>   			ctrl->state = OFF_STATE;
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index 8a09fb6083e2..278bc21d531d 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
>>   	pcie_do_write_cmd(ctrl, cmd, mask, false);
>>   }
>>
>> -/**
>> - * pciehp_check_link_active() - Is the link active
>> - * @ctrl: PCIe hotplug controller
>> - *
>> - * Check whether the downstream link is currently active. Note it is
>> - * possible that the card is removed immediately after this so the
>> - * caller may need to take it into account.
>> - *
>> - * If the hotplug controller itself is not available anymore returns
>> - * %-ENODEV.
>> - */
>> -int pciehp_check_link_active(struct controller *ctrl)
>> -{
>> -	struct pci_dev *pdev = ctrl_dev(ctrl);
>> -	u16 lnk_status;
>> -	int ret;
>> -
>> -	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
>> -		return -ENODEV;
>> -
>> -	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
>> -	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
>> -
>> -	return ret;
>> -}
>> -
>>   static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
>>   {
>>   	u32 l;
>> @@ -467,7 +440,7 @@ int pciehp_card_present_or_link_active(struct controller *ctrl)
>>   	if (ret)
>>   		return ret;
>>
>> -	return pciehp_check_link_active(ctrl);
>> +	return pcie_link_is_active(ctrl_dev(ctrl));
>>   }
>>
>>   int pciehp_query_power_fault(struct controller *ctrl)
>> @@ -584,7 +557,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
>>   	 * Synthesize it to ensure that it is acted on.
>>   	 */
>>   	down_read_nested(&ctrl->reset_lock, ctrl->depth);
>> -	if (!pciehp_check_link_active(ctrl))
>> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>>   		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>>   	up_read(&ctrl->reset_lock);
>>   }
>> @@ -884,7 +857,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
>>   	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
>>   				   PCI_EXP_SLTSTA_DLLSC);
>>
>> -	if (!pciehp_check_link_active(ctrl))
>> +	if (!pcie_link_is_active(ctrl_dev(ctrl)))
>>   		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>>
>>   	return 0;
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e77d5b53c0ce..3bb8354b14bf 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4926,7 +4926,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>>   		return 0;
>>
>>   	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
>> -		u16 status;
>>
>>   		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
>>   		msleep(delay);
>> @@ -4942,8 +4941,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>>   		if (!dev->link_active_reporting)
>>   			return -ENOTTY;
>>
>> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
>> -		if (!(status & PCI_EXP_LNKSTA_DLLLA))
>> +		if (pcie_link_is_active(dev) <= 0)
>>   			return -ENOTTY;
>>
>>   		return pci_dev_wait(child, reset_type,
>> @@ -6247,6 +6245,28 @@ void pcie_print_link_status(struct pci_dev *dev)
>>   }
>>   EXPORT_SYMBOL(pcie_print_link_status);
>>
>> +/**
>> + * pcie_link_is_active() - Checks if the link is active or not
>> + * @pdev: PCI device to query
>> + *
>> + * Check whether the link is active or not.
>> + *
>> + * Return: link state, or -ENODEV if the config read failes.
> 
> "link state" is bit vague, it would be better to document the values
> returned more precisely.
> 
>> + */
>> +int pcie_link_is_active(struct pci_dev *pdev)
>> +{
>> +	u16 lnk_status;
>> +	int ret;
>> +
>> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
>> +		return -ENODEV;
>> +
>> +	pci_dbg(pdev, "lnk_status = %x\n", lnk_status);
>> +	return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
>> +}
>> +EXPORT_SYMBOL(pcie_link_is_active);
>> +
>>   /**
>>    * pci_select_bars - Make BAR mask from the type of resource
>>    * @dev: the PCI device for which BAR mask is made
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 51e2bd6405cd..a79a9919320c 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1945,6 +1945,7 @@ pci_release_mem_regions(struct pci_dev *pdev)
>>   			    pci_select_bars(pdev, IORESOURCE_MEM));
>>   }
>>
>> +int pcie_link_is_active(struct pci_dev *dev);
> 
> Is this really needed in include/linux/pci.h, isn't drivers/pci/pci.h
> enough (for pwrctrl in the Krishna's series)?
>
As this is generic functions, the endpoint drivers can also
use this API to check if link is active or not in future.

- Krishna Chaitanya.

>>   #else /* CONFIG_PCI is not enabled */
>>
>>   static inline void pci_set_flags(int flags) { }
>> @@ -2093,6 +2094,9 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>>   {
>>   	return -ENOSPC;
>>   }
>> +
>> +static inline bool pcie_link_is_active(struct pci_dev *dev)
>> +{ return false; }
> 
> This fits on one line just fine.
> 

