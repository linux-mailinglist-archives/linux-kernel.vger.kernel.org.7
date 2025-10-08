Return-Path: <linux-kernel+bounces-845893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B9CBC66C4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18672404612
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739712C21C1;
	Wed,  8 Oct 2025 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PSdS5V7S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7902C15B8
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950525; cv=none; b=M/Nn1imWA5m4dRfvjw3sAbQk8g/ocb/9W4UDOkP0J1teR0T6m5W7vC7PqaVHKr0OL9bGPl6dlv8e2IojgULnsTADf1epQyH1JI6xQxYCPiGe8q9xq39we0+7It/Awj/uVvk8h6YFrr/5xrSn+7lK2mvYtM3sGl7wFx1Lag3c5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950525; c=relaxed/simple;
	bh=36H8OByZz4/Y/E0gK6HuNWj3lJs38jOo6haF23jGHnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phF3NVm5G1jCGXmM+zL/+SOYifB8SNzzu5nX90Wyb8quitNKWs1WCrG1Zo7PIGUyJqVXfsqFHiuMhzyBRV0YrRj5yHV1SGOZ4Mr9F5ij4TxUj3iKugTEEDmElW9pO/+9L85rVajxc6YpSTXSXVwsLa2jiqw9CrnbagZ89gb/0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PSdS5V7S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5HBT004429
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 19:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Rw+KzFLht2yFEyIY3QTrtR4U
	azMsrTevmU+uxmGDP9w=; b=PSdS5V7S4B5LBHn/bBi7uCxcLnpqO98yWb2aZxkL
	lHs5i9bU4aIKC039KmHUdulwm0yCEhO4dWty9V8u9aY5N4T/vnWejxXYq64f/OZ7
	S63MguaLUpJpbI968PxkYiryqfI1Z8c6uhPzDa2WjBu9GrRcv0HB9ABQ5qlvLTAN
	la5vrp2lBgE1afSvxkRgwqZXXfwxNDosmbqLLrDPJAzNStM+qH3o4D+S/3f2DZdD
	oQjt3tOvTfi0Yxzq3l9gWBAOkmsA1gINUmpL9RpSm/0e/AJZ+GKQFaMotmfLl8NJ
	/JIn/yFtiD8sY+9NwjFQ6JPr1mQaZuQnKyaCF07D5mLYSQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4krak6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:08:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4de5fe839aeso4792221cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759950515; x=1760555315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw+KzFLht2yFEyIY3QTrtR4UazMsrTevmU+uxmGDP9w=;
        b=p5mpt+MTNjY1eh3rpx3nmTf6rmHmOowTIQg4DVQmSKHukS7mqfvWG5oPwMsu2AyQqu
         I7IhOSg8XHiWABYrbSVsY2YUqJ9jiRsJ8Pn+dyyh5cUtoUO79HkFh0i+rPko0j1gOdFm
         j0HcvLWdwBegh5e5N8Ifvd5QnP1NBXSRmO/yf0m2rEiwEomXDdmPgrhTBzEDnNEYxmdd
         ZqI6hQbYjl4sgckr6AVzZvHmwBJ89ApXIO9fwbXIvmR9Vx2g+vFtYZ2R2nGu2e+35vrV
         z+dVC5rVxLGUGScTC9P36dcM7PEI3cGwhq0m6sMKNw2r4H45I/CPraF/Qhh6BH4Y21Fb
         ivOA==
X-Forwarded-Encrypted: i=1; AJvYcCU6nPA0CDLp34KpsCk0CH28ycF89RzGgbz2CbSykEDxOwlzcGgNfN9nYMaaDsL7rzFHVMChQjpw4xLQCLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bEoyhaPE56YxG85jpAipLxtEZtMKt+luikixMlJtm5MUj9K0
	T/DykIucWDnnA8vXEtDgd8ZXgDylmZho43mqF4s7aPzqpLDk8EaTQcx18pPHvtJl7GsA7S+gDsc
	LbGwrSyM50XvEJwdtsilC8VbdZA7Lpk6mp/GGrxr62Tda4AKP6OIb4D9+rRqMIX++G3o=
X-Gm-Gg: ASbGncs9p3qaEwvw9q6uUGO8dwqOq76p3e7gIdDm/5jRy6WvH7+D0vgC1Zxh1LbRR1f
	Owwec5trNvFfGVzPrzAjlgvP7x3lW56TJbHer3X50aaC2xBAOmeSBlcy1x4ibfLmMKqEEw8IU0L
	LOxayKyIkhdg75MM+MVvB8I7yp72fo4ztuSQYjELVw4/iZFEz8HBrVDdqte55y9zfWOe1+nPJv1
	Ezv1/49hrQUfgDAJ4D8CG62ElR2cnIhnwlclo5S8MuVH/fJ2EukOCb+1IaezU9rxSvqoXK3kUjL
	fWhCPa9vEZFmBeUGnVfn/XAqjtPIjErUrw7CVRj7CENmKWSmuN4ZlCljDpqHVgqRy0OOHJmsex6
	7syt3hA0wTSEFq9AxfqSDx4HeFC678/H4iofuHtW4cJEkI33BoDYbvtCBQQ==
X-Received: by 2002:a05:622a:4206:b0:4dd:e207:fce with SMTP id d75a77b69052e-4e6ead64a22mr57960191cf.70.1759950514849;
        Wed, 08 Oct 2025 12:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9dfHI26F6tmDQPEhiuoqrcfAbe3ngcx7SImkYRwO78fn/4c/EYGv3VDRX+xMY9m3o8N3kCw==
X-Received: by 2002:a05:622a:4206:b0:4dd:e207:fce with SMTP id d75a77b69052e-4e6ead64a22mr57959571cf.70.1759950514231;
        Wed, 08 Oct 2025 12:08:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39fdbc4sm22092051fa.17.2025.10.08.12.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:08:33 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:08:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
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
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
Message-ID: <qref5ooh6pl2sznf7iifrbric7hsap63ffbytkizdyrzt6mtqz@q5r27ho2sbq3>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
 <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
 <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
 <4d586f0f-c336-4bf6-81cb-c7c7b07fb3c5@oss.qualcomm.com>
 <73e72e48-bc8e-4f92-b486-43a5f1f4afb0@oss.qualcomm.com>
 <8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwQFrFz03b331
 136W3hnZRgcAgabk6kIu/3amsCo2kEAo31Q0ontFmKDnluJ3IKlIWMpnlN00St1xwRFLmGuAYK9
 KfrxYeSIOeZavToiMLtymVmHX94z7/13M3LhxHp/h4lmfnZxPlnW1dKtzoaBHNuUfzRxR5uc/Sj
 ferMSffmyPEnKzbPl37I0E1Dk9K+jmBHa2pIFR99DSXdttqKMiM8/Fdp04twazn2qpXap8L38jx
 hZpCGkE/rqiD0n0BQg7LcIP8yOlE3dEYNfPqu7iO+gdNXsbWXZXQh+pSqPE4Q1GEHdvRgINVZgI
 MrO4IjiKWYscke0cjH3FqJoWQk1fcAlFey0Qfv0Jk0metRLFbFm3Lxz4rw1HF7jgkJjA8k1rkoJ
 cn864pi2kYRcDZOv6DQJI8b/kJDtTg==
X-Proofpoint-GUID: vcqk45a2rYP3oHaqdIoFcGDo_STbsmxG
X-Proofpoint-ORIG-GUID: vcqk45a2rYP3oHaqdIoFcGDo_STbsmxG
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e6b6b4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8Rp3m3j2afKyq596a-UA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 11:11:43AM +0200, Konrad Dybcio wrote:
> On 10/8/25 10:00 AM, Konrad Dybcio wrote:
> > On 10/8/25 6:41 AM, Krishna Chaitanya Chundru wrote:
> >>
> >>
> >> On 10/2/2025 5:07 AM, Bjorn Andersson wrote:
> >>> On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
> >>>> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
> >>>> and x2 lane.
> >>>>
> >>>
> >>> I tried to boot the upstream kernel (next-20250925 defconfig) on my
> >>> Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
> >>> is crashing during boot as PCIe is being probed.
> >>>
> >>> Is this a known problem? Is there any workaround/changes in flight that
> >>> I'm missing?
> >>>
> >> Hi Bjorn,
> >>
> >> we need this fix for the PCIe to work properly. Please try it once.
> >> https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com/
> > 
> > This surely shouldn't cause/fix any issues, no?
> 
> Apparently this is a real fix, because sm8750.dtsi defines the PCIe
> PHY under a port node, while the MTP DT assigns perst-gpios to the RC
> node, which the legacy binding ("everything under the RC node") parsing
> code can't cope with (please mention that in the commit message, Krishna)
> 
> And I couldn't come up with a way to describe "either both are required
> if any is present under the RC node or none are allowed" in yaml

What about:

oneOf:
  - required:
     - foo
     - bar
  - properties:
     foo: false
     bar: false

-- 
With best wishes
Dmitry

