Return-Path: <linux-kernel+bounces-796113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EEAB3FC17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9651A885A6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E58C27F18B;
	Tue,  2 Sep 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OrY81uLT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899827F75C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808420; cv=none; b=fzN3zUcLS1c7HQo13wL9OnNZaXmi7jYzKtDIshbDaqboYy6+HG1Xvnu2P29uiZJWkV1pAMjg//1aK8pT58VZpypez5xZZB0JWtSk4uYU98URKUNuCJeI2Rohv1Clw7fb1B8EfFUFEY9szESGu3qPznhFmDFV3J+EfBojemKsQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808420; c=relaxed/simple;
	bh=KhqjrOQrOyXMwzO0tGi4lNXWqZUxZo75m/WEJwFFTn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKqGnPRNFHmmbh413KkZtt+HwRlJURQ6biYmEL/yDFGGIVJanAl1sS3+xiXg4AbqgUH+dXVpKoHL8lRb8O3MosodQF4LaDO2WnUq4vFIupPOkEbNnJ75j/8h9WpqCzgPv2fEu9xlKijP8k75N69O8TXsbvFcuc9BT62EFZzoL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OrY81uLT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RrWc017336
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 10:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sk1VaVcSz0D6MZp2YEe09AG+zx/xwfxMGDZWZMcPKJA=; b=OrY81uLTtmDuEheZ
	XO+DUj2z0pG3ed5a9vwmIJE0eP3mKIP2KH1l8dbGEzmBJzsLk9zQviRVHoC2eqqp
	/K+gUl0AlA6eFGf/D3xChHnPsSXHE+qOTXSfI7s6Dhp+mXQliLlhT6GyFyqr97p+
	ASg4OSklcY2xP7z0R5kj8+bs9+Jg+HZpFNKncawFf6Y2KtWAxRILS/SZ+6XUH2/h
	z1St7r6XDaT9XNihV7//qkM4uj+1HCsonzhvDHyvfuvEArMl7Pr3kRQ7JFBSImlW
	DRp4RUpyvwkkxlBPFjehYVkSVU63J/32M+otnw69DwFT1qg5HgvzEWplFAZK6ZDK
	Mh4tXg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8y8kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:20:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3037bd983so28552321cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756808417; x=1757413217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sk1VaVcSz0D6MZp2YEe09AG+zx/xwfxMGDZWZMcPKJA=;
        b=Da/4KLcESrzNeZynMP/Tmn8S05iK1G0n8i56B+CB+MGqmIPFPnUq1xDLk8fZUqvpOn
         k9anyy8RRUMpp8fS5mSEggwT2VNfgvApelPbUsACGI0N/K7Mnq7c5C/TPhZwv10uXZbq
         aKsT0ixIL5zUapE71ri+W4y+hdVPpyoPZW0sDXe1tLRhk6QrnMjYx8sxNsMrzCKT85Io
         DgnauIfWFAS6p2F9sq+sMnjpBVB1ZHoCcoLu0pO/uAjMIgUWa65gSCsGY85nsbxPFM5W
         o3uyLqeEbwVo6ninUbK6gz21akhzco9ZLN11uOXEw9wOCRvuv5mD2KsBRRocJizIA9OQ
         HuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCkARBHTgBSzGdMeBgKD3K1spA6U8dDRc+g5OqqStL+uYyn+08UjF14sry58u/ftFRWVtRE+2pxtFWy14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lL/uaV2x7SD0VzAXt14rXRbBKrGoh4E8XLrt2eBP3sjL2RqB
	7XJ9Den0aWgz2NiP53se940IMIFFNcrLQXY2DfUoDV1vxfFBd0+4p3iKKkSF/GtekP1rypq5hJh
	wHD/el8BRNIL1WiDZUZP9f7+cMAGtwdPw0nJFM/JhXpe6m8he4MXGChQUzfKULcXTdBGJSKO+DT
	Q=
X-Gm-Gg: ASbGncu+EZrGjdjFd4w1v5EMw4D7qSNlE3GtdcJdaa3/Z8xuNMojAxZ8JO2ut4tJYps
	ubxGQITn51/FCq6JVbsyuoIkk9jVzYXPQS2go7XXmu54cJWZBhvO2RmA9+13S3Hrm0ipciyHclM
	slI7tYIxM7Gq3wRTEoewY7fQWvZhRrQ0qumtlSkuqtEbbcjYhlx7997m++zpEzBCmGLUY0bv4Ru
	bRqGYPWQD5x3pJtbV2nyEL/S1YJ8YBZFDHziwRAazoWmVFlYaRSnlPY3Kz5rZJOTHBVMoaiF2Bd
	itOt3/Qm3m/oxrTXa1BFhyrpNHtuDXp7Czm+6RzxzEOSdumFvV4a5XBAjvzB4D1k1t+rxWPFScP
	74kWDjJ2S6XfSsQp0cF5nYA==
X-Received: by 2002:a05:622a:447:b0:4b3:37b:d853 with SMTP id d75a77b69052e-4b313b8b709mr103026511cf.0.1756808416676;
        Tue, 02 Sep 2025 03:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCcotXg5MvZt1PU3uDiIFM/arWPB2u6LH0Lj+40jupDbU8ueQ4n7VQ+cVQhsS/D/WR7TF8SQ==
X-Received: by 2002:a05:622a:447:b0:4b3:37b:d853 with SMTP id d75a77b69052e-4b313b8b709mr103026251cf.0.1756808416044;
        Tue, 02 Sep 2025 03:20:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0414241e1bsm644579966b.39.2025.09.02.03.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:20:15 -0700 (PDT)
Message-ID: <09281121-e8d9-439f-b094-9df817acfb00@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 12:20:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8953-xiaomi-daisy: fix cd-gpios
To: barnabas.czeman@mainlining.org, Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Alejandro Tafalla <atafalla@dnyon.com>, Luca Weiss <luca@lucaweiss.eu>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250830-daisy-sd-fix-v1-1-727e83a987b8@mainlining.org>
 <q4t2cmg5xtzbga2u3nnxayvb3mom5zaffhyidki2h7pmctk6f4@syj4byco3pwi>
 <e9750a64c761c0e66a813e206696dc7f@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e9750a64c761c0e66a813e206696dc7f@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vJ7upHKsVfbWkBhW0bJKss0QMh6UtBCi
X-Proofpoint-ORIG-GUID: vJ7upHKsVfbWkBhW0bJKss0QMh6UtBCi
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b6c4e2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=OuZLqq7tAAAA:8 a=kNptk6tRclfZ_PHBQXIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX8eh7KmCIc8hk
 2wu20D+BPclUTH9YJ3Z6WWcySFHnFwa/elpI+nmAb6sW50fNx3DymI3O6sR6wpP5+mm5UoDuYDn
 7U0PeO0Tx0/DixG8mnyH9Gnn0WMk/5/HJkYfezchJIl7HoTYBP51B+XYimwDBGKvZhNbI5bQA2G
 mWJ2Y5BlgQ+aENnljbc5m/LVHBYLvWRGC0H01aqmHM7/vwzyCRlpb3XCG2th+JU6aDardkcqM/P
 ++Z1HmcGJ/KGoL2+N4LViTomoYSu2Gi1C+aWBWBSYz8qGBBbsSvBtVIJAzlMg4aU5yJyNikXIAk
 OvtWusvEPrsh2XDyYYGaZqvGcdjUZ3ehNoMEdfxS9F3NCWj/OfUPnDsQxAwGs8A+UVgSdzH2GyC
 H2E63hnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/1/25 8:32 PM, barnabas.czeman@mainlining.org wrote:
> On 2025-09-01 18:01, Bjorn Andersson wrote:
>> On Sat, Aug 30, 2025 at 11:59:30PM +0200, Barnabás Czémán wrote:
>>> Correct cd-gpios in xiaomi-daisy according to downstream sources
>>> it is using GPIO_ACTIVE_HIGH instead of GPIO_ACTIVE_LOW.
>>
>> Is the problem you're solving that the DT doesn't match downstream, or
>> that card detect doesn't work? Does it work after this patch, or is it
>> just aligned with downstream?
>>
>> Regards,
>> Bjorn
> 
> Both, it was not matching with downstream and card detect was not working.
> It is working with this patch.

"things now work" is a more convincing argument than "copy downstream" when
constructing a commit message, the latter can usually make sense as a
sidenote

Konrad

