Return-Path: <linux-kernel+bounces-845883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A8BC667F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FA744E815C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE42C11EC;
	Wed,  8 Oct 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MCl5f/mB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CC2857E0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950293; cv=none; b=RJ4S5M7fYWK6PvYMlyu4T4okLV9Dl/FI7Sz4A8uKl3vHZpIUH0CT1rPl1hL/74Ndr1D1zwbFulhwhfpjZ7TBBEOwPPsJszaVx7ymcdW0buZJXsyyKF87RAPRqwkKB4Jk3VZAzJtzu5T5XU9+1eHp9jeyzFMYN+DqlnpO0Dykurk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950293; c=relaxed/simple;
	bh=F5j7+pfFJ0zioBtIlqjIf0yKgyL15Xepcs2kVFSkMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rha7jxZZxQut92Xp8SxHui7THImZTCs0AHXzhsGmqNxhNnnznJH45Qef9el7rbNfKaUwfQVGCGXqq1LE9ee2ZxIeBX6egoqnhulw98rsFSpWNI9NBrThXEciWJUBCWEWp5h+yOwv7Jz6tkLybqDwTn06VLuo8cgoF3mIW4E60dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MCl5f/mB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5fn4020951
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 19:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vLkdhzU4dB9t0lL881Qj037K
	WlsULwSrkxUDXDtfwCk=; b=MCl5f/mBtxOaP84V9D8JhUqzwD1cuKxkagK9splk
	nvmkRPGFWmTr0Z4wzbI8f3xvF9SK4y7wrfb6JZD8aYLLhBycL/B8pQk5fhFghrGI
	THLnkeIXjLMrVm6Z0LFRsAxGw8l30/iKQBZuZvSANz1OXU+tz56st/6I0ckX9B6M
	VclFPJo5wlpSLgXPQ4YXK3kSgMLUkpYxs7snAhSEg7YqCVjRENoyjhOaYNweUIWq
	Nq14eVIGkbbECmCL/4xkHnWoZAlPwMNVAHun7srRs5IN6e0FGQE654AkhRDyNn4+
	iHxDvtcymMrc/7LXY+42yk28hIOxwYh8rG/DeVynvbRTQw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kgakw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:04:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d91b91b6f8so1980391cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759950289; x=1760555089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLkdhzU4dB9t0lL881Qj037KWlsULwSrkxUDXDtfwCk=;
        b=BYS9SESsQfPTDVjOp0OhzvqKqqYEKwoiEy1TrgzZw61NBrjIGENhLbUESKPfRQI3BV
         D8kbqd0+AmWwBwn0HYZRlxsZ8GZIyVooDtR08C30Xo9nIkEVf2C1Qb9BhsgZueqFty2P
         /gFc6SiZOUKjByZ1YK4xpN+u8oGWFjDLWW9CAzD6CnSgyOjW4MEgG8NltvnPMCi71fJB
         59QUM0xprzZqpOvwiNMcaDSmuD/YaL3VMzUy10zLACRbI+b5ccZpMMDvaw1HGBL3JGo8
         2ZyKEMw/vHN0eSm6mM7QqAueBaTaacqFkoeE9PC+/pgyiX3DNEOj2tIVulBPCerSRQJh
         +Waw==
X-Forwarded-Encrypted: i=1; AJvYcCXpOYcYJmMzlm0LeI4uFmk8S9Sk7kwMYjpO15hbWSizetD5kGk3cabD965A+2plKtav6GrqMWh86xTzd94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpS0kWv55T6CopPYGJ1Hn3j6nvPUhpATy2JbAcD3rh/0W+/wPe
	n+6Q4BpCKVIZsMVZUHNqGVr0hB/9FAuTca0O03AltmQ9Ava+KXdVKAe9yw/P8Cs9bmUVz0Z2DUd
	VVq/rb2dk2161il+uNvu47hhv7682p4BNMNqwxgxdbfM0GdbilJ5MukW67+wN5MXZ4JQ=
X-Gm-Gg: ASbGncv4p28hpub3THHVsCxpOYMW7m0UzIJuu7UuS49dIkFZeLqZZqGHS+qMLMqYlL+
	p9pU5jeqq2y60A8F585yWXA5UzwgnmkeR1vMiawBZRPyeJjfIXHIePfRyJQlKx/LQi3A7BNRCxw
	rAo+QqHlE+hCFzxRpkJmRBPI/hdDzOg1AKB2SEqkGZ+oxQtEgXYELJ8mmQ6o6c/5Jlpk+gjQJE3
	5WO91bYIsXtiSUhlPC8ZRiIqGvzJDC+EoCmH5jV1IiHYtxa4ANNXidGRK2vu+CXvAZqhuXX7deE
	I288J+pzuP+fH6ddZIn4eShlTih/dyOJNu8gnQgg0hvFvJDRarDT6WyVr4Ww0zn/qMIDTVuLmKX
	8vt0rH9ap2cUt1uyY43Rz41XNN0ACUoM+0B0Lp0I61GHKjQL7OHjAJhJYjg==
X-Received: by 2002:a05:622a:4814:b0:4b7:9c98:aed6 with SMTP id d75a77b69052e-4e6ead58053mr70078371cf.41.1759950289360;
        Wed, 08 Oct 2025 12:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFWF/s5ht/T1nn9ZhhX03tqHdiImT9nJZ78m+w7Uds+CFfUB96ert6VvJukBJuf2++atRTiA==
X-Received: by 2002:a05:622a:4814:b0:4b7:9c98:aed6 with SMTP id d75a77b69052e-4e6ead58053mr70077361cf.41.1759950288698;
        Wed, 08 Oct 2025 12:04:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39d50b2sm22349511fa.9.2025.10.08.12.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:04:47 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:04:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH 04/20] arm64: dts: qcom: kaanapali: Add support for PCIe0
 on Kaanapali
Message-ID: <cydoo3odr5nh2i2grhx5pnvntt7yxvy7wzf62hf63krweeqyyp@kjwjiugjmfa3>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-4-3fdbc4b9e1b1@oss.qualcomm.com>
 <68fbfa0a-605c-4b6f-8ef6-33ebeea8909a@kernel.org>
 <noonr5lrw3ig373pi4c7efakil34vsaej6cshs52us35n2bbmd@7xmq35w6wetc>
 <f16508fd-05e9-477c-92d9-26f4f04bc056@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16508fd-05e9-477c-92d9-26f4f04bc056@kernel.org>
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e6b5d2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=LsMgGdHZQkRXl9bu1foA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: kBYaib-M7FRuuVhfHAl_8WBMzgLHi7Yp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX14DQvGDc/t56
 N8vfAE9rlAUg5RXnPyMHZMez3AaXcHWkcfHlmTr8TZN80gYFw2hNEviPmqk4Xhq/ZJFKXLkGQqI
 XVetUcSvQdK8F9Ve0Zmg8woSFtJ0/ihNeUVCD+BRxzQY484OxgDArQjG7lORzk7NsHWZzhvKSN0
 nTsqu1fpISsXzD6q+u0zGZJMpqCbe7dBbO1GBu2Up7FxbQ7Jr4yKsujo0/j3MEKF9Wj9YVo8K8f
 b/PO/WYoTUy+CnGKjhJ6fCy5+DuQHNB4G0iiAPUrPi+rxIapMV97cQi6dR+pmnDqJM0BwBRNsZR
 Mo8HR4kpVsvx5skyNFwR8ezNRb0ln+tfdHw69w6m/Yaq6I1CrPk45hzgIn6RZR0guhH+w5f8NXb
 qe9HEO/PC9KY7w2JD8L7wbmJbutQxA==
X-Proofpoint-ORIG-GUID: kBYaib-M7FRuuVhfHAl_8WBMzgLHi7Yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Tue, Oct 07, 2025 at 10:46:29AM +0900, Krzysztof Kozlowski wrote:
> On 07/10/2025 10:24, Dmitry Baryshkov wrote:
> > On Mon, Oct 06, 2025 at 11:23:23PM +0900, Krzysztof Kozlowski wrote:
> >> On 25/09/2025 09:17, Jingyi Wang wrote:
> >>> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> >>>
> >>> Describe PCIe0 controller and PHY. Also add required system resources like
> >>> regulators, clocks, interrupts and registers configuration for PCIe0.
> >>>
> >>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> >>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 182 +++++++++++++++++++++++++++++++-
> >>>  1 file changed, 181 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> >>> index b385b4642883..07dc112065d1 100644
> >>> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> >>> @@ -452,7 +452,7 @@ gcc: clock-controller@100000 {
> >>>  			clocks = <&bi_tcxo_div2>,
> >>>  				 <0>,
> >>>  				 <&sleep_clk>,
> >>> -				 <0>,
> >>
> >>
> >> Why are you removing lines which you just added? What sort of buggy
> >> patch was before?
> > 
> > Weirdly enough, it's correct: this patch adds clock provider, which gets
> > used by the GCC. You might argue about the split, but there is no bug
> > here.
> 
> 
> Yes, I argue about the split. This is new SoC, so any patch removing
> something from previous patches means split was done wrongly.

I agree that the split is weird. But it's not buggy. Anyway, let's wait
for the next iteration, which will hopefully sort out everything.

> It's just confusing and previous patch (the one with lines removed here)
> just shows incomplete picture.

-- 
With best wishes
Dmitry

