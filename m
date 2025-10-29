Return-Path: <linux-kernel+bounces-875155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F95DC1852F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21DDD504907
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6762F83BB;
	Wed, 29 Oct 2025 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MU4iDMhR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MNIwgJPf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C102D3EF5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716575; cv=none; b=usXHz2wO1k0qrmBMOsH8JJwalRkkUp/qrXqwi6Z3Wves7NWIGK8vHxS9f3mF08QIvRXHPeA+SsRQ5u/PWhrx8vzVQcYpMUVGzn57y01gWmTCRI77c5B8zvfeQJCWUyVV+TrVJN9ZI+6qW5ur1ZMNRztBztdPHEl5TBAp1EPhusU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716575; c=relaxed/simple;
	bh=Hq8XQ7WLCASzgS3W4PqiVhut8mCz2MvByqRttaBS+zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUjZ9n9m/k7sXfyEX2MqbJ3cTN3sj83IRLv92TwaKEaLt6+FSqi3oJV0lF5U4DCqjOBSGW1tdIbpxR2TiOuSXsVQnx/nrwnSJQ+dbRRnHh+U78T8J7AQdkAr6vICHDQXKSuMLu+1Z2dEe605SDijVkNdULZWPiBd+bYeDP5o+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MU4iDMhR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MNIwgJPf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v5op3755485
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D3bKb0RDe7sqcKTtSK80VBkKPBG6lWJuxoKADwOVxbA=; b=MU4iDMhRdB5gEpoU
	+Zp/rE6ISERvIz42qDt+G461liT+E0ZZsQG2ahU7C/pB3Tsxmq0I+bgEbtZFbCtW
	88tzkOm/7fJSKQc0mtSTOZXt9pG+egYpSosl4TDFJho8DV9TUwreDBl35WZcPuNM
	PtNuVO+WxiGXJrz0gZqD0puGbPRsovLl4RtUpDNIEk5d1OMpX8d29pJuX7B2luXK
	KsOvw+kEvVjocmHouSOl0tiPvHRTM8vVL4Wykob0Km7hXxiACy3oIN6wQtXxXtzC
	z2D7wN1KL0D4AM1WYFcBf/9HUcIRBFzKh3HCi+UnfhMqV9aL0H8Uj5lT2Q/Tq+Md
	Ea5+Bw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a0habj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:42:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2924b3b9d47so60898075ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761716572; x=1762321372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3bKb0RDe7sqcKTtSK80VBkKPBG6lWJuxoKADwOVxbA=;
        b=MNIwgJPfnWISd6Ss4T8KCFu6QLph2vMHI2PMMZChFpuGVbknH0ygVVw0AMDDVb3D84
         PDcXFyCoS+Zks4MiKXBKqcbTdf7IyIbqKmdQUlMn0+3P7qEn2VTd9J6TTxCX43icHvCH
         LMxU4RMc5/vScmz2YwmoyUyuKWCYuSnlznVCm7xU9OgK9iv1VwEgiLL9+K9aKQcExzAW
         TMBDNklV0yhgk6hG2CdUojGwqWvfmli300TsHLsy4gCNjyOA5zTuJPQ86eN8wWaV6oAl
         2YZnzabFedMLDWsuEdSuZGeYIkZoHNTAufHCuMJWrawA1zhJTDbsGoKk7Qkm0t1vsc0a
         StZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716572; x=1762321372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3bKb0RDe7sqcKTtSK80VBkKPBG6lWJuxoKADwOVxbA=;
        b=JuSaFvOr5k775C4Qnpy7XQRnFcgeDQ9v0+vfQZ0rHsAT5adwMQ9ggPc5BoUPdGCknD
         UBvJ5bxlOBXse8p0wE4PcE74x0BKBujK7hBTj0ktvjI1/j/05VYhC5chs9U74dtzOUA7
         aU29l/eqdSSaxye/E23yqS6dD2FjsFDBPbtJ4fFAo8SavxQ3iilv9htszAsQcl4Ju9pC
         LRmyPWV5dPfGVyxFtgZEC3PE2i9rWJMp77s9DwNrd/L487XEv/VO92AuIqQ7HD44tQMt
         FBqtzUp9kxYUhbrA/cqt7+P2fQMJECmYyTy08s7jWiTX2pXGniY1uPu2MatBnxVKcV70
         qodA==
X-Forwarded-Encrypted: i=1; AJvYcCV9dLatx6yTryzuA3LNK34LdstRu1sD+8GWoSKsawrDAtK9PMHVgvmehYpT6FHejVpJuxsFlkWiFp8RAAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFd8nHongBTMutG5INAsxM/noAfPBnYm48/dDe3Y6SX1j12eVl
	8OoFkvBbkirId/ivWzOEW69eyZyeoVhVMOa+mRqClpy3/A+Q3j0QpTZtXAzYFSYEpMyLy6FVcPt
	QKPIInr0Its8Fp4t6LoD9gias8eZj5D/ixVcwdYOdZ/zY8fKPS5sqZlJzdKQNkXIbvYk=
X-Gm-Gg: ASbGncti44S5rw1vvCZXlKVYb/3qrKR4KjtLW6NGDFe8fRp+fJfQWaTz5wf2avetIAp
	pe4SiPpY2Wz/pZNBW+Cdv5zaiacnV1N+GUAacXLN4VFhKG3n7I9jlcuvNvQZ4fOcmwrI0xKEUi2
	V2tweP6RcXuYTUyK9HTmpNJSD4jFulD6hGn8vmytZASuk5GBBNfO2vrwert+AlepoGbZx5vN6Wc
	OCR0PuWmj2wF9zJHHPhYLfqnWV90MmLe6dJKxSpCGOgZb7JYhQKTwtdNe3JSlB0032NL27LQLGB
	+NMnR/jheMjxSp8Za2G0MZnnct72gUSTA71Ym6Qryi5Zto58t03v5fLSPQ7x5Llpl3WbBYFbWqL
	Ndf2Uz+i4ys+1pFVfamusGiF3/cQySYSX/gt+8xrwvheGtgQr5ncFA1xMIeU=
X-Received: by 2002:a17:902:cec6:b0:26e:e6ab:66fe with SMTP id d9443c01a7336-294dedd1f75mr20591255ad.5.1761716572206;
        Tue, 28 Oct 2025 22:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0J62yU+cW/tUQvL7VRAYtrnfeGLHRB6xGqt8DJOtnOMkh89UIRroDUUeQ58BKxUmHrLwaFw==
X-Received: by 2002:a17:902:cec6:b0:26e:e6ab:66fe with SMTP id d9443c01a7336-294dedd1f75mr20591015ad.5.1761716571699;
        Tue, 28 Oct 2025 22:42:51 -0700 (PDT)
Received: from [10.133.33.214] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4b17sm140263785ad.5.2025.10.28.22.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 22:42:51 -0700 (PDT)
Message-ID: <a1b02978-8c6b-4480-b2cb-305865ddb7a4@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 13:42:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] dt-bindings: media: camss: Add
 qcom,kaanapali-camss binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251023-add-support-for-camss-on-kaanapali-v3-0-02abc9a107bf@oss.qualcomm.com>
 <20251023-add-support-for-camss-on-kaanapali-v3-2-02abc9a107bf@oss.qualcomm.com>
 <20251028-wonderful-olive-muskox-77f98d@kuoka>
 <84ae4280-d0f0-42a2-acfd-e85e0263be1d@kernel.org>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <84ae4280-d0f0-42a2-acfd-e85e0263be1d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=6901a95d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=FnPmbW6RWPOSwBWwTPYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: u0qSGc72PKUxj63sqf20YJlnP3i_LkF_
X-Proofpoint-ORIG-GUID: u0qSGc72PKUxj63sqf20YJlnP3i_LkF_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA0MSBTYWx0ZWRfX8XnjkgFlSfJX
 BrP1pENWxN95Py89S4xn8IDGJ1bwS1+ApTnNw5TZ/Fyo2bk6UgAFls+m17nPR27cRp0losXb379
 4XdWSVosjZECRuhdmWzOViZ/+Ueeqi2TmvW73i1a/bSw+2dKvlD12mhUdLoivnHuYNfTYSnWln6
 CbX/Q8ERvFS8iV48iwMKQl2H2CzX9tcysTEUKfn4hM9dgWV2au6/Zq2ax5zjetC9P/feYLc5OGi
 ThVLDevGHNfm+5/ICKqT/9PJq2UmrgHUGYUg7XW89WWJtQEs/lM4flycVW2xAKukqJfuxQJF3L+
 8UVidm+JKnp54YnmKu+Rj5C7aaabTx6wBH7+9h8tJXWA89IZZFtKGFqWwWlg30vdXjkGwphmSnS
 Tzs0yvebxnKTcRukp5ca7ufJ4K9Kog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290041

On 10/28/2025 4:10 PM, Krzysztof Kozlowski wrote:
> On 28/10/2025 09:09, Krzysztof Kozlowski wrote:
>> On Thu, Oct 23, 2025 at 02:14:34AM -0700, Hangxiang Ma wrote:
>>> Add bindings for qcom,kaanapali-camss in order to support the camera
>>
>> What is qcom,kaanapali-camss? Sounds like a compatible and you cannot
>> add bindings for a compatible. Instead add bindings for hardware, so
>> explain here hardware.
>>
>> You could easily use `git log` to see how such commits are written
>> instead of pasting here your downstream practice.
>>
> 
> 
> And of course standard comment:
> 
> A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
> prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> 
> Best regards,
> Krzysztof
Will address other comments and follow this standard in next revision.

---
Hangxiang

