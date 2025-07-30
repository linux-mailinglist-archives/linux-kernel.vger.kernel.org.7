Return-Path: <linux-kernel+bounces-751174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1FB1660A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441FA1AA6858
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC8265288;
	Wed, 30 Jul 2025 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kxFC/qMW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770BA29
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898984; cv=none; b=gdVwBqpYINly8ldm9i1vCHe1Yw7QmiFWsDj0jZPZJGw1ksoHRYkKk/0dc+QC5LYPnPBB75TLvFSggdIt2XGJntWnrDEXjl3SpOqXO2LvzhmVMCP/4NXhJ7j9cA0NU5N08kKCj38C7zPAisMWFzaT+xZi/i1o/aYd7HHWaXwJ9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898984; c=relaxed/simple;
	bh=uysVQLDbrNrO2Dt1d2Mtse/kMVt7UURpOikxiU2uC7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PztbNvskoRt5/tGussaABBwIgiDqplmIUvBXjT1Zks3oQMayWX8wHKmM26vOH7Tjen0LT0NKfntZ4FoFB+CyEpOvyfKxtuIv3jxD8DWvR+TuqIED3yAoqw78nZlJQJH3nUKG4jn8GZErfV4KuCC+hgi2rtiJO6ZLXlO27IuLw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kxFC/qMW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbSeh030772
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nvtzYg1hl8x/PPGrm3YFV7F+
	GFXE8yyZC3xOnR+O4uo=; b=kxFC/qMWH5RhBuGIQfIVYvRLv+aomLMieSlJGYsU
	xig53nUEDThyVhZ06mgZJVfStk6i5zT+GZ17rgL/vruU8hf08feCb/o06DnKwrnj
	PgX2apy5TW2ejJBXMqzk6E0JWyL/pxbSkfjIKj5WSRL6xOiJ9UO+n08CFXnhqr4W
	/Nw6+U26cU8l0kGp4nZPwAL9giQ6c2SynBcVXPo/4DFinJEDXgiNypKwzQkn5YyA
	wW1JMmfLi878vC1rNsATsxKKtT3EaKgZLomoGrAe0mu+SuhoR4fSCOIl1I4b20h7
	GuGwrfAW/GHzlrzWmC3G4dy1NNJjL6apHngweFTCwDXqdQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwes7y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:09:42 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073f820d42so1142616d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753898981; x=1754503781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvtzYg1hl8x/PPGrm3YFV7F+GFXE8yyZC3xOnR+O4uo=;
        b=Q8XRv8Cs9JcmygNajoixQ7hEfAmL7thKaf71bkWcAeSNUeOtPpwlQgDpVs4yuGlwrx
         j4tZbLElTqjavvBqTJHHPfvvff30ehiZIDOlZUotK2ICG0rODFI5HmtKuyPCqNGlwld4
         fuoI0wBhl+MhVahPCFLC0/Pgn7aBilJ9zTeO95WGnFE+3P/ygNI0J98q1Sa2qFvXvn9G
         eTLl+nhKyJwCEAQbo8t9xVYolszs2j+gRPgnTZqiZn5nuLsEoA8DvBRF578VzG33FIsy
         VubhNXTEO3NVFU0QCi+fUlnXA7fjNNZViQTB9tX1hlV4ClNlcHvW6EMW5vm5XjWFgQ7+
         eAiw==
X-Forwarded-Encrypted: i=1; AJvYcCXJfC+vM2bAQalejwpJbcLqhIRmn79KawaHqu6CDVdHrSxfIgd7uQzgLZsewhgA5F5fSgKSzd5nge/bXWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8DQiXJIYDAIAPKl6S7tqeT2pP7xzQHv/K8P3Tnee9fCfQmRa
	v2xRilW16pUc9RaxNVmhXBrlhWjk5c09dnd/c+OwFA5C91zxWwz41Yz+kRicvbKO3jiiEsFyrF6
	3HqIRGBiOcQqDhqUhWF8AIfk0xnkYZLsSJOj/yfcpUtROEriqK2nTNs0oWlifN2VOdXs=
X-Gm-Gg: ASbGncs3z6z2okUdyNeu2eNrDfa55AxO4xeeSmppQMjl6F2J+KOe4ROBtTwdtY0r7eR
	tFpGPQC5h2XNG0BAtzjUUccYn9Z2ptLVuaElX7uF5zvHSO3g91AWK/6hyzKmkX2BGgKpkHVVLtR
	I62WALvOi2N2GrG4gul9OYCE7wldl2R2WTUTL7hKSLdo9tutJzMvQgXyJSYY0SOuMjI24kvMlfQ
	e96QY+NAes7+E4FLHMYi6FaAdazK4oUd0gxh1Q3MoozHWZVKlRzHJrLsWrC/RV6nV2NlGi1ZYoV
	E0UypviPyyf0GNXdmySwwF9oPf4r+rftqm+t/jV9fV+B4R8EpaUEFiEVaxfFNaDg0aL/phomQ5O
	vZVuPxs4kl0peIvo8Iad+mROcPP0XCqAh/aW0q0a7iWCWtPxgkHTq
X-Received: by 2002:a05:6214:248d:b0:707:5fbf:26d2 with SMTP id 6a1803df08f44-70766d59498mr60197046d6.2.1753898981318;
        Wed, 30 Jul 2025 11:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJt6gobol1sslUNlmAmCuSnfF9g1pOZQ34oC0tL/it58uEDXC0isYw713JWBv+Uf2VQAj2Bg==
X-Received: by 2002:a05:6214:248d:b0:707:5fbf:26d2 with SMTP id 6a1803df08f44-70766d59498mr60196546d6.2.1753898980852;
        Wed, 30 Jul 2025 11:09:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63375a82sm2251205e87.134.2025.07.30.11.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:09:40 -0700 (PDT)
Date: Wed, 30 Jul 2025 21:09:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: tcsrcc-x1e80100: Set the bi_tcxo as parent to
 eDP refclk
Message-ID: <qu54efmofss6247jdnnrsxvuojlf6fyex4h4c5rzrinbtznwin@2vysndddddy6>
References: <20250730-clk-qcom-tcsrcc-x1e80100-parent-edp-refclk-v1-1-7a36ef06e045@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-clk-qcom-tcsrcc-x1e80100-parent-edp-refclk-v1-1-7a36ef06e045@linaro.org>
X-Proofpoint-ORIG-GUID: zfZH130eoMQjdAC_NQjWXYuRT2J0b-Mp
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688a5fe6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wC1PSKU0_OW3W4-qnQoA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zfZH130eoMQjdAC_NQjWXYuRT2J0b-Mp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEzMSBTYWx0ZWRfX8El2tyrVBjHj
 dWbESCEVu17pe4gUq27xxSTPdqvQlLVdbqmWewxMQGeubX9OF+gWx+hHyKHQ80Xy7OUWI6zDeKK
 C3x+0Wepxuj+Q7dgVtF59/zqXwon1YFSkTEC9prDwD0hlnTeFmgY7Qk3VNCQ2wjy271zy7zcYq4
 AiHFScZGW47Ly6RCxS1vVaMddZSUhgfPvoCKCkgtWCPX377Nu7FjFb2OIvL9ME3uk5o2UrpbYtj
 ZrAeY0Zo84Grldxu+UyQCkJafuLD4+yTSskRnXABO6nZoN51/CJTz7vxBo2SQoG+3qeK3GO6vlx
 MSR9Yn4U+VYS9+UptjPYbZgFmdIwxgUsOmK5DmpguonJsvp4ySh7OmY64hqXPD5tjQKm+TsDwGw
 oqUO237MIKAJTJhmuuc48j3XfdZjIgdJ98DdZhEcqEJQ9LCAUkPhFFXn5HlRaLqE587iA8Jt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=584 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300131

On Wed, Jul 30, 2025 at 07:11:12PM +0300, Abel Vesa wrote:
> All the other ref clocks provided by this driver have the bi_tcxo
> as parent. The eDP refclk is the only one without a parent, leading
> to reporting its rate as 0. So set its parent to bi_tcxo, just like
> the rest of the refclks.
> 
> Cc: stable@vger.kernel.org # v6.9
> Fixes: 06aff116199c ("clk: qcom: Add TCSR clock driver for x1e80100")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/tcsrcc-x1e80100.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

