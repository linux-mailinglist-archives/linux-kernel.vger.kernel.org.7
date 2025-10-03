Return-Path: <linux-kernel+bounces-841721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB6DBB8127
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F814C68BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2B423A994;
	Fri,  3 Oct 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctDr/41q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B922B8BD
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522472; cv=none; b=cRxVNo481vYBuQCguqvAKdFb+BAp+f2EcDcoylLdSKEEZFdjEvbrDC9vuWqJa27H8iQbXNMmcybDvvmMA7TSWdvTo79fh6+MAXJQ9cUZnNoozd9mbyRVJtuYj2ZEBJ+c9v0xMTwIBkEro2KFyoRr5v9L0KdMtdJMb1eBJOCo/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522472; c=relaxed/simple;
	bh=fD8n54ZX9M0RRQRWUXO3tmRnzc0ewZjTWlfVmwaUwfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB8AU9HgYcWDLUcO8s5HBWQkBOmtxh62DWNyZHnnQh7340IMKcN7CfbxUbdDsBy4MqWq/urU4FeecuklzvvriWUGoik9xbNvWq1k2DbpzAztn0J02azVKnihaVgg4KCJsZoVJFTh4AAp4m+JtiVl1Xfdbr99BHezNvqZ0dBwuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ctDr/41q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593CGYEx015210
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 20:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3d9SzCzSMJIBbQowA9w6QpPw
	22iAr4U27ZeiUZsWKrA=; b=ctDr/41q1epOH8JmCATKNMFwBQJA361qEiMbkHGK
	Vu+8JQ3OS9BLn7HIKjNVx3K45tPXip9z2SKTlASdb69+mpI0zQEeuZ9+BP+1J75f
	JPc1phAtYdf+uAGL48vI0aJEl+d7LIteaJHTzoNyzBN//KgHtIMZ/PzhLalDrOxA
	PsysQPT6TtqgrLmC9D1xSjA4kFm/1xFTAao897ajXeC0LiJRQHT6z/T9Sme+H4M/
	VPhD/POypn3o8R/h3W83hZ9E4MZwdWsOqcjTApMk6JGM05iCntwrgXmfRtvLYFA4
	f9ANutiIlJ0c/4v2KvMpM5gwKAXTebEM4X3UxzImI/thfw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jeb7h4se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 20:14:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ddc5a484c9so67770381cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759522469; x=1760127269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d9SzCzSMJIBbQowA9w6QpPw22iAr4U27ZeiUZsWKrA=;
        b=CocMSxBYuAKV2/Q6yLRLkD59nahe3nx3xOc5xR0rJCjruukPTexJw3Y5e2NQrOP2Di
         vhO2Ty7ffBsunE1JRhtoI46wyeP+D34AjL8b3IO859hxOEsjF0E5e2fMe16W9Dgrg6rc
         GAL921ODsj4T5Ufq61l1/o5zO7+mJnG3NNg/tayCoIWjFNovw+0bEOLpatzX3pWhG7gm
         KSHD2ZuTdw6Iyfb1gO7cGSH9/aCcaSYpEmmVYLBSw1nK9OFQOwmzJs1ECFNT04bSA6wU
         7R0FYSqnxB9NGFPQ5xdf8i26a1I0yK2NRnAcw1YEEqSjyfGZExpHmyAKTZhdKRk5tX/0
         6aPg==
X-Forwarded-Encrypted: i=1; AJvYcCUw2oMv55m9Z/hPAPWlNMqEQPdb4drBQ0cQNOkA4cL0ZC3jtmG6BJ/M3yhN4vuYtrGFmDn4c54U86cSuJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCmuau8F4TSpAvLdTsQVpN/W+P4TwswnNq1pwxEYaAj6y1L0Q
	RK59Q4UmAlkyf9IJe6tib0/i7OIFZxyWGcEAanUiFIWVO3I8ESFBZ5VNbLnqEzMFhkz/Z/Ce0Ts
	A1cn58E17ssH9h9DROXZ7TRX7lbAYzpa9Uzoyj71Zd4X8ckFkHBrj1KnPIedn1c6TTA8=
X-Gm-Gg: ASbGncsv1TiQKBj5SfGkGqP92nC7/SAL3sQywkMGQ2/EpSMjVkMl8fU2ahIjTuUMDzy
	a8D5JIIqGMa8BvxtTlvOEiXnfacO4AJDWp7gFdE0HOqt+rlcoKjgCgkO/82bulbjjzqF1H5Z6s+
	yHwkhdfyNeynDYEdS4sKjIQjp51WMMo9J34LYtfXQJWZBauXsK/tj+kCc4Oou5bZoVAs0b7JhAD
	PpZ37PZcX6g8ofbQIeGpnHBWb+L0Q+lvMJxDvWGLVOOrMllgh5mi12heADIGBDg7yEFpFJLRely
	6GwIFJ4hClZuSeB0CX2WEmjVChU14j7Xgzbl94yo0a26xSozkTv1qy86z/2W0aV7NgPFZC48XqX
	++9958ek3fjTSDT9o0IB4s1+XcQmD4w1Kxxc89Ryds8Yxhh1wZrU7XQgMAA==
X-Received: by 2002:a05:622a:1482:b0:4df:1196:f56f with SMTP id d75a77b69052e-4e576b43357mr58964051cf.83.1759522469168;
        Fri, 03 Oct 2025 13:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqQgFtCLDGX+O3PJbNb1GIypKvYOnVxRVaWG1pkNYoNTcWC/bmJvu3v1drdtBBMjl3H1gE3g==
X-Received: by 2002:a05:622a:1482:b0:4df:1196:f56f with SMTP id d75a77b69052e-4e576b43357mr58963591cf.83.1759522468538;
        Fri, 03 Oct 2025 13:14:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba2b79e9sm18024371fa.16.2025.10.03.13.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 13:14:27 -0700 (PDT)
Date: Fri, 3 Oct 2025 23:14:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v3 07/11] arm64: dts: qcom: sdm845-lg-{common, judyln}:
 Add wifi node
Message-ID: <wudkpzky5sqrhqjfm3utrd2tcmtalszmyw3zts246pop4a7aj5@oro2wyqhtwaw>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-7-b14cf9e9a928@postmarketos.org>
 <f58493a9-6def-4610-9c3e-d6a877dc23d3@oss.qualcomm.com>
 <d38801bc77ad00442b1669ea252ae30a5c6af5b4@postmarketos.org>
 <7661d9d9-eca3-4708-8162-960df0d7f6c7@oss.qualcomm.com>
 <ad721948b83a54eaa34f367e12564fe6acc222a1@postmarketos.org>
 <gfbvgsen75w5h7afyo454pvdfslkeprqyuycuok6syinbza7vx@crapzdo33re7>
 <b9285a2e81ca992b9fc560c78ae03921000e388e@postmarketos.org>
 <budxy3xza3ieykmrp2anpiz3gktq6mc3pqohkf6ew23jun3po3@jv2em5mmhjts>
 <4db4f0d411cb250db2d513690c93f0ff5a6dcbd9@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db4f0d411cb250db2d513690c93f0ff5a6dcbd9@postmarketos.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDA5OSBTYWx0ZWRfX9QfIandltbDN
 gNPkQhrOnpwhK12Ri9wQjsu2d78iEtPYlc4DZg3IXtMB2oNLxJgCHDL46a8OSNV21JhP0Z42UYu
 xUdI8xPuVNB1ft91mzM9+9QNnvASu5Zq0VksHW2zKfm2cEpBO5blw2tVYWrZ+rBn/w/RkC1FyVk
 5ZUuti8rR3KnhK/ZjJRneMlW/ATKhec+xaOmlDAtM4BoUiPgmTzeE677yT/oc5zXMntXSU3clzJ
 T0mzBd+d3Y/aSSQwtx1ao/WuzY3Fk54L649w6tL3u/YusEpkTNSXoGaihlZESZo0iSFmLKDoxsH
 AapR3ZwIhbiIanynAVCBptZ+Pd9Etn/rHgjwr0KjVztumMeydgIWubijP8PdPE0J1CAGgmORIVk
 oTxCJzyW0Nk31eop0jaomrB9I2/tXQ==
X-Proofpoint-GUID: QAsTVmPeEFLMNM0SvFHeeLss8xoFGJ4F
X-Proofpoint-ORIG-GUID: QAsTVmPeEFLMNM0SvFHeeLss8xoFGJ4F
X-Authority-Analysis: v=2.4 cv=YrwChoYX c=1 sm=1 tr=0 ts=68e02ea6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=p0WdMEafAAAA:8 a=85DtlbXH99wPiBcwuMQA:9
 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510030099

On Fri, Oct 03, 2025 at 07:55:21PM +0000, Paul Sajna wrote:
> October 3, 2025 at 7:36 PM, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com mailto:dmitry.baryshkov@oss.qualcomm.com?to=%22Dmitry%20Baryshkov%22%20%3Cdmitry.baryshkov%40oss.qualcomm.com%3E > wrote:
> 
> 
> > 
> > On Fri, Oct 03, 2025 at 06:52:03PM +0000, Paul Sajna wrote:
> > 
> > > 
> > > October 3, 2025 at 5:13 PM, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com mailto:dmitry.baryshkov@oss.qualcomm.com?to=%22Dmitry%20Baryshkov%22%20%3Cdmitry.baryshkov%40oss.qualcomm.com%3E > wrote:
> > >  
> > >  
> > >  
> > >  Regarding the MDSS. Is it being solved by adding reset to the MDSS node?
> > >  Or are there any other issues?
> > >  
> > >  Yes I'm referring to the reset / pmdomain issue. Joel Selvaraj is looking into it in the sdm845 tree. He said he tried doing what other SOCs did and it just got stuck in a reboot loop. More investigation required. Currently he's reverted the pmdomain commits in our tree.
> > > 
> > Which pmdomain commits?
> > 
> > -- 
> > With best wishes
> > Dmitry
> >
> 
> https://gitlab.com/sdm845-mainline/linux/-/commit/002ebddd695a53999550e241b71950f1aa0e1ac4
> https://gitlab.com/sdm845-mainline/linux/-/commit/09813cde376d9d8f30eaf761534532101a0a7755
> https://gitlab.com/sdm845-mainline/linux/-/commit/0e789b491ba04c31de5c71249487593e386baa67
> https://gitlab.com/sdm845-mainline/linux/-/commit/13a4b7fb62600e1c0738fdb0b7176555ff05aadf

Thanks for the pointers.

> 
> All got reverted in the sdm845-mainline tree, I believe related to fixing mdss
> https://gitlab.com/sdm845-mainline/linux/-/commits/sdm845%2F6.17-wip

-- 
With best wishes
Dmitry

