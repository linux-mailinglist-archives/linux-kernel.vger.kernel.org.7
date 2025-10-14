Return-Path: <linux-kernel+bounces-852348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D05BD8BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B916334EF99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDD52F6176;
	Tue, 14 Oct 2025 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kL1xS8E5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEC2D193C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437405; cv=none; b=LjjC53Day9/Aj8vL5KQCJGpefTVwnlIYEVKY/q3iErFXheFcUycIMQIaLjlYWxTjM1R4EjTgs+4r8cp6/1rsFA/RquwHU74kN1Ul17OSQBbfwKkCBdB9m9JabCXMwuB57tDb3PDSTxjsZbLtsgj5tXvLgjqLnicmc6OY+7JKN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437405; c=relaxed/simple;
	bh=dka1hLAB2FDL4jzoGIfRpvi/9wOSg9e0OUQPD939vAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZTTXepk1I06oBiIHfWccX7hL1C28qBOw4DydV8NTJ+6aog4gTvn9EyIvRPZfEHJWzJZQCPOhYcIeSf3go5hdp1V0FpjNded2bEahynXnXpcAolBxauoDbgh8aL1oauda5gq2mBiYeYjS/W9HEKOQ/FAZwWKwmEr1lvxvZkrHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kL1xS8E5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87GS7018073
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/q6kggVv0I8zQ7jGT2QmEA7M
	QI9ZTL3uoZuqj2yT2cM=; b=kL1xS8E5F3Es/ScguvWjy7ncewgbUzmnaLwzxTTT
	VNVloJ/pWk59upqJNNFE+mKZBL9Ho0Wjx8h96ECdVr21vEHQBFllduAVWyqr1+Tc
	GIFvE6Djg8LoVF1PW1DRhYTrQdIaNoNm4Z4ZcBpvmghtbuBQdm4y7j42tQWerZwL
	LtK6ELPdy8ZIgBmRMOVH15Ok4b4S/p4iKKk9sIuuvBuuZuq9zW8yJvwJWmJsQJaj
	xWij3J+PPAmXAHBd6lT8UhJ2q7VgXrxuUqLWT3mPHJsydFbMDjfz2pqYQwSn8Pqy
	KqwHjPBGv4Yck2jc1//GOLK42IlW8gwIhK9S6OZ8H+KpkA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfes03cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-86df46fa013so3301544985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437402; x=1761042202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q6kggVv0I8zQ7jGT2QmEA7MQI9ZTL3uoZuqj2yT2cM=;
        b=cbp5ceLF4FJFkqfNWbKfQ1tSE5dq2Ba2Am4kgTUsKOZj6yz/Drd7jNlOWDIpEAQNLh
         EMd+BZm77pgSEEZ+g3XEeHEB6ib13GTbpQP52Pwijh3PGSmkECxuYlpKfnV0QBT86QiS
         s2daT1EG9HhBKY0+6S1oS1tYpRvSvD4qIrREAAldgswaTEi0xWZAvNS7mms5J3kx343f
         Nhhn6DnE6kdrwXjgD0H1gyz1VelQH68mozV9b4lWY68eJZcfDxS8UB1LAn2CnD7sAlFM
         0I+9TyJ7dr44Skrm1kmByWHVqVLS/Xjj6yWbjsKdIwECITQBsucuu9rt2i90CU7utTMu
         uBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUWh63CkjOc2urMgYJknIvWZBRAXJ4tnaI5URenfW5eZmJmM4KlZ4kCqSdUTm9QXCgrUtUxbABZkHseVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymXdI5DsMX7x3PktXE28bfcoN03f5VuFpCqwWBMxoTB1ZvVPeX
	i404o2ZoQX47sO+3/lM7y6VXHnisRl96iCFPupa8aRJwIYd0F+kOnssoc7Z7HnN4dGvL8mfB1GD
	gpzsq1MIsp56h42R+czuZuzthgWkAFOqeBcTIOqgQUQsKGY4BOqZ+2S9KfoZdRH2C2z0=
X-Gm-Gg: ASbGncvsQT4szwOO/DBYno0DdUv+ww7vBTg/DekQp9G4M9jCp7htk1Vu6FbVSStudxe
	g/u0LiIM9r7QGdhZAevyYH6R/XNR2tEcQs356eQnzaNby7OFvzF3tmXC41qbKkZgUCn++zbtzQv
	KJtgrkOK14BD6UUSekWemEaCgJqWzf48ZDFSCvxE0YsRJ2Zg7B05m/k1rapyNghMrQAGoQnZvlc
	tmSw7K1X/TXfVYCrMSawfePK1XdglzME+e4Je1b/BtyRZ9cdKVQ2Jq4H+tvgK4NNwr0qTSi4aQX
	byzlJgHV9qcBqK4Sr3UlUD/LbCcwMUed0NZze2uU6DsWzBuPZv1zAr7khoi4U14N+aLbFr0Lpfw
	5AJnG/wrzjpJiX1xIllJeC/jfR0fNd/lLusu006ZKBviQR+cFcRey
X-Received: by 2002:a05:620a:bc5:b0:85f:d78c:579f with SMTP id af79cd13be357-88354019979mr3300404985a.80.1760437402455;
        Tue, 14 Oct 2025 03:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWXH1WiqeKRdg/ZhH41/VhdoA1bJDjANkssxaTXJhlGef6O0WTcMGo77Oq7bI7MfQwSpsR+A==
X-Received: by 2002:a05:620a:bc5:b0:85f:d78c:579f with SMTP id af79cd13be357-88354019979mr3300402785a.80.1760437401998;
        Tue, 14 Oct 2025 03:23:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f92casm5118341e87.43.2025.10.14.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:23:21 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:23:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3 3/3] arm64: dts: qcom: Add missing TCSR ref
 clock to the DP PHYs
Message-ID: <ivigimfa6lp5rbjdw26t5witdpnlghvbnlljc2aspst457hadu@4yuudxoxx26x>
References: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
 <20251014-phy-qcom-edp-add-missing-refclk-v3-3-078be041d06f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-phy-qcom-edp-add-missing-refclk-v3-3-078be041d06f@linaro.org>
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ee249b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=bvtlJ27tT1nIeLj7f_gA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lNke0tLaqbDVpBfSZhM7N104C4Zqh_9m
X-Proofpoint-ORIG-GUID: lNke0tLaqbDVpBfSZhM7N104C4Zqh_9m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0aIwzJ1WNdHr
 VH5PJO5vXUHIu5LiRVIO67CUN3Xi7mwQnTsExBBrhxb5lVyFbkWMX8i+/S6lQaNypJpD6JqlId8
 xhv9vrj3w7ObscjMLDnuMaFs7cKbRnOVCgTAot48nR6B/zZOvHxxQa7GdC0tJaoJQ3JFR5WtSJh
 jKa6zVF1copPPgZ9dJyId7GzAgXf1Ie99VL/EWHEZv/PmXyO5M9kV8Fl0WOJWQbkZHXK7lxvhdl
 I0Vrof/b/DUqYlPXSBdlcBu6sYe64LY7o7dBBdOvKHU8lMQp9NGNmcz0ZnfpTFanBzD5W4SNr59
 GKauVRklf9/fDMvoNbJt+qQjoy3BMZd5uY/oVJakxmrc/LDfoAltSel2AmlaYY4CuSOHU7XgjeL
 tJBBvkKa/CIXmdsf/UzFgoVlriyDvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

On Tue, Oct 14, 2025 at 12:46:05PM +0300, Abel Vesa wrote:
> The DP PHYs on X1E80100 need the ref clock which is provided by the
> TCSR CC.
> 
> The current X Elite devices supported upstream work fine without this
> clock, because the boot firmware leaves this clock enabled. But we should
> not rely on that. Also, even though this change breaks the ABI, it is
> needed in order to make the driver disables this clock along with the
> other ones, for a proper bring-down of the entire PHY.
> 
> So lets attach it to each of the DP PHYs in order to do that.
> 
> Cc: stable@vger.kernel.org # v6.9
> Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

