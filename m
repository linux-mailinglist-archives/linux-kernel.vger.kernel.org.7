Return-Path: <linux-kernel+bounces-781708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D59B315B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6AB6867C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752AD2F8BF3;
	Fri, 22 Aug 2025 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G4g/xQEJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4282C0267
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859547; cv=none; b=tULPpfSNTlaN2cJHBD8cSd0glTMtPDfeCgp+fXf23bz8shywxUUCXeNRaIoV96ebGKndhKZ5HQsPV2KXLiteD3HjLYRZhlgcCzP83+BhC+69+Aa3HM15t00PyYu5BZwj6v9tx6wK5qZ81GvuK/XYTdI3LZKwBo8Ki5ivg9cPIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859547; c=relaxed/simple;
	bh=4Da/rNoRqu+KdQDZuIFjb/Wxr29c5xO+u3Hrcn4ak98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSTS2p1oihOA/LIYnCm7Yz12/e3AsRV7mzLpjE9o0zZuOkpfYvIg0Oue6UmkeTQJLuqgKy8u+4I4G0mTfYzK5zudmqcmDZsjNdd58/jFvVbfz06sTv14iuDOVK84w1D42ryFVh+wC+8frf01pxkiMElOOPigdP/5UpK9nX9rtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G4g/xQEJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8ULF6021784
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Hr+Bv/Zl6+bC+J6poy0J+QYU
	64VF4tnwHUKsj9xxJFc=; b=G4g/xQEJnImASM53PVeNpVVagZBInqutQoH4kfyM
	hClyz50JGBjRwqoLX6m6KzuXLQweSIbWBHT+AAY1JTlqWIp8sQmtmUrJKPqgvH1J
	QyZv7i6OpByAXOd1178UhgFbXK2xrd0xyrOnmSyF9K/337WSx6S3NmAgIimdm8gP
	ybYPq3x9asUlaed37uphv23dIJRUka3JbUdEYmy0LnzBpOUtienbH03fVCbJZNrj
	bXUNPcXQaSlm2iZOH4RQ4XGpFg02gvLAcY9VkazpOiveMH5uKvvdNNqK9FljrzWY
	xVZPiion8T15WfZz53N26BtSlG2MPn5WXL0J/pZ+7+lAzQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a8y9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:45:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d9eb2eb9bso5436896d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755859544; x=1756464344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hr+Bv/Zl6+bC+J6poy0J+QYU64VF4tnwHUKsj9xxJFc=;
        b=Q5l+ibw5i9MJY5Se83hI3InPuqtv4svONBJKbMhiamWJL5CP9UwUgYM4hbHgp65lFZ
         UopI4YOX0AUDj5aimbK0IuitcGoY74NulNIyc0Inb5glzv8niO/HxSfJQvzteJx6Zskz
         5Alay8f20Rey+rM/WQDoW1yQ7l8iGRPomI7N5PWLI+5BhsPzzfV7D6rP+uZ2bb47PtPa
         lRWGK179jpWwU74Wu68DsvzWv/3UPsTP38b1suHeRZ4My24wUu0tG9Mm74YfiTFF5WTO
         mwGLxYbOHf2rt9Vvco3jCuNPUrRV19N+C/hlFv4gid03d1WgCZ3ySi0Nmp135JFtTjks
         40xg==
X-Forwarded-Encrypted: i=1; AJvYcCUy86Gu84jmb8PM9nYE+wjfK6TDLb+QzXqXX1Awo3flEF/rLDZ8JITgJDlHJWuXfadnguopCsziv9Svk6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YymPkiiL4ktQBZ45JzZ3909OhaYaWWhh03XHSP6WvYjONV6Y+Qv
	pAmHpZz570BS9Tdfd75URzZUAE0nMnFgpvn4aU0fbKRDTQBclQcd1170+bu0+p+zFd5gI6TT+Q7
	9/FSEEDXF9eS0REqU9iJK1qq7y4T1ROuKPJo7uz1Xx2I0KDGd+Yv3i73GRB3xgwI4GJw=
X-Gm-Gg: ASbGncv647/DABvd+F3ZpUafsvjo3g1OQtFlMst9c3r2nqHKf9SPX1SfwjjtEbEHa6r
	xP6cR28KmNt4qfuaMXsuxj85Nk+wCFjZmMQ5sKymrrrL9ACpUUZS190L0DpHIKX995jvcn8yAhd
	9p/Kj4+mBqs7ToPsRyVtv6DJPzJFt2KIZbFgCmoT8Kk2qV3j1NP+hUe3/g9oEC4LhnTFZxOL9RF
	4VngtFxdqytI7oYL8lrUc/Bh9JIAncr0bBITEEKRTr01btWveuYZcvpd0pDLDYFGiG6gRQNHI2A
	34HSV/BYmDe8ZFh6gv7Sp/WCtRl4Pgi1Bnf0yxKd1EV4wvE/vWVmUYf/FKrswPMamepaSXkQ/ns
	Xy3LpaL8eN6AQG5ojPEiq+UxkMTCK0MjzLG/mZhzmXhI1dw2x6XtV
X-Received: by 2002:a05:6214:226d:b0:709:349d:14b3 with SMTP id 6a1803df08f44-70d9720675fmr28383346d6.47.1755859544309;
        Fri, 22 Aug 2025 03:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsiu+jZSuPp3DRAgJjk7+bqDL+G4Om108FdlP41DzJWGtQBNAjJ43xnePD/yq1clCP/p+4XQ==
X-Received: by 2002:a05:6214:226d:b0:709:349d:14b3 with SMTP id 6a1803df08f44-70d9720675fmr28383086d6.47.1755859543653;
        Fri, 22 Aug 2025 03:45:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55df8db7463sm2149334e87.166.2025.08.22.03.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:45:41 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:45:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com
Subject: Re: [PATCH v1 1/1] soc: qcom: pd-mapper: Add SM8750 compatible
Message-ID: <ccr4gnk5dehm5mjybyumu5yayde2wws7soiqv2cuqauggfcenz@qdzhzm2kewog>
References: <20250821160618.1037157-1-quic_pkumpatl@quicinc.com>
 <20250821160618.1037157-2-quic_pkumpatl@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821160618.1037157-2-quic_pkumpatl@quicinc.com>
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a84a59 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5LXwvtfwI9oVQe0OSlgA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: GuYR38VO5DtaoxiHPWfAHtdByz4IFMT9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX14tuYW6pelkc
 M5E46bsOWI+LsGfllBIheYTPSJGR1Zdz1SzA0Btn+FvSQcYQM1ot1erwilKWmiZeBjpLUWBqpkc
 mLwGftFqIMtwjqQIQi3JVO4npV4DY6ZUzzcs8MDSrxsAe30VtzSFbZwVUZ8uNQ31gNTGTh0GBr1
 aTnLbmaGTCi3GU6GsbwDJqXW9l9rhujG0+ZXH239wh0q1JdD/A2JRY9Zx0vvtvtx1UpY+1k0MML
 ofRfTiqZYZ/ADWPxBsCQGar1/NeZETGqDgMVhdtJ/AaPNGfC3JNmP8BpVAkBIee3CRv0njcp2v1
 psggBKB7b1c8uOPdVLGKL/CHopJW1G85CvJNnnGIu3Db83FlRNPhY0sbtAGl1QNDVZyGymZDx3o
 wZc8UnNpy+c+Khb5DIv6NvhzsUmxPg==
X-Proofpoint-GUID: GuYR38VO5DtaoxiHPWfAHtdByz4IFMT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 09:36:18PM +0530, Prasad Kumpatla wrote:
> Add support for the Qualcomm SM8750 SoC to the protection
> domain mapper. SM8750 shares the same protection domain
> configuration as SM8550, so reuse the existing SM8550 domain data.
> 
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> ---
>  drivers/soc/qcom/qcom_pd_mapper.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

