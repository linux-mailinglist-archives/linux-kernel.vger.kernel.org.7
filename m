Return-Path: <linux-kernel+bounces-752555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63615B1771A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17395623A30
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0232A8C1;
	Thu, 31 Jul 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzbIiL0y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519201DFFC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993411; cv=none; b=Qc/7pAASzBVGdd3kYIq9ozeByg7quUt5aHsI66erZG4FEiNDoXIRlLp2Jbc02LrHUslLs2xa5udFK0g23ENdPNUDryOI3LWXDSqDxtL8M5zwRGoU7n/j6Ycz/+VOEJFaLdchgn7mPvgIkjdqTlRAqpvk3U6beN6GeTV2ESeWH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993411; c=relaxed/simple;
	bh=6BS0/r564Mr0wQVda1HbGywe5kFCQVQe9P3LHKToAII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6ZWufJlibJk6XBkhSFbB1XkGzTVqLZokyZ31FAvoKmTofbUoqhIegbpq5qCKiWUKfVxAwWHKFmnA2FQfkTK4MeuvhqCpMAfA7XHXqo2y/JwankgWiFmgHZ4CmXh8X85BdTw2QXQG8i1dY6r+QcntNgP4XAfe4EdmmGKh5fmFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kzbIiL0y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDf4ke018848
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f3HxypiWDDr8xm36nB0lYGa5
	9CbpmhkWZfBSL/BLjek=; b=kzbIiL0yy8yVyIUWAxXKQH8wuFSA4jEYXZwdNKeG
	RvS/AWunvMNjXh/hoAV9g+HiY6YSjpEooc7GLtFtaGj4q8hXw14+b1usXyTw0tEb
	RS1eh99MnmuLA44CMh/ICBFFHRkKTvqAspX+dK3tPYoOfb0Er9PwBk4iNZVtdt4S
	Pw1FmPzhwq/wQqneU1ns52m6GJ9OAm0pr96KHGuMCXQgq3qqPsfbiCfIQ1Ti+5Jh
	QEniM2WutaxUOXU1EnDOl/KDQ3uXLU7UEKyFa71cJC3TuZv5YATPKDjWCqQGkCup
	TZZypUQpE2BVSKd45nWFUi+P3kcGi76mGpJaV+GbBqphvQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qda93td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:23:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab752e0af7so25956181cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753993408; x=1754598208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3HxypiWDDr8xm36nB0lYGa59CbpmhkWZfBSL/BLjek=;
        b=MPnJ9P4HhpiJNqlyPBrJp/haJE7FnQijnFe+zQGNSZE2mbjW93cpZ9PGdVumAi6NIA
         pfNU+HkJ8mmiohCWBjS1iNfzVNsMN4XDpvH9rnz7WKCvcIBtv/3Gme3pMlbPK7tB6T9b
         JyMYRXZP9VO7GEwe+z3mZkLe2ShnKr5+1T7eXd3KKNnTC0o7yI850uy+f46P3ZyZaDNs
         Vpc3F+TR68r62QQ8oFEAGp/5D0H5Jrqbq81lvMKA4ZUifupMkgbwx0/WL8yAVxQUi0kv
         WSdbiyw7pc9oIrnKFJknqR/o9HuZGuEiwzbD3xRP9dqjrGNgv97K9Jed+TSd474cKzIn
         rE8w==
X-Forwarded-Encrypted: i=1; AJvYcCW6raFZxqPBg3eUFW8VgmRlxeSB7/fAxwe54Wzpgjh9knzS6GfmAfUVHhTFkhRLhhP90GXaCLaLUTMHS6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlNa8ynl9wXVJGrAuKZuHJQpHnjVyem6HwaEcCcLNrvdAJlnno
	j2KD22qVRF2/oJYTTJ2V5PVfeMInF3J5DtH4x3u9zgqLn8X3VVfuX2gev4n7bk/SB9JEpv+Qd6z
	xnBjLeEm7690eCJvz3wI1JBni5y589pORuy/hF7AUIW2VmuBOJKxheOH17O1iFM/vi3hh84kA3R
	0=
X-Gm-Gg: ASbGncvO4prqcIpuTTLOWUKE/F//A/pYj6nNRtB7Tl76gKdx56eaZvdL9SUZ7VKvg94
	mAWEbMPONPg0FoIClOaCFGk/LHHcDnLonL1g45EQBUCCRaLigMEHrLvYXW+OqG+SvaM2mbAtEjN
	k0y35I5pUM0lB29bHC3OkiSZ0jSntH+Tlf+Fa+vrWtsxB3uGxQJvvaky79vKsIxadXE3/MIMt1b
	EY9nlYfEtVP2MJtV6rAhAig5if0TrqcqbdNcLhk9B9jrb0elz0epoPnJMWrmm0Cxdc3ds5zXsc5
	+0ZA7Zh7KLS0+8xtQVIhETn+d3u73vaqcDQOkquQtJHqA0Ek6UYg6khO1LDYTiHjMXOLMTHuSAI
	6s6kzpfaLo5I8tcZlBIyLSxHElq3RNcvciyKl/Brb3FEP3Z1mJKiO
X-Received: by 2002:ac8:5a08:0:b0:4aa:827c:1347 with SMTP id d75a77b69052e-4aedbc6d40amr143765881cf.46.1753993408167;
        Thu, 31 Jul 2025 13:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGMGIh1Gf2+K/S5JsxxWt05bE+b7j7MOvdw2bdF3UYcUhqsNNUsy6RcMZ313EFuyJbcDLkUA==
X-Received: by 2002:ac8:5a08:0:b0:4aa:827c:1347 with SMTP id d75a77b69052e-4aedbc6d40amr143765371cf.46.1753993407622;
        Thu, 31 Jul 2025 13:23:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238946f76sm3187081fa.84.2025.07.31.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 13:23:26 -0700 (PDT)
Date: Thu, 31 Jul 2025 23:23:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Val Packett <val@packett.cool>
Subject: Re: [PATCH] soc: qcom: mdt_loader: Deal with zero e_shentsize
Message-ID: <zf5tkmd6mhhn3ktbip7vxeri6oozyswzit2a4j7kkfghnwqrwy@cd6dlf32vwsx>
References: <20250730-mdt-loader-shentsize-zero-v1-1-04f43186229c@oss.qualcomm.com>
 <490f9017-629d-4c19-8c2a-7fd106b4568c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490f9017-629d-4c19-8c2a-7fd106b4568c@linaro.org>
X-Proofpoint-ORIG-GUID: 7ahJMO5z4OeDJZt_7faV-VTjmu6AQFJh
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688bd0c1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Vn5WVHSVvbZXIGMPreoA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 7ahJMO5z4OeDJZt_7faV-VTjmu6AQFJh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDE0NyBTYWx0ZWRfX8xFnRqoC57vf
 qI3VALRkJ4RwHCuCL9rW+q+7AgJ9Ttpc8NRlZfO+tSQh9UY40SgXuCV5GYTCtpJNaBePRGwRji/
 kJkk3oRHlYxjlka/pIx8zlSH20dcVdFIYZeihluGPW7m7Yk9gE6YmCUmaSZtdblW4F0JkUbWXdO
 eCmqcZHiMoMBH++tFavI5Mb134KrFFACWuglXf5gQj3vtVvVauDovz4qFirbrW0+guNWmWdCvGQ
 m2XdKD8zJmQAyQIoZSUB/AQALbDPLdBZx9CYvoBc4Gz3Q+mBvfpeh0JuyXxX6/B0HyxXkSVgBb0
 oF8eq9Tk6Kn6sKeqTHiUxYdUMEl66mXsKMk/p+0vu0mE0UlqoOAJ4KEudFexxxaMqGo/XpQnh4Z
 X1Ucv5eiupEk6LyTkiA3UDj8JzcsTSrSWXZxR8mX9YsRHtc+i7nytCZy+d45TDZGnt73tJD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=767 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310147

On Thu, Jul 31, 2025 at 04:58:09PM +0200, Neil Armstrong wrote:
> On 30/07/2025 22:51, Bjorn Andersson wrote:
> > Firmware that doesn't provide section headers leave both e_shentsize and
> > e_shnum 0, which obvious isn't compatible with the newly introduced
> > stricter checks.
> > 
> > Make the section-related checks conditional on either of these values
> > being non-zero.
> > 
> Missing:
> Fixes: 9f35ab0e53cc ("soc: qcom: mdt_loader: Fix error return values in mdt_header_valid()")
> 
> Or it won't apply on stable kernels

Then it should also be:

Cc: stable@vger.kernel.org


-- 
With best wishes
Dmitry

