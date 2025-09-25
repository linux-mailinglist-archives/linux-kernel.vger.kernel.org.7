Return-Path: <linux-kernel+bounces-833093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3538BA133D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F969176619
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3B01DF27D;
	Thu, 25 Sep 2025 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6pMUdgg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFECA31C56F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828786; cv=none; b=louguRWJ9TVLZlmlExGbIzB+7uGS+vYwZEjMMoZX06+jfm5ykPbS3a2L5zLgYkD3uImEUTBUwk7GVWqMJnyQjMpOeWcE1S5/X/4oEdqM9d4gzxIW4v4rD8WHxuJ8JKfPMTRhrynVfUrsRDFzIkioVLfcTmgm8zuy0tNsZTHWmIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828786; c=relaxed/simple;
	bh=TnBEnMqj9PcBFYUsBVb09AJzYDc97RSDWF7EDvNsZr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ou4QN1D/niLt/ydS0aYpiynQ5Yb84F4JLV6mpUOZh146Bp1bP0g4F+rTeKIbyqQkGJOqo+Kr22hWW8CpGo4aZ8PVljCs35YSarY18LTQGRJef915o5mYZUyF30Dpt+5zxH+6NZkr67ZJKOWn2TF3IauIQHPqIWESHflFxxu3mVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6pMUdgg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIUuCv006031
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TnBEnMqj9PcBFYUsBVb09AJzYDc97RSDWF7EDvNsZr4=; b=n6pMUdgg7o1HOrgY
	EhGqoBKaP6P2x8Bf+fJ0BEpsE9y7I9q+ZUsYD9Upeuz+1qp3rab4zpH6l0DAbCoH
	pGmpyB/yuXh5Jd47KllaZk53mhlUdOuw4ydqth+gkoXHHIgTQdrDzi47c8soowfa
	etPQT3hvO3eavu8XhEpS77QWY3YVZlzSSvKI5qX3j+4mO+/NU+gMsgj6Y1XEXw4U
	WhDf1QgSRAOXGbm3uHmYMh9PSrAWdsA0Uhd4Y8u0pC/419B4xZOj0S2e7LND0PPA
	QK9hgYURCbFTagVrzz0yEQN4QwrN+JkNtFJaoRotH10ta5A2cVZdvP8VY2o0fkb7
	T7EO9Q==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db3204ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:33:04 +0000 (GMT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-893656f5776so165556039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828783; x=1759433583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnBEnMqj9PcBFYUsBVb09AJzYDc97RSDWF7EDvNsZr4=;
        b=rBPkNfjJsR+lOVnmTS5qzPP0SWH7E8t/4LEhvmyaHHpXL1Q17Jvlk2hEy8seAnV/VR
         rcoRKLyggFYjfX5nGXUGEEn9iQo2ZExJLnfyDHCz/M2zq/p9Om6cJyTPqk6HTBlUtDrJ
         4GDsTTufkHWQJGohGYdWGpl5Z4jyONLULWkEmVL/nG4k4u8LCJigavyc53E4l0NN7wgr
         EXdSQC+sDwPKnbqZY4N5FUjYbWOWnD75NjJjvJj0Jc4PsGARBvkBH7ahh1f2/O/qQz5P
         R5rWnt50Qi113giwUCi+EYl6tlQ21c1zZ2aAZURn4SiSKLM7CC5J/SJOWKM5V1w+iB3P
         hOyw==
X-Forwarded-Encrypted: i=1; AJvYcCVhagyuN4oO1wZuY5P7i8S9cT15+UpKijIvC2Q5lCkTx5OLDvvcl0KBazNz9QV0phQKJYEiUoeDNQLLutA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIUOdjH4H/I9SSE1d9UL5uKsn52RXFJcp5STFtAgibDhTZLle
	heWPTntkBvnmcv4Wa3K4oq8ryf+8jh22bccwNwzBnqN+lI/11LJ9g3SEJbjmMGenpGa0T9yrA8b
	tP0uWvlU2Uhx/OIVKI6IkshO9Q8CDfmhoKYMtTWg7KjYCnMO1/oOhgbhdJGHDqGg6NuQtN7TVkA
	P8ryXkGR3aCwAp+qaLsTE4v1tPdO1nziLcGoUxgvx4rg==
X-Gm-Gg: ASbGncvA/bDSkZpfHJ8J/g/6Ulh4xRfndbyjZz9HcptHPLi4DcelrA6f8SnvBYMh6DQ
	BnSg3oYy8hyt+MHKrOJCFzDLFHZatoBbAPBtp41H+EAKDpVSjULz6zExlcXeR/51MbSXelfjfah
	KWysBppsa/rvlRSddLVx41vMJUUDps5EuXI4t4a+436l4Q3JnFF73ht+0IzOkKxpPbRa9P2/JDn
	vL50b7v
X-Received: by 2002:a05:6e02:471c:b0:425:70b9:243c with SMTP id e9e14a558f8ab-425955e5344mr62881315ab.14.1758828783017;
        Thu, 25 Sep 2025 12:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM8FpReApr0CA3Q3i/iHZMzcvXpITYuK0dqKpybMbm53VSYRwCkGk4q3clx06ZAwPs9BfYLZtd0oAmaJMnlD0=
X-Received: by 2002:a05:6e02:471c:b0:425:70b9:243c with SMTP id
 e9e14a558f8ab-425955e5344mr62880955ab.14.1758828782638; Thu, 25 Sep 2025
 12:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com> <20250924-knp-cam-v1-1-b72d6deea054@oss.qualcomm.com>
In-Reply-To: <20250924-knp-cam-v1-1-b72d6deea054@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 21:32:51 +0200
X-Gm-Features: AS18NWBmOViIv5jdU4dSvUosy08SUKDUBUh2nCRDhTzk4mlZzt1vwqBX05hLiQM
Message-ID: <CAFEp6-38buo3WafiiXUEUs8n-=SKgacMD44gGAd1pnEDAsizCQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali compatible
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ao6/yCZV c=1 sm=1 tr=0 ts=68d598f0 cx=c_pps
 a=WjJghted8nQMc6PJgwfwjA==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=i1QE4n8HBj4RHUU_w4AA:9 a=QEXdDO2ut3YA:10
 a=CtjknkDrmJZAHT7xvMyn:22
X-Proofpoint-ORIG-GUID: _8P7n0blY3qpu6u1XkSIWuboiGtGTRNO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX8D5NAl3uRE6W
 nZ/jHjjHPMbTlfWeSuhy0cE9sHUACKnXqXFAqJmTVhOVrw59DIP0uUdg+s8tQPHmJBSOLfhWlYI
 +aUy34ncXsvcXp3fbazJweu9wfn4jLVbAjvMaNZAP2Wk3dryDVBhcyw1nWjK1sIzALcs0YsevcY
 PB5Nz85zIdAn3O69cy6hcq1Ohi4r1407zliwpn5iw7wYCTSyqQ0wUeGRPRdttDrxCOUjKneOuIa
 otLyy0PYlzG0mySLWVj5kZnZzMoki9YA3zT4YNqmVAuhwRJ4vtnvGWvr+ylVXAa6hofnnzl48rF
 /COmBM9IKq+0sdD6Y9bGZYPNTNrfUxp+9fRM1P9RiKX9IERESgzSiceQ3d7oe0Zxw04vVBBi9fB
 u/3dGFZYyemZqRjCXiy/FQmxL8cUlw==
X-Proofpoint-GUID: _8P7n0blY3qpu6u1XkSIWuboiGtGTRNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

On Thu, Sep 25, 2025 at 2:02=E2=80=AFAM Jingyi Wang
<jingyi.wang@oss.qualcomm.com> wrote:
>
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>
> Add Kaanapali compatible consistent with CAMSS CCI interfaces. The list
> of clocks for Kaanapali requires its own compat string and definition.
> This changes the minimum number of `clocks` and `clock-names`.
>
> - const: cam_top_ahb
> - const: cci

The recently introduced qcom,qcm2290-cci has the same definition with
two clocks, ahb, and cci.

