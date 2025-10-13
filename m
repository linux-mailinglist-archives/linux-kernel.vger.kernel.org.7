Return-Path: <linux-kernel+bounces-850506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF8BD301C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF34C3A69FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E9A2609FD;
	Mon, 13 Oct 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZ5vOFEe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7C2367B5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358934; cv=none; b=ClUWCKu+e7B1Q9H+3bM0fRs3/GSZQSD5Yuxss0TXy3EyNNWWg7QUDrQ1QIjl/rgNpN+jwoYN6FAYji8i+Y64CfmAsrDQ9kA3fA7o/XD2Gnhaiz9R6KXq177KZHpeOUI2wpN1oz+2kuyE60AmdupSfdbUDmam+cIknyYmf4ZgZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358934; c=relaxed/simple;
	bh=kXxhkCykLcnXkTZcPHSJpo7nayzyV8cdsyNMW6iYSrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5LdKk6FlzcQjRZxpsHLd1OyT3aoaXBHvlGQqX+oCXIolP9IvcG79a2lHM68EEix1GT3dy35Xl9E7BZnp5fmtWPyn6NwMOH1haJnZvZ4UYIkuunCrVM1VmEdEwESETVP+8VyO2D79Mue+2pxgfiEBwYdJzFxUTHAyAJcgz7hm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jZ5vOFEe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAnMgi021349
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m7L3o4Pwi86bgIe35Awo4E+H
	exJtX6srm8LE+iq3Tr8=; b=jZ5vOFEegJlPQpNfq3lTwLEnKM2Ukq9nwYbVRsfM
	XsN1rgjkcOX8zxZOxM4o45s1FEseh78LcztQ+fmeRqquEGP/39OkDCXLVDa7q5La
	+lRHXkqajUk2aR8U5D6n9Q4SmcC+curU7m0ND7GTQC5kok+JNl9UM+1kCXAcNKLS
	/M2Uhl2bsPfo6STYYZ44vvKVk8RCQ8Q7xUEN4KC9RgNujHSfHGJ34ZHFd5WyoDPs
	TgwJbgrZXjTmzbhY9RrZaO52pNzB2GdwdvioGfD5A2X6CvSBGDBZbSoKQ7KA4V06
	BgnMfkx6A4D1htxF2nQFc463c8jd4TBb1b9yxdtas3Rnog==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgh64eqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:35:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88375756116so247222285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358931; x=1760963731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7L3o4Pwi86bgIe35Awo4E+HexJtX6srm8LE+iq3Tr8=;
        b=FJ9JXNmsOQDF8oflpIn6JjzDfVn+IOcmMQ6w4LqZwsL5aEJ1XuwP1kJln6M8GF1dtM
         9Vmmp1KbF5jsvJUVMEJnqCRhiGsuikG4HmJF84LpxwJXz1nTMDu7ZKJS6TlIVPtKZSRO
         tOT1x3UaSRg7NSjWMRyRx7SQdNcgGiqRlhZrd7f1e+XdfheyrtWVxTWCHDQ5+GTZ3iEy
         jDqOcwHPVqCA/a2pG238PUF8riqMK3mxgRSdr2Dq1bnjAljlUT6Hd42aK3Ny1llxhCTp
         gjHfZRF0JfnIjr26L6Fwq9Oyq+6vMTYZKqzNs42U8G17yzerIfcA4JslhlZs4FYduxXr
         7HvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzUcqiAGTAREKhW8gsbvr8hqj6vUDv6NQGKWhGRRw9tq8tTFsN/vevHZYjFJUPDFcTKzwaxbPQwdCrnyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXu7C4RtON18w+XIsoE+TV6kEGuIQ62tYayf4Lg/8fVUl7mhuQ
	5hPXXkDYP02A0fZWWnmcHu5GsGiYC81nTzWJcsav/sWHA/tGFacbI2XbBXjPdzM+bxMlbcLhiWU
	FYJ3BkssO1WSHfg86ohOVg82Nrq6uJl2DuIrb+tR5xHcAdHreG3TKVACPrHk2Ji7qLiw=
X-Gm-Gg: ASbGncsVx0z/hjuuFAjlhmVrLQRVrUN99+F01qkS0vxPLqmUvKqD1LnApw77eS+xuh8
	Ub+CRATNLF6oyI+381aS76VHjJx5NNq7wGhv/cs+bqxTCVBd6Do+rCAQLOOPlZq0sF7glED+8Lh
	ecijW/5Bi8ad1inDqXS50r61VIirsm67mszgrUdB/P+AS+Ldbkt43GAIJuLrJqIi7wKUEJegHES
	0gpD0rzwU0OpX7QnN9cIM4HREd5/wRB5FbEliOXBTDjuPOd1jz0AvjnXcfK/pgImo7+lXMfRb5+
	QZvwSCmVywnyrkoeI6+OQVgVFN8xrtktxbtquw/+T++XlFkDItSt9MLnJq0bkjX8tgeaEnyp/CP
	pIrQ5ytRO5T8GD3R++AFzmRU6jMESyQZluAQtslhOWqty163Z2hh/
X-Received: by 2002:a05:620a:4411:b0:84f:110c:b6ec with SMTP id af79cd13be357-883546e153fmr2786635785a.76.1760358931010;
        Mon, 13 Oct 2025 05:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtTA5MLWXtycAaJRA0YpGMVukU6FtceKKwRiGS0eYpqRLVEiT3h5hR82xs7c3USv5CsJzY1w==
X-Received: by 2002:a05:620a:4411:b0:84f:110c:b6ec with SMTP id af79cd13be357-883546e153fmr2786630085a.76.1760358930475;
        Mon, 13 Oct 2025 05:35:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881fe5besm4080369e87.50.2025.10.13.05.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:35:29 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:35:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mahap@quicinc.com, andersson@kernel.org,
        konradybcio@kernel.org, mani@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        vkoul@kernel.org, kishon@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 2/3] dt-bindings: display/msm: qcom, sa8775p-mdss:
 update edp phy example
Message-ID: <cjweltdnffozpi5amqvrfwikw3a4plogjm6ozhbf2lqee2neby@ueoha7dmhpgq>
References: <20251013104806.6599-1-quic_riteshk@quicinc.com>
 <20251013104806.6599-3-quic_riteshk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013104806.6599-3-quic_riteshk@quicinc.com>
X-Authority-Analysis: v=2.4 cv=H/zWAuYi c=1 sm=1 tr=0 ts=68ecf214 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=en-7mTTXfYbHl6GqnY0A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNiBTYWx0ZWRfX2H1ERblIan/H
 CHltK/V0t67LLRs/Ph4Z78/gGdqeECmvMrMR4ot/0C3Q+xHJAzOI5VVKEKO49eqdVuGmCTB4Ubp
 6bmDbRyVLz2wezjEFBEdtZV4mie0x9CFcACp40CEdueVzyZr0inVrqLM6bicSTpqn/swEFsmYl0
 kZ8U1gbkVarDmFdcm75TvvOGWnfLGH7Md4SzZtSteFF9V7wAANCJO21+47MD4ABau/eIzVE7i3O
 RO0ky/dnQHJWL+Nx/XbO8H8l6iOta62Vpg7gqtgMW+wItJAFt8h11W+irKYXDUKx8Qcz4ikOFHJ
 bQA5tK7sY4U+0YcwvuwQ50Rj26ey8yWSKWrYmYW+cYJ/xxn6/oaROJiYTihpCyFBwBc3sMQ7bwF
 brVXEj1JoaoIQzgR8K6YKZcXALd9pA==
X-Proofpoint-ORIG-GUID: DTzFzJjQAcU1jCG7PTCdNDAfm0Sf1bM2
X-Proofpoint-GUID: DTzFzJjQAcU1jCG7PTCdNDAfm0Sf1bM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110026

On Mon, Oct 13, 2025 at 04:18:05PM +0530, Ritesh Kumar wrote:
> Update clock entry in edp phy example node to add support for edp
> reference clock.

eDP, PHY.

> 
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> ---
>  .../devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml  | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 


-- 
With best wishes
Dmitry

