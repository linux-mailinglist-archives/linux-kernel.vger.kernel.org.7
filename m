Return-Path: <linux-kernel+bounces-787514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCFDB37757
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C23F7B18C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08551A2381;
	Wed, 27 Aug 2025 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZ+DF7r7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97201E25E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259123; cv=none; b=RqpdoBZr6qZdvtbGHc55DY5gpzhLnonRkGB0rhvVV5qDuAfSHxqmJYwf/WCh4iPdqxWZNxOiQEtUnRACyPFq0fsAwlBeHReR/oq9hOptaw3fAakee4mSs0maZ0MZojXU5skga4w4FtPrthES2IVVKTIPMp5F6MbjyX6Y9csubac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259123; c=relaxed/simple;
	bh=UVq8ijWoKWzpnf583jQxQdol3ylcdfNbLdYgB0k/HBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGEEudqJ/PUJKx5SNtHRw0Mai6+uwSBSOYiikX6hBCCk/09zBt5o707jzPy8NMAD/18Xu3IwiNVr4qsEaBeKb5jsUpesJLv0LFmRGZUWl6xWNFUTl5gIFK0TuKANo9cHMuz9SM9e8sGiXeufHP1gRXWiZr8MCzECdgdsFEP3nYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZ+DF7r7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QHLVBZ028938
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EVlyCX7UKqENRSV/+Uoj7vIb
	5mLKB73LY5H1x9aorkk=; b=pZ+DF7r7qRDjmqTBosQWZiu9zsBENsqiqQt2sQ/f
	BfJJM5SsYqKmZ87W25aEyzHNfaPHvAZJWmGwcMd21B2LDUUUlqiNg1xzShyxzVZA
	e4ngydvxpMGLSvzL57bqjAbHpXbEASgkvap2wVmeo2wrMZmQyvb+ePstkXGG4PuL
	6X/UZk5QT5i+NPxKUq2Go8m0O7kQQahk+bNfQeoS5ykwmbYReSRdGoM6t6v+3FnV
	qvpXihvZT6e0V6CzhXJTi61wYcE8d4IBEb+6GDfYnM4R2u8w8i3Gvz/eQBc0wiyr
	vIxmmNc8LljAm88TorEzLDZ51NdMoiu07bCNqklT3RcnjA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8ah66k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:45:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f562165so180343656d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259118; x=1756863918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVlyCX7UKqENRSV/+Uoj7vIb5mLKB73LY5H1x9aorkk=;
        b=E8xeJIENOzrrtw2T8zHq4dM8oi99Zni/jFnJcm2TrohCdrkI0JsWuJaxvDXPQg5T+f
         7enKvw1ZsZExPwlD2fCxEMa1wK0lOsqwIuLDDky16uFtq47PdweE6irnS3/VsCIjB4lw
         fXAuDxrS7bLJ0BGvh9HTQ7fCyOSLiaP4rJ8rAmjb/uCjDKHr9cV0jRgie9GvQklaKNBL
         gv3Zi6MJxsE0auIL07dUnEhZ24gjx1UUjaGpNgRBMeI8gsLQcyOkJAt4vU6Ls97FSdV/
         /9M+pAZ8VLQpo+HylOND2V5rMlQjjad4UG+oIPzgC7fjpIb1y97tU+HuWzNAV0EU8Uf5
         ARUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQClXHFpG9mCaHagk5n+G+LmlFucX2zR5E5RnEaw9V2ujHvo+oDEt+v3AdAgA/OX9/at0ab7JsJAgdcFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPSWWK9/zqIYd3OUoVw6yAUMreGUUCHOfxzeYa3d/HSv36dPKs
	+d1cOtYnt58d/dQ1/s8DI2/ust6HqmRo2TwKZJdL26JF0dkjV5QtRj2R7/3os8npGWmKYhZJtjc
	BXlCrAcwZiR1gRHDJDPnxL+QABq5zX2pz4/KXdcsDBwCxoaeKK3gRFFn8LnQh8rxWV5A=
X-Gm-Gg: ASbGnctK2yqFKEpmgM9PLEuH3jnQIn+ldMqyqhLYhwfGNsairLPWpK0uqxAuQlvMCC5
	1jZZzSo+Kv0tF5UXUICVR0p3jaT28+YjXmbgccX3ujilXtmXYtcOhXZqvuHMg/f1v3vYI25r4rB
	KSHwYSZp6SL6eVCrFt3zwU98CbjfHiFRZ9Fqvw/mod4qr2xx2t8aKqwuNzKYGHSghecORmjrPk2
	ELu0cyHX+cofv28mrSTJAy5oKOwjcTru14tCneXLr8Mf0MmPy/bqE2K6bHXmzL5sH812dlfdOb1
	2PJw00Z/s6D2F1DFu0z4NNI+7vdTymYLojac/7hdg4t5NtAB8w7l1yDTh6CDOuBnFeow668Qra7
	bHiFVFJ3sAkm8mHAR0lmCwN1gSyxASO7falCeyUraPlh/2F+UYoOc
X-Received: by 2002:a05:6214:468b:b0:70d:9bd5:5652 with SMTP id 6a1803df08f44-70d9bd55f6emr220290306d6.21.1756259118065;
        Tue, 26 Aug 2025 18:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWdYPt9kh8RJ2zFRkhVPn7Ohu0C4BSckH/umAugKFEf5MEL8zGfbaIQZmlbtg8WiX75govqA==
X-Received: by 2002:a05:6214:468b:b0:70d:9bd5:5652 with SMTP id 6a1803df08f44-70d9bd55f6emr220289936d6.21.1756259117532;
        Tue, 26 Aug 2025 18:45:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e2363dasm24546091fa.17.2025.08.26.18.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:45:15 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:45:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v3 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Message-ID: <ohzgigqvqdgaee27fdozzpt67i5cpp53jkj2rh226kf6sgr6d4@jsgqpno52x5z>
References: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
 <20250825-glymur_pcie5-v3-4-5c1d1730c16f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-glymur_pcie5-v3-4-5c1d1730c16f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68ae632f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=RFEw3ZXBErJeItyUBPQA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX22wFKi2MF/+4
 eR5m+hjbdvD1xWNNnX2MdM9PjBgTqUhRxsvRkwvIhJRiUR2Oa34ZnqB59YKpLtN+Wa05ZCqcXGP
 MBUuxMercYbUotRjcrVnyBXfIeNdaDTV9dkair33a1k6bKBc1CVEth2e27Tlto7BDKl++deaZWd
 tejrG7LFBJZKkIyqBPVwx/UBOeOo3EUREICTRzLJnz1ZlD0IDq+XyoSFtWYXip2aWcqkVZzaUxy
 hzVENZUZ5YDQE7sTgkpWXLvbnem5R6kq7gR60Qn2yREHKxcrwR1yBRvfVsNSTs3P2BBBCjKvRb+
 3YcwCHDCAvThHfWSmvj1Lp4lvfN1U0WkdNpLHY7pNM9hOteUvH4kdXcN3oVsXyxsn0XJyOx3weO
 mu55JfdL
X-Proofpoint-GUID: rJlW7SyApRF7i827NLlG17Xq5aiafc7R
X-Proofpoint-ORIG-GUID: rJlW7SyApRF7i827NLlG17Xq5aiafc7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

On Mon, Aug 25, 2025 at 11:01:50PM -0700, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

