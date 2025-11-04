Return-Path: <linux-kernel+bounces-885142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0AEC3218B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31177189FB9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD97E32E73B;
	Tue,  4 Nov 2025 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+MZG+D9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJ/ro4sE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832A23EAA4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274328; cv=none; b=h6rZvq3R+YN2RlGvaP4iwdvzH15AlrA2F58SD+eo6+3JjeLiZVaU9qrJJ716BoE7AAxQvyr27HmbDMCsoGyg5ZchDslf6LVcUIx8tppvgiuEOwvW5BcCkz2DzOEjnIsNhB+N64bbr6xM6SUSWdK9Le3NBwaVD2ELHG8UxB0f+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274328; c=relaxed/simple;
	bh=WP9gc6aoabGI8uiHDARaHICukxcNlD501b4UKexOpVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPaKSEDojnhGTqWhEfrzwtLLyu7g82kBUIi7zV+giJhisWgCUIWY7LP8qYfFW3gmaEyJC4jbZ9iopZpQS1HuOA5XNWh1LdDMWoCGLr71yjv7YMGMRUPoLWDpb5bC0OFLp4qV9sCykoFb+EpbTjy0KQ/wrKKuDm6NDtKlTGQg0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+MZG+D9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SJ/ro4sE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CgEdZ2026341
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 16:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WP9gc6aoabGI8uiHDARaHICukxcNlD501b4UKexOpVc=; b=i+MZG+D9QijvQiYs
	E5oTiPE4X7OJCHpTaXS8W6BbOL9JuFfBzOSGrV2EXRABaM22NisFXwPEN5KJI0xF
	EI12SU2ybN7gCw/QqXjRaZ8PoTKD1Uc2nNt50nbhn6nwPwWxIaGUfRTKzHIXjO4b
	/vRJr5oTbNd15FiAOl7e+DdUe9HaMNoeOl5J9ec9XOf2iAH27ny9OcYtLayrqno5
	OAt/XXaWJHJDfqAcOW0UWlLG882Io6b2C3UGWVrtlUBsCOLmQ9RnJpO6y7yD2tWo
	x4UuvD+Jsrrc8zP/0tLA8fcUKVwUEZJjAQIITOqsZnLz3Udrmy0ikMr/T5Z1T3UZ
	QVuu8Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7b6psvhf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:38:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2953deecdaeso90365785ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762274325; x=1762879125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WP9gc6aoabGI8uiHDARaHICukxcNlD501b4UKexOpVc=;
        b=SJ/ro4sEwYIQXCEJTaNHZy7nrFSWgXneNxXPfnzkN5KzhwQgclVLVOLJ0uZ1RnbP1T
         qDs6bJxcj2BN5zApJ1+AZY51nvvcP7nJhBIz/BMumdkHKxZPQD6SL/XIIvNEAkYkERPa
         jMEh32eT4mjd+Es9TTcZ16CeUKIc//QbluxyU0ZFbsH5gdmH8y99qknRTlxdsOyZTDOP
         zzWcagl9y/bkdwZ9nOBvVWF5efX4ex9rFkPL8yLMJj4zNX2M/i297qULkSRYq2X6szFx
         ADoZmwCKkjtze+RNZsvQjaHJIwL1dyvff2lkZ4Xq8VgZiaBjMEdiMQsjyMiCNCWmvXU4
         WazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274325; x=1762879125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP9gc6aoabGI8uiHDARaHICukxcNlD501b4UKexOpVc=;
        b=l6MFu0DALovgdbmEkBYilOpqDlduNQsp2C52zKTVBTqcMcStTy7vLcAXCSy1xiR23+
         2A+dFfXNe+YJI008ebeFojJ9SmztEAk884eXqv8z8VoeE6Vem3ZauCVHaYf89hy1nxtw
         PyK8RTD0Hxe9n6ru7pJWK4nqQ44TBlb6Ir+Z89V8ncP23fMBZ50FnWUeFxx5aEbjsjF+
         zox4rWdIY/E1GzGS519yEXUeOkCptky/HnGkTi5bSibtEEb7FyZEbTVsXe3HH+Jr9cba
         SYR3lbKeZM2JmDNmfLZvM/7hqgqtW2ZKlXPr2FbVUxMMXZt/bHxoj/69GtXHohbsJ3QM
         poKg==
X-Forwarded-Encrypted: i=1; AJvYcCVcftF1Ozc2OW9F0qTUctnQ9HreQL2bxziyE4M6diqN/cJjLKbL3v1z0jM1IqDs0RdJOty0pjntC5lmsyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eBACBSSuORL42Su4MDPNJu0AzBZKJ0NmeSLtKIi/ADQgLE9A
	+F74j7mUakjeAQSYNhfyJbAqon8sIqQqwn2BbmkgVer2K3iIQBXBOaIAKF9As88CPddug27qThu
	HLy4Sdy3k38OhXlBGXxhQ7+8UPPiuBZ7i126XCOY5LvDmYe1cpgvUlK5xBTurGd//ueY=
X-Gm-Gg: ASbGncsqn80vX/+KF2yL83fxZH7MYJaWGF13Bl3BkrY6EJZoFkFmWW9p19qQPynmyBY
	M9jp44naw+/oP5hwHFaU2Lz8NtV5PU5TY4K0nBmNcEa9vXLD/67o2k9GmIDNhpBg3Hry/quaMd4
	p72l/I8Ks3cOqrchXPpTS5tJZpr942f57jMFXVN16uKIdf7duhHk09XyPSWN69DRE3S8vqOH5Pe
	XfXErPmvbuhFytby2Mk2pf49btGzgWF1/YEn7HchZ/i8PqQfJA6Y1HIiDw9TCyCGcSjeu63pPmo
	M+uNcviptgfv/BeMX0vLOgwpsD1ItvK+aezDrlTmBAeWgVSXbt0nQKJ4jp9Z8rX3tWpSejlOzph
	TCCk2oGM/cXIbXKp0cp53z7pM+jAN8etasQ==
X-Received: by 2002:a17:903:46c6:b0:295:39d9:8971 with SMTP id d9443c01a7336-2962ad0c936mr3416805ad.1.1762274324899;
        Tue, 04 Nov 2025 08:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz6uJF0hcsIaWD0Bqp9R29GTarddruadQBQ56H22/WdcYPRdszrtsBx7nayDpricbv68SMYA==
X-Received: by 2002:a17:903:46c6:b0:295:39d9:8971 with SMTP id d9443c01a7336-2962ad0c936mr3416255ad.1.1762274324314;
        Tue, 04 Nov 2025 08:38:44 -0800 (PST)
Received: from [192.168.29.63] ([49.43.227.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a9fsm31883835ad.20.2025.11.04.08.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:38:44 -0800 (PST)
Message-ID: <2d4a192f-45b2-4aee-bcc9-dbe0dce0aa93@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 22:08:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com>
 <29b32098-39ca-440d-9b51-915157b752b5@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <29b32098-39ca-440d-9b51-915157b752b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEzOSBTYWx0ZWRfX1Nv+TMNWqwDn
 +JuPnvdAkjVZlqAlKzBrNzVSTEyRwX2SwyFTl1+KjkLTb6xh3tNo97+UOPDnxPDbDOobJ2+Ni4c
 c2KvlV033DNJS8wmt7BhOpEyuzd9JOyQAHBzEtOOHvSla7Bu1am3gZWp/VrGA8LAV4QjUPCmitt
 SZKBJ2xSYCEJYSX2sWnRS10kSNUtMddJvEp+WcGv1Ti2yoIrsl4ZF2i828obHrHU4B5RCyONejQ
 AQKWXpnGgicevFUZ5lOKiLkwKWgw9RrNlPbSDm6d/uJAQtXYIzyhw3q+fhgrgKi3zOvMSEYD0YP
 xk6a1SpGTbrTBGM770PY/dOSr29lKjCGc+Up1XcgpI379YUQ1hWQBbJMPyWqB866goxYZ0LVhHs
 Exqtp7Pf5tCuFZTHGqM+LQHbBZWBbg==
X-Proofpoint-GUID: bkbJwm8rTY8zqjJ_tX5yxYBcxncULgam
X-Proofpoint-ORIG-GUID: bkbJwm8rTY8zqjJ_tX5yxYBcxncULgam
X-Authority-Analysis: v=2.4 cv=Y4L1cxeN c=1 sm=1 tr=0 ts=690a2c15 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ISmZZG41GQzdpg15mxjwIw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WGPAbWhItJlpQzQmOdIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040139


On 11/4/2025 5:59 PM, Konrad Dybcio wrote:
> On 11/4/25 1:12 PM, Krishna Chaitanya Chundru wrote:
>> The T_POWER_ON indicates the time (in μs) that a Port requires the port
>> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
>> asserted before actively driving the interface. This value is used by
>> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
>>
>> Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
>> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
>> This can result in improper L1.2 exit behavior and can trigger AER's.
>>
>> To address this, program the T_POWER_ON value to 80us (scale = 1,
>> value = 8) in the PCI_L1SS_CAP register during host initialization. This
>> ensures that ASPM can take the root port's T_POWER_ON value into account
>> while calculating the LTR_L1.2_THRESHOLD value.
> Is 80us a meaningful value, or "just happens to work"?

This value is given by hardware team.

- Krishna Chaitanya.

>
> Konrad
>

