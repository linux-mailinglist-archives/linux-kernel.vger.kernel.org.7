Return-Path: <linux-kernel+bounces-881991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E181DC29647
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 21:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320AE3AE17F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634D21420B;
	Sun,  2 Nov 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXik7WxN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+3Mihow"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D53136349
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762115109; cv=none; b=mh+9jnRHGl9sBurIXW3paqnqUfcer5x5QZMZLdBC0IH9aENnSvFdK5oXrqIvuTOc++D/LWSPzBKCfBn+ZY6Fob7gs9SCRXVfoTnz4AJt1iQ95EfsHXF9ty/DZAg7YPggmJU9r6Gee2g9X7VsiBk6yoNIWN+XH+QD02ocaTSN+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762115109; c=relaxed/simple;
	bh=N6H5/yrrglS9GGUXXu0UIjTadrjxIjFbU48PaLb1FkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn+oxlAJYLLSGJgv8zlsKONHOn1GISvGgSKn0vl8BKXvX7SYbZmb9gknO74OawajnzF0bZ6M799EPoGZf5x/m4/W8azNXB1gQR+3RCBDn2HGEngJsTG6lF/12NfIEEx7Lk6H2VolF21VZEtEYY/MOLV2LwQQr0zjmFs7rsEGoUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXik7WxN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f+3Mihow; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2GffOg752216
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 20:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EEG2Iz1LJudMnHX5OCqnescY
	0Xbxi9uQYfIsRBJgGgY=; b=UXik7WxNrfMiGXzZb2sGx3fburzl4nHJ4Es5i1cX
	segTefYjXNeT+NrMbsVgIikACSS/kBnZW+EDi4r7qeBg4cjwmzbbCHgv5nIp/f7S
	ZbADih9mvKIn4IthNIcuF3WvV7Wk69dlLxXX9S0I8PIAXnb7lDVi3IeURdwjmsRv
	64lSZJ8+9avgDXj5IMq0kFemYgeEYZiXZXn6YSODSquMZI1SxjDYodfE1xzvAKG4
	nRTVo5tYWZybkumPV2RBmfhMUhqv++Bk7nLjbI9ygWtBZIejCgCEOjFtZrkuG45Y
	3THcL9E2iWefyC1jpct4IwBVzmLhp5a/jlRHwx2YCMa+Kg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a57jn2t7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 20:25:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e894937010so103182021cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762115106; x=1762719906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEG2Iz1LJudMnHX5OCqnescY0Xbxi9uQYfIsRBJgGgY=;
        b=f+3MihowWjiKDL2Q+7Zk91B3ocUU51IHW0bOh/DDe1aP4RvF9SSXyMeXQWa8Z/UkHt
         0BhgHKfPxIn1B5kvHR09FKIQVnr2uezUsFyw9mjlu74z/oyMV8OLBvbUVIvinSiIb6PQ
         lcdaNRWRBcOGeY7419p3u+bNQbJmFW1pMOKNjHOVpZlheso+bthbL5nkfVSJWtRNyjT2
         sI8pBgsEjqUkSDnXYC3ha2mApM4qYlEHVX2UXubBGDPU/oVRN9etw4h29VEVWV0BjLJn
         a9gLE0WeLqLBHgHuucPunYZJuyxZdACSZT2295FalmIo73DvJH+6feMeY8qu+VR71SJ0
         QZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762115106; x=1762719906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEG2Iz1LJudMnHX5OCqnescY0Xbxi9uQYfIsRBJgGgY=;
        b=nHwYLFM0BObRajqG4yXCm2TvnLyew9BrjYtvZdQOTIw8eoOMmBIBw6CKcZBMd4+VW6
         L1SIVjsTCn70e0aL5IazFCA1yI1bRlAGcrSAJR6geZYpCB/Uga51DF/iK28QSGZgO/uh
         Pxh1L1tdYHbIPgrSsdFAr7UGLUGl7Beu1D0dyVd7O6/+qDYX4Eain64i6zMdKtAh+DNt
         AxnNBkpUjLE6Y2ZOC5wpaMZtiuIlv2z0bkd7M2S+Uc1ZQRked8ED7vTDgIQqz7gwynO4
         ow2pzd8xS7B0NrmvoqjAUeGy8mkyrueVrbSa0EiWhJiZgXZwokpveGQRvwnbgTlZEuS2
         LqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVeXfU5+U0RcCUZkyQXe6q38LNw2g2JVYVFUjz/vclFtGPs4oOS9uVpOOCWE9MhXi3DX2vBb9pYe8Wh0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxuHvJ9CSFtQWNXS/TgVROEUE+PTUMGKogqpgdWcTyRSvV4AG
	ozfiy9+zXJFfxg9KeocAaPLrKiFpHQZNmF1hUrCGBVB4FUu6VsG1KJtPgaPBkURTtX525fqna81
	EO8QZcceUG4mc4ss4MbNOKBSkzmSJ4AVZ9JxgZbnnr9vH452g2qk8qUUw9n7vTdS9YZQ=
X-Gm-Gg: ASbGnct04OtzNHrtOhQaQWiwQi7vUL+RuL0g6OlcKLKhLjEs4RzKobxVtHLg3hT3xzc
	WN3tnoxHNd56RFNDbl/VZyEGRx2QogMp/ySDJANRbzLAKz67JT2zEThT64O6kSTd6m0GcYS+9H0
	ow+H+v+A1wZtbXjFBtw2vIFZf0usU69SifZq81f2tIUutXHoQwFZwXWzR63iGSkoTIb2blx674m
	SoRjlmYLNkPtMvU9ZYSQdu6V+XyOs6sJgDouHN54O1dFk7P6t3hdduNGHl9SCHTj9RGQTX4WKK5
	Aogyh6e7+GQ6n64xjAiApybMAV26wjSEl9N/Kvun55hO7G1U/4hHChC4pIRzXFUiqJtczC3Q8fp
	Iqe9/YtEIm0/gP/NEhSWxhCWauto4q1KPVuKlyDw+ZZwnhEzWF3JeEQDrRQJupkCU+RonLKlBhA
	mRs90iu0xpBjzL
X-Received: by 2002:a05:622a:420b:b0:4eb:a1a1:7c0b with SMTP id d75a77b69052e-4ed310c5d61mr139573311cf.78.1762115106272;
        Sun, 02 Nov 2025 12:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb5BWz3i5Ujnzs2gYdSamh2WbZV7R4N5QhulfUp+qcWnmLJlhrUeDTv8ibu172IgyTkjIZOQ==
X-Received: by 2002:a05:622a:420b:b0:4eb:a1a1:7c0b with SMTP id d75a77b69052e-4ed310c5d61mr139572941cf.78.1762115105713;
        Sun, 02 Nov 2025 12:25:05 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f39c0c3sm2249247e87.42.2025.11.02.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:25:04 -0800 (PST)
Date: Sun, 2 Nov 2025 22:25:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Rename vph-pwr
 regulator node
Message-ID: <nlqtcvxwszbi2bwpu23peualujip4d3bv2pehep7kwegf76lad@pxmiji36mw6d>
References: <20251102-rb3gen2-regulator-sort-v1-1-908879d240be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102-rb3gen2-regulator-sort-v1-1-908879d240be@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=6907be22 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=1lonT_InBH0CplU8HdIA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: O6HJ6Y5dQgVYLGxgHGt_aIwnv5192-at
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDE4OCBTYWx0ZWRfXyG4Mxs0QmSVk
 nUg8UWf5M7/hXmjr0+eDWPYyOt35UjYzrZfrBXjiY0PEAkHXMuen/QQOqchbFe1dZAZrPz7N4I4
 v5Lc50kG9FCcMhmiD6bIys/nyx8jb7Jt3RCDqMbyGLPDBdeVL/Wa9I6lhGinMlk8JUI3oWd/9af
 EctbskBQ43YlQDzbu9tHADODdeb8UM1CgAH7YY0iS0bwY22qGhVnbQ4BtSZMYsjrWuH9TLFJ/B0
 M4W8rKtvM7K76PUsz35u5vgS032eyccTq/kTiEVE3fh/BXLG5v7QlXJnGC2myDV6QXeNI1glZaI
 if7GNJGtcZf81BSTy5Vgaq8nS6RHbKB1WzS1MwwgtwqW+oIqoACWjNf0L0EJJrWj9OvCpDQAEjx
 Sd+Huq0lK2J8u8yO3ds5DVE23wl2Bw==
X-Proofpoint-ORIG-GUID: O6HJ6Y5dQgVYLGxgHGt_aIwnv5192-at
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511020188

On Sun, Nov 02, 2025 at 11:22:20AM -0600, Bjorn Andersson wrote:
> When fixed regulators are not named with "regulator-" prefix, they can
> not be neatly grouped and sorted together.
> 
> Rename the vph-pwr-regulator, to facilitate the incoming addition of
> additional fixed regulators.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

