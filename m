Return-Path: <linux-kernel+bounces-865323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D4BFCCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3103188C0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82B34BA54;
	Wed, 22 Oct 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PlhLj2+9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39D34B42F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145915; cv=none; b=Kta5J8NKjywRSQezAcMVaIScR9+qqWEkmDhh5UwwfpGBWU4P5V8WDsDuonNDMJizYE5xmsTnDhQhChC3+fbC1n8xnw486rf5Fi8mPF4zl0szbgXlhUhOsCjDbTPhs0uJhUQ8/6csMZSZg6+AoE5OYHKO0a76yPzjPWayAV3fwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145915; c=relaxed/simple;
	bh=kJKt8lgz3AINCzfVP+bT0fSkZSZDADfgsy7cFW+DHYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPcx1aOIX3Cc8miJ7USKL3I0pe2+1WKJWKTtTWTWCuzhYu2VpEZk9kKJ9mq1mfskGUv2Qu9NLvSZ9OHigjrn5+tJM6CQW2O3Zo4H54+THCwHZCvRlHY+5P4BvVqkedQpIUYXKp2lQIGF5bBoUgrKnxjDsaBevAdFYdDEEukcMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PlhLj2+9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAQB8N005242
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6hiZwjXaqgofJGS5eH3n4ygeKuepcGSGKuVfiI1deRk=; b=PlhLj2+9VFyDqWm6
	7WNuEHGEGIx+6UOPFojVVXYucQmPh4VT4vy+PO41KygDzqRXRAWlOT30xcwZvI79
	JjHP/jOMc52vGcwFTTXwYVGUYDXp2zFVBGA+ueJ2zLjfRXYh7/hHUEo3c6APsiAo
	zKCkxU7vTd2NKn8nLWCstG3dQqfGfS8z3Hxwtn+mk6VJsz7h+bqhIJtTf4yRFMNN
	pZNi2Wu4jMsn0iR8eKVCWMIdrbUr8VKlTgApP8P5aCi5DqSiyPzmUBSrveWb5h/s
	h2+8DsAvUtbJmbDO600uU8A4g7RILGKnn/UnRoUtAzTHT9Ez1s9fh6a6Rt+H18Id
	xThydA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfn2qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:11:52 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-93109260c4fso11962885241.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145911; x=1761750711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hiZwjXaqgofJGS5eH3n4ygeKuepcGSGKuVfiI1deRk=;
        b=BYpne8BPdCwGYz3JJHQnXW4G3+dmFZsIA3+rNm8j//yzFM8+uQcwLpiE9WINe6aWjZ
         tNfQ5WpJ+DrfXUAg7oLyBS/ZjgUGU/n1MKrJ26GhIVM2owqKVb4tmOCDC1HDLdUZ/Y6P
         e5aoDTp5jTfZeztwl66RnASk/SKGQ+cM6l0sF/eRPFphwN06+AT5Fy7OsJtmD3OxAMT0
         QPD4RRGQUT1zguUIVPHSTtv9qCTwyDeOIWYZH8OlOuWIE0Sqce0IN5KeUdSO9K16f1Dc
         9khOVSDbcl3JL3T1yTgnrRg7lfaDprLDXiAum9gpFZhsMj3N6huVpcNT4rGB1Hi9wM/M
         4mPg==
X-Forwarded-Encrypted: i=1; AJvYcCVk5YN41N/NTFHt++e/5CpGUFpdm4golRDSqpZFqnOTawSVh5CMduEv2o2/oEon5yiddJHxZFi8eFIomBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGUBo6ZjWF2fwgPDZ8xpB8IFNDNCMbDt+kQ4HS/EX9LYxA/g5
	aViBnxhzPZ4ysTCeEiC2hTSg8P1Be8ikitks1vcGwRMX48IV80tekFYD4idJ0D/H+8923U0Y3Km
	qxvGw/kvjUjspGxQ7Ml/u9L0KnSt0KNHzEx907k0qu2E7hvQbDNG/a3ULrqiInrl9Wgs=
X-Gm-Gg: ASbGncu3+DNJ47Smyh6xFJOHRGW8TzOOzdDT6UVh8ckXLlMDd6YREbWm/E2kJRRoaqy
	KOUNBZ1kxPHQwuLBA4R+mBREJMr2sQy7fjtpaR/e+8MDXCy+VoVnjPfWYzGW5d5+izhP9dwBcN7
	/03GRs/4oxp0D7JNmS8HiVFJ07ops+U6xc7fK6g12ALiUjQk/tu5A8VXJGQObChSnSx/zdyMwtX
	pO9Mkd1aWOoWU2hRKmcroXNMlyV4awuGzcCC/QoeFLBzcB++isQ0syY46LT5VUaT3PMboLiUmVp
	ilaeLppElYfDVh2J1tJhJ1aKbp7ShQiWWCHK79Co3PTBtyryXUfdK3gKKTGQ+28iafvQYqPBKw3
	+IN2z2sUzsPmr01YPR+9GVo/PLaTAWHds5wR1ppTFUuOJXrV54/iGUvPz7TR0ak0hMfT7sW+ZMZ
	FRySoU9AASQFA=
X-Received: by 2002:a05:6122:469d:b0:554:afe3:1fc4 with SMTP id 71dfb90a1353d-5564ef30a63mr6957798e0c.9.1761145911004;
        Wed, 22 Oct 2025 08:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPhrVnG/2oMiJ4rqpCF4qpoLZDW95Sa1i4rJVKxuoxAgakl581z6U7Bbttq6QPtplgJNJpDw==
X-Received: by 2002:a05:6122:469d:b0:554:afe3:1fc4 with SMTP id 71dfb90a1353d-5564ef30a63mr6957774e0c.9.1761145910557;
        Wed, 22 Oct 2025 08:11:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1b2e9sm4789860e87.86.2025.10.22.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:11:48 -0700 (PDT)
Date: Wed, 22 Oct 2025 18:11:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] regulator: rpmh-regulator: Fix PMIC5 BOB bypass
 mode handling
Message-ID: <xlki5jwurnixdxaph5mtxg7sfks2cww3xbswgtf6dbn2z72o2r@smx5hxo6obxj>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
 <on4zcfs5qdaekc7teo2iq6vpw7o2mp6yiqjkbznxo7wcxgutj3@nb35f55fkugv>
 <61c299af-c4f8-47a0-8803-306c08792b17@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61c299af-c4f8-47a0-8803-306c08792b17@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: pRLLTbgcvHs66o6efblZZfD723ZiT2sS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX7BPH+Bfc8Br0
 UIFW8QXPkOB7oM94+w4l2k2rMLyfXYs1BhoV30vqP2AAFwlPOKlZFvlZ3NNMDix+Py25OlHT4VN
 /eZx3rAKgK5Pwx1U62g8NCw0F05ky4VH54KX6dgH5NJij6O3QEKmVdb7LbHg0+7lw0I1+AjRFn5
 fAE3y+LyahBfuokpP/uq3Zk98kCvvc8IeoXwDBXX5B2vIGBQJ4XIbg3DNMJoANkAc7ztiGM78WF
 Adetp/YkDcBCTPCnalQwXj0uEX+TLZ6eg97WMNlhYKmQqiNOmczMJBeTvmuMa+cJSRK09SjJipa
 qnCwqldEan30zQLsa6LZiKoEugYomtbB0RyW74QAdxW0S1QPFPWQgmfVAtESvEH34FWT6YImRnl
 gFqOJEBu+ayhZIHCMWKVgwxOjUygCQ==
X-Proofpoint-GUID: pRLLTbgcvHs66o6efblZZfD723ZiT2sS
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f8f438 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=FG6qvep-uaCpXJXLnlYA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On Wed, Oct 22, 2025 at 04:58:15PM +0200, Konrad Dybcio wrote:
> On 10/22/25 12:23 AM, Dmitry Baryshkov wrote:
> > On Wed, Oct 22, 2025 at 02:38:53AM +0530, Kamal Wadhwa wrote:
> >> Currently, when `rpmh_regulator_set_mode_bypass()` helper function
> >> is called to set bypass mode, it sends PMIC4's BOB bypass mode
> >> value for even if its a PMIC5 BOB.
> > 
> > The universe will end, the Sun will explode and Ragnarök will be upon
> > us. Please describe the issue, why sending bypass value is bad.
> 
> I think you misread, it sends the magic value which corresponds
> to BYPASS, but one that worked for the previous generation

I just wanted to point out that the commit message makes a statement
that it sends some value. It should document, why the sent value is bad.

-- 
With best wishes
Dmitry

