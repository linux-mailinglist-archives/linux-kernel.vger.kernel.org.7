Return-Path: <linux-kernel+bounces-768411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66623B260E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203071C22F40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FE22EA17C;
	Thu, 14 Aug 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/UceC3B"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529F1F4C87
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163474; cv=none; b=B4VzIl3zRHMkrRAqwm/AEWTRiQP+Sjg7ySr5vBQxeJwHjwNjwIT/aPwFD2bUXdTRY/82hzCQvD/ZCjEYrFPcp/WbCXiTYO7Vz4+TNV9uyISNHlH4xi0YmkGY1aW/p4020myQmiIvB9MfGFu5qQX5yY26UQxJ+YfKLU4KOvFf7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163474; c=relaxed/simple;
	bh=vdaFT7lJHU1/bcbxgfs+eVOcQaHzEaLo8oTJQTgX0JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfrHlJaHEW5rlaKWM+MfXmPUddXKKRzyp0fSe74Em/ZNQODbpwb0wXgCw3bc1j5KlFw3DPjc/9hPkSfsXTEuJ0XgHXGcGC/egcHKPmW+NICtn9l7MED5obltBlCKEjRTiNKbz9+Y8q1YGeHFkh+YoY2rj3Wzy68kA8qe8ZGtsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/UceC3B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E002Ja023968
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cik/yynWNoCTrOCfvMEnMDYo2lqNO1rXkT0A2/bPuyc=; b=O/UceC3BqWpcIlyK
	Ml6jA34oMfkUkMHW1XTBrXLlFzP+ouX+jhGB7RduO0zDnIQlNhstNvOW6dTA9aFu
	WIuSfdmseuhnccOxi/JKsUNEf2U1N3CPhyEE2mrB9B/40KYcqbbTM/FVKWF4Y7/4
	enQ26G3D5Mh7YIRPNGL5/gTRB41q0mnDyKTJLF/m9s5JFoxRp3wL6LW9po/ie3ly
	TPsM+j3LkTSDCfxjrR+AEbnsQnikFSoonfFPRBAmf0kRS/Yh+3+S9+KX4BvfHt4c
	Um2jr60DBvFh/S6Zp8OijisKQ2pVZylZPB7iO+VAknTNpF0xxh6I2cboojSwfMsy
	pPAKXA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9rusjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:24:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109be4724so2919361cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163471; x=1755768271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cik/yynWNoCTrOCfvMEnMDYo2lqNO1rXkT0A2/bPuyc=;
        b=UsPnENJOSmea/D9DemRJ/YvGsj806Yp35Agp62Il9VEPOW4hM/Or3nQW9JmYW9IPBK
         BBqozGudh421DFec0xK2lHmgQ1MR293OgY/Wyp+rBbQzaFS+jYQLE6LlgxShT5t05X+N
         PcMAEUnOgTGIptyfAOKPf+/nqxnRcZGC2Lc6qz18UmOPQDVN/CYy90tOATX0GtgIMxry
         Rz57BLX/olvCCTb9DPzU0fsOekynvb9tvFX3s+UIwEPdOx0R/K9NTicOyeIUvP5W4+iI
         2PYIHwFXHkyza11v7OXwKQGh2R1YVPNItuDC5fudu1BGIN2NPGJfsvuIUT9IrwCn6Uau
         aBgg==
X-Forwarded-Encrypted: i=1; AJvYcCU+/pcOO5qrG1sGDzta9cNZQW5dTDz4/obbADE1e87hJ6YM6HHOdwESWABt4v06+dPaMlc8b7Kdn/nw6Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCNGGjRArByC5/36eJd2cV/tZuDOnxx4vQzpoKN1MsE76GfLy
	GouhGPFkmwXrgqDdQ2AW8GaflfyyQFI27o0e8Msiy05KVSxsC1OTbDEnIoaH2JmXutBexabDBS7
	na9aOvEEWBWHXstLLBQ01CScEbcYfB+BqdF49KWjuL/q8+upQY6AaQiZYhzeo4Bl4/kg=
X-Gm-Gg: ASbGncsZZ9oQPcGdpYOh1T3i/6Z9iCB+dsPUpVbn4H1VKP3+Kom42VZyf7Cy9Yoxuxz
	7amarP7MGFPynpX+Afct6oMikfDUOUG9mwYwcIouaPcnQMae4lkzeCaFOzpFG9IALAUABJ7gf9K
	BWNHbZ+zHmKgmZMrIhCjCT/2tfeTyftpXgNwk+rfseafqjDQasTUKlb4zCSyI7rdQpOY+0QaZRY
	LHKS8zB4XEzdDr7ibVR7Fwnhl9KXwzhEppDyYHBN7B8S/T8ZOs0iLjCvVVmaqNDRJS4KIVY2Ojn
	EyFpo9bdGC7lCusDvKHJCaDg1Y/8T76cOpcStPoRq3ArwaB3F7eqBp8B/O3xsrMCXtCxugE8Vxu
	pIHEHB57OSVttZws9AA==
X-Received: by 2002:ac8:5dce:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0fc6cbd31mr38631821cf.4.1755163471167;
        Thu, 14 Aug 2025 02:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNu4E16imK1oApBn97vhiibZw4d0qerBevQJrwiUss6ZWux0iiLHaeAGCcSK7HzskKOZmvLw==
X-Received: by 2002:ac8:5dce:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0fc6cbd31mr38631581cf.4.1755163470184;
        Thu, 14 Aug 2025 02:24:30 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3792sm2544145066b.50.2025.08.14.02.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:24:29 -0700 (PDT)
Message-ID: <aecbe59b-6ae6-47da-bcc4-9a49cbdce591@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 11:24:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] soc: qcom: ubwc: add more missing platforms
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
 <20250814-more-ubwc-v1-2-d520f298220d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250814-more-ubwc-v1-2-d520f298220d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfX8KpZvCLgDe5o
 AfXBgkM1P+lyxI3T+6YAyLGKvq2kpe/zVJMZ3Hw+fGeXLzZe/+WOYfn2iqwmF1eXnhCad040qfH
 zEV7nB2gsU9BSirNurd60LSM8NHcHhqhiyVqSgaToTyFjFOJFoOsGsVHi7uu7CCuLq5pZQnHhBG
 /zwnSXchTfPWrYvjj8RnMrkkRx+KZSArgASWZWBydMXPy78/yvil+PfA//t4TT6I/mpUZBXcYK8
 RTaUwwjK3E5zRLHBXaZoXtHMLN9hZ0KUYUXuw+TH6uPuFEFZtTPeUcrLczKvOaRojCZNToi6rja
 kU1vN89obGU7eaV9RiTRGd/OGQEMauMKO8cD5cKX8TwRid9ui+xRHiLutg7Yb4gcQT0TBNH38Vl
 H5m9rKRC
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689dab50 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=B_kxR4TvTiZrqIWArvYA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: kE4F8X0rKaNrsWDXHP1wAfIqGemyOpH3
X-Proofpoint-GUID: kE4F8X0rKaNrsWDXHP1wAfIqGemyOpH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

On 8/14/25 9:22 AM, Dmitry Baryshkov wrote:
> Add UBWC configuration for SDA660 (modem-less variant of SDM660), SDM450
> (similar to MSM8953), SDM632 (similar to MSM8953) and SM7325 (similar to
> SC7280).
> 
> Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


