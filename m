Return-Path: <linux-kernel+bounces-865336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85CBFCD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5307519C82DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF8134B41D;
	Wed, 22 Oct 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXr42Zhy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6233F8CD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146389; cv=none; b=PZ5s7PvanR1QxwqjqBpUq9Nn/3vXZqtMlT/1DRZfEXw+LH4z6vKx3SyMsvd3iWHo36Ula4EESuI7OQTty5H/BAO/17iiZvJb/uAoKGacuosQ2JUQQjLSxVTn16wiYzkQIZEXekye8m8SjalM9cBOEuChYRT6DdOMsqKT8wDbwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146389; c=relaxed/simple;
	bh=AOPCbuZwYDb6Dpjxmn73PLplRI5HptZK9i3IrS9xvQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jl0Gfzq27rKIV+ewjKh6Cve3KWE3Bn0j32rCWVAWqzI4tGxt8IuwgiS7Fyog0s3jp9YXS2nQVydH7RKKmjPpcELtmEMC2w9wn9/xEgph+FGdX4o4Al66j+buV8VkpB2IzaFW4Gkff/m3xerYTYg/mWXCUyc6zV+IIXwrpsHoXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jXr42Zhy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8rok2024879
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EFJjV6ZS3dp82z3JjMux6bhTskobUNBVC36CDY6FPjw=; b=jXr42ZhyNhaVEDqc
	fV/59OWVO3iy1FJlmO04R7rOE1No/5fJWFuVd3Jk1c1gaNpLD3giL+96Tdy+rCu7
	M3EcFYR03VzPyqGGST3ck+gfanRm+wkXYtBjrUAwZ3SFtHQnfgubDtDJx/m5KDOc
	oxJlQZFmIzeYmjNzGcEDqeJge9Vh29dEZwxIHuxZ1YhGPtOL1QPzuOUtVusTMpi4
	+9cd4y7HOi2xuxGRK/ZH6FUvTpvc7wwQLrLf4DQqWZdNoEGM8VsY6unURVUqvMSD
	nrv3FQMtNHOhmU7VLMmoeUQj69RtsFK7Ajrpl+tMvhek3m3zcaLeFW2/m0tJ+7Xt
	S6fkcQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wsws7gtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:19:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8aab76050so4544741cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146386; x=1761751186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFJjV6ZS3dp82z3JjMux6bhTskobUNBVC36CDY6FPjw=;
        b=QBwqGx86X5ILgpiIHNL7UzQeYVpaxBexE8hYG2GQP/UnJEP/VWy2vOKDwDrWlkCx5+
         RotoFp89+kL3W/dKxi7LBxMYBFm8iLf71+wv3nClHXJaFuE00le7Vos1TIwC63lrZRQ7
         w75kTZQcu7DqJkaXPUykBQeVBgg7dZ8vv8OJ0yXkJPYNQgICUx5Bcqghe2SMLlLzJeyT
         ze87Zu8TWiEejgxj9yHn0NUMy5p6eM5OO7t7idkd9mOowfRqFiBtytJNeao+enMPtJR5
         qpG2fNkppwOXXGtSmHyAW79ym6bE1eMKhCgvsY2RkFYPd7ziMggGPuAcVFd53+iyp2Pc
         DYSg==
X-Forwarded-Encrypted: i=1; AJvYcCVWWuMt+ke4R+xkdfPpGKxUmjniHIQO87ffoRdF+cV3YsvBu8jbim3ATwAVjXjoYzJ8b63yaXG+TP/wAiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8L6BoZqy9GBo4Z2iP5p699vv01Pp9IsgdOeZlN4XaEXJBoCe
	Qw8tqYrtFiYBCTaowjVnf0AfMD3X8GFDUMWea7czUv1A6NoilKkjX1Ql2CqzWEe8RoXJVr8BRaO
	BRX2VZ+35wrbob+BXkBmTY+pqg/y9bu20kdZoA03Q2f+rXeRrmUCcJLH9n7ERDc6Q9bo=
X-Gm-Gg: ASbGncsI2wLqNEVtssGV5VAT+WP3u7MjRoUjwEFu/ksBbzut8e4htXHNiYUoD3PBo2e
	+vd64xgWEC6Rckq6fW0Soi+FrfxLkuOdCX2yBbHBWh4HDdjlsKA1z9YKmKMIUbDY2d+HUGGl0DA
	XyG6xh+/cX0o3aABI59lQbyF3I0i/50nF9VyzSsn744EfbmYlQ/B4Veo1O9An01XQFZoDEnbtUg
	0W1hiAxyx2IJBM5ujuxM8aEnE6YlKOZU+Obj5eItejDxMAmR5nV3sSlTQvKJ+xtI9vYxp6o6rmd
	Klsd5AyhHzBuUwKCJB1SXIg4aJ5ryHYhKPbMO8T/OMW8tbOLOIffwQ8HfZ8jaYfo1nokTTObgmc
	3aLISjJKODtk/acrIgcNKXoLdZl9yhxjI4HbSB651euQYg5l9BRe5fKOo
X-Received: by 2002:ac8:5a05:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ea116d889bmr62265071cf.4.1761146385872;
        Wed, 22 Oct 2025 08:19:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKXvCIbB2pLB6SjAv7Ty58xdlLb8zP8xTswFS1vxWoJjM0mXPHI55XPzjSk0aLd8Oz/JxG/A==
X-Received: by 2002:ac8:5a05:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4ea116d889bmr62264671cf.4.1761146385272;
        Wed, 22 Oct 2025 08:19:45 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab5553sm12255949a12.16.2025.10.22.08.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:19:44 -0700 (PDT)
Message-ID: <f859d423-32b9-4aa1-8468-c2e9ef006669@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:19:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: camcc-sm6350: Fix PLL config of PLL2
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251021-agera-pll-fixups-v1-0-8c1d8aff4afc@fairphone.com>
 <20251021-agera-pll-fixups-v1-1-8c1d8aff4afc@fairphone.com>
 <06aec134-4795-4111-801a-469afdd8977d@oss.qualcomm.com>
 <qanawqrk6izypwmmuvezzff37k66ptv2vlbdwxs62dqx7igop4@wzkz76376jli>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <qanawqrk6izypwmmuvezzff37k66ptv2vlbdwxs62dqx7igop4@wzkz76376jli>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfX9kMGBhUpw4of
 QVuty5S1NQbEPXeFHzHa8WqsbnAsX+V9MSRhd1tJsdQGWVJImgDgehim4obj5nfOKWO8egxjkyV
 JerOXR66zj0tnV8n5BLtA0a13+GUIfV4yFF+jfA+mRGeVS6cn6R9WUOONhNuMqOgB7BGz6r4Wj/
 m5yNwVHat7KO3pAdmJ8/WWs73VY+LDY1LsgXYrtOZUAOToqMFsk95U+T7LxXbuc2ifydYvpcikM
 aRyjHEVV1flkdCMu7wruON8gndJpMS9/KL1LiTlxN8m/TyN/UDx4RFl2HZeYX2De4RS/iuufyzO
 py7REPlTx1QyTDX3vO7TUL4IANinfYKT1igHtvb9U+hrpGN7YPRfxgPkwI8yx0eHU2X4S88s7gK
 Y2LdL9UBCZ1wVI5aorec0jDR3GuvyA==
X-Proofpoint-GUID: 3P6v_SAFLKvNVg1EzL5hyKaGTx4wP8Ja
X-Proofpoint-ORIG-GUID: 3P6v_SAFLKvNVg1EzL5hyKaGTx4wP8Ja
X-Authority-Analysis: v=2.4 cv=a+E9NESF c=1 sm=1 tr=0 ts=68f8f612 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3hiQA3MbAuwmldFtFxQA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

On 10/22/25 5:09 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 22, 2025 at 01:19:16PM +0200, Konrad Dybcio wrote:
>> On 10/21/25 8:08 PM, Luca Weiss wrote:
>>> The 'Agera' PLLs (with clk_agera_pll_configure) do not take some of the
>>> parameters that are provided in the vendor driver. Instead the upstream
>>> configuration should provide the final user_ctl value that is written to
>>> the USER_CTL register.
>>
>> This is perhaps wishful thinking due to potential complexity, but maybe
>> we could add some sanity checks to make sure that putting things in
>> unused fields doesn't happen
> 
> Should we just drop those fields and always write the register value?

They're used in other_kind_of_alpha_pll_configure.. and we have a lot
of drivers using either of these approaches, so converting that and
not breaking anything sounds a little difficult

Konrad

