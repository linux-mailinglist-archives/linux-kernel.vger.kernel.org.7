Return-Path: <linux-kernel+bounces-853435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93115BDBA96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D251A4F9921
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E65283FDB;
	Tue, 14 Oct 2025 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G2Vlhn/V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7F1FB1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481548; cv=none; b=p/JtL5Xwg1F7RhQhoV84BNSqk6uuyZlQ6oC4n5NyMFAUNRcZZzTKT1QttVoQvhjPwW9lL05XScz7oBiIzOrbqGABH09Z1o8AjLN9w4dY0bB5v8QDBZyy24TLtNZNi56jcaR97W4Y4Yc5NM8oLNSTr2WWQBQsDe0XA4ztiv3jNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481548; c=relaxed/simple;
	bh=LRXf7zoTneh0faYdMnc0/LhZFo+UjTTolWI46Z9U54I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbH9dS14gA0QVA0SeMcK74ltr1MZ8pbEM+JdvRuS7n09dsXNFzTtoNUoOOFj4FlaCUmzDkosY9IznyYL09TqN2ifXjAIo/IcSfl0U6QSIoaxo8e2mg2I7/iOdap5DVpVOuhzE5k+RZD8cPruOIWf5sEUL5Gw2kQnQIk1iWPf0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G2Vlhn/V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKR5KS014428
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=J8qH2hDTaqud6En4jAAuso/H
	AaC//gK/RbvrpvFRBGk=; b=G2Vlhn/VVlT2+0iR3mUUveGo0Xi3ZP2jMDV/npnW
	KAAFaUXW4rbTooFCuzfbQTUgv04Go0dIQ3SmOY7qNNHMYRmMpxGVjEH4sAFKVWMi
	NPBsvSwohMiekjw4d5ghQTvvGFcitRKlUgJz2R392MFPhPu51IabAtyzbL6peHQf
	XTrG7nlTMIRI/4FFeAK1anEa2ajBxCAvbFnACEcgD3angnETVPwCEFpxB3P4MLTe
	GMlZiIf4gXve3baATFl6DrgZS+B2gZJli8s3lq+MMtbkpU3AXM6+A0jzU/pyIT+D
	FonX8GX000CL1xFiDhZ8FzC0u6QwI2QaN/jO2KIJOO0rtg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwmhen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:39:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8544316ef6aso1526631685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760481545; x=1761086345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8qH2hDTaqud6En4jAAuso/HAaC//gK/RbvrpvFRBGk=;
        b=uVX380cUNMU0TuUfuwqKHZutE42PXPHTZ8IhETHOyTUg8THLYq5bRilK7jRQcQ5orB
         DwtngI7nl+iUDW5CzfgrbQcZ1/Bpay2lER3REykHGK5IplhqYtP/sMIEZKeuQWFrZNyf
         uBxDRYyvAdwHN+2vu2bhNNqIR+jKcftoMnjkowRp/nSAsMkbkDut7Di5gawwW+enRtC8
         XQSPa/t07/DYmFdQhRee9mK+czoFcAS5QuXicFrrKFVnkSl0YqrBtUgBAEYxWlZQBrVX
         K9+0UsmMuQfCRulkp9GTcv+M6kJXEJOAjUF1YyFdbjseAOkYDY8uWGW3IkV/k8dELgbw
         Vnkw==
X-Forwarded-Encrypted: i=1; AJvYcCWwbqed194FO3MheeGSA/IbzJB4bpShOlSn9HcnjC3Jaiz8OesPOzVGxLGzm9daFWSK/fou5iHhY3Y/H/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RjJo6IuIoL3y/teklnYWRpiXsbW1germkIn2DGR5EHJjtiSQ
	3QwDk9OL7XC7L5jH+MCn1kMzA/x65Htx++x8yFlUA6pvaGQfHXveXQGESndpMNKViJMdO0sGNVy
	4XiIpQxSqam3lRvD8t/0zKRyiZ12JEMTDTdPX0X81qEqE+DGy26ZwTN7NqsdSh8i+r/o=
X-Gm-Gg: ASbGncvO9x1bLKDclKgPc5lNcaE5l/N4yGrGNmqlX+jc5ub8mxDMW++usmXPMaWIYVY
	adkg05v+FEjZ7276Jw2XxdYIbW0HGB4iYJ1zEFSdRTQZ8u9T4QYiUOuL186bJmJIjwlOYCQqZUp
	fZCQsukLYQQY2sfnuZ8rVhOw/fhIQOX/NotbYOPkBsBMw8/fjmr3uNao1C1BjTMD9vnElgHXOql
	+NL1lRNLVBtlxYOLOKlBxop9HwBs+LYOPELZqFSJXqH93TwFWVgKPnXQ1zEIwKt+S8B70KIeDXr
	cxH7b7kMuQ2Q1TUjWP8htnGWVS/x9oTDFtcWHK0Kbv+rzElpt5P8mNoBT6zndxjGno3OD7KFbGV
	oP7ipN9m8Bnp2hEAnDVzWpMlP4REam3+2OUA8k/SwNwJSoHtfiPcA
X-Received: by 2002:a05:620a:468c:b0:809:eb12:1ea0 with SMTP id af79cd13be357-883546e2601mr3663313485a.81.1760481544560;
        Tue, 14 Oct 2025 15:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxH5DvJku+UB0VHHWUK6piGxCPJ1l8jYzFuBsQSJN8q2+dqSi3yQpT3dZOzHDbmLQCFlEOXQ==
X-Received: by 2002:a05:620a:468c:b0:809:eb12:1ea0 with SMTP id af79cd13be357-883546e2601mr3663310285a.81.1760481544017;
        Tue, 14 Oct 2025 15:39:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563c98sm5645388e87.74.2025.10.14.15.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:39:02 -0700 (PDT)
Date: Wed, 15 Oct 2025 01:38:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, joro@8bytes.org,
        will@kernel.org, saravanak@google.com, conor+dt@kernel.org,
        robh@kernel.org, mchehab@kernel.org, krzk+dt@kernel.org,
        abhinav.kumar@linux.dev, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Message-ID: <nhq26qmkbaycrnw64nwur4pufalurtdf6pyecy5t6vzoncqe2h@mxzwvzuaepmb>
References: <nzqte4glwtpjs5bhkxz43yhdufelxvqvzmg5tepudxwetimir3@bvlw5csjizsh>
 <9d3eeb9f-b8ea-48e5-a1d9-0865f63ef991@arm.com>
 <fhb4woejzh3r6v5dxvdiopnsbuwstucfuuzbiymxg4wrxrjc7t@dt3z3utq6lwd>
 <8d88cd9d-16e8-43f9-8eb3-89862da1d0c1@arm.com>
 <hOs24ZavnUyKYyNwBWwRpYnrsefzBfp95yuy9zyp1ByxR9_3VacGX1Yntt8pCE4w3gllPwvevs1AZqghmwKoFg==@protonmail.internalid>
 <zcgn4xw2xghyna2eysavujbzbiydyki7p7upzzv7one5mdyjy6@sj7f75kc4vwu>
 <fb767586-a376-48eb-97b4-bf33061642b9@kernel.org>
 <a4WDx80rJP1GnGNEK0OOD5lh-m-MiAvireXdpiM9ETLKZ084sBJ2UthU_QqRbU_nwD4XtsdiyEqQ0AhxguzJ6g==@protonmail.internalid>
 <6gx74wxie4wcabq27wo5y7v36uuurez4jxlzanroepqazdlgtw@sdtv2ld47d3q>
 <fa3c1732-328d-46a2-8514-2e7f9ca6c63f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3c1732-328d-46a2-8514-2e7f9ca6c63f@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX4bWq2U3X1nNy
 W75fBM3/AOsjOf08Sn9+OamdegDhZe2yaPeotpG4ORroqExAgsE0yiECdM9nOU0ANqLz3VATqvT
 /O4myau11pwLUvs7xCsnctZ8IagBApwNVImuvBDZZmY0LkPnyrCF8pyP2avHDKiKjfWih2doyal
 gvly0GGvwDz2kCsQ/+ImW6mU0loN2nss4luixWFh4wuxWUgzk/RfPa7oI6DnEVymvEyyz361j4h
 CdGB5r2eCxlmg11zeXAWPtTHPdbOOHZbuHDJ2pyLedy1et5oufidn6b/9WUmQmXlV4mKkMA7rm5
 ZgpBS76KMrvDvgeW0rb9MsjQ5t9KxsQk6lFTtmLaHUWDbFgaPDdSDhesEe2V4RKIr7gDAyMGJGO
 3FxR8NcGHhs3CRdGqdJJ0X68tZXjfA==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68eed109 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=GN0BuYHDo_BzztcbwqwA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 8E7yLOkkS2UK5X6f2e46OJki3n8-9PvX
X-Proofpoint-ORIG-GUID: 8E7yLOkkS2UK5X6f2e46OJki3n8-9PvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On Tue, Oct 14, 2025 at 09:49:17PM +0100, Bryan O'Donoghue wrote:
> On 14/10/2025 19:35, Dmitry Baryshkov wrote:
> > > Each function id can be associated with a device and a compat string
> > > associated with it.
> > So, which part of the hardware is described by the -cb device? What does
> > it mean_here_?
> 
> The non-pixel path video encoder, the tz video encoder...
> 
> What's not clear about that ?

And anyway. The "non-pixel path" doesn't sound like a piece of hardware
to me (nor did it to Krzysztof, [1]). It is just a port through which
the data is being transferred. The encoder acquires pixel data through a
pixel port, processes it and returns it back through a non-pixel port
and vice versa for the decoder.

-- 
With best wishes
Dmitry

