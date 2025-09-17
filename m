Return-Path: <linux-kernel+bounces-820861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B31B7F7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B7D480B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF78316197;
	Wed, 17 Sep 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Axf5Qmmk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951751E32D6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116473; cv=none; b=jAXmZHbJ/gqdG8SYFsMdR0l+crx1vjPMWc0l7UBiBpKNII5oN73G75805LjHs/E2aFuk9b5lFQerJOX0vL6q9a0/IfHgQUStvdSiDqhXMtaLsIaVxA/ZcLKtDBDaTrM2v6pyeeMwPi0pOQFY6fsvPQUHyYe0xBvIp0w9N45zDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116473; c=relaxed/simple;
	bh=g0He+fScWmFw3Wrgr6o24cjCzpRTesI9T42kVWMJSnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/woC+7e+yX4HQdTXm+GEEtMDdCqGwMkv6en6zRYTzKyThliGCEZo/vOGrLKHeMXL5QEpZKesL5lcX/4NEcO7C5OrLP7uIdm6VJH1SXJZ+Jt6FLFo0pXICKvLAuJJjkFdVizG0CnmTS7BM+YOuA8fc3lJllJPh+HjePH0ueicR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Axf5Qmmk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XeSc021478
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2alquu6If2SsvZ4fYTINgicB7yPUpfZ+7K13zW+7ZVU=; b=Axf5Qmmkeo9hEM+P
	uyxbaSc1R9Vztwualh5MCCoa2Nn3SZZm2/Nmbdv84VF2ZFeDiebbgkNpDL9TRJ1H
	leKghxxHoyjtMCGOllQmKAFGyoeAUtROurE3cJdzgQwle94b9G3+shrS0bwMU3J+
	I9W9PJ+FE0Yq7+jPGtxMAfLan8B4cG6PEh7LMsoY6dq5CE2B8XCkJJSer/FK6YyC
	gOAHUVHt9Tl9F4q4etkAfmil3OeeJF5F74/F2vxtc07Qo6ikA5Y1zyOZxzet5bFT
	3sLXHxKXNBLlB7Rfl2auruqPaN5v9SRPytgQXxDjQrL7ByzL+D656JKiPJLkhj/c
	QqAVzw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5ah00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:41:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78ea15d3583so14118246d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116470; x=1758721270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2alquu6If2SsvZ4fYTINgicB7yPUpfZ+7K13zW+7ZVU=;
        b=WaLghMGGGzP67olt2OB0C1pvpEBSlZVpp6b0B4SrlqUteKWX2rV1g5DbsuZbSwm4Ua
         Y5Q3O9LXAakEw/C6xVI6tRT81me2EQ212U8dfLsVbavD0oqBliL3Cc6oGO1K/EPySmPR
         3Bf0Opr47lPHnLZGlqN+HlXrzYUtaKXDYUSksNAGFpvfzeSgF80aB1PhdJ++d7Z38VMW
         gPGe0DeLB/dTeS5R8wYZn5Y3UWIML6mVThcVRtvOclbif8Cx0A+ce703mQ6wjL1VQMAg
         mDYOJj2TbU5QuIbI6qFQnhEAqIpPc3RVMMysfsqpuUdARtH/Ph1xAvrVkx65fLYJpMcD
         4mhw==
X-Forwarded-Encrypted: i=1; AJvYcCUBBWH5lTKbSffO68IWcrctIhlLRfnlt/2biGUaCFGORA3Nt0pstPPALU9VEVZzXTofM77Cl8KugqIn0Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYwXBabiYgFrosSC2NKma5Ii5FYehik8yCqVIAK1+qX2P0UkxE
	ogsdfG10a+NsWh+m7NRItZ5WVmHbIUNP0DoR3XZdpokqzFSrZfW6VGKv/NW8JXnVeRxGkgBRuQc
	Esnco/xzIDdcPg5FFMq31ptv0jgqhWA7MEDjLpi3U1EjNE6XzaEKLpl4AYti5ARFH97U=
X-Gm-Gg: ASbGncsAqVn2GbU6rQTcUeLzH76EPcNXLH4Tkz4ThFIRneA7zidNl3nhTSf0c7B55ON
	zhPDPCw/PASk/D2vIQIQynmXYtHbaiolWmjtmzem+dZgDRPJLJ300jwbPVegh9P5GMJDsK+vJjm
	z8miZdOU88Iu4hXUjwz4e6Os6rfJHsOiyDSdCwsfT+MGZFyr7uR3nEy6VNV1Ym5o/AEZjDYEruH
	bGW4HWUjjPD1LmRcB5pgjX2ULmZcDIU1EWI0B8MphjSt7CrE618rn0MVv6s3zwj5ct4TPZ+gqw7
	CP82jZZxH0+R0BX9upPzYQT/qQSyrTuXptd6LFXeT5J+SX3u51BMIf1oiBdxfsi8HCpkHgPem8R
	59oLgvoGhBKXAlhqSHTUZyQ16UvOJQbGnWq/+PH875WlNSK0oPRK5
X-Received: by 2002:a05:6214:4892:b0:791:34a5:8682 with SMTP id 6a1803df08f44-79134a587d7mr2380646d6.38.1758116469598;
        Wed, 17 Sep 2025 06:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG8CjJ+HmCrpSHuGNrLJMUXXobGCkzRxl+dlfY1SXW04kxl2vskOrhELTFh5H9YnapKZMXaw==
X-Received: by 2002:a05:6214:4892:b0:791:34a5:8682 with SMTP id 6a1803df08f44-79134a587d7mr2378216d6.38.1758116466202;
        Wed, 17 Sep 2025 06:41:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a5846asm42557711fa.5.2025.09.17.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:41:05 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:41:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v12 2/3] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
Message-ID: <gpnnlwwvgip7cew4y7jfzzt2y532bw5xdabud5ulntz6hvp6g6@rvscoeoyeb43>
References: <20250917-hamoa_initial-v12-0-4ed39d17dfc5@oss.qualcomm.com>
 <20250917-hamoa_initial-v12-2-4ed39d17dfc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917-hamoa_initial-v12-2-4ed39d17dfc5@oss.qualcomm.com>
X-Proofpoint-GUID: UK0t-eCK4okONSgcKVPU-4LC0Xq6qvFu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwoGRCuXmwhyH
 gWZmpkMyVNQLqrz9GhMO0Tsgp3W+WGPkCSdw5PDgjDpW+yziE++haS8zZ088F/+zNurHpKjjKM2
 KMy5FD5qxTrnPs/aV9JchThF8w4tMuHBS2J8tw+xXBxe47dL0ixKbnyyG9BAYhW8EqFPT7hfBLD
 loou8n73Vh8hjn4qk9Vz7Smquxf4VfYS4VXO1RadxSuSBat/nAyRfjxICBR0srHaK35EFhvPQj8
 i6KO4ioU/2hl3wNL/T9MsRhrtkwP8FfqzchQ1ayT5N/bCAVF0PvyPlCHQcTmi8AIqSoJTP4dI4B
 96sP75q0VAs+B0owS/v9SSF4R38oKiS9UFG4bRBQxbI8X1ZoUnBXEYhTHO1/J3wI08WailxGHes
 apjDZq0I
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68caba76 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=PhgHo22kut4TJJxNvVMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UK0t-eCK4okONSgcKVPU-4LC0Xq6qvFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On Wed, Sep 17, 2025 at 10:58:59AM +0800, Yijie Yang wrote:
> The HAMOA-IOT-SOM is a compact computing module that integrates a System
> on Chip (SoC) — specifically the x1e80100 — along with essential
> components optimized for IoT applications. It is designed to be mounted on
> carrier boards, enabling the development of complete embedded systems.
> 
> Make the following peripherals on the SOM enabled:
> - Regulators on the SOM
> - Reserved memory regions
> - PCIe6a and its PHY
> - PCIe4 and its PHY
> - USB0 through USB6 and their PHYs
> - ADSP, CDSP
> - Graphic
> - Video
> 
> Written in collaboration with Yingying Tang (PCIe4)
> <quic_yintang@quicinc.com> and Wangao Wang (Video)
> <quic_wangaow@quicinc.com>.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 619 ++++++++++++++++++++++++++++
>  1 file changed, 619 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

