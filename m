Return-Path: <linux-kernel+bounces-861144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 200DFBF1E49
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014694E6288
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5910F21019E;
	Mon, 20 Oct 2025 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fBTh+0cc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E808207A20
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971347; cv=none; b=mlnJaAbW9B0YQzMAXJgjTTf8EmiVlNKIEH928bgpB3W22npmqv0f8YLfb95WDTcYBJJJhMjKP7LmWW8jG45XQfqdJLbqIqtMdg8qciSAtlxDRIIum5rq5pZ3r/Z3z1fTELVme2nTr0y+IIF5FI/G0jpMiPGE/mSSJCmTn2S3hjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971347; c=relaxed/simple;
	bh=V0bd2YeG9y+zp8acJGrcHch1eDDvrpqFqZQw7v49GGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFsZx/vno3030ug0ZzmTf8pybDCuhE3ezC4m7gYp4c7dp1fKilf6iVy8oxZy56PBYac+D71OU8fsNNHSOjEEQq5Rylqb4vOJfmdTMdXHHT4iV+eAQl0HYhRlHT9A8LyNDhXCMUkZO1oL7HcJRXSs4i2kmmsDlltcuU8TQYsQYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fBTh+0cc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBtuFB021576
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AzuzpebQuiCUmAzs2L6YCgPs641qaIn58unhv6j87lg=; b=fBTh+0ccm1R/JmvX
	diuVbb0dJZo3q/4msMn9YktM4kbmgtH3AqRCHguNxlnNkO0a4vCYlUN2Cc59kQ0w
	BLmdb379qanphEyQN7wlKXvpY2TZT3RRVcp70JZuIwUjqBagmG2v6kx2xZizeICy
	uLWdtXG9geJGBXFKZ5V+hhkuMB4sq6Ij9YGAG6cClE7pR0rkfC5GDPnFNyvCEbdC
	YPBcP3zfdnY/yh1LQ3yGtOKAudclz893+4lYegUY8bj0QOio4peCxJ+vSbVRgrQT
	aXLqDAT+4v4WEbvny4Qngo4K5Ij5B4PDr1H5I/zE3WxN60GOBkwn3Hfw429ZUbnP
	uFVikw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w2pqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:42:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c6f88fda2so111405036d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760971344; x=1761576144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzuzpebQuiCUmAzs2L6YCgPs641qaIn58unhv6j87lg=;
        b=elcT4I3lp2AUflm9wleGpu5mUzXPR0ll95VgMkFHf7SHJAn8Y+NIjrKfAeneutHn70
         zAFE4x/Gmr5kKZWerbOF9hnBrvIPCYIZJ+OiykiIB+NwE5Q7PrlhiZugJMTruEauskSY
         +Vkr66rYmvGez4/ShEN49Ac0zMtYqTSWxE6A/8tAFeTkhojBv4ik+xJUVcN+pEhdzrza
         uy7hJFgoP0Ct2loiHuTc66buXmivzMXf00/YMY+6Qg6iwRDw/IkTxfFrRuYUSzrA8d8d
         ITGJ/zSEV+Nr3Ska65FxaRUy+dD36nKdP2xGjWbFJLA4kn4JXmK9/STgR0jxeY9Yg0D5
         YQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnHL0FJY4jaHKffL+TLYoTbqtFsW/DxCOj69ucH0jxFfF0rwF3g+6RpNW1to7cLkcIP5o56zp82r+nhPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEX/7jip8isYPk3uzGGga8+r3nJ3IWKhjLnxZrSBdztKkQisbx
	BPAGomVhqukF63dUX5vZiKS8T3kZsgG3Bd6sI6/8/JgYGclQOXvC/Jv47IEVRwKGAiTBKnET5ST
	AhvzbzLpAdwzpsmQrs1VssGIyxBOrmXvUUKT6UeUdABS0YLuGlGSV+xx8phL3oHRXcB8=
X-Gm-Gg: ASbGncuChaPVNmgA+axW+IhAqVOBH8glzDi8YCrfjpoJYyM3hcemsaDXl0prM+1Bm2N
	+XHGj0etmsKuB2xXJGQvskDghGySkrFxcEzULBLdK92/4g5Xs8vJI71MW3DLHSHlTkFzf9yP00P
	dMp/z4nUN/LGN1Q9gnrKWt01hk07fa/QkkC3l3Q9LBEKRdjcuRp/uCw1SiYAABOEmIZ2InT7e49
	woZduu6jqqsAmJTdo8R3tgDWWgGXeq82cjQIhbkUyqlzdsxm3nhZDt4rzL2+SCApxsr4yPijjGt
	n9SlMZo0aVzzA01l7XP2WM95pVdSD5lJleca9SLE/cL46RQwSbdyegNv2aac2Mip1dkdo0pck0Z
	1ghp29QG9a3RZvyMp4X7dJJ6fjg==
X-Received: by 2002:ac8:5706:0:b0:4cf:1eba:f30d with SMTP id d75a77b69052e-4e890faf914mr179126911cf.23.1760971344131;
        Mon, 20 Oct 2025 07:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhtyCSF+YM4DeIm4/Qr3TrxytiWpj9q3AAOl3feDFL2dnbHUTsqqQ/KVurNTcsRVplFSTreA==
X-Received: by 2002:ac8:5706:0:b0:4cf:1eba:f30d with SMTP id d75a77b69052e-4e890faf914mr179126641cf.23.1760971343580;
        Mon, 20 Oct 2025 07:42:23 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-471144b5d48sm237038165e9.9.2025.10.20.07.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:42:23 -0700 (PDT)
Message-ID: <97afc64d-b384-4edb-9665-a5d654c19771@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 15:42:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ASoC: qcom: q6asm: handle the responses after closing
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-6-srinivas.kandagatla@oss.qualcomm.com>
 <DDN83LOTCUIP.5O05FBN02AZB@linaro.org>
 <7c0dad34-cb4c-4912-9406-2e559b91142a@oss.qualcomm.com>
 <60a48dfb-e266-425d-8cfb-574c637f5e9d@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <60a48dfb-e266-425d-8cfb-574c637f5e9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Aamdhl5Z7Q_4OnTj9h4SsrKVPQOmKUow
X-Proofpoint-GUID: Aamdhl5Z7Q_4OnTj9h4SsrKVPQOmKUow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX32A7S0lNsoa1
 7DYKPdtASCL74zfxzLdPA7IYYD4u3b8zJXQnBCCSZp3KDrFgnRClpcW8IAY+nh0SANMRWrooNtL
 SmmLkPVSkGf4gsJ+MaoRkz+Uset0cIzPvkTN1/0r3rRoO/q/PC55DvsILp3yxmJjL6D2FS6S1u6
 ofUCOEZxhGYC17vatS6Ji1oyKGGR/wN8WAJ+Xu6/h34npu5ru2mRYCoYwiRfttLjUnTSC6Arc1i
 k0xvoVVFGYDjhD0u+5hwzhLdNyYjBW0d+J50XwW7M+FuBBsiEq5IOT2aDwzlXF3d46Y53YQx/+t
 i3h/eOL65fxkdp99OgouhK088OeOOyNPWMtQuYvbKf8wMnGN521FNDfG3X9OqH+qGpEIBMXfTl/
 NU+4EjW+StyaCp6+P2KZPVJIjyiLJA==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f64a51 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fPukrFknxGqXpuPaOycA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/20/25 3:39 PM, Konrad Dybcio wrote:
> On 10/20/25 4:37 PM, Srinivas Kandagatla wrote:
>> On 10/20/25 3:35 PM, Alexey Klimov wrote:
>>> On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
>>>> For record path, multiple read requests are queued to dsp in advance.
>>>> However when data stream is closed, the pending read requests are rejected
>>>> by the dsp and a response is sent to the driver, this case is not handled
>>>> in the driver resulting in errors like below
>>>>
>>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>>
>>>> This is same for both write and eos.
>>>>
>>>> Fix this by allowing ASM_DATA_CMD_READ_V2, ASM_DATA_CMD_EOS and
>>>> ASM_DATA_CMD_WRITE_V2 as expected response.
>>>>
>>>> Reported-by: Martino Facchin <m.facchin@arduino.cc>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>>
>>> I was also reporting this error months ago.
>>> Thanks for fixing this.
>>>
>>> FWIW there is also DSP timeout error on Audioreach-based platforms.
>> there should be only one for SPF get state command.
>>
>> qcom-apm gprsvc:service:2:1: CMD timeout for [1001021] opcode
>>
>> This is expected as we are checking for DSP readiness and it will
>> timeout if the dsp is not ready.
> 
> Can we make the UX better by adding "bool timeout_expected" in the
> path that we "want" it to fail?
its not that we want it to fail, its just that we might fail, if we send
the command too early.


--srini>
> (I have no clue how this is tied together, this is a high-level idea)
> 
> Konrad


