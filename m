Return-Path: <linux-kernel+bounces-832134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE508B9E6C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CC5189536F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE62EA143;
	Thu, 25 Sep 2025 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="USvucVEw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09C25EF97
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793033; cv=none; b=XU4mSa3bWXnzsBM8+a7ijP90LUhyGScvFnh1tnpIJv/k+GZeICUnfyhpbMvOUWEvutflkJvNM7/BlBFLLmj5BXvmZp4N1TowQkukTYs+wYvMTCk4q6AzP9a/i4kTLOKa+rFSjQU6P2vjCRRqf0hNvT2B149YgOwXb/Izr/ssDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793033; c=relaxed/simple;
	bh=zamVv0dXOTdYNEn2puE91zH5uRrPdj3WMXEeHYVBzVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijCJwjkH/pj/YyotveSJCSn7eKwKKYvifyWIsMviMEA7gFyPnJa4s6gr0fu2y6L8pcBQaNgiMjyIYlqLGUp/2/SP5mdqZhzzwxqtHKGMBhIR6itVp1bf0gIDhfcmccxLU13toNMs5odhqtIB/6Z4FzAZcVzsFEEMmeENgLStFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=USvucVEw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9XqsU024010
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zeVa0WZkgGit33CQLVzL5GAxI4BelhXE8gH2cuvDak4=; b=USvucVEwWX5vGxBE
	LVg5Xvi7Fx4WN8BKLqsVOWdNAE/TH+j+AAY6a0N3hJ6B48VvYBi5YQxG+slFxWCk
	+q6x5cQ/BVELtr46VFsWKY0szkEVY42G4QaLF5avDysrH+8ukM3os+BqKS9OMEY+
	qy91E90w4tAHlW7nbSAOZsOOt7/2VHcVMes+nhVa6YUAToMTnZfgi435xk2lrKWc
	ANrhFdO2vg4T2QdlnXrKhIm/JtbkKYYjauYCX5wV8ow2JRQidVJXrvrWfEaYPuGK
	Kxfg8zg9Lip8NfNdR23vAmM1f1ECL+iRg9kL8qAPZzYWLSHEY5aKf8KeQfklB/PA
	BgKUqg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0emd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:37:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-819d2492a75so38548185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793030; x=1759397830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeVa0WZkgGit33CQLVzL5GAxI4BelhXE8gH2cuvDak4=;
        b=S5lxAT/iLWD07CPiGxGyaL3NqTxK4G5iB7MFXUovMBRFLnuU8KEDIuEOtrCGCJJlQI
         4Ohcj/kobAyTb5Izh+gWaBBvb8GyJkNY8B8QUU3A0aT9C7u3BRe4KUwD4yWe2TPCh97O
         /QLxflJOjfzIflIUVtwncmUNywBs3NYZUYx6GhSIpTlInBMr3N4CcO27lsZqI5ZuCb6h
         iDrkHyEQ+hvYn5qCl8UlJODcBEW1vSrOO+wqhEMXOGuSfBZlR4XzGzi19qdOdxEpWcGQ
         8NqzouX3Sl8B6H3Sas9QZtoNJTjqfTo1Z5HOZBwJtsnfNAsGAtMzw6qIY+g+ECq75IOJ
         Tkcw==
X-Forwarded-Encrypted: i=1; AJvYcCWi+UC8GaNEk6CYINN6P1c4xTLQq7TGOp9rSk/hIUDIxHRsMsi0O4IEQXwUdK17aTlHYpfzBM98yEYCd4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNoLHW7LIFlYogTv4e32exUG8QO3153nCTtaKYKz+D7SwMaPr
	/m/jGNykcWMCr0KsxTNChRnScVUGCOeejcKPdLsniUfAQEGBaNs7DU3VEj/RYA1hDql05nS9860
	w1KavPnkbs0Qu8NW9DNbZMtSkjxDNzhkQYooTvTGpN4N9+U9KvY7aDtZIY+kagXdakPk=
X-Gm-Gg: ASbGnctTEtH0QbIuuT+NAu+sxYU95B/DBGp+AKLXetZIXbs82W07aL3C3Vmm0jQxahm
	urX8uEby5VClu/gGKh5+5yP8S22358o12kJarfP5t3YXktBNyHnjKOzrKHvsPe/VVt+OjStYAB5
	U8IuCCEtBqmpe7pdPFAK2PTKnbSSl34gSsAiPVx//9x4qbUBCEaZYuysn5ZA4A7zqlmasUitM9k
	KLpeNqduPW/95VIAAjMBSAIcJcZPEd7MA+sXLOzKQuYsfBRGicm1CYd56a7Z8vHUb+SnhPyrc4I
	x3UnJ9Ms42jTHPRimpst8/h0BQOz0iSCQRy6v77YjEh1YZYuw/Rd4+BmlnS2s0OuOqs6Q1QDDwW
	Enc/evbvRdnPdv083xfg6ag==
X-Received: by 2002:a05:622a:7616:b0:4dc:15a4:60ae with SMTP id d75a77b69052e-4dc15a462d0mr1290911cf.4.1758793029526;
        Thu, 25 Sep 2025 02:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhWYbhiie+DtdNK2tQZ+Tuc65d9LphLjEc6TZpsNJ8FCEHPxhcyKa4Sn3ApENdJ4f9vHV2Lw==
X-Received: by 2002:a05:622a:7616:b0:4dc:15a4:60ae with SMTP id d75a77b69052e-4dc15a462d0mr1290631cf.4.1758793028998;
        Thu, 25 Sep 2025 02:37:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35458950edsm128031966b.90.2025.09.25.02.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:37:08 -0700 (PDT)
Message-ID: <a078c6a0-5a54-4ad5-8e3a-c676783e68a3@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:37:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add OnePlus 6T display (Samsung S6E3FC2X01 DDIC with
 AMS641RW panel)
To: david@ixit.cz, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding
 <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20250925-s6e3fc2x01-v1-0-9293016768f7@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-s6e3fc2x01-v1-0-9293016768f7@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d50d46 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=CYF1pGrXqkiHziMhkFIA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: OfpW2XzhZfzUUcR4kecNYo8e9z9hYz7x
X-Proofpoint-ORIG-GUID: OfpW2XzhZfzUUcR4kecNYo8e9z9hYz7x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX1CPMs5mGnAfL
 U+TDk634z0ImFoExBPgpRXe8NE6j7O8GoGpbRtITioiSfQJgOwGFFV0GAU2dPJZCxU9aiQKgqQ8
 YrWcwG8oiwJAsdntERoqhGkEiOdbKIroiNYsZhUOG7KYKslZDV23Jw0yq7BSeTglTs9bSon4PuG
 Mbyp5qoPmlfJL74g8hGkmbIyHjyvrDET90Eb6OHF8mXIoJCc1iHxAg+hudj7rlkKVojqVr4brNu
 pSK+ZpVo9EIRWouzr6D4mtjzyCuxnSr5kZysV++coUgHZGvKBkf4rWh74V7Wj6EmlpiZmk/J5Rz
 2+oel6232qZg8pKjMVY5O+rjtp1BqLNh5q7Ak23DSrOvdjx7f+3euelOWh/Rluvxk2uPzYlvrDj
 7Wc0YpWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On 9/25/25 11:12 AM, David Heidelberg via B4 Relay wrote:
> This patchset enables display on the OnePlus 6T smartphone.
> 
> Minor adjust to the device-tree of OnePlus 6 had to be done
> to properly document reset GPIO used. Also same adjustments
> had been done to the sofef00 panel driver (used by OnePlus 6).
> 
> In the last step new DDIC driver is introduced together with AMS641RW
> panel sequences.

I think you skipped the elephant in the room - some of these patches
break panel for the phone intermittently..

Konrad

