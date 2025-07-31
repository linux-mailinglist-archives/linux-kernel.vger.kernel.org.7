Return-Path: <linux-kernel+bounces-751429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE36B1698B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A24A5446C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2710E5;
	Thu, 31 Jul 2025 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dtCKjQAH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A0A2D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753920761; cv=none; b=VkSLVw5Uwj4toZeA68ar8NME4bjxK8Yhbj6l3UcaAPFHrBrs9oqxrzrLguuNKCT2L5UYWP3xkN1XDW/+3Hs+vnfZfDHE2M1PIvJDRoehFFuV8v3pg1XIdVqGO6rqykNyvJM4l57P1qPs1EZFZjfrRlh8eYNQf9VIRkUHC0euKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753920761; c=relaxed/simple;
	bh=WoyyVDdL/pe7grqQh7vkQNyc8R9rmr45oz4PR65U6uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HY9+MWJFDsC16jAXgX0YG9LZAtHnZxhNrUZXQJaU5ATvUl6xeCqGkxV+KYTTOJb0bO6hXVhW8/TobJPE0GZMOjXyk5mBnilRGBWJgkVXO0bSSVNI2s93Xam6cWAzN+H1qofGGILp9GBmGYTz5KQxr2mRunSUo8qyGf0yNQzClZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dtCKjQAH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbBrU012965
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n5TfsdIq0q4y4VvFqmZw5jjnclAjOmVGqCrD0ePejn4=; b=dtCKjQAHrVciGFNB
	gpCOpCL5kV7R2CfKsk8Ut09tpimu1DK/3Hk8HFNgWu700uQYOcCidacWdG7N9PVD
	CrWGB7Fm4JP+ZG30+LavDRTOvUnKHFUIv0Dv76uR8fMasi3Y7QsQcqk9+ZAhDZg+
	KVeR3J7CD5fP9Ufzcl/tpKp54IlUjwoIyoBqbw7puXH6bQAU/wybs210Gw7VAbPY
	+iz4FoseS1J6W0ihgW2ZpDr/QxdvJNpjNPWofQfN1EZuWuMlwUVL2QVYq1UjZi2O
	4l44yBIe8KwdvSR6KKXdSBhLu5GQCJd81OdRTs1eQpglc+5HEwPGdh+MRjzH4Pce
	ET+kUQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2njts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:12:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bcd829ff1so27345b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753920757; x=1754525557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5TfsdIq0q4y4VvFqmZw5jjnclAjOmVGqCrD0ePejn4=;
        b=cJBezpNClIVULAiceqr1SdwEzA6isnl2xMXEI+b3v6POjjOb89meV3nUmbCRwSFaKS
         3orq3OJPe3oSreXmzMbnhD4VmB0RiZy4cZkYml7N1P4yyxK92KX9QuRpUMqZkmubXD/7
         vk2GXGK7uX4rX7HWJiTfQrYuYZqIfLYcT+LXJf6YVibW4KRbnUBbIH+owkggPVHLT6RM
         TYrMDPYUyT1nBAKG/mq+dSZw9U24FMplPgYp2EjeMekZh8Ycc++TlB7+Cw9+xTWajHkx
         rBFRcZpU10xduYSxrVl/Brc56EVDCfs4b+jl7R732bA6JHDCwKOz9Sn8gLBVjKj3b7ZG
         0b6g==
X-Forwarded-Encrypted: i=1; AJvYcCVrPT7AhJImpnPyfMPE2QhyH2Mn9xbl+24WO20rMvExyZlY+aq86wbJ+/yCilVuKJIGDMiSFnwRd4x5vhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZJKahH/Ur/VlK4uug1kAmpJvi4WJD3QdbG72yu6e1dxxTy0G
	YpdIbuGzaXWpjzFY1RRyS2WYtJEIxfGcXqzRtS11DqLqgt3RXpkus3XVB0Z58+V/MO4FzOTdl1k
	NnHIyiQHTrUCcMj+HD+e2jjnFfRUKe+MvE6xkCzIS+iS24D6b4s3O767emoOPEwzfuAg=
X-Gm-Gg: ASbGncvL2IHqnSukGZzPZsLCz1zAePj5eZx3LMIrMMpmbEAnKodRTE6AfkCkNQmAkpu
	mvY75nuIhvn1kt8Qt85ZULVqJbFji9uPCO37splC8qJa6Y6iwJ1B+nmJ3pAwb1dDCJtZmTy29he
	6RjzgH3DFy6BVI/l748893wIo7/rFhHOXZF4ijNMPMS3Idf5wZ7BZGEEh/2d4Z0YEL4dum3a3lM
	Whm5AbvWYeRhDWJWZFkbZdj4R1IQy62OUEpxyH2z9z8sYoTOGlpzbssghchsnDNDHREb01mkWCq
	5eG/G0xmCCVrUd3hZxiocmbK1BquODcUbX+iRRLu2kBSrmsrzX6unnhSo64W6Pl1n6DJxZiqws3
	QtIU+tcxHPz+ZCXlYXidnNT3/Huu3Ye2B
X-Received: by 2002:a05:6a00:2450:b0:74c:f1d8:c402 with SMTP id d2e1a72fcca58-76ab101929fmr8483257b3a.8.1753920756767;
        Wed, 30 Jul 2025 17:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtA26SksYevn+Vt0DHMEQW8M32DRyJS68mendQzQAaKQ+8c5uR6z29tGwXyKJ/Xeb6Dd50rw==
X-Received: by 2002:a05:6a00:2450:b0:74c:f1d8:c402 with SMTP id d2e1a72fcca58-76ab101929fmr8483215b3a.8.1753920756244;
        Wed, 30 Jul 2025 17:12:36 -0700 (PDT)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe9172sm64126b3a.126.2025.07.30.17.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 17:12:35 -0700 (PDT)
Message-ID: <55db7f5a-89d1-41b8-9e63-89bb7ec18778@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 08:12:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k: ath10k_wmi_wait_for_service_ready() called twice during
 boot
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath10k@lists.infradead.org,
        James Prestwood <prestwoj@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <97a15967-5518-4731-a8ff-d43ff7f437b0@molgen.mpg.de>
 <3cbe13e1-a820-4804-a28c-a57e2ee7a020@oss.qualcomm.com>
 <8716a67c-6e33-4a35-8d96-33f81c07c8e0@molgen.mpg.de>
 <1e797dea-d2e1-4947-8ef3-d2ac5ea0c156@oss.qualcomm.com>
 <4e5a3a4d-9b6b-443b-b3c2-eac1b44e96e0@molgen.mpg.de>
 <4f00e46c-598e-4661-87fe-cabc6a678be0@oss.qualcomm.com>
 <04cd7aaa-e1f6-410c-98e7-49cb7ec8e582@molgen.mpg.de>
 <c085b770-36a2-4c7c-a841-b47d7aa3768d@oss.qualcomm.com>
 <10298561-8016-478f-aa82-bf2ea9b33db9@molgen.mpg.de>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <10298561-8016-478f-aa82-bf2ea9b33db9@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 972MnZOLrVxNdcmjHVTO7KdetGPhB8sb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE3OSBTYWx0ZWRfX1jliefVq17w+
 eenayYgiIIaWn6PjFIM6oKffO1QDyHVIA6agZ02I34dcicCfIJvx3LyuR9pyVTsfbGq6i1E6uoH
 5FNDQLAd0SeNIxX5bRpyJMwYXOxoQEgqsRd3QIe26QDqfkK3Fa4jBcUZDoPeIvRRbOPrd4sAvW/
 R1id2735srSEPyQT9UgyZF+SdFu9Fyq5IYvsnfQ1EvIKJy1gBf8YXUOMxN2YSw0cv6B/z8efwK7
 i0/I3xh8BTyRj6IiR6mBhwoetr0y7IVMy8WK7pgYKanUhfEibbhED3gxH7yqZ7scKkORWwhVOJO
 HrIxhFR8KHk12hiSITVwhdNuSLLEX/MoTeU+S6QROqxgT5fa769qLhYl3IpSSihkWx67Wzu2Irv
 oR+nPOrPQFmmM+zmQXBP0Xq7baBO1lS1HA5Oh/TpFYZBiEo2Nnp7FBF/jY6FqCCb8CHuhwjn
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688ab4f6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=8-oeUsj2rOlVhVxQr9IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 972MnZOLrVxNdcmjHVTO7KdetGPhB8sb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300179



On 7/30/2025 6:40 PM, Paul Menzel wrote:
> [Cc: remove scheduler folks]
> 
> Dear Baochen,
> 
> 
> Thank you for your reply, and let’s fork this thread.
> 
> 
> Am 29.07.25 um 04:27 schrieb Baochen Qiang:
> 
> […]
> 
>> Never mind, since you can modify the source code, you can simply get
>> call stack with:
>>
>> $ git diff
>> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
>> index cb8ae751eb31..eb591e059103 100644
>> --- a/drivers/net/wireless/ath/ath10k/wmi.c
>> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
>> @@ -1766,6 +1766,8 @@ int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
>>   {
>>          unsigned long time_left, i;
>>
>> +       dump_stack();
>> +
>>          time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
>>                                                  WMI_SERVICE_READY_TIMEOUT_HZ);
>>          if (!time_left) {
> 
> Thanks, yes, I wanted to avoid it, but now added it to the end, and started the Linux kernel.
> 
> With that, I got:
> 
> ```
> [    0.000000] Linux version 6.16.0-04406-g154cace907b6
> (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU
> Binutils for Debian) 2.44) #98 SMP PREEMPT_DYNAMIC Wed Jul 30 11:59:36 CEST 2025
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.16.0-04406-g154cace907b6
> root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep
> log_buf_len=16M cryptomgr.notests usbcore.quirks=0cf3:e300:e,04f3:2234:e,0c45:670c:e
> […]
> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> […]
> [   14.624206] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
> [   14.633316] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
> [   14.662181] audit: type=1400 audit(1753869969.819:2): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=516
> comm="apparmor_parser"
> [   14.662313] audit: type=1400 audit(1753869969.819:3): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=518
> comm="apparmor_parser"
> [   14.663112] audit: type=1400 audit(1753869969.819:4): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name="1password" pid=514 comm="apparmor_parser"
> [   14.664059] audit: type=1400 audit(1753869969.819:5): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name="Discord" pid=515 comm="apparmor_parser"
> [   14.664963] audit: type=1400 audit(1753869969.819:6): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name="balena-etcher" pid=523
> comm="apparmor_parser"
> [   14.665357] audit: type=1400 audit(1753869969.819:7): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name="buildah" pid=525 comm="apparmor_parser"
> [   14.665479] audit: type=1400 audit(1753869969.819:8): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name="brave" pid=524 comm="apparmor_parser"
> [   14.666813] audit: type=1400 audit(1753869969.823:9): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name="cam" pid=527 comm="apparmor_parser"
> [   14.666817] audit: type=1400 audit(1753869969.823:10): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name="busybox" pid=526 comm="apparmor_parser"
> [   14.667174] audit: type=1400 audit(1753869969.823:11): apparmor="STATUS"
> operation="profile_load" profile="unconfined" name="ch-checkns" pid=528
> comm="apparmor_parser"
> [   14.719843] usbcore: registered new interface driver uvcvideo
> [   14.792965] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
> [   14.793498] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
> intel_audio_component_bind_ops [i915])
> [   14.837438] snd_hda_codec_generic hdaudioC0D0: autoconfig for Generic: line_outs=1
> (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   14.837458] snd_hda_codec_generic hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   14.837467] snd_hda_codec_generic hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [   14.837475] snd_hda_codec_generic hdaudioC0D0:    mono: mono_out=0x0
> [   14.837480] snd_hda_codec_generic hdaudioC0D0:    inputs:
> [   14.837485] snd_hda_codec_generic hdaudioC0D0:      Mic=0x12
> [   14.870772] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff
> sub 1a56:1535
> [   14.870778] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> [   14.870853] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309- api 6 features
> wowlan,ignore-otp,mfp crc32 0793bcf2
> [   14.877651] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/
> sound/card0/input24
> [   14.877724] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/
> sound/card0/input25
> [   14.877788] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/
> sound/card0/input26
> [   14.877872] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/
> sound/card0/input27
> [   14.944938] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [   14.946658] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
> [   14.967545] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
> advertised, but not supported.
> [   15.027036] CPU: 1 UID: 0 PID: 41 Comm: kworker/u16:2 Not tainted 6.16.0-04406-
> g154cace907b6 #98 PREEMPT(voluntary)
> [   15.027044] Hardware name: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> [   15.027046] Workqueue: ath10k_wq ath10k_core_register_work [ath10k_core]
> [   15.027084] Call Trace:
> [   15.027088]  <TASK>
> [   15.027091]  dump_stack_lvl+0x5d/0x80
> [   15.027100]  ath10k_wmi_wait_for_service_ready.cold+0x5/0xc [ath10k_core]
> [   15.027136]  ath10k_core_start+0xaec/0x1090 [ath10k_core]
> [   15.027169]  ath10k_core_register_work+0x5c4/0x930 [ath10k_core]
> [   15.027198]  process_one_work+0x185/0x340
> [   15.027205]  worker_thread+0x252/0x3a0
> [   15.027210]  ? rescuer_thread+0x4b0/0x4b0
> [   15.027215]  kthread+0xf9/0x240
> [   15.027219]  ? kthreads_online_cpu+0x120/0x120
> [   15.027223]  ? kthreads_online_cpu+0x120/0x120
> [   15.027227]  ret_from_fork+0x198/0x1d0
> [   15.027232]  ? kthreads_online_cpu+0x120/0x120
> [   15.027235]  ret_from_fork_asm+0x11/0x20
> [   15.027243]  </TASK>

OK, so this is from driver load.

> [   15.046899] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32
> raw 0 hwcrypto 1
> [   15.053439] nvme nvme0: using unchecked data buffer
> [   15.120478] ath: EEPROM regdomain: 0x6c
> [   15.120483] ath: EEPROM indicates we should expect a direct regpair map
> [   15.120485] ath: Country alpha2 being used: 00
> [   15.120486] ath: Regpair used: 0x6c
> [   15.153053] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
> [   15.644071] CPU: 0 UID: 0 PID: 675 Comm: NetworkManager Not tainted 6.16.0-04406-
> g154cace907b6 #98 PREEMPT(voluntary)
> [   15.644075] Hardware name: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> [   15.644077] Call Trace:
> [   15.644079]  <TASK>
> [   15.644082]  dump_stack_lvl+0x5d/0x80
> [   15.644089]  ath10k_wmi_wait_for_service_ready.cold+0x5/0xc [ath10k_core]
> [   15.644104]  ath10k_core_start+0xaec/0x1090 [ath10k_core]
> [   15.644115]  ath10k_start+0xb8/0x840 [ath10k_core]
> [   15.644125]  drv_start+0x3c/0xf0 [mac80211]
> [   15.644165]  ieee80211_do_open+0x2c2/0x7f0 [mac80211]
> [   15.644197]  ieee80211_open+0x84/0x90 [mac80211]
> [   15.644230]  __dev_open+0xee/0x200
> [   15.644233]  __dev_change_flags+0x1ef/0x230
> [   15.644234]  ? prep_new_page+0xcc/0x1d0
> [   15.644237]  netif_change_flags+0x26/0x60
> [   15.644238]  do_setlink.isra.0+0x348/0x1150
> [   15.644241]  ? __nla_validate_parse+0x5e/0xc70
> [   15.644243]  ? security_capable+0x66/0xa0
> [   15.644245]  rtnl_newlink+0x892/0xc20
> [   15.644247]  ? update_load_avg+0x80/0x760
> [   15.644249]  ? update_curr+0x90/0x170
> [   15.644250]  ? mod_memcg_lruvec_state+0x191/0x1d0
> [   15.644253]  ? do_setlink.isra.0+0x1150/0x1150
> [   15.644254]  rtnetlink_rcv_msg+0x348/0x3e0
> [   15.644257]  ? rtnl_calcit.isra.0+0x120/0x120
> [   15.644260]  netlink_rcv_skb+0x4f/0x100
> [   15.644263]  netlink_unicast+0x273/0x3d0
> [   15.644265]  netlink_sendmsg+0x228/0x470
> [   15.644267]  __sock_sendmsg+0x38/0x70
> [   15.644270]  ? __import_iovec+0x139/0x180
> [   15.644272]  ____sys_sendmsg+0x1c0/0x260
> [   15.644275]  ? import_iovec+0xb/0x10
> [   15.644277]  ___sys_sendmsg+0x95/0xd0
> [   15.644279]  __sys_sendmsg+0x7b/0xd0
> [   15.644282]  do_syscall_64+0x84/0xae0
> [   15.644284]  ? pollwake+0x77/0x90
> [   15.644287]  ? wake_up_state+0x10/0x10
> [   15.644288]  ? __wake_up_common+0x72/0x90
> [   15.644290]  ? eventfd_write+0xe1/0x210
> [   15.644292]  ? security_file_permission+0x35/0x70
> [   15.644294]  ? vfs_write+0xcc/0x460
> [   15.644296]  ? ___sys_sendmsg+0xa1/0xd0
> [   15.644297]  ? ksys_write+0xc7/0xe0
> [   15.644298]  ? do_syscall_64+0xbc/0xae0
> [   15.644301]  ? __sys_sendmsg+0xb6/0xd0
> [   15.644303]  ? do_syscall_64+0xbc/0xae0
> [   15.644304]  ? do_syscall_64+0xbc/0xae0
> [   15.644306]  ? do_syscall_64+0xbc/0xae0
> [   15.644308]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   15.644310] RIP: 0033:0x7fa5c3ca49ee
> [   15.644334] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d
> 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00
> 00 0f 1f 80 00 00 00 00 48 83 ec 08
> [   15.644335] RSP: 002b:00007ffc2e929548 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> [   15.644338] RAX: ffffffffffffffda RBX: 00007fa5c3094580 RCX: 00007fa5c3ca49ee
> [   15.644339] RDX: 0000000000000000 RSI: 00007ffc2e9295d0 RDI: 000000000000000d
> [   15.644340] RBP: 00007ffc2e9295d0 R08: 0000000000000000 R09: 0000000000000000
> [   15.644340] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001c
> [   15.644341] R13: 00007ffc2e9297c8 R14: 00007ffc2e9297bc R15: 0000000000000000
> [   15.644343]  </TASK>
> [   18.369625] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
> [   18.369702] pci 0000:01:00.0: PCI bridge to [bus 02-39]

and this is from userspace starting to bringup the WLAN interface: calling the _start() ops.


In summary, the two instances of 'wait for service ready' are expected behavior.

> […]
> ```
> 
> 
> Kind regards,
> 
> Paul


