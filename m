Return-Path: <linux-kernel+bounces-780401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36729B30149
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A731CC624C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E233CE83;
	Thu, 21 Aug 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V0Dvt41u"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3EE33A010
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798120; cv=none; b=jm5J66KIX9rIMmd6M5v7Q+QZ+8glgdptYdtmw3MeF1n1SFiv2wATTiNsz2Rd05W4fMRGcEJ+hJh6fyWy8Sbc8RMkQnIWwKW1cda8VBGZJUYdfr0/Uo4vjP+yg1z6WhUZmbOsIDUu2Kk1P/pUVfTVcDnzWz0KjxY3WH2mT6sPcH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798120; c=relaxed/simple;
	bh=XBftF9vVc+3tI637KCJfSWq0zNEkjwcRWENx/cHOE2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyuOE6+2HD6ayubfJIumqmAI93naSTamUUsz4AeBkQekCD0GeALxWFCN2oen+V+ZTkzXG85o8XSWkkf89KOzNc98w5rd6SWOT3gjddF0Z0Cd66WgCo6A2Bflaj/jvkfNTrzyKE/mFWtO/W//QCg3CBpyb3SWkoNJB2+UORQMtvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V0Dvt41u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b8w6006302
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vnEqxJRQCtDvyZhU8tZMvU5d
	wwDJJ2c4l8Yh2cwd+34=; b=V0Dvt41uAXkDUDCxunJOHnebnpVu9uq2hh6nCdhb
	pWT9TCfCpRbXlfb+KNubBSXwayz+EHjSbF3N1jYZofM9GCbY59/jqCbWGj5DtcR1
	EF52rn/TimZTwqEn6fiiQuCCKY2zhASfgtlV2saMXPI5VTIrVMXZmufVsmHX0eW4
	5Ri3m0XD5I1+aAan/gu78y+2ELeVn2hXgysWoFeqea9/pdy3+GdEzWqyB8RT737x
	ywyK7YighTfrdFKHuUStCB1m8LLYYq+BLV6ih5gdb3vn7ND79xDa9SBahWMr3QmI
	bHtIQF/9JNYajuNjtwc0i716U050zswGujdij0YyX2UT9w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5296bjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:41:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so1453301b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755798117; x=1756402917;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnEqxJRQCtDvyZhU8tZMvU5dwwDJJ2c4l8Yh2cwd+34=;
        b=WFwBF5PlUkbIieXI5XnZnXmZpViYcR3zXGAEv3pg2O2Wt41rAs8ZSvxI8EIzHHRJyO
         ojDlwO0lFbMIw7mMFFKqBu+URa5JEyPSfOox5JcPoWeQgyUbj8Xe/S++a7aTu7XXnZ+B
         xVUvyR3Fw9zNGHq5tts7CYmfgSixovohCuxO7r9ayLWlMelq97PABrG4ijxlpSLudAOM
         OXR4ULpKxwQtnyRhYgR77r+JnH2FA3Apl2LxPBqltFgTGb+i9uxsUmqhR1GVy+5LIdjl
         bQOzTYuT6SNjhmVcx0WbSj96AH2IWjLppjTJ7z/m9lFGzqQt/TOw24AnkHSR3whNy8Xz
         0hBA==
X-Forwarded-Encrypted: i=1; AJvYcCUeP92BbGvHgvn8LlcJbsmVxISp9/ZT+j7kEKNNIGH3go1S7UPczV5ChV7hQMUh55d4tMgatRA3JmT/W5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogNvewU0uoyWWQ4Q7J3gR6oZ5gc4LUOWfX+mEmxrFHhiBpTbY
	LrE33i7WaokcwBvU9IGoX8nlBZgl9G4vBQA6C0CCIrEO4XIIxmOH5we/fIekGUDAzwGayj74nEY
	CTHQy4rnk9ehTKnV1UvsSLlxvaVTKJKg9hXH1xOYO9ig4rcVgxbbbHdORWlHY4/B9PE0=
X-Gm-Gg: ASbGncsBMyl+cCN144nqh6LjH9QJeZRJ5VMczbinXXbpHNRz5SFiZvnJI7q9pZzUs8w
	1OqFNiOuo8fXlOY38TRA02JqCEnx/EzscSg4iRyBPgf/o5MsDJLLybRRCjcy1vGNk0AR5oRyb8J
	2HP/5ymNvmruBPSMqsZSlfe4zJRfvjSiGL6dveAwHj+W1AzZhGMF1w1UjF4kOZ3xrZd8f6XcU71
	pd1shBEZwl0q1c4uNOnSZXIeblEPQ157JWhj37XZUNGnSptPGMICbEfJyqPTVAwnj7p6wGirslc
	4QEo8B2OSwrh0shE45yLQo0EwdNQpNclMjssLxPxu8/zDLPoyd55puhh3TJ5sXkKY5A=
X-Received: by 2002:a05:6a00:1954:b0:76e:885a:c344 with SMTP id d2e1a72fcca58-7702fad491bmr269154b3a.26.1755798117304;
        Thu, 21 Aug 2025 10:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfoEcLMlYe+1GtBuuKraB9VKo/91uiHzpZAtRimt8UXekxp8zN/Lsk57SdrJhUm494lfaFIQ==
X-Received: by 2002:a05:6a00:1954:b0:76e:885a:c344 with SMTP id d2e1a72fcca58-7702fad491bmr269125b3a.26.1755798116849;
        Thu, 21 Aug 2025 10:41:56 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e830d3558sm8032826b3a.75.2025.08.21.10.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:41:56 -0700 (PDT)
Date: Thu, 21 Aug 2025 23:11:49 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 09/11] remoteproc: pas: Extend parse_fw callback to
 parse resource table
Message-ID: <20250821174149.d2iktj5tovw5d3ku@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-10-mukesh.ojha@oss.qualcomm.com>
 <aKWI-izL5BooL61p@linaro.org>
 <da22b26a-99da-4dae-9c46-2f871e45faa6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da22b26a-99da-4dae-9c46-2f871e45faa6@kernel.org>
X-Proofpoint-GUID: zkjUAODwNGtQUNaJJ1CQ9wYfhJxzfDso
X-Proofpoint-ORIG-GUID: zkjUAODwNGtQUNaJJ1CQ9wYfhJxzfDso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxWf9YxuEwGIZ
 JsqhreUV0H1xxrIR+4Vh3aJFJuSGiCE/+coZTi+9hxmSJuIKcG6IgEG/jy91NrvtNCFvhTvS8rj
 AS7xrJz+RrIvWXSvi6LKDlIKMzmKe1oZSt/eIqytH9CB2imuiaPqZSQHukk3zaPMZOFTVQfNZbp
 Q0BnyGNs5yGiMuYALnn0Gf8tnBDHEYXkngvTkgvS3VJYTuG+ppwFQ1S45ZQYAGbFQwV0n9/KCFR
 /3nPUeedIk0L8siWGC5fQo8JLTE0bQ1PZmmTbgkTf0VD0kHMF+No6sFaT28m2dkvXFuNeKQFW/T
 ZAWtgszuGoiNQvANum6EZCZTuADTPEK/t2gy6hfb8wLeXO5W9cyYOFjubnLFUXqGtIWKThXv54L
 OT/S0fmRb2egQgrstCXvchxRYonNaA==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a75a66 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=Zwf0W_gy_zjNHVC9GZEA:9
 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 04:49:39PM +0200, Krzysztof Kozlowski wrote:
> On 20/08/2025 10:36, Stephan Gerhold wrote:
> >>  #include <linux/slab.h>
> >>  #include <linux/soc/qcom/mdt_loader.h>
> >>  
> >> -#define MAX_RSCTABLE_SIZE	SZ_16K;
> > 
> > I'm confused why there is a semicolon here suddenly. Did you edit this
> > patch by hand?
> > 
> > Applying: remoteproc: pas: Extend parse_fw callback to parse resource table
> > Patch failed at 0009 remoteproc: pas: Extend parse_fw callback to parse resource table
> > error: patch failed: drivers/soc/qcom/mdt_loader.c:22
> > error: drivers/soc/qcom/mdt_loader.c: patch does not apply
> 
> 
> This is very, very odd process. Editing patches POST format-patch or
> post b4 (wut?) is a serious warning sign.
> 
> Few commit msgs also bring attention to possibility of AI, therefore
> please clarify:
> 
> Did you use AI tools (qcom internal, external, any LLM/AI related tools)
> when writing that code, formatting it or creating this patchset?
> 
> This is very important, as it create might create legal risk and
> everyone should be aware of it.

Again, I already accepted my mistakes of editing(removing ;) 8/11 patch
once I checked minor checkpatch warning on it and will not do it again.

And again, I don't use any of such tools, and hopeful it clarifies.

> 
> Best regards,
> Krzysztof
> 

-- 
-Mukesh Ojha

