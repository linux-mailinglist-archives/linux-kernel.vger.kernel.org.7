Return-Path: <linux-kernel+bounces-846457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F1FBC80E8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3981A608AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACD72C027C;
	Thu,  9 Oct 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f99qQe32"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B2BA4A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998795; cv=none; b=Mlb25PKSug7Erd9YMSGDrnYBoO2xeJi3A84h6SP6N0QSkSQYFWvA1xE5V8Kuts+t716RYvX1nlA5ubW559DdiKwVG9K3yZDb6LS9wYusPTs9OrbIixuhxMXQO5QwI2Oj3Fwg3Wie53JT+LlJadcH1VIkj7CS3Lzz5O1gU6hf7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998795; c=relaxed/simple;
	bh=cO0b9ogySp4L6nxDCj4cXryCcCKh5pkNUODLEw/Qa8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzQTBxspT7Sg504p/hNjRmYxo77wgOUXiGz9nwAxvwickUwCUigQkXFQlhi+RRJ3iU7tNpS2ZEfj3BXE6rBnv5MzjgPkbkbe1d3z1ySXrOHoYHk834L0cENNNvy8iJvbmJI7SNA3JzrDEqf5zP/jnD94YTKFQQLw3K48uM41ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f99qQe32; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EQj5029800
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 08:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jlgy40yETlR9CVmXoLlXfeZtV+8pqdLDPcp36HkTmWA=; b=f99qQe32wLL4gnT4
	vP4m0hc5CxVBnyTqJ2cT5/5LgnbLm1PxAgkq9BCp0Qj/qGIKI4v3wJjyf0L9gvnP
	TDB8tIhYIBkvxqRe6YOF8WBHgqzghz9BYoNAE5Iso/jjO/LUEq2+ArXVv3/UGG0F
	LmNOMXiKiIwj2qDUAjjEmVASS7h9SUTUAGS5FE1/2rJTgHzv3AlYy5TtqBkoPzBt
	2epOpFH7qHDfYtHhvvzZ9yvPFWDUV1y/vKroehkILwLkTJ0gT4LSjW/WQpjJkevC
	OvYmiE0eaTu1IF9lYMWVG4ak0AptAKKZHi/R9LnlGp8eH3Pe2x98Y73HZi6E7msE
	6evCJw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4na2kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:33:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78117fbda6eso1040826b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759998791; x=1760603591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlgy40yETlR9CVmXoLlXfeZtV+8pqdLDPcp36HkTmWA=;
        b=mQEYhcYRQ6NVAGTfBNCj1oSLYSczX5akdcgu6WSLP5WEC7OQpgoZ+NegxWUVPLCU81
         JZ4/4iVVGr3HBGRTHJglVltQqVfr8RGerEm53TsX6GnjnKB8eKdktYZQJGgZec3evPv4
         hp3CIkVU+b9s6YupC0bDvdyj5kZFDMMfqxsIvLewbGC7k2UcaNO/vNmY9Kpk+3XloNfp
         gv/I3NfCk9+PIfOv8S4FSLCGADvc/vJdbozmo9gbnKg88rkchS8MWQ0bmJ5evZjfQpSS
         kXmJM/4vGlLd+xaAG6YzrQV35yHefReCo8m3D+ol/N5Tr0o6ijD0aSZKyRZqwPkHGtXF
         GjVA==
X-Forwarded-Encrypted: i=1; AJvYcCWuwmnbqt5xNZc+Dla5Q2emdK30e/kCJQRKrti9wuS+bALMkyr8ieMFNzGfUnUcsPzMtidIRkrNaiKkXh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo614BeZv74xoxepwS4xWDi39J054cmN977KA+Ls1upQ9eXw9r
	TiGfjakMySLenxh42HHiOmR0fQ0OOh5TiBOQH+46j/HHBCjq/hAMo8LEn5g8ZGRpNso/DuhoWtU
	o4SNL/ffwe/JbI8bWMkOvy5Fm654v6Di2ueuIPpXQsimFpvaPOzJReuYlfrgd9zVJmqQ=
X-Gm-Gg: ASbGncswKHgrQ8Ii5Bxnp21FsnD4+KCV8VTFy9n6h5grKgN1AoKVUmoawN30XFrnnKd
	M1GhTXASbawnf28kp1hM2WcLc7MXjjS+20/pK4RpHudwQ6IN3KSKy2f21W3M94TBFgrWDRrajcW
	YUzwfKjArwn3sPbPxanBUVk+DXpHcRf9tt0Tk2RtcvHGHoT0Mv2rvYEQ4wb0qTiUCl5USzotOwI
	qe5SaYkEXjoEV4479Y8n4W9V5ptXFk+bx9JF0Elw5+sYmmySW5Qr24xFQNqYdGCKKpMcPJU1n89
	VmamonoE+jsZyiw+cPd1MsztKwQyVaL/n8G+gstZ6qbWnuP4fMheNm9c2Cw1D+nYHhaY1nJKaSu
	BPBsc//g0BpqxkiZcZSkE3d8SVQ3hvbA=
X-Received: by 2002:a05:6a00:114e:b0:781:9a6:116a with SMTP id d2e1a72fcca58-79385ce7b44mr6670773b3a.9.1759998790955;
        Thu, 09 Oct 2025 01:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJpAJYqqdEqGRYT4f/BDqodMlOPzBvXPMErzTaUIGOMqk3iP5UWKryIOqgcOw/n2dpHhEScg==
X-Received: by 2002:a05:6a00:114e:b0:781:9a6:116a with SMTP id d2e1a72fcca58-79385ce7b44mr6670752b3a.9.1759998790496;
        Thu, 09 Oct 2025 01:33:10 -0700 (PDT)
Received: from [10.133.33.54] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e1fc9c97sm2100782b3a.62.2025.10.09.01.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:33:09 -0700 (PDT)
Message-ID: <974ac942-b408-492b-9e15-dce0d2d02272@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 16:33:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: qcom,sm8250: Add QCS615 sound
 card
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20251009023341.27277-1-le.qi@oss.qualcomm.com>
 <20251009023341.27277-2-le.qi@oss.qualcomm.com>
 <c469ad4b-9dc0-4ded-9736-1856e44d21e3@kernel.org>
 <93491a16-0585-4c24-8ba5-0e4222efb5da@oss.qualcomm.com>
 <b8b70358-7cca-458e-aeb9-fe9de8b51e03@kernel.org>
Content-Language: en-US
From: Le Qi <le.qi@oss.qualcomm.com>
In-Reply-To: <b8b70358-7cca-458e-aeb9-fe9de8b51e03@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e77347 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=3rYEZD2lxOpiP_6SFuIA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=ZXulRonScM0A:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: _MjyBvrrgghBgKENZqg4_CpJQfj5Kgm7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8nV6OnIRb8lx
 jX/xrKH0ZIhQL32aQumB528RZCFAydtUPnXCDsquuqrSH//KU86gIm+lRnB4rcMJ+BTLIGBsKsN
 BARgDL+G0AKl/KR2r8bE9toeyoiBA9Gt6bp+B+/ANa3MFx9L4V7nx6N1y/hFOialvZJ5+iaT4K2
 u1FwKZmaDzwFDhLxJUCTpFB6hWUK21XwUgGkoQdWq2zfRBlpRrlT3Z2WAPRsV8R7VJbW/GQT2eo
 VIDSIdIzXK2lzOg2zPDj/1+GZtwYlbP+jl5W1XFN+VLULCpTTwVFFJwJCKRLF9LMW3E29IefuqU
 XE3YQKuLQoCG3pCSb1kR2KcwUA3EB++jLJQYvn1/UK4U3Vuj0V+VXI/p3dRBsVt546T8z5h9Zvz
 PP+MTZ7Z69V7qd7Bv2IhuLXa/qnNkg==
X-Proofpoint-GUID: _MjyBvrrgghBgKENZqg4_CpJQfj5Kgm7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/2025 4:15 PM, Krzysztof Kozlowski wrote:
> On 09/10/2025 13:01, Le Qi wrote:
>> On 10/9/2025 10:47 AM, Krzysztof Kozlowski wrote:
>>> On 09/10/2025 11:33, leqi wrote:
>>>> Add bindings for QCS615 sound card, which looks fully
>>>> compatible with existing SM8250.
>>>>
>>>> Signed-off-by: leqi <le.qi@oss.qualcomm.com>
>>>
>>>
>>> Just clarifying: is "leqi" your full legal name in latin
>>> transliteration? It just looks a bit like login name, but of course that
>>> might be just my western assumptions talking.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Yes "leqi" is my full legal name in latin transliteration.
> 
> 
> Heh, this email is addressed from "Le Qi", so I am confused now.
> 
> Best regards,
> Krzysztof

Thanks for pointing this out. My full legal name in Latin 
transliteration is "Le Qi".
I will update my Signed-off-by to use "Le Qi" for consistency.

-- 
Thx and BRs,
Le Qi

