Return-Path: <linux-kernel+bounces-754790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFDB19CC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0095D1781E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA023A98E;
	Mon,  4 Aug 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NzaC4u9X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF1239E8D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293118; cv=none; b=ZwGFVGFJe+jrdGfeH3Lygjjq3hVR7FAIttYFiPy0QHyCCHEDjMPurJlshw7Vj46/ROst94CPALuCoB3G77kio5rRI+7uolJNutE2oAlgJGF+Xs5T8mcMM6e4PJfKkha2rTCBkX1mYdf3WUl3LuvCydYD2ljzQ/wzH8Afq9Ud0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293118; c=relaxed/simple;
	bh=OYitVlFPxIikXZWi3J/Q24/sAG8nsc3bjQStGEprTS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hemyEMATV1jqBDZ53yiad2Bj45fjfVVpK/SMYUqsrrZLOPWLZPvbrs8DTv5AlvntX7oEWAiKlRiUgXBcGjynWr2Yk4Z+hJII7XgGgw1WBbSNePft25ow4DNsf+T5G4Dgc5d7l7R2SOoyufLAL9TgbwhCCokpi83Ph/0R9eKwqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NzaC4u9X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573LvGEs027733
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 07:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dLPEHMpuSUAhkcXckF10EsuO
	FuqVVkiNf5aJcVkK9Gc=; b=NzaC4u9XYQQcdeh8y8Z9fbooOl/YVEfzubRQLzvq
	8g9yemhfBM+Vm0JLP2QVelbpu88n9X6qCSYEX6mvn3rSHDLgshQvOzkoXNl7xaFG
	WC911Qz67X66ltgYSJEqRVDEFnDCOCB4MwjdYONGULTwLHNpJqepZ49nHNZBzbvt
	lxk8i7kz7kuby6ucbpMkOqjJfMVd3V2jVDj4N7OlmKI1SRNCn1jE273ioJLBpKD0
	gCphCMOsS8VbxHmNwPs6xnvfl8tgrlZnt1Hwp8Aj9vZxY1a5QPQwnqaYvsBmTbGB
	FYQPYWfPjud9if7O3f2MkFPGTpc/K8sBqci5n2E00GilWA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899pabyn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:38:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e7ffcbcf7eso109545485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 00:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293115; x=1754897915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLPEHMpuSUAhkcXckF10EsuOFuqVVkiNf5aJcVkK9Gc=;
        b=O0WnLSRwzdGgPItquGhOT8S4Pw9CECZdQZ/XF9Ojdi5pXeSllNtyf4zFajQ3QqgDQT
         c1MX+tSJ6LGiLraIRRVzRRLWhBN89G25SIGEyPA9PeE56r+r4O8CaEBldMFqhhSLACCE
         OVOoZRcyN0Rmef0o5oxoTnqxlL7t46Wxcthx0XKsxZvMPyU3REaqmORAspTrwx//4R6g
         MSxdY+7WrfYuI3IdFXgmK4tTSsly/Z+BKraYbsbCI8YpNfB1oNwzisv7PDFVmmni1/0D
         FyFryruT2NheHgcB7VUDrM6JFOjQwKT+5GDq5LM3tS4iGVNk8pysRSZ8yu63t6TD9g18
         cR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5H5K0yXpioiXf2tqh4RwrNzMPTOkW/lt/DNXurjZiw2iTBppA3rV99Tbg4rZ7fY0jRLTMk9Sk9zRXi/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgG7cSxsJwzHYnKFIW4lSduaQryKp2EqhT2D8SS3R4h3aMOvVE
	1SqBDFDrcerG2KODwHmL98VKRavF3aFo6hG0RGDO74ETsFeljQF/yFVAMy6BQBmnJB1Ix12tLT6
	1sUjk033UGYepEa2V/zYk8thw/udasrTKa5vdN1qcFjxLkve8WU4/TucFsU0+UPd2WH4=
X-Gm-Gg: ASbGncs5+8THRqw710h9rm4Kk704ctEy6+nW+HooVGVexvQtcKGiF7Y+xEE6x4WReWb
	UcX1+0gXUWZmiGzRFnglRq3H9nLb8wZNWOMNDrrB+XWFHw2qG1yPWFHD1dROTxUGaxo6VqXYISt
	3VhTsFvLeNyB/g6UKGPwEFFnUizw1Pi6GweHuOXiNS67k5k6VS8gThpSH1++w0XmQcoxfvpQuP5
	WyBFPCxY/7CdHFUXC1un+RSlhIsxN098KJRA0rxO6bNgkJr0JOL2RdsWRMdSwfuRzCjVZQJyusr
	vw7NTY7GE9tSPGv0ePnu5tvwLoIIrjiO9c5aNhL7gvaBQ7BoBgIaSjDaNSeLaP3OrIibYpUqGdW
	JENbaPP+OMWnKWkuXr/zpTswoZ+O/fskCc1Vbys9j+xuYfnOTs3he
X-Received: by 2002:a05:620a:a01a:b0:7e0:2c05:6ba1 with SMTP id af79cd13be357-7e695e8a0d7mr1113352985a.0.1754293114815;
        Mon, 04 Aug 2025 00:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbAIeDchoIpgIbJ3YOHJ8cPnw+3eT6oKOooZ+5+kJViLlpccUv6LJV8vEUOdsgTMkDrMUecg==
X-Received: by 2002:a05:620a:a01a:b0:7e0:2c05:6ba1 with SMTP id af79cd13be357-7e695e8a0d7mr1113350285a.0.1754293114341;
        Mon, 04 Aug 2025 00:38:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cb22casm1551921e87.167.2025.08.04.00.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 00:38:33 -0700 (PDT)
Date: Mon, 4 Aug 2025 10:38:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: simona@ffwll.ch, sfr@canb.auug.org.au, airlied@gmail.com,
        jernej.skrabec@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, neil.armstrong@linaro.org, rfoss@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Describe the newly introduced drm_connector
 parameter for drm_bridge_detect
Message-ID: <zzvczsirgb7inxtdr2sigsyjejxzd6cx2otdq5ugapbafw4zzl@fvxevtwepiz4>
References: <20250716125602.3166573-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716125602.3166573-1-andyshrk@163.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzOSBTYWx0ZWRfX0rGi0a+VRxWT
 nvlbB0gSuqxiU47gDTdTGjUcMZIh1mTNjvh+mHBino2J1fyqDXNz6kqiaQotjGmPzy8CtaZ1PdX
 k9v7hXIaBCLigFjlIQ7jqA5GAdjYu0W75ldoqI/tJ6KF9yslrCEAN4b6XT3cpzGKbPej5G9PoUF
 XgVExthKhNgF1kO6mNfKkgKfJ+iHvSLH2uwoTyK8gzMzjxqU/D8saWmdnQZ2fR+unX//zbt2kju
 rBHclQLUbCmYNy7GT/wyGJHBpPO630z9kK+yorenwAiELz0s+CMOatf63yAdjxw+NllHreub3FY
 hUYCGJUC+0KQVqyqbPyn6k7XXNI0fvqsiBKlENLrj6rh0MYbCSOr8j4RYD0dxTYK+JN0+KIqVMn
 canN2A8VKQPdaVChsKi6OcKaVP9Y5jb17UbKTJfNwxSDrOUo9XlHmWOEFncIayhkpuauiJed
X-Proofpoint-GUID: iAqOLTkW-Q3XrWX7yxFbGPWMtHV-gm_V
X-Authority-Analysis: v=2.4 cv=N88pF39B c=1 sm=1 tr=0 ts=6890637b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=qBLgyY_kGNq-VcCgTqsA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: iAqOLTkW-Q3XrWX7yxFbGPWMtHV-gm_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 mlxlogscore=924 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040039

On Wed, Jul 16, 2025 at 08:55:55PM +0800, Andy Yan wrote:
> This fix the make htmldocs warnings:
> drivers/gpu/drm/drm_bridge.c:1242: warning: Function parameter or struct
> member 'connector' not described in 'drm_bridge_detect'
> 
> Fixes: 5d156a9c3d5e ("drm/bridge: Pass down connector to drm bridge detect hook")
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
> 
>  drivers/gpu/drm/drm_bridge.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

