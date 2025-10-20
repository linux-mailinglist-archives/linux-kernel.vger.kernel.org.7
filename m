Return-Path: <linux-kernel+bounces-861060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B1BF1B24
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E087F4FA12C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2113203AA;
	Mon, 20 Oct 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdfWAVpX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103D320A04
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968648; cv=none; b=Nh26ynlph8xkMVeWXibqiuUCw35WRszehWklVPwn6Q+IiLw+2iKK0vn5JF73BAjVPQqhdwWctlXfoUxFc+p40MUs/IQpZsRkkpuI1Wo1HsVidpID6AjaGJvPtQVr77mnPaRmXHOqHrOtYtmojekBfFotRKWBsmnkaIOGx1u/sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968648; c=relaxed/simple;
	bh=A8hOd+NyHhmPh2zHInfdGnL3TO16aSzoKbKuuytyv14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJs9d6AJvXD6YT+m8hoSjuPOxcNYO/pinmsco4z+UT9Wlj5z7g7rBmzyLlQqMCpec/Vuh/ytN/aWsiOTcQo/rIFNAOodqRRRx644jdUlbEHX3aISxt2zyl4/yhIEHWI0WujwYHA8KKJai4EBXXf88cfQSQA7JKAeA297d07qLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdfWAVpX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBsovG018249
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qIJKOvCxcYruswbUzq9fr5+Eh0foHybSIq/Oms+hhQU=; b=jdfWAVpX9TExDMuh
	ZK+3mX23sEkMJmAsZUmCsoEJpxSUm4EncpHPNzAias+XnllwWVMgqj2wKteUU+87
	4Pq1osV+X0BK6FFF95HCsHeE69a/aA/UTnobWObFTSOWha0M5mx4i2IoEgEapdBP
	s7c/rsoSiZIXYhZxUGkL/d9HTsUSAYo/FfnV+FHATOU89QKHLEI/Sde/pSFEzT7n
	m4e2ds461LJ1SdSgjZ/AILfkTGbGJBcH9uTPFq5aXeghIX/h6BrHZxr+pOR3pkPa
	u2O36w8IOsaXyyhGx5lqRdCiffKgSYB5zX+w7OKl6R42KdjZ+vxodYMHWx9WXmig
	uk6AsQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3984uwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:57:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b67e14415dfso3119334a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968645; x=1761573445;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIJKOvCxcYruswbUzq9fr5+Eh0foHybSIq/Oms+hhQU=;
        b=cplibMB0Ms2foEBlm0jefCpOipbp1C/059pTqDwF3FS/VWUW98umF3kE6gBUL7TmDn
         wXqPQDwzTBHTXo60INqz3a+0iDPvNrjY2dCdLWhNOk1tJKoAm8dhmUYkI0HAm8x1HFTz
         uoQF3GYKL4LyeTi7/e0Utc76KlusBlYZT77SSa3bskrUGffY/pV0qTGc1kTvbJyLsKbv
         x5Dlos5D0QiSj1V+tmVPPtm5v+LDb46u/h/hU0jydlQqpGaGF7S3XBk0x5DYSSX5Uta0
         Nf1b2dSVDgidbz9pTMcyf55Fg35EUACKURtCPwTWJ/S1KIFHDZ50NdezA/TqOchwvVUf
         2woA==
X-Forwarded-Encrypted: i=1; AJvYcCVe1iaYzjuGGMCqdqwl54LM5v74eB700RpkSvj7F8m6TovRvSbaZYL3v8TNP3cT7if3d0gkVtORMZSRxpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XHpjE6TtIPrqG9bFTW1MnIrbB/Cdk1BjOLIZehX23MuA3N58
	lqkNR2ZPX8HSFllWrQVZmn9/FBSP1VaKeCbpI73CwsxLgDWfrwCDWzb4+OxpmZmpcJKV1UwOA53
	NEuNCbBnAlIkss3QLOuSeRuvy8Kq8Q3SPdvYdo6GnNbXMtFczsyoGHWYSRPoilbMLGDg=
X-Gm-Gg: ASbGncuu5kC2X18QY1/hUgLpKu9iGOsKTGah0SZp+3koo1amGyvCrhUy+nTJWczOs9z
	dE30Mi0y7PWFTN2fECalheQzm0hr71pEoZYtRmFy/rMLB420FIeiYGZBKjkbkNJGrhv3bY6F9w4
	LowOxdh817kNEVavefDVD2zMwCPJ842TGA/F08RnnGGOIPhJgOF0J+HUB5lJdRdl19ONpjr6Kt2
	fofHs29LG8gtEsX2+XvGLuFEtrVsTbJ5XwV08ZAll6vMskOzIHRauYCe0tytzaf1dA3qPdVokXM
	hAETR0STXxqV7PzUfuxy60nlEA0dLjSujQ1oQF/1gc3oacuPPnzob+ye1IZYiCYh7ly09gYRuzb
	7VvCDbJPhaVWZNNGtsjAhkC6VG2VhrB3DbH2odyHpNtHR2Rs/XM+LrUMqkkI=
X-Received: by 2002:a17:90b:5386:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33bcf85b45amr14364030a91.3.1760968644490;
        Mon, 20 Oct 2025 06:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA4meynf7p6pqVmPtlHOuUrwOJeYLX0JWNpq3bEBdJBjh/Gd1Q075D8zivONKd2PftWkqGwQ==
X-Received: by 2002:a17:90b:5386:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33bcf85b45amr14363995a91.3.1760968643935;
        Mon, 20 Oct 2025 06:57:23 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bcfc12fa0sm4940456a91.13.2025.10.20.06.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:57:23 -0700 (PDT)
Message-ID: <e5f7d87a-e170-4cad-98e2-5e492e679c21@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 06:57:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ktap: fix minor typos in ktap.rst file
To: Randy Dunlap <rdunlap@infradead.org>,
        Clint George <clintbgeorge@gmail.com>, corbet@lwn.net
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251019202053.285723-1-clintbgeorge@gmail.com>
 <ba148c36-8778-425e-8c94-35ebd708fc80@infradead.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ba148c36-8778-425e-8c94-35ebd708fc80@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KcvfcAYD c=1 sm=1 tr=0 ts=68f63fc5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EM1FLKRHAAAA:8 a=pm9b69XgcQeHAuKcwUUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfX3ksr64AiPuR1
 VIKl9MewmaBxachthX9FIq4sg/K0tCFCxecwbitUy06S66kZOlhdLQmtiSUhvcXOwapiCY5aStD
 GLNpite9Gi4tFGCLSwGOGDD/f2fKEeFIWHUIowu2euVR+EtVtM7Oquho+Lb+acWCx5rKBrngrXm
 27r7HNqoUZFn0pFO9K4CO2kGkOiuuW5/sHZF8TVrDjKa71ibCQfYz5AHO1d28dYwdDm1ZYqvRnZ
 63ZkxBDA7J0nSf0q7iqhU4Jxx0aWQ68ZIbevoUQKOwQZ9xj4FIa5lU0d0fqqa8ytn3icZEqtc5I
 p29OoRec3SprI27pg//RQLZVvyAR6Ii54c5312f1f/zGI02YyTS2G7SZ/vF3e3GOk4kNjO7CcHI
 zvlHJDQXOCTqExg0X0sjBJoPgsU9Tg==
X-Proofpoint-GUID: hPtYdiXCXOm44yUEWJ3LpUeEiKc55cdy
X-Proofpoint-ORIG-GUID: hPtYdiXCXOm44yUEWJ3LpUeEiKc55cdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180025

On 10/19/2025 2:30 PM, Randy Dunlap wrote:
> On 10/19/25 1:20 PM, Clint George wrote:
>>  TAP, or the Test Anything Protocol is a format for specifying test results used
>> -by a number of projects. Its website and specification are found at this `link
>> +by a number of projects. It's website and specification are found at this `link
> 
> The '-' original line is correct.

Randy is correct...
https://www.merriam-webster.com/grammar/when-to-use-its-vs-its


