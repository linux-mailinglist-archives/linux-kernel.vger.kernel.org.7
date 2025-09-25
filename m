Return-Path: <linux-kernel+bounces-831635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B9B9D312
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512991BC2B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBACB1D6DA9;
	Thu, 25 Sep 2025 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aE5kPspM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7F2A1BB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767418; cv=none; b=nLmG36kQWpe1qNV00K5JTXkNHSWnL8VKYzSa58tDhWV7BQG0v2/2vol0sxrGq1SmcPw86UMdlbzkSglVkBHkhmNpWlG5ZCxGgvk/Q00DSl51twl77IOZ0XrPozIn1PzklP+E8exP488SDcUCNmRs61a4ovry3kY2gxpvU5bLWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767418; c=relaxed/simple;
	bh=plWV8FVZhzKc5SEDmUQW15CvTrIhFuB2nHQE60yUcgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYAmhOnPyzhhVH+BDlqnZWV+DKO0kQr0z+XguArtXRxIjtExxFX/Bz08a1mx7m1ToDcIzcuFpoVIO2CDq369iadFbVKCxpEHgoXRQ/UkMW1diFp2h0/jYBnDQPicDn9J6k7lrnUgpnGJIhq2sOKyXQf1OrznBXRv8gPdEMa3CEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aE5kPspM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0Z4fu019915
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hEXHJ+SjOGDYSQB3Fj+ilyow
	IaPOlrIE4x+LCn5HbjA=; b=aE5kPspMgFYexH79wxX5NzYAOWU/cwsECdTvxoQI
	0dg1NE4znLh1q/o4Q1y/MNbnZUj7yR8fW6vBTkVTOLTG3cosBmar6/BOK6X0PHiJ
	KMIQQv0USvLsPqEzNgsMCdGZBXJtGyuR2cHPSzHFilm4hssAU1OR6Qp5cKOIzMHL
	ZBUMSwCi/W37IvS3wzkwTd6mzfAkJhHqc/a70hnQ3hs2EA89NeZplgAzOj0FegR6
	hIoMzmTzM/ssgNtKeqedEG9yAdaCG3sSAPN12g6bx+lObVwTbexH4laB4MYJIHTY
	lkDzOBACtnfArZ+Z0Pe6r1TjNDcIPyUuEXzf0GcbXyy9ow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdynm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:30:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5d58d226cso12303501cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767409; x=1759372209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEXHJ+SjOGDYSQB3Fj+ilyowIaPOlrIE4x+LCn5HbjA=;
        b=QYLE20jWG+4zofgi+KBLNlKpfcxxgmhgPuJbRLE1xSrz8JaumUu83moZBNg+apzfA1
         83cia6nueZJ4Na2VfFJRnlUkfuwD4MnFTit2gvymD02bJ/WaTRacmYW9HcAmtd2MknQ/
         lDV88h6olU0mtc+su8bY/yhMtXzUPelHTmoatXGvUrCDHll6Wr34XQXk+PxBaZS2AWQd
         GEVWsJW6UypG7slUxeSW8hKB2HbcuidvdAU8xPBZWmJv5sZxwVBF02g7Wk97pUIrEAQh
         P020/CcrXGsLynrs+Tc6AYnVfca3JeYrSF1br+qeb11vfCLz0e9An83TsUUrX+L+B20M
         dRlg==
X-Forwarded-Encrypted: i=1; AJvYcCUk//rayMgpoNp+6Ijq78SRB1grp1o9FqZvtFSdTtS3/NqaI8JPylFs5HS8W/+x2VPCXtO5FW+Lv2+ecI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtxh7+yjp6jM+EUNfdMCHI0rpVCDzXx9fPQ4NaDiSRcJKDNjf
	bF9hAzb3C0fdNt6imc8HZvOVumnHkd86PBkmOWcZp6f/ZHzZNYKgOMm5119vBlniuIGUuHEjNdr
	xGUo5fPu9FeadGKqKHMyh+GG6W423CsxwCg2Tiva+5l1QYsWtTu8ikorWB2Jbhxs39Bo=
X-Gm-Gg: ASbGncvvH4vX0VVmCduEG+sGUd1wXqSSkdIbmDxoCjz1lE1FHgkOKuEJ2LQXF9yJ+Eg
	5uAb5f9qWmhZ1exjeyhfKZl4aXpxzv06ugxN84fM62ov0OIhKz+3avSGlTsYMxME3b6QKiNkvkM
	1kCkJfnVSkwcTYPTI2C7GihxPTklDGhsEGyHm54NLMUt0fsb8OKkmBrkrSJmr5c5Cyy9AX9/jT/
	OdoZhGw5qEdWESzNL4QuHFlzrvhpyeTGJ2aLa5zCJRzeTc4sOdiI/ePTVtDaLioUbmg3D1Wgy/G
	TkQM1B5xgss0c84mXe89tkbOXGFfa9gCLLYv0FWMH0sEnHSSxh4JHCAeybXx5sYPkv/mIKL0hkB
	jTnCmwrcoVjbOIO/1Q1VUunHhw+dB4ep6Sv2CkZDE8uXC9AsEnDXI
X-Received: by 2002:ac8:5f82:0:b0:4d1:7f1f:af5f with SMTP id d75a77b69052e-4da48d78e03mr23750921cf.34.1758767409405;
        Wed, 24 Sep 2025 19:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYRodSYOZIlp9dQwajaJU2RST1eRjakBYxnpjkIG7EzbAunG1wg2V/xO1WNTRFimAPmbNJEg==
X-Received: by 2002:ac8:5f82:0:b0:4d1:7f1f:af5f with SMTP id d75a77b69052e-4da48d78e03mr23750381cf.34.1758767408636;
        Wed, 24 Sep 2025 19:30:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430c1esm253515e87.7.2025.09.24.19.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:30:07 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:30:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] phy: qcom-qmp: qserdes-com: Add some more v8
 register offsets
Message-ID: <gaazbca7xrai7nubxgyk6gbm2aznqbli57psvzquvwhdfamupd@g64zbtyy3hnt>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
 <20250924-knp-pcie-v1-5-5fb59e398b83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-pcie-v1-5-5fb59e398b83@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: FCB4e-7Y_G7x7oJoCddjLWFhnJt936G7
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d4a936 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lBzdhH75gVJACzjABzkA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: FCB4e-7Y_G7x7oJoCddjLWFhnJt936G7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXymoPPfx+kfBO
 2qyqmQyuxCsyFx5bUvAJIBX9Lw6WAcwZzteW5IhYy4mKJmGbddRFtFX02Sh2rhxg54YLjTapf2N
 3kueli+li9iENsZ+RCsz7d4arm/oEg0ECNFgAGdtVu8AdfRII68mvgKTMVrjxU0W5s1RovCINw8
 d0ZMJzRqwJgVT9C+Q7WmvxR3HHabIAv5OXkoumV1V9sPBgGVoG9V87nwj30uOevJPOO7PRTkRRC
 pKw8OYP6Uwf9+h7cZVqkE+U1lukBnoza4BZ272E9cAsaGGSdABeFxYTaFaJ+rvJU5dZB1F9N8hH
 wrr5fvf7vvyvw1dmgJmbjT3xA74QS13MEhRU6/fIw6LMJKb1pav+m8KhI/pX7bfIgGxL/V5eE73
 KWe9JLPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On Wed, Sep 24, 2025 at 04:33:21PM -0700, Jingyi Wang wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Some qserdes-com register offsets for the v8 PHY were previously omitted,
> as they were not needed by earlier v8 PHY initialization sequences. Add
> these missing v8 register offsets now required to support PCIe QMP PHY on
> Kaanapali platform.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

