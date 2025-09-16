Return-Path: <linux-kernel+bounces-819035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0CEB59A86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D2416E894
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9786532ED2F;
	Tue, 16 Sep 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFhBTekM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1F306B22
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033259; cv=none; b=psPsDYVbTIzAb9PERGeEobskurzNrnfgeUVa1cHw5gbAEGkFWE/0VFL2INhXDd5eBwR3Pz0BuhT1MTSoEiOgtJ4T4Y4m6oj0C3v52uO28OPpWxKlvsnGPfbc48oGbUIowk0g8nN/70XXhnNujqG75U5iMsSbkNdsn2qQwWs1Bps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033259; c=relaxed/simple;
	bh=KHZk4EViggi3RhbubCzOPGVKUuWKgzEbtKwopsxMPrU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYtK2mWtGc/Lq5oHJarvkxTOtHJcPzuMXKfW55gPefscdHL26HPCC6lxa4Q8vW6gSyY+OA8uTUwMJpfEks7UeXgnOgZ4yjT1OdCplD71fli8YhQW2tn7bJN6Pp61d30mkdNOZyielEp4ljA88IhkA9TPjJR9JGwGSezMaNDL16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFhBTekM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GADCNA005711
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rdEtDQ/KStUM2tmPeX6rUeKx
	5/Sj/ntciiL23PmicD8=; b=gFhBTekMdvNrezfAZwAcr/p6E31L6vSsqsUMpcOb
	ZAxpaI7Sst1ZDKIepI0F7xy6tjD7D6W5gTtdYU7WShbqHiSNT898ol6toLJVZJZq
	WBR+m5s8lH8K7+XW9bJXjAXUApheu0xbSIV7idTJWUTgu7xJWvn6FJF0NABVGorX
	CsVgkdKyrMCJrSItnJqLVSJP49bgJzdp8NVk+t76XBpTOHDIRhL8KHsLmDY0ShaS
	/Zuzn4kS6elJ7+YRVzRmmQy7B9AimGLG7J8+RLL4tGlG2a4R/dDyg863JOL8Sfam
	C0hK/gh8gTFlJaF/Ov4ThqkT76F4FsKA4tkfgDhtJIupKA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u593va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:34:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78e50889f83so145826d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033252; x=1758638052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdEtDQ/KStUM2tmPeX6rUeKx5/Sj/ntciiL23PmicD8=;
        b=Z0wuTPMTkre2QYAoZEWMKhJwIZNXg0KYiQp78rq00opNTAxc3VxMag2hac5K+oswnC
         kdcappoxeuZ0FFrP4oW84dNamDmyHg5ehpjv3rV3/G6pdV5l+10sXPMoekGDHc3luq7v
         pcY3WIlJ/3Gwohg5zHKq8EwMD1+I1Hxb1W/ykj31Oygea46OE9s3k8dN5xnVKo5qTHvQ
         QzPvEmBkDZXNzWN0Q44jQ7Cus1DsF8ruOTn2Sm2H3gmV9pbdE+7RnMujsIrIWp03m5lG
         Dyj6ODPGPhevZTBlxep2fxxWlYOHcJUhhfo4yUz9/4BSwobymXQwCAtx+dlkSrQ1GjxI
         5nuw==
X-Forwarded-Encrypted: i=1; AJvYcCWS+QdAPE7nM/uUV2/M8nbCpkfabqQoMpMNzVDW2/S6g0oEciB9EET3OwRVhDUvCIlW8jZNsS4s+ODlShU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAMgziurMBv00VkU9drZvCkFQQqP59BdJVNM4BBkwkwt5PH2d
	jJ5/s4l9iJKAvcCCPk48E5tqwskKSVOAQ50AJHXGcEmM6xDZ19vWYQjD+E5spKBYg4qg8hxUXTj
	3RPZXLkvtbOabNcLIVILuF4uvuQFkrhVxSe+QYt161ogfewb9n/LiVOPw+G+wG7oz6bk=
X-Gm-Gg: ASbGnctSgyZKaXAFvXU5fgtDtZJTLYAVp8h3nNpMZKGjPSTDUxlym00Dzj9fGz09itC
	H0xqheL3mNqp5KfcL1sq+fR/qav5AIp54slcFeYW9u2NFCmn7I4sjBj8fdokWv15IFcHphrmGOV
	qwaXBRAPDb/eCzr5WYs2W7hTt8Mp8mt0s4W+/VWzUVb81IJT4DQA1lDXGT9VU8wowutdVmEHVQz
	niRTAsXyn7XvwAXOW2HGjWfh49kKMlAyhtmKpt6rr1bgkqc0e+vNqTZIBMhLCCwQL32vwM8YvSW
	zIZFkdcGHW1lYLvsFgQT6PL5K8QSAWAzyH9UK51LAIs0oi6KYk1lqCJRqMYFgoTqbJCDHOHjNQM
	=
X-Received: by 2002:ad4:4ee9:0:b0:766:5890:c5a1 with SMTP id 6a1803df08f44-767c1f720edmr201816386d6.36.1758033252255;
        Tue, 16 Sep 2025 07:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ0AsHCnMPE5I5ZbfHkkcpXKs4CoGvMSzsghgSkRELqsV8abvYm9Jk0hzQBm/9IJHBCDCvOA==
X-Received: by 2002:ad4:4ee9:0:b0:766:5890:c5a1 with SMTP id 6a1803df08f44-767c1f720edmr201815576d6.36.1758033251461;
        Tue, 16 Sep 2025 07:34:11 -0700 (PDT)
Received: from trex (152.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea4b52b7fcsm9889568f8f.33.2025.09.16.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:34:10 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 16 Sep 2025 16:34:08 +0200
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
        quic_shazhuss@quicinc.com, krzk@kernel.org
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
Message-ID: <aMl1YGt91p1rAaG6@trex>
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
 <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
 <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>
 <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
X-Proofpoint-GUID: cK4Hb9AlrpAVIbXHx0fESStvCqKMEr5D
X-Proofpoint-ORIG-GUID: cK4Hb9AlrpAVIbXHx0fESStvCqKMEr5D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX/M9keXCj5/3z
 WLmRyoigC4tFwQuglIoHGxMWtukmefKEniSFAmEIZt3N4smvLX5ZvDd0/3IZoylmkxKTphfgqyb
 7xCBTjDh1zxcy8bKkdysjs5oGIdrNGA4mjVsB6uRMytibI7gEStTUu/PxviJIYN51Gyi4WfNUtC
 tVM5+rNZl8TglhPQWWneQZyMIKf9ZorF7ZFqzOW2yM3Q1M+NVjSfym6EiGPQTK0H/ln3uDtU1M1
 Q+0GZZG7trKtI49wD2TmjyhrIlIKX/0J9LIeqfnG0Lob4WcMtRqYuiu1Ob+qTkp2GLEiuL1Uoq1
 OTGVHm0BFEewxZYrbTd50JETyL4EPU6ORaoKaq5yqBJ1Vsd2gaYkyUYVxaoFIz3pnuxkEtAkfn8
 R0jTajcs
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c97566 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=UlsMzGb/nx+Jy78HFkoo8g==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=3dTM7dEFXz68Hci4Ch8A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

On 11/09/25 10:00:27, Alexey Klimov wrote:
> Hi Praveen,
> 
> On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
> > Hi Alexy,
> >
> > Thank you for update.
> >
> > On 9/10/2025 1:35 AM, Alexey Klimov wrote:
> >> 
> >> (adding Krzysztof to c/c)
> >> 
> >> On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
> >>> On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
> >>>> A deadlock is observed in the qcom_geni_serial driver during runtime
> >>>> resume. This occurs when the pinctrl subsystem reconfigures device pins
> >>>> via msm_pinmux_set_mux() while the serial device's interrupt is an
> >>>> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
> >>>> __synchronize_irq(), conflicting with the active wakeup state and
> >>>> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
> >>>> leading to system instability.
> >>>>
> >>>> The critical call trace leading to the deadlock is:
> >>>>
> >>>>      Call trace:
> >>>>      __switch_to+0xe0/0x120
> >>>>      __schedule+0x39c/0x978
> >>>>      schedule+0x5c/0xf8
> >>>>      __synchronize_irq+0x88/0xb4
> >>>>      disable_irq+0x3c/0x4c
> >>>>      msm_pinmux_set_mux+0x508/0x644
> >>>>      pinmux_enable_setting+0x190/0x2dc
> >>>>      pinctrl_commit_state+0x13c/0x208
> >>>>      pinctrl_pm_select_default_state+0x4c/0xa4
> >>>>      geni_se_resources_on+0xe8/0x154
> >>>>      qcom_geni_serial_runtime_resume+0x4c/0x88
> >>>>      pm_generic_runtime_resume+0x2c/0x44
> >>>>      __genpd_runtime_resume+0x30/0x80
> >>>>      genpd_runtime_resume+0x114/0x29c
> >>>>      __rpm_callback+0x48/0x1d8
> >>>>      rpm_callback+0x6c/0x78
> >>>>      rpm_resume+0x530/0x750
> >>>>      __pm_runtime_resume+0x50/0x94
> >>>>      handle_threaded_wake_irq+0x30/0x94
> >>>>      irq_thread_fn+0x2c/xa8
> >>>>      irq_thread+0x160/x248
> >>>>      kthread+0x110/x114
> >>>>      ret_from_fork+0x10/x20
> >>>>
> >>>> To resolve this, explicitly manage the wakeup IRQ state within the
> >>>> runtime suspend/resume callbacks. In the runtime resume callback, call
> >>>> disable_irq_wake() before enabling resources. This preemptively
> >>>> removes the "wakeup" capability from the IRQ, allowing subsequent
> >>>> interrupt management calls to proceed without conflict. An error path
> >>>> re-enables the wakeup IRQ if resource enablement fails.
> >>>>
> >>>> Conversely, in runtime suspend, call enable_irq_wake() after resources
> >>>> are disabled. This ensures the interrupt is configured as a wakeup
> >>>> source only once the device has fully entered its low-power state. An
> >>>> error path handles disabling the wakeup IRQ if the suspend operation
> >>>> fails.
> >>>>
> >>>> Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
> >>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> >>>
> >>> You forgot:
> >>>
> >>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> >>>
> >>> Also, not sure where this change will go, via Greg or Jiri, but ideally
> >>> this should be picked for current -rc cycle since regression is
> >>> introduced during latest merge window.
> >>>
> >>> I also would like to test it on qrb2210 rb1 where this regression is
> >>> reproduciable.
> >> 
> >> It doesn't seem that it fixes the regression on RB1 board:
> >> 
> >>   INFO: task kworker/u16:3:50 blocked for more than 120 seconds.
> >>         Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
> >>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>   task:kworker/u16:3   state:D stack:0     pid:50    tgid:50    ppid:2      task_flags:0x4208060 flags:0x00000010
> >>   Workqueue: async async_run_entry_fn
> >>   Call trace:
> >>    __switch_to+0xf0/0x1c0 (T)
> >>    __schedule+0x358/0x99c
> >>    schedule+0x34/0x11c
> >>    rpm_resume+0x17c/0x6a0
> >>    rpm_resume+0x2c4/0x6a0
> >>    rpm_resume+0x2c4/0x6a0
> >>    rpm_resume+0x2c4/0x6a0
> >>    __pm_runtime_resume+0x50/0x9c
> >>    __driver_probe_device+0x58/0x120
> >>    driver_probe_device+0x3c/0x154
> >>    __driver_attach_async_helper+0x4c/0xc0
> >>    async_run_entry_fn+0x34/0xe0
> >>    process_one_work+0x148/0x284
> >>    worker_thread+0x2c4/0x3e0
> >>    kthread+0x12c/0x210
> >>    ret_from_fork+0x10/0x20
> >>   INFO: task irq/92-4a8c000.:79 blocked for more than 120 seconds.
> >>         Not tainted 6.17.0-rc5-00018-g9dd1835ecda5-dirty #13
> >>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>   task:irq/92-4a8c000. state:D stack:0     pid:79    tgid:79    ppid:2      task_flags:0x208040 flags:0x00000010
> >>   Call trace:
> >>    __switch_to+0xf0/0x1c0 (T)
> >>    __schedule+0x358/0x99c
> >>    schedule+0x34/0x11c
> >>    __synchronize_irq+0x90/0xcc
> >>    disable_irq+0x3c/0x4c
> >>    msm_pinmux_set_mux+0x3b4/0x45c
> >>    pinmux_enable_setting+0x1fc/0x2d8
> >>    pinctrl_commit_state+0xa0/0x260
> >>    pinctrl_pm_select_default_state+0x4c/0xa0
> >>    geni_se_resources_on+0xe8/0x154
> >>    geni_serial_resource_state+0x8c/0xbc
> >>    qcom_geni_serial_runtime_resume+0x3c/0x88
> >>    pm_generic_runtime_resume+0x2c/0x44
> >>    __rpm_callback+0x48/0x1e0
> >>    rpm_callback+0x74/0x80
> >>    rpm_resume+0x3bc/0x6a0
> >>    __pm_runtime_resume+0x50/0x9c
> >>    handle_threaded_wake_irq+0x30/0x80
> >>    irq_thread_fn+0x2c/0xb0
> >>    irq_thread+0x170/0x334
> >>    kthread+0x12c/0x210
> >>    ret_from_fork+0x10/0x20
> >
> > I can see call stack is mostly similar for yours and mine but not 
> > completely at initial calls.
> >
> > Yours dump:
> >  >    qcom_geni_serial_runtime_resume+0x3c/0x88
> >  >    pm_generic_runtime_resume+0x2c/0x44
> >  >    __rpm_callback+0x48/0x1e0
> >  >    rpm_callback+0x74/0x80
> >  >    rpm_resume+0x3bc/0x6a0
> >  >    __pm_runtime_resume+0x50/0x9c
> >  >    handle_threaded_wake_irq+0x30/0x80
> >
> > Mine:
> >  >>>      qcom_geni_serial_runtime_resume+0x4c/0x88
> >  >>>      pm_generic_runtime_resume+0x2c/0x44
> >  >>>      __genpd_runtime_resume+0x30/0x80
> >  >>>      genpd_runtime_resume+0x114/0x29c
> >  >>>      __rpm_callback+0x48/0x1d8
> >  >>>      rpm_callback+0x6c/0x78
> >  >>>      rpm_resume+0x530/0x750
> >
> >
> > Can you please share what is DT file for this Board if possible?
> > is there any usecase enabled on this SE instance?
> 
> Well, yeah, sorry, I didn't really compared backtraces line to line and
> behaviour was exactly the same. I thought that the purpose was to fix
> the regression reported earlier.
> 
> RB1 main dts files are qrb2210-rb1.dts and qcm2290.dtsi.
> 
> The similar board RB2 uses qrb4210-rb2.dts and sm4250.dtsi+sm6115.dtsi,
> it is worth checking it as well.
> For testing here I didn't use anything extra (the only change was wifi fix
> from Loic); I tested -master and linux-next usually.
> 
> If you can tell me what is SE instance I may be able to answer. But
> as far as I know it is not a part of any infrastructure or CI machinery.
> I just boot the board and see if it works, if it does then I rebuild and
> test my changes (audio).
> 
> Best regards,
> Alexey
> 

will there be a fix any time soon Praveen? reverting "serial: qcom-geni:
Enable PM runtime for serial driver" does fix the problem on RB1.

Otherwise I suggest that we revert this commit on linux-next.

