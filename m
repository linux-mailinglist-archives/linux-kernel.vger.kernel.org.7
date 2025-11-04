Return-Path: <linux-kernel+bounces-884036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8EC2F2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20F243497AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8C32989B4;
	Tue,  4 Nov 2025 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="amsJfX58";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YYhrYa8k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59454284B2F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762227274; cv=none; b=QpetwbTin2zPhhqZhbLywhAYwOYYtujPRwce5dvHD3pbBZYYgt/U0YNNXmI/ZLGV9Rk5uz8VQjYsRnuj+8/DmBNGKP6VBnEuswbD9O5mdXh90FnVj/pTmRKycYjbuXMA0mZNF+BeBE76EntCzOa7U0W3CI+ZZM0RFGQPtIS1apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762227274; c=relaxed/simple;
	bh=n8Ub7A6S+7POEG43DijZiuTWeDWVwra2iLpEtrebeX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDVlqyBqMu4WN89w54w4fn6OANOpCFDwsM9UBqH9c6pTS5dDCicLjZU59fw7G1iDVwomZ5hJba0q1diD8IZ+rnxOC2cJlCMQSnCT+VH22hU0dI8HCfGcNaV1LkrqVFcBCQfhFIBiQq59En4jKKiGOUOx34uyFLS+iyh/OIuRxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=amsJfX58; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YYhrYa8k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42vIQU3595021
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 03:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JM0VP2lHokmO4GTbs1/cjjHRzdy9AEzcgNNOnuSZRy0=; b=amsJfX58KIX6FUyP
	LqMDwk9l3nmRs0igWE+QrZ/vst6sIpJF8ABZcKL8CI4Fk/cZGTmspxiUIDPP8Ovw
	lwS01swr8VF0w2RCAzXP7zIVNJuT+/je80Es7oETnOurae71GUZj++Zp7bNTqpGW
	6Z2207gId8lNynfDmBgVo9QlZ47Q9KdxVxDf3SIaiqKt1WjSDpDECtSiHUpvC4mr
	ZTLojlYVwK/ub+nFZaBKaUqWu4ibg/aJh0bWVGlzCRNBe7gCj3vx0CRPPOvB2/Ct
	Kv6bvnlBrZsIoh5058SwCCzJPm7AGzQ3kmk/eGENmdiA1HYj90TZUrX/OVlRewsq
	ryMCxA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70exhgxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:34:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-340b12796d5so1230317a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762227271; x=1762832071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JM0VP2lHokmO4GTbs1/cjjHRzdy9AEzcgNNOnuSZRy0=;
        b=YYhrYa8kSA2gJtk3toMaLnU9S+bXSCLQb+m+A9F4pzjuPs1+b0j04DSntHnmBQQYi/
         tjaJL+t09nITn6YQK8JJEgSmPzF2qwNAJRt+q/jdWmdNFn8omC51Vdb7fqPjSReQAMzH
         sUZfcaUNwBBDpSaJEg9xQQbSK56mM0lz50pHVG8Rn0nWRjgBTBW7XlPvNb+xE4GP9ZAx
         CljCOcQM89A0dXnrOJxlgqKFg3SJlUfPtill+CkKTjB4ded1EHOnpJGE8eujuEPeRkTx
         XA2/G6aSbkOeX++FS+2yFHFSEv140D9pe0vzOVw3lmQe1iiTqvOKrBwpZic6lWfef3vk
         jxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762227271; x=1762832071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JM0VP2lHokmO4GTbs1/cjjHRzdy9AEzcgNNOnuSZRy0=;
        b=NHT014QDNlFkv4OVR8Ims7CmQt9deVJLgNkvuKzEvH5e0OkzOIqMnbqDpV0nj7wQBR
         TSw/RfKlI6DMbk/GkPxBj+Ivdp23RGfmaQsG0l7DY0iCX/RVhdSpiDiD4WylhRVGIftP
         Ugkl51lMpzkR9EQ4DPT9T5J6sA5wIjSGAOXZcyO1hfoSbwmvcdmwodLOpssAeIJr8XYf
         ZPX6OeqW1p2GfsnPfXX+oTVIByDNxs1ODa/nfnv75krrA/pIR56Hvw4RC7KNknxYLG79
         Gytx+feTlG7UBGXFpfu3bMmXalQPdHZeokWUXL/+ijhGtFEdY3jAMR0PWFxItjGlEZm5
         6Tjg==
X-Forwarded-Encrypted: i=1; AJvYcCUO/vwmeQ+fhEgpKYm7Eadl0GZBIF/UK10EzhtUjFtfedEYa8wxzut5YtQV7wAXVCdiiOo5U/fkX8Up4Og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7bShoAQTOM/s7sd19/1lU+cTfwheOsRwchXR6p+oMLFJKx0Ru
	GPoK4b2MPeWN0/oIN8oM8XgQ9Qgsmx3MNwMscsCD8vcmX9RwKjIjFRYRyeiIzEr196fowlkDwkt
	+CUHk+z6Uuu2UEIeigbt6ceg31/Oilf4OWa5NIkBWANKkKJiqhgPuvBEs1LTmK2ZYuNY=
X-Gm-Gg: ASbGncsluQlPW58rLJGxRvXKC+472a+4Fkw81NuC/ogVrW5B5A2P4z20dxeDBOtmrjR
	dMFnbVCLO0QzzFooc63B7ZNgGIi1FflhEee+ms2nC9/A521nvezIPyFirSLLrECvBx6l95gox3y
	KrCayzvbgTQyvvCSGDmue9VxHpKp1V/CSYti9TWo29aci3fL0f00BW5wR6cXTBx8Na8dyBMuQfH
	Sq/0aP2M+4jqdBLLmyYpvgEZ8k3p9suz8sb4Um84xrB6yCggKRR7C6peRgHiL3GgE7XXre4ZQHs
	rweyv2l6iTbXl8SShmtWw8re64eJZN3GvRUST+KRBuDJAbkAN+Rh5iuXkvSVIKwNky6L2+qGn3N
	jMK52gbO0md54S+NXa0HGGNdDmMVnIsQvZqF7jJXwFjVPHxR4H2V5IEfOyOIflR3TnQ==
X-Received: by 2002:a17:90b:1c92:b0:341:8491:4734 with SMTP id 98e67ed59e1d1-341849147c4mr12388a91.8.1762227270965;
        Mon, 03 Nov 2025 19:34:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd8JmAcMLL+Rmd6Uz3JK4OYIq6Oe6mWlkpZ82eB97YJYJVgpYMsEMN1V04JblFPOYjHg3YqA==
X-Received: by 2002:a17:90b:1c92:b0:341:8491:4734 with SMTP id 98e67ed59e1d1-341849147c4mr12373a91.8.1762227270366;
        Mon, 03 Nov 2025 19:34:30 -0800 (PST)
Received: from [10.133.33.149] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415991d381sm2726626a91.2.2025.11.03.19.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 19:34:29 -0800 (PST)
Message-ID: <b623c7f6-f28f-49ba-b6f6-25084117a6b3@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 11:34:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: qcom,tcsr: Add compatible for Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-mfd-v1-1-6c8a98760e95@oss.qualcomm.com>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <20250924-knp-mfd-v1-1-6c8a98760e95@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=APHuRV3Y c=1 sm=1 tr=0 ts=69097447 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WMZZJdeCZ7IOBlX-dNsA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: fOy2LH9nDC7M4NRPMnMa6EEukpXDg9ES
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAyNyBTYWx0ZWRfXzX6E/e1yhSFg
 /IiBkfe/p1TYlpIfrqzTW2nfEx+QAQ+3/SbgKRdtw60VXJAVqFVw+9jwEAU2SeeO9dVMqsrmYSk
 GwyHXGRF82TsELWAYY1HXwUT9EJPZJ7skHR3TIYxJw0hmMPsbcNlRbPL+wXGdIJmBpFAyaDCaT4
 83CI9UiyQgRZqZYoQxnv0Op5jGoVwG3zijDpeYIpM27jLciA5pqu3Mp6w8iNImDzq+YSHTXmMNX
 iGqybfKJsu0Z+nPelxDKlXwb/1De+oHd77XomCv0YWz4QDxQKxyRIb93t408hZKoxXJz2dVAc9D
 jC2LvyeQq2e66w83VnzAMevfZD7TxG/XvWFhD2X2ZGMd59EgRLnZ7+zBdLart6Aa4jRVS+oNcw8
 U2KG+sX04hO6XVvj0OzFwwAmP7g/dw==
X-Proofpoint-ORIG-GUID: fOy2LH9nDC7M4NRPMnMa6EEukpXDg9ES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040027

On 9/25/2025 7:23 AM, Jingyi Wang wrote:
> Document the qcom,tcsr-kaanapali compatible, tcsr will provide various
> control and status functions for their peripherals.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> index 14ae3f00ef7e..ae55b0a70766 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> @@ -48,6 +48,7 @@ properties:
>            - qcom,tcsr-ipq8064
>            - qcom,tcsr-ipq8074
>            - qcom,tcsr-ipq9574
> +          - qcom,tcsr-kaanapali

It looks good to me. Glymur didn't have this functionality verified yet.
Remind for review.

>            - qcom,tcsr-mdm9615
>            - qcom,tcsr-msm8226
>            - qcom,tcsr-msm8660
> 
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250917-knp-mfd-4dd3c81e6b9b
> 
> Best regards,


-- 
Thx and BRs,
Aiqun(Maria) Yu

