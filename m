Return-Path: <linux-kernel+bounces-848583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1AEBCE16E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68B514EE4C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E322157F;
	Fri, 10 Oct 2025 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLdLx7Xf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B7221FA4
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117412; cv=none; b=ls6hTsFO4LMO4AWNjPhNJoJBNTIk9YD7N3NQsYgu2vSDG6HrQaNaGwMbFfd7ix0lYzGUfDm3DZbsOmQ057//f7QeeS956McF5fu/rCgVKxNK2/9StWPUGlmOvivOv5/lXdvXVPB0EV8e8y3J+4WJNfvdsAWbdCaDdjrCd9duosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117412; c=relaxed/simple;
	bh=nWNPqczF/IxgC8AwsNffriAiexgBBMHO9WesC80uOcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg6QBRD+0CiLVs+HCj3ycUFeMPbJB+IiBZaQ3+wqmferMd2HDe6p6Tab6/u1nJsjjwEAYRRmQUHom5YaNsveZ6HtbV3hDdEfHLzKyqzd6iIWqpscSVoYRQuq0cgxFQCzN5apuzEtx0Syl0T5spv0IHsDpKDFj4efJoBXzsDCKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iLdLx7Xf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AF1OSO018539
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ATXrLGPewk+USu4WH2tPmXTpI3iF7n/KZMdGkOVu4WY=; b=iLdLx7Xfko/0GgWa
	hbPzFA1YEUyGGpWqBgTsZYy7efzDlklzJJDrDRQ3e5AI4TCr+7RK8nF3S/IC01wG
	X+tvOzVklpiyOdaLJj1WRX6C2C+2RhOSWdZ2GU0i9I2aR4KhuJwLcD3/HGzPunLc
	1qHNDnxOEuM+vgPZtHh+sj205MMZ65m0r5h0J1BCd61SaSk/0+5KNK8CLb+pbD8C
	ttBfrI5LjG/tva5xb/94+AhEoeFAj+8lkemNN8S3eqtpvcaqVBWYN5in7kCsA8Hy
	KpbWabNKwKJZtcvMOB+qpbBm3iRFyBEKZsj0gl+mnQHuKhC2X0UT91XTp7BD3+HT
	Q6l+yQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m78ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:30:09 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5d3fd09aa9eso424211137.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117408; x=1760722208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATXrLGPewk+USu4WH2tPmXTpI3iF7n/KZMdGkOVu4WY=;
        b=rIBIfz0EktZ4f8mA+iGT8OFwD5jfmyjcSVfaISj2ya6NFIa35ztu3rztMM3ki5aLuP
         WfjmPhxKlY/tGgfQmfUNbrea1zm+caC07is+eC3Sqq0+nMDvd0pOBmG/Y2uBUniMuRgH
         55keANbYiLnX6ZYecnRz31F7xOJA01+wPC91DXjKIR3Gh7VpKPFQ3AQ7f/dSdr9PKyNG
         QvZvBSXih8vnBTKuW6y19Rdqh2FV9OmzlALNpKPasSpEAK/2HkBFg9j5mZjzpnkyumED
         z5zoo8UuAcP3p+UuJjxgzt10gBrZCwY2oE3MdFfBWzaOPKnwPndYDBcsKPW5hclvEw8J
         CzKg==
X-Forwarded-Encrypted: i=1; AJvYcCU2EuFpP6jmvEo/iKeSzJvOytDokMYIaY7qF51TxhZEnBvHfYzMH0CmcGS4beyuX7940FOwNKxe52QP0WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiZDL38xZdIurrA0hZPKTXUrosBDFencukIUL6AOvQxJ7bxtu
	wvLbZiL1nYazuV0Bq6iUA4IDGEypl/r4fJ6RQvjkUCnfm3fceQswoiv9vbXf5WYM5pigoCE2SEG
	b/kvwud+Pz65ebMIfjU50tXd3eey7UOASA7gffwbvqrKUmltMp6N8tQeCoXqQgzC/7rs=
X-Gm-Gg: ASbGncvUd1rP1hvxA+Dt7aycrMhgcwUxiB7HsDB2xRTZJk0irBtnBliwhkRKs8bol9C
	+scZGk+q9Mv/8+Z/MGFFWDgOMMtau2Tng8AP1MWvF5VkKGpFJ7OoTmF+65KRPPVzoS0qbaYOU01
	5q1fLOPNzbVbKkTA/lgAQgO8H6ld/VV6TohRDrmdQQd/4RHkSsM3QzMtAS7ueVrWbIp/zjflCsc
	Kc574hJV/TRR8zvFN51y0pzT7Tng0SWl+NItYauBG2elSZz8Q34MjPggR2gxYg5NcRNqaJJ/Iux
	Rf9MTfUPsSsMQl2f/t6vc2geJVHusiYefev1EceeVwMNiqtO9/+wweqY+YcvPnBPascim/r9JaP
	SHNuLsZ84Q9LcrjAEEV4pZQ==
X-Received: by 2002:a05:6122:e0cf:b0:554:b341:2764 with SMTP id 71dfb90a1353d-554b890a550mr1451424e0c.0.1760117408358;
        Fri, 10 Oct 2025 10:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHD0hhK6b4JamkLYHPshkWQ8JHKI3MVUIkzRHAZmhbAXRpyPdpO2PcbsweVGgxi06rXqhX5g==
X-Received: by 2002:a05:6122:e0cf:b0:554:b341:2764 with SMTP id 71dfb90a1353d-554b890a550mr1451416e0c.0.1760117407888;
        Fri, 10 Oct 2025 10:30:07 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c321341sm2786754a12.38.2025.10.10.10.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:30:06 -0700 (PDT)
Message-ID: <eb15cf16-f51a-4eb9-992f-158e2510184e@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 19:30:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: make sure last_fence is always updated
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251010-close_fence_wait_fix-v2-1-adb332dbff65@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251010-close_fence_wait_fix-v2-1-adb332dbff65@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX4asWLwZrbsc4
 20sUK2HsiA8j/jqGYVFxr9ZCTCAAlNjEk5jOCIoa61aO2W0oQd4CfNTNmppEqhWyTvWcYPCjCzP
 knhKWP8IFM6wSvbL3Rm/yAOY2Mx/a4NOUbVv0hk0L7qF+rM3vHJQztL1C0+aKEeT/GyrEY9Py/c
 AzOQeFUkJrq0ji8HgmlW/cQy4KUpbzBLzyGlRRx2QIminr6xkRGNrkwPZDZwsVUpTtB866C51Ze
 WtVUGu9V0uR192CARaepPjiF2fTE20FUthYGfwRaltpz1Tx0+Qe3/FsfKLB96n2M5os7E+jZgZ6
 AyLzmWkpLs4UYVbhKgC3b4JGUXWDRUEt+W387TTN7dTAfmVL8HTeqnw7BY5bhfo2n7jBjpJK7tb
 LONAgyCH+AYzOGU5kpahj8tlRQGncw==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e942a1 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=XV8jktkr_dr238JMAFQA:9
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: eCespaQGcYAGAuYWf0925zNWdDkB3CW9
X-Proofpoint-ORIG-GUID: eCespaQGcYAGAuYWf0925zNWdDkB3CW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/10/25 4:39 PM, Anna Maniscalco wrote:
> Update last_fence in the vm-bind path instead of kernel managed path.
> 
> last_fence is used to wait for work to finish in vm_bind contexts but not
> used for kernel managed contexts.
> 
> This fixes a bug where last_fence is not waited on context close leading
> to faults as resources are freed while in use.
> 
> Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
> ---
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

Your sign-off will be removed by git, as it appears below the '---' line

Konrad

