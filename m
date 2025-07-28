Return-Path: <linux-kernel+bounces-747836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A87B138F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E357A5C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B324676A;
	Mon, 28 Jul 2025 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V4co8DeY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC31CAA79
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698619; cv=none; b=L7WKcE9/cM2HKtmbCqYO9+hqDXJNxUPTlRCRkvwIfCkQdJeR7enTQIhWV3CwDDIM9V/IRY6GK97Mx7sXNip8XJgbmXpDnLPNAg/vVdrVvbsstcP6TYZJRV6vQRlVDMfF+SaxaVrxEkZY+367ZM/+KGktkHjsBdXT4puVNckcOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698619; c=relaxed/simple;
	bh=4vFJKZ20JoDYDpHzrACMlyjLsMA40zA9ZOzsUu/Pjoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcoXx9HpzT4bp/nbnIEqxsk88vdEJVIwD+gFJizPO2lNiskjQDYmR85NJb1GcqnHKdO6Ru/4zDV7SS3zN+MNhSuQMCu3jWaHC38rjfWVS3j7WtJ72aVHqOh2JHRbj4PBtSv3YqB8FNWZ48DWz/gdXSrkSBDC2ASj/IdwXxKP1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V4co8DeY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rQLI008438
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jd4jPTJZhxKDES4qsp1a4FtiRTBXAwjqIYn7iPQId2M=; b=V4co8DeYdVEjkfDT
	w9o+LpN/onk+X/VlV7UL6+xQJKRiiXyWikz5sFRU1L5QlSGdogmGCToqnWx4Px28
	RypxgSYISWTlqjqYdVlJv1c7fNtODyoFpITEi/C88p+H+C3CmdheKfIfe8/1d3Q6
	6D5tvzNUaTB4tA0RcJRL0gVhwBiK4TVJoWEHWPNS2FHGXCIh84CGKSIIZIJozoMS
	0EWsYWQ+nhuBFJevDsMjp26sDMNltXpNbvhu/Ubp2yH507a4nCOVsuzQBIWuLTbq
	GVAiFvHkPDwIGnVf0NGcTUJQirK1US71jJGzs5oVyqJkAKjbUkRgGPfFTIzr2Tgd
	gQp3LQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qsk47na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:30:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e2c8137662so917375185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 03:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753698615; x=1754303415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jd4jPTJZhxKDES4qsp1a4FtiRTBXAwjqIYn7iPQId2M=;
        b=P8VoqCLDgmSek9Kqz7acva2j+SyQ691Y6G9lYxbiIe+1LeO+rbqhfwvvAG5rb4HptT
         hOsNIaz9gaipi8W0okn78CPNKH3FkQC4QK99cjeYpyuPth5VDbVdbP62oitl7vLn3gOn
         1dPFJRGWOugQEGWxJXclEtIKW+MnHiRR68qPcdEKV611VDa4WFKofe70DJpNRx/dgT9v
         K85WlhScottxR7TXw33rBHWTOPFDOBQGXV0h4t9ue456Yg/RxeoteWL5B/ndkA5WRsnm
         G1+kw1ZJw4P7AAXE29j3SaKrXGjet0gdp+of4/RuUwYnAII4ijYJR/yWKOsVXp6RUqkk
         WeKg==
X-Forwarded-Encrypted: i=1; AJvYcCXo8ggNrpNZWJ26wJbYJa8Dl1m7yNaZPnUZZpa3fPoTox7OvHzUl6TGsD/w1td8NfwbWAyeEq2GaNffMUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkUGA6umOHTQgLXsq7hvyKKcEDDCR1AY9o75+uotJYg+8qGuH
	/2ixxTk1gVcswxFCuvMrn5P+2ZImyQV+v8dPxufTytdTLWoFX1OW9KL8HLw5JUck/uaw8qCzKx3
	Z0qpuZMEfMe9hwaISLd2395fKVBsm7cYphWrVY08llqTpVaDoWqWGlc/ls00g6l303Mo=
X-Gm-Gg: ASbGnctqLeWonlC2L6tGmwRrxMpiNN7vrGgHICQxcFr4X9f2qGeXdLMWYcfcPBjct3Z
	7y0p4kkM88EYLFB4HKjBFV05LkMXGv6Bemiia731v0gR6JeqMpEd1eHX14oYDPvPnTchHwd7d6p
	wpgAtMdDmGsuNNTLrToC7BqdLjnLzdHlWOs0rjTPS34JWFT/eBjRREPPgwem79FosXyLxCT9UJZ
	XPHQGH8AL0XDL0C84Jryvr8yzfJkJX8s7/JZnb2toTWZYryd0p6SJYONV9jYF3MPcqOKTZTK1ot
	lShIQcbQlNyWxKcjO/xkbyfb2nCMJf6mzfoivMYJZV/8PKr1uH+od2cJ3RvIsN2VccOoaQrS1HK
	JrcL2Xr4VNU/vbY67Ux0lmGuoPIPE/lMb5ZzGjGXF12+g9ngduOiUcZzpySE4JKVCHtKrb8NYyn
	siHjz2sTFtYLV+8lWVXw==
X-Received: by 2002:ad4:5965:0:b0:702:d7ff:27f9 with SMTP id 6a1803df08f44-707205a9bdamr128692266d6.24.1753698614925;
        Mon, 28 Jul 2025 03:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGypUPlor8dmGzCs1Hb1KwVlQ5U63aDnG8xB7AQNMeXC1aEHwrW5Sk+cmb76e/+qaKsdRzhDg==
X-Received: by 2002:ad4:5965:0:b0:702:d7ff:27f9 with SMTP id 6a1803df08f44-707205a9bdamr128691766d6.24.1753698614326;
        Mon, 28 Jul 2025 03:30:14 -0700 (PDT)
Received: from ?IPV6:2001:14bb:cc:47df:318b:ca77:b793:45a5? (2001-14bb-cc-47df-318b-ca77-b793-45a5.rev.dnainternet.fi. [2001:14bb:cc:47df:318b:ca77:b793:45a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63375ca4sm1203262e87.124.2025.07.28.03.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 03:30:13 -0700 (PDT)
Message-ID: <2ee9a4c7-f971-4b73-8c83-cbb26c7072fd@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 13:30:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through
 secure calls
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250722-eud_mode_manager_secure_access-v7-1-40e9a4569895@oss.qualcomm.com>
 <2025072446-ensnare-hardhead-12f5@gregkh>
 <CAPHGfUMnaJ8HPX=CC_q6m2nbq-ODP=MY_NkcvHjXR8mD9b=tBQ@mail.gmail.com>
 <fo4hek5twtgl7fa5ncqefatowz5nw64iwifaibl3yyzonucpqz@uwwxf5jdke2x>
 <CAPHGfUOusGDDumM81ZwfWCT+4H6ku2rTgYw4Wuz3KduZ96KhXg@mail.gmail.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <CAPHGfUOusGDDumM81ZwfWCT+4H6ku2rTgYw4Wuz3KduZ96KhXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=68875139 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ag1SF4gXAAAA:8 a=COk6AnOGAAAA:8
 a=SYl7J9Ou-g_foRn2Kr0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zykoYzTxIl-YzI74WmO2VdLjqOzppfuA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA3NiBTYWx0ZWRfXxASxw+jVVyHk
 VXwiqw8Z7iJe3z37PBO3wsnOXdQRY5btWYW3m3tlCfo4janu7yrfT3nAoK/tn6Db11wRDI9pEsu
 fhDJInPzgXe6inLEQDWZg7J0joN4nC8Ir2mo+aWZtgjG18g+2AhXyKn4jgkMAMlpiofatI2plv4
 fFElM1eZyloVhZOimBaSytYlZXeKBbG8ve2Va3bP3NLvvxtg3lPg+t/JJ6iRV7AOsS9b9xRMLzS
 wjgIKjJZB1fUPPYxs34ks3FJN1wvU6nukgkIz6Zj29r7+gbX9/eC8ux7HPfkuH/v/yX4SKvn432
 ZSe71gF3MXGJQNCbtZAfbw1lVXNPU0E765X4S5dNntxaFM6LXO5pK6mCXy+At5Y38drHYpB17es
 LmlQsF7UWFF/73VZdeC0f4QCDJfrWoJY9JZXSuoTLhQ+OKIkRxv4FUvv48D+5bWi7xJUYgrI
X-Proofpoint-ORIG-GUID: zykoYzTxIl-YzI74WmO2VdLjqOzppfuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280076

On 28/07/2025 13:19, Komal Bajaj wrote:
> On Fri, Jul 25, 2025 at 7:07 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Fri, Jul 25, 2025 at 06:19:21PM +0530, Komal Bajaj wrote:
>>> On Thu, Jul 24, 2025 at 3:06 PM Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Tue, Jul 22, 2025 at 05:01:53PM +0530, Komal Bajaj wrote:
>>>>> EUD_MODE_MANAGER2 register is mapped to a memory region that is marked
>>>>> as read-only for operating system running at EL1, enforcing access
>>>>> restrictions that prohibit direct memory-mapped writes via writel().
>>>>>
>>>>> Attempts to write to this region from HLOS can result in silent failures
>>>>> or memory access violations, particularly when toggling EUD (Embedded
>>>>> USB Debugger) state. To ensure secure register access, modify the driver
>>>>> to use qcom_scm_io_writel(), which routes the write operation to Qualcomm
>>>>> Secure Channel Monitor (SCM). SCM has the necessary permissions to access
>>>>> protected memory regions, enabling reliable control over EUD state.
>>>>>
>>>>> SC7280, the only user of EUD is also affected, indicating that this could
>>>>> never have worked on a properly fused device.
>>>>>
>>>>> Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded USB Debugger(EUD)")
>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> [...]
>>
>>>>> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
>>>>> index 6497c4e81e951a14201ad965dadc29f9888f8254..73ebd3257625e4567f33636cdfd756344b9ed4e7 100644
>>>>> --- a/drivers/usb/misc/Kconfig
>>>>> +++ b/drivers/usb/misc/Kconfig
>>>>> @@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
>>>>>   config USB_QCOM_EUD
>>>>>        tristate "QCOM Embedded USB Debugger(EUD) Driver"
>>>>>        depends on ARCH_QCOM || COMPILE_TEST
>>>>> +     depends on QCOM_SCM
>>>>
>>>> You now are preventing this code from ever being able to be built in any
>>>> testing systems, including mine, so I don't even know if this patch
>>>> builds or not.
>>>>
>>>> You did not even document this in the changelog :(
>>>
>>> QCOM_SCM is essential for QCOM_EUD for its functionality.
>>> One option I'm considering is using select QCOM_SCM, which ensures
>>> dependency is enabled when QCOM_EUD is selected. QCOM_SCM facilitates
>>> communication with secure world, this approach should not cause issues even
>>> when COMPILE_TEST is enabled on non-ARCH_QCOM platforms.
>>
>> QCOM_SCM is not user-selectable, to it is not correct to depend on it.
>> Have you had used `git grep`, you'd have seen that absolute majority of
>> the drivers uses `select QCOM_SCM`.
> 
> I had initially used select QCOM_SCM in an earlier patch, but based on
> the concern
> raised about enabling it under COMPILE_TEST on non-ARCH_QCOM platforms,
> I revised it to use a depends on condition.

QCOM_SCM can be selected on non-QCOM platforms, so there should be no 
concerns for that.

> 
>>
>>> Alternatively, I could use a conditional depends expression like:
>>> depends on (ARCH_QCOM && QCOM_SCM) || COMPILE_TEST
>>>
>>> This would allow the driver to be built under COMPILE_TEST while ensuring
>>> QCOM_SCM is present on actual QCOM platforms. However, this would
>>> require proper stubbing in the qcom_scm driver to avoid build failures during
>>> compile testing.
>>
>> --
>> With best wishes
>> Dmitry


-- 
With best wishes
Dmitry

