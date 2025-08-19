Return-Path: <linux-kernel+bounces-775883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E5B2C612
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB7D7200A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613A732A3C3;
	Tue, 19 Aug 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LCJoZEPA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE123AE9A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611096; cv=none; b=NMNJWH8pC0CR1LX4wvMgfzl/xfArwff6RVr0KVV3DC1UEJV9kUqdAfK4Hzn4wPmdCHwrRpAGp5YTsoOHmeKRQmaBSoOLNBOhK/4LVjpofBH4iOU/sGUIum0w0O+K0G3kSUD/xbqEBqn8kTA83NQ2SYag/0jE5m0994a+6AbBM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611096; c=relaxed/simple;
	bh=AYZbnwOPwzJWkM+k0OVBmKQh9N42C+v/pYFfjHMLRVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaeSpAeMK8vNcWNUPNsELJLMJMa3m7Z+NiZQBpObN9/bv6DpJRv/CPaSaPsa/h8jCAoCbBpYDqEBISrChTnC+4Ld5kRMgkR4SK0lHgoMvPCS9voJqw0GV/cdX92TCUqAkaKwAl1H4MKFxM+eZxim/w9Rc0ZGAZkDnPpRnlCzOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LCJoZEPA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90X4b007201
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BKkqlT9s5AsaZO6RLR2Htiq0L1b+P8/Jn+4+PCx41u8=; b=LCJoZEPA0r4iImFr
	6lqcGcSyDRHxtSf5Wj7D7YzR89GkKGrwZ2Q9bteGEnCbOvrXHXxlrEX2LIJeVrB5
	qp7gvxNok511+XgHciddoxcrIQsxWxY2C1cV/TnY4l5ciDBCHLliBGPgalEOLxbC
	CWL0MNZQAkXO0h9w6p2INoEjj9/6XK/aYlkcXuB0k/JOUO5MBGvenyOMaylIp2yl
	gvGl8/oispfm7a6jCFR5aCUdkcAy5w3ArmvqfR/E9OUxAHQc0NIexQuDkXZeLv00
	FXZp0/dFep7lT+IiBT9H0OLYWM1h3o89InSqwZOZDqGgNjw6dSqwNQwAHgl4LNnO
	MuR+ew==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj748qqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:44:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88de1e26so191217306d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611087; x=1756215887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKkqlT9s5AsaZO6RLR2Htiq0L1b+P8/Jn+4+PCx41u8=;
        b=bSoMhv+OYe0UDjt4gXiaQuYgFM12qJ9Zf1x+3bTqFDMGaHcwFavkAb7xPFVs9JW2r4
         1dGCMU7T8n0x2USWMsCAUCyN+xJWFvAsIXN0KrIlMvjlqsPVnmTAGaTG47/fsvK+ZotF
         Zx7RABKh+BiA0YvXLkiQVUlSzj3e3S7AtrjhVe/3xzU5AXOscB3X92Uul6saKNkctdGw
         4YezUJ1oemRXXvVLKQTwMe4DbTxy9VqCPNN9P8pRj8IjUZ3HV6S/lfLB2OY9B0XHKzHr
         8aJHzhDFJz2/Nb8gvXQEAVqDMmiIae/OF8uLIPwuMbgx/HggePG91+gGJyoNmuFBKCMf
         u4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9z9C0r3a1Ap3Su0sqttKtW2bSmbW8SG/6UQpJE5oQkfOz+0F0v8/aCmfK6E9G9PKYd11KPrhdxy3kc9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9i9HV5Qe/7INrD2Pr+QO+cB/t1Y4zYovbPc6KB72K2ctbRj6
	Ccb7bMSwctiaBY+FdxbhpaZRdNTlzDib4SXfwL8+qNIhd99YIGTvYwabj3r0quXp/gn8QhPxl/U
	q0THyg+qMurqKV9cOAT8unptf/TVAE6NmN3zEVjRWkQh/O++qM4IAkjTaRx0O03S0h+I=
X-Gm-Gg: ASbGncsNjvE+BBUnrkOflxps7v9pcA8kJmmsCFuAowTrQR3mQuSqJe8kQP/uI0ED6rd
	2Up5UmqgYzAli9ChVpRILJsac1xPJnNDx5MwTCbuyrdw/sfRs5l+GmAgkmr8uDN0G9TAKC2nPTl
	fS9cerqUAuWZ21PBiBrcvhwcL0sJjbfmq1z3OqngSbI0pcAvkH+EUwo4Upd+K8Kza0KaTHFo8qJ
	VTGH9lVCF14K7t2GpDjIh2h4oPqKXI15DqI1lukCgiexzEdFr+JuqMcX/XI4VCmxbxvfx4D6Evd
	AWf1AgB1gtiylO+Bz5A/ZJXsXUPsNm8RddFl9MnzcdY6p22BvuShyf94lG+hkleRN8M=
X-Received: by 2002:a05:6214:5004:b0:707:5313:eb93 with SMTP id 6a1803df08f44-70c35b98573mr26058566d6.37.1755611087109;
        Tue, 19 Aug 2025 06:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKefw+kYHsABqfVxmU5o4qliGwOTNEXsA5EmB2zAtUTekLaQCS80bnjjzt29xlDNuC7G7m8g==
X-Received: by 2002:a05:6214:5004:b0:707:5313:eb93 with SMTP id 6a1803df08f44-70c35b98573mr26058196d6.37.1755611086524;
        Tue, 19 Aug 2025 06:44:46 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c07496f432sm3787926f8f.6.2025.08.19.06.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:44:46 -0700 (PDT)
Message-ID: <990cb5af-3846-44a3-b373-ded62d3309b9@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 14:44:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: qcom: remove unused qcom controller driver
To: Rob Herring <robh@kernel.org>, srinivas.kandagatla@oss.qualcomm.com
Cc: srini@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724132808.101351-1-srinivas.kandagatla@oss.qualcomm.com>
 <CAL_JsqKG+dcMgp1QF4F3Oxh5Shvagg6cSde=g1JMcEAquZhH_Q@mail.gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <CAL_JsqKG+dcMgp1QF4F3Oxh5Shvagg6cSde=g1JMcEAquZhH_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QoYNPm3ftFwmWIP53KLhokJtGZQvqZU_
X-Proofpoint-ORIG-GUID: QoYNPm3ftFwmWIP53KLhokJtGZQvqZU_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfXwW0BMjo8Er16
 c+iGvUk+AyKJ8RRm06LwfuD4impAJiXp8iR/W4hSX8KHtBb+z7w9GsSnSrPJh9J52NTJ1/O85TP
 Cq/KS6c8bb7pJtbFEp+7a9wH4sR1V6Kj+nRGpCORgrFMAOTG864S8zS0YKu6LB6Ot1uLfNsliTN
 f6yXQ4dFjtumQwdawzXPjWos6vDZcjaA/6ogRzf4UwxgYy48EAF11ENg1g5Jz7UfjzXamVMXf2E
 iqqXPfisO4QPEIjIk0wm20gwAs2Ld88DmjnIYBYoTJARcmuEqHnS3sfWE6Nw9AnFeQLsxFZ8Q2Y
 XFdwbQErQ2kJS/4Uqn6n4yrRIo2W+N6lBOwSNKP6gfeFjvO9XUB53QFTaBDFZD8n708OiFBZLZc
 b+QtjU/s
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a47fd0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=lVDL77IP-BOR7NVgOTwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

Thanks Rob for reporting this,

On 8/19/25 2:35 PM, Rob Herring wrote:
> On Thu, Jul 24, 2025 at 8:28 AM <srinivas.kandagatla@oss.qualcomm.com> wrote:
>>
>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> Qcom Slimbus controller driver is totally unused and dead code, there is
>> no point in keeping this driver in the kernel without users.
>>
>> This patch removes the driver along with device tree bindings.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  .../bindings/slimbus/qcom,slim.yaml           |  86 --
>>  drivers/slimbus/Kconfig                       |   7 -
>>  drivers/slimbus/Makefile                      |   3 -
>>  drivers/slimbus/qcom-ctrl.c                   | 735 ------------------
>>  4 files changed, 831 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
>>  delete mode 100644 drivers/slimbus/qcom-ctrl.c
> 
> This adds warnings to dt_binding_check:
> 
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> /example-0/soc/slim@28080000: failed to match any schema with
> compatible: ['qcom,apq8064-slim', 'qcom,slim']

Will replace this example with slim-ngd and fold it in the original patch.

--srini
> Documentation/devicetree/bindings/slimbus/slimbus.example.dtb:
> /example-0/soc/slim@28080000: failed to match any schema with
> compatible: ['qcom,apq8064-slim', 'qcom,slim']


