Return-Path: <linux-kernel+bounces-765078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A479B22B15
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B96F5026D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5542ECE8F;
	Tue, 12 Aug 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MqreRUwJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B62C08C8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009946; cv=none; b=krl2oS6OdIVwsJyGEyxgjjTEyoACpxVJX04LCEQFy2+ouobmfDhBQiALF21xRTNw/W5WAbWoJjKvVl5lgQlFWSgW6PnteM2Lw3N4FUkDcsYVHIKUa6KXBXCyIKQFU8drDy6qDape/DIDM5PTO2ENjqksOQOzHC5g8xrPgtWnk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009946; c=relaxed/simple;
	bh=BsPUwKo2RgN3PIB5w5A0XiTeMyiBfC1bkz2j59r34M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFLFj7w5ThipXW1GhYFlofMUWNsLyq6dAAeBEMSl/zn4S7uF5Bo5H5agMYzdJDcBWLZpTR0+TqdKAKrGCWbqftNrw1lkEE32zOpnggYsXD3el5F2j2pPzUM+ZSB6eu/tMydCV+49H5P/3wvkeF3ZoeD6vzSOXb9SDI0NC7LY+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MqreRUwJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvfJ4020363
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xY4ybwBZU/5eLYxDAWc6jB33
	jh5tMDovV2YsVXcnASQ=; b=MqreRUwJQGKu/vdT+4GzlA2RsGs00SJaxFKBFkSs
	1JCr6oWHCxv/17JbdIMePea1ftaQcRo967TDVlXOQL3K95XXKmeTZblSEheh95PI
	1iKMKwTHg04dmOwUAghBgPb75ODxB/143K6b1fRiiKAgrB5U5CSwia/CAvbxFZur
	r8/a0UwTE6KWuknjsDZdzi7n5zVfnVw8VcgRQdXScQdoPNtJM11LpIWs/VYfl+Le
	Yi75uk+BCbulUkBglpf0lo9466nxj5SJgbDPdEOSmy6pvQNWdMHDwlmmcJ3aALnf
	Jg3nQP2T8rc3hY88F5mEIuk1a5/Ya1qzyrHVfXtr084wgQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx6ncj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:45:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0de38c71fso27792161cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009941; x=1755614741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY4ybwBZU/5eLYxDAWc6jB33jh5tMDovV2YsVXcnASQ=;
        b=OXayQfk4UzU7XeSco1YkzKgavSL/uOKX/OTtKCl9HU4pG5OfdRs/MKTPEHJXCl4+h5
         rPhC+GL0+odqrlGqJMb9vZv/jUgxk+e4Zgz5KdbDhXMuvdjznSIz0CKKR4IXcmKjoPJ4
         vqHYAidrun7VMrOxI/kAjUkuDYJMC3KwgqOxIB9pJxW/Uc08LsnBL3YrgwAsYhhw8WEc
         tGt0bX7HxhRaSQlF6FBdwYclCp7FMLRhTbBZqepQQiwLsMTrNP9owQeeVfhrxcRiqKu2
         Tip9DvUg8ioeS4vUDpJQHPUb8mOyCnzZ7DdaliBzsYSZAqsNdZ8Hfwc+qucRAuWHwwhc
         3MRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1MomawlQf26DWkQH1QwTeIzDfB9r8qtBMV145W2oB/U4gJimZPdMHR1QA7xuOxvmpRAyHbrgdhVAzJ0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5zP4HgmQnkFBcOSpgEuPeFjuUQWAHNwTAMtZrsFqFazsdCG+
	x/PTpjVYuv3eF4kUargowwrzAwXaeSe3RaM2Mzye6YgPd6H6C2WSZdlGbFrIQj23H9SO+0qMPF4
	ASSJcHQY1H22ZN8Ukofm8E86uHsJvjQwfCevOZX1vmlDzUCww7N7TPWUUGNDXHYKFPPI=
X-Gm-Gg: ASbGnctQWrQGlvAAwv5F+6uBKYuZsN8nWjL8nnVMLWt3pw63jrOpkJtFjvPlFZ1ZFjK
	Tvv4H5FKNM2D3wjW6F5IgdodcNMpiEXJANd3m65y5gmfCo42kgFgyuWUV2gYFuM8qYJT8nZL2oj
	foUDL7L2FnbzRDcQD8JD58NvZCYfvPsP0CtVIXQFXDecVVsBCF5LiFnxoTK1PdGjH0SscJJkU2r
	IydClmRYXyU57Xi1xkRgKMQkEJSP+nklggY+DeMYFPcN+xaObQEE8ZrhodrY28zhP4RxWrbrjgg
	+x55BsFU148YN3KuIJonoFxoFDU4lmo2ryWcbhr/KLYHGY865mvSCmh5NSx3rtlPUJ+jMADn6d9
	iZ7KlP6KnnHS2cI+HiKxx/4kgvaLNCoB500KyaVjhsTthmogqsHRJ
X-Received: by 2002:a05:622a:2446:b0:4b0:7ecf:beda with SMTP id d75a77b69052e-4b0aed0bff1mr245432251cf.9.1755009941255;
        Tue, 12 Aug 2025 07:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmYy8rE3bdSKUsBvaAM/ijKkrxlBj6I9ke2X5s/PiaMRaKBrdTRaQVzxnYmAAxXiVyybZVRw==
X-Received: by 2002:a05:622a:2446:b0:4b0:7ecf:beda with SMTP id d75a77b69052e-4b0aed0bff1mr245431671cf.9.1755009940667;
        Tue, 12 Aug 2025 07:45:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55ba00b78c0sm3769141e87.68.2025.08.12.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:45:39 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:45:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Describe the first PCIe
 controller and PHY
Message-ID: <xirkug7igbf33nkxtkpdnma5wsepndasmka6fp3q3n6xsk4npj@jucnjfd7bqc2>
References: <20250811-sc7280-pcie0-v1-1-6093e5b208f9@oss.qualcomm.com>
 <8d5eb27e-e299-4fd9-a591-2d90f4693838@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d5eb27e-e299-4fd9-a591-2d90f4693838@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX+3aCcfAHYOyq
 fy2v7xy74qvhT/N1KVUCH0DCfFCZixQswxssdyFqRHY7wBFjohpidJ03BlidM2Aks7D9psOCTwx
 NZqMacsMDtX3IOnYWMUvk/FFuhUMsYimZ9dEB2zAI/LWf1/6RbCNpvgJ3bMjDQ8UIdny9pM3zwB
 MyoXvSdqyxMQARuFLHzj33K+EGgRCcC3vhjFvVE6nClQD+z51rBn9XQkTOIchiyPWHslS/L0y2S
 bUbxtd+7I98EKRvNYcnM2Voy9e2XY1dGTneZp0S2bYyR17ishJKTINe022yMVNVXBaQ18PxRMWJ
 UI3TbewOYaYRdxFSrlFB5OmHwMxFfNCiWxa3bU6eI6nuFYnScsxVlV7K3TjiUa7zYF3T6s5zytB
 FVEgtakG
X-Proofpoint-GUID: AO9ctdxY-NuzuooTSLC1KownFkKZyRYK
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689b5396 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=QUNwyAoics8Us-WNJDcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: AO9ctdxY-NuzuooTSLC1KownFkKZyRYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On Tue, Aug 12, 2025 at 01:34:44PM +0200, Konrad Dybcio wrote:
> On 8/12/25 5:16 AM, Bjorn Andersson wrote:
> > Only one PCIe controller has been described so far, but the SC7280 has
> > two controllers/phys. Describe the second one as well.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +		pcie0_phy: phy@1c06000 {
> > +			compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy";
> 
> :(
> 
> BTW I noticed that Krishna also tackled the same issue just yesterday
> on the internal mailing list.. would you prefer him to take it, or do
> you want me to review this patch instead?

That means one thing: a lot of our engineers don't need to post patches
to the internal ML.

-- 
With best wishes
Dmitry

