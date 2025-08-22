Return-Path: <linux-kernel+bounces-781525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA3B3138A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF5AAE50D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F404D2FD1CF;
	Fri, 22 Aug 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWVpWQk1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1D2FCBF8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855026; cv=none; b=IoRlOiIGLSje/QhnrR245BhMvTvqbgpGufRgfx63OJgZDfl/e5f3xHcDMf0sZe9DjHDjAP2uo5Ws9pYgv6SLOvKLfIN26rhulqjOO97UI5UNsgEHdqUf7JEYrypLjAwphifET7Nd9bsuzYmdlNHahVY0w3XhPV6fV8fUTiICBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855026; c=relaxed/simple;
	bh=DDOINDlN4zJfXeUV+i7J2/ny9DQpMWb+X2z1LIO2v0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHEfGmdY8bMxZ7Ir8Ujkvx+sVWnJYe/cbc/As1Jg0MRDOxy10YUWMYOnaDvWIcJF5sXAiWBI0notsgUbYLMlwiojtcyhP4lBSHbabyzdFlXGtjJDjkkBOIVzHYR5bOuToy5uuwguPD3MCUYXJd9TtSTlHi4DgNFBeHpo6QABJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PWVpWQk1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UUbw020987
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=apgzY6IIDslGxm2ZxHxgxxLn
	8qHnWA9Q7ouAHkWulDk=; b=PWVpWQk1s5S5VH+XVqgN6h5G1JwLdtQQbiOc7xJ+
	0avKZl8+BGCTG5VQkt+ZbnVhRAOZiNxwELWjL29adVz8OGkSCuSHBIkMRw8wQApy
	0eg0Rr2mA3MFwnDGdV/0on3OB6DgBwxkGBj7pRVprDS3N9GEvcnuDFpCxmYMztt7
	b8hbsSnIaivhLona9IzshfMvX4h11oLDijqNfiLDG/m2vPEGDLxgTtvQ/dqZ09z4
	W7L8GDZh0tsDNpQcc3i4ohWSq/4EdqArFvBi69DeK5WZWDwPF0+ez9SoHCFid/of
	F8yDHBND57vBPkqDmB6Vk9BFAT24AZn+D7inmHA4neCUMg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290q5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:30:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e5c4734so2165441b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855022; x=1756459822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apgzY6IIDslGxm2ZxHxgxxLn8qHnWA9Q7ouAHkWulDk=;
        b=fQ7Ijh6Dcto4kaIu9xeQNFI7R7uEk3n0AqfldulhlxnRrYf2CDsvFc8VH0v5KNNeQX
         5Go123zcW8U1c5BCYwShX9PIOybm+v+xKhOvNTb9OHYdIqyEHHQ2zaPFnulcOwy11QDU
         CvhzUjVOkybVFWsZZUy7/t3Heji49Czuby1zeSTAr40I3nQowVPWXPI+izs2dydLrDnT
         kgWOXPOKN4s4m9oyNO3ktMhawH9wpXk2334Gd5hc9kJ4UpwmfVXz2pKVqV13xW0BMLBN
         xAZqRZKervg3/youWdepSfrLpC0k8AniJRMBk1I6xo2GsG9DQhM9MPYzGiPYx8z7vwhl
         wDnA==
X-Forwarded-Encrypted: i=1; AJvYcCVS5IDGv3gXp+zDs/qrDEIVExZ6z3ImXz2I3dn6yGGAbOlWbgvCiYJE4G1a+1zJe+gJjtYh5vPHQfmQT0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7vbEKOV8Q8+6qCTqgwDcJM9MWaYBL6f4N0FsOnnrBu5ykJ1Ql
	2owgiUKlg8RLRfF+Iieyg1aDOCqJYv61itKdWgb8QeqRIT57M+8j+xpzPOjYeERA2zl4c6H7gC+
	3/r2haDrdEHR+k1s+NIKz79+PYEkLREXP6+8ZIJALx1SBLra7EDrTffmpaZvIGueJWtA=
X-Gm-Gg: ASbGncuTkSvsk90vV9wOTRzp+rjcLWUwY7YxcFPQua9swhuM2z5dvV/pOGXjBtn8ZGv
	tJTpuTJWvWi/t1wO0tOh2kHmnJm9JdRAKsLOEhbXnSWgiI9Ew2Mn6uJpvtJhPHLHZ1YInrJNuKG
	UpYVcfVqFH4DxI+GQ+wyV3MXddjRb3jWWdA+SFr0Ig6Om71SNaqJ70bUXI/skEf+Gt4o+2TrE/5
	c/0SmGDJNBox6qRQxxS6l2edyGpC+jT5MbkzkCu4IDzyA19gy/EIpSz0oVJ3oRoGMb6KZGl6c51
	gXjh+P085NQdSSTh1A3ygBUjPn42sMhcBeWN/7EnXilpl8IroV+QsQY4nG+2I2WKGhI=
X-Received: by 2002:a05:6a00:2350:b0:76e:885a:c3f2 with SMTP id d2e1a72fcca58-7702fc2d339mr2910843b3a.30.1755855022163;
        Fri, 22 Aug 2025 02:30:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPjl9du6NbhNGBRG4TzW7fpJP7yr3XTt7Akf+uqRroowTWYPJrBk6a36wmJwTgWdjLdbhyxg==
X-Received: by 2002:a05:6a00:2350:b0:76e:885a:c3f2 with SMTP id d2e1a72fcca58-7702fc2d339mr2910802b3a.30.1755855021746;
        Fri, 22 Aug 2025 02:30:21 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e894bc4d2sm8255639b3a.67.2025.08.22.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:30:21 -0700 (PDT)
Date: Fri, 22 Aug 2025 15:00:15 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
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
Subject: Re: [PATCH v2 06/11] remoteproc: Move resource table data structure
 to its own header
Message-ID: <20250822093015.snkxlspg2czzrmgz@hu-mojha-hyd.qualcomm.com>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-7-mukesh.ojha@oss.qualcomm.com>
 <aKWDXySSt57tXHVP@linaro.org>
 <20250820151822.6cmowxfsheqxfrnb@hu-mojha-hyd.qualcomm.com>
 <20250820163250.hszey3i2gtd3o2i6@hu-mojha-hyd.qualcomm.com>
 <a59da8d7-4e35-4af5-8b9c-96aaf1597271@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59da8d7-4e35-4af5-8b9c-96aaf1597271@kernel.org>
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a838af cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=DtrYIkIAubBs6YGxpE0A:9
 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: xor59kyD2zWpWyqO_aK9gIUcD-yniexm
X-Proofpoint-ORIG-GUID: xor59kyD2zWpWyqO_aK9gIUcD-yniexm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXw+g240fYjYPI
 JXNa5JqEzdJVJVOyeQm71Lm4M2VICftTnRKVsoMFpbUrjk3zHx9bhQCJYxEtvdoAELlx0bvg4In
 hFtAbrVXZDOAffc9sfrK82uPXnJ/YAAh16t3WG+AE+dn2LDAz4Kv/iwQ04fRK9a7uL5BFziJ+jM
 ye0tD1AJOCKZakCWyzE0Qvuq1TnOllnUntm+uphVyPXpBFtdZ1iRqf7Fduj/W1fKIsElmVDIqEs
 aOmt6H6WgXvVyH42acjY84onfgmKnvi87ny5nJ87+b2x5Z0uYuNO6o6WFiIy3YpDR6eXfl71tja
 z0qbRopUa+a3whtkux/PzRCZw0rkUD5n6F6FXy40yLd1DUu/AygYfCLiLWtSWLG85LKG6zTQ6T2
 yACE56CRP80H7k3fPDZlyKTfikvtBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 10:35:42AM +0200, Krzysztof Kozlowski wrote:
> On 20/08/2025 18:32, Mukesh Ojha wrote:
> >>
> >> -- 
> >> -Mukesh Ojha
> > 
> > Since I am not subscribed to any of the mailing lists to which this
> > series was sent, I am not receiving emails from the list. As a result,
> > your recent messages did not reach my inbox. Additionally, it seems your
> > reply inadvertently removed me from the To-list.
> 
> 
> You decided to remove your address from replies via "Mail-Followup-To:"
> header you introduced. It's on your email client.
> 
> Just like you will not receive this email (surprise!)...

This was not intentional and just a switch from mutt to neomutt where I
have added stuff unknowingly to filter things and showing inline replies
correctly that may have resulted into this.

> 
> 
> Best regards,
> Krzysztof
> 

-- 
-Mukesh Ojha

