Return-Path: <linux-kernel+bounces-747145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73EB1304C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 987697A8D16
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FD21C177;
	Sun, 27 Jul 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldZrEYD8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC520B803
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753632740; cv=none; b=bWmZiWXlZj4RT5+WwuseIADgemIKK1QZvNAVKrcI6EpvDZ7s+kSqTH3rG0nU2RNGz2XIVs2cWzQy/y2HGzKLXd5f3uqfvQJCTykpMj9iRyQde1A07l3NrLxCudapAoixSGiwwSXI2sTp/9U4P6AHgfapJ4Jr01Hr29lTe22+6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753632740; c=relaxed/simple;
	bh=RjNfiA81APDV4IT96AI7K1pjVGVOyfYFfry+faPEv90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+IHAABDEGLKSb+kl03sXwH8nBrjLBDcAju0m2vHXXkFBzZSdWhXo1HEaavPGDIHc2nV9Quqv/7BvX40/43zwTm411//mgPuKdtlqqTsbPpiqEFV3rgfuXt+rcqXrLoQeP7Rz6Ja36m5EX9UJAfRYFomeTiIB7T0sVdFTV79Y8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldZrEYD8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RCpvVZ029754
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=685vHDCtSGola1yY0CRVxCW3
	5uOqefWBiVFuzxBF1M8=; b=ldZrEYD8G3pn1c56jmZ2X5Fs48V+E/a7JXZSmxWN
	RutyLLaPFcJqhoe1a+DhgFqSAVQ3J8fZ3qY+5p9sFueyqPldAXTZiu9CPZ3GRN1V
	64c75QfcLE4nV2oRXbAn/3ZAGm1Qdra9cAXGHIUJ5sSxvcrySi/U9U54EvODa5nd
	z33uNCDZUDlgDeQizrcWfrJ8bGXTo/13c1UgjWx/OF/cORy1OT79TAw6R/fms43t
	yZiJLZEWdqOKN/p272DUhpdd+eNLl0GIugArMQGVFz+v5mIcUfH+yJkHsTjiYdID
	dpyZRUDb691/hXCwjbjSxLFavNRMo2MOITsZ3vd9kAo3hQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484racj93m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:12:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70747c020daso4217926d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753632729; x=1754237529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=685vHDCtSGola1yY0CRVxCW35uOqefWBiVFuzxBF1M8=;
        b=H5gSAWsxiiG3HL4VRw2xt0m1yWHuM9bXxYpIaxdSfhh0Rt1Emy6KRgkJjX/pxP7W88
         uzMwbXzO5gJy2ArjKuAVn/W2qxmZlSHWTTv98p2HqYRShqE4F+Uu6POmbyEAK40M5i3w
         xS9ZkTTFR/Q6kQd/w8VeXwLyMuafD/uyuJyI3tZJtzpbM+oLnZjumWSSVfPwGTv50X4W
         RTjKp7eOqv3yOdRS3goGcelzctw4jo6jim1IcZjbnXOoYn45CvxwkT1jv1vvF0hUKzfn
         oJsQL7ewWdsKovOCDQEqvf0K0L40wasVrdrhOE8AmTjvhX44KasQOMudUlMSeJplRTJ8
         1yQA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Zt64QTfqKKqbwCXtENOioxMlNXMSgsSlDPmlc5bXiAO+zDp9i5FATMdO0WHnpWm0YCXAeJxHg1XS3jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6TLNrjIjMcUaqtHxTo+gfPFTtPes4+ZKwJYLbdd4DGnNT4Qro
	NQNYZnH13rxYVhfaDy24FYDZ9VjvvKdBPZkO1IlRnst9LcGNSa8kQ+kSa8+7KX5bl4yjNDZJwRd
	10Nsy5xONZPsCb6D2BccU6yT88lo3fitf9cm52HF4e9D6L6AC392ANMCvCsZrpwO5Xs4=
X-Gm-Gg: ASbGncu8/yGFUn1rEI3fgf/PzlzJi57V1p3+/fhPOTiVJH/Jq7hQCd1WowHYNae1bnj
	kuYqrRR6cl0gNylB+B7e9NpfED6xV+aRh9Rz8BeQUauQFhqshPhiBMGiakuULlUSBr2viVrpMfk
	Ji5QygYvmD3eqPTFvGYoD0fhS2JKi/ej2P0BxDRASgMRMl2s0gyf5uRRVTIsDhJtUTUECfKZ/sr
	aWyBLDUTGbCzY/xepyVqXjn4Th9D1UULreFa5ApU1gdjJnXajvwNqpiOc+VzNDhJBMp8SXamEt4
	rntj3LTibVuK9kzniipVm1DPtpDfWYr4eNsT+zJDwYp+AxSWFd4PRlPi4SVj93YplIwIV3Vahg/
	KVuMi8/7RusjaKZhslsch++GHGd+7dBhKgbFEaPbNP3UDhMpXsmgx
X-Received: by 2002:ad4:596f:0:b0:706:f190:f2ec with SMTP id 6a1803df08f44-70713d9c3b0mr193045836d6.19.1753632728965;
        Sun, 27 Jul 2025 09:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrgOtZO/BrhsYDwqI7MpuwYvF38Y6kA2ThfIBA0C1aFDjGfvO0v6UznSa+ysUHy7ifVbV1JQ==
X-Received: by 2002:ad4:596f:0:b0:706:f190:f2ec with SMTP id 6a1803df08f44-70713d9c3b0mr193045336d6.19.1753632728412;
        Sun, 27 Jul 2025 09:12:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f407b4b3sm8601681fa.13.2025.07.27.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:12:05 -0700 (PDT)
Date: Sun, 27 Jul 2025 19:12:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, srini@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slimbus: qcom: remove unused qcom controller driver
Message-ID: <6f43g2ywh26olthehlxmstnzfb3rrd3gavyzvmuad44w6bzvhk@vuphps5i577a>
References: <20250724132808.101351-1-srinivas.kandagatla@oss.qualcomm.com>
 <276b7977-45d9-4b37-a4f5-1c65802ac267@oss.qualcomm.com>
 <mwhxikivaxtz5px5e7jkqtuuk2iz457fy5drsnaj32j4o5qqk6@hwkcjso4jpsp>
 <8b3abd1a-4246-485c-9f2b-63ee37ef808c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b3abd1a-4246-485c-9f2b-63ee37ef808c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=WqsrMcfv c=1 sm=1 tr=0 ts=68864fda cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=hECnEToTbSFRC2ly_LMA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: WF-yr4hqgi2oC9Bj3unYuBT1nUDLsmYF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NCBTYWx0ZWRfX/4rxZuByNpkr
 y4aPrBxLgw3HuJXDpy4DBViiM0A/Fp6PkE6NTEkucjGZwCHZ1HycvQd2+nvWhIGSJ7c/efn0Fba
 X6olU66nrlT5ZBybDR9Yc6EBWnnPXAETwmmPWiSHx4SyRZqrzD3SZwuy8BZVhqY5J/LgcNYoETm
 YirKzUkqoubh3tPNQACpHPbv6p9V75Ol+ARM6EqYQfx7EZQ+6Z9zb5TP+6nPWe3UZxMyDH4494+
 fYAbD7N04y1nkDqaqwaSm9NHLmXADb/M7k2eklWimiAFczzo2GC8KYOr5Fz89xLH2Xp0dn/u0Rq
 ng9p0Pex6qE8yWFcz2jBTNaIhZUaRA7KvZWi/oz5h5rs/JTqe1Se7fFvjtuxoITQMppg96tgiGH
 RdMwFCI/45gLdNVJbAiaZl2uUzXGZ76VrP+cyMzCFOfcoZVkVE8iYPnX1Hz82SuI7XA1ogG8
X-Proofpoint-ORIG-GUID: WF-yr4hqgi2oC9Bj3unYuBT1nUDLsmYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=823 impostorscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270144

On Sun, Jul 27, 2025 at 12:25:12PM +0100, Srinivas Kandagatla wrote:
> On 7/24/25 3:24 PM, Dmitry Baryshkov wrote:
> > On Thu, Jul 24, 2025 at 03:31:50PM +0200, Konrad Dybcio wrote:
> >> On 7/24/25 3:28 PM, srinivas.kandagatla@oss.qualcomm.com wrote:
> >>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> >>>
> >>> Qcom Slimbus controller driver is totally unused and dead code, there is
> >>> no point in keeping this driver in the kernel without users.
> >>>
> >>> This patch removes the driver along with device tree bindings.
> >>>
> >>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> >>> ---
> >>
> >> I *thiiink* this is apq806x code, with 8974 adopting the new hw.
> >>
> >> +Dmitry, does you computer history museum require this driver?
> > 
> > I never had time to try enabling audio on IFC6410 nor Nexus 7. But if
> > the driver would be actually useable there, I'd prefer to keep it.
> TBH, I have never verified this in full audio use case in any of the
> qcom platforms. This driver has been unused since it was originally
> added in 2017. AFAIU, no one is using this lets remove this now, Am
> happy to take it back if someone has managed to test this.


Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

