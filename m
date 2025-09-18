Return-Path: <linux-kernel+bounces-822472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6307DB83F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 482784E2800
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3024167F;
	Thu, 18 Sep 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UHFidj9d"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84F26CE07
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190046; cv=none; b=G0JwYwmKrTNgiN4L75wnSK6s8a+Nq0KLIwn07P5mVSmeMPe1p94nxjof8kbgVTJ6HlKjsnVKCxa0jb+Nk8ID0GbYtdVo8mAB2JYiQehgTHl+JH5mf8/7U9bI81y+/T+a5Ab2aR8Qb2wBpuPYiUzywiKKy3qeKgQ4LD0f6FTF3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190046; c=relaxed/simple;
	bh=MaHkjJYwc8DMck7Xh9rwkZqfWOJBacfKsQYBgtQ+Umc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UARaih1x0gbgT4pqla3j9FrLOuODf78UiQW41Y3eiKsDJdKvmyCdBMfbHkx9af/lSwvjTGjDe/j8RGFr5Ss0yEvEy1dsI1QT69JL78nMXwvOhFn/dTN/DLVnTRe9B2X3lHrj4KtDwNc0TwVU9Vu30230wN957MMAmgbnODL1E/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UHFidj9d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6Q1m5030267
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GGOSNQ5nH47a+34ZmsmhGV0lPGcs11aQrS/2w7Sf1xk=; b=UHFidj9dVpLlZODi
	nDLsX2J00guAzO1R6kpuayxmCkoVrL679n2MCP7Ok8v+JzUkRjtFd2gB9vAfpEsx
	6jQ3khsk1Ce7wqK8w45V19ae8DBzNHOfClxu9fMXKjErjO1MwHnIoR3ew73HktPy
	bA0TMvb7Ta6w23VRpG6VzbQb74z0D3CeLVC231nZJo9x8y8pdv0t15BSnYw4/eZN
	UM7i88Xn0UG6G+cRcisvxz3qsNIHXzoH/67dYMSgwFmIf5Dksim0qWyuXXP7Ukh1
	uxqz8hWgTVcvCxuTkOHXPSfZmpiV82UCo0wNbYLkTyc4KPUDsDb9wgNyY/74Ef9Q
	fGElTg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jbu3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:07:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-79538b281cdso4911216d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758190043; x=1758794843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGOSNQ5nH47a+34ZmsmhGV0lPGcs11aQrS/2w7Sf1xk=;
        b=Cohv/2pBT0TL78HOcSR0i8wsMth4HxM8mlXU5kWqkCFkigzZIe2AL464xIX1vpl2od
         7p/MAM7EXIBiZuKsdL67YjI6NvtLYdJg/kZ9S6H4hykauRz6VCxYfs62ygyAlMIwtzWP
         vru2ApbIOYn6mM6wLVz2W77PPwzbp6qQeel7+aaPQpsS8aGLZzJOo8ftD5NAYNJ3pLP9
         inn+uK/pQnkVnCBzSnHCCqAh8Md+ZqPDt3SUU2R57uK8RYdNXrNbmkhdaHM6U/tTrotz
         otEub3ubmIWnhwz8/5s+iTuELRo4pnrCox+bz/ztOQ0+0HhBzalonMlreHKpoNMmPKV/
         4BLw==
X-Forwarded-Encrypted: i=1; AJvYcCUd9PQ19T3IdeL8V7SObewLHyBFDMU5/2FInDZ41RJKNEar9QmK+j8444nj9+6DkbL0YCPr6BeKAkrdLeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvoYsX32D1FXHe3h/WildrwTsG6GFWfIWsNisXmbh50yMPW3Yw
	6sRDewizJQ+S6nrfU5SXRZigyE4lQaM2iME1rYEC1FqSn/QtLfojayppXeeM3yGf1Uzknrb6mFu
	iwQFPXlPd+hjGcWGkKUX0+oIOONEdv6VvZzI0TpKG+e/tI6ptVFPCi2Vkz1YpFbQ2NQg=
X-Gm-Gg: ASbGncvDAiYy8yzQM+XS+0U/6kx32AR2F8VH0IRd5LESN+ZwIUNog/e41WWeNXTOApe
	ygHSN3xRNsiA52jcaFFH7dgautDklniKr2St5EDCjk2YZWucl7oxmUiCdZ/u+Kz+ijHloA++DSc
	C6Hpqs7IMlTEt9KdXKGZ+9QvpdtzAjyy1MgsB9CF+7paWgsW7FtG8LR/zxWJ925vDAmGjNtsVfU
	0rgTBpmj5r/nD6YB6YS8y9zHf0/eNNWmhuautey1puuNLR5aawXxnRY3+3O4b17/dtJQuAi0WnE
	p4vhseZKMzgSRM3rgJMWQPoYH4jzOpxXvl8dt7upL5BPAYRbf0wyggaeMCevmGlI6rJ7tgOq8Iw
	=
X-Received: by 2002:ad4:5fca:0:b0:72a:2e5b:af2f with SMTP id 6a1803df08f44-7927b757c00mr27754036d6.30.1758190042453;
        Thu, 18 Sep 2025 03:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFBEfjc7Tkt/1Iv7IF+XCof1OPXKA6VZBfDMdHjBqN0oeH0J4tmyEMtrM4m9cQn6cz5NMfNg==
X-Received: by 2002:ad4:5fca:0:b0:72a:2e5b:af2f with SMTP id 6a1803df08f44-7927b757c00mr27753456d6.30.1758190041748;
        Thu, 18 Sep 2025 03:07:21 -0700 (PDT)
Received: from trex (152.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e754140sm73363605e9.21.2025.09.18.03.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:07:21 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 18 Sep 2025 12:07:19 +0200
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
        psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
Subject: Re: [PATCH v2] serial: qcom_geni: Fix pinctrl deadlock on runtime
 resume
Message-ID: <aMvZ10EsMif/DOP4@trex>
References: <20250917185102.3763398-1-praveen.talari@oss.qualcomm.com>
 <dab18f70-4017-4c06-92c1-91cfd2229540@kernel.org>
 <8e2781ae-34d2-4009-bf8c-56aa1bb6fe85@oss.qualcomm.com>
 <aMuz/C1iT8JtjXbQ@trex>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMuz/C1iT8JtjXbQ@trex>
X-Proofpoint-ORIG-GUID: tgIBbeAh3Xv9GJsPdelR1iWnbT3qyxcT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX6FCND0fvNqRu
 hFPEWVKMAxcC9JU+JkUTkXJ500qjmo5qEJp6+gajFZBrKZzAtwV9gm+h36/gh3O6ODyydFKgJpk
 m3HmHTfCcZg9koXMXO07DfpMtpLcVc9AqKvj+80pl6+t3km4KaJ2qPaLhs7XhdX0OuvFN+7KWBT
 lOvHISdJk24VvH8ydtctqUFohOFhrANweV6TstbnBt/bPutcZG/GwV3QPrF4j9HHnKVuGthhxXl
 IDflHZil1j8xQlsMUTK2I2bMkFwVeOmWXtkOYHcvbv6oiQhjtejmkJ9DtRfeVcxB86YLiu7I5iB
 5X7mrCIfC7tqQ6YCzL7rSNARHbmqND3i/nrK1NDjdi75UyB+FWwj62E4JmsnZNIfWrxx2px5IR1
 CaZHAzgq
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cbd9db cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=UlsMzGb/nx+Jy78HFkoo8g==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=UD1JcZfzldWnGte6AesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tgIBbeAh3Xv9GJsPdelR1iWnbT3qyxcT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

On 18/09/25 09:25:48, Jorge Ramirez wrote:
> On 18/09/25 09:25:53, Praveen Talari wrote:
> > Hi Krzysztof,
> > 
> > On 9/18/2025 5:28 AM, Krzysztof Kozlowski wrote:
> > > On 18/09/2025 03:51, Praveen Talari wrote:
> > > > A stall was observed in disable_irq() during
> > > > pinctrl_pm_select_default_state(), triggered by wakeup IRQ being active
> > > > while the UART port was not yet active. This led to a hang in
> > > > __synchronize_irq(), as shown in the following trace:
> > > > 
> > > > Call trace:
> > > >      __switch_to+0xe0/0x120
> > > >      __schedule+0x39c/0x978
> > > >      schedule+0x5c/0xf8
> > > >      __synchronize_irq+0x88/0xb4
> > > >      disable_irq+0x3c/0x4c
> > > >      msm_pinmux_set_mux+0x508/0x644
> > > >      pinmux_enable_setting+0x190/0x2dc
> > > >      pinctrl_commit_state+0x13c/0x208
> > > >      pinctrl_pm_select_default_state+0x4c/0xa4
> > > >      geni_se_resources_on+0xe8/0x154
> > > >      qcom_geni_serial_runtime_resume+0x4c/0x88
> > > >      pm_generic_runtime_resume+0x2c/0x44
> > > >      __genpd_runtime_resume+0x30/0x80
> > > >      genpd_runtime_resume+0x114/0x29c
> > > >      __rpm_callback+0x48/0x1d8
> > > >      rpm_callback+0x6c/0x78
> > > >      rpm_resume+0x530/0x750
> > > >      __pm_runtime_resume+0x50/0x94
> > > >      handle_threaded_wake_irq+0x30/0x94
> > > >      irq_thread_fn+0x2c/0xa8
> > > >      irq_thread+0x160/0x248
> > > >      kthread+0x110/0x114
> > > >      ret_from_fork+0x10/0x20
> > > > 
> > > > To fix this, wakeup IRQ setup is moved from probe to UART startup,
> > > > ensuring it is only configured when the port is active. Correspondingly,
> > > > the wakeup IRQ is cleared during shutdown. This avoids premature IRQ
> > > > disable during pinctrl setup and prevents the observed stall. The probe
> > > > and remove pathsare simplified by removing redundant wakeup IRQ handling.
> > > > 
> > > > Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
> > > > Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
> > > > Closes: https://lore.kernel.org/all/DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org/
> > > > Tested-by: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
> > > 
> > > Where did you receive this tag for this patch exactly?
> > 
> > Since Jorge was involved in validating the change, I’ve added him under the
> > Tested-by tag.
> > 
> > Please correct me if I’m not supposed to add this tag myself.
> 
> let's test a bit further Praveen - we need to validate/trace the wake
> path on a real scenairo to make sure it is not cpu intensive (although I
> suspect the 2% was due to the storm you described more than to the code
> path itself)
> 
> I can then provide the tested-by on the list.
> 

um bluetooh comms are broken - reverting the runtime_pm patch fixes it.
and the proposed fix (V2) does not address this scenario.

I agree with the common sentiment, I think the patch should be reverted
in linux-next and better test definition shared.

[    1.451715] Bluetooth: Core ver 2.22
[    1.460668] Bluetooth: HCI device and connection manager initialized
[    1.467034] Bluetooth: HCI socket layer initialized
[    1.471922] Bluetooth: L2CAP socket layer initialized
[    1.476988] Bluetooth: SCO socket layer initialized
[    2.504958] Bluetooth: HCI UART driver ver 2.3
[    2.509427] Bluetooth: HCI UART protocol H4 registered
[    2.514600] Bluetooth: HCI UART protocol LL registered
[    2.519978] Bluetooth: HCI UART protocol Broadcom registered
[    2.525662] Bluetooth: HCI UART protocol QCA registered
[    2.530915] Bluetooth: HCI UART protocol Marvell registered
[    2.764571] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    2.770503] Bluetooth: HIDP socket layer initialized
[    3.901958] Bluetooth: hci0: setting up wcn399x
[    6.202761] Bluetooth: hci0: command 0xfc00 tx timeout
[    6.212294] Bluetooth: hci0: Reading QCA version information failed (-110)
[    6.219261] Bluetooth: hci0: Retry BT power ON:0
[    8.538729] Bluetooth: hci0: command 0xfc00 tx timeout
[    8.543988] Bluetooth: hci0: Reading QCA version information failed (-110)
[    8.550989] Bluetooth: hci0: Retry BT power ON:1
[   10.810736] Bluetooth: hci0: command 0xfc00 tx timeout
[   10.816095] Bluetooth: hci0: Reading QCA version information failed (-110)
[   10.816110] Bluetooth: hci0: Retry BT power ON:2
[   13.082946] Bluetooth: hci0: command 0xfc00 tx timeout
[   13.088490] Bluetooth: hci0: Reading QCA version information failed (-110):

