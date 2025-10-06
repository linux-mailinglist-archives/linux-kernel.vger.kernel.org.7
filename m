Return-Path: <linux-kernel+bounces-842801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0041EBBDA4B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9ECB4E8212
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D72222C8;
	Mon,  6 Oct 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxJ6kvb1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC17221FA8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745666; cv=none; b=ZpCV8UI0hiXQmWXq8Nlc20WZxkm4dHJFwh7Sbeq01Fd3YODtbLh3/S9E8h+NywExzFedVef6ReVuBNQY2r6q91IpLylneQw3pck6gHG13hex6Yoy1BRRb5YWGRSWWYVjdJ9Uji/GSPhh3j4tMHkIHi2JiwaqN/rxbzkwgX1SKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745666; c=relaxed/simple;
	bh=3n5diOc/GVX3FAyOURc6tDxBpIvqdKVjmuy4hMw576Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQBw19mTT3v+cuhRKHyZnVN2DMo13C4bWIJue5jGlOQUp73EamQoE0jTYyWslqLKPSMPkRXO0DN6OjhfBXbf8DZSsKWllLzeE8dwbP0kFfkgnqLhQAn/hw7Ec6UJCxUyBMiiWLb3cSbXRscDvWZHNIlL5M1iYOsug7VgrP5Wcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxJ6kvb1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NSC1k017282
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Pkk1RkRlbB41L4lHFoSJJ7UG
	9ReoAbhWG7PYzEdfnMA=; b=DxJ6kvb1IMmD7N973bpB2J7zMx9/sc9NyCaUwE5j
	iLdASxs+Fz+zAlJWpkUUwqq/fM4+2JG1FlQ4ij6hnQwbdeOlcOczRZ5Q6piwHB17
	BU4THkDH+lc6yClZbDOq7sy06II2IhTQi8tByQB/FfCenp3XAxMwt9rZ9wt/QvHr
	NCX1tgfEGzZ0MFfmto+c8LlirzLF+kQ0lbe6VrMIgDlFXpdkLJvhbB7sPJwx+Mxp
	tQFhGv8NfPkZjSn6PjjrexXUDjkG8iprQQnY7y4zGSNmeXCOtfowlsb/KQfQ0Ugv
	d3AVkhS5rjoF6gzT/0tDOFmThQSekyPq7jXEC/qyw9g6zQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jthpunvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:14:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df60ea7a1bso97457921cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745663; x=1760350463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkk1RkRlbB41L4lHFoSJJ7UG9ReoAbhWG7PYzEdfnMA=;
        b=I3i6MehBM9750CR5HAWLjLmg9b+biAnvvAYbV/9wvSKHuClp1ZPfDxgAbgmCilP+al
         q0C6IxzaQSX/7wP7iXJtDXMYRlRfPpjsBFrqMPxW3ZTyS36Eq2g35KPYkxNKir5TwwwJ
         /HYSgrv+Z7NwmziDglHE1SZ0Yp+76ydWxE4kt7GCd5lar+NibkdkRjChz8F65Z+p6fAN
         RF4OlMFpdc326+KhrRwb9Z/89wEDYw5AQPSRZh3mzwaxHreYdu45NvUm+y1wSyS3lb2R
         6GtjwL6d1hITCOBowZb/a0wJUAVLKkW6oWQb7cpejHdWMKhX5+LqjKh0pA8VXrQ0vrCc
         Oj7A==
X-Forwarded-Encrypted: i=1; AJvYcCXDNTm29p47o5OTBuMOwM/CKOVVCcNH14Lv31vHyZzR8rUrfLvm1ZptBdrkodOrm/8xiPco7LDoTf/GICU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcn3AH6mfcD9uoBKLM36rcwOGTFr7baLpMMYGz1t1aYThC1QMZ
	ralCr4Ow1e/AGcNlG8zmk90v2Tv+3QKNLfjuiptGIUsnrTTpgByYSwSILNY3GOdK6zvWq94Vkux
	mrDftlmnNCXPFZriokvfqgS1QXCwgD3aohrK36k0UtbtRoFzyO0gzw9axCPktklgxV4A=
X-Gm-Gg: ASbGncsf39hAC9+pJRBk1wOPKvUCXOWqorUrHCK0T76Ir8vo5jCIHKFw5EaK3hjhfDM
	cngH2FF+VileXwUgEiyytlv3qj+tKGak/3SubnQ/BwUHg4QzUZhQM4T/NAZDHrmfR6m+E1sCYEL
	fTDdhgAVmuAd/iu3PnhW/NCJN++U3dOqmn6Et//rvtsDTsPIC/BhQQheonZcGPdVblQvEjs5nrs
	yRfl+WVgvhZGb99xPBanFacnDKTMLu9TZitz3LVSYAR1fvP2lXvxmVPxIVEJvOLINoIrOgKh4fr
	L+nsHEWtjdV9imbnUErNiHIvAp6FY7LvPwnA1mRhyGPpvTZeIQXk0VJODwPSPI4gflfaaEd1GHy
	QkdplNIQsBtUhPkOSSkj6OOu50oWeMmEvOqjoz3dGv6jrBqC0l+1muiwKXg==
X-Received: by 2002:a05:622a:19a5:b0:4db:db96:15d3 with SMTP id d75a77b69052e-4e576a7bbd5mr115462571cf.31.1759745662813;
        Mon, 06 Oct 2025 03:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2mRS+PCS8yqh6XoTz4k2QRrzCDf3fx5rt58x+S+tnSIyPuPPK5UjHLpMhBU2vR1wjv9UXMQ==
X-Received: by 2002:a05:622a:19a5:b0:4db:db96:15d3 with SMTP id d75a77b69052e-4e576a7bbd5mr115462101cf.31.1759745662272;
        Mon, 06 Oct 2025 03:14:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119e4a5sm4890540e87.93.2025.10.06.03.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:14:21 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:14:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonathan@marek.ca, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: qcs8300: add Display Serial
 Interface device nodes
Message-ID: <fsqytqhe72bgmloyzm6khoprq6bysf52ufz6oi6epos7uadyho@wg4rxs6f2xyl>
References: <20251006013924.1114833-1-quic_amakhija@quicinc.com>
 <20251006013924.1114833-7-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006013924.1114833-7-quic_amakhija@quicinc.com>
X-Proofpoint-GUID: QCqIrjrLEdasra0twaA6RaS_1wLAITUt
X-Authority-Analysis: v=2.4 cv=N5gk1m9B c=1 sm=1 tr=0 ts=68e39680 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=OIU6w6j0321fZR4p8lUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNiBTYWx0ZWRfX8ChPGsQh0BMr
 rl0AuQqSTRrdyNX3VFgrBiGdQ2IrtNUiZdLrQRf9WacKNvFvaVBf+luTzSC8UD4ck5I57Ra6t49
 5BUzMTtu9MdsQI2CvvXw5s9bDo4kFRKqef2H9i5GDw6lCSCpgsnwLTwBD/FnHAsdYIVUEAQsvVW
 pR4FEJuRrHGL8xvEM0qs69rrzGuXHmqqMFvCgb8n6BH9zqoWX/LAHG+/SWfAlY0Z1ooYXSZrc5l
 vaSNVqTnApN05N67Pzm/+/hqc6CLsF4+Cvqo65Yr3MVcb8fe847iw5QBCjnzvqHMc+4dE8dz2rQ
 jotH36AqtL9rbSjrK75OBBJkskTmyoIBLYqVlDSTUsjw3+4OjmHyjNS7RQ/CputxpfyP7oQfVlR
 K6f0Xewhl6bhjq/2EeWpBNwNcA9p5Q==
X-Proofpoint-ORIG-GUID: QCqIrjrLEdasra0twaA6RaS_1wLAITUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040016

On Mon, Oct 06, 2025 at 07:09:23AM +0530, Ayushi Makhija wrote:
> Add device tree nodes for the DSI0 controller with their corresponding
> PHY found on Qualcomm QCS8300 SoC.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 98 ++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
> 
> +
> +				mdss_dsi_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-358000000 {
> +						opp-hz = /bits/ 64 <358000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};

Does it really support only a single freq?

> +				};
> +			};
> +

-- 
With best wishes
Dmitry

