Return-Path: <linux-kernel+bounces-600738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67950A863D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6AC7A7706
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E324221FA2;
	Fri, 11 Apr 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJUUjNvP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B783921D5A6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390678; cv=none; b=CNe4S/tc7jLNoRlen4tasUIbjyIh9kOA02GLr4cT8VTVYHk+eLNvonWFxPWSltKSb6eFKZZXhAbJnEyxpJNyQfaQ3rt9ZS4M0i2J9q9LvN1qxDcA1GnEZHgQYNpOStCu8A6J5VKweGazDOTW/NInoYB8bfCqQSgCmnFb12toD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390678; c=relaxed/simple;
	bh=g1FN5PT3e+DmJD0YyLOI2xihs5Hpfcx6Ef4TFtLLHO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt6GOmZfa+g6frnhjenOPVOHWyqRgudFVB0nTPOW/EPujYn/tWDsuT2NOG8+9pwJ3eP6rS5+psewqgkBvSCCfclerX3N2Z2OAFe+ONTS2Bew/uFQlFZuwXiz2jCT5gPq82ax362BU36dX1T2CDSePZHpHCQOUsUHxMLgn7XBeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GJUUjNvP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BFk4hi019650
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 16:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VKImoR0KichjLHhvcg5Snjqf
	fOPNM4U3wHwTAAjNnW4=; b=GJUUjNvP/hHF34eVZKR4sQ7plSnvlEqvQoctOHgG
	06hgN/Rn0wUkt4m37gC7xM2pcAgtjqxsrUsP5V1xxkdwaoWbn13lNNaCTF6cBIgL
	1hbqS01cBrACvy9/BZyCxS4+otiEy2b51QkU+7Atp+0+oKO96e4X4euBCflto1Fb
	FjQbFSROgqMhDd+P+aorWQHoDDo2WN1zgTxUu9FvyYVu8Wjx8fE9OHNGrKgrHcyj
	fvXrPITy20GpUsBbVxxbylRl6jp0qplP7uzEBSERSmmN032BFjfgPV/4jdfQOZHp
	kUJ6iiS0s9FfH8zZAa5Bispzr3a1QQkRsBReJqF5vQvZig==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcru7qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 16:57:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2241ae15dcbso25304795ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 09:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390674; x=1744995474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKImoR0KichjLHhvcg5SnjqffOPNM4U3wHwTAAjNnW4=;
        b=ikQX+wk7wn2slLl+9qWu8GSusTBa4wDvxBVKHtfuDJa/5DJ0hafUZInGkw8qwRut/1
         nPRwaVlXiQ4op7z8aw+ddEZk9gOj3BA0fjKzLtT2N6VQev1J3fl3jNlknxj/lct38yL0
         Y0zbUPi3XpFUE0PRgt+AwjQPhNzTpG4yruX/RZhRP9RHQslX942w+lQy8W2vad6mQP46
         wOoLD1iAztD4sbt+KP9L3mDRLqNRIehcdUnVdQKs2+JFY0MPj1AqgMGXb1jhMICcE/0V
         taYzx37yPodIDIKY1OincUSXOljGBUPTWalAt0tJoas3NbokSI+4dFYRiO9rD8Mm21Ef
         ykeA==
X-Forwarded-Encrypted: i=1; AJvYcCUsQNXKe4qzXz0CdpMCtfcE6kQsGG8yBnLBnpK6LEhNJP8wP9dOX4EuAmlVhFZgXvi0NiEkzVYZey8eDeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCeKR3C04aeRLQXOFC7z3E/MsUzIibkiOYb9V2effQs8bBOVs3
	t0p96NZo+/WfQrpeBQD114Y6sZPGB/6GqEWvwA52AAyzvIJvTd7i3TW1ih84JGgcbNN1vwmUGpx
	XHLYnAyCn4FJ74SvdjEzGk0X/3pkEDT77NyY08CWRhc2enuThdN+m5xPYfUnIUWpWR4JkK7M=
X-Gm-Gg: ASbGncvb5KCnNI0ABWf6lrfZxt/3ihTsIx/px7KaVlUVBvS5iBeg3QGxDvhz8GbWrGo
	75qsF4qwPdiaDp9y99sJ2zPhklyJ5k5qzD+fprV7WBtiROJRunif+k3XiJ8hhIsA3cqWmN/a301
	w6lAao4iJUbXODTwHJ452C3FLF72l+9U1xz6AeUDgBCZqGQ15JmhTntiKL1IZvcK0NZlqUyfPH3
	zTQb1vAHwHoGwpqUeQEEHosJFntkZiLqK7K0ySz6O0U8Xs7YfYqokF91+7QmwyIGWoS0mQruAgj
	yw+7DTAVLXOwQ9NT66XNNI1ddGSugQ/3av32btk=
X-Received: by 2002:a17:903:189:b0:223:f9a4:3fb6 with SMTP id d9443c01a7336-22bea4a183bmr44301125ad.11.1744390673866;
        Fri, 11 Apr 2025 09:57:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUVDTk+yzucEuAE4WKGO88quhWCVXvQVwZn02WXJ9p0EoVjVInbjnjnp7hGMhEFd7TQFVmsg==
X-Received: by 2002:a17:903:189:b0:223:f9a4:3fb6 with SMTP id d9443c01a7336-22bea4a183bmr44300835ad.11.1744390673449;
        Fri, 11 Apr 2025 09:57:53 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cc8daasm51998795ad.210.2025.04.11.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:57:53 -0700 (PDT)
Date: Fri, 11 Apr 2025 22:27:49 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] soc: qcom: socinfo: Add support for new fields in
 revision 22
Message-ID: <Z/lKDZFtJEQEYbWd@hu-mojha-hyd.qualcomm.com>
References: <20250411095025.4067964-1-mukesh.ojha@oss.qualcomm.com>
 <20250411095025.4067964-3-mukesh.ojha@oss.qualcomm.com>
 <a730e112-b3c8-46a1-a9d7-186d22a2479f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a730e112-b3c8-46a1-a9d7-186d22a2479f@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: FS-JitBJBk9Y5abW7ukakrSICKDF9nX3
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f94a13 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=CieDfDEW6uGNFcNvMxgA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: FS-JitBJBk9Y5abW7ukakrSICKDF9nX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110106

On Fri, Apr 11, 2025 at 12:01:48PM +0200, Konrad Dybcio wrote:
> On 4/11/25 11:50 AM, Mukesh Ojha wrote:
> > Add the ncluster_cores_array_offset field with socinfo structure
> > revision 22 which specifies no of cores present in each cluster.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> 
> So with all three of your patches, you neither introduce a user for them,
> nor even expose them in debugfs.
> 
> Please definitely add the latter, and let's talk about the former.

These all revision is added as part of latest boot firmware's socinfo
struct version and that also necessitates updating Linux socinfo struct
version.

I don't have a problem in adding debugfs entry for all of them however, I
don't feel the need unless there is already some user or kernel space code
using it.

If you still feel like we should add it, let me know, will do it.

> 
> What's 'subpart feture'?

Ah, my bad I did not explain that field in the patch.

Subpart_feat_offset, it is subpart like camera, display, etc., internal
feature available on a bin. 


> How should we interpret the value added in patch 1? Does it expose the
> higher temperature threshold in degrees, or do we need to add some hardcoded
> variants for each platform separately?

As the name feature suggest some of thermal policy could change based on
this value and currently, this will contain only 0 or 1 and 1 means
its heat dissipation is better and more relaxed thermal scheme can be
put in place.

-Mukesh

