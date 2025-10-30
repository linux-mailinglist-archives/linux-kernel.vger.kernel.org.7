Return-Path: <linux-kernel+bounces-877320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61FC1DD98
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA3B3B50AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD16B134AB;
	Thu, 30 Oct 2025 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZzOjsly";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EINaNLbc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E88F6F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782668; cv=none; b=bQvUiyjiCTii8nT7PhEk/d3IJ1ODDMTNijdQCwHXcemQ9CsnjqzExYWZXxQnn3sy1as+WS0rvAmPs+RgtKMPHFaBTgZ1yE7Kq0Ks1EW6QWEvYH9jlNcZIEEGxigYOFygwMYhh+InjTLE567LbSKo1Pg6/PPcBonhVQlJ6uC8ecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782668; c=relaxed/simple;
	bh=e8La3PhKLAY0yqATjn4W+M/31632+mqbSgzSPOUT1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMNdkEvnewbgbfynKuhxcZHoFSmncpBLsyRYq5Rb0HzKRL9KItxWnCzGj0y8aGZDCzY5ijN3TqmItPb256IW+lZ/uvNRDh4Vmb7icYLAryNgitrOeftjgQrJ0B5j7vBfSK+8qoaU2+W40jI05jS/gU7gJQ8BmUIp3BJWHSqOUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZzOjsly; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EINaNLbc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TKWDvg1504048
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LmQr/nvqXK+zOFXNOeHfnc6G
	NLUHSfAv8AGMrlOSOR4=; b=AZzOjslyn+AP6WLjvmjMX420G6Qvsy/DISlzjLw0
	KWQZA6TKF17Aacb5Yu0QWeHZNnFlDO8+ALvD935093QNgc5fHMGJIQa9rIL42NHA
	Z29JVa2n1aMfQ4W13LLfkdbMt/y1dvpw6dwF1YBoZ/rWD/p1GmOCQwp1HfQ5Y742
	Kbq8EDDEu3XZdPe6vCMQnMU+MEGf+/LRKcx69w9xQr1gpOsKFSoE0JWwS3dgc7ny
	XoiSMn7IWGZ1WKYmmn/RwNEmKx1veRy2eQj8Z0Hpojunh8GOOK3sZ68VXFt260Yr
	EC1bQWqL2WDAVvEfplslbFtQO/q/q7rldwf8ND5+ww72HA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3t1jrjg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:04:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf4540bb6so8885041cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761782664; x=1762387464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmQr/nvqXK+zOFXNOeHfnc6GNLUHSfAv8AGMrlOSOR4=;
        b=EINaNLbcqOUBfky6XcwD4C4eecPBr93cgiqtbiaJkSw2xbUjZQl2W3BukyjjhzsTt7
         gsM4GCVepkRJdRkQ8ZQv1QQHU9vsrzDeTr8i34QnrKiF5A4J/5/bm/CFXViEL0v+4bIr
         L/Q4+Hr1xQNdQUR5K2dXkQFxEJS0WqIRzpc4gz1ixYz1jFO8emGfrWZdFq6aMK2ovG5f
         NnARPlWFTs6lZ3t8wWnpU9Ng8wdSt3RP4iIqyx9E/kn0dLS9v4zffMtQsML4BHOQiv34
         2hhWNlNG9hyYRtabPjv55k3IJ6Kg3ShEAtlEJl1UqnbbV9uqyvLB2ECgLa5KCQTQynqx
         lErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782664; x=1762387464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmQr/nvqXK+zOFXNOeHfnc6GNLUHSfAv8AGMrlOSOR4=;
        b=m23lMw0NWgW3j5rR0R6uBhuyDefDIRx8CDtDlSiqkqq1qCefM9NDgTKhCG97yLVsyA
         vLyCgcw56wiv33kiI39qUN+CXSZZr7c5WmHXjc9P+J8laFXfSYuyeIuXzK5+d30zp8x4
         PIT7hEBWmzGYr8Ea6n3/6EbBvJjIZHQZkHt/zGCXbImtLNItDt7/VSZjJzrepqxRpn51
         MK6CiRORfL2I0mi3Tl7cgukXwiOhYBefW6vgHsNzbuIC4/G1M/3FvMoQHyytfFXCFs4C
         67lJQel4se6k4rrb2LOnKu3p75ctQa16UMbIAlRZdkgM5vTHeypFGj5+yYOKE4Umubrs
         tD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKl9J3vq5mMpIj3js348nSgtADj71kTj4p4gRk036Qj+vet1TBa3oTfwMeoo+aOO0yyoj6MGXDCPaEuxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnH/MckEQjoOB1F8Qqi8V+BJL43G/pC0mFyhlfS6dvvRb6ddg
	OULnmR0SArmCEbnniPPKyVDwC6WxUMrs8DIUnBmSr1JeUEFp9JnHgGFqfPq3eK9TRfdJGzN2v1n
	l3c3JcxbRKKV86CkTZDvZ00iq2PdMumt/DifuG4Poa6yG7L2K6DkuYvSLnvKTgxeNH6A=
X-Gm-Gg: ASbGnctASqpRDkDmNwwnjb0kRMfNwxwRx37zySzIKVumBYjR57YHd+oq8oI1uTjRhIC
	g7Dtfo+Zq/V4zsKbeg04YePYEuilWn/Zw34YNQ1adnw82K9Er7axd+0RyT+3pfCHASOLAWjVZ6w
	gpROmhbdHn5TPCDZmW3GBIopx/uJRGboV4DfKpIZvRAGvifvU8b5hzsBoxR7k39Evwm7ldspa5V
	DynaF2ns/YEhDL7F2V9zj4gVt3McXNVHHUS2wO88TClAYlQXTk2mZbzlr1qzBLC46G/A2wop2yU
	CSNnDRLJm3Re0Uuf8iLZYVyRZ42uMEzTrM97ky/bXhOVQVKvBMHBH+V0DFpmpWaOoqrMpJJz35d
	wo3GfzRwD2vbYn5SKvKp0aMW2+YMzh2tuODIOJi9T2rtDijK4FZ3I3WJD8aRisSTvsIszCArPES
	QkFfYaehMzeqYf
X-Received: by 2002:ac8:59d4:0:b0:4e8:9704:7c83 with SMTP id d75a77b69052e-4ed15b53e60mr59019531cf.14.1761782664172;
        Wed, 29 Oct 2025 17:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHls9al2XoteQcyohoS5y0Zyle0J/v2kM9a5LZVzgtA4jNe9zTqJ/FMEHsgEyEmUumiISYvUQ==
X-Received: by 2002:ac8:59d4:0:b0:4e8:9704:7c83 with SMTP id d75a77b69052e-4ed15b53e60mr59018991cf.14.1761782663698;
        Wed, 29 Oct 2025 17:04:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f7444bsm4248514e87.85.2025.10.29.17.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:04:21 -0700 (PDT)
Date: Thu, 30 Oct 2025 02:04:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v7 7/8] arm64: defconfig: Enable TC9563 PWRCTL driver
Message-ID: <jjbiamlcof6gttme3crotwyzsxtrguohaib73gcsaabpan5fqe@s5uroqqargti>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
 <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
X-Proofpoint-GUID: qXxtgDOx7sxJ2-C4bPmC6VKnLdXaRR4d
X-Proofpoint-ORIG-GUID: qXxtgDOx7sxJ2-C4bPmC6VKnLdXaRR4d
X-Authority-Analysis: v=2.4 cv=M/lA6iws c=1 sm=1 tr=0 ts=6902ab89 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EhQ9wbuxbXqUBhoRm5MA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE5NCBTYWx0ZWRfX6AJhNGGZ6/IZ
 Q+QsBL1UMLchGWjdXQjGAsBsG+FAEUeSAlFbDqoJ/rOWD+TJRKkS0lkp9L+YsLM/oWaTd6k9f8A
 qcq2xYqJrRDVEuHTlXusSUDwpMcobJ3gjZzYrVOlHzTUTaGUfs5bV7wgUndQOBTSUYKLSA4xttR
 tB4CZJNm3R3YZSzG/dFExttW8z1kQPrpidLeDhckfqAXtQZ0MM9K/ahRmmSeoGmc5BuAfJgM/Eh
 0tvpDEXizVTI3P+YnxRK7Ze5qZbJDsZPrVejaKXVdaHoluZFP/+TLzK4/RqFpqOPVMfiviafw2S
 APaEowzxOr8u09ycV7N7xWLX9nKYQde6q648ge0lDdfRrdHrxjI6B74KbF6SuBcy1o/iY9OCTSP
 lXTyrnmedt6eoGVfu8BoxK/MwbpZ7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290194

On Wed, Oct 29, 2025 at 05:00:00PM +0530, Krishna Chaitanya Chundru wrote:
> Enable TC9563 PCIe switch pwrctl driver by default. This is needed
> to power the PCIe switch which is present in Qualcomm RB3gen2 platform.
> Without this the switch will not powered up and we can't use the
> endpoints connected to the switch.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

There is some broken logic in your commit order. How comes defconfig
changes come before the driver which actually defines that Kconfig
entry?

Please reorder your patches _logically_:
- DT bindings
- driver changes
- DTS changes
- defconfig changes

-- 
With best wishes
Dmitry

