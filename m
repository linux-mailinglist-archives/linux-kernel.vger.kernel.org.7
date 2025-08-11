Return-Path: <linux-kernel+bounces-762448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCC6B206B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B453A7DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96321277CA5;
	Mon, 11 Aug 2025 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i3hOb9tb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF3289350
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909938; cv=none; b=ReN9tl+dCzWTf17Aq3WKUj3vBovW4lp4AtbvUlaIF90ElTjUgsuOC60b5WbY5XJxzt4ZgVw9Ffesplm6uWcchQvX4AR2/YP61tUEIUjjj7hk2H9POTZqtLYrmj5EsWsxndI7QvpfBOLHvQCW5YjN94n/IDe5M8vgxWF38v2rlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909938; c=relaxed/simple;
	bh=jQpXt5lJOPGLa1sqB2RfxQcFg7u6BQCGwUZwSWOyUyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0MrMWq90y2+S1WUlIfJZZt4xQVJKEH7SR0NcPzH0nzgIvIgWMyRoEsrvdP2kVeAdzs/no5h4Am1Xw8EndGVXaWwOZ7DcRmLPb0EncHyIK39H+bv1XS/TCU/fOPpFL2ajRUbM8zpJa2YnA4yf9IJB2RPxdZywFGM3cq+/zLVQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i3hOb9tb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dX2q001633
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LCBNoKc54TT9NiHquTumjmp6
	Jc2gxZAQ8MEjjE3KJtg=; b=i3hOb9tbCFgU3XFUbquG8R85Ws2AOF+31mP3dKy9
	iqa1+sEKuHZbTz79Wii6UtfKZcdW9Wlf8p0YuMs6nrFjIsL5mbWnt5cOFrf4iEse
	bVvbJe52a5LZG2ZXxK6YZz+Joqfs3o7US22vZQzzLIue/ljR5YN0uWIgw0NbJwMD
	26pvtvhFtvst+Fd1xRBx5gMW0mU2EiDvX83vzcs0VtmtnzhYJIoECuYSmL1/2lJe
	BTGNm+NdDo/In5b0r9RGFhjWmuH5Dhn9RiPREPVKhwfy2gSXTWZdbUnU/p/PUKh/
	s1U6awXOH5A0hBCKFpa3MaCsxJmhiT+TYCOe1dNqZOZVmg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dym9m20e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:58:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0ca325530so9756741cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909935; x=1755514735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCBNoKc54TT9NiHquTumjmp6Jc2gxZAQ8MEjjE3KJtg=;
        b=fH3Uarhh7lx3GsyjwxjaNiQ8aer/GxKcol82uN1YhDNv2DjMj1TYm5jFxWeimYPMyX
         3MSevD+NmCJ1H6boLPtYGVHILZTfx/lFD/uQFixPEZwax+S9hICkgFRrRqcZBeIX6wot
         9Oa9i0/mMUEmrgaYHc4jSyvtkIH9/KbafqJrhXu+rlp8tR2ItxQhRnpdeGAgLb4Kg3ZN
         PQx2e8/p+h66DGTMgz0wCYMcaXnxf0v/0pjEJJZwSO02OVubiOEjxUFn97I5Hc/CqOaX
         1mFGGGSCFmm5nuVVhS2gLIaJUUTgSKJf0mvC2TJ5YN4S+tPI9nMJj0s91RulRNXQE0Kv
         P+QA==
X-Forwarded-Encrypted: i=1; AJvYcCWymVz8jTgKWUPJfaoYPVCoNsPXDiuvhzM4jEyrzzRyRioAux/YkWjuc3nEvqkRmhQ7zF9jRjf3J2V4568=@vger.kernel.org
X-Gm-Message-State: AOJu0YziFR3UT1tCd7t+YeGdlQNqmhOu+n6Vk5TV0Q8nZBN1IBzkGIm/
	YrKl4eGB3Op0E9pdkPiF21cS/oja0D9EVEwDoe2upMJfHebHHdKSSU3AQFal76qn44cLeGHMSnP
	7D5vzaZB3Rckl9EXr9eHmQsEC44AiMWt6CFG1LLjw23VBKiJOpyBjwzq6BDOg0Xxy79w=
X-Gm-Gg: ASbGnctKC7PI/hLy+LjFaTwCga/SuoVs7VfJ40KTgqlaj+VwkWPD2Zp97pXEwjw25Sz
	i8LOlpAkks9prFx/NYKQGVj2a6g1xSMzz0XDG0SRphJCTYjr/tjtxF9h1oNY0AC5xITFfanaist
	5cNgmEiik1yVQdpsVxXwMYmJRD6xUqWCn9Kyd4+FCm9VeoAPWtbkG8wdPJ8uV+eqi+7RGVn0rB+
	4RqxFbIE4zKd6DokaVERD7jwHve0ocG2tOWm71WZ4UWtzvE1R/2xTO5K+BGe/pQ7UoXi53AfCdv
	auas8oNwAg39nu08r9Q7x4/H8RotObY/LkFAihhbiBf7U1lVADi4d/ytk7ZkAwJcKtMqGbB560i
	vMcSmNG606u8Ftl655qCyVoWPLa3yKhAzvwMHFahH8p2UMFt/MA5U
X-Received: by 2002:a05:622a:1a94:b0:4b0:bc43:dd90 with SMTP id d75a77b69052e-4b0bd6610f9mr96569901cf.48.1754909935237;
        Mon, 11 Aug 2025 03:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBrlBvmKL2RueO2NS0xviGlmtRPiD5NDEbuXSKBImqyB7gwapNEVCwYcaPgiOWwUqYRHjJCQ==
X-Received: by 2002:a05:622a:1a94:b0:4b0:bc43:dd90 with SMTP id d75a77b69052e-4b0bd6610f9mr96569681cf.48.1754909934768;
        Mon, 11 Aug 2025 03:58:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cc9df19afsm1050425e87.168.2025.08.11.03.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:58:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:58:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH 2/4] phy: qcom-qmp-pcie: add dual lane PHY support for
 SM8750
Message-ID: <mjg63cvby3jtosoiswqg2kjxlubavyz5o27asthjazg2z2x6gj@3u4gywclkg3r>
References: <20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com>
 <20250809-pakala-v1-2-abf1c416dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809-pakala-v1-2-abf1c416dbaa@oss.qualcomm.com>
X-Proofpoint-GUID: JIuiShmu9BGIg6I2FPN0lH4hsk8njqZB
X-Proofpoint-ORIG-GUID: JIuiShmu9BGIg6I2FPN0lH4hsk8njqZB
X-Authority-Analysis: v=2.4 cv=YZ+95xRf c=1 sm=1 tr=0 ts=6899ccf0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=m1AchfmAwCg5kGC2PD0A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNiBTYWx0ZWRfXyb81TattMmp5
 1q2W8x51TqpckbEwy7/ZB8CQ6KePMki3WYwZ+47k0vRXzgGSo04vAAFIoeS6sNGI0cFGh9FNpBj
 iUg20DxHpG16FGAbj0z6OSHskEVcE0ThZkxSUAc9gSd9DbEJtjxb6uMWLNKygcHWBmD7b4SB8Di
 1APIfYG9yekXGJoLzpHp0wU950nL/GdaGsFZAKL4xqak42r20zdnaXfPBe7MwetVdozyZd3ZSur
 XZl9NE5Jcsh0OGsmv59tDwsfDT1Nvn0syzkJw8yyohY3E3d+WaA7gJQz7Pf9O1P5A/twFdS1F+w
 42QuMG8WxUykfaqmNapHcBkHHP8SOSQ+hE9VVh1ElD9kSUs9cX249ubnO+vw9/A4dUY0v/VYQND
 cNr1OvFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090036

On Sat, Aug 09, 2025 at 03:29:17PM +0530, Krishna Chaitanya Chundru wrote:
> The PCIe Gen3 x2 PHY for SM8750 uses new phy, add the
> required registers and offsets for this phy.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 149 +++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h         |   2 +
>  .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v7.h    |   4 +-
>  3 files changed, 154 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

