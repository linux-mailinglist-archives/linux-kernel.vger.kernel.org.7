Return-Path: <linux-kernel+bounces-864411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F4BFABCD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 808844FB6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE93002D8;
	Wed, 22 Oct 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQ+WIKNp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A42FF15E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120028; cv=none; b=CC8fxACCAdv6ir3chLfVH0PCRKlL7njTQrnth1aFP9/EDE3ngTwu91BF+OVRz0nyNnHcaYM3ibn2IX1nZa8/PZD0/u+UcnD1zCXDHrcDZQRXUFIkoxrp0m/Ycsj84olr2awiody6918jiSjE6EBF5GpH6YoxzaQ4axrxtHL1/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120028; c=relaxed/simple;
	bh=L6JYs4ivoCFvVciQgaMIR/lmHduqqGaaz0VtISeqwJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQJliuGEK+Z5tvxTkrPMIuymGY5RSg1CWULCk8udauoPlG/zFkaEJLaz+OS//cO7L9jvRQEvQMsZI+ReLNjuVLMfFy/0jlHXt+20KtctjtUnLu6gRQkQCpN9isZy1K3ti3zzjBDvZOwJAo2bqPtzf77tIC/guUObTZJo55Hacp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQ+WIKNp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M366iY031133
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XYXVFaAaMLwr6fG2n4FdstC9bqlVQImA3Ymx6v8/8mI=; b=nQ+WIKNppkakuGoq
	HNCN57+udiDo9ZKqUV2gpSbuppm2Gs7W6lfqPcebpF21aUqbzMPsxh399Vr7Q/XM
	+u0aLJxhQa68vIJ1qmxla0JukMwXMSzCeKWxTPnWAU8H9khPMG2V7/Skixpdyybc
	NqdB05mXyKXpFkC8eD+BrMiEtXBDueQQkDwnOM6JS8G4OclIQCL+mf+QEwwF+luJ
	//eNrKanvzCpAyKY2bzUhgYg5+T+GFcNuYh4yVRSc2mibI4hvwMVag0wNq+Qwq98
	IZs3U8YVfxfeexExDzk6fIGJYWDdpgNHWs+hkU4G/0ucAYVTOm2kc4k9IpghZlSp
	8y9QCQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kbm6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:00:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-781253de15aso14696683b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120025; x=1761724825;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYXVFaAaMLwr6fG2n4FdstC9bqlVQImA3Ymx6v8/8mI=;
        b=mRnUCyU9tkERnsNDXgx0cF3PpNQXKPEnDnflAWZZ6ovSc632vG8m8ajTLpdBgk8dL9
         9lqU8W4+8dEeeWAsDioVPL8W3uqs597x6D9vDyP8/qXNrySBaA7yGj1E6zzhzkIH2O0c
         932S6AUrI6u5NT5wIxYINAzofZumjw99fSpPccK5k8vcPymAFN31OV3s0zVr7lIsRfuB
         VrM4EeYMF0hHr0csvUmBWiXBVJZ378HMl9nI6cSZFjlSMG3oKVkesCdtAMEnYdXSeeAN
         w+cT6NO3RwzikMazYW3lXfmEhGuf0UHAXpCE8AvavJj1Gg18Uw9gaIWRu6EjLV2m7dwH
         ySGg==
X-Forwarded-Encrypted: i=1; AJvYcCUBD1J+nYqHRh8kPOuKAs5Al9mSlD2ctxS0skCTH1F39dkkFRAqSFdkTaYhmRq7OigltcklBmF4fweaBZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOFdFOeLru0SoVplL1FvJbUPuAkqcqr+FKMdcODgP+Yb66kBuz
	cLjoo9tWb64sTdtkJZgw8EEtUnbWi4lT/WlFiLzkVkRecp5PnNdJqjzaxCo+Hw0WEAWXQWX33mS
	20+FdM+6lRgzL7uth91sbIC0iTbCjiyxRTxUglXdAueFbapT5NgM0J53aa13D23Wc4WI=
X-Gm-Gg: ASbGncv5f5ZwJc6QlsdO9AmyQdLoLBjAiH3qGMd5oOE6MGxeCT4rDKktV5Xkxckz+T3
	uzrXJ8ioQkzY8rbEFyjlp5CdkiuRTkgbZ8NrovDfO1qAdBuOcgGbWUq5wCg+CXFlHFVF9NzBjr5
	A/CU3DCalzyiugficuZLRtF6vsmkvCZnkRzIrUfFSprTExlv6q3B+rnVSJf+XdyiU03JhnDIkqS
	Uv7imQc7EcKsSxnkexkEheP2SZvIOEGxCeqOJJOYCZXXixHb0EIalWgIpDMXV2oEyCoO1gGKW5a
	2Qx1r1TNc15+omTVguHGLiM7sxxkB7Cqkr5MP2jyilqjFAayMbTxnTWyVl0o4vtM0n2KOMN6nVb
	A1F1zVxk7bT7mpTvXX8mM4v0th86EDVY2JJvSdHCLtK1fGAgjf5fNySxrSzu9XfRnCyjdguyb
X-Received: by 2002:a05:6a00:99b:b0:793:1955:2384 with SMTP id d2e1a72fcca58-7a220ada794mr29166882b3a.17.1761120025196;
        Wed, 22 Oct 2025 01:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVyRz86S4Hw9/gYeNtzxJUUmTcx16JDUBodGshnXBo7XeH/deuGV1Ia/yK2XgOqxc89Wmg0Q==
X-Received: by 2002:a05:6a00:99b:b0:793:1955:2384 with SMTP id d2e1a72fcca58-7a220ada794mr29166840b3a.17.1761120024635;
        Wed, 22 Oct 2025 01:00:24 -0700 (PDT)
Received: from [10.133.33.147] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121ebfsm13617531b3a.70.2025.10.22.01.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:00:24 -0700 (PDT)
Message-ID: <5466e122-9143-482e-a9ab-7f956e19bf86@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 16:00:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ath10k fails initialization, bisected to "wifi:
 ath10k: avoid unnecessary wait for service ready message"
To: Klaus Kudielka <klaus.kudielka@gmail.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        regressions@lists.linux.dev
References: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
 <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
 <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
 <76d4235d-db4e-40f4-9ede-8cb536b82fbd@oss.qualcomm.com>
 <10919281648e306fd3f6713437b4793c50bb6692.camel@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <10919281648e306fd3f6713437b4793c50bb6692.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Mh5F65IhmbofXpgg2Ytee9ovdEksPplU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfXxqNGg796/upS
 7X6LorPHvyAD3Q31TP2/jowGQdDKrCXb/zC8Ntja6Aw3vkhauVenoWPJmnb7I7pcXCUgsqVSB56
 Ov0g1T0il8AvBwqMP4fFq2SBc54Iq1vH23MxerB4UjWO2mEMupimY8BF/UqyLqzi0J6kSMniLKM
 ACQVXIb8KQ0B/+MKHGom1D1UlFx58me117BO1WflfEb12mfFMi3/aQzKJnen9cdvmDhsE2nmpQa
 L7bNdYSCaMt8aGOzbp7S4swSG3BynXTC8MzwRzycNcFtwrzixD2gMHHLuQyfZT+Kh8FDQEqXET9
 XqkjchQcNQbwkb/A8rv26AoSoB8+PwKMUJobj2KO5fsy8rQb7jKt7kcTJJ3aT+5F1JxSzm9TknF
 CJAHzcD5RubRV03t6V857bTkKltg7Q==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f88f1a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=PjCq7wsziC7u3JKYlTIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Mh5F65IhmbofXpgg2Ytee9ovdEksPplU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031



On 10/18/2025 9:50 PM, Klaus Kudielka wrote:
> On Fri, 2025-10-17 at 08:57 -0700, Jeff Johnson wrote:
>> On 10/17/2025 8:37 AM, Klaus Kudielka wrote:
>>> Unfortunately, this particular commit completely breaks the ath10k driver in my setup.
>>>
>>>
>>> Hardware:
>>> - Turris Omnia (arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)
>>> - Wifi card (output from lspci): Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter
>>
>> This issue was previously reported with that particular chipset.
>> This is currently being tracked at:
>> https://bugzilla.kernel.org/show_bug.cgi?id=220671
>>
>> It may be useful to supply your information as a separate record to that bug.
>>
>> /jeff
> 
> Some more observations on that topic with the hardware shown above.
> 
> ath10k_core_start() calls ath10k_wmi_wait_for_service_ready(), and later ath10k_wmi_wait_for_unified_ready().
> 
> The now *unconditional* call to ath10k_hif_send_complete_check() inside ath10k_wmi_wait_for_service_ready()
> makes the later call to ath10k_wmi_wait_for_unified_ready() fail.
> 
> If I call and handle wait_for_completion_timeout() first (as it was before the patch),
> ath10k_hif_send_complete_check() is *not* called, and both ath10k_wmi_wait_for_service_ready() and
> ath10k_wmi_wait_for_unified_ready() succeed. Everything is back to normal.
> 
> Side note:
> ath10k_wmi_wait_for_service_ready() succeeds in both cases with time_left == WMI_SERVICE_READY_TIMEOUT_HZ.
> 
> 
> #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=220671

Thank you Klaus, can you please try if below diff can fix this regression?

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 7bbda46cfd93..1a981d333b5c 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1256,6 +1256,19 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int
ce_id)
 }
 EXPORT_SYMBOL(ath10k_ce_per_engine_service);

+void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id)
+{
+       struct ath10k_ce *ce = ath10k_ce_priv(ar);
+       struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
+
+       if (ce_state->recv_cb)
+               ce_state->recv_cb(ce_state);
+
+       if (ce_state->send_cb)
+               ce_state->send_cb(ce_state);
+}
+EXPORT_SYMBOL(ath10k_ce_per_engine_check);
+
 /*
  * Handler for per-engine interrupts on ALL active CEs.
  * This is used in cases where the system is sharing a
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index 27367bd64e95..9923530e51eb 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -255,6 +255,7 @@ int ath10k_ce_cancel_send_next(struct ath10k_ce_pipe *ce_state,
 /*==================CE Interrupt Handlers====================*/
 void ath10k_ce_per_engine_service_any(struct ath10k *ar);
 void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id);
+void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id);
 void ath10k_ce_disable_interrupt(struct ath10k *ar, int ce_id);
 void ath10k_ce_disable_interrupts(struct ath10k *ar);
 void ath10k_ce_enable_interrupt(struct ath10k *ar, int ce_id);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 97b49bf4ad80..ce8e0c2fb975 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1812,7 +1812,7 @@ void ath10k_pci_hif_send_complete_check(struct ath10k *ar, u8 pipe,
                if (resources > (ar_pci->attr[pipe].src_nentries >> 1))
                        return;
        }
-       ath10k_ce_per_engine_service(ar, pipe);
+       ath10k_ce_per_engine_check(ar, pipe);
 }

 static void ath10k_pci_rx_retry_sync(struct ath10k *ar)




