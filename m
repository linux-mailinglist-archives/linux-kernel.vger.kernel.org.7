Return-Path: <linux-kernel+bounces-721603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0314BAFCB8C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F1D568286
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B2C2DEA9B;
	Tue,  8 Jul 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pupCTEsZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49650EEA8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980143; cv=none; b=k+a3aQbUXv5BEjlW6sePweVedlmRyiK6Uej4XSaoQcyzCr/iEYXASOowrorYnC3L55UId3zkJassuJv2mMSSGVJTaaMFFeZIXLGsVAjrPJYl8T7MHHT8LNTtWKqZhMqDG3/X8xyN7qKjl2pYZbsdQGk7JlsqEBcu7+yRgaiE9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980143; c=relaxed/simple;
	bh=WzAnNBoWqDOEgWIAvOrUUm+cPnnAQsDqlITlF4IdpJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kz9oBneu3rBIZMU5HTHVdANJeVWOdwTQUzKq/l8JZBOOupU+ZmzXfWvCafICuaReP2tnH4x8jCynrcw3DpUFscyy70woeKhvGAYhfatdtJv3mAeXEfBfMBYclEEzaE5xZJf6MAtnx47sx4hknn+pNJnS9ztdUIB+HfWxPWRJLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pupCTEsZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AANfg030305
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 13:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmIrXBmloEveFtaKUykatLGYGI7N92PV13SbV/egCdQ=; b=pupCTEsZWKvwVFaj
	Fq6QywPPikTVuTb2opn7tBRmUSEnJJECoHJ01EtmgUVbLxLOaD075yS3vjJbXjIy
	eDLtOVvY9EXDf1XlS1m4glK1whQVre5XUxKqevxPd1z2Am0ltKXyNEGJV5M8HJ6I
	rDuNQ2aB0zc14xIOvLdnKnsree6PHxThRxB6eVgnlNPXkPZCGPZ8dUBWQl8EkfI9
	zcEglYLLg3fwOL5LnZwz46mYp2T91EJWAs41WEDy9VwMEDxaNFJu8vg2w+/WWyft
	yGYHLU8xAXjoy2eXqbmsHAa3tr2SnaAFG3+pmv5hbErRZVMbrPx90pAPYxlxbENu
	BRMTYQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b0u58k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:09:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d097083cc3so68892685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980140; x=1752584940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmIrXBmloEveFtaKUykatLGYGI7N92PV13SbV/egCdQ=;
        b=Rn78xZEfhTAwujjC0rfORHGxFIICYXpxLDfL2mk5TIpNiMmWfxhGU+GUtE46VrkgF7
         N1B32ZkDRxICZkQXDEqTkdjpLID5Km/eb8KvuIfasJKqTgPpOQx4rE9+5CQ679/Dnwvi
         7Jnyd+wmuk5w4fox1q2GG+xrcAwylqIk6dex2AiBQBRfA4HPxYijBM8Ney2SscEWfupK
         fEJW6N9zlmmWQvQCnQNHTEYie4msTwThMJ9/WZvEkTslBSWXpkwFD8MS4Nwu15Dj8jAB
         VdpX9hvLFBDhS+AGEJkfz3XRrELhZ94wrQ4MDsuPLS4jHZsbN0YS5ujbSkItdVdQGOxI
         AREA==
X-Forwarded-Encrypted: i=1; AJvYcCWvs3UGGOUQ0Z8RSu16yQ2ft6h1p9CmH+E7P4h7xrOviU9ym1GUt9AA+wJ7akeKdXmNqUBENnXsNFL0f4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUeQdsgqDyKMA9g2mvJFjnrq2UZbFtZ8tLGJFAnAw4U1azR/ZN
	/MEFL8x6fGRm5tEZWnjl/nwVRqAUt2aj3p77cs8HoGmkgxD8yqekKWAaM4Lnudz8RDEP4c/EYLS
	4jLZTYt7N3dKLZgeANbVzFTGqkoivB2ztt9PJZPVdKurAPfG+xq1qe2mjFgibtwqPAIc=
X-Gm-Gg: ASbGncujXJi6S/gFKDat9zgC2BpCFFlnoZ19HriyVptolL9jBpOpqMAdexzdpvFsjHD
	6PdyP9KK9zt527alUWIM/kkiNU2XY1KZaIAGJZ3S/bHAKfpMKfms7IUif+xTLrVOmtacjFw6gQO
	z4JlN1of05eL6LJ/UkROYEY3sdptKp9aicmjkm+Brp3IxSYr5Vn5SgiVl3vPGfF5opvK4Scamgq
	eHG468NjSV89Rrz7p0rnhSZbTv0fsQW10oRib7OKeriRMVbhEBmAyRf7EQxCqM2WfqOa01kHGBS
	qVHwYo6LMaklB3QTdIALSPpeyf1g9dT2Do5PA4CrA7Xm09Q0N/FWFfVHkIqtrbBzk5WaxbKgF/8
	eqpM=
X-Received: by 2002:a05:620a:2944:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d5ddc50daemr765452385a.11.1751980139682;
        Tue, 08 Jul 2025 06:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSTsfzmJAfztbrESgmPdNkncNaz4K8G5/fia2Gnn0NF2orxJ57CWlxeDI3ewmnGQ+XWEqAMA==
X-Received: by 2002:a05:620a:2944:b0:7c5:9ab7:3012 with SMTP id af79cd13be357-7d5ddc50daemr765448285a.11.1751980138638;
        Tue, 08 Jul 2025 06:08:58 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb726csm906327766b.179.2025.07.08.06.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:08:57 -0700 (PDT)
Message-ID: <3cdef7db-4835-4e67-8125-9406a0532394@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:08:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] clk: qcom: smd-rpm: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20250703-clk-cocci-drop-round-rate-v1-0-3a8da898367e@redhat.com>
 <20250703-clk-cocci-drop-round-rate-v1-5-3a8da898367e@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250703-clk-cocci-drop-round-rate-v1-5-3a8da898367e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686d186d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=oBXrOfH6mq4iYN50PBoA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwOSBTYWx0ZWRfX7qi1waw7Cz4E
 dZehkSHd8lDwc/lsCdaI5/2mrNagnRbvMdR8Yb0I4tCMTNIgjMzYh5SZ5Z1Fl/CShzSxkCjzc5f
 kgmervUYhWLaHvr9BlH8HFvYiZGJRZdcmLGDEpdEFJIEQqm/00uPIT6WiaGxXO4w8aSy+IY3xgW
 TjdQB8KuDDROB/EnmJAgzJaQn02tkswkehhDJ7tpFBkfUgzj5EZBc4i1sQhogh3SLHZdEBr+K5R
 if1Tfm97u8ZGZ4OJ14VXXXNATa5BwyMLgI4j1EIkLfYO0wPKozctOhqQhIPKOD4j4+1jepDFxzk
 jKYLjOCaD6K+yFC/kTRc0Jf+Bg38Rx3sej+TmHLz+EkCAb/6TaQvKBMXYJeOKy9hqC1LQEYOX6G
 WRw1GmE2QFHgIzPN7/WlbXx4bot/qklPA+Bg5k7mr2wXcoCx014vhv2AXMcepeX2eTbKRQh5
X-Proofpoint-GUID: Dx8codUshmqyi5ybQMsqhcuzQ6VckFAC
X-Proofpoint-ORIG-GUID: Dx8codUshmqyi5ybQMsqhcuzQ6VckFAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=798 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080109

On 7/4/25 1:22 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

