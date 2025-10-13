Return-Path: <linux-kernel+bounces-850510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14885BD3055
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C908D3AB146
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181F27144E;
	Mon, 13 Oct 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ibG1wdZh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C69262FCB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359240; cv=none; b=IMmDeDsw73iHRG6IYTWAGHN4SF5G2WglYjsvym6mkm3HtYvCGfPfoDtobhEkaAf/DVr+wGqWUl1sI0XW/LHLbu5Ch+UpNb0ZyXRBsOuzNe4qkULd5rhw97hfZFOyVGFVRzM1XRgijcDwZXNuOvPT579lGDEene1CJEvhYmuQuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359240; c=relaxed/simple;
	bh=dZx1FG/WcIlbQOgcXxuWDW5+YDqYBZQhGx5Hx6dPiIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8dK9hECOh2go5qi3WognCHszKbiBUJV4ldQ3FWYfdfWzjtGLu1eVZKnlHX6jHPl4dU+Ob4vDgxdkachSC0a3R9bdGiqkRteb4bduAEjjlDx91Rn/Zw3gpjgZIWquiuT89Dq7jJTImPtHfN8PyBrh2WkcvIgtUS3jZAja2aU480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ibG1wdZh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAq5T6010423
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f6scyOM+ahva9+uwhw48pxSb
	yDQ+LPEwq5/UOfcG8bo=; b=ibG1wdZh8jBFjAAr/HF2MKezLDCDoQs9U+AgU1E+
	gsv1WjshXlYEN9CVA1E5jrdrhhJ6K7/zPyVZqvMENNAU/tCyIKuRxCus6Jc5tetA
	a6rPPK+TO2BnfR38pazxRS7lrCik4W5lChA57gij0xGAxeev/Yl1GjWFyr9HS0nR
	l2fHx/xpO+WjXOHdNhSY1nFy8+H6qGYESv19zRsJl63y/BExMozlu7ORp7RC9c4l
	siWH/7eZgiUEdQnb/G4twJJ4YbPKpXQ0MOFG0iJRvYn+xVIVfDBB/ZAX74srez0Z
	OSrcURx02nSd3it8vowRjjgF1swAg2wZTvtQ1POWLIVZdw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0bvgrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:40:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-859e412f2c9so1839596285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359235; x=1760964035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6scyOM+ahva9+uwhw48pxSbyDQ+LPEwq5/UOfcG8bo=;
        b=YTBz/s5h8L1jJCvqQ/3TC/BOm6DM/v2SizK5pnACP8roqMLeN+FzldSjPvq7n//q7b
         E34UkmHFL6SocbVnc1oTG1kKU7mKE5nNxlGPktWsuktbD4cTTztoLhbIa48s6rZ2f0/V
         44OTcseK+wZEW/MhF6D1fyzfCRb6XIe4WTYSSlL6cP79ganO30LcGu99jh47j0nlxJaR
         95X2IN59UG+957MT5xM8uokkorfVdlNfg9zyBR6Lfnd2FNdmjtC+WaYMwdDH7eHU5gj4
         LsOpiAuadMZh6LbNZemuvpBq4RlsKrfdSAlXjsZm4HkYoDMIzJTiNffduKGNECiQ8XXJ
         TMbw==
X-Forwarded-Encrypted: i=1; AJvYcCVaREYI5II4niIDlhaMd/wgeMCXVnNOdSi5zbnlMuSazIhxlT0Q88ZRmh8H9tfKyUHLVL8g7gg6qW2lsGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9CKvhyOQpTQn4v1+7rrnultR7vg19DtUu6h6b+ScfngxpGO+
	RJSz262RNOlDMqsFqzKK80rC0vD7UbhOYdeyJETs2qp5owMav8x38yaCVfXZX1CkentRWRyjbPO
	rSuFg37aYvrbyEDBok2LHkHk5zzWf0rOpS1otEdy5BGC562DnlXVsnA6+aPycVNxaBp0=
X-Gm-Gg: ASbGncuA0UsIJh62+7ivvGAve/tyOGJTBzoQHPuqdGS5+mMmqcBqMTgNZ/uKkeP63l3
	9rOOFqb3omiquduBam4aCZfxfxGj5o2iQNOE9SC064FLAUaEUO37azsz8BfwiiYm4srvdZKL0az
	1MnAO1QIGf2vbV0rRSkyI1vPrUsQGc9WCkn57GB9tqkOWL+8Fl1ECJ5nPb/moaWEl2fQ+ZrT9dJ
	EA89nru06zf8MmkbDVP3vOhlBsvpMhv+dScguPB8GuenuXs5R1/g8EHCI7bYSAku9K1Eb5AUHjH
	VAn32DapRROJqG0eFov/dhBiSgfSsKnvsGf9nEmMQDi3okWd+WuwZMp+r6rO6lEQf7THbg0Smfs
	Pai0waGqBqCFUbnwtB1Bjn5EvHtlPeq8L+qB8tsS+v2mr7mmiz/yz
X-Received: by 2002:a05:620a:458c:b0:868:54ba:7c42 with SMTP id af79cd13be357-88352f83d61mr2871642385a.25.1760359235471;
        Mon, 13 Oct 2025 05:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkvZQ+8ZJnIwC2hIgs/DILNFhHouXWRCw0k5tWWtya0oIkN3txK/mV8/TSZwSq7k0H8FX0lg==
X-Received: by 2002:a05:620a:458c:b0:868:54ba:7c42 with SMTP id af79cd13be357-88352f83d61mr2871637585a.25.1760359234973;
        Mon, 13 Oct 2025 05:40:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908857792dsm4081471e87.105.2025.10.13.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:40:34 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:40:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 3/6] phy: qcom-qmp: qserdes-txrx: Add QMP PCIe PHY
 v8-specific register offsets
Message-ID: <x2443gg3bj37j7qxjk3ocol4xzcly2vandob5j46bp5c6akqb3@zgwrl7qhl2y6>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
 <20250924-knp-pcie-v1-3-5fb59e398b83@oss.qualcomm.com>
 <fw5hf4p2mjybvfo756dhdm6wwlgnkzks4uwgo7k3dy7hyjhzyr@bv4p7msxapcb>
 <aOzSnxuuAb4gFCkk@hu-qianyu-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOzSnxuuAb4gFCkk@hu-qianyu-lv.qualcomm.com>
X-Proofpoint-GUID: 0UsQ-RIEsMUZFJqVoxQ2ARVbcr4FS21s
X-Proofpoint-ORIG-GUID: 0UsQ-RIEsMUZFJqVoxQ2ARVbcr4FS21s
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ecf344 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=SRHymB3k53h_HzVQ3XsA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX1AVkIKEnDpwk
 kcswsArypS9z/oPTk4kNDv+cpwWPSw5wcALVrzuDejNnHn8cMHKsfO1zoRyQAJP1qLIX/imb/iD
 ZbXK0d4GFyrPWZIMHAcwc2d67rNr6v0fmHyXfwd9/s1/u8kS8BO/w0+eLcTbb7qB0zFFPncdtwI
 LJn+UD7JxcY31yWoZRST9twEFiRTZ43U4b+qSL8dJ+wbxdV3Klp29hIauyFoeFr/9bYt4jpmasG
 Yjoh1g/0BnNCcNBLtU+CiFRfvnDk+syK2TWb8hymHJ/hfSYRR5d6BnI6NrVV83zOEONGxbj4RZh
 bklcCD8aWEfpEzMJMwdknXajsktJ06IEhg/eK2cSCYZbl0uvw30po7kOJSv+boUzP623ryJ/fyF
 Qq2q9Tq7OqKUkVXPsJaoo6CILXNJWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On Mon, Oct 13, 2025 at 03:21:19AM -0700, Qiang Yu wrote:
> On Thu, Sep 25, 2025 at 05:28:15AM +0300, Dmitry Baryshkov wrote:
> > On Wed, Sep 24, 2025 at 04:33:19PM -0700, Jingyi Wang wrote:
> > > From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > 
> > > Kaanapali SoC uses QMP PHY with version v8 for PCIe Gen3 x2, but its
> > > qserdes-txrx register offsets differ from the existing v8 offsets. To
> > > accommodate these differences, add the qserdes-txrx specific offsets in
> > > a dedicated header file.
> > 
> > With this approach it's not obvious, which register names are shared
> > with the existing header and which fields are unique. Please provide a
> > full set of defines in this header.
> 
> Sorry, I didn't get you. Do you mean we need to add defines for all PCIe
> qserdes-txrx registers? I don't understand how this makes which register
> names are shared and which fields are unique more obvious.

From your commit message it feels like
phy-qcom-qmp-qserdes-txrx-pcie-v8.h is an extension over some other
"base" header file (likely phy-qcom-qmp-qserdes-txrx-v8.h. It makes it
harder to follow the logic and harder to compare the values. Please
define all used register names inside the new header.


-- 
With best wishes
Dmitry

