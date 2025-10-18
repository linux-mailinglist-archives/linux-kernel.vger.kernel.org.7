Return-Path: <linux-kernel+bounces-859100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9FABECC7E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E581896FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78542287510;
	Sat, 18 Oct 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlqmmEAC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488428467D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779584; cv=none; b=YFbb3Pq3mklcRTp8Hc3oNOhdAToU5eN9Yz/Rmvk8CD2wcKfrbAqOvJcozAOWwJ+fmo+AsIl8/gW9h5fbQM6iEPiXwr0UhP1LMAPNlM9Ot3NVuzr10oh20Qq60W4KvwHUMxeuCrv7y6iZ+N3zF3u/DcS6WyhEyahgV90yF/EKjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779584; c=relaxed/simple;
	bh=wMpDMGFQKHxy/NBZclNn31ED1l+VBENotPXsGz0x/mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUqni0uqIbt/tiARImgr1GbJJgwbnNED/odI6E8itKUE9h4/4Km0yHguSiqF2OvbTf2FfjDJOMHCZPa08Xyrgx/TTkvhZXIZj2LEj+qhcZgTcwmMnUsrk6AIZRSFI/HsjzS9fXgq+m7qrsNm71IQhycx1mbJULGtFfrEkX5hsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IlqmmEAC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I80BEu010895
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6xho3cRc1k8Fcl9SOaVvv0V5Pp02f2XuzfHvj1N+8zA=; b=IlqmmEAC+79o/PR4
	t33mL4xh7Qw9kJJcWFCUT+VrkxA12XFKRHeomVcfTRjgPIj3IUsTzD8nm8Br/26M
	gzr3eXL6hW2XCDkg8mL+wtT9V0wyduhVb/Vsl26DGwH4e+bug0GsbL4/O+yYf3Oz
	11rs9bJ3uC5zF7XRzALOnWdntxeeO/ioj3UQyOeccwtayaZhLMUlRyhV4X7WMpjv
	IPSaAJHU0HkG8mrq+QnAENtamqsgLHpI5yYUTxaJ1mMZGJlyvQsnDMU02nBLOm+Z
	ltBM/O9IFekUSDJyNHcP9UPJQ4K05wf+HrxvwVsCCOb0QIfp5HtLfBslRYp8DSQn
	IiLRWg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v4698bfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:26:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33be01bcda8so1548942a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779582; x=1761384382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xho3cRc1k8Fcl9SOaVvv0V5Pp02f2XuzfHvj1N+8zA=;
        b=rZ6725csPhF5OHRXDLKKFrIZApAPbKfx/tSq61oXakrCJzfJlfmf7Ymc/cIuQIetdg
         tAwZAzBHJwW0FV/p1YZV6GxY7tiAVlZ0jB8s6n2UdgiAQlBG7A4TxyANOtgCexq+92Os
         W3RBk4sEFPpMngQnqTEicRI/xqdatWEy0b/xXCIqIIjOuWaFcJvzqwPlxi0gpLFcn40T
         uCnDuNkIoqwnZQ+hbhQsSpbi7OMSjEwOnVKdaCNr/UiaXlMAIduxyAGFa0dTEOXGQFwc
         W4dPily2e550jISsBvJZbKw5c+9jDLzG0Z+EAYfn0UEVH7KZLPy4WJzTqH/S6AnAEELk
         yzYA==
X-Forwarded-Encrypted: i=1; AJvYcCUylKpxheOwx3nv/8c4NU5gSaKnqoVJC5YzVi4anMU6BQu+C0vcXdNoaYVdIN9eTvJafHjGfw81b5+Bd+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSf49umlsuGHbr3q9Q7CXOFuFgppY4snC2yKbEJSlHoJEyN/e9
	qP5DcyXLpayORG7Tay9QQv1X0OU4ws4n7iwS/dj5OSjF4UIAnoEsm0PAHEv2AyIyUr5UxH7IYVS
	MMH8/sOr8SD8i0fnUO5wMzG+b7G9aimdiMu6ACqLPJFrRWuVPmpt9FaVudl9S8HiLrP4=
X-Gm-Gg: ASbGncu48uCkK2cE8LuNe0fRuoWg58W3ixiTImWOia1uMZq4A9Qh4uRjubI9nMsSUFi
	UtADbeNCAI8TZ+rv3fC/nQcF173sNFwjLSm/QhyebYGi26P6iwqxwg2xi9dERtAVdB/TyxAt2wj
	Cdcr/jlEfezTTZnXsZ3AlMXVTYbtKyQrl5qOcGWOZ9BdqEo6VqTs4SnAK3KG81+ao1SaJMGNfTr
	f5td78ojby/biGvJ0hjHdos3Ek0TKeBkPvXN7HEH009782KPsuWH1Ot0cM2Lh/pZthgw0x01Hot
	SYlsNHp3mXC+gKEYcHcyAf0c8yKF3ZuJEBFWqr6/Ogle2IQKYod/OjedZEJGjTrt15trYNZAJgU
	i2ZxHjuxBqxO30mz1GrjaIgjZEBtGiVWBPl0=
X-Received: by 2002:a17:90b:3f10:b0:330:84dc:d11b with SMTP id 98e67ed59e1d1-33bcf8e4e19mr8048569a91.18.1760779581487;
        Sat, 18 Oct 2025 02:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEmESriWFcZzGmtgits2npnFUdruZMy0sc09C2Q2PskZmtfwvW+rj7fVvru8J0S883ilZfAg==
X-Received: by 2002:a17:90b:3f10:b0:330:84dc:d11b with SMTP id 98e67ed59e1d1-33bcf8e4e19mr8048549a91.18.1760779581053;
        Sat, 18 Oct 2025 02:26:21 -0700 (PDT)
Received: from [192.168.29.113] ([49.43.226.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df9351fsm1952642a91.16.2025.10.18.02.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 02:26:20 -0700 (PDT)
Message-ID: <26537629-ec3f-42c5-a1d9-ae0a8566c871@oss.qualcomm.com>
Date: Sat, 18 Oct 2025 14:56:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Ron Economos <re@w6rz.net>
References: <20251017215817.GA1047160@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251017215817.GA1047160@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: myhLU4cx0h-_NLbBQMtuQjK4B7wKKYL4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfXywW8Kk9OTzYH
 LNu+Ec8Kc9h1WGU+fT87M3Q5wA1JAM8IhubSZLcg9R1OQusm8EVmG1h1gDg44e5j61O7hDQve+W
 GlW/FBY362sRtOPZN8M0JR+H8iqtuopkWIa31OYYrPpfuOQC2n6WD7AJZO6fvQXTYSIaJWaYiyu
 9M9Y5xRBaRo2m8mQbB9IVkL2ZTT8bcu+BcpCzVN4oAROW6ys6AKY4Z/EkkIUTnTrMZgNTLfblLe
 Kyo5BseFrP6Aj4GWCSFo9aYJM5HUcd7Elw+/MxnMWZtZsUX1E1YcBK97d0naqp+67WgMDNJF9iV
 D+zur8ZE4ZvPce/ypKGJoMI1eyfruxzY11+zitx05lEgOVEj/LVJjVkvp9Kl/mauYx18dO4vgHr
 S4RJSvovDr4xqaBYrJrcNi8rT+F7Fg==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f35d3e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=r8OtbAjNO6w9l/f+plF4pQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DmEVpG1DHoo6bZaV9IIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: myhLU4cx0h-_NLbBQMtuQjK4B7wKKYL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032



On 10/18/2025 3:28 AM, Bjorn Helgaas wrote:
> On Fri, Oct 17, 2025 at 05:10:52PM +0530, Krishna Chaitanya Chundru wrote:
>> This series addresses issues with ECAM enablement in the DesignWare PCIe
>> host controller when used with vendor drivers that rely on the DBI base
>> for internal accesses.
>>
>> The first patch fixes the ECAM logic by introducing a custom PCI ops
>> implementation that avoids overwriting the DBI base, ensuring compatibility
>> with vendor drivers that expect a stable DBI address.
>>
>> The second patch reverts Qualcomm-specific ECAM preparation logic that
>> is no longer needed due to the updated design.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> Krishna Chaitanya Chundru (2):
>>        PCI: dwc: Fix ECAM enablement when used with vendor drivers
>>        PCI: dwc: qcom: Revert "PCI: qcom: Prepare for the DWC ECAM enablement"
>>
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 28 ++++++++--
>>   drivers/pci/controller/dwc/pcie-qcom.c            | 68 -----------------------
>>   2 files changed, 24 insertions(+), 72 deletions(-)
>> ---
>> base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
>> change-id: 20251015-ecam_fix-641d1d5ed71d
> 
> I hope we can remove the assumption that the root bus is bus 0, but in
Yes we can remove this assumption.
> the meantime I added these to pci/for-linus so we can build and test
> them.
> 
> They're after the pci-v6.18-fixes-2 tag I just asked Linus to pull, so
> they won't be in v6.18-rc2, but should make it for -rc3.
> 
Thanks Bjorn.

- Krishna Chaitanya.
> Bjorn

