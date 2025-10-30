Return-Path: <linux-kernel+bounces-877564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D9C1E708
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAF71896D59
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2AA134AB;
	Thu, 30 Oct 2025 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4GMrorz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ipG2aAH3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF928EA72
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802650; cv=none; b=A0q7RAW17RsNBXn4FRPyfT+NLb5Exddg9HtyJU/Ecsis5MZ9FOI6HiOgQFKTRgbU2mC+8GMmAp7eqXO7vlkLmI8hM/106LfnbtUh+Uua7RJE9yw3b6HJ2D6Aygys0fnzfcijfJFtF4hrPoV9TFZW/azyBc3puZOHOxPuwf1JSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802650; c=relaxed/simple;
	bh=eCGAlRA0QSOsRVcn1TquQsOHuKQDaQ+psONOlxvOkk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlwNPgdqKguhF15x7Su+Gr3GRNSVZVVGB6xduJsXSRELFrwUexhIFYiFKaOW8rrLw75FViOq1WMJxpijnGLS1FQzkzubO/JECGsIFYKiYavAu8ZDxt7qkRvTNsZNG6HPgkVvgFqgMJWUKmfFrQ+HDAjiMMPLD6kbb3dQHv1Zk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4GMrorz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ipG2aAH3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TLH5831656152
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7M5/feYIXAcY/xiSvoX7AATD4bRj++JaUOMJzVqLb/U=; b=b4GMrorz0W4TMU75
	3T9CRxT9sb3JenThV91wxDEZCZTNp6TCFVK5xU7KPfvomzcJtxJeQ2h3PPll0ORt
	syi4uWn8kab/OI00aD1vnhRqjR52fN1zZwXiaYlkzdaYJAR6vebpJGpWh9xIok5G
	Q1SujHUUiGHwsb5UvedzVT9DQT+jvYfYdh66SN1wTDp1ker+MUOqoFbs6womOH7b
	/Ji7rvy7HaWaIb51jCZ5uZDLz0mKr/tX0sJrlwxDmWa/aONxR6qmKGGHMG25V+tf
	SehFzwkPAgCVIZRdQNdITf7ApxpZyxhrP+aM2AUbn6kH2ImQdPRXJiHHoE96JPXu
	dzLKNw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tpts5fv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:37:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62b7af4fddso393996a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761802648; x=1762407448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7M5/feYIXAcY/xiSvoX7AATD4bRj++JaUOMJzVqLb/U=;
        b=ipG2aAH3GXjzDARjceZdspQUmwo957P2bngsKFE0YWI1riR/9dt33qNSRTmxmedNet
         /rFfeJ7J2FHrEsP3SGlwwtSH7QLAXSYF2eg+LtYhgyj7plf7nkX7khCsd7HJf1k+/Dj4
         SYPrTlcJ4wFDTtLAC0tkZA3VmVFaRIhLQkFO33odC3FJejQtiP3HbnBmUW91/jg1DPKS
         40rR0US/KywFcMj14MDsSVdZAxV7yWyL5UqiAUY2RHmlHFfCYZOn+StlK6zG2ED5LI0C
         RpGp43vnVagpv/EjODec4hucx2TBCXSuS7JieGPR2dPiavjODSqRA1vSwRd0NoY/AHn4
         3zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761802648; x=1762407448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7M5/feYIXAcY/xiSvoX7AATD4bRj++JaUOMJzVqLb/U=;
        b=q8xQfvRnNZQ/HwJuAgZfR1vzBbvnqrND83HT6yu2e4HU/pNPYSy5kQsgSrCiqYISCr
         oR7z9gmg3xMF981hZnMuIcBLdsQ9I0ZpEaKiUkO4YhgFM7cx16N8c0wTXu3DL2TOhsAI
         ieuYPiyXVW8j6Rv//S0q3O0INoeYxRghHsEJn6ZRHAy3ovujgYyKzYLaBKLwN/Zd5vEY
         4lkqZyrr6VBa4dAIEPii6xHTktZNZlFJNk4X5vYzrDPeUbaTWXhLzgTm/Terv2r6DBdz
         rcb6aTfeKW1z7eIzqGd3QJtTKi2e4s2xxEP7JT2KjoixgORUlJOjzr7zCn7rlk3L0eU/
         NvoA==
X-Forwarded-Encrypted: i=1; AJvYcCVkjL4bq8A2UZLooqn846oWZ52IyQzfiDcxV3VGcIlRh5trpQQuVzvIkL4O4MZFgYa/ruPMZTGYc+XmuWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWQgT40J5DINap3iDgbnLabi1vCcq1Mlbvt2STnZEoJQFxcJWv
	tIwpO1Qh1cDDMpkiHL5qD04rgA4AEeJ1uh9Dz5Sn9rrKZUpgu2joSRNrj25vnneUobcpiBEWuA4
	lO6FJhsOfCmZfcXpOd1gKUHE1+jWhxQgPDOkSYapI4zfkhYmQgbI4+HmTUV6AarukSpE=
X-Gm-Gg: ASbGncuABTRh9CW3tpzugMeKEXNhQjnZEY+ggKlLhjwmbqPY7hy4GYrNuDeIznt9Gga
	DOOJ4dJ3s1y2ITEcMMaL4KDmafjpuun+3B8JKn8GWhoLpMhu6nJhTePHaWBxmWbIWrytpGsHWIg
	9VvIpW3jq+YqsxD9e/YnIkcUniAYbfsr4ZTVFKcVWjKczP7l0B7cBXXrf8k2bcFcOEuZxVJKQaH
	JCD4uMyA3WEjh4yH2a8Iq/la+RLP6rizyN88NdEPQ9oJ8qBqLx1nBdJonnAOrfOFmDBstDemk6l
	D25aMFJFaoEAmR+0YCnJkypF3XO99U3EquMjMcWDWAtCKw18/xWVpp85HkxpXDmSNrVfir4Ao/y
	JUU/9zUMeHJC67LrsgG6WvoMSsV3+0VI=
X-Received: by 2002:a17:903:22cf:b0:278:704:d6d0 with SMTP id d9443c01a7336-294edbf56admr21509585ad.19.1761802647637;
        Wed, 29 Oct 2025 22:37:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOi3AtcF65oro4e3+BO0KlY5luy6t+0LWSKM1u0T44ogvuEu8VYVcI28WV6vxqGpo9V+1xOg==
X-Received: by 2002:a17:903:22cf:b0:278:704:d6d0 with SMTP id d9443c01a7336-294edbf56admr21509355ad.19.1761802647083;
        Wed, 29 Oct 2025 22:37:27 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d39048sm171628295ad.66.2025.10.29.22.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 22:37:26 -0700 (PDT)
Message-ID: <dc230a62-bd31-450a-9acd-fa654f694b3a@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:07:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] PCI: dwc: support missing PCIe device on resume
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
 <20251029-rockchip-pcie-system-suspend-v4-9-ce2e1b0692d2@collabora.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-9-ce2e1b0692d2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA0NCBTYWx0ZWRfXwGYRyS9jWC/J
 PfzInGskQftLjao/dmMIODOjZwDKLa9LfKOOmjkfWEcBENNyL+cA6v/EU/DCbZdNNB9AT3JuEzV
 pT5hzGumPYUSK9gjubDuC9Pt+zh5gK5wKhd7R8FlwkTyt9y13NujyKU2GyHmGcbBGfSjOJXTASe
 xv2FI57dUzgTy1e97NWZyVevfz01XJZisQ0dZ0XaAEw/KO7GZVthNX209tAx+izVXpMPG8+5WYm
 bvz/JAulde0OQ/tMotMSYCacDHN2vkpmrEaGAY8VIOsvl8tJuTooEYZKiuIPurh+2pY0322LIGU
 FY/lG3PejR0EUHiHXHWNS70A1z0rcVE7bjFQmrzqGbg2keTS9sY5bMwZRkTfD0yM7EC51c7KRxJ
 JHq6WvhIEm0Gw5BNXRjpXil+CPwepQ==
X-Proofpoint-GUID: Xr-6kKxApWV4epKMPHC9812nsp6Saa5c
X-Authority-Analysis: v=2.4 cv=MuRfKmae c=1 sm=1 tr=0 ts=6902f998 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QX4gbG5DAAAA:8 a=G1FknBJvTCrQj4ipN-0A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: Xr-6kKxApWV4epKMPHC9812nsp6Saa5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300044


On 10/29/2025 11:26 PM, Sebastian Reichel wrote:
> When dw_pcie_resume_noirq() is called for a PCIe root complex for a PCIe
> slot with no device plugged on Rockchip RK3576, dw_pcie_wait_for_link()
> will return -ETIMEDOUT. During probe time this does not happen, since
> the platform sets 'use_linkup_irq'.
>
> This adds the same logic from dw_pcie_host_init() to the PM resume
> function to avoid the problem.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda5..f25f1c136900 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1215,9 +1215,16 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>   	if (ret)
>   		return ret;
>   
> -	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Note: Skip the link up delay only when a Link Up IRQ is present.
> +	 * If there is no Link Up IRQ, we should not bypass the delay
> +	 * because that would require users to manually rescan for devices.
> +	 */

In the resume scenario, we should explicitly wait for the link to be up, 
there is no IRQ support at this resume phase
and secondly after controller resume pm framework will start resuming 
the bridges & endpoints. what happens
if the link is not up by the time endpoint is resume is called. And 
entire save & restore states might also gets messed up.
There will be no way to recover from this.

- Krishna Chaitanya.

> +	if (!pci->pp.use_linkup_irq) {
> +		ret = dw_pcie_wait_for_link(pci);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return ret;
>   }
>

