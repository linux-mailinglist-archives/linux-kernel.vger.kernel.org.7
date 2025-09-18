Return-Path: <linux-kernel+bounces-822216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28549B83506
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2141C245A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC1F2EA75A;
	Thu, 18 Sep 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HuC3m2ah"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9281F1921
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180458; cv=none; b=qXeNIfofHP5lC3QNcklkEOPARoIIp1c02JfLzG+7iylAK0rJ0IHo60Xp5ZjFBaJQBWY9xIKxasm3Gptsepui0sxahSN7PNLEL9IyV15QEcif1X10IBHszHsw9XpTSPxvmfa2QzvjVCmnqjUzwLFMxbczJfa9SKEvHpuWA50C0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180458; c=relaxed/simple;
	bh=+0pnqooJvvQ3guaL0gULSvIN3AU4QEO/1s7ZgLDrVyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxOY3FThhgmeSLi8afEEfzUpz43/CJSY70G8EEACk1ERdezAi93LTeHXQgPCL0lySh/ABIAv8OhfeV2wgaM09/KPcRO3A9zSns48C3dw+rOQTNYKIZQ9HTaCSVQAMr8/YsL7k9wnrVh81tGTFlep9LCGbKylD4+IFSK6LONVxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HuC3m2ah; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3Qmkc014213
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QtCe2RN/Y8pRtGMrLYTfDuCnv7IysubE6DCnGz7W7B8=; b=HuC3m2ahB4bvgx80
	qUemhJL76zjVnfWRorL9tTZoVdBfmD1OC6jLJzEjVNkgJBfpShrGwZsk+T8YdbwS
	sCigaZjWyDCAflV9onILshlLErjzC4wpIRHWGllI6L+q8m9HPzMLqjWDvrmIU9+8
	64ziix6Iliyjm4lJCj3SDi98XGn587KDUlHCaVBDqKnx3vqXFVrbFQcn5e1zSWgl
	ySoijlIpz5VxP/ywgJEuho0vW69SISwqAYcX2wEkM0Pj1K50IVDOisxCYBcEBB+j
	oxNGZwvGgatpO4N93z0otD7NyHASWnUBhdVUiI9+/lGmKnwH9CYpCRG2VJeJWwOI
	izukew==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxu5cur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:27:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso536381a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758180455; x=1758785255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtCe2RN/Y8pRtGMrLYTfDuCnv7IysubE6DCnGz7W7B8=;
        b=IIrQLLgU49ag+FlmGws5NM05qTh5mAPJR3ylUkU2pfrt7XQ+aoUOGASL57DxrFRsDP
         te7refYG2WgsYnX+D7gNfmBV2/EVV5RI2B+iGWSQ8ursAu3HXEtYTe0nSWLZGuuu4fEq
         esVqxCoRSaEXbGJ488tvSjnHVGTH4QxHaq7HI50HTKkCFhK0T8NK5NZPqCcfbamP2u9u
         NVAGLdQP1+eGTyEIcy3rjjKbJFkWzSVYLwiPtI4KNspQTA4hUZryhT1G0CN+31fwT0Yh
         BK3C5uWWFRUVHRYak9z7iB2O18YM0wF3k0n1WoTspdtiZw/A6oy9fTkCAuRGYmYMDWhU
         rG4g==
X-Forwarded-Encrypted: i=1; AJvYcCU24ysFTsaTUro9BQT+tV+Ddc+PM8kyq++NQGEISa3whCgC0j7/7wHWqAhJla6tovuod0DXx8FXHK0Sf1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OIuGhY1TZHylQ8jHG/YmxlMY9LgV4NMVYOYEqr5GXN30H3+n
	ghVDYY7EuD9nxprLJoGgqnib3foX9GVI27y0y+4HWwFcThxnpY53lx28HpUaT8MS8CCTp8XlfSt
	CAu5EprPVIlkz5VpLBIamD5ddLpTsStM+GK7/cG2A+xvGQFsDIgM/Bt91QYrasFN1nK0=
X-Gm-Gg: ASbGncs80kBT77qquynoJ5Uk8UOaxhAYCu8SQOk7IEFhSwhXdpURBUgZ/hZoY0FG4+O
	prdrXNL7Myt/SMxg38T7MBQN/uoYlNi5/iSsS2wbDAQXrYqSWxlVgpw2jyIT4omyVbphOXTC/+u
	/5y6g+a2fMYwdFsdeEukiMcKLiD7txIN69L6dSAUV1paMqUyAGgXAbrrr8zFx65rdLThxOjaUBe
	c/d87WoTQ6wB/EZg9H8dV1bQCn+kKmc9ZsGd7K0jiAMJ8QmoaymroBGMpczWK9PfkWXvX8NJ0ou
	LxojtFkPq0ZuivXZRPSE1tNrlGzKTWd58x0QGb/ANOg+D9gQbRYqLmaz4VV1sywOSAAEKu47N4a
	nKJC4EQ==
X-Received: by 2002:a17:903:186:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-26812184917mr59001685ad.22.1758180455506;
        Thu, 18 Sep 2025 00:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErLnyx0n30seI7eSnLwhrrBGTy+VTJlJ2pd6118rrdXNeRKTAy8YPNg5NJ/hm0KMGdyJ+OsA==
X-Received: by 2002:a17:903:186:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-26812184917mr59001265ad.22.1758180455032;
        Thu, 18 Sep 2025 00:27:35 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dfcbesm16608495ad.88.2025.09.18.00.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:27:34 -0700 (PDT)
Message-ID: <d6ca6b1e-466b-f90c-a75a-b9f88ca63aa0@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:57:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath10k: avoid unnecessary wait for service
 ready message
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3gb5oRM5ebxx
 CwIKvyok0eojdAwHIfo9rJu1XEoi3e6v7gujKH6mGXFIuvS9pqjy+0CxRY7gHKfsmmt5cg+yrA/
 s2G7k9AkMH+X/TVFALu2f10GLjhX3lhG5UEzESarmir1+ryF/bgaho9wBdCihPlM/Upxi2yOUyS
 vP5zv+oIyh490T5+/kKwosxq8TWqwyrUxLbbgJ34WkB+U3O33Sszq8+WJiOkvZzDSC/bdp2xMGE
 coMINw/nmqQDVk6vxl0fHjPVGkNm+FsSQmwhJdXExY6p5ofr9rWeGWvptN/Eq5izw2Yn12C5m8C
 ww6S9XrXHmWb2X6YiJHrZ5dmPgCGEG7NdQqzu8hOoH3QUUhD56nv5NuTfSEL3nm52lCV2x/U1YF
 aOWnsbuK
X-Proofpoint-ORIG-GUID: oTUmjnNT_Om3l2MMGDTVfFEo77F5j4OB
X-Authority-Analysis: v=2.4 cv=R+UDGcRX c=1 sm=1 tr=0 ts=68cbb468 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mpCJlUNt7pqHQ4OmjRMA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: oTUmjnNT_Om3l2MMGDTVfFEo77F5j4OB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/11/2025 2:56 PM, Baochen Qiang wrote:
> Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
> failing") works around the failure in waiting for the service ready
> message by active polling. Note the polling is triggered after initial
> wait timeout, which means that the wait-till-timeout can not be avoided
> even the message is ready.
> 
> A possible fix is to do polling once before wait as well, however this
> can not handle the race that the message arrives right after polling.
> So the solution is to do periodic polling until timeout.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1
> 
> Fixes: e57b7d62a1b2 ("wifi: ath10k: poll service ready message before failing")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/all/97a15967-5518-4731-a8ff-d43ff7f437b0@molgen.mpg.de
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

