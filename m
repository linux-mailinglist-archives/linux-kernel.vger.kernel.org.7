Return-Path: <linux-kernel+bounces-818242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F091B58EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFB71BC2D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1B2E0919;
	Tue, 16 Sep 2025 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVa8Sre4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338362DF712
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005846; cv=none; b=MhmYwbzvNRX9sxhjEoQSXkSpyfSsG3f4otHj25sg9+/UiMynY3/yrpk86eGyhWyoo8gCbLynIb2Xm94SHuzEYxCv1rDJprgwHuyhOZ2PAJmp9ZmNW1wbsGAlPlvyUdqOt/TMNmD7GOTnawqPugQyBIUXrsiPUX9lN/7VsEIbLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005846; c=relaxed/simple;
	bh=VJqgGR+I8yQ3u1riqJusgJNxUJc7JbGh1X7CuNzrMz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/uw3ECCzceso07R+7pxZz67jLb3uDv40HM3dyjAVidS7uT6HFLQMk5N5CAeqLJlqf8pWKPmWsj8vDNClITIFVtfqdLEWvl3kg9CjfiJuGVQiT4U5TIrC0c4bWFzCljz0JTjiA/bVGV6hdiz3RfmjKu9ZNj04QkN7ayQyJ+4y/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVa8Sre4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pwpW012753
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yDOD6naCP+XeV3EVxxXgXxWe
	VWa+eq7jpdDsyJP98B4=; b=jVa8Sre4w3lXoBUivmQ6mnN9e46kDSeXxdGBWGa0
	JfG4j+WY/GXv2C/PmWlnx7kJUtfjgSAmr3xOC5jGtMqBSGYhr5RLiXTGyCIxzDb7
	LUpVq94FDMjHLam05wUVqrOmzP5HnM0LSXpA2SEZ/2kLa6RGKB19hMYmSkeNXLIL
	4cPdD/NXIW0k/1p+317qN9PYGdEPSComfwjX9ZQQBDT4dAG3J7iIjEDMNGBt9EVz
	EpSbUNbamEjdNLpGFh/PTZ3Z3fpPWUBpszoFgyCiBkZSPk2uQAdw1d+hhZiKWSO6
	Q5UU2mFtt211TfDLK9C06ESo90+NzfgZ898aWF0K+fbqAQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072qs86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:57:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7761dd1c845so3070890b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758005843; x=1758610643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDOD6naCP+XeV3EVxxXgXxWeVWa+eq7jpdDsyJP98B4=;
        b=usKRosSXfGnM2mywX04z5fQsUycBRgmS+jaGWVMwapJiirHgXRhz3cHMopesRszLvV
         XD+wEDAf/KMP9X3iwa8O+OwAEjuTp8LvkiF/d+mIuFBBjWjiTVNIRJnzl6DUIUseLdC1
         U8G5/gjteHQt0DWguDhSDWjCPQklcRTbHvzLueshcaqp6pXALbCo6UmVHLWDyHwhVJZH
         CFVFtt9FpuVPYOD9/D8GamseAjUIPg4yjB0qhWO8MfpF7OlhEJFGP7qmQs1qfih9VRhF
         x2tPOa6BQYalMgP2+E4j6R2Gz8zXWJ7UrAyGUczTiDkdtVSN5Rxsah5WBDsNgPv3s4Xo
         P/Og==
X-Forwarded-Encrypted: i=1; AJvYcCXPYVe3GR7MFqoZjGlxR+mVHTaAyQx1a6YlX6PCQeyIkJRA8FVaWEAdb0eTVAVBWB6yCC0qnrLGaLbfvWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+Mu77t8nx3BEKilkpO8EbH3Dd6+K3uvVL9IZuDE99+xvHVIa
	Dm63EG7DT8La9JN3BJ7gAY/SgMWHD/PL8fsm7MiyzjHbxmxD+33MDWqjBpS9z2WeWDTEG5RlPsd
	FLCPI1brR3PuZG7FdUVVKs0BdXKQW+gEKKemA3f6MY073LYLBoBPbaXli3en0CuJQnSw=
X-Gm-Gg: ASbGncsp1ckJyXkIcHj2Ca/qncgPkxlMjV+KnY9sBt33ZUb2PC7Gtoa57BBeMwufxAd
	WrD6tc7KxQUib4ZlhuHOzFaxzdT2Aocf1PPIqN97jXw5Y22kbeGOG4aVAUQeflq3Ju5JmvJN7Zz
	uxPH+I8Lsg8m6q9V4yo7gc8JmvdauXa65h1XGynTHhDO/soMLfaqnt8NzC/XT0H3CIgP1NuPvmP
	7Ax5skpCyec0LJ8CTGxHr5UM/YBH909sbypDmvDaQV0kD2isNEwsvlpcD3CaalO0vY8WY8sXQKd
	2XPd5ZYKaZfJm7egeKJTuEthy3L1vTkaGYHfGYfh4za6IyE4mLoipU1KdrxsPSONcfqA
X-Received: by 2002:a17:902:d589:b0:24b:270e:56c5 with SMTP id d9443c01a7336-25d24ca88aemr166330695ad.15.1758005842682;
        Mon, 15 Sep 2025 23:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4HAqsYboh1u5zQJIXFoukFFzA+7Y7eq8ylmhIrbJbC2vY6iiQjqmYMwdKUwYE0LFccwGbPA==
X-Received: by 2002:a17:902:d589:b0:24b:270e:56c5 with SMTP id d9443c01a7336-25d24ca88aemr166330495ad.15.1758005842191;
        Mon, 15 Sep 2025 23:57:22 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-260cf673181sm92629055ad.99.2025.09.15.23.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 23:57:21 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:27:15 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 07/14] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
Message-ID: <aMkKS6m0QEOWz7md@hu-wasimn-hyd.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
 <20250908-lemans-evk-bu-v4-7-5c319c696a7d@oss.qualcomm.com>
 <cb2a5c93-0643-4c6b-a97f-b947c9aad32c@oss.qualcomm.com>
 <8f8df889-3f88-4b9b-a238-16044796d897@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8df889-3f88-4b9b-a238-16044796d897@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX+6yswWkB5kC5
 45sCd+y+TPF2zK0ZJl3VOqcw1hX1QXkk4dL1PvXqdvnSMiD+RdNN3+i4uFs40npdbky9csb49m0
 FJkr4PnT76JEAUbl62lzrdhI7CoNUvf9+FO0zOAHATXbNw/jw+0O5VDM2qgpYo14MX4Lm5+NmnO
 Py8eE2mxnBTgLkBnAYaMWNEeYmHt2jT1xSX4u0/0otLhPSYPeR3sn3sLYxb626jUYjiAvTfAD8B
 YmrlvMx3d9siRzgDeI+xxtpc6ddFXOa/wzgsZQOYKDMal4W8tHwh6jHfyz7waP9OyZ/sHZLaY1w
 DQ8watHLFYvuwllJE4fQcKSi+UVcRKQOVD/JWsOxyDfMnWgJlLcY0hZcli7EGbuGStdHMlDw0GA
 6vVU/Dai
X-Proofpoint-GUID: TFmCJkxgdqadxDsJVscaKXUJJaiD7cIJ
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c90a54 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=aPFnfdsyqS22SUcEH6cA:9 a=CjuIK1q_8ugA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: TFmCJkxgdqadxDsJVscaKXUJJaiD7cIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Mon, Sep 15, 2025 at 04:03:14PM +0530, Sushrut Shree Trivedi wrote:
> 
> On 9/12/2025 5:57 PM, Konrad Dybcio wrote:
> > On 9/8/25 10:19 AM, Wasim Nazir wrote:
> > > From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > 
> > > Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> > > 
> > > PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> > > attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> > > 
> > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > [...]
> > 
> > > +		perst-pins {
> > > +			pins = "gpio2";
> > > +			function = "gpio";
> > > +			drive-strength = <2>;
> > > +			bias-pull-down;
> > > +		};
> > Pulling down an active-low pin is a bad idea
> 
> Ack, we should do pull up.
> we took reference from the previous targets which seems to be wrong.
> we will make it pull up.
> 
> Bjorn,
> can you make this change while applying or shall we send new series.
> 

Let me send another series with this change, rebasing on top of audio
change that is part of next.

-- 
Regards,
Wasim

