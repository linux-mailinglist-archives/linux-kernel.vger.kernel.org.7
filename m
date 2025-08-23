Return-Path: <linux-kernel+bounces-783075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA2B32919
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF37AA09BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F811F0E32;
	Sat, 23 Aug 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pCzJiM3i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963AD1ADC7E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958890; cv=none; b=IRBDUOKJeovP9LcRhMAfNngd1QsQEMJpYnSpwdiiIzvnWyrC7kXWjI7USlO7zHhQEMtXWYes6YijHS1Xo/weSDOO6oPNRidiMCGJwY/4DE5Vz0E6NTdbiM0F0AX49bGqYdxgGibaO7nnuXmPG/dNY9FGD6EDjzC1ULJfbNkXtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958890; c=relaxed/simple;
	bh=khbVORoJwmzj8VKDm/dKhHweKD4KPWw0WHkplcKZ+Bs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NCAs9zfqkL+wPFZyKQFoF3zGdbBNaCHIKEjST8XUz7K91MAAqWmklP5xAe3ScbDBxh8KhIUoUSbBzN4zK0s56FohTKY5WuoLmerRUBYWtYjlQXGoJmHhWQxVu9gEt+dPeFoU9qYUFFAbPJmikPkXHO2GSdiLtXsAIQvmXrOBK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pCzJiM3i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57NCe1FR011564
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ECk1LsCNk3gjT6xoXSEgvWTIsSpYG9wG+965yN0jkes=; b=pCzJiM3iXeqj/lbN
	IV/J3mt6UntuZdlR3Ql5v+ass/KUy5aSHm8CbHFhBC9mm/jj2TVb32KpOIBEwYp5
	QlcmpyeDvvuKpxB/F4r8HH81zxGA3gblbiB+uWnoH9sFc2QA64XKxmEi0MoL0NH6
	lplW6K+gf5NrLnI18QZ4xKgXKem+MTryp9xjAhyuxJGjAU+Dkn+h1tTDP5s0N4A1
	baR5OUcMbcNmBL0qEN+OzZzSQ3uARnI2aDX/bAnMotkfRkNpicaP2oHj2QuC8Vw8
	ksopgrjb5AI7c4WgnaNjEXlPtzn8rr3rHdICw3NdEz5+xFBIaflKVOnzQzKfZ5XB
	4HMIjQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6de0x8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:21:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b29a0b8a6aso80524601cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 07:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755958887; x=1756563687;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECk1LsCNk3gjT6xoXSEgvWTIsSpYG9wG+965yN0jkes=;
        b=VzB03ySnt1hKI1LDl3S0+mIaEDoCF743z1Es2IfzGI8g0XAAFkl39Ur1QwcY+jxQHl
         /tN60dryaVhCWBfZVaGLjo7JY4Bt0it+NEkXGAyzybACfEZfwZOW2HtJ2cv/2j4BIpwE
         1O1AjNKNvDkWxP6CaHJ3KExY/qx3k9ThQgWSQUxrpOx9RIzsyCpSJA+14VQ463wuCxKR
         TXmluVU+LqcJQP5Q5nI2O72KJDifanD63I0vUw+wH062Ch2VXp5a1/WHI7cM47a8S8g4
         CDTGMP1vFJVkhW7MmjbEIngrM15Pjkp3opSNzrIGYyl/vDDwXAn1lG+19EpK22lRhh23
         ZBnA==
X-Forwarded-Encrypted: i=1; AJvYcCXwI2a8TcKubJK/3axoN1+1RHVz52zTgmq+df3Uk0TGnA6UKSY1ssP5d8Xq+KbjejrzFqptk699K3UHm24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrnfl0deYpeMaHWUpSBSKWdsucQpLJZL3nc4s/nEWeboBfiOSi
	CN6oAC5pGl3POKmBXmSNiaJJF0mksxxmt3u57Y45sfASpp31ggRHcF4k1UljQVmDpVMNoQRtg3b
	LMaLggQu6YmBRQhoD841ov07ImUJUCAVFKZIzMltgFeeX/dVi/tsYiBH4+1RlgpkTahLHLkOucM
	A=
X-Gm-Gg: ASbGncv3oTjpdAvsxe8CfedL0z6ZYyAnLrK8Da6HYEuY7Qa3wMQiRLVrTynVys5tQcA
	WBIDzWs4OlI0cOjo0Svb6JurOujY7JvqdGZKP7UgdOYarzIJLQabeEaqWtWZi09HZwza6Z8FEoW
	AzLopW2Tj10MxKYEEIhEwxZO80011Or4SWepsmsOIBHXLxdSbd7Y2L3u+KgBvSoY9ucV4kvzUcT
	JEbRYmczRyaZHDOFA4uGErBOyw0Vg1kANzvh01m8Va2GvsOAI3VD74+l8f7vE9WZL23SsHxovE5
	EYZuYrsGYZm1YJjejf96o/Qh2WSiFr232dR8BME/bo4fkAK/zUoyxBKjtKBjl+m8gh2sSKF41x4
	GNrEEw61mPZ4sGe0sQ169tCI5GFvbNAMHHsz01OvC2hqGKZgAYnPp
X-Received: by 2002:ac8:690d:0:b0:4b1:a3f:adde with SMTP id d75a77b69052e-4b2aaa40e39mr103546711cf.27.1755958886985;
        Sat, 23 Aug 2025 07:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4PmkSmlgiF18xFq5d2W4o3JzzrwhL20Gh1Sspi04wdUKBR/io81yO2DxJF6sLkzYTQNqwZQ==
X-Received: by 2002:ac8:690d:0:b0:4b1:a3f:adde with SMTP id d75a77b69052e-4b2aaa40e39mr103546091cf.27.1755958886482;
        Sat, 23 Aug 2025 07:21:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c9a1efsm523398e87.118.2025.08.23.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 07:21:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Matthew Brost <matthew.brost@intel.com>,
        Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danct12 <danct12@disroot.org>
In-Reply-To: <20250823-msm-fix-gpuvm-init-v1-1-e199cd5b1983@oss.qualcomm.com>
References: <20250823-msm-fix-gpuvm-init-v1-1-e199cd5b1983@oss.qualcomm.com>
Subject: Re: [PATCH] drm/msm: fix msm_gem_vma_new() allocations for managed
 GPUVMs
Message-Id: <175595888536.1764874.11815793767108601921.b4-ty@oss.qualcomm.com>
Date: Sat, 23 Aug 2025 17:21:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNyBTYWx0ZWRfX/B4wNjE7E2D6
 8nNgV3QNyrcxzYM0Ul5yBMUhIhmHWKpxIHrgyN8fS4u1rR/MY1ceU3eDjsNIdhHR9HZwIRgI/iB
 i28vFFYpN0ilA+QV4Ff4S7wNxKzGIBuMYN/j+Mou3b9h6dJrUXh/PzDL2NNR2sq+VN03gr02oDs
 3wA9+w3ZTW4xcC0On77cNeSmqGWiRXO1NiokcubY99gZWRgTa6ImlgvSDjPQHc+Dqe59RTrzpzP
 RcfO4lcIu/CV0iL2Zf3aGgfjg5nfL4WirhjiPHtiCgxNE47d2fXmT0y/NPrJvVG2As3uRJTMeSR
 XtmDTPncImAr0Z1qBGHI2BVM4518Cqy8k99ptsZiqU8PTjdTZUZRF+ZDfVYfL4iw/eazcY2nSzn
 v0g7eXQO
X-Proofpoint-ORIG-GUID: Zgc4QR2OFFROhq8bjr5DnN7KdxZDaUhS
X-Proofpoint-GUID: Zgc4QR2OFFROhq8bjr5DnN7KdxZDaUhS
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=68a9ce69 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=yaBPxWdkq7d3F1QRnygA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230037

On Sat, 23 Aug 2025 03:12:00 +0300, Dmitry Baryshkov wrote:
> Since commit 3309323241fb ("drm/gpuvm: Kill drm_gpuva_init()") MSM
> driver fails to init, failing with "[drm:msm_gpu_init] *ERROR* could not
> allocate memptrs: -22" errors. The mentioned commit reworked the
> function, but didn't take into account that op_map is initialized at the
> top of the function, while ranges might change if GPUVM is managed by
> the kernel.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/msm: fix msm_gem_vma_new() allocations for managed GPUVMs
      commit: efe927b9702643a1d80472664c2642f0304cb608

Best regards,
-- 
With best wishes
Dmitry



