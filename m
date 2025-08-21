Return-Path: <linux-kernel+bounces-780367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 660BDB300F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056DF1CE6D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A087308F16;
	Thu, 21 Aug 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FnpnpTMB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580BF2FB63C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796853; cv=none; b=fLkgcw+D5stf2HQgZ4XB7dhe5zu7cE1NJiY9ajisJo6wsBr+cvpva77to4agc66SNM5JduFj/H9EfSpKJhyH5OJBeCbiBxDzBcutUrbV95WKreuYmolOB2rPQW6kPdj5c+rHyXZlpK3ZK7BTX7JswCyMnniemrK+AaZrvNrl1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796853; c=relaxed/simple;
	bh=TLhz3rMWCYqIHd1iDP8owe1GnVQepPj0RnY98tlw4tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6KjnmgdkTJ8yfAbE9K9M/7ZlSFK/2CeH4iq4CbdGkM28OVOzSHw9veBckdxmlM8AL860t4CGEbVT2U4iOBQ0v9zKs3X8niio7Yu1RjCjQTo9QlO1P2hqIyGw/5G8eidWc+WxkTiNdmCj/oCRNoPojIT3Amn5GBuKxmlPf0BRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FnpnpTMB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bCIa007094
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aoikleB8qrZ5qP9Q/cyNCn1p
	Z+IFQyJRynDCSYl4hUs=; b=FnpnpTMBbAjGVONZOUKSg45IKIU3/Pt/XLcXMtBf
	ZxuQp5uWC/cq1N5YbOoezaPPyBEZB00p8bN+/xX2uNGVQbtA48PLCiUjlFuY9rLm
	W7tb/H5ZNYtgNlPGbK/6i58P2CgLxj+qRO1GjoXbYwadaCnLkLkXoiW5JkrT476z
	zU7lHrKvjTE/o0ApQEGMY8e4I8jPEz8Comuec7kBpBrNhnnqbpEWYPwG8NOO/6qE
	f+pPMoG7pOsufRCKCQz/lx5H993Jj9wiaTQcqNlMs7SPj04CFuRZjwOcZ9IuVygt
	jxOmM1ge/LklBDcRj3xAOInuaGu0QUppmdPfaJxRbbgYLw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52969ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:20:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2e8908fdso1073434b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755796850; x=1756401650;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoikleB8qrZ5qP9Q/cyNCn1pZ+IFQyJRynDCSYl4hUs=;
        b=Z3aG8Qw4A0qPOB7fC2PPl1MPMfDjUnuEIXkgfrGnm+ozkBHf0I7ds43UaFa6ENRJh1
         G4myCTdfyN+z0J2NxCCSglEkumwLi1jIsCOuI89ynTiqGinIXIRVJagWF00iVmlMDxFF
         pAZcGKSsgR8i2T8ccknBppmlUADQ/FD2TAcDD/TM/8B+rNUm1nGDLVKMU8kg/p74dj/C
         c3vD8CXEPb53lGLdW+Vpxo2lOHdnT/b3HaWFED0gyudJIduCltA2QZjcmXoR5OqBV1p8
         3LdclCbB+dblXNKOI23L1cSanr2wjeD+iRsPxw05bv4MxBAtdpOwWaigA/WpUuh9Ipfd
         VNRw==
X-Forwarded-Encrypted: i=1; AJvYcCXD2ZiT38PFx1i+sgOthY3fC3sHEgPkvHEhKvLq2PTYdOeDMv78mEbK9XN0x4d1kIxmBri6HCuIAnnjRjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsbVwdxTWw3TPIWIx2gihj9ymJosc15MpcuHl/rMfsTBpo2eZ
	PnZAdrcrWaNZdcYeXJg/lZMssnBK3ERXRey0xDpe7AZp4h+7TGIHxZSoYiuTgYnuWA6ZgKSw5so
	dsqD1HlHRK+fhsLJRJu5E/yA/wpe6UIQxTLKzKl1mOH/m1ERtu3wYfTL+ZDSGgZgpo88=
X-Gm-Gg: ASbGncukuECQgVx42XhIEtTHB7PrbdH9pXQxWPfFa4pTwktRAGU4JgI+aN48rVEj/u2
	QK4O/20TGBrhgkZpRbkeNrmqU3zbfpkDht7C6iciIl2G8wKZmv+hwkABClH85U46noerSlQlR4M
	2UxZK9kU8c0n2WpLXtG2CwyUl3GmNQzlu8Gg5j8FkFeJHu52McgLGQbZQAV2fWncMHZ2BgJguQn
	/pS/ulWJqB2WiVu3wuUic58xpQZjt5P2sW7+P+vYE66Rw9uqK8MkTX0kOWbEhTwczsR2yZ50oB9
	vbCU03EfPpfVXopSK5NIurwt5Bu+0H6cGZlEGD0T6TyKfMePhX0uLTjn7/H9QQevM8M=
X-Received: by 2002:aa7:88c7:0:b0:76e:885a:c3ef with SMTP id d2e1a72fcca58-7702fc18b12mr165885b3a.27.1755796850499;
        Thu, 21 Aug 2025 10:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqqgWcrAIo2xfc1nSKhO+omw39OC5L/phKySKVnNxOepfjjZ83oA3Goh+/8/RVSK+mnw4EhA==
X-Received: by 2002:aa7:88c7:0:b0:76e:885a:c3ef with SMTP id d2e1a72fcca58-7702fc18b12mr165864b3a.27.1755796849972;
        Thu, 21 Aug 2025 10:20:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1b63sm8977588b3a.7.2025.08.21.10.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 10:20:49 -0700 (PDT)
Date: Thu, 21 Aug 2025 22:50:43 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 07/11] firmware: qcom_scm: Add
 qcom_scm_pas_get_rsc_table() to get resource table
Message-ID: <20250821172043.fh6sr6w4bwyhov5q@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-8-mukesh.ojha@oss.qualcomm.com>
 <4a60c3d3-11fb-40fb-8686-3d83539f250b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a60c3d3-11fb-40fb-8686-3d83539f250b@kernel.org>
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a75573 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=SpqgzKZKrfenv9_tDssA:9
 a=CjuIK1q_8ugA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 196kE_DS178y86q6NfgDVvM-zVJnH4tO
X-Proofpoint-GUID: 196kE_DS178y86q6NfgDVvM-zVJnH4tO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzpEuTYGJK8lj
 qO0NIebHriC+LH/3xMfKZlTK8rVYdaMzgoTSlMRnknj/edhkoJ67B4N3+HAFxipXZ7LSFgZh45e
 IrX3ZZhhWcWOJR47DeyET3xKG2ngQI9mX8+6vYn6/S4GZjbeQqyqjS/XUYX+ad2SRVqVAUD3SNT
 P+FIpIo6ub/Zamt7tNEac53juEMNS0D3+AZ68sbBXpwCzr+2ybLy6dd33/5J6dauJSYzoo4NAjV
 9ENzUgBEUW96kFf1kTyYZTjAOhbqASCBYbMwgVyP5P66BX8R8iZ6lNRmZzG5SiqAki5Vq2WbpKR
 yGVuzL5PTeSx1pjeiiR7sIAaY17bbm/79abqWAPDJQ3JMaymxzvPv3kjsheIp1+FB97XKTDnHlf
 2WL5wn1erhmb71Z5/sV1ItcX4wrDug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 05:05:59PM +0200, Krzysztof Kozlowski wrote:
> On 19/08/2025 18:54, Mukesh Ojha wrote:
> > Qualcomm remote processor may rely on both static and dynamic resources
> > for its functionality. Static resources typically refer to memory-mapped
> > addresses required by the subsystem and are often embedded within the
> > firmware binary and dynamic resources, such as shared memory in DDR
> > etc., are determined at runtime during the boot process.
> > 
> > On Qualcomm Technologies devices, it's possible that static resources
> 
> It is possible? Only possible?

its possible 

> 
> > are not embedded in the firmware binary and instead are provided by
> > TrustZone However, dynamic resources are always expected to come from
> 
> So dynamic are always in TZ?

Yes.

> 
> > TrustZone. This indicates that for Qualcomm devices, all resources
> > (static and dynamic) will be provided by TrustZone via the SMC call.
> 
> And now all of them are by TZ? Previously it was only possible?

Will correct the wording if it has cause confusion, I meant, currently,
some of the chrome product supported in upstream has resource table in
subsystem firmware while most of them Qualcomm SoC supported in upstream
does not pack resources in subsystem firmware and rely on Gunyah to take
care of its static + dynamic resources when it is present. On its
absence, TZ will provide.

Will add above thing if it is not clear.

> 
> Srsly, what sort of AI hallucinated slop it is?
> 
> I think this is pretty close to proof that your submission does not meet
> criteria of open source contribution.
> 
> Did you run any of this through your legal process in Qualcomm?
> 
> I don't trust any part of this code.

I don't know what made you think that way. There could be confusion with
my writing and may not have expressed the thing i wanted.

> 
> Best regards,
> Krzysztof
> 

-- 
-Mukesh Ojha

