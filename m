Return-Path: <linux-kernel+bounces-870790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E744EC0BB16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F294A4E228D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A052D29CE;
	Mon, 27 Oct 2025 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bg6xkrgk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759B15C158
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761532907; cv=none; b=Ewlx534wP+vvEZr5L0Hj7cV7y+K0w9K4YPlcst0BJkbcDvdXdvWxM0lziY0wlzfX6EYs4hpZ0bueZ8Uhz1cbiNcXmeRXCYxR2Gso03Ib8IanmgzDZeyqjiwcFCuNwjVm384TdRTgaQ1RzZv7VObEOQIx3cXaF6/08XHtjvpRUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761532907; c=relaxed/simple;
	bh=AGvY242Ca/Nq0UAeAtfWET6y4Ds2aRq2tAvl2LBrZu8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R+ixZeClyQ8a6QN7VM/JLbPjdwwjjX3l9jYakNTFHIrRFLKos4EQ+VLeekSU4b5ywX1OsLw4GBMkUjf7m9zs7a2kncde4O/WejQgsJPTP+Y4dxsHa5llF5wvEFcEb03CCBMAGd2PSftNZxESUEBassOZP/0QCiS0UsgQUIZbA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bg6xkrgk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QNJC3M1090823
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JV5F2mfcXjbp0Yn0zNkEW2lY+742MXru0QGn/jvHbOo=; b=Bg6xkrgkAkMijxGM
	Sh7izWP93gHnZkwct7lHnjjYh7wWsRujrd5iZoPQbDiooSfdUBUuWdp+kEiQiLis
	3XsqlOlbF4t7Ozp1txnRX2Dobu/mK8s++PKYAYNzSCfPzFqkiiXaRBQVTnGTShH8
	OJIgPeR17U2yQFjXbWRJcBOfkiaOI2oXNQvXNoUPs40Lhr5NcKZcYfgnTUX9iYRI
	fz09g6JKO/MumbC1vhVqP6z3N8b4fsm3pcZ0LTDfkAlJTm4rriL+VqvETBJo22Km
	pHMwLdSt8ZT4SG8RjRqbpHttEg3s6Wxaie93ZW1QLOMozOvp7c6GjQGsqsA+1YAy
	8XZgvQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1ud1rcx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:41:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33bdd0479a9so4179589a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761532903; x=1762137703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JV5F2mfcXjbp0Yn0zNkEW2lY+742MXru0QGn/jvHbOo=;
        b=s8SzILiOlp/OgdBkN82IVhJze4BRF0VuRM8LQeivCXUbzi++e1lgqhC/lAmFenhvC9
         em1Zc6aFuLfnIZ93HrHyhVlvvlD5QoMMDIcCpvv5XGF7rohXSpoHY+zCibIB6dqVInhP
         q8D86stwT1CWd3aVeLsm6d9EpuIszNG3HnsJFWAkCruTfqycqMYxaTq1wUIoHX/MlSwv
         YoG1Kd8qYUdZt03d+DSPGG0kM37NNxd8cY4sZtm8maorVYcOHBTLYORHQzX6l3t9sJy/
         /xOa/EdKxJpw+GiZDUfZkTFdSziiTxcOLaPeaNhHtmhaRiFNs6V7RhGXc78yCli9MErk
         qABQ==
X-Gm-Message-State: AOJu0Ywkrjo7p4CiDwfF9vaaCIwJrc0EnOIbdB5QpUAvYBuOzoMAPvCf
	yA6Gzt1t4l9J7Fu4b2AKpWHm0J+6iT1MhMnhYbby9ugyD8+D6FQ3yz/aYG9ZUQ6lI/waV4MsB28
	4uTOQkXH4uijf8KCWuw4L5l7SdXq8ja1BTOwxc5sAsqNrWJNIlUV2sZdqw5A5PN0dRVE=
X-Gm-Gg: ASbGncvK5JV+kAkuWv44G3UyaZ3C0wEwV/8PnWdLnImmQ8ukpds43g1QBT8EVx6sPqs
	gGRLIKSTTMMBUsKWV5yB5QGj2d4KAOJtbLfuCV9O0wUyEoRDfOZuOZp4+NoChKiuMrKwcEga+Fe
	r1cikpMz4WaINpOdyrxUeJKmdwznypI8qAdfVTJU8ti+fknnbkyw3Ye801CfM5BVge+wNkK0fx7
	TTzPDCxbquhJt1zHyPspepIdtoPo1rBKpsNacY5Shs3S0+XcWjJx+F9rRcg3EMtq7oOZEPim6HJ
	z5AiasUxRYxRQkRF37e/Q3yTxuVmoNaUwvrKl3/Fq/6RmqDMufibXOVX7L86JIT+ISldmHFsujf
	1eIYDWPWvZY54oBdD/YLHLGvGVUMPYMccXSI4dwLCg2MMtVoqZBFD5w==
X-Received: by 2002:a17:90a:c110:b0:33b:c5f6:40ef with SMTP id 98e67ed59e1d1-33fd66b4246mr11005023a91.24.1761532903344;
        Sun, 26 Oct 2025 19:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2qj7rWVn7xtVSSroR9gqFj9StePj4mrbtd+kLAo1n4y5CO9Fe7FI7xL/9TweMaOP55jU5Lw==
X-Received: by 2002:a17:90a:c110:b0:33b:c5f6:40ef with SMTP id 98e67ed59e1d1-33fd66b4246mr11005001a91.24.1761532902827;
        Sun, 26 Oct 2025 19:41:42 -0700 (PDT)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d2767sm6622083a91.6.2025.10.26.19.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 19:41:42 -0700 (PDT)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
X-Google-Original-From: Songwei Chai <quic_songchai@quicinc.com>
Message-ID: <d2fd354a-e3a9-491f-b5cc-86040b037ebe@quicinc.com>
Date: Mon, 27 Oct 2025 10:39:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts: coccicheck: filter *.cocci files by MODE
To: Nicolas Palix <nicolas.palix@imag.fr>,
        Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        jinlong.mao@oss.qualcomm.com
References: <20250606060936.2756980-1-quic_songchai@quicinc.com>
 <54b6e30f-a194-4f5f-9df4-5df0d3d4d738@imag.fr>
Content-Language: en-US
In-Reply-To: <54b6e30f-a194-4f5f-9df4-5df0d3d4d738@imag.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDAyNCBTYWx0ZWRfX8o6eD1GkdItY
 e0S3xkAjjMe/e04SnVOK6v3RqqL2azASNSsCVGEk1a9JK4BoNj6wb9XGLosU0G0ur1iPnbVJSkK
 b8PVNBauKBFgfLrAMwNrcubKZGYVSxHfr0HHeK7ouXsNx487KloKgtynoonV+edXlfPMZ9TNnaO
 N4x+o4bhV9qfVt6ulVh9rHc82fYmWCuv3da3unWEUdGcvdrbhG+0rveohj1br2ZyX6RZ7Ueqch3
 C3RjkhQSyhDJlq9PoIpN5ABMmsI30yJy7o+EMKY0ml5fTvLDX7Jua+I8cITBZE2Gri8b28n6a+o
 2QoL4Hj4J42KQtAaYSvmOf0iHme/K4F/bvOIXKKlVGjpKu5Q26Q+dC0IVxwgAts1dWpY2fmsS+l
 YD+z1XAB1MdWUB3rqCeSEmyFUHP7Wg==
X-Proofpoint-GUID: tZR-WDCjthV6xuznmzWUlkGM2GyiewYS
X-Proofpoint-ORIG-GUID: tZR-WDCjthV6xuznmzWUlkGM2GyiewYS
X-Authority-Analysis: v=2.4 cv=UqNu9uwB c=1 sm=1 tr=0 ts=68fedbe8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=sPnlxz4oxlKK5PFXHyoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270024

Hi Nicolas/Julia,

Noticed this patch has stalled after being ACKed.

Could you please help review it and assist in pushing it forward for 
merging?

Thanks.

On 6/6/2025 3:26 PM, Nicolas Palix wrote:
> Le 06/06/2025 à 08:09, Songwei Chai a écrit :
>> Enhance the coccicheck script to filter *.cocci files based on the
>> specified MODE (e.g., report, patch). This ensures that only compatible
>> semantic patch files are executed, preventing errors such as:
>>
>>      "virtual rule report not supported"
>>
>> This error occurs when a .cocci file does not define a 'virtual <MODE>'
>> rule, yet is executed in that mode.
>>
>> For example:
>>
>>      make coccicheck M=drivers/hwtracing/coresight/ MODE=report
>>
>> In this case, running "secs_to_jiffies.cocci" would trigger the error
>> because it lacks support for 'report' mode. With this change, such files
>> are skipped automatically, improving robustness and developer
>> experience.
>>
>> Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
> Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
>> ---
>>   scripts/coccicheck | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index 0e6bc5a10320..89d591af5f3e 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -270,7 +270,11 @@ fi
>>     if [ "$COCCI" = "" ] ; then
>>       for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' 
>> -type f | sort`; do
>> -    coccinelle $f
>> +        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
>> +                coccinelle $f
>> +        else
>> +                echo "warning: Skipping $f as it does not match mode 
>> '$MODE'"
>> +        fi
>>       done
>>   else
>>       coccinelle $COCCI
>>
>

