Return-Path: <linux-kernel+bounces-853416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204FBDB9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406EF19A1736
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80C630CD90;
	Tue, 14 Oct 2025 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B9XLbw6F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2361257AD3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480228; cv=none; b=lAVCjieKUr+QPwTqMZ5sIi4xQZfGBHQnHIMounNgYGNvnxDxbBRGhpc0JflPMVx4ICcaoT8s77g5nrLKbxY9Gui8Ntbzot6mc5OPuGHtUBj5ppvb4mqL3Ll/VJnNn7NishWtn8CpoMiocPKf3SZhrFZgLT5DII9/3LyEsuCVa1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480228; c=relaxed/simple;
	bh=UTBERQswmPtrfgvCDNGWHUY5Ci7MI6TrR3rlhhVtcuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJpDHkdFBWLeVlVqbHcLzobQpEmLu/k9wg8IevVzmq300W8/p/Tg1FSkDRqgu/DnKi8mvwiIXB7O5hpJsiB1BdAOHnZkgbXZUO2yeYQBef0E43cWGzSPoh7UQNSJttHWUjh6oZQi6iYYJzjTnrQC/DXjQSpPfLoXEY+4qGR8hAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B9XLbw6F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKRBxb000444
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=acxFHNB1qCMmBdmM94I3DPDY
	6fafFAZsfZx2OVrKtSs=; b=B9XLbw6Fx2zZ1zBQM570nvp2RMkPYfqyQDQkWZhv
	fzQTbA08rlojgXNeCKfhGuQOndGo3Y9tjj47AwmdGiNu8D62lfTRJqwRTWqzObbm
	xX6SwScK2mMiHynka1CbmHUJMHuVb5DV1hyIOwY0wpOeQ2enGaDuK/DwgLiZ8FrH
	VoyoZlgmM86qvCb+OekhKp3cfCmCoNexlt8FcneC3FxejfLl1BhtIjXifYcyBjaC
	GxUgqbLfCGJ0pdouIlqEZdznFyJgvzWwVOXiKK9ZPB2zaNkC7Ug2trpVYDm865Qt
	gxicwWVxfk9/n1UxpeD35z1/p3BZ2BpyDKkH01UxhTINyg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0t6bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:17:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8635d475556so1431982985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760480224; x=1761085024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acxFHNB1qCMmBdmM94I3DPDY6fafFAZsfZx2OVrKtSs=;
        b=Z+nmwvqv4CuZ+S7PTa+S2UuFMxxQE84y+L6uAXGVHqArcMp73pMVcyyivC/jL3+lTx
         tk3HHe4TwYs1cqg7R0V3HlRrvMKbbWK9hu127EBI8RlrGKpUaotUgwN/GIV0X/lSq9uD
         QeVcf+/ZK//ZLx4aJihWSSjGoa8AdTS0eA7Y8cQZB75nm3mkOQJ27SmeJwcNTH7BDk8b
         IrTGOMSfHUC8u47j/fEoAO+PFzelJMdAf/Y6mFNTjVcP46X59gnOSyCPY7H3ZUSVsIg4
         rDzj6oRW1NIFfTfMQEgX19RZg3eeK8EV67YM+IkQK80i29nEHYOXDyLECzJLRBrbBFEl
         s+yg==
X-Forwarded-Encrypted: i=1; AJvYcCWtSuMDOua8IGBipoWEQ1Ci8fBNt+/SkXUdpmeEYXf0GLzvcwqC9opSjhYYR/vIatP3eJg2o29f1cGCnPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7ZrsGQLldA3UB3mYskZ1TMnmTwFvaxo1X/LLtq/UJdiPcbI+
	r/7/HKPCRsYge+kelGs3N7aZolasCXjdyIHw0h7Ot34tIKuQvrEq1Rwc4rJ5Dp1J6ZqGX2iyLgu
	OSBNyZeMIZkDgQwnl+YdFfbyg6IHTZ5YiuzWH/g3GD/IZgIS5uMcDojliyNjP+D83Jvw=
X-Gm-Gg: ASbGncvS37qvO9XW04jGbodLBhlq1drBIExNOLa1zYbQJvdOKYGWfAzk+4VGAZiay8Z
	EOTp5jgDSHi6cdtNC3NcwtnvLx0sK8zQ0BKmf4Y3MlPUTWNNPM/ZDi4sLQaQzprfdJSuWkJV174
	sa0LAfUDH3qzjPOohiSgzMVfdx7GxgKsZGtTFPR7C25xnphFwBM5gbyeTTwo/gHmjn3yaLApEtN
	ifQ99Z+PJxg12YVr0c8JWTIOhwUpEgii9JgiC59uxWGLLtTOdDy0eUeK2wsM/eMUnTORM0hUlM/
	D5iN//McCZcSRXHyt+qKhPLIXAEUH2E8TLE/8rCWy3HNJOPjtE+xf4nswEAHThiJNonJ8Xznkz6
	4pzP6Yz/HrYFnkt7MhfPbu3fSnxSAFsD2ozrOHRi7YBUgoyqoIIeR
X-Received: by 2002:a05:620a:d96:b0:84e:2544:6be7 with SMTP id af79cd13be357-88356bece86mr3605346885a.65.1760480224029;
        Tue, 14 Oct 2025 15:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqry7gL0o/foP5bdIZkkIufw42pdC4mWKYSgvEtxW5lk93OwMTW4qm5JmsLq1hgKg1FOcqoQ==
X-Received: by 2002:a05:620a:d96:b0:84e:2544:6be7 with SMTP id af79cd13be357-88356bece86mr3605341585a.65.1760480223473;
        Tue, 14 Oct 2025 15:17:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762e77ea14sm42497401fa.7.2025.10.14.15.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:17:01 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:16:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: xiangxu.yin@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qcs615-ride: Enable DisplayPort
Message-ID: <geh3pbatv53bnk2zgyalnwvumvcsqaz6n7x6dniohsfk7r56sq@mpflfuye62ly>
References: <20251014-add-displayport-support-to-qcs615-devicetree-v3-0-74ec96ba8144@oss.qualcomm.com>
 <20251014-add-displayport-support-to-qcs615-devicetree-v3-3-74ec96ba8144@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-add-displayport-support-to-qcs615-devicetree-v3-3-74ec96ba8144@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXwh/Qyooxudeh
 pcrjHiKyUNpNbQduUWwKj92ohl2FS349Y80/4UKX3f2DodzIgd53fLqJG+CVVVopvtjA9E4g3E4
 +Iiyhm9ZECVxtzhAA1cawoBVbD/V6z4z0AHk68KsgySjAupRhoh4I5zyB6cCpwoGwhs4cjFuIsv
 UDh58KhtUDXxLQV7W68jWq3DwNkxzkykASJOA2h6QYxM4PJVlSFgfCA5+V0kmuOO+BBUocXoY2W
 wzRY6mAM5ZmdebwPQkydVVrXlCB4gbjNcGQoeJn1xbYuB+yY5RISQolTmot8+87kqVubOXlTdtg
 p1m7nyj/Rg9r51XiFVuqZMLdGjXBi9OXvAJXo3I1g==
X-Proofpoint-GUID: 841lLFoG46SBF5moAOULJu-g_ZjhLwe9
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68eecbe1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=VdtQghO5X5uSFlG9jygA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 841lLFoG46SBF5moAOULJu-g_ZjhLwe9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Tue, Oct 14, 2025 at 07:54:56PM +0800, Xiangxu Yin via B4 Relay wrote:
> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 
> Add DP connector node and configure MDSS DisplayPort controller for
> QCS615 Ride platform. Include lane mapping and PHY supply settings

The "lane mapping" no longer applies. LGTM otherwise.

> to support DP output.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

-- 
With best wishes
Dmitry

