Return-Path: <linux-kernel+bounces-838658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D10BAFD76
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636DC3C616A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBFC2D7DFF;
	Wed,  1 Oct 2025 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X9tK689E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31E274B39
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310524; cv=none; b=f8beY6gptOaU+0bc6OgdNitztdcsI0HdFKKw0YhDxTxaf39B5b6xuIvzG5t6rDRyVHZafivJk6YkoAZZvZPJGWdWwAcGqVOgADPUrwGUUYjFyp3FwwLWMjbn6jbUxtd9yiuBzcMztm4gJFkAqOPdSm8Dro8dZIWhBPo34l8G1lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310524; c=relaxed/simple;
	bh=IdRnIcS6QKGTsIaT5QjTI0wJOvHQNm5+p8Y5bF8BEoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVrLZNcGEenHjxcYTDytWQA3nc9TtwIjufmRc96gxXzKKN2Vk2YLd7PIA+XZaotYAUOIwW6YpEK/tLZy0BrnQCRX1KpPdUwiZS0THEhm283eP6UI+40tL1evU3Q7SVv1L5jYGGZlIo2ZDdUytTV3KH1aE3wktXcMhV/B06rHenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X9tK689E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918wpXg028127
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hz0VTKMOPpfUrE/UuDLPx/DiTF0z+t2Cca+4t9M7as0=; b=X9tK689E1sWeCYU7
	Oa48+v8p49Tl/xCE/8gLhfDuvtfkhHGw5/7fqIUOQmpMIu12hLGHd6z/A6UQcppP
	KrVztvZW2MjG59ZuIaNM6P2rHAbv9QJCad5UadMheGQaBzOyTu/fwuEXScSSbPxV
	HX4C50+9eP3b2gaSkdOc2xv5OmS3fa0P5bYFZom51c6DqA62XTricJlP7kJTpqfi
	FpLtzQJGwueoEI8PzjfpWliFjeim73bXQfIGqMG64Byt+nIpcOVo7UrxZmcmj8Ah
	/mdl0UaYM/djE/0SL95megroMtjIOhsyWPg2igRBtoHvhCuixSVtvm724Huph9Sz
	AriOiA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851m0ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:22:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dd729008d7so6611781cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310521; x=1759915321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hz0VTKMOPpfUrE/UuDLPx/DiTF0z+t2Cca+4t9M7as0=;
        b=S9AG0XaQLBflAM2dgzmyVCIB/pXBO8gH0KirEAKs7Bjyj9iFH+D9t7HGCQC0Bbye99
         sUIudWtsLtX3mqEwUwzJJq3o3P/YVmQjpgPZCog9YtkyhgCTVzHlVBDJk46RZzEtZerG
         /s15Dxz2jjk2nbReXf6HHfP39PLouHiZH20Yr3RJgNuZ85s97hP5cyRbcfcGvIioMaRH
         jh/3DwUlYFqT3BzfLQtYibE5AP21oIbGydxW5NdSYPhSuD1lHIH14VORULS/5SHdjuM1
         jBjduAFsPN5Hr7VsXkkl5KzNRxjevq4mtCjJ/d1ADttk3dvvbmoOCQrJwC20mU1ps+iH
         mrOA==
X-Forwarded-Encrypted: i=1; AJvYcCUK7UIiiQs/IQPyjPA1BeCPXcp7M8zRbQVixtdo5sr15UZ+OpvZKfqYPjlaNYjKPGoeEORpIwcR8zF4nys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+i6fpHuArVyJwKdQ0YaFLFo9I+s6uph26jr+2ukCzXIRGKH36
	ZoAnz/GHjuDya4YdkZ1lWuSbiLcoWjUCtGq52Z5QGO6p5WKMqr8nsK1S4KLF2FZewQkACphnevv
	5+oRaQ8HR6K+c3uiowHecybxrNxmb+RVA3n8qJ30SONcrlK+rcl3AfEL5OJci8pKdnqA=
X-Gm-Gg: ASbGnctx/xvM98fLTaaRcMQC0v25gIkU3eARJvc4GPr1YodFUaAeemiVjKZJMRWTGvT
	4EFNqtJShzeNR4V4UdChoFFQROjSep+jBwgy6x+tv/4LyVG88M62NOHkeNoWoSqJ9T+AeiyJy94
	rInyRqJ/wB8mzXmJBY3b6vSNEs6FCbuvLFPLP8VA+j9aQcz5VIn/qQqtcXwTgLeLODoDx/JffXt
	8WifWU+C1nFZ5Wcfl1QmuT4JcMsvIfNLNYHCRMfwf+7lVse/wULEEJ36OQPogdFfH4WJlfeG5PY
	KqLWmna9nothr3N/Z1bJ5GLxsURRCXzViIIU3HcefvWBLqPH+lqxLgZ4yF5Us/N85GIddhK/Kld
	F++SLlUCjj1mqmgMRmD8B5zfMidk=
X-Received: by 2002:ac8:5d11:0:b0:4dd:3948:3380 with SMTP id d75a77b69052e-4e41e91e3cbmr21974701cf.11.1759310520621;
        Wed, 01 Oct 2025 02:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4I5AplJOR96MzKDzS82JAqomgQQ5+85uACxZXIqYc74cYo+UMLycwKcE3vq/qFToNbOcKEw==
X-Received: by 2002:ac8:5d11:0:b0:4dd:3948:3380 with SMTP id d75a77b69052e-4e41e91e3cbmr21974551cf.11.1759310520172;
        Wed, 01 Oct 2025 02:22:00 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f575aa299sm573251966b.50.2025.10.01.02.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:21:59 -0700 (PDT)
Message-ID: <c8803f7b-74ee-4722-93fa-24538d5bfdc2@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 11:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: glymur: Fix the sec and tert phy pipe clock
 halt check
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250928-clk-qcom-glymur-gcc-fix-sec-tert-pipe-clk-v1-1-55e323cc98cf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250928-clk-qcom-glymur-gcc-fix-sec-tert-pipe-clk-v1-1-55e323cc98cf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dcf2ba cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=6KCzCHlq8YoJfQJeh5QA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfXxtUTjn+h53fc
 iWSFByu7CI1tzSwIr8oaB8bMc90iU/kE5zuGclTUMf6YuBwBYr9kJYQjMTgjZbzclqrQi0vAsbG
 uhZXxK24b7ryI7wTKaK4TakhFEXKMfA81hI+2slvO2jeOZYWRpKQq8SaSlc5y+ROEyglgedvF3V
 s7kvjcjRIKQqVPtFuuCrZMduFFkEt/USHz9SHxQ/7DEwtee3mQlvhNcf9AYjfIe0vkBID37W8zg
 utFPwV5izwynJYkN8+k5uQrDpGZszvFkxU3PxiQxhdeIB8rJW8+kqnkEgQBK6629JQtvY2278kM
 qnA3pxtiBSXNC74aaaIrXnlmjLRbKWBmG/daAqmKzw0xxkHeyfi/T/HD0dDXb6XY8FeFnRp4kd6
 pL5pYqiQAmLnW6udMMGyTl2tlokaMg==
X-Proofpoint-ORIG-GUID: D3rgvjze5Z3_a2SycGu9f73xmoiEoejf
X-Proofpoint-GUID: D3rgvjze5Z3_a2SycGu9f73xmoiEoejf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On 9/28/25 3:14 PM, Abel Vesa wrote:
> On Glymur platform, halt checking on gcc_usb3_sec_phy_pipe_clk and
> gcc_usb3_tert_phy_pipe_clk on enable reports them as being stuck as off,
> but since the gcc_usb3_prim_phy_pipe_clk clock halt check flag is marked
> as delay, means it probably it should be the same for sec and tert as
> well. So replace the voted flag with the delay one for these two clocks.
> 
> Fixes: efe504300a17 ("clk: qcom: gcc: Add support for Global Clock Controller")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Taniya updates all three to _SKIP in:

https://lore.kernel.org/linux-arm-msm/20250925-glymur_gcc_usb_fixes-v2-1-ee4619571efe@oss.qualcomm.com/

among other fixes

Konrad

