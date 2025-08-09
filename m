Return-Path: <linux-kernel+bounces-761003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E0FB1F2DC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF457A6D30
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310727CCF0;
	Sat,  9 Aug 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRNFMl9k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366727C17F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754724616; cv=none; b=qBgiqrp1NLwI5rfhybXks73b5ePE9XWI5zeQgiGNx2hYPyErggZSF242yT9D+nua5BHYxfeXBAp9zFuc0Nl4HQSmEYbMbvm9Acek6yKH2aND6vSuYo0lHc5bSo2/dTghbEwD85xq+YhBox/DNeZ0nL0bfS1JzgqJXomtUtiL3h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754724616; c=relaxed/simple;
	bh=l8z2N3VCZM6RQchSw+3RLf4E55Fhb8eHOiRzLOSfIUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEcFjdwr3nWhwrdLf5h84gJ9WVDlLlXZoVm74lhmINFj6WrZZY48c/bdJ1Tw09pLWAgYyHst82HoJwcoarqIjGKitAEInLYhS0hxh/4pK9VMe9EICMPWfuphqIGVnpZplgVZyoSSUELbpjZ1eAD2FmO6A5UaLrG7BaaPRJSFvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bRNFMl9k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5793jc7F011498
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6cdLO8eSlr9RJYCTskzMuxsJ
	U7OJLCh7xxZyeqOV+Z8=; b=bRNFMl9k01cPZ27SnLt5YRi+YNY8iZx2Se8sUBfr
	wkdGbCG5I/c7d0fecxzy1YDdtmf+DSwdfngbzNbhspvgYn0ZNPTX3L91KwEDJnTp
	UoWPDv1/CbWaNsndJoF1V409sON0wUz/g5xk46o0jIB7AICMPIOAglezeszcjO7p
	fOhMZIgqUQfzDNuztLwhzG2UOuk/yW3DfmE24ft6+62CZ3rSD+Pt/7eyE14NI46L
	Zgn572YM7oVKOsyTrrXHKhA3TNVjGJKU1VI5rVT9w+ZRDgbtj/XqW7m9gK6zyUAk
	ClZnZPvEXUooZeSFfN957vlS28mPZLSqQHsAFYlkIRR/ZQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxq6r86u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:30:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b0b507d014so20411741cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754724613; x=1755329413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cdLO8eSlr9RJYCTskzMuxsJU7OJLCh7xxZyeqOV+Z8=;
        b=GGiAiAeq+faWEQ068zuendnlBihk1Cc8KUeT++P7Yiao5RMsrt+Rju8uWzARGVyh2D
         wYBBckm9cHqDIp0bamME3/H9WqBXsF2QAWdxbuLsxw5Bj4k/MFdiQbyFC4IpehzkYwjG
         +1kLyBqYgp+fWD4yTUXjVK7kReC/L/HBasxH1Vr309k3pjlwEK3TuoFeGts+PCXbp6Fd
         tTps/lunKIp3igwC+yF05k5ZjvEncv5zs/EhdPnxIyM/09OxNZ6R55VHkhd0Y8Q9Zckm
         we7XjBcHxqPRJeo1HGJzZj3T9nqloVEcZ8pNsiLyOMJFUCfP+CT1gBprOXpZ/Py59yzV
         Yv6A==
X-Forwarded-Encrypted: i=1; AJvYcCXe0T1lV9/Hhg2BZ1wzW4tdhcjEiQKUvhZvUN9q9K7G6FPmk496l2k+56tp+QzOJVYMOkbMEgz9JsdZFmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqCvtMkJSKN1wvkxAu1H0t4ejso9Y+vTZGnRPNIOq9JEVuZtw
	NedhNUFeuQhSbVeo0X9+u61QvvNNqTj0AjpUnEHzfrIAo9sjb38HRzsShdx7BaroMtJObvG1orw
	IJ+ALvf+1lfebjobabwP6G5zbPzSupWpBatnpyyHDkEk5MZDJRAWyeqe4siy48cjGBS0=
X-Gm-Gg: ASbGncsQy+qOdhNDEMJZzMytJRB/JTd94Mlog26NeZe+GFma8VjpHDPolu7qvh5jjDF
	bCwjlqZLHzK1ivmj1A0+J3nRxWswLjObLCCNtqNHSS3a6Y6GtlSUxwfW5NfnvKy35yrrRhcb+xv
	tA31Jnus2wtD+caGP0vev6NkZWD3X9k0z3VhyzrTHMFBdtsoRtEUF0DSqNp+baJczeTnTFBNSBd
	PuKJdmYGpJBA9TDo7jGZV/JyYHRrEHDDCwlsPCWt2AIZW635Tw9/LBwow/ifbSB8ueHME8Xj0pK
	00skkgghxsXAGVdfdyo9CbPnqZ6mwSjnYhOd1OO/08Z29YrCHMNSTpOj+FH6ReyAkcMjiLRDq9n
	x+zkIwt6dm39Bdqngi4m7uVxtPqW7rvX0TAzGTllUQzd0g+U6mhkP
X-Received: by 2002:a05:622a:258b:b0:4b0:65cc:f64f with SMTP id d75a77b69052e-4b0aed7c945mr88513431cf.54.1754724612731;
        Sat, 09 Aug 2025 00:30:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI6V+Z5+t3pF8WT1G/7aQiYdC2lbd+mLRd22M3GqlN6tzB0CFSCGVQ963LVGJWMyblECj+jQ==
X-Received: by 2002:a05:622a:258b:b0:4b0:65cc:f64f with SMTP id d75a77b69052e-4b0aed7c945mr88513091cf.54.1754724612236;
        Sat, 09 Aug 2025 00:30:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a9483sm30812911fa.23.2025.08.09.00.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:30:11 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:30:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, mani@kernel.org, conor+dt@kernel.org,
        bvanassche@acm.org, andersson@kernel.org, neil.armstrong@linaro.org,
        konradybcio@kernel.org, krzk+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V1 4/4] phy: qcom-qmp-ufs: read max-microamp values from
 device tree
Message-ID: <5nsglhsnqdx4l44r36zmxumcpbbwhns4432hm3lvttsgyjaknb@feobdhpzzo65>
References: <20250806154340.20122-1-quic_nitirawa@quicinc.com>
 <20250806154340.20122-5-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806154340.20122-5-quic_nitirawa@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyOCBTYWx0ZWRfX1KB+aviq1cGp
 4j+KmEdN+NuW2KBrDt6ItQJtNWLnWkDBPqpmVqcirbnibd5Y+nfmDFRVW4WGdjjgEdFTHguoeUY
 YNxWbhDHv5bk2gGGgNuzYUMk7zknyZ5QZdGG2v2nMP8f3ZC9+0vmNHdCTBCdgcL2X7n268wk4yH
 tAkZ5nzu9/EzaHGQUcYZjFWUBpn7Vm8PTtupYfOM5Cg3+PvRJYdW6ku4ZerusiJQWIUEt7oOeTP
 M+vyYf3Q5QeLaUlBLXuD0BAv498Yg+1FwTcv0g3+bYDsiafuuNgeYa6k1yJdbj+/bkFu/fLCn79
 9fZLO+X2fSSmZPQJSNf8RMPuURmnXX2BrIJ/l+bov8tjiyrirmz6YhDvA1+8MhPL4hm0gq7z1lr
 eRRAHgH+
X-Authority-Analysis: v=2.4 cv=QYhmvtbv c=1 sm=1 tr=0 ts=6896f905 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=eDCZef9bSGwXM37ZZ4wA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: jzG5CQxjGArp4L8ptc5utljDqS3A3QP_
X-Proofpoint-ORIG-GUID: jzG5CQxjGArp4L8ptc5utljDqS3A3QP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090028

On Wed, Aug 06, 2025 at 09:13:40PM +0530, Nitin Rawat wrote:
> Add support in QMP PHY driver to read optional vdda-phy-max-microamp
> and vdda-pll-max-microamp properties from the device tree.
> 
> These properties define the expected maximum current (in microamps) for
> each supply. The driver uses this information to configure regulators
> more accurately and ensure they operate in the correct mode based on
> client load requirements.

What defines those load values? Are they actually dependent on the
platform? On the SoC? On the board design? On the UFS gear?

> 
> If the property is not present, the driver defaults load to
> `QMP_VREG_UNUSED`.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry

