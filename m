Return-Path: <linux-kernel+bounces-846326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE752BC7948
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EFF94F4F22
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C74211290;
	Thu,  9 Oct 2025 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HIlmvhS3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D952C2340
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992532; cv=none; b=Ne5dSBxjWpVQ2yaUQAtKGfEgZ2Dj1iaNTKjkElvdJjkwAVhtkradYxl5mjclG4iToY1tatrtUOttpYbYPnqG4Z1VXYrUpraXO9lRKPCLooWB641AhuruewAioQy5QNTH2EqG+4KcfKxYrQeZJ4O9g6AGewphkYKY4gayTkH/5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992532; c=relaxed/simple;
	bh=ic9Vss68dPabO721ajneWZTeeiSQLVPNFuFb7lBW75s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhKlMkiP2k/PEA1tgbbHb8hUMK/JF8GkofHF3KYg8/Og875KEp8MxAjmqUWeavfl79K4UvH3fAHPzh+gXlKpzSS/U39flI2cKe8gLARG/+0VqGxWqykkS01SDjSDUfJkXJAqbYbiwbFZWOxffjXWjpnuKGmzBWGmcPggkHh/L6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HIlmvhS3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EGrT012249
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 06:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O/X5Uvfbr+U+5LWnL/Jb57ftS3SWraOPoE3A5ZWOA9g=; b=HIlmvhS3G9ASO9yM
	N332g2WzSLEnbtLyo5rAE52mRB+Fznl8t25+LOdG9nOB47ZOKfrnpXdEzX7U5aXT
	SwXEucqkblsE/56rdz0a/RavSvqUvQB1UO3o/oqL+AoJuP3PzvEfElI1qaOI6XHG
	Oktmyq6Hfk8LQabbaF1Z2sYgzl4C4BjTmGcntFlDPt39asRiCask6hOJp39kCLP6
	HuB8eWUE0L6+fYYReLtmMyCiMcgNjWE4XtzbZY7MQOD+QSv+rCFkkyOCANtuqwSq
	xJLbCCRWsSYiMYsrLyqOZsGR2dNe07j1+lazAlBHD97OIE3tkVi/jTCaFpabMQ1l
	6IPulw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4khsm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:48:49 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so2142456b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759992529; x=1760597329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/X5Uvfbr+U+5LWnL/Jb57ftS3SWraOPoE3A5ZWOA9g=;
        b=ZAScZOEUXuixuLoNfd/tsEYfFtSUUCfZK6UbPXy1gz3HG4HUI+wIS41gnTofuDp2ig
         9sUAeYMf4y8vLNQlk/0X3nN5idEyEHhbqYDEPnRPt9x4CXl2AqyphiSzZlxDNNzszZoJ
         +vymHwEloDmjN+2Nz7Xne4GRQoGTKlYD7iqALYaa6e96Gt0aeXK2VhJ36P+mWJMc+6a9
         ed401aQNYUOT6nLDpT20QXeTkY4AoSe5UarVs14gh1XtDkYCXKDJfDntO2TNv6U47i8P
         kL5cHsjlXx6NAQNnl5ZH90mJEjX/WSTxDX/vVCPQtNr/GzLtlJC/F1zTZCiQ1vwLLxmZ
         kvvw==
X-Forwarded-Encrypted: i=1; AJvYcCX/UuRlMAYCBO9eeyKibkisOfoSwFGHJGUrcit+BqqsOQz5PXaOMGxvmS/UiuoVBUKaeZc4wjz7Fwg3pVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymutpIHTLGzTR7XQX9X10ObeF0sp77e7rvFqAbEc5nleb7lua/
	SpT05PnsnBoBFyGExTfRoTq3IGs5eGao+pNh6QOh4Oe2s1heGeEUGkYPweDBuS1b6f2vxYZ9MGw
	KvJ4k6g2i26Tz17AmozckRviDu/qXO3uG9wx8qczR66rhTsQfiFXzxPCkJXlBX7x9izk=
X-Gm-Gg: ASbGncv+hm+m4MC/tkK48JHCDY7GV74kzhpY6uO5qcYaYsBhX75E85MMzvgdjjt4ZFo
	vdKBAmW+ujqPPVaA0LmxgkBAYB3KXOVBKjUQDFdWXL1reo9FxoreUWaPIm8fb14yq6RXg+KgVMt
	WcTawqcueFO1tNQbsInDZyxnUDjpNTxuWeuzPzTSgD1jfDdmjffZjto8/EFyxfa6Fvp+OXbvIs+
	baYyDZ816objn0C0r1P3gHyR15UJLYYhcSoe56Vj8HZDo9YCwc8B5SH475ZYaseBH74oHTFMPKz
	6YEnvF7vX7M3RyFKMpSB0IKUrf6jsKp0wYxwE09EsftLA7SkpmC4r+kRE7luF5pfLpmHIuh6nPs
	VDbvBqMW5i0dbgTzbiKYtquZtweLku+Bhd70VZmI=
X-Received: by 2002:a05:6a00:23d4:b0:77f:3ceb:92bb with SMTP id d2e1a72fcca58-793858fb3b6mr7616193b3a.8.1759992528728;
        Wed, 08 Oct 2025 23:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj8Rv9uj1kQjcjGsQYqLP1M7EZTs7RFClhYrctbezz0OUijiztZ7vcfVQque68PbIFbDQhdg==
X-Received: by 2002:a05:6a00:23d4:b0:77f:3ceb:92bb with SMTP id d2e1a72fcca58-793858fb3b6mr7616185b3a.8.1759992528318;
        Wed, 08 Oct 2025 23:48:48 -0700 (PDT)
Received: from [10.133.33.62] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e22ab4ffsm1796190b3a.70.2025.10.08.23.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 23:48:47 -0700 (PDT)
Message-ID: <fdca746b-e1b0-4610-ada1-6d9fd156c7c7@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 14:48:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mailbox: qcom-ipcc: Add bindings for
 physical client ids
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250922-ipcc-header-v1-1-f0b12715e118@oss.qualcomm.com>
 <20251002003432.GA2714683-robh@kernel.org>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <20251002003432.GA2714683-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e75ad1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lwdf39Mp2klsYuJi8zAA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: YiAolp_fa6MxCG4ZyRZFgRKsZN1-HWNU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+p+BB9GlTFv9
 KD8ClwBw1Zl+zDekvtAwO9g1kgp/HkhsdTXENhBnxcquPuie9mu8EFntoFAgjJpPhPxZLtkpd2y
 SGWV88AaBwAYoNXhYsg+CjnRbXdKcwPvckY6dQQdOChBfSWJX+uJI++QbSFliBMIu01pY+n7OIe
 ouEaoRns0tENsgs+HPqdZ7tiEvvEtkRsujOQmBzir7OGngwSOp8Hxtn7jydWhOBveaRKtl+aHxM
 ISLS96liae23VJFtwcp11rzXu3zJPFGnLP3BvsHhimmwyxY8inLMsCh1W4Z+ZJ04uy5rwDqM3Wx
 cjQG4ALvbkYY34OHVL+GgeO7e3HAna7bLXzm5vuQ1R9+yCxuNc0jopSUsTG0AuIll9dcW1G3Z0q
 ho3PFDUMSR5RnMniE3slOTzTVUOcsg==
X-Proofpoint-ORIG-GUID: YiAolp_fa6MxCG4ZyRZFgRKsZN1-HWNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/2/2025 8:34 AM, Rob Herring wrote:
> On Mon, Sep 22, 2025 at 08:34:20PM -0700, Jingyi Wang wrote:
>> Physical client IDs instead of virtual client IDs are used for qcom new
>> platforms in the Inter Process Communication Controller (IPCC) driver
>> as virtual physical mapping logic is removed in HW. Add the bindings.
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  include/dt-bindings/mailbox/qcom-ipcc.h | 48 +++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
> 
> This looks incomplete. Where's the binding additions for the new h/w 
> that uses these ids. This series looks more complete:
> 
> https://lore.kernel.org/all/20250924183726.509202-3-sibi.sankar@oss.qualcomm.com
> 
> Can QCom please coordinate your work so we're not getting the same thing 
> a day apart.
> 
> Rob

Hi Rob,

Sorry we thought all the platform use the same phy id at first, as different platform
has different IDs, maybe it is better to maintain it in different header files
like qcom-ipcc-kaanapali.h? Please let me know if you have disagreement for this.

Thanks,
Jingyi

