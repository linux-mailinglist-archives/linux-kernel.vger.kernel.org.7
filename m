Return-Path: <linux-kernel+bounces-852278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEDDBD898B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6691543FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78CA2ED871;
	Tue, 14 Oct 2025 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EUj+0nu5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F4222587
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435509; cv=none; b=RBAfbS34gTmB/OTIlBpO2HTO4ZDOneANbYYdTEQeKzu/nlXG9l8Ez+BGTQf5SyMT1+KoKttSXpTFAeJqVdYQhDyGxXnRIy5szYDoR3/sas5nmuCiVC9YdkExX+vhYvyBv+oj5sfiSHal8bd2Sd1xrfz7KkZEy7X+aE3bLzdD3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435509; c=relaxed/simple;
	bh=HXt64+1Xvlydjl9pTmLXP6gz0dV1TLaywfmvV1SO+gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb2QKiIpuxIkGikwaaV94DSqDKChCxYJ0FRanlzhrhzFi1saHW2TNvfQ/w+VsJhplrDkOFEolQ3asP+SuZbuUvrCulwnMEe2AbuksafAJmgLSrqrtARAGAxLZqlHHPMKBrmL9Z2o1wvGgjumO/LZskgJQYwwBJ6g17LXqM7PI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EUj+0nu5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87KMZ016292
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PBxL3RtdJsu1S+FhleqKP4xR
	3hS6Z1oUg8unkEVuIQY=; b=EUj+0nu5lCKxxt4hAqAT2RuYpEFLOIsi2tQeavSU
	uoKZfx4PVnqmTjcWgrTaX//TP92ZQbc8Nw9kJAMG2GomrysvU+CGiLXPwm5DE4pg
	7QrivPWpL6oQmrCLxH+wAzVNhuhfsa0BCwTXQyxS5HknlYymVLTzCs4MuITA4Jvm
	+G7XAsRie+FZp1VyvFSNUHxdKC9cZMt2fPUr4pteQIcnhSAIKK9A9U+X11IK2cy9
	qNJaPvAlwjOLJb4jdtfOYk7eC4W7lr+M6KbRkL8degOzoN4w2t3pF2AvwthoYKpX
	NqAqhgYWjQxlvwcMhxKkX131cgKH1rPL+cbJtpn56EKIhg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd902be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:51:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-870d82c566fso2391808585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435506; x=1761040306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBxL3RtdJsu1S+FhleqKP4xR3hS6Z1oUg8unkEVuIQY=;
        b=KVimLi/P0iTeqx/GaudgujerMTn1BGq1r38RNV5dAXku05XabYDe06Cmc2+4GI/8ez
         skTIc74xQNeUpjQH8QP1fTvshCWOfhqATeq+bdrBxQCz0xYSjA3MnnhqsOTZt8ht86y4
         JoG4ky8GMqzfbqpD6UyoWo6fBmvIxJPISZYCEr1iq88YtvHNbdO3KmKnP/sgdJ0VsAuB
         Usx00RyGqneQ+QntgYEZpcHtgIshj05GVFpIxAkh32abhYuJdTa8SSt67/M2J5HgrOE4
         TEkfBtI1fhgUnCGdT+IsqQZhZv2ZbP/1pMa2a6j2wqDGf6398kUoSomOP8nXrymMlAk3
         EyAg==
X-Forwarded-Encrypted: i=1; AJvYcCUmyOykhNuh/lJoHQFk2qurSqEgxYY96H2D8/YoywGThza2lK9uAi0oLKbo2CrC8x8C68KJufzWVBj6Llc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxj/ZFY9233ZaP2kA24t4g8FGPPZgpc75Ss7QxPF+ZlLQxsZjs
	k6WhAmdO42IJYKX7O1HkagJTnsc9DXcp44wYEt00XXkAR3jOrn8m9dAw3aCYaB7Zil+qO7ZAAj0
	ri+p08unLIgRdEPkRE3zOlPM7uOwJbhVJQmINTRGmDFg9o0tXQ0gSoc6Y0jPoQ8XOSIM=
X-Gm-Gg: ASbGnctKwOWpbhnkrqc5LwOOxqKwYmcywg1qTm4ZC+GgCQTPNSZO41lGN07IszBLG8J
	hJetM+R9UXI/GF9BMsFeh/tLIrrMBH3sEkyo32uChaEewrlyJzuRJMAP3+BIcIOE9EyidAprsLm
	ShLq9cuEpNuwpTA9eUqbpiHhGOtTS4E9TAbfB5bihK5ryVb0culftpAomvxCR7aPT/K224cMrrn
	509KU5Iqooqu3OIuepXoNHxGangNRJV5S88kpeo0W5qgrDPIdJQWWSjyHuAviGETeOxteHQbU5U
	UFpxWljwTh+Ae1bEy/icJf9eoGe4GuQOBGtsVmqOfZbh+M29ZsfZYMZ1ObCwqVv2FRbErJIQSRp
	zQm06B+/lfqCkVzRrSdn/LJHBq1+zdLDcxeWHmvybRFXNDW99JfI5
X-Received: by 2002:a05:620a:4548:b0:855:4f0f:d782 with SMTP id af79cd13be357-8820d18e2d3mr3743664485a.34.1760435506170;
        Tue, 14 Oct 2025 02:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxVvkud5xjmzY3lu09oqjenWjIPO+wBq4K6gyqhY2hcAj1kfJyz99dhsusENH986ON+4ZCmg==
X-Received: by 2002:a05:620a:4548:b0:855:4f0f:d782 with SMTP id af79cd13be357-8820d18e2d3mr3743662385a.34.1760435505707;
        Tue, 14 Oct 2025 02:51:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e577asm5106216e87.11.2025.10.14.02.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:51:45 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:51:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] media: iris: move common register definitions to the
 header
Message-ID: <t5obao7tm34uilnzoa24shknvdtzqkc5uwek4cxwbof3tgqylb@jehfugyxvups>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-7-def050ba5e1f@oss.qualcomm.com>
 <b7eba4b5-1189-7506-4767-0ef3234fc6f2@oss.qualcomm.com>
 <dzorzudzpjipvlkwik3uylomwi2dy5ticxromzegzgi2jhibot@reqv5ul5ifuc>
 <3802fe42-0c94-8c10-7b6c-6c3adf863ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3802fe42-0c94-8c10-7b6c-6c3adf863ef9@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1gfXUEKFsoeYXY8q9urplnlr4nB4Yfz9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6qT1u6Y3SdWb
 s1V7PEg5hNMkyAcHtx5XLUZH3Xw03RNokYP/7ztZXO0Y1l9gRLerreSfEFrQJ0ZLDwtcVFaBASv
 sxzg45TeXTHshzSWzHu7E8XtiEfxe74G9oY+rM0kn0yYOVY04oxayj7HgAJ1HVr3MM4QQIIeOrH
 bT/aLXnEh59AZmZpqnIlqdAY6jtPBvGamNIRTBt+U6rjhdCGABqHEOusEPspTcQKml+tCu6NJe7
 ugTtPufr8fZqQq+HFm4BWQcmZl9E7ALws2/OwcDc1tFdIIJUqjK98hglS3pgN3nz2uWPrkBEv09
 ud+hcBbh3Ep0p8f0zQ8Jn2LPwZakTfDZNVQNRXc44Oc8p6o99FCS0feqS3hz182+1aDPU86FrBJ
 73YmmcqFphszgmJtlfRmGDGq6DuaiA==
X-Proofpoint-GUID: 1gfXUEKFsoeYXY8q9urplnlr4nB4Yfz9
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ee1d33 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=aQDpXfm0Yy41Go8ML2QA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Tue, Oct 14, 2025 at 02:43:56PM +0530, Vikash Garodia wrote:
> 
> On 10/9/2025 8:18 PM, Dmitry Baryshkov wrote:
> > On Thu, Oct 09, 2025 at 11:40:25AM +0530, Dikshita Agarwal wrote:
> >>
> >>
> >> On 10/8/2025 10:03 AM, Dmitry Baryshkov wrote:
> >>> Simplify adding new platforms by moving common registers definitions
> >>> from VPU 3.x and "common" file to the header with other register
> >>> defines.
> >>>
> >>
> >> Similar to
> >> https://lore.kernel.org/all/20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com/
> >> ?
> > 
> > Yes, but moving more registers. I can rebase on top of that series if it
> > lands first. Or I can just pick that patch into the series, to remove
> > the dependency. What would be yours / Bryan's preference?
> > 
> 
> My vote would be to rebase this one on top of earlier one.

Ack, I will rebase. Seeing that none of the patches in that series are
in R-B state, I will probably pick up just that patch into this series.
I hope it's fine with everybody.

-- 
With best wishes
Dmitry

