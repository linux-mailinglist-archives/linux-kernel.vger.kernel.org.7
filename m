Return-Path: <linux-kernel+bounces-818653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D33B594B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE97A646D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52642C3254;
	Tue, 16 Sep 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CpKidFal"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A702C15BB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020587; cv=none; b=uj8r14we9yZ01wZl+qEVM5QW3yf4LBeI4XbwBuHpFBko91JMkAlYoqhpSk7lF6S194jfv0s37P0BpdkP1PUg+OVnFa602aHVm++ZMcbIaALVqp/B0X3juAcqhGq1Nn0S0Ij0lQ/Lsu3y/vsX8+Ynnh6mzgY1TZeIWpy8ujcocB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020587; c=relaxed/simple;
	bh=jCWoiLmYKgtosl3zfnsSg6IJaEKb9HxfTKRf3FW2tfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM6iyZNiS+LceYsHnTduzWBz0/2uZO0tNkk4IZV86GGgcfesRxvyY9PmCJcT9xe15wWRUR5YvSLxoVxJ943z66nKbn/pjJdEpHZXMFwjFlVrIfCk3Djsp72wjHeQlBs6PKiqQe7nlkaqsImg6KLpfZVr3gs0WYSTBXGsAs1zkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CpKidFal; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA9LUS012285
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aGWDhUBbPiv5SXm2JrRwK9rd
	9d5oa/pXGFvpbeXT4NQ=; b=CpKidFal8r8YMEiczKohQ78k+JXRhS+yUuEIbXS1
	g6MGu9diITl0kVe1nGEnCZSzRwAuokwfR5z4b0zj31Q0ofgXf948B4wKaX9ai/FX
	pkK8DL1A0hCfXSdRGahYBnsgBAF09ooRnAYUuV6ewg6imY9qn2aIVtn05jeanzMi
	wRJ8zmGPXMbJ9CdK4hr76v0Mo4Zxx1j2TSsZmL+MIFPI0wL/btDt0lGGIl0rlVf3
	khiY+vyNb9Pd4VLsqUBherw2zb9usklcJYxRONlTBs7zSROcQ2CI6EO4J03+fq28
	L39NP8ukiqo1PCmCImYkLxj0Ii6ZlfjixaZt7+lJRlBa+A==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g12m902-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:03:04 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-544cb3e19b8so7473376e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020583; x=1758625383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGWDhUBbPiv5SXm2JrRwK9rd9d5oa/pXGFvpbeXT4NQ=;
        b=WNoOOCZZSOQOG45FPE+OEJeiTfdMFWWilj7/oWX5umy9wsVK1SnoxjngnLIAPcaKY7
         S9l8sYVLSzhHpz8PGKK+LunCWE9/ebJLJNiKrxs9Kt2AixA0RSHOqwcmFOVhrnEiR+L0
         kxUrLT9GEiQUNcf+n4dcnVCvmrr4W5Z4dYnZrjNqp1YPqbgWE88ITNc4vrdPnvIgK5qb
         cYvbNdiUzCuvp3ZiVDrGUCeSD36LHrm/BlxFCkKpjN7lq8UXkRGKM4TU+SchJlqRWOn0
         0LlDwGug1t+YLoRoe0p05UKjaLguJbSoChL/g9tIwcrQafe+h2Zsmw9dWzayhFbuu83K
         8eVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj45AYwTZ7oTzVn443zjP8XKWLtdrv19HrYV+jl2PovPqR1gfCF/wZYjp98OimdtG8RLrGjK4/ZByD7AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpvKxGd5fMdMl67MS3E+iZUjPjiop3WiC+fzNf4h5IhBc3Q4q
	F9s78lGTPLzqmUWbUn7Bqpqsq/QdHHi5Nz29QPvfVKGBIJEy0ji5py41iZcc18QgY+ibU4Z70QG
	o1S/XlSVvNyKKGDErr853ipeighieFl9SQvnBilThsbSgcJ8LjVGGZehod9+mvUsOcaA=
X-Gm-Gg: ASbGncsE4m5uK4EmvJlUdYziJfwpAT7j+OJKxd7SzpmfoaOuYgSk90QhWnVkc3UrFeP
	ZqY0XJq2LeWpUUaoAMmnHEL95KIUQNfh+BxNZ4OUSZ9VMp0Xzez/pgQeMTNgg3IbnMUgomvMzzz
	HQqBntjAqEi0pLObeDVDRSuRBVgULoHNRSbVQuqBuhnygUYwpy5YjtJqOFSFHhGErWzjhMp3NRI
	6vxKnj/rc6HbjaS/lj+c5N9eD/cTSd51bQ0BDJm8w6nB0FtQMPM/3uYdVwyznqYmqLjlvHqfTB2
	jWcLPV+pFhmF9hZsZkioimXuU/S1UFQQbzi9+IySfRuSbZX+Y9MA7bToguizTp6oDW0XNSPFBzC
	Y6LaIo8XV9orbHrB9QqNP//fz+irOP/aJZBB39bl7YJnbDRwGOQMv
X-Received: by 2002:a05:6122:896:b0:53c:6d68:1d31 with SMTP id 71dfb90a1353d-54a16d07e94mr6109275e0c.15.1758020583474;
        Tue, 16 Sep 2025 04:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8pmwdL5aKOwSmINEgbn2GiMkviQ7ZG666F4+/PsdQLZAgj5aiT/QrcYUMkStouRwCE6p+sQ==
X-Received: by 2002:a05:6122:896:b0:53c:6d68:1d31 with SMTP id 71dfb90a1353d-54a16d07e94mr6109209e0c.15.1758020582881;
        Tue, 16 Sep 2025 04:03:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6167sm4429373e87.25.2025.09.16.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:03:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:03:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 09/10] arm64: dts: qcom: lemans-evk: Enable SDHCI for
 SD Card
Message-ID: <zw3efwluvdru4dyf5ijwmsewemlth3dj5oo6gcpkve254myrpw@bfuziw3jfber>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-9-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-9-53d7d206669d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: I0fj9BMQxw6w6RnijpVFaqt1_FtkPDys
X-Proofpoint-GUID: I0fj9BMQxw6w6RnijpVFaqt1_FtkPDys
X-Authority-Analysis: v=2.4 cv=E5PNpbdl c=1 sm=1 tr=0 ts=68c943e9 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3hZAb_iNorm4NPqi49MA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10 a=hhpmQAJR8DioWGSBphRh:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX4bukQJ3UoniL
 x6YYg6YuK90C51rm33djS4p/aC0OyY9JlMriog9sx/DH0QD8TYWN6eYsA3kB2jG2Suc3AiGkvec
 trmP5vuyX0uqlsHAC+DEHVG0YpnTgN5kaXDa6V64HtFRUvhCPKjtgFMj/R66vGrey6DFGL18yuA
 y/Zy4ZdzX67qZmkCkOrJ1rEjtRwcUj0xmSDNClXtFq0sE7r52ZEWJLG0ea/pE/7SBoLvgL9N47l
 oJDjjaD8dvYTc9vqohEogRYQ0jLOr6O2Kg2DAudU8LU6RKwio2wnMCErF8hmaOqi05UZHRd0vnh
 FO/cZL15Ti8bhBWeIYafPxUPBXz/SkYkjhwAjIKrWQjkfiazqVzURx/hC8V2s0g9yJ8lQBfnAnT
 DssvfV9+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

On Tue, Sep 16, 2025 at 04:16:57PM +0530, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
> to support SD card for storage. Also add the corresponding regulators.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 45 +++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

