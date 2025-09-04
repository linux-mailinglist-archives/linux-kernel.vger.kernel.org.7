Return-Path: <linux-kernel+bounces-799774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4EDB4301B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E0D3B5871
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709DB1FE44B;
	Thu,  4 Sep 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o4ZCeWXk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8196313D891
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954633; cv=none; b=BUr3XOhPKw+aVgAT1CmN2of2OKexcA+52/GmUf9r9DCmI8XORldoIiRLoTT9eVGQyxhxbcffudOB3Q85fox/9/SOtuh64HIoYGMYbprW/L9Wv5fULE1aO7EPBHWEMKCkIb474btctRy5+Y3KKKDMaNbB1OfsuPaqrRZmnZSGfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954633; c=relaxed/simple;
	bh=zB6lARCZWAp3QWoDTLpKdGRVccF0RVopNO5E0t/xn78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBT3KtXJlVSal8ZIGMxyQww/Zma1NTvMslEJ4OUZOFR9ZJsGDg6RLHl1+m3OlW4+G28o9WD9vqJS2X5HM9V9zk5y3/kwgDRwTugW7z1XGFfrm1GNrM2ZJdsy6g/M4bW1dJIefTFB6vTmWIXPRSAydurCE6C2gjP69B8wP2USezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o4ZCeWXk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841QogP017515
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 02:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bzEaXoQF+ag+J0SJOs2QiLzRINVuYknBIfuTABhdTUs=; b=o4ZCeWXk7vL3saQo
	rCJrW2+Bd1AfaXntGnvhFqNZV8rNGURkPnyhZ5Afq/+qqbbo1ptziuuxo97Oxr0C
	MKu/WVF8gIdHdqhV6QM7P0fjoYluHGAEfgtV7WbzunVIoImS7eVhB1KuCs0m2R8T
	GbWmdbwbk3hMZjbxq/GcxGXKxr8sTJJE0MxeRYi+1/Dn0sbxu8aAnem7qjuLVbXv
	1I4gehKLWlhJ5AtF9agegWFmay9wknyF6IiqfqYXc1yVByzeKxVN5EQvLhspHc6v
	wAJoG32m5TENZ0O19bjTTVearrKvO0lEJtnGySLhaKRY8b/jl1PwvBWTRpx+bQnL
	5E2pJA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj2fus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:57:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso480873a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954631; x=1757559431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzEaXoQF+ag+J0SJOs2QiLzRINVuYknBIfuTABhdTUs=;
        b=V7BBdD8zgcYAUmYUjbcl/0Il1ZCGS0fDfuultjuqBFewBjkceI6oSUV5kP5j0JP5Nb
         BjvLLS6sx7AQYdKusp75FM6Mda+wDcaoVOPCy+uDdMNdK2W/uO5+VWuZw4vZDb3i+ZcO
         oBHrhFXHMXmL6vh3q0d/mfWYvtmPxbPiV/qJiKIEvtVLHBcWN9DTLFlfnidyI7TnnKCR
         cE0AQ4A1QncQkH2PvK4/lp/ULeRQ0TaiQkvnWHGmZjMcgOJLm0QQR2PN+cYKzPvKQlUn
         RG7bBJXUxu4W/jEDUdw4goMRXM4n30xLNhvmr8RFq+oNxIvCIB3jBqaJ3GMBGjfxShiz
         Wnag==
X-Forwarded-Encrypted: i=1; AJvYcCU/osVZnuzKLWvaekWW0vdJgrIBL/PcJhZ/Je/INMsZbWl6+D1nn7sK++86BNNG4sc3y9p3pgUFY6VmqS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVbEkbwZUYJJFNWCrhfo16RRwbvLjL5f0jDvxb6/HqvNseBVv5
	RNh2uoVVb+pwE/BnkB5Ac6VHz53iSN4IpFLcXNZneQeMEPqUVnfzsTp8nWHs1gdO+fESKk6zNiK
	6X0fBZoNeTXI8fbCrjqXOBhraFxvNVq07zqrVxoWfzIEDC2sbvJnkB1Za/FaTtOu5Hy+kelqJo5
	Ab+EAbOzhGWuS5hNMjqsOH5nvmfti8ZEu+ZRC5LYrPAg==
X-Gm-Gg: ASbGncu4IVC26xoflg8/adOvLrdIbp46a/pRbXspkb4hsCNFqxkNVFwf6nNDtbiQnrr
	fSCwTYI48/csZr9RX+hl5a8CPULeko/ds6hK5wLsx+ewz/gC/ysMlLMcXuD/VSWGagh+r8Ld5lB
	glagV1Uw0WXoVe5UiV+4rM/oLKXKLC4TUZWpZP6twKuj4hKStmD2JL
X-Received: by 2002:a17:90b:518c:b0:329:e703:d00b with SMTP id 98e67ed59e1d1-329e703d645mr10321018a91.19.1756954629900;
        Wed, 03 Sep 2025 19:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOCPdzFNzraiWHbGuHEoBM1QvtTU0Nb0FFJzX0uW97BnqhL/gBuv33SiRgGl4vDEi8Sr3AnsPHLBpMRXmEtAg=
X-Received: by 2002:a17:90b:518c:b0:329:e703:d00b with SMTP id
 98e67ed59e1d1-329e703d645mr10320975a91.19.1756954629213; Wed, 03 Sep 2025
 19:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903123825.1721443-1-syyang@lontium.com> <20250903123825.1721443-2-syyang@lontium.com>
 <lcyori44rm5p35wykk2rb54zbrrpft5c7uibi376jihemkb67w@px3nj72a5hx4> <CAFQXuNYKcGHyWLD5hjj24CrbaXzkaKsLU4R2vmhYaryQArA_yQ@mail.gmail.com>
In-Reply-To: <CAFQXuNYKcGHyWLD5hjj24CrbaXzkaKsLU4R2vmhYaryQArA_yQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 05:56:57 +0300
X-Gm-Features: Ac12FXwqpLK0wU-JoT7FAo_2ssmdmZOCvHkhkCqIZn8qnoojkUv60OwC5s_f_Yg
Message-ID: <CAO9ioeVUtmVjdxyykTXysQwdUx8iKLqrsU=yehR-pPtvk_QEFw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] This patch adds a new device tree binding documentation.
To: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>, devicetree@vger.kernel.org,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXz1FeQEL9CjO7
 c/DoxDfp9cDG9DQ46ULyopBS4JAcXlE4e3WUwgmCocNxon19dOu7B2Ech+Nzgs8n5TE1K6RPKWh
 UkPvpivODhxXPGdfcszjPlu2/zZjXzgD/r6s8UHmA1htVcKIF3mrlfBG9r90xwOppG5vat5zdKf
 rtJ7Es/MRiK1mLjavDFVdu543rU9QaNMOqTsGTONr2i3xt3rSRiJhw4VzwDzLAx/u0UDSX95UlK
 zdMS2UhBPF+lzsw64v7d5AmMRKNEbkmzka0hodZLY/1Sk854q2iI+xuQOg0G6P73dKrJw5CtBx2
 nT/xm/F7QGoaX3vXjNOsrdA1z2ctuapRKfyqYwKYv/av7OhxxwUaLTTwi0ujFDLtEGVuYUobtZH
 fLMHnVUm
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b90007 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8
 a=yqK20mq1EwIQVBnv59QA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: l-_ryBCPd7700HvRrOt4IFcu0Z17WFdq
X-Proofpoint-ORIG-GUID: l-_ryBCPd7700HvRrOt4IFcu0Z17WFdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On Thu, 4 Sept 2025 at 05:39, =E6=9D=A8=E5=AD=99=E8=BF=90 <yangsunyun1993@g=
mail.com> wrote:
>
> thanks Dmitry baryshkov:
>
> 1. Please fix your Git setup and use your full name in SoB tag and author=
 metadata.
>      ->  i will fix.
>
> 2. +maintainers:
>      +  - Rob Herring <robh@kernel.org>
>          Are you sure?
>
>      -> I'm not sure. I need to do some research.
>
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2025=E5=B9=
=B49=E6=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B 10:22=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed, Sep 03, 2025 at 05:38:24AM -0700, syyang wrote:
>> > - New device tree binding documentation at
>> >   Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yam=
l
>> >
>> > Signed-off-by: syyang <syyang@lontium.com>

Please:
- Don't use HTML email
- Don't reply off-list
- Don't top-post

>>
>> Please fix your Git setup and use your full name in SoB tag and author
>> metadata.



--=20
With best wishes
Dmitry

