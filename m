Return-Path: <linux-kernel+bounces-893934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3781C48D70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 186AE4EF5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3FE32C92F;
	Mon, 10 Nov 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PL1AEmln";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FQu4JQnI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30932ABC2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800597; cv=none; b=dNtHSYXs+F7tTp9EZM/zKgMIyeWLPMJ8inbyLVQh08xt6rn+vFkQ2rTlgwaCDW/6B2myf2erFRDAiNDyy2bV/UOpHUcSMOm/P0Q3XgTo4PcLW0XHVgSZPiTJm36IIyoH3z9v4W+fDiOnc8qcqjoCIQ4OPWdAuVCTn93lIyZxFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800597; c=relaxed/simple;
	bh=5KsqV0q3bBOU5rsRiux1gNTW1pdgiIi69GXvdpcIg2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoB0BAlblVLgQN9+AynPyJHjZ0XJDXftt92aSn+0l4D8bAwPExe1nIez6bdmmpePN1hegPR2at7f2b9PKj2PugulD7b7svx9+JPN0slyclVTCYfExIKQRw8q/wkF5vwLLwAiL3Vsm9GkLH5rRL9ThLNmxgcEJaG5NSGel4LDjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PL1AEmln; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FQu4JQnI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAGYMLj4070681
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O0m4SsGXFjn2QrveGO9bZZGQsmQpk9SLlkT4+HpNpjY=; b=PL1AEmln8Wp5xl7w
	if42V9d8kC2vO7KoDJ8J7Zziit+76YgVx6P4OGUTF5++Avt5HSX8vh+zX0RZUvST
	j1dialVZPYE8Ips1+6OIaaQimcYMg2Rn4/K568KCdb9SbqHr32ryC0wvm2u4zxYs
	g9xlzv4+LcBTGoUQHp2W2lIH0nh8gqt0+vUZJu17tSShwNIDii8PR5J/nrj6wGVm
	OzREJZiylPjgoeRGEdO15OJOUvoJuYFFqK/rfV93oA6LGJpq4UvqZU0W0Kqpp0hK
	vuyDnH+32MhvEqVv/cJMVpHn4smdPUT6TLB8MQL9pKkMIze7h4234INZE0m9diIZ
	4+WCEA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abkpj8dev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:49:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340c07119bfso8174000a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762800593; x=1763405393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0m4SsGXFjn2QrveGO9bZZGQsmQpk9SLlkT4+HpNpjY=;
        b=FQu4JQnIc9X6NepP1SbernDV8nPvFm6zn4itCBbxYZig6pcqZ6TSuCO+mMElYrO7NG
         fbsqM/Qy11Yg5bms/K3Ned8UOj5TTrvYpic58a4vf5XuM2rTe6xTy4gmHTM79xpR44jV
         pxyPmkRuDLN5T8+2c4ufBmnkq1Jh+GhUYOd6S1r+NiDlTes7aM1p34a5M4dcek0wUA6R
         qExZRp+OKj7yNAB6NoU8eW5krfWN6tb1x3s1+ENokaWnLlRzwO++eMI0C31kEVRB/M44
         R3uok/VdP8N0anTeX7BQ4sSMxkdAu3wrxH7bvW/bAypLG8G842c1IlUlb5GJAGMZK0sj
         Ciqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762800593; x=1763405393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0m4SsGXFjn2QrveGO9bZZGQsmQpk9SLlkT4+HpNpjY=;
        b=lIFNiYbYqAR+ab0uFW03HLYqmT4lAeJCJHXHhjxn+pnBBIp9PmsTJnz/JwVWEvIzJn
         U8hCrVX3icSeehJ/Wdihjtj4CWKLhUXqYmPhlZ99eAB0kT3e4tQhNlhZo51n4+XzAvWq
         F8pSKP/IKjh3xbN9TkFLDh+BNrQHmPW5sT/Rd9wAoSkJFC5vQp1ErGJ8ArmHFi/1LGjX
         gqg1JWDncyYew2/SEE3ZE9LLZY6+xLkZBOp9x1XMgf5kQ7rBmMmkrL8Qpj+K98lijRl9
         vpf2m9DQ6Utbo+Hiv53HK30dFOVU9hitrfooEYNB08zB+bofgHWVE1K3e6Vu2sKMMcip
         /UYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU353qqFu4irFiJv5zsdsyz7Ws8X3+vDl19wvNd4moRpXuRlryFNL453UHuDsg1FjZFvIfg2ItLBhc9oAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/+OKNKlmAFQlWrwN8y3EyJQNBVpXqr1jTeHP/pWliaM8AFb7
	MM3P7MzlfsPflbPBid/4x1DSSOi2KVG+5xSb7PUsR/AhYBOyrdf5uKAl+D0+Za4C2MvvVY8L6dY
	0o1KBf+5/PP4P/LKeSa0YtbOw1krkBhBzgqFzU0wxoOF1iXRmhWuQKk8cXGq8J+8W6oc=
X-Gm-Gg: ASbGnct6MG4z+rz//61fa1f14M/Rj4UnhIKbfmGi9N9x8JVksvHisiYvZtAt45dYopm
	fA0ovZ+AaKeG59u2gnzRzoYj1Tp/05onSxuZTeQe7zNiiTeup7TZWk5/cIGZ9NQi7I9UKZAd0gE
	r/iQt2ErSjds2Wnq08iuRxE2dMdShGLK7qMhjSnNc0mbTtHIADRNwD8R1KsKPtJH4t9ooK/pgor
	EL/lpfUNz+v/w89kLtvafN7KQlAV0cGnfQC/Save0lJPyBtIHkFFwkzcqb9+KrCOuQARA8pDQcI
	oxL/0KqhJHdowKe9xt31bbOlUO99MJEG5PLMQ6Cu+BUskvZumZ7Djw9c0MJkaQTDEuCgDiJjgsd
	V2xkEAZExkYmigYcHp7X30rHIVXMoQ94z9Bc6L4CDVyrcxTuIjdRS
X-Received: by 2002:a17:90b:3904:b0:340:ec6f:5adb with SMTP id 98e67ed59e1d1-3436cb7beb3mr11459419a91.3.1762800592652;
        Mon, 10 Nov 2025 10:49:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEly7/dDtyVvwZoxb1UUG2yBv46sYHnPdx6WiV4Ldjd9d3p/YphCmNqkTgC3gIcVgA7m3+7tw==
X-Received: by 2002:a17:90b:3904:b0:340:ec6f:5adb with SMTP id 98e67ed59e1d1-3436cb7beb3mr11459389a91.3.1762800592166;
        Mon, 10 Nov 2025 10:49:52 -0800 (PST)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8e750c1sm13402258a12.1.2025.11.10.10.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 10:49:51 -0800 (PST)
Message-ID: <507160ca-a3ba-4705-984b-ef94a56e3b8f@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 11:49:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/qaic: Separate DBC_STATE_* definition list
To: Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux ARM MSM <linux-arm-msm@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
        Aswin Venkatesan <aswivenk@qti.qualcomm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251110035952.25778-2-bagasdotme@gmail.com>
 <20251110035952.25778-3-bagasdotme@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20251110035952.25778-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ydpt7RS7qIDa7IEDcZE2Qp5k0GE72R8t
X-Authority-Analysis: v=2.4 cv=GZoaXAXL c=1 sm=1 tr=0 ts=691233d1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=yxMg_K-rWnv8iLjOS7QA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-GUID: Ydpt7RS7qIDa7IEDcZE2Qp5k0GE72R8t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE1OSBTYWx0ZWRfX/FV+n10LvHm3
 11pOLQq3lGy+BKuOyQshYA4mqwcvWKOLcNIYjBQ2DxkXuXXQ9EOp0M9R9iJ1MqFQEx8+m5n0yKx
 PfEBaAgSak/mEvzQ4XzqjNyL5wqDK5aCUbntUStEJxT+hTydJGINJhrtz5CXfw+Z68jy7cn+ABr
 saBvYDscMMkF3NKSxTQ7mnEH8CJUQB9h/2LTfikRufjNTaxgXB0CO9pZht4OO4E6ByMehVV/8l4
 iChQ/RsiyRl+FQKFx2KB32L8U1H2a9lvO7OXfx0CrO30A5svJFsIXFax7a1Egb7qSDGaiK6xVdJ
 aDOZfZ1vH9iQl8SzXBxIw5kI87sicnQDTXjtA2H6JoFUi7ixZ3iDuGbhQ7S5FsBCykwq2uOGkNM
 Ve30DClZtwOgd9R8fOescEBeSlD7pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100159

On 11/9/2025 8:59 PM, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warnings when merging drm-misc tree:
> 
> Documentation/accel/qaic/aic100.rst:502: ERROR: Unexpected indentation. [docutils]
> Documentation/accel/qaic/aic100.rst:504: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> 
> Fix these by separating DBC_STATE_* definition list from preceding
> paragraph.
> 
> Fixes: 9675093acea04c ("accel/qaic: Implement basic SSR handling")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20251110132401.200d88bd@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

