Return-Path: <linux-kernel+bounces-834149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726ECBA4080
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6343252C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7452F6581;
	Fri, 26 Sep 2025 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LT6uGOFX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AC1A76DE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895554; cv=none; b=EuylvrVof5uHZj0VbHeOg+DVwE41lHMN2M0kxLxjSlTu1EEFmKixZhKkTnd34cwN48FTg72SRNKCwis4Zy+RHuKkKZ0HhVOo0GzvwUoABlEQx7HHOqH6SPvRluKpbEj9bb7YLs+kIR5mNFv+RSuGc6Y1gmTAPIGmUzsvMM9e6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895554; c=relaxed/simple;
	bh=h8O3JMj2Nf43sk9ATCze+ZZOkp/rooCR8t3VS+9ryNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJZpOkJSfcQEMI9XVD6UZ2kpL2G/ejDxI8h7siRPkuCiG0VGTtq5rmthX6N4g4TW/VfyljgeXLIMGMTSq/SXDojRGaEDkEZ0FoFq1dcwfany6keh8iTHOTBDhUuFhXj3qYUcfW7nlPnxnj4B9TCnuEY0fZ1ceiUJFl0e1lU9Hk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LT6uGOFX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8ve9a002689
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=584nrbDAdLBURaO0cgXzCKXy
	eOmRtZu/VSbhHT0wC+M=; b=LT6uGOFX0SR1QZQJx9bkXdGg/dXzjHdSfKJWmOwi
	ljGQn5xCogB1rQaZbF7TQjvv7rqySxM4f8vz4W6EG0xvvsZZrHZ9+SGW+CAxZouq
	jbIx+2yFc+TajvJYxuLkLkwq2r4AlML6lXHXq58vVNXIwulwRXy8K3dcrc5kAXs+
	bOSMYW4IoVT3BYgfwM5/aIuqPlfz5yfZrMNrlcqI/0JNMYRVd5jjoTX9FyXjEvgw
	+Ffqrkn8clA6GSCPx8HXzIAiH3F9NFhxq/nq6j4rNwCSs7yAO6X9WiITkQYpY45h
	lu4DSs0+DyP9uSx+QdYxo91+dHCp/jQYgSKX+pR25euFjA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u32m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:05:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4de5fe839aeso9087171cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758895545; x=1759500345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=584nrbDAdLBURaO0cgXzCKXyeOmRtZu/VSbhHT0wC+M=;
        b=aMyPeSAaD0KohuMz/qIzGlbtk/ugxd1YyIuwEFZIlDOzFEFRKmzSy0t5rD85+SFnbU
         NQ0FBesdHVkSGzr4ya8Z8eAGbaagtzgOIwIbmtwJUPiaiazOhlMWE1upo3Gl7JM1c9Eb
         ZZ90rLE9jl0vQJvhFv41Hps/b0EVnIv6nBJTBXC+tubd7LEipJl+pIvPcrWTiktmvTpY
         6C59s3NAolhI9wUubUzvZM71dhUyiaGfBWblaEphJHw78FfJvoRKsUrl96TD7Q5MhzfS
         zPD1mfv5E8opzjoU+dV/7+sb0E2DUsP7ONshq+ZGsAP/zYC9iUY+65Y1Cmf0uoIiH865
         E10A==
X-Forwarded-Encrypted: i=1; AJvYcCWy7pWcLL3YrtFHijr+ixNK6zU6ALcjAzvO6ktBzMxAe5ltpY3VVWixlxYBFjtHiPyHHT/K1suftHA5MX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAJ/YWLOpJBRwH1dAP7J7gHEVGB1qp6GShP5zznwCmE4Xio2i
	5V6I+wWyIOM4oBSv7WPL37iXNRW4v5ZYuu//PKGYXLzPzn6th7bwSJht32xfpUmHEjGh6oi4R+z
	0A4SkGzRajnCqma3kQbLKmaMur2U+pCZM2b7vnHnZm9tleA9/GgPlBhm0W1t4jwnlxqw=
X-Gm-Gg: ASbGncuqkeuI1KfVpJOA/11xHSrRQU+BWp24IPRYtm9TTQz7YLmDYtUWFRSfhixEfhs
	rZ07EvjTn+nH0aaVzZ3WGYMfPe49x/nJdasMnOMTN//BImeapBNNMgfGcsr79tOL2rZwMGWYYBS
	Rxu12v3iFzsh3Z6FvVnmBnfTRYSCmcyrePSd/YunKJoMb/3x+xD1t1LbfkwC2jWrXm729nLQmMO
	Af7a8YtfHpRy1ROiLYEOkzdbFj8eLgGs9rxFF/v9J3LdxmiV9Yv01UGBb3Jg44an3gdc11qFeR0
	sTVOG3NzzLuDmVv5hDbRUmJvh5Sxx0F9ob4ck8N67XKHQnS2fV+7lDS82G70pULtutB0+gP2u0x
	LmKIRwHw/mRTDwzARAXp7DYT65N8IWA084xEIGqo+ADoiLUaKwjc0
X-Received: by 2002:a05:622a:768f:b0:4db:dd57:e093 with SMTP id d75a77b69052e-4dbdd57fb69mr58371571cf.51.1758895544719;
        Fri, 26 Sep 2025 07:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHltJA6GbWIV/+igvGWnl22Iv/P1bx9gnuRDpBgQL59uVz2fnVyjK+CDBIlVIjHHYtcOin3WA==
X-Received: by 2002:a05:622a:768f:b0:4db:dd57:e093 with SMTP id d75a77b69052e-4dbdd57fb69mr58370611cf.51.1758895543827;
        Fri, 26 Sep 2025 07:05:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7710256sm12274671fa.45.2025.09.26.07.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:05:42 -0700 (PDT)
Date: Fri, 26 Sep 2025 17:05:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qcs8300: add Display Serial
 Interface device nodes
Message-ID: <5irzdmwxs2j4ppti35hc5235yxqq576doerrrk6fhcpj7f726a@eh5rl2jwb5kg>
References: <20250925053602.4105329-1-quic_amakhija@quicinc.com>
 <20250925053602.4105329-3-quic_amakhija@quicinc.com>
 <vsty7sy7gi2eeyifokwcqpoycmarxietkijmlkymwrmzmdsfws@x64f4ulbc6ja>
 <8c248bf8-2f25-443d-a08f-6504c349b72b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c248bf8-2f25-443d-a08f-6504c349b72b@quicinc.com>
X-Proofpoint-GUID: ExPhBbgnGg4mUTpVapllTBYEB90yyafD
X-Authority-Analysis: v=2.4 cv=PYXyRyhd c=1 sm=1 tr=0 ts=68d69db9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=fWuQbBWbtaeYDtlrs1EA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXxSJQsx6lQuMt
 c2l6CBIDZF4yFG6Ew/2rqmEsg19J1yloejLCdzDplj+C3xoevSFxlgPzoLyt3uGDBc/SaKZEDO+
 2RBTf3vcJtqYezIMJ0WK2eRwRHrzkPJ2+Ca2mkYRx04tXjiaazTwvjxRS17Fh0LCqKL+iVR1/NI
 V07GH9SSJ85XChItGONtYIpyBGTybPLEXrW++jgXfOs3kLqf4oQRSayk0UBcc5rvRWYFZNe5Z0r
 7EgA/WudB4oX/qmaK7BbkMeACg8vlUTFgtdCU9bTBDi4nrWF5mRFpZZpwvOklBGndUlYqLN4Dso
 0e8QZ5CobWedvD5igTokN+b6o4reMvJVeY4hPILsHplqesBWXKQP74nZT118EE1TLCchEB5hR3G
 0kVTw4FDm18LdJ+1ZS7vjgeSnOm6Ww==
X-Proofpoint-ORIG-GUID: ExPhBbgnGg4mUTpVapllTBYEB90yyafD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Fri, Sep 26, 2025 at 02:55:19PM +0530, Ayushi Makhija wrote:
> On 9/26/2025 3:32 AM, Dmitry Baryshkov wrote:
> > On Thu, Sep 25, 2025 at 11:06:01AM +0530, Ayushi Makhija wrote:
> >> Add device tree nodes for the DSI0 controller with their corresponding
> >> PHY found on Qualcomm QCS8300 SoC.
> >>
> >> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 95 ++++++++++++++++++++++++++-
> >>  1 file changed, 94 insertions(+), 1 deletion(-)
> >>
> >> +
> >> +			mdss_dsi0_phy: phy@ae94400 {
> >> +				compatible = "qcom,sa8775p-dsi-phy-5nm";
> > 
> > Add qcs8300-specific compatible and use sa8775p as a fallback
> > 
> 
> Hi Dmitry,
> 
> I have one doubt, even though the ctrl and phy versions for sa8775p(LeMans) and qcs8300(Monaco) are same.
> Why can't we use the same compatible string that we have used for LeMans ctrl and phy ? what is the need to define a separate
> compatible string for monaco ctrl and phy ?

Konrad responded with the reason. But also, this question should have
been asked when you took a first look at the qcom,qcs8300-mdss.yaml.
It has two compats for DPU, DP and eDP PHY blocks (for exactly the same
reason).

-- 
With best wishes
Dmitry

