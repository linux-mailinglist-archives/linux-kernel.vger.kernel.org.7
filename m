Return-Path: <linux-kernel+bounces-774963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9CEB2B9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F3D1BA76E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0126B09F;
	Tue, 19 Aug 2025 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXBx3+Gk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70511AF0C8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585527; cv=none; b=rbf7BoL/Gu3rTe+DFUfnbl2i6cobHfZOPAUpeI7XlJjj3VznEUEUc+SW93NoYiMGTweJgaAM0TqVGhSusq6lhQoDj5LZ74yXiDH2NUAVXfnMv+9aHkaR7BAnGxGUtC73qlWgvM2Es4NOQzZi4xZU7819YRsRwsOsvMiY8cWl/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585527; c=relaxed/simple;
	bh=pAoLF6OgU9nexvhoGoHay7FSSnOOjGhiFZBRNoQFC2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRveg1n9BDej2jiC93lYUYWClS/p65KnqVV09J6yBXD0rq7sLgRtWHPpOAGYE1hFoVyhEdgqysla+Ai8/yqgKOm5f81cHmjauoESTzY7+5qxXmhav72/5u/kxf2cIduvX9yIW0bul+wv9svI8aaqAlJC9jWLlgeWXGY+q9BHIEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cXBx3+Gk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J2JgOC016705
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Qq/aMBe6WA4icgWdgRmHu9HjfiTSjioB8bzv4f37ps=; b=cXBx3+GkykVB2H/+
	rclAvJg00+PXYq+P1x17sgD1TMbD5Mr0kkctnu068m/FosJuNT7d0BALR5K22p0a
	/dUdXAemP0M4HkqjYkI9pWZik0RToD2Iv6sdHhSVijNoFQvovqmzTvOyF9uv0kvO
	Qv6bfJXiJenCa3GzevEUxRLdm0ZrUsewskNeNI0Xj0+58rWumfk29GUeFnUd23DM
	Wu5weD7jy5HoFyCR3TEPHsWf4FO5d59MAwbKXoEn1lsRODVAYEShrbe4mRZMsw2r
	Kbpps1z79DH3QdawTiOKd+UOn6H+YzATOxP1fmz9ox+2sI0WyBmvG/Exex3xXRM9
	Qge4fQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk5mfckf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:38:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b474d5ff588so1124345a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585524; x=1756190324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Qq/aMBe6WA4icgWdgRmHu9HjfiTSjioB8bzv4f37ps=;
        b=AitGvMsrlJmW4LWIebGs1eaNYIQb5E0Qdxp4LXp5Q0+dMXmiu9Ne7nPB6MqXKr2JG2
         Mlen7FiqSCT0L0hQjdyumamuuSpgymVxaWuus5UBreSEMBOA4DyLzT7M7vUkXVzqGZ9A
         eDHK537I0bcVjR32+2bSBanu9hBWmrfn6XGObn2V4KgJhGc+uceH9LD+rEsI8/n+HwOw
         QrUau8S99wGErNKnKrsUJkGEDHAe61QxNf9hUlfsoJ4p3FcTtzpRHy1Ps2OlJ74OWKIr
         2B2O/2fKYXZRDoX7UVGe3EH350iI04Yhk6FrfRB4bgqxjqdN7ziuo5652nSFJJvKoYzX
         3o3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMxr1p3jsly1LolRYs9aXIngPvImzjIrt8T7DwGCztHg26j0kWTXHJurw2ypf5xOGdZNBjP8rKv1PCha4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBz8dJi9SpF8msiqdIC0FHRIObrDD2Bq1lwLPp9olio1fpSXHs
	mNLdF/LtNNKDOQeTsL5wg24H3rE9+0+T7YPOUDr2CopSZR8s5ptWC/M9delwhJJG9ZkW+XMb627
	RV2OsisIBWHN8bO0eu39BAPqr+FYTJFTAOUHAF0zPAeXp1VIZMUKp8wyNgyJyMEwvVUvhoPD//T
	c=
X-Gm-Gg: ASbGncsdgbzydPT/ldsxY3eRFbXnGs9GJ/X2OfGNH0jBjmPMOGzUqWFKAqETxGvxBj7
	3c7+Ddq1SqbxowomNixnxeavYSobfFEnIlc00FhiFIpbRjm2yw/4Mfa89ejp3bBJPvywO6SyImR
	InLiDN/lwekeXjcu1OOzKrS5kaVJth+p31k+TMPSMNYLsRwr3miZzPp6AHqC4QuPROo10NR150y
	DpbfsuiSH99BFG9CFZqLuAaKs8MpqtIlAy6q9ySEhqW5OxMrtpbHWO2xzyjBWG8SYZ5AfSboKKL
	saLgmLdLuyUDptguGUuhf/ogX9FeU/Kbd3h7HpxzPiYPtlKAmpkxuCPtiSQEbU92rfgDXUmgPY1
	dmRkgMc26oP4mEqaJ3Pflx1mEzCc1PhlXIDcG
X-Received: by 2002:a17:90b:5746:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-32476aa1cdfmr1843076a91.31.1755585523822;
        Mon, 18 Aug 2025 23:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQYE9o0BkXEZqqGhwXwAEvO5q7mg3A9ZGePOqkdZyzZsjwzpO4oWulSOZ4lo2KN9r2OZ7z5w==
X-Received: by 2002:a17:90b:5746:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-32476aa1cdfmr1843053a91.31.1755585523326;
        Mon, 18 Aug 2025 23:38:43 -0700 (PDT)
Received: from [10.133.33.94] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76f9d5sm9646108a12.45.2025.08.18.23.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 23:38:43 -0700 (PDT)
Message-ID: <d6f0b64f-1764-41cd-a7c5-fb34d034ace2@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:38:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: REO status on PPC does not work
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sdn3duRu c=1 sm=1 tr=0 ts=68a41bf5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=HThdk4v1ZfnwiNzKKCMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 9OEdh6XW0SqXcB0Eq1wfVchBPGSeb9d9
X-Proofpoint-GUID: 9OEdh6XW0SqXcB0Eq1wfVchBPGSeb9d9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0MiBTYWx0ZWRfX0i89U6lMrRUG
 Yp37XShJlu82cHhctKLbEw0gN3Bg2ZPJ/bVXYBMfNwcvF2W5Y/9H4sykC26sTuVmv1GgnIDXtIB
 qJww437jQcYiHOgUsjupBreqhHqJlhfnpfQK25RQ3sVdS+QKh1Ho8iVnlJM34Zox7m/h4vPvurW
 X25lFlczuMEax2EZ5cIq8HOIRotZ//lm+1mkPdzsP+WjNEPsDtQ12EciWrgZ+rELImCkcm3bacZ
 mqJqyxoMj8/0o40cec/PSPyE6N4YEX7IxHMVljCnaj1zV2McPV3GUjT39iU5AwtyKdcGDlxH+GL
 rdxHu/KIZqaIqf1qUlnkqDRkEYC1Hd3NjxA1Qf24nplcItdVaj9J3RjB7WXHx7DLhX1CFKhvMM8
 S8BwTaOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160042



On 8/15/2025 4:13 PM, Alexander Wilhelm wrote:
> Hello devs,
> 
> I'm currently working on getting the 'ath12k' driver running on a big endian
> PowerPC platform and have encountered the following issue.
> 
> In the function 'ath12k_dp_rx_process_reo_status', the REO status is determined
> by inspecting memory that the hardware has previously written via DMA.
> Specifically, during the call to 'ath12k_hal_srng_access_begin', the driver
> reads the value of 'hp_addr' for the destination ring (in my case, always with
> ID 21). On the big endian platform, this value is consistently 0, which prevents
> the REO status from being updated.

This does not seem an endian issue to me, because either of them we should get a value
other than 0.

> 
> Interestingly, DMA read/write accesses work fine for other rings, just not for
> this one. What makes the REO status ring so special? I couldn’t find anything in
> the initialization routine that would explain the difference.
> 
> Could anyone give me a hint on what I should be looking for?
> 
> 
What hardware are you using? WCN7850 or QCN9274?

> Best regards
> Alexander Wilhelm
>


