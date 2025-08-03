Return-Path: <linux-kernel+bounces-754475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD8B194AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C147A3B3157
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCA1CEADB;
	Sun,  3 Aug 2025 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OMTxDkp9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BA111AD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754243423; cv=none; b=b5SI+KHEWa9rByq37bGXXjlliBFEU9pJNEUaLAC09fUSrZiQFeBDpswZOUB060ybFmpsjuOK8S1bkhQd6ixiQESsJRKRXuVf7twiVeosLbX376XS6+Ez6hYvmI3iwKNfvrFf5JrvKKWwxB+KlvyhOet3DoqaQzAnM1oQlKbwudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754243423; c=relaxed/simple;
	bh=//RkQLBME1MgzjooVgQY4fZDfTQ2Bo7QuMaKCDdYr/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5Adj5tU9zDwO0u701pxv1gz4SdVgaoPuVSaToIxbYVDV5Z7oTtwjaWJ/wevHmrF0v9w8ywotNrvjlRhs9uZNp38SFNZjfp00Jm2fR2NlwlTEeYzRJH3jEx7lcYCp1ck6NVPfeMDmqNxQ2gSy1R60jcmTSHQVR50TjWsq6an/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OMTxDkp9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573FgZw7003393
	for <linux-kernel@vger.kernel.org>; Sun, 3 Aug 2025 17:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OuenVFObwJHSBvqO5nKZokK8NvCYCBaQf6VRFPFzldQ=; b=OMTxDkp934e2BWaW
	lekvnSCvK+ogy3qHy3qxltVMvGOzSlb7NwVxcNbW3wsXLTc1R9IWMhCgEF8mAh8n
	rwZRg8coDDZcNhMIj213a0vBiPp6pE1adI40K7ufppBBopZ9YBmbNO2+YMMlLxsl
	OzmhPk2ntseBpIPkB0pM3ON14mtf8D0HiFCd19YNCtYM9wu1qTAtpSkAGxhN3QDL
	I6Mmlf439l2FYYbAmo+n1k0QDtOdGeXC7YMejj7VFnizJhTT7DbGc8F/12rfTKmK
	xlBTCDW0AJdTOgTHRxYaYxtemeIECIo4VsnkFfD6aq0F1G9y5mlO6ary9TVSm0jk
	Ebp1Pw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqjgru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 17:50:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2420cfdafcaso25335855ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 10:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754243417; x=1754848217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OuenVFObwJHSBvqO5nKZokK8NvCYCBaQf6VRFPFzldQ=;
        b=qxDUNkf4J7dpqb1jY7XyQfc4jh9pprY5+zJnG1HT9VB9lU9A1vohm0NYINUiDjnJ4X
         1H0L2LP8sHdmcn45Gk76uuQ0P9uyTKvW6z3t4lUhuqQP9zvLOjYkD2mrH5Z0M6O2r6Gc
         NqmUbXLvINP/YqIV+tlhL8c9tnxduDteL1rs2tKxzqgmP1FucMpDEQL9ECBKuivU9zYd
         /dkKZFrThUmBv/GhoQtGqx11k1uWbYK8SFqtOjathpn/4JMTSb/rnvPEe3M4V8Kv+drl
         L4H4oxIwa2INEis9zh+6vOLyodvxS1+IhykBpE2SPpSx+4EXsG5nz0BgnkXN3Nr+HusP
         PlfQ==
X-Gm-Message-State: AOJu0YwKfY9Qv3Is6oH1QPl8pOL/wDjiiTX5Elk+NRKXZ1Jkncq6oEoF
	+aWHBdyRA6HvjhaowtypHsUZ2WOA3/HfA7J3K0gAyueYx84D9c+Gj00Dp6ZHUrI0DFpKqSTTaoP
	BiBtA0uISk2+prNBa5gkm2uDOhL9pqIb79QO7aLXJYFXDz1rAwUcLIwIYLx3Ou1fGwnk=
X-Gm-Gg: ASbGncuIM0bqJOsRNeHHCrDks4rCkgDDlIrBTqx8IHzF7T/T/TZkE8rB5DmXmOEmyxJ
	s1UTWmDG48E6Dfo1cXJy49yGu48lDWbg/5aZI8KBUfqXNecoNMujw8/8CjwlK1okSJDkdrpcbOV
	/BogCbjWin1H/fhc56PdlyK4O1fcY9oLSoEl5vgrhsuApzPwKwp/7Cj0RnJc+iubp99CodFRl/M
	9AX9k30nUxXDU5i8sgUTx26u5FoY4cqSWptwpu5nKImBECmkihJw/+NqEdn/nJvDROkFOT0hpsi
	/XQqv5gkpdGDws/yGILB/HCWcNRo+n3Twtqxe/Zgcj6BXo6KlmSQrTojakTOYw8MzsxqooB9uCy
	6
X-Received: by 2002:a17:902:d2cc:b0:240:9ff:d546 with SMTP id d9443c01a7336-24246f3090bmr72478945ad.6.1754243417263;
        Sun, 03 Aug 2025 10:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFouRq6KmYOSkRCRFm6MPwSsBmhtsBwdkolvhQA3wYHsCDnIx7tKFvrpwUR4TXFNCs+S73ZQ==
X-Received: by 2002:a17:902:d2cc:b0:240:9ff:d546 with SMTP id d9443c01a7336-24246f3090bmr72478685ad.6.1754243416745;
        Sun, 03 Aug 2025 10:50:16 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d2e0sm89172685ad.143.2025.08.03.10.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 10:50:16 -0700 (PDT)
Message-ID: <34f4a0d7-f834-499e-8747-936107510f99@oss.qualcomm.com>
Date: Sun, 3 Aug 2025 10:50:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Scheduler updates for v6.17
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
        Tejun Heo <tj@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
References: <aIcdTI3e04W_RdM_@gmail.com>
 <CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
 <CAHk-=wg7Ad6zjs8QdgDkS-8oJD2EbLK2Ne-WRo36ZXVHa=hmWw@mail.gmail.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <CAHk-=wg7Ad6zjs8QdgDkS-8oJD2EbLK2Ne-WRo36ZXVHa=hmWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: eE72mHA5JdZoIBarZqg-w2aZdecSfRfY
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=688fa15a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8
 a=85e7GQV96khZYQ1lpSMA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDEyMSBTYWx0ZWRfX0C66i9GKI/+j
 TXUx81NH/uP1Om8OuVLxszHDESfRWKA98j+WE8NuG7a5IooSS/Um3plIfsSoVX5oblvrq5wJwex
 tmM0D82Mm8UCjDfCx1Yg6ZywDanDK1xfZXZtqIXu/W1avnDirp9oRizW5m7cvBRwI1pD5glp6tP
 /ZWftSTgRe7kkVgInBX1XZ+Mrqa8yBm9wT3Z2TTt945pmxyc85r3hUjdrc/YjrqhxI474OZXr5b
 vQ69MDqoJb8r6dD4UUziPnTd9dp991KHCKlDUrDamcBmbZvcGPN6KB6+wPmykHnHVj27QMDCzS0
 BLVllxQGNnFjveg6cxQWZroi/xYiC9bpXJZpR59gdRfgJMNdyFU7CR/ffKx/eZ4UBM7TQJwwBme
 0Bo44KXDZZHx4SagQt1IhCEAKhwBNRjpnMH0Ta4CaVDgIuhgLTfhssDAGX/m/iaaVdKkFLcz
X-Proofpoint-ORIG-GUID: eE72mHA5JdZoIBarZqg-w2aZdecSfRfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508030121

On 8/2/25 11:43, Linus Torvalds wrote:
> On Wed, 30 Jul 2025 at 20:31, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Sun, 27 Jul 2025 at 23:48, Ingo Molnar <mingo@kernel.org> wrote:
>>>
>>> PSI:
>>>
>>>  - Improve scalability by optimizing psi_group_change() cpu_clock() u=
sage
>>>    (Peter Zijlstra)
>>
>> I suspect this is buggy.
>>
>> Maybe this is coincidence, but that sounds very unlikely:
>>
>>   watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [kworker/0:3:7996]=

>>   CPU#0 Utilization every 4s during lockup:
>=20
> Happened again this morning, and as far as I can tell the machine was
> just sitting there idle at the desktop.
>=20
> I've only seen this on my laptop, so maybe it's some hw dependency,
> but it *really* smells like commit 570c8efd5eb7 ("sched/psi: Optimize
> psi_group_change() cpu_clock() usage") from the symptoms. It's
> literally hanging on that psi_read_begin(), which is that
> read_seqcount_begin() on that new per-cpu psi_seq counter.
>=20
> Now, I'm not seeing how it could possibly trigger - I looked through
> all the psi_write_begin() users, and they all *seem* to be (a) under
> rq_lock_irq and (b) paired with a psi_write_end() with the same cpu.
>=20
> But the symptoms have been very consistent both times it happened: the
> RIP always a watchdog in collect_percpu_times(), always at that
> 'pause' in the "wait for seqcount to be even".
>=20
> It's typically been in that psi_avgs_work kworker, but once it was
> systemd-oomd that apparently had done a "read()" on it, so it went
> through "psi_show()" instead.
>=20
> Now, the *writers* all take the proper locks, but the readers don't.
> And my laptop has CONFIG_PREMPT_VOLUNTARY in its config (random old
> setting).
>=20
> I'm not seeing why that would matter, since the seq count should
> become even at some point, but it does mean that the seqcount read
> loop looks like it's an endless kernel loop when it triggers. I don't
> see how that would make a difference, since the seqcount should become
> even on the writer side and the writers shouldn't be preempted and get
> some kind of priority inversion with a reader that doesn't go away,
> but *if* there is some bug in this area, maybe that config is why I'm
> seeing it and others aren't?
>=20
> Any ideas, people?

FWIW I'm seeing the same thing.

Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: watchdog: BUG: soft lockup - C=
PU#3 stuck for 21s! [kworker/3:0:3977]
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: Modules linked in: snd_seq_dum=
my snd_hrtimer ccm michael_mic bnep amdgpu snd_hda_codec_hdmi amdxcp gpu_=
sched drm_panel_backlight_quirks rmi_smbus rmi_core qrtr_mhi snd_hda_code=
c_generic at24 intel_rapl_msr binfmt_misc snd_hda_intel snd_hda_codec int=
el_rapl_common mei_hdcp snd_hda_core x86_pkg_temp_thermal qrtr snd_intel_=
dspcfg snd_intel_sdw_acpi intel_powerclamp snd_hwdep snd_pcm uvcvideo ath=
12k coretemp videobuf2_vmalloc qmi_helpers ghash_clmulni_intel nls_iso885=
9_1 aesni_intel uvc rapl snd_seq_midi videobuf2_memops mac80211 wmi_bmof =
snd_seq_midi_event libarc4 intel_cstate i2c_i801 videobuf2_v4l2 i915 i2c_=
mux radeon snd_rawmidi videobuf2_common drm_ttm_helper drm_buddy cfg80211=
 drm_exec i2c_smbus videodev ttm btusb drm_suballoc_helper snd_seq mc drm=
_client_lib btrtl btintel drm_display_helper btbcm mhi snd_seq_device btm=
tk cec snd_timer rc_core drm_kms_helper bluetooth mei_me snd lpc_ich mei =
i2c_algo_bit soundcore wireless_hotkey tpm_infineon input_leds joydev mac=
_hid serio_raw msr parport_pc ppdev lp
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  parport efi_pstore drm nfnetl=
ink dmi_sysfs autofs4 rtsx_pci_sdmmc video cdc_ether usbnet mii psmouse a=
hci rtsx_pci libahci e1000e wmi
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: irq event stamp: 198926
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: hardirqs last  enabled at (198=
925): [<ffffffffa240150a>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: hardirqs last disabled at (198=
926): [<ffffffffa5714d90>] sysvec_apic_timer_interrupt+0x10/0xb0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: softirqs last  enabled at (198=
904): [<ffffffffa29a4ff3>] __irq_exit_rcu+0xb3/0xe0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: softirqs last disabled at (198=
899): [<ffffffffa29a4ff3>] __irq_exit_rcu+0xb3/0xe0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: CPU: 3 UID: 0 PID: 3977 Comm: =
kworker/3:0 Not tainted 6.16.0+ #146 PREEMPT(voluntary)=20
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: Hardware name: Hewlett-Packard=
 HP ZBook 14 G2/2216, BIOS M71 Ver. 01.31 02/24/2020
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: Workqueue: events psi_avgs_wor=
k
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: RIP: 0010:collect_percpu_times=
+0x77a/0xe80
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: Code: 41 5d 41 5e 41 5f c3 cc =
cc cc cc 48 8b 54 24 68 49 c7 c1 00 b0 51 a8 49 b8 00 00 00 00 00 fc ff d=
f 48 c1 ea 03 4c 01 c2 f3 90 <49> 81 ff 00 20 00 00 0f 83 93 04 00 00 80 =
3a 00 0f 85 38 06 00 00
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: RSP: 0018:ffff888132d3f9f0 EFL=
AGS: 00000202
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: RAX: 0000000000000003 RBX: fff=
fe8ffffdf65c0 RCX: 0000000000000000
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: RDX: fffffbfff4c7018b RSI: 000=
0000000000000 RDI: ffffffffa2b19025
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: RBP: fffffbfff4c7018b R08: dff=
ffc0000000000 R09: ffffffffa851b000
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: R10: 0000000000000001 R11: 000=
0000000000000 R12: ffffffffa851b000
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: R13: 000000000000085b R14: dff=
ffc0000000000 R15: 0000000000000003
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: FS:  0000000000000000(0000) GS=
:ffff888467291000(0000) knlGS:0000000000000000
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: CR2: 00007f3350001158 CR3: 000=
00001040bc001 CR4: 00000000003706f0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel: Call Trace:
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  <TASK>
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? do_raw_spin_lock+0x12d/0x27=
0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? __pfx_collect_percpu_times+=
0x10/0x10
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? __pfx___mutex_lock+0x10/0x1=
0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? _raw_spin_unlock_irqrestore=
+0x27/0x60
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  psi_avgs_work+0x96/0x200
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? lock_acquire+0x154/0x2d0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? __pfx_psi_avgs_work+0x10/0x=
10
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? lock_release+0xc6/0x2a0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  process_one_work+0x86e/0x14b0=

Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? __pfx_process_one_work+0x10=
/0x10
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? assign_work+0x16c/0x240
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  worker_thread+0x5d0/0xfc0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? __pfx_worker_thread+0x10/0x=
10
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  kthread+0x375/0x750
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? ret_from_fork+0x1f/0x2f0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? lock_release+0xc6/0x2a0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ret_from_fork+0x215/0x2f0
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  ret_from_fork_asm+0x1a/0x30
Aug 03 10:17:26 qca-HP-ZBook-14-G2 kernel:  </TASK>

just a bit before, if it matters (this sequence occurred 3 times)...
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: The canary thread =
is apparently starving. Taking action.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Demoting known rea=
l-time threads.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Successfully demot=
ed thread 1861 of process 1789.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Successfully demot=
ed thread 1556 of process 1506.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Successfully demot=
ed thread 1567 of process 1505.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Successfully demot=
ed thread 1505 of process 1505.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Successfully demot=
ed thread 1568 of process 1510.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Successfully demot=
ed thread 1510 of process 1510.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Successfully demot=
ed thread 1559 of process 1509.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Successfully demot=
ed thread 1509 of process 1509.
Aug 03 10:14:02 qca-HP-ZBook-14-G2 rtkit-daemon[1557]: Demoted 8 threads.=




