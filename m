Return-Path: <linux-kernel+bounces-861141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52946BF1E28
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 367C64EA1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B456E21770C;
	Mon, 20 Oct 2025 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FwygVMAy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704C215F7D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971083; cv=none; b=NAFKrJb2BgAvGE8WHjsSqy3BTAPpOpfpMwPRttUNOZSL8qxQwQEqg7Nf0X9HgieaMAxIr7vgjbKbYhyHp35LM0npnbcZrsYCnkiBQ2GN/6pkRbmg1BbsfBa3kaGFrwelOL7biXpHwXoN87WgmvqwWtul62oCHoNwIXu3Ddh0+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971083; c=relaxed/simple;
	bh=g7vm66uFoBWXERlnSFU9QSzM2MNBZ6eB9epOObSdlZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEuc+beAkiFw1nEWhb4vA9Rg38vnxoY+lOZg4k7x1hf8X05OtqBQ6Iir+9liLSTR1kR1/r/kmARwtf4Og0iD0KnYigAivMI1ZEmKsCWo4Jll1qPOOAjycOsSNtEAOqdlRAM+SIzeIEuX8aZ+cuepS/aoxJfzTrsAkAinlpfop2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FwygVMAy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBthav020913
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3UWjAiIBrgLau2Sy8mogzZBA0wuWkqgwhg9kzGevk+0=; b=FwygVMAyWc+zuQTX
	Hv71MGzGyRMmHDvdinBNXZdut3E5ZuYTkSPocn+IXkEkuCSd97ehvd00YK3/YsOO
	cNylfGudOSyUN9Wg1wKS/GqRIG4/JcBFreXLwCaY1XzqJwIbfKBK4YCEv680AnCI
	SreQmRw4pugK51j1wkuX0xfOX9IJMYlRpEPYM3bzAcC0htHXvs8AZg99nmsF42CO
	jtVjAdxMgSZ1uI0gQXSj6xPwhU7zqHKU10ZSseXPjrpF0gxwKiRIiW7ERqyiMSD2
	PmtSrMNSAY+w+qCgMVOygEm63B/Jz7cepvEHz/DqLgBVOEakUPwFrGN3cOkGYYco
	9tpXJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfdagh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:38:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-890f1090e44so936331285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760971079; x=1761575879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UWjAiIBrgLau2Sy8mogzZBA0wuWkqgwhg9kzGevk+0=;
        b=oY9PqL3z+7Ce00bx8LdLOt9TQwv+gUVBOZNql2VidALtteyT/XjcoKTU5D+iQC1y3L
         Ls+OMU65Y2l2NI4bm6ew75m1mzfU2czFE54JiKfXuHl7ftDq0NOEHE8QW/qLLuStpn8I
         K5gLPlW7YOQkFkIqjdPhed1jJ1o9zRhGY5JPkhKTa795vPYT8UOUbTWFC5M+hEiz6ufB
         YzNddvD039TfLICyJPVsb/pR4ZvxKHj++M1vC5eVrkvA05ZnpNX8jwND2Z1I5IlfMTLn
         3dHH2LjdTEFJQwHiyEu8CWRGfp1G58p5m8jX0mmQB33Y5G/jXEEi21bTpY549vyIBelB
         suIg==
X-Forwarded-Encrypted: i=1; AJvYcCWOZYdFRXN6DiR1Iq3zqnrcoyBmUkHjDlq4lMlodVBx0U8xDAqvRjPREDrfXG9HLDFePQ0naZoUTguxjxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXqltotZnxMQoRNXVLG+blgPyA0FyOU1iiILuJzXcs++2mNfW
	uYWNnnhDXDxAXGVPZM5FD7OoaMiiY0eUm4bJdG+lbmDQ11+sBbVIiVLNMANCUGoX0MhYtb9gChb
	oKvS0X9EENRy+TYItYjdvIg8z3E3uFInBBQnHSW/tUwb6GD8mjgK+u1CBKBuA0ks10DI=
X-Gm-Gg: ASbGncsoz1SBjKV/3FMgqdiIO4K5fMR5F+mwaH4xDJLyLNFAFIjuEIK4UCW1fX2ts2c
	pG9Eo1Ug9Ad1P2f45S3sk6lmeXIUNZ6ZV4jj5JA18Q9de9ffhipGKq2vaaNYPrSj2fJgIWKX4BQ
	nz8iJhPD4DZAZJAC76UmcniQ8Z2wiXrX61Da5HJckxeh9JTwAC4irANLSP0+rbTeKyjx3I5kz2E
	XsKC1RN84HaFS63Up/+iSv7ajP5jV1w9+dgrMXZDE89g9Bj9CPhYYkn947rdJXQFX/8aHIlzuO8
	wsoZuAlkfnf6troNapkxdBvGBW5y7ypQY83SYPGXfzAYFtgG0eScLVFzMPhSRMqJ9YxZdUvC3yg
	kl+Xuz7sS+WFt/KwrijqQ/jiPIw==
X-Received: by 2002:ac8:5988:0:b0:4e8:b979:c7ca with SMTP id d75a77b69052e-4e8b979cc56mr65036301cf.18.1760971078974;
        Mon, 20 Oct 2025 07:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1lzeMW875NTSCbMzwfc5cSS58/qFqK7T2evBfqjYBnU2AF8O4gAA+d8fm7iX72aR+ZS5uhg==
X-Received: by 2002:ac8:5988:0:b0:4e8:b979:c7ca with SMTP id d75a77b69052e-4e8b979cc56mr65035961cf.18.1760971078497;
        Mon, 20 Oct 2025 07:37:58 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427ea5a1056sm15657051f8f.2.2025.10.20.07.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:37:58 -0700 (PDT)
Message-ID: <7c0dad34-cb4c-4912-9406-2e559b91142a@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 15:37:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ASoC: qcom: q6asm: handle the responses after closing
To: Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-6-srinivas.kandagatla@oss.qualcomm.com>
 <DDN83LOTCUIP.5O05FBN02AZB@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <DDN83LOTCUIP.5O05FBN02AZB@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f64948 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=dtEi0ryFqlHHO-XquR8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: MQ6ksbJQT45FHOJXSRYbXkQSL1zQtfrV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX2QO8NV+PiG5f
 4O9gmxdAHeEyuzoZzQuQFGtnOFdWICZ7KhtlQBO94KhGNag6Jvv1K42JtKpekLfEdlbXls3pssc
 zqRWt1+ynnqeuIviVnY2FmglvbP4TNm77B2rDe1/VlKZGLH/TRD1mP0PuVx7xAmD0o9gIk27sY7
 IhGFjSGpkeT3tMYQk9QmimA0iTFOq8ewjRD+81a76fj2Ywnw9ggirjdEF3qXDSD5t/5GGdXJgs8
 HDMcPwoblqDy7MipEoqCo/7ZE6zqLybJ5uu/5tkHLIMK6A9JIMTl/G5ccoRPuX9JEEjlNkTBG5h
 khyQRgitO15GQiFCYv3+AMb08ROHReVWiZGMqZ3IY0ksw5YoHm50bnLi74ujr4tPCQd/LdNOPvA
 kFghc7QSij8PMXPjczNNN3MDrnX4ew==
X-Proofpoint-GUID: MQ6ksbJQT45FHOJXSRYbXkQSL1zQtfrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

On 10/20/25 3:35 PM, Alexey Klimov wrote:
> On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
>> For record path, multiple read requests are queued to dsp in advance.
>> However when data stream is closed, the pending read requests are rejected
>> by the dsp and a response is sent to the driver, this case is not handled
>> in the driver resulting in errors like below
>>
>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>
>> This is same for both write and eos.
>>
>> Fix this by allowing ASM_DATA_CMD_READ_V2, ASM_DATA_CMD_EOS and
>> ASM_DATA_CMD_WRITE_V2 as expected response.
>>
>> Reported-by: Martino Facchin <m.facchin@arduino.cc>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> I was also reporting this error months ago.
> Thanks for fixing this.
> 
> FWIW there is also DSP timeout error on Audioreach-based platforms.
there should be only one for SPF get state command.

qcom-apm gprsvc:service:2:1: CMD timeout for [1001021] opcode

This is expected as we are checking for DSP readiness and it will
timeout if the dsp is not ready.

--srini



> 
> Thanks,
> Alexey Klimov


