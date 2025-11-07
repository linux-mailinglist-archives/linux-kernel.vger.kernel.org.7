Return-Path: <linux-kernel+bounces-890163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCB1C3F5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115C83B1976
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F242299A81;
	Fri,  7 Nov 2025 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6S78mIw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evqrelLx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D82AD22
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510555; cv=none; b=uYHNfMEA+c29KSw1rTPykvR0ILebPW4us76nYlmMMzBJk0qApWkOSXfak2SYxfA8bH73AI6xj6ltTaytYSlB8AXosipO4w3iwwlH5vkkV/NQ141R/62r3b9jQnMnWxxAygW41D8tPF1sZ9bVk3trR6v3tFQ1ruV/OcNS81/ibBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510555; c=relaxed/simple;
	bh=Anyq/raF18/Z5tmIRwUrDoEZcj/HsfO/X7b39NnL4Ho=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=FTPwuI6LUkWoRkVGohWa6rn5+tHBgIwfkreMN3hYV3eizkq1W8sgndUBlSnHmOgombQeb0Y/2czOasPH2t1VwfwwwFaYnJ/blOlaYuPEYjFEXW0uKa2+IYK2BYF+IdgmPT8KFhNRXtvhMLscfsPEQ53Kpv0az6o9lodGLJFluOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R6S78mIw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evqrelLx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A78LNE64131391
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 10:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Anyq/raF18/Z5tmIRwUrDo
	EZcj/HsfO/X7b39NnL4Ho=; b=R6S78mIwVAWa0C4ff0eH3OTF1cA9onD0rtKfyi
	2IqUCx3sjZRYtABFJnYbQPsF1j6I2VbiTmzEYI5Hc/3Fwm19ozo/yiHYINjxEpDH
	WAlvA4XdCdCpBRMCdxY1b3NjIQXQirA3haaiy9vRyCTL6OY91FNWhbYjhjO+AzSm
	3XNblZJiGgLi/PAHwRClFztqw704E0URqqvU/Zvkv9RqcElvygflmiguNI6DN/p1
	rZY8xBV5XvZxW/B0YN2uNArBQjfm87IJpIrk1MKmU7pnYhPhxlNz4sodcRmWQdax
	E1v/p2sCZLZWlcL2yp0ETn1olqJZ8Q8Au1ngoLKtNpahF5PQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u3x3nrm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:15:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed704890a8so13485421cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762510552; x=1763115352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Anyq/raF18/Z5tmIRwUrDoEZcj/HsfO/X7b39NnL4Ho=;
        b=evqrelLxMOXsxcLGMNUVJHH6yZMZyhsi893P9DLCgNo2/eksjZ4LcJBK8g7bWYHX+h
         LVfXXt39VTrOJKuFnoHjHgJ/ZAo9sixP/3p5V65z1TllYwnLGgXTikw3Gsh1D3hSOrc6
         ytIcYvkxXLKzWpNxbdn26nZ9Ty0JM+r0pApCvkCjD54RYTy3hwloqwSHjwdYxkjJiJu2
         Ecc4RQjl0FfzsHrKI+ixvfmbmooEBxw9OSfxkPLex5/kSmuVVBwHmCt14qIAjZXiRB8q
         krOuGvLj5OW0MXNcJqyJwi2Jn/W42llHWqBo1SRJeriD7GZmC55wX7jPPfUGUeu/yTkF
         duuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510552; x=1763115352;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Anyq/raF18/Z5tmIRwUrDoEZcj/HsfO/X7b39NnL4Ho=;
        b=jo4X6u63u0NuuzPa0PkDjN2yiub6/DnvMD6sJf1SLzpwXmirCY6On7o6MJcxkIQl+G
         75ByZBBDZ/XPFE6hEYHXkC65U8lCi1x7EPfz7jFT7H6af5UmTIc+cY+mK5wjnFzQOazR
         TKARl0xBVGme4BDU+FRCxQnpRbbEwtd1uwoD2Tnt6fwcChJ7PPSsBJEki11qNLFcLqRZ
         sT+TJS1COdbXgQKvhcL/jcBwVHqI4UzM+NrIkUvWFtaLHscJWMCDgdF+BzsebwRP1Auo
         VfJS4hW0itVfQVNEMEvZRLGPP8VHoAy9LQx5A+SKytk3dtkb9Gf1geDv/bSkEcQn9lWp
         3Y6A==
X-Forwarded-Encrypted: i=1; AJvYcCWz2L1iF4pe+opHmtrejYAIZLdbaRQXmvyivYxVrWzlpfJh3OcyZytM93s3eGZcDHGbCl4QYz4lo12HWGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLCQI9R+FAIFg9g4qO0SpvTIxjJbb2bJ4fgLstTFB4dxuGeIJG
	n4BUUYOttWfE9CgHYX7iNyTWHWxs3zmibhsm/ugFl3L1cC2kXFKaAHSqqJyuITQccewfaCNS5a3
	okXovL7sAtADRXeC9gBcaQyulAuEqeKIpcVMbrq2wTTkETkvYB0l7oCCjcOsm2LQ5C3s=
X-Gm-Gg: ASbGncsW8ruln5g6Y2+W7sHoL1Ufwm1EKBndqBUoxMKXzELlFjJY80Tjn5f3MP1cwq5
	3mlkKKPKBEVYFzTwnNqoIiO3QwiFeEbFpwUCbo/iIaH/nNsyIT/DPWXNh3xPlbNRLCQ19bBQijD
	cZVA0VYI1BCvd6U5xrLECr6aQX9wFVRojiVRT8w1tjQup4SGAY/95Su94aJWMX4/efFFiasQ1D4
	YI3SkzF/Lr9DDvSB4ZTHXVXgE0LbDu1loV+W4+f1KOGDEi6367bk0+c2GKhWPvO731ezC7oP/Gh
	6ulVtIIFciWuVIrlZcMIYqY5BElPjzg0AUb9+uH9rhnvZ4/oP99dCxSZTa0a5emiarRylzg97gt
	i5qdGuUY0+Nq3B3fL1Z1YtoqLoA==
X-Received: by 2002:a05:622a:254:b0:4e8:916f:9716 with SMTP id d75a77b69052e-4ed99820988mr11215111cf.36.1762510552473;
        Fri, 07 Nov 2025 02:15:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHafiudsuRZWxYGaeINBS0P8B9LbBBeVGf3jzVF6gn63s52bJBsprEWshk659I2xJipbevSkQ==
X-Received: by 2002:a05:622a:254:b0:4e8:916f:9716 with SMTP id d75a77b69052e-4ed99820988mr11214841cf.36.1762510551931;
        Fri, 07 Nov 2025 02:15:51 -0800 (PST)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4776bd08834sm39413235e9.15.2025.11.07.02.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:15:51 -0800 (PST)
Message-ID: <76b8ca1d-040b-472e-9804-5c0c0100b5b5@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 10:15:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: DP/HDMI Jack and Pipewire
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound <linux-sound@vger.kernel.org>, wtaymans@redhat.com,
        arun@asymptotic.io, Jaroslav Kysela <perex@perex.cz>,
        lkml <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4MiBTYWx0ZWRfXzkpn/2zbCPSP
 kvXcfoYCHYs5IulFMgip5EFH8Notud3ShXpYU3DFdzFnd37X3IEezLvBuJTBhEyhjr48JAoVmtt
 aXQEgxQFmb4C2x1vBjs+0bsQNaoDjaEDCP+HvFB5EmCtuV2QQFyldc9exJ+0wsVmaE2iyC47zfo
 Gz4XdYfSxy6BPog/X7T+9BFzVVIPH+BqOhE9iNAosnm2ea42euFlDViLxUDlMbjM0YKNx8PPOvW
 YjJIve/e7v8poqMT5dNLupJRIP4I6Q2bvEVC0DQEb7zhZDInE9Z9rj1indzkoKypw8Zijr5n4L5
 tPkJm2aSkxGSn9etbQ4AoXh6CUEiP+SMfS3m7uNdoE9ImIJ6q+Wiq0Hy88063urqzy7e1fgROSa
 8wkGFt0ERiUHnh3aaqP2AUrcmVMzew==
X-Proofpoint-ORIG-GUID: MyLW1M96FUrgRS2eTf91gkJR6HylPaIi
X-Proofpoint-GUID: MyLW1M96FUrgRS2eTf91gkJR6HylPaIi
X-Authority-Analysis: v=2.4 cv=BrKQAIX5 c=1 sm=1 tr=0 ts=690dc6d9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=wNNw3XZq_sXo5zqJiy0A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070082

Hi Everyone,

On Qualcomm platforms we have an issue enabling Display port on a full
Distro setup with pipewire and wireplumber in place.

The issue is that Display port Audio IP on Qualcomm SoC is powered off
if there is no Display connected. It make sense to keep it in this low
power mode when there is no use. And the DP IP is not expecting any data
in this state and any attempt to configure or send data would result in
error from DSP.

However, we create PCM devices and jacks for all audio sinks and
sources, including DisplayPort DAI links. When PipeWire starts up
without any awareness of jack state it probes all available PCM devices,
including the DisplayPort ones. Since no display is connected, the
prepare callback for DP fails, leading PipeWire to mark the sound card
as unusable. Consequently, it abandons entire sound card, including
other valid audio sinks. I have also started discussing this issue with
pipewire [1]


What is the expected pcm device behavior when DP jack is not connected?

Two possibilities:

1. Consume the data even when the Display is not connected. I see that
in Intel case it sinks the data somewhere and gives the user an
experience that the data is getting consumed.

2. Throw an error to user if they attempt to configure or send the data
to this disconnected pcm.


Also what userspace ABI to for such usecase?

This is blocking end-to-end DP audio enablement on Qualcomm SoCs.

Not sure if this is right approach or will work but somehow we back the
pcm devices with disconnected jack state to use dummy pcm ops instead of
actual pcm ops?
This should at least keep the pipewire happy. Is this the right approach?


[1]: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4938

Thanks,
Srini

