Return-Path: <linux-kernel+bounces-845159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC93CBC3BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A9C4014EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19C12F28F5;
	Wed,  8 Oct 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbEkQFpe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E762F25FB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759909926; cv=none; b=ARqgcqN2igX4G+CPSw88C879mWiIANwdZ/KJivQXCpQaUxAxYP0C1VM0hnYX/knMoRYOKHLsE9M88AP7sIHCQd0fhQ3BfHeN85qrbMWCS/QZUFeqRbJw2FKEA+jowdlVhq83vMMht1KEjhmI+Le7dEYU9rCf+GIB/ORSS12g9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759909926; c=relaxed/simple;
	bh=jp/zJEcCPvf4jK9W6zx5g+YSKeu8yY8hjmywdRuZSmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akAUUkkcR6EBAeWUZMphHmxDYDQ+QFWMmo4G92XJoJVCcYaAbwImm7ggpk691ypDlFoOYL8+ZFKFFM5REfSn3IVy1AWKQHDAohwrBpwPZEurKexnKQ9pcl8Gf0ewjsCJDtZzcnaZYb/5w1FI6bU/3tS5Y4+H9lhO1JDIfzzwGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbEkQFpe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987bLsI018518
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 07:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YRZFPPJQeCYCUJqQnDigqrNWBaX8OJqlWKA0JVc92S8=; b=nbEkQFpeRBLgPSQj
	/f1GLwdqSYQnSLmOMzcCP/how7x3+eNBMtAEDUCjEX6Utd/E+yinB3QFfMMQlwSc
	Uv2i54Y9RR30fXkrqie3pUnR3f9Cp0UQlYWlbniINnGP7l/4ADBxvbF9HlWpZawl
	tUUh/kDy69TLdt2XWjXovWJT0u+AF2BWBzBoyWTd9UTyc0+dHg6Z+d148idjyTZv
	B2gpn/vQoYrza6C3lHN0woop40T/CvLqET9ZGP+2k8ZNd0/k843l51L83fQV+v8G
	36q/si8FyItZ4TygoYzZOVRK8RK03imRIVzfWprJVKf6VLO6AY5QEopuGSRsCy+w
	Saq1sw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk71rbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:52:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so6271245a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759909922; x=1760514722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRZFPPJQeCYCUJqQnDigqrNWBaX8OJqlWKA0JVc92S8=;
        b=u+xe/3r9mMDT//2oYaU6+eCYjEKv+bV/jUpkutC3U2bEylkrn0q7HDbKJKE71tYqa+
         Qg+9KOqQevt0Lb89+Zrkb1fIMMRCMlPIHDRk2IIkvs9vvu33wkBUj6AkvxahUMITN1J0
         hCCKNHww1wHM4z5SyzqK8sfyGW9Mnde85fGrgSGFGvSg7H1QHJoddXCCyB/Yb6ncXWJh
         bnt+uBVPVVovmPG81WWvx9iK7gzLPq4Ps5J70w6xyfvHTaA7sFQphsbrQ9JUOGI6pH8J
         YsvRdmao387R7T62LgTKs/gqC7k0CzdsBSBRdozWOOms+huLKJNOaoHFqIGJBJn59WJD
         5V2g==
X-Forwarded-Encrypted: i=1; AJvYcCUW52HnYsDVzqg09lO+QgCAhSssNUoNyL1pE+PEZ5xhb4F8haiwgN5zpeVwXwFCCTk4APQULAoW9RzaJiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynwcv62xoKekGhGPg5s/DsVl7/OIV9S6AG2Q5Oay2e/TckTV9W
	zxFYuIsyMQKeJggsS5E5Ar4lXyzU73I0czGefNXcbQouOjxRZnJWDgw4x5CNCi3EpCGOss/M5+p
	T7NfPLlXHRUz0BczEiOpXKBvFs3chMLxGs6z7vWPNLduboTsayxoTOImW5QD0t+CEcNU=
X-Gm-Gg: ASbGncvAHXS78wLbe9PNBVerWgHcoAOZVej5Mm/M9t3phaFIqzqhtkKVObR3EQ8leGB
	STyLEe+sRs4v4zLd63oAOaTgS5fx4YcYU1K4MxZnU/taZkJMoN0fi89nU1DvoNMhOPFhZCCDqM/
	FeXxY1seuDSTo8FQhYrPukzcuy2rz8imaEMKbpL1xpLBiZUF67cVzJKSbt2f1TNW+OFzEbadCzA
	8JCcSiBlCK3Qf2HCtAZwUoFyS1eUPUzjZR4qWsmtUBdA+eq3EFhPwEs0i7sznHsWvZftC8vzBv3
	43gggAun0cbqpl1MQpInWy3JAO96Or0IrL0s/Q08OWomEHzAyEgccgfvFFmgs/vldZzWtI4R
X-Received: by 2002:a17:90b:4d12:b0:32e:3c57:8a9d with SMTP id 98e67ed59e1d1-33b5139a279mr3467249a91.30.1759909921542;
        Wed, 08 Oct 2025 00:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu01xYjaBLVLru0tk2ZrxcSyg6W5LORhAKpnIdoAjX3D22/ZziNpKkl1IjWF6AN1qDNFxpNQ==
X-Received: by 2002:a17:90b:4d12:b0:32e:3c57:8a9d with SMTP id 98e67ed59e1d1-33b5139a279mr3467197a91.30.1759909920761;
        Wed, 08 Oct 2025 00:52:00 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5296d52esm888452a91.2.2025.10.08.00.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:52:00 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:21:53 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/12] firmware: qcom_scm: Introduce PAS context
 initialization and destroy helper
Message-ID: <20251008075153.wjvlnjr3iuncfued@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-3-de841623af3c@oss.qualcomm.com>
 <qqjynnzjhpe6elglh3xb4ghbtesfkr4ssxyq5flhcy7a5jp6ym@3viy7jyesamq>
 <45eb9c5b-bc8e-4866-bbaf-5afaed9fda21@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45eb9c5b-bc8e-4866-bbaf-5afaed9fda21@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfXytLSMvP5HsML
 y5WX6ItEV7Fr43QkXtn+95prLX9cS0YhR+lm8AbtY9tkFszLOFXqerHEwNUlMpQ9DjlrJBcvZQn
 bZFy+DHX+PfaVfd6t4t5/eFwfulurnCPiSBSKNII1FjAH3UtPUSMIWin9ho2Erd6z1OUUZmryDI
 2xp14/RK47r5bIhAD1JZwrxaNaHjpR4wYzp1vCDeRAE3wZGnWzLDraAm38wYpBLZQPKTnybwisU
 19F99mZRJH5tn5eF+RynI0lE7NHIByCe2iw2/9xOFqKVZXACLI69Sn3XI6aF5qTE7ASMEcyeeY7
 AKjKMwd7SkymjcEDm0bv8X5yX+q7sUW+xDPOdZNIOx2Ou5bUvRG3dy+lZ/KaN/rPg0IOH4SJIMT
 qIgqHmDMZ/7kfA0H99eV14CxUeXXeg==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e61823 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=3aEvWvYx403qF7UyPRkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: piV9SMSzIP_WI5RZnAssmQr2h6kXgODJ
X-Proofpoint-ORIG-GUID: piV9SMSzIP_WI5RZnAssmQr2h6kXgODJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On Tue, Oct 07, 2025 at 11:16:28PM +0100, Bryan O'Donoghue wrote:
> On 07/10/2025 22:23, Manivannan Sadhasivam wrote:
> > > +void qcom_scm_pas_context_destroy(struct qcom_scm_pas_context *ctx)
> > > +{
> > > +	kfree(ctx->metadata);
> > > +	ctx->metadata = NULL;
> > > +	ctx->dev = NULL;
> > > +	ctx->pas_id = 0;
> > > +	ctx->mem_phys = 0;
> > > +	ctx->mem_size = 0;
> > Why do you need to zero initialize these fields before freeing? Are they
> > carrying any sensitive data that warrants zero initialization?

Nothing special about the data.

> 
> Mukesh, have to say I don't think adding my RB to this patch is really
> warranted.
> 
> I gave review feedback that the above looked odd.
> 
> https://lore.kernel.org/linux-arm-msm/9139706a-708c-4be6-a994-120cce0cd0e6@linaro.org
> 
> Could you please drop my RB here, and fix the above in your next version.

Sorry if I misunderstood your comment on this particular patch.

I assumed your concern was regarding the manual destroy call, and I
responded to that point. Since I didn’t receive a follow-up on that, I
proceeded to address all other comments and added your Reviewed-by tag.

However, since we are revisiting this discussion, it seems appropriate
to remove the destroy function altogether and switch to using devm_
APIs.

> 
> Also please add me to the cc list for the whole series.

Will surely do it, thanks.

> 
> ---
> bod

-- 
-Mukesh Ojha

