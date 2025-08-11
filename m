Return-Path: <linux-kernel+bounces-762396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 790A3B205F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A6C18A34CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39B3241C89;
	Mon, 11 Aug 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTjwMIBC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CD23BCE3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909040; cv=none; b=KmtbB5tnNn+60Y9V9vnU1GYFBEn7/qxJLC2tZSC+Ax5KDpFp8/fxKtVUcr6d4FKcxxhGhdZNgQt3MI5ck8Yj4Kib1whtYKYmDCYO7b+G8QW7ueSAlkX7KqZsjttYhpfDbsFmXcCW4/bZiZbq+nA7gTeXJhSxbU3qK6pZWjDDhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909040; c=relaxed/simple;
	bh=OrQf5TeKik0aA/FhPSEBXH6grpaJsQKJVsOv7xshB1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWaJWoqUJVwmmRh8nRFWOyM/zIC1EhohrnrH/y8J7XlGX+1F1pYjzRebWuQCVJn+XKXeOCZG9Iqm7G4nrrXnedwbZUM9Gh42Tbl2M4JNW1rPsRhT173k1+i0yzW6pWYYbT6e28NVaWgj3Kt13J/G152+FdYpQ7ExVcEOAiqBo9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RTjwMIBC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BAGqcO024522
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HhXbP2+tna5Rc97KVm0kgr+C
	8N/2nVWZsJajTcTfHec=; b=RTjwMIBC52U1VjfbSIfzSN1mAUaM2KKVo+Z2O260
	XTreoGsZB/KYV4rhJT+n6PuSeZr873taoyzUfkfxRGL5rDWwn+dCYR8hTtZEdo8E
	+/Zq/8xHh6h9fs/k+hPLMm0bAvlFDlY9QkTm8UYns32DweQEF4sk+bfIscU4ZTYK
	0ONMH/4N/ljyTD9Gxhu2xbDW7J1gT/ykfBtkK4AdBWCo/xJFMuaAq3D1JMdWMJxB
	P0TT+qrgScff8fw5YObUKhrxgIL+bAt+kCFFP1ZTF0YoKQXj6i1CTk0b3QxX4W4F
	vV5uh0Ifb4TXw2tTiRJQBxwsuqUpvjENWDf7ovJ9/KhoZg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem482bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:43:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b0b507d014so48370781cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909036; x=1755513836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhXbP2+tna5Rc97KVm0kgr+C8N/2nVWZsJajTcTfHec=;
        b=IoSX18YjFAA49KlSI86IvVnZSQkfBBgrGC5QyiOQ+7io3XPrkOXKZDgsRF/POndkNk
         9eUB3laRGe71tAbguK2Yf1k6O9Fy7xbneIe/IAXyLLcmnUfrG42Z9ZSpVItaneI5P2w3
         WHa93EG3CBhKAAyYZtIuOw08kJPLZkxs/Q2pwHwU/nhIQxbjboezjqJ+9+5Ha4bdPKin
         UDRH7soBzywT/vLO0sqtdZMUxNHBlsOGtK0YD34YwluIJ7mux+qj15peRR2/e4fki+gR
         2RftkarTEDekVC+yPczOjmGO43VoEj0sy1VUwTOTdEdAHvFR6rWV0LYDTHhIyiHShU1+
         KBvA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5YjszgbgSK4rJz/SN3+LmIFEfy0zLf2UEgdETbgwQTS0ID9TxRohriFKnlVyywfXDes7BFOmksPO2dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfctNcxivHeUypsGLJMOrtYVd1Vlfx3QBussuddGlehsmno0V
	Nf0a2bZ0LKFcXzt25vz2a6PYcCGyLcd1Ou7MNvZqgQka+u+OMCx3Ka4KY+rfv2PuwuZ7OIV5Jvl
	o/Bs4BV0Ld/USa81RM5jSO2uRRk1Y2s2siwOeyUAEs9O0w1EV/OMvRYzZU3jzGzuh7X5IM7YygL
	4=
X-Gm-Gg: ASbGncunCDkw0S4c4ugGLN+9n/cRVDNzsLx+rrAMwDlUZBp4WUHjGj2F2blZ/wC6YAN
	gx1actLq0Ef/kR5s8FSHKbFGIx47SbXl9D65DJnsa4COkuyrCwuPcUbISlxkHtMEE+E/koTrdDn
	MeKjx4vyDtYz5Lzhs85C99uoC6YO/6eK/ivst5VTNParai0ORooWPzXLYMjbvVsJpMVofOgKNDv
	l6MRz9saQNRrIv1E32qBZw3+RUssik29C8C9e6jpzvKwutfGGQ4NXPuMRttqbF/XSs8BOzgGxEb
	+y7sMBu3piW4rJYHDwAP24G15rconLB/Y6T85inq9RkS/fv6x0IXdvnrNvBVgJIq2Pf1woSDiTe
	zmBEOBHgRARw5K6RStv4dJC5qPHXDsR38CMaiZXPbCT1uxzL11HPQ
X-Received: by 2002:ac8:7f94:0:b0:4b0:8087:b85 with SMTP id d75a77b69052e-4b0aed7c82emr155599481cf.57.1754909036456;
        Mon, 11 Aug 2025 03:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ+2vRNgiTRkhuWDXI9Wct/WD586NSNRCy2C3GvPTxw8ogEqF2gQptR6rB/WMoGGoXT8d+eA==
X-Received: by 2002:ac8:7f94:0:b0:4b0:8087:b85 with SMTP id d75a77b69052e-4b0aed7c82emr155599241cf.57.1754909036028;
        Mon, 11 Aug 2025 03:43:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabce5sm4279421e87.151.2025.08.11.03.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:43:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:43:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_kuiw@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sc7280: Add memory region for
 audiopd
Message-ID: <ucgmkx5fhwf4tc634gexj4usgzdme7aj44qup5qo4fpolnixm3@dgghylexk36y>
References: <20250701084905.872519-1-quic_lxu5@quicinc.com>
 <20250701084905.872519-2-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701084905.872519-2-quic_lxu5@quicinc.com>
X-Proofpoint-GUID: Jb6kE6XQj06Nk3i77sIqz1mUdrYj08sD
X-Proofpoint-ORIG-GUID: Jb6kE6XQj06Nk3i77sIqz1mUdrYj08sD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXzHrIBTlh+xH2
 HkmwOfV6+OB21mP/0sZeNIXlqNIUgTxQ57+hhND6heF0HdWOD0xBuyERoXaBYh44UIm3aHmvdJB
 XUjzT0brzoXMEY4LLXHltnfqukIMXdiH+N0uLsxTnzqkxEJTtDla5qSMz1EGhHhxh9/ymMf96hL
 B/m6nHmwORIMuNDSIdjfZvwZX1wwMDxf+wkzAeC4ls/l1c+ppFlv7XHzpUKqRE3eYqHuwHvhjNJ
 2kFGlwyC3B9AloFXOjzscUpn44FfcKyct7grA00Tr7NkQ2CjYr9TQqGWL8WHY2kvE6Uk+/5eVLR
 uZlYVNy3bWYVQMXL6KaSqdUVb/edFVEsx26s5KmG5qTxPZ79h1j2h+Gq9CR3PskDceoT40ZrFzP
 aXYU+rMx
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=6899c96d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=2S0CspHO_B4CzmGuarAA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On Tue, Jul 01, 2025 at 02:19:04PM +0530, Ling Xu wrote:
> Add reserved memory region and VMIDs for audio PD dynamic loading and
> remote heap memory requirements. This is required in use cases such as
> audio compressed offload. For example, playback of compressed formats
> like MP3 need audio PD support.
> 
> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 64a2abd30100..b1def5611764 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -189,6 +189,14 @@ rmtfs_mem: rmtfs@9c900000 {
>  			qcom,client-id = <1>;
>  			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
>  		};
> +
> +		adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x800000>;
> +			alignment = <0x0 0x100000>;
> +			alloc-ranges = <0x0 0x80000000 0x0 0x40000000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {
> @@ -3907,6 +3915,9 @@ fastrpc {
>  					qcom,glink-channels = "fastrpcglink-apps-dsp";
>  					label = "adsp";
>  					qcom,non-secure-domain;
> +					memory-region = <&adsp_rpc_remote_heap_mem>;
> +					qcom,vmids = <QCOM_SCM_VMID_LPASS>,
> +						     <QCOM_SCM_VMID_ADSP_HEAP>;

We should stop defining VMIDs in the DT and use label to determine them
instead.

>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

