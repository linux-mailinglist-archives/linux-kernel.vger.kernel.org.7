Return-Path: <linux-kernel+bounces-725665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAE4B00241
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1851717C6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02509256C61;
	Thu, 10 Jul 2025 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C2BHkvSI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED246256C8A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151393; cv=none; b=gSxZig17bHIugRTULpDXQNKf/nrK+wGofU/eIv7e1zd+QRpwTI4cOj8RJiVmfIbkUVFwrSgG5EGrQHl8JQIbSzgDxL2X2kz3W3cofw840DA1NMzrzukzmqarSwVE01GO3nfCVlYNfYSKG8vpOefw6CQP+7iZ44TBQW1LYQSEu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151393; c=relaxed/simple;
	bh=qBFhK1afkV4m7aBBOosJ2f1pVgbfITnIKsst8TKTNfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqMKtWnS1PkfX2qxv4dFN7/MAlAEfDfiuOTj5CDE0HAbNVKOQHzEPXA2yY9Kxdh93GCh9O/bjgq7N2djhqS2UDuw2jEOPNVm2oD/AzrHny8CMKqiGJLa6WSbqW6ayGnBpfEMdoEm4KerEipers6XOu7XD/OaZv9+z//ZU8ceyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C2BHkvSI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9BRgS014483
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PYTkxuuxHpA2VyCMgJOS//3tQMwdPfUJSgKrXX2iCCg=; b=C2BHkvSIoZJSOXZq
	CXdYM6tfFv8SDXPQqgpBnuN2gA8gAmbQ7qwNkYdtyb2/G+ns9vkVaXghhAcbgSXt
	5rFQwYga9olvEOu5CTiqi5mRxF/YLbFkfZIToEVnqntoZvNdgWEJoLTB08ACEEiq
	jiNuRu+5vais+df93bme35RJOKuqNDkc6bTcpsPubhbdG+FClqaApEfVVpujq7EZ
	sZ/lBLSbVqj+ZufwPlIdVtdjiF0+cWIwvDCyGuqHfouP4goH5ua4J4lwvd9DakMx
	gBVfzNJwJQ4hhDPjwwvoEeuMGJzDpYoNWLfVUw/6XgGI2V61qEsV45cJX8CtaQxk
	so3g5Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b15vvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:43:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a9a8841a85so2299861cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151389; x=1752756189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYTkxuuxHpA2VyCMgJOS//3tQMwdPfUJSgKrXX2iCCg=;
        b=HfuPxNWFPX772MGZNqJRJutHaU1XKuDDfk2VtavLq1VHP92Ljh/xY4NZkrLsmyZv55
         wbAFJcv/Xo7I1EDTrzrHFx05gMc5DmMrCSzYeZ55MaQmgHMTzvhLNs9Zw7KcRwFp6x+2
         U1YoESvC0y/Wpz5d0sgrh3778ycgkvo+JpN1y/LTgAlodzfFTQFAysXtUMvnkg4rFJRX
         SPOP+EVXdhs/I+JXH9LS53GUZ390Me+NWHCGFE8JgTfe3Qy8dIg5Y0sRZ41zX1i9bKOU
         RHzSrUlQ9Ts4X7le0EizAEekmjeMtM9XOiBUkIiei7t5cP/vMdJYkBmJCGImytN1vAIc
         76cw==
X-Forwarded-Encrypted: i=1; AJvYcCXX+z0/D/UyD0tOvd2MY8nwtbJ97G1Na8NBX0GgJ4v/4g4jEdVrs1hJYwh11bxMqXe04Ew93vep7m2BsPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzED5oxfI4m4ApHwXLdsCFefJSrta2ytGNmaHoQehg6zhVcZyri
	O3Htlirfds8MXd3EokmS6K1NplcXPwCCsHDbF48qU5993ZsP50OTUcyinud0EBmF9c82R7czKVe
	d0JIhEa6I0I569KXPspZbejeW7LOfONWzIoCJpGwMfoJie9zDbH/1aDl+FcoIv9AZWWqkh0f5e/
	8=
X-Gm-Gg: ASbGncvllRrMDWDS/cZcXu5N+koC0b6pNER7iZAmbMSsLz6mC6cMVEHCkS2kYVkrGpu
	0FfoMnXgTwWWmWiOnNHClYWLJss6gaz/h6GrPNktvG/0T62LTTw8eK2yk5phzZGZjmxTVKq9klc
	2SZIR/AdQiIqarMafWtC68WW/ERB8/mH0KoTANbU49oj5qqwYxAJmPflG6KygFusWXZzlKimNhi
	dGT0Poh/HEnqAIjjOPUfrT2gI08LIt8ypQy1ZPgiESI513d3WrXv0ymJli1/wQdnlkA/W9xdN97
	9uXUR9rTiTpc1GEk+YyuSBoJLwWug2PvNdYdkS5bzOqhCLmiy8diVRiahc7XcTTavzQFykhZFci
	owqw=
X-Received: by 2002:ac8:58c4:0:b0:4a7:7f80:7a8c with SMTP id d75a77b69052e-4a9dec22598mr36676091cf.1.1752151389316;
        Thu, 10 Jul 2025 05:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRbTSEuEeV2umL8ashTgvApRLmR4nY0TUzJVh0ThLvKrhyZgdrRc12SQWS6A1FRWNQ/HFWnw==
X-Received: by 2002:ac8:58c4:0:b0:4a7:7f80:7a8c with SMTP id d75a77b69052e-4a9dec22598mr36675821cf.1.1752151388712;
        Thu, 10 Jul 2025 05:43:08 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294b5fsm124039166b.125.2025.07.10.05.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:43:08 -0700 (PDT)
Message-ID: <684a8db6-ec47-44da-baca-1b16a33002a5@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:43:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] bus: mhi: host: pci_generic: Add SRIOV support for
 PCIe device
To: Vivek.Pernamitta@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20250710-sriov_vdev_next-20250630-v2-0-4bd862b822e8@quicinc.com>
 <20250710-sriov_vdev_next-20250630-v2-4-4bd862b822e8@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-sriov_vdev_next-20250630-v2-4-4bd862b822e8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686fb55f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=H9ftyYl3DrAdAmmota0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwOCBTYWx0ZWRfX5/0Lplx0WDdt
 89iiSQra32aoq5JzZM8xGiOjZU9PA/jOc2mXq/YRQnaOkbmEBrjeBxO0QEfR9Aj3+fcnsEfV73i
 5bCZnpl1a5I6UsUzc4VuK105akeYMXsCZHGoVgXo2WpZsY4TJIXGZpt/Ob29PWGKfAMMo4TxBR7
 bbLFCBtdXy+f9rxZLl4wWA/7wPhbHd+kSEh33SsvTAt0FDFr2hnGO6xIVAF0sjFLn7JTaMQr/3U
 Gia5XfkyARinAbtQCjmT5W9Lckt5NkmonZIlksXldWx9Xa16aI46JrtftR2p5z2tQrWDrQn9qit
 MKPJZwXsYgpk2Hx/nzlFbfmS+QkHSA7Npq/JQOGn8w55A5kcxqHgi7Jv1pB5jizgWKTI9TNOrS7
 EC/7Foqkbq2XaQRcbPIss1F83wwQD+DnQG2c13fL1xIDp/6KxHsu5XLW4AyCgSPZXRaOZWQX
X-Proofpoint-GUID: 4zuUESBqWq1MMibAnyp_SvbbBBp6Hg5f
X-Proofpoint-ORIG-GUID: 4zuUESBqWq1MMibAnyp_SvbbBBp6Hg5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100108

On 7/10/25 10:58 AM, Vivek.Pernamitta@quicinc.com wrote:
> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
> 
> Add SR-IOV support for PCIe devices.
> pci_sriov_configure_simple() will enable or disable SR-IOV for devices
> that don't require any specific PF setup before enabling SR-IOV.
> 
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 2d1381006293412fbc593316e5c7f0f59ac74da8..a64b5c365c920ef2edfebc994e82d6385ad7ddbd 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1640,7 +1640,8 @@ static struct pci_driver mhi_pci_driver = {
>  	.remove		= mhi_pci_remove,
>  	.shutdown	= mhi_pci_shutdown,
>  	.err_handler	= &mhi_pci_err_handler,
> -	.driver.pm	= &mhi_pci_pm_ops
> +	.driver.pm	= &mhi_pci_pm_ops,
> +	.sriov_configure = pci_sriov_configure_simple

If you add a comma at the end of the newly-added line,
future diffs will be shorter

Konrad

