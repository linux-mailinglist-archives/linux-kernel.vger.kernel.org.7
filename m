Return-Path: <linux-kernel+bounces-852147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E614BD8468
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FD334E195D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EB202997;
	Tue, 14 Oct 2025 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zo5RysR2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C33E18F2FC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431818; cv=none; b=OBKw5csOS6I9zR6/MikChRShsYqFE60iPcoStz2lMGRt9v6ipfEm/lVQPdDqxCADXjxshBKtHO6bh8r/WP17Au0q1hPgGsT491JkhzNleECT1V6Ew0RHnc32H+g0qfFp3xqwIIFbyE0eoYR7eyEjZsSMhIv8x759bu0eV4TY06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431818; c=relaxed/simple;
	bh=Ev8yq2QjwLEFLAMs+VMUIoDBcm44QvbV0Ol5FrupKII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOk2cE6p891aJyLx4l8W8WuCtxebexlwv4NDQ7YdJ84JehRYUvH/Lii//StX1kWjQfzL/ZmaYUbiPbnDQPULBGrIHd8VuzfntnshV30tbCS6F5g3JgxhkMPOn4+mLnsdhiLS1/iN08QWYjcYNFADDsQuPh2DVinuKcq0G0Q9t+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zo5RysR2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87O6l021179
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w9f+nU3HFmyw3t1LjMr87pwsziNsqNNp4ZBv/CxMUqQ=; b=Zo5RysR2nSJ1P/l9
	Gv4rXznAsDaXcX20UGMwXmzOTYRwOHAUfdoWz3N8frLH2mt7IAOFnzDkxh6XIeqm
	yoq/eBKKmMwhq63IOUPGZIS4Tsj6WdX15Q+p4sAJfdMGbW67i39F0LWY1+hcEXzD
	aXiRH9H3/Qe89sWS4f0orvxqRob87W8ZKGRCcgl8FTNzNhM+0LTaPOZiIkYPpmrg
	PyBDYZ/n/VBw3ZUL5M2s/RzfPFL0SqmJ5Agjm8VWBR24S5sbO/WDAnMu4Me09D0K
	IfinSpluojMyeC9hgCeELv8VO4TAhKhtCupAA4KdQLaFrFhbutWvSx99M7f+hGhm
	Y3BR6A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwj377-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:50:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85a8ff42553so250812385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760431815; x=1761036615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9f+nU3HFmyw3t1LjMr87pwsziNsqNNp4ZBv/CxMUqQ=;
        b=ZBzj/N1NMtxVYEpmiQQA08o037DqqFdXM/wFfJOwVkA+8EvlHW33P3kGIoJSi6z82G
         TX4xf6b1S5OwdL0aPyjgneisxc0n2xgUhHVBO0kW5TiD0d8+TZXji8rH2KjvkUuMuyox
         YRaau7P/DeR4LybNfhyORsgxM9d/Pj43ia36hkRSd9ZQMsoWZ4JpN7JVCH7vzHCRgJ93
         Wdrbf+57d5fZyqmyBLjraLOriVrutVWQjfz77ZD/2/n06FQvt1KVWzIh7TrlKdVqrzza
         kMZNBNfnP0bDDQu/Neo1M9KvD/oxQ/cINkZ+Sjz3sV0PvqlBcT3Gv/02P2+g7f7Qz/Ad
         SDvw==
X-Forwarded-Encrypted: i=1; AJvYcCXdmFUw/jM3foaQ+ZZjUJDOi2k35FFE2hptw7pBjMaTbAj8wc4tuvTXzAlR2ofXup2hJL9HrdOBJ6DX0Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYiH4wx1+bXl0hLUyBdMguD4oO3/hckGsXZhoyBj7r4ZxTFq0j
	tvZOtpHSKOAYX93ITsHhi4aiDl0Htoy+Th7F3GgUC02K6XMFS/jvg6PDU4sL+IYYPMAuP6l9tGz
	N81rblAcecpaTDGSjvYjzWnFeR9KHdoQL3k/BSXHqV4p8ZkJhGbCWzdpcU+D7VmqSKNY=
X-Gm-Gg: ASbGncv9HX0fZ4slBz/07MLLRlPyKoTyl2oWzIYuNyEe3ImPOg8J00IFK4n4gUVjVnc
	hAxAz2JEtsnAwfEG5lvME2Rwp5l04p69D9C5uG1Q7q+aBssZWLQysLc5/4h8k60CJzpYa8fterp
	8Ch/qkiorhXMWiz0d19YESrf8wHkYKPpypa6wWtYnA/VlYhvv5q4FMZN1BY9jyRN+r5u7X10L5Q
	hxDpY3sns7HxQ3Ssw3za/kLAvrtOB/FMrpHr4gvfFYXOvCOEKlZW01bZVqizxFnYenTeIRT6Z5i
	AXBHfLGm5yoVuO5YTk2aj8xaAUZ/UwnbzDIh20OKP5goW1/l8YeIdGGI3R2h68roiJBELGkj/V0
	/nzMEv4cKc9j1DDhZTVlijg==
X-Received: by 2002:a05:620a:44d3:b0:85f:89:e114 with SMTP id af79cd13be357-883527c9c39mr2343739485a.1.1760431815034;
        Tue, 14 Oct 2025 01:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGncIKVFHxsfaJ6UTmQUqWxi7M6jn0t0eJxUvQoUPR5cx0i1d2AEnVAwqZq7xbGoqN/fnaSzQ==
X-Received: by 2002:a05:620a:44d3:b0:85f:89:e114 with SMTP id af79cd13be357-883527c9c39mr2343737385a.1.1760431814478;
        Tue, 14 Oct 2025 01:50:14 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12a08sm1122876166b.52.2025.10.14.01.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:50:13 -0700 (PDT)
Message-ID: <096f3063-ba79-4676-864c-d9d9312a7634@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 10:50:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: qcom: apq8096-db820c: Specify zap shader
 location
To: Valentine Burley <valentine.burley@collabora.com>,
        linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com
References: <20251014084808.112097-1-valentine.burley@collabora.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014084808.112097-1-valentine.burley@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX74EjnLMfgVoQ
 XBiOAtMuxMLptP4zTlQRHSt+xBqonvHsx/ITai0ZEUEPFWkjajj+NoRSrqFfHlUp9/tbd/aL6/R
 kC/x8afZpwhP3xcHMm9LW14c862CIDP0P4L91XFc9yeRr303wFR8g4N4Dx/kQw5Tdtc97tfhsW6
 KgFM3Oz4vLzS6O0/seBRg7KC7Wt5ZW6SdHjKV16GbxOXpMsJj+cM3JCiWsRxQ0YAi+CsoNGVib+
 poSUSdlFNYs21ge8HuopaXzE+TU8ttNN7Al3kEnahGSojDJSM4NCkuMOZTVjjVgW53Senxq1UTx
 Ife2zFBDJipgtpXTAskqiXIwsgVUrYLFKrHXQArfOURhyoEtdvhkcokvZsQjI8fyoE6QFCOWL3k
 rXiRrtFM7mGu3ytNSH67p6v8EfQ3JQ==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ee0ec8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=vzHCU5_V8cFStwcBz_4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: 8bqrkkV_WM3rdwHtVK4JoEYLgsTSk9Pb
X-Proofpoint-ORIG-GUID: 8bqrkkV_WM3rdwHtVK4JoEYLgsTSk9Pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On 10/14/25 10:48 AM, Valentine Burley wrote:
> The zap shader was previously loaded from "qcom/a530_zap.mdt", which is a
> symlink to "qcom/apq8096/a530_zap.mbn". Update the DTS to reference the
> actual firmware file in linux-firmware directly.
> 
> This avoids relying on the symlink and ensures a more robust firmware load
> path.
> 
> Signed-off-by: Valentine Burley <valentine.burley@collabora.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

