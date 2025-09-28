Return-Path: <linux-kernel+bounces-835237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AE3BA68D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C100C7A1497
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C16299ABF;
	Sun, 28 Sep 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="amJK5il9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3D1DC985
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759040326; cv=none; b=DLYENdRHXArFKeI3q3z66nWH4alOx8fB+vxeRYjL2jhzTBPZ3HUuLdCl9Rx7Ge5uFIBkg7ihg/LotsC5Z/ygSNeLe0B4IsyKU1xmAo0Y0LQxCpLOAoFzQK2kpWZ13DY/ep4FeZODl/1FsJSE5490WQj7agn0nKrtvGOIF1jEbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759040326; c=relaxed/simple;
	bh=Z0F6UJVfn/LlfQdT98ctPIYk0EawlOJ7ctowoPosqNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXsGQwvsBZt2dp6AiCfcS+VPhmtrhEhp2G5oKN88fjJzSxcbCkUFIcvs6A6wAingq1EJQG/sompNTI71vFz5Cw0oPO+6SJy7MomEKMLEa7pWw1MTZf9czszif7Y/qY+8JxUTbLDwOWbD29qft2xgHZ/biuAclF/fRaZRRHj6k8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=amJK5il9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S4WMfm003576
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BSwnv3Xkvl+g0UVXHw8KeGPp
	tPgeAtk4zXgP6spaKt0=; b=amJK5il9ARGFz5jw0o0GJTZ6HiZdmQ1e89a03DfS
	QMoU0c3WRmNzOZV90MqKOQ60Cx7fuh2UX5DoFeOjQHFfI3iOze5RAO5+GCdLmklh
	xaXoLLnnc6QBN3BPyppFR4BFz962DtbOUOwIaQ1V2zKkDL3ur3wHSYDhUJMhlRfH
	eoMI75BRw6YO5gbY4+L2oTYyU43oRh8zfjLPQY//LBXSaPKEt/WRkb+TYs9LwKsm
	qQBMj4mdeRdo/nO0znbOFI3CWZJTbxjbwlak+fag56RLVpjhrQ0NYXjnb2lPDUpU
	37CbQpUXT2l/+tCpZuuoAXEwocAl5aukMlCMt6whg9LH6w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977j1pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:18:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4de53348322so75939701cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 23:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759040315; x=1759645115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSwnv3Xkvl+g0UVXHw8KeGPptPgeAtk4zXgP6spaKt0=;
        b=SqHN1WtAhD0zmWRSoHkYwvgpkYFRh9zYEi2rJHDNJ1Hb3MhDJwLMkLdQwBO9hIevRj
         Fl1AthN534XO9QYrEpQosCmQuYvlnPtKf2SlzeRHE+mxKE0BCBT5yF9GWbJV7sIrZ/hO
         82in/BcqgUMi5UyJ5MXZtI46a+yo0JGBY+hZXTB/earKC+yfZehZzJNv4oJcLcAfJqvy
         p7lL0MDjgBqOEbOqlmpZSt6WQIUVzEnuJUdAElzQ2W/B1aNEoqFp+D8L4Do/vepKuUeT
         Dx/sZ7XXJSX7AEep6hf/An7wcmxkxALHHTQePykYvnMoZoLtA7nzZGiPgsQ1yiSg5y83
         xW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuUZnA43scoRwniZjQBvq38HaYa+FqfDo9qoFFDp7prBmSXCi6uCFSWm/C+jJznJKnxylaEFfrA3fklOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjBoqe6lRjX11dJWRuqSalyoxAdzdRgFU6nx66U7SYpT464RJ
	W4MuARAFp/pM/U1JNwxgpjOXC3j+wfRgMl3ts1S2rnJVxit7KUsvyTxVlT2WMl3d5g1Q/UcGZXC
	ojo7vYbrRhhxsn/NshF/hUiWDJj0GVRb0bqmCd3NHdCfcT4aHIqtv4ntBq0X7Aa0rldg=
X-Gm-Gg: ASbGncsuqryu+jMjFw/K501ELZ0TUhBHltGUi54mW+A2roBbYOjcp1/x5fiMaqMSe7U
	ICTH6pkMopZl7ZRqEbuPffwSLky7r18t+KGivaZHc1ZFbEeXrmg2uhb8DvE61l8lmrSDSUSCyky
	DdeCccWfg8PiUVptoH3xA5g/RyGg4L98DInWf6CxxKIVyloDijT/gFsW7SdA8UXETPlsFkOGLTM
	z3meHc8dNNa9ltodoaijXHqaHW74OqpDEr7wNQziwQoFx5NrLgJXA8lXi2obzGYGn6WZb4XQKTR
	02gwn70mhRczlbaMKgUYX4Po/ZxZU7l7lyZiUnXjfrvJZfl/BK63aE2yZcneqPaf17q0MkZNytS
	aG+XOswWACYKQvV0UjOd4wN8ZAvx63Wf/ruIa1Hjz9XhANybU1rAf
X-Received: by 2002:ac8:5852:0:b0:4b7:9ffb:18a0 with SMTP id d75a77b69052e-4da4cd4a061mr143128921cf.68.1759040315339;
        Sat, 27 Sep 2025 23:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlQdXpq9xf3qMK8rgrvVSaVIarMfdTXA+EGifobgNxufqrTePrHruNxjnW9EJCKUwVIjmgpQ==
X-Received: by 2002:ac8:5852:0:b0:4b7:9ffb:18a0 with SMTP id d75a77b69052e-4da4cd4a061mr143128761cf.68.1759040314888;
        Sat, 27 Sep 2025 23:18:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5854703b06bsm1412296e87.143.2025.09.27.23.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 23:18:33 -0700 (PDT)
Date: Sun, 28 Sep 2025 09:18:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor1@dell.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1-dell-thena: remove dp data-lanes
Message-ID: <kgy2l2lmj6mv3er3nmvvpw44zort5cmhdkkix4oxijfojr4wol@tnxjxnlkum5f>
References: <20250927032240.20759-1-val@packett.cool>
 <b6066559-72f0-4f1d-9134-c93f732fa6dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6066559-72f0-4f1d-9134-c93f732fa6dc@linaro.org>
X-Proofpoint-GUID: wc3jzMHPlfus3oESgAFc1mubYv0u_0y6
X-Proofpoint-ORIG-GUID: wc3jzMHPlfus3oESgAFc1mubYv0u_0y6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX5KBMqc2aIN4h
 t1NssmPAvTKk5kJ2mu5UkDHjTCsHeWCD0H6lWM5kXWipYHA1zKhG4GZ+N7ramJjAkH0/27xncQK
 9op4szj4G3KB4qukNk6FpyhRc4MM+XV9n2WxE/ruqO1nqERt9F5Qi7m1NpnqqvA9wD3eXyI3zxk
 pR3J+IfDyix1jNvqsCVC7tsaH6HYLNniCIiQuLmFdFfj8vfI4xXVSlqqiAvH2EytB71sA2MvCT5
 muBmmisJPrYL/M6m8PGn9ZOV1FUg+cos5JNVr2ZmWsANHnvq9p5PJdx46FWp+OadFGbv5hOzZiG
 +Tx/IKnhieJqTeDMVUFSrZCvOEaDNzX0QcEOX8/Nyw1tHTtaQiAsv8gsz+0CwtrS1pRohhOv14X
 qdkHR0RYTuDJZqj2PHlJ+iMPS9r/UA==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68d8d33c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=9kv6F70430RFdwkcrusA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On Sat, Sep 27, 2025 at 09:59:00AM +0100, Bryan O'Donoghue wrote:
> On 27/09/2025 04:22, Val Packett wrote:
> > The commit that moved data-lanes into the SoC dtsi (458de5842) got merged
> > in parallel with the Thena dtsi (e7733b42) so these lines remained.
> > 
> > Remove them to enable 4-lane DP on the X1E Dell Inspiron/Latitude.
> > 
> > Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
> > Signed-off-by: Val Packett <val@packett.cool>
> > ---
> >   arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> > index d71b67824a99..ef83e87e1b7a 100644
> > --- a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> > @@ -1090,7 +1090,6 @@ &mdss_dp0 {
> >   };
> >   &mdss_dp0_out {
> > -	data-lanes = <0 1>;
> >   	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> >   };
> > @@ -1099,7 +1098,6 @@ &mdss_dp1 {
> >   };
> >   &mdss_dp1_out {
> > -	data-lanes = <0 1>;
> >   	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> >   };
> 
> You should include those commits in the style of below
> 
> commit df8922afc37aa2111ca79a216653a629146763ad
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Sep 18 13:59:15 2025 -0600
> 
>     io_uring/msg_ring: kill alloc_cache for io_kiocb allocations
> 
>     A recent commit:
> 
>     fc582cd26e88 ("io_uring/msg_ring: ensure io_kiocb freeing is deferred
> for RCU")
> 
> With that fixed.

I think that's a bit of the overkill. The usual style is:

The commit 0123abcdef01 ("foo: bar baz abc") has broken this-and-that on
my device.....

> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

-- 
With best wishes
Dmitry

