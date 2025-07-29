Return-Path: <linux-kernel+bounces-748811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64AB1462D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78F11AA1D22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2131F4180;
	Tue, 29 Jul 2025 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y3sz8Fvp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603F200BBC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756090; cv=none; b=e9fyTsZ4y68K0yUB/5u4XwZ69QnFJw2kBwI9t80FEIORcHIUKR3C7rmqH8d8Tvlq7CpCfwc4x2kZdjq+7K118q1y7MWpwdpCGbof2M2a9M1V128PB/gY7xhBiMtrFxOz7qUY5rnW6lo2D4casYOE862BB048qgvF/7Z93UDH08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756090; c=relaxed/simple;
	bh=jouon6KURKobNUWdkGtiphkf9aDkVDi5Pv2w9Oj81SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTSbbn7+w93zP0fTqWxKrN1T0juIjBDXKjEFEJgo4gWuXxI6BnI1LW8mej4vhaRolsF1bHrv0UPPedQ1W/7csUjTYe6f3dVjRLhsgSPocg2df7ORFH7xuep+Vd1NCtZvS1RIp74KPkfCvdA66yB6lYvddVhzfQyojE9+OF6j3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y3sz8Fvp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SMGk51012528
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Bq+yWPTZtYMMhUvfg0Sv76S/fKoIvuEK9cXDqqvaPQ=; b=Y3sz8FvpY7himpwv
	srfwrhbdTScMFpbgO8s3/5vIGqxMkfkN5oiQng/WMYu/UxdoiWfbaefRuFPU5db9
	XdYRWwV0JuyjjE5AakmUI3OEVyuWATHBYzbaOp3WGgh5qyQKq+wzEdfayLZ9qbHL
	tfsIZL6pvUcMRnIkU3T/Y9A9JYY6Il784loyYQh4gqvfGTadaOFjDsmp4ie8hdh3
	Tlyy5+fD/WEmAzivJyWwE0VFDN25KnugJE7Y5XKVp8bfwDHasvxaCu8TL83E7lBR
	GV2gwYSPEKbt3vcoiA6p95udl/UbZSQAXb3B8uhLLq0xIwi14UPhorK/HmoNdGZU
	TtJwnw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qd9xf47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:28:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b38ec062983so3623512a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756085; x=1754360885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Bq+yWPTZtYMMhUvfg0Sv76S/fKoIvuEK9cXDqqvaPQ=;
        b=nZ62PTDFJy/NIFvEy3pgz7zS2nm1HII4bPluJR00KKPY7U6YvM3gDjaK61uf0NE4h0
         R1ukIcJBXRBvzZDMYYoBLJJm04iS257cC7N98hsdRzQUWb5SdQEeMcWtR431bMkfr5yq
         SnVNBgB7WDXi+lp0Gtos++8I/QlsRSruxs28KpwOqHvaMBt6GMFz46Kn/+e02nZziVaA
         DqRLV4oGwnHqtOlSROH/aFIHRN2QzqGuxqd2l6RRRUdtH2WZgt2ucqmQWVm/5Y4nbDRp
         vAYx6zSYpAeXllHCZwKYbFSoZEd9kVNqDb7wKIpHEXJW3DGF+sASgZ0j/R5NS+JPMBYk
         27Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWjO7pAg2kNDjs50+f+cHnjboT+qRrlZtGxu98/VANDuSO1r2XUAEaKRTjAOceA3t2b2jzHxFCV+KpI5TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsq7UY9hfasZZWZMU1Ilm/T51/M+5D7/4k9MvakUumBqV1akPn
	PCpNFPrwqrml70V6iOWv9ToZx+RgmDSZp+XEllgg2r4NFw1jUPCLRFgnaKuxlysbZj6rQZmZ8ew
	rxTDHN9PURUGTpOhZkjJtueanL6wXdKtic71YWsSBuOzvSjpO3+FY+UwlXuTDbGVTDwRHj/pltP
	k=
X-Gm-Gg: ASbGnct4TBycSYXe986mnSKMxZ0V59MlwsTdokAyXPBD0ZL9W+kViAq5w3hg4r9C5Bm
	sl0hQxq2Q53dRdXcZVh3RokT+2xs71WagFn2DqtsJ3ivYV9X7UxSLAh4fsLjjt58bUyxz8+FPNM
	2Kw4IEsRpHGm0pHEhdeKikTYrDyipKnzZ32Ta9ewEPJ7B6R4bSQboantFgD17eeCh9cyHlNpxZN
	IvlJCyI6NUF277hGbap2bcUhFmwOjwndm/N5A4US8Z/u+/w8ovi9c5EQlGABdXILVbacmrz+Ge6
	ff2TxY5oQvsx2+5rGO++FWi4SHdTlwnMbcQVT7zOJiDjp8boymYhHMY/BkyWj2qEdCIHpc0WbVN
	nsiGQ4EiMMB92aD/lWoXlRD96SEfenGE=
X-Received: by 2002:a05:6a21:998a:b0:225:7617:66ff with SMTP id adf61e73a8af0-23d70081443mr23226084637.20.1753756084851;
        Mon, 28 Jul 2025 19:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdTXKGPk2oDfwPEnJJFppZYni8t0e2aaIUCHCbodlIWr1U5WTGFrQWbKzJgft0MYHAMQUTAw==
X-Received: by 2002:a05:6a21:998a:b0:225:7617:66ff with SMTP id adf61e73a8af0-23d70081443mr23226046637.20.1753756084322;
        Mon, 28 Jul 2025 19:28:04 -0700 (PDT)
Received: from [10.133.33.82] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640863502fsm6673398b3a.19.2025.07.28.19.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 19:28:03 -0700 (PDT)
Message-ID: <c085b770-36a2-4c7c-a841-b47d7aa3768d@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 10:27:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: athk10: Poll service ready completion by default to avoid warning
 `failed to receive service ready completion, polling..`?
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath10k@lists.infradead.org,
        James Prestwood <prestwoj@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <97a15967-5518-4731-a8ff-d43ff7f437b0@molgen.mpg.de>
 <3cbe13e1-a820-4804-a28c-a57e2ee7a020@oss.qualcomm.com>
 <8716a67c-6e33-4a35-8d96-33f81c07c8e0@molgen.mpg.de>
 <1e797dea-d2e1-4947-8ef3-d2ac5ea0c156@oss.qualcomm.com>
 <4e5a3a4d-9b6b-443b-b3c2-eac1b44e96e0@molgen.mpg.de>
 <4f00e46c-598e-4661-87fe-cabc6a678be0@oss.qualcomm.com>
 <04cd7aaa-e1f6-410c-98e7-49cb7ec8e582@molgen.mpg.de>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <04cd7aaa-e1f6-410c-98e7-49cb7ec8e582@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1PBIX8-oROtPiurZ4Ri4DSOeRG4FcuhX
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688831b6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=0Zq-NrcLnryi7NrueYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1PBIX8-oROtPiurZ4Ri4DSOeRG4FcuhX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAxNiBTYWx0ZWRfX2KU6J9UAjSzP
 GFcfeJLlf2zy7un1fVGgiG67GqCZPqJiNqNOkPIEMXqWe/WVlgOR7fEfJ36IeWFFziEuiaR5eZI
 vRRSSMmZQ9hEph+C4lPmwUoqh6RRUHXvKvjp6uPcQZkqa6572zZWZTneAvd1FDMtbZOlEQT5joR
 ulmB+Pb03LhUxee6KoxRCWyJeRdhuWtLU3/Sv24DlJAemjhnboC43fVYEuV4/ZmvI7LptbwIwK2
 mwytDHK1yqzKP1jRFmB4ARtX98n7t3V3ABQAqWBfNryz37eT0bBRX2R77gKgDp2fpqsJVbf8KCg
 3Bemu48CRRl4vHDFzW0yzd3241BH8IlHy1kULlAEj8XB+2Jmo4ETEji6HE2yvCuKyxdFweQ5zJl
 PdfagI0CovSWs7i2EVP4TR7eWU2cQrKuOidyCZGJ+CLcl7RelU70XnctcxmDOl2giiBh+erc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_05,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290016



On 7/28/2025 8:48 PM, Paul Menzel wrote:
> Dear Baochen,
> 
> 
> Am 28.07.25 um 10:50 schrieb Baochen Qiang:
> 
>> On 7/28/2025 3:39 PM, Paul Menzel wrote:
>>> [CC: +scheduler folks for input on the wait_for_completion_timeout() part]
> 
>>> Am 28.07.25 um 04:18 schrieb Baochen Qiang:
>>>> On 7/25/2025 8:15 PM, Paul Menzel wrote:
>>>
>>>>> Am 22.07.25 um 11:38 schrieb Baochen Qiang:
>>>>>
>>>>>> On 7/22/2025 4:37 PM, Paul Menzel wrote:
>>>>>
>>>>>>> Today, on the Intel Kaby Lake laptop Dell XPS 13 9360 with
>>>>>>>
>>>>>>>        $ lspci -nn -s 3a:
>>>>>>>        3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174 802.11ac Wireless
>>>>>>> Network Adapter [168c:003e] (rev 32)
>>>>>>>
>>>>>>> resuming from ACPI S3 took longer, as it sometimes does, and looking into this, I see
>>>>>>> `failed to receive service ready completion, polling..` after a delay of five seconds:
>>>>>>>
>>>>>>> ```
>>>>>>> [    0.000000] Linux version 6.16.0-rc6-00253-g4871b7cb27f4
>>>>>>> (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU
>>>>>>> Binutils for Debian) 2.44) #90 SMP PREEMPT_DYNAMIC Sat Jul 19 08:53:39 CEST 2025
>>>>>>> […]
>>>>>>> [    8.588020] abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target
>>>>>>> 0x05030000 chip_id 0x00340aff sub 1a56:1535
>>>>>>> [    8.588372] abreu kernel: ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0
>>>>>>> tracing 0 dfs 0 testmode 0
>>>>>>> [    8.588603] abreu kernel: ath10k_pci 0000:3a:00.0: firmware ver
>>>>>>> WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
>>>>>>> […]
>>>>>>> [    9.113550] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome
>>>>>>> 0x302 build 0x111
>>>>>>> […]
>>>>>>> [41804.953487] PM: suspend entry (deep)
>>>>>>> [41804.988361] Filesystems sync: 0.034 seconds
>>>>>>> [41805.007216] Freezing user space processes
>>>>>>> [41805.009650] Freezing user space processes completed (elapsed 0.002 seconds)
>>>>>>> [41805.009663] OOM killer disabled.
>>>>>>> [41805.009666] Freezing remaining freezable tasks
>>>>>>> [41805.011383] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>>>>>>> [41805.011502] printk: Suspending console(s) (use no_console_suspend to debug)
>>>>>>> [41805.523883] ACPI: EC: interrupt blocked
>>>>>>> [41805.545779] ACPI: PM: Preparing to enter system sleep state S3
>>>>>>> [41805.556040] ACPI: EC: event blocked
>>>>>>> [41805.556045] ACPI: EC: EC stopped
>>>>>>> [41805.556046] ACPI: PM: Saving platform NVS memory
>>>>>>> [41805.559408] Disabling non-boot CPUs ...
>>>>>>> [41805.562480] smpboot: CPU 3 is now offline
>>>>>>> [41805.567105] smpboot: CPU 2 is now offline
>>>>>>> [41805.572122] smpboot: CPU 1 is now offline
>>>>>>> [41805.582034] ACPI: PM: Low-level resume complete
>>>>>>> [41805.582079] ACPI: EC: EC started
>>>>>>> [41805.582080] ACPI: PM: Restoring platform NVS memory
>>>>>>> [41805.583986] Enabling non-boot CPUs ...
>>>>>>> [41805.584009] smpboot: Booting Node 0 Processor 1 APIC 0x2
>>>>>>> [41805.584734] CPU1 is up
>>>>>>> [41805.584749] smpboot: Booting Node 0 Processor 2 APIC 0x1
>>>>>>> [41805.585514] CPU2 is up
>>>>>>> [41805.585530] smpboot: Booting Node 0 Processor 3 APIC 0x3
>>>>>>> [41805.586216] CPU3 is up
>>>>>>> [41805.589070] ACPI: PM: Waking up from system sleep state S3
>>>>>>> [41805.623652] ACPI: EC: interrupt unblocked
>>>>>>> [41805.640074] ACPI: EC: event unblocked
>>>>>>> [41805.651951] nvme nvme0: 4/0/0 default/read/poll queues
>>>>>>> [41805.865391] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
>>>>>>> [41810.933639] ath10k_pci 0000:3a:00.0: failed to receive service ready completion,
>>>>>>> polling..
>>>>>>> [41810.933769] ath10k_pci 0000:3a:00.0: service ready completion received,
>>>>>>> continuing normally
>>>>>>> [41810.986330] OOM killer enabled.
>>>>>>> [41810.986332] Restarting tasks: Starting
>>>>>>> […]
>>>>>>> ```
>>>>>>>
>>>>>>> Commit e57b7d62a1b2 (wifi: ath10k: poll service ready message before failing) [1][2],
>>>>>>> present since Linux v6.10-rc1, added this to avoid the hardware not being initialized:
>>>>>>>
>>>>>>>            time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
>>>>>>>                                                    WMI_SERVICE_READY_TIMEOUT_HZ);
>>>>>>>            if (!time_left) {
>>>>>>>                    /* Sometimes the PCI HIF doesn't receive interrupt
>>>>>>>                     * for the service ready message even if the buffer
>>>>>>>                     * was completed. PCIe sniffer shows that it's
>>>>>>>                     * because the corresponding CE ring doesn't fires
>>>>>>>                     * it. Workaround here by polling CE rings once.
>>>>>>>                     */
>>>>>>>                    ath10k_warn(ar, "failed to receive service ready completion,
>>>>>>> polling..\n");
>>>>>>>
>>>>>>>                    for (i = 0; i < CE_COUNT; i++)
>>>>>>>                            ath10k_hif_send_complete_check(ar, i, 1);
>>>>>>>
>>>>>>>                    time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
>>>>>>>                                                           
>>>>>>> WMI_SERVICE_READY_TIMEOUT_HZ);
>>>>>>>                    if (!time_left) {
>>>>>>>                            ath10k_warn(ar, "polling timed out\n");
>>>>>>>                            return -ETIMEDOUT;
>>>>>>>                    }
>>>>>>>
>>>>>>>                    ath10k_warn(ar, "service ready completion received, continuing
>>>>>>> normally\n");
>>>>>>>            }
>>>>>>>
>>>>>>> The comment says, it’s a hardware issue. I guess from the Qualcomm device and not the
>>>>>>> board design, as it happens with several devices like James’?
>>>>>>>
>>>>>>> Anyway, should polling be used by default then to avoid the delay?
>>>>>>
>>>>>> Adding additional polling before wait seems OK to me
>>>>>
>>>>> With the attached diff, I didn’t notice any issue on the Dell XPS 13 9360 with QCA6174.
>>>>
>>>> In the diff you are moving polling ahead of wait, IMO this might introduce some race:
>>>> what
>>>> if hardware/firmware send the event right after polling is done?
>>>>
>>>> So how about, instead of moving, just adding a new polling before wait:
>>>>
>>>> 1. polling
>>>> 2. wait
>>>> 3. poling again if wait fail
>>>
>>> I do not know the hardware behavior/design and the error, so cannot judge, if a race would
>>> be possible.
>>>
>>> Could Qualcomm take over to cook up a patch
>>> I’d appreciated if Qualcomm could take over to cook up a patch, as you have the
>>> datasheets, erratas and a line to the hardware designers.
>>
>> sure, I will see what I can do here
> 
> Awesome. Thank you!
> 
>>>>> Unrelated: The only thing I noticed is, that during boot (not resume) the function seems
>>>>> to be called twice. It looks like once for Wi-Fi and once for Bluetooth:
>>>>>
>>>>> ```
>>>>> [   35.507604] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
>>>>> [   35.516010] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c,
>>>>> bcdDevice=56.26
>>>>> [   35.516022] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
>>>>> [   35.516026] usb 1-5: Product: Integrated_Webcam_HD
>>>>> [   35.516029] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
>>>>> [   35.587852] ath10k_pci 0000:3a:00.0: service ready completion received, continuing
>>>>> normally
>>>>> [   35.606632] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-
>>>>> sta 32 raw 0 hwcrypto 1
>>>>> [   35.628744] mc: Linux media interface: v0.10
>>>>> [   35.651301] nvme nvme0: using unchecked data buffer
>>>>> [   35.687466] Bluetooth: Core ver 2.22
>>>>> [   35.687493] NET: Registered PF_BLUETOOTH protocol family
>>>>> [   35.687495] Bluetooth: HCI device and connection manager initialized
>>>>> [   35.687499] Bluetooth: HCI socket layer initialized
>>>>> [   35.687501] Bluetooth: L2CAP socket layer initialized
>>>>> [   35.687505] Bluetooth: SCO socket layer initialized
>>>>> [   35.696050] ath: EEPROM regdomain: 0x6c
>>>>> [   35.696055] ath: EEPROM indicates we should expect a direct regpair map
>>>>> [   35.696057] ath: Country alpha2 being used: 00
>>>>> [   35.696058] ath: Regpair used: 0x6c
>>>>> [   35.712821] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
>>>>> [   35.716790] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/
>>>>> usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input40
>>>>> [   35.718912] videodev: Linux video capture interface: v2.00
>>>>> [   35.719492] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/
>>>>> usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input41
>>>>> [   35.719595] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/
>>>>> usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input42
>>>>> [   35.720899] hid-multitouch 0003:04F3:2234.0002: input,hiddev0,hidraw1: USB HID
>>>>> v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
>>>>> [   35.720947] usbcore: registered new interface driver usbhid
>>>>> [   35.720949] usbhid: USB HID core driver
>>>>> [   35.812081] usbcore: registered new interface driver btusb
>>>>> [   35.815263] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
>>>>> [   35.815270] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome
>>>>> 0x302 build 0x111
>>>>> [   36.174345] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
>>>>> [   36.199643] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
>>>>> advertised, but not supported.
>>>>> [   36.398657] ath10k_pci 0000:3a:00.0: service ready completion received, continuing
>>>>> normally
>>>>
>>>> Hmm, I don't think this is for BT as ath10k is not a BT driver. Something must be wrong
>>>> here ...
>>>>
>>>>> ```
>>>
>>> Can you reproduce it?
>>>
>>> How would I get a call graph for both function calls?
>>
>> # cd /sys/kernel/debug/tracing/
>> # echo 0 > ./tracing_on
>> # echo function >./current_tracer
>> /* replace function with what you want to trace, e.g. ath10k_wmi_wait_for_service_ready */
>> # echo <function> > ./set_ftrace_filter
>> # echo 1 > ./options/func_stack_trace
>> # echo 1 > ./tracing_on
>> # cat trace_pipe
>> /* reload ath10k driver */
> 
> Somehow it did not work for me. I think, reloading the module seems to make it forget the
> function `ath10k_wmi_wait_for_service_ready()`.
> 
>     $ sudo cat /sys/kernel/debug/tracing/set_ftrace_filter
>     ath10k_wmi_wait_for_service_ready [ath10k_core]
> 
> Unload the module with `sudo modprobe -r ath10k_pci`.
> 
>     $ sudo cat /sys/kernel/debug/tracing/set_ftrace_filter
>     $
> 
> Load the module, and it’s still empty:
> 
>     $ sudo cat /sys/kernel/debug/tracing/set_ftrace_filter
>     $
> 

Yeah, my bad, I missed the side effect of reaload.

Never mind, since you can modify the source code, you can simply get call stack with:

$ git diff
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index cb8ae751eb31..eb591e059103 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1766,6 +1766,8 @@ int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
        unsigned long time_left, i;

+       dump_stack();
+
        time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
                                                WMI_SERVICE_READY_TIMEOUT_HZ);
        if (!time_left) {


>>>>>>> Additionally I have two questions regarding the code:
>>>>>>>
>>>>>>> 1.  Is `WMI_SERVICE_READY_TIMEOUT_HZ` the right value to pass to
>>>>>>> `wait_for_completion_timeout(struct completion *done, unsigned long timeout)`?
>>>>>>>
>>>>>>> The macro is defined as:
>>>>>>>
>>>>>>>        drivers/net/wireless/ath/ath10k/wmi.h:#define WMI_SERVICE_READY_TIMEOUT_HZ
>>>>>>> (5 * HZ)
>>>>>>>
>>>>>>> `timeout` is supposed to be in jiffies, and `CONFIG_HZ_250=y` on my system. I
>>>>>>> wonder how
>>>>>>> that amounts to five seconds on my system.
>>>>>>
>>>>>> HZ is defined as jiffies per second, so 5 * HZ equals 5 seconds.
>>>
>>> Sorry, I missed to comment here in my previous reply. HZ can be defined differently – like
>>> 1000 HZ –, so the timeout would very, and then not match the actual timeout required by
>>> the hardware? `Documentation/scheduler/completion.rst` contains:
>>>
>>>> Timeouts are preferably calculated with msecs_to_jiffies() or usecs_to_jiffies(),
>>>> to make the code largely HZ-invariant.
>>
>> Hmm, new knowledge to me. Will check and update.
> 
> Awesome!
> 
>>>>>>> The timeout should probably be defined in seconds? Does the WMI specification say
>>>>>>> something about this?
>>>>>>>
>>>>>>> 2.  Is the task interruptible and should
>>>>>>> `wait_for_completion_interruptible_timeout(struct completion *done, unsigned long
>>>>>>> timeout)` be used?
>>>>>>
>>>>>> While I am not sure for now, may I ask why the question?
>>>>>
>>>>> I was just reading up on `wait_for_completion_*()`, and so the different variants.
>>>>
>>>> If there is no obvious benefits I don't think the change is necessary.
>>>
>>> Thinking about it, the driver initialization is in the boot path (hot patch) so would
>>> block one thread(?) – or is that a wrong assumption –, which is unwanted?
>>
>> Indeed a thread would block there ... So you want to make the thread responsible to
>> signals? such as killing it when ath10k goes wrong?
> 
> You got me, that I actually do not know, what the downsides are, and what signal/interrupt
> could be fired, and how it should be handled. As a side note: Other drivers use
> `wait_for_completion_interruptible_timeout()` also without checking the return value. If
> nobody else sheds light into this, please ignore my comment.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
>>>>>>> [1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>>>>>>> commit/?id=e57b7d62a1b2f496caf0beba81cec3c90fad80d5
>>>>>>> [2]: https://lore.kernel.org/all/20240227030409.89702-1-quic_bqiang@quicinc.com/


