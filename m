Return-Path: <linux-kernel+bounces-855761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE262BE237C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E0E48680A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8C3090D0;
	Thu, 16 Oct 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KBje1WTg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23B2FDC51
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604446; cv=none; b=E1W1qk8yZKYqCErhu5GgqyH2roStRBleRmya6R0nIsUirvhZqZmYpD3yxQIwh0wXMvkDclaE8VBUHfWmUkY4MhxU1dTY+sZMXCkSu6L1+Zgv1WSCqWFZbLo+w8gip4YNP0hX/zLaZCb5TjgqoKBMPDJjYvTlHsAp8ntw57VGFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604446; c=relaxed/simple;
	bh=4Cr3hLvCCrouiag43KD+fwe7CAMY7VqZErV48pL/VOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FB5oh6EI8/eLVBWCYvct9dgarwwUeUVQzs3CZszA94eNkVdbG+5ackTHJmDstQpjO/7MS4Hy75MVlkhW7Fy7f0VH5eLIaMkfgPt3dQ+UgJOIZ2ZLix0dkSv4Es/eFGzL8/kGDJeHtB1+4sf6gFZwJ2Y9mY5ujes+9JLBBt3DYjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KBje1WTg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G8DNsd009138
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DtK2jXcjWQPbKB7OnX2TPJKpHc1AyZMAFUwhHWo+ek4=; b=KBje1WTgyhZ37KRv
	On83yXBfGXbNXOOwqTu69Gof1xwbOtsQVzIMUOaWhqJAH14FsD+2g3ptjOhhggGG
	O/G61XyTeZzgFxtpTCcAZsDtiruQ/XX/V1mFqpBuDjVOc+qhEMI4UhVVM9Zhms0C
	b0qrY+XqgoLLpJg2AIptG//5SEm9TojJTt1A0j+FvvhLqOauzd4xTWw3hsPtgnro
	qvJz4dT4dW6Gb93cOuYGaocMUfHPXsqxk6YQojuMEWy96m6tvyHdK35CQ0MGSD48
	ll11UmuQ7eI0qMtstRSSzPML9uyFnqqfiFF9NT9iOSGZ3SnmEJhb/i8FB+PpquFU
	yM+wPQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c7ghk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:47:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c08308d26so17257056d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604443; x=1761209243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtK2jXcjWQPbKB7OnX2TPJKpHc1AyZMAFUwhHWo+ek4=;
        b=lvwuSvA+45q08juGrb8DYleuDzunnKxV9VFzNcdegPsn1xDxa3fREZRcnySK+LbwDW
         dObvX1KBidxYLKHsdKaaK4Z7SUE9IjNYdjrWt21ZFuQj7kGSz2cAOda0Ea5UHb2t62GG
         ueQ8gelQpUbmg7ZX7i5jw7wsjCv3S9JucR19UC+83ds6ckms7MMZnQHk6gfLHosmemwD
         SaRpLhdefUrrMn45MjLOTK2r5Dgk3todbsy2TkhdXTndToSTwRns9a0eFcd+OoLd6XDR
         bhASVNHxhVAIIttng4WyaSPzQIGQIKwVqjMLZlylU5OL200SPw7dzrP4Oec9zvqMBnBf
         rBqw==
X-Forwarded-Encrypted: i=1; AJvYcCXESj7HHewIW212At4vgP4Xmu4a8WgzKoo1Ob3/b2hEsDm2dXUEaJuP7P+qksKxIDGH8W2+yKG17Ihgo6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbd23bTbYOqUtAdwXGkektannB+LxuemBVUKHpjVKuIkZh7FJq
	+XX7A2tKJA4l2dgGq6wy8ky9QXiHFFOxNDQkqPcZy7TZDtJdonufpkoJLYE7jDoOe5+asyAmggk
	W9FnNVAZBlPYQIBRJhZnBErMSrMAItnUjF8PXZOLHtsDYVKJ3I+LFKEjckHnTK/CLVoZraUfrxc
	LL2jK3R8NB9/bk3YIrOIaZXk/uzbygQIbqq6WNQ53m3w==
X-Gm-Gg: ASbGncsCwLOFwW3hZxKWj/0Pzy16/3pFjKFxzAHm1LtfBG6eokOEamsfEx4ODK+g/Iv
	PjHVHx9H89W4BSofq7BK+/eGKUjjO5qgRYW8qMGD0EmOiQHoWYJd2kKc/z0mETrmFDM1q+KWGBq
	6cxacFzsbgDZF7GOCb96DelNbgSvwFMAjuYeMyhVe5C+kodJTBVBzVXpP24BUNpj0sUb4teZE9H
	N0eZMg4s2iVv1bOCpUiuPEX1gtfcu9Zh0gPVQDXF48+IQ==
X-Received: by 2002:a05:6214:cc7:b0:879:db53:dd2 with SMTP id 6a1803df08f44-87b2107bdc2mr384170116d6.22.1760604442622;
        Thu, 16 Oct 2025 01:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKIDwd0H080pXEFK1kdHvRTAf/OHzMp8h2JpG4d2oyZ6MvcF5FnRmiKkwvO8LcA8cfNV3BhP6f4FxVJw0D0mg=
X-Received: by 2002:a05:6214:cc7:b0:879:db53:dd2 with SMTP id
 6a1803df08f44-87b2107bdc2mr384169876d6.22.1760604442226; Thu, 16 Oct 2025
 01:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com>
 <20250924-knp-cam-v1-2-b72d6deea054@oss.qualcomm.com> <CAFEp6-1o11B9o3HjdJY-xQhDXquOTknXo0JeW=HfpTxXcEaK3g@mail.gmail.com>
 <a7be3a42-bd4f-46dc-b6de-2b0c0320cb0d@oss.qualcomm.com> <d8dfe11f-c55a-4eb2-930a-bfa31670bef0@kernel.org>
In-Reply-To: <d8dfe11f-c55a-4eb2-930a-bfa31670bef0@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 10:47:11 +0200
X-Gm-Features: AS18NWDQrzQKYCHdrrwTe9-7hmb4jjMXDlC9wkwV60oUqGOhB-GFpY7hHhqu3ys
Message-ID: <CAFEp6-1zpobZNLHt1192Ahtn2O7bV+As0P1YvVHrkRsORyH_Aw@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: media: camss: Add qcom,kaanapali-camss binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: C-cB6ZvfXBAyZhnPeXQ1uMh34m-IPa0i
X-Proofpoint-ORIG-GUID: C-cB6ZvfXBAyZhnPeXQ1uMh34m-IPa0i
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68f0b11c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=GOxOaFmcAZOYw-Nqf4IA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX87FkgVnOihQU
 jMkT/VbkUlmyKg0Aj0YTDUCUqCRdNLdi8zZLxLXEJvKs6Oiq51Dewvf4MiPfu5LegykmTxoin90
 mIQHOwEzYuKv5dzWWy6KoZixkijyHLVD71KpNkBIN3OLFyXK7RWgmG05Ezyx1yNSBEPkdijjzxF
 afOK/wgLozFPf5fosSz1yfSz+z1ofssxkPcqHq4l6pph7UiuXDUMSaL2bn0iOJu6S+lwlYk0fGF
 mE56yDtuUaqEcl7dJZAtNbd7hbR1OBWQl3exgJTBC7UDX31T5HzP+DFLt7WFAgrnf19x5DvA4Tm
 bfO908jKDgNFfhzRJ5xbdfJN2au9WNYgml2R8CJmDtoc85FSBhN8Ghi73tVlGobCMFYKtvUG9HQ
 eCDlaxAAvUwbADAmSG/gkhX078NLsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On Thu, Oct 16, 2025 at 7:52=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 15/10/2025 05:21, Hangxiang Ma wrote:
> >>> +      - const: csiphy4
> >>> +      - const: csiphy5
> >>> +      - const: vfe0
> >>> +      - const: vfe1
> >>> +      - const: vfe2
> >>> +      - const: vfe_lite0
> >>> +      - const: vfe_lite1
> >> Wouldn't it make sense to simplify this and have different camss nodes
> >> for the 'main' and 'lite' paths?
> >>
> >> [...]
> > No such plan till now. Other series may take this into consideration.
>
> We don't care much about your plan. You are expected to send correct
> hardware description.

To be fair, other platforms like sc8280xp-camss already have the
all-in big camss node.
Point is that if Lite and Main blocks are distinct enough we could
have two simpler nodes.
Would it make things any better from a dts and camss perspective?

 camss: isp@9253000 {
    compatible =3D "qcom,kaanapali-camss";
    [...]
}

camss-lite:ips@9273000 {
   compatible =3D "qcom,kaanapali-lite-camss";
    [...]
}

That approach would create two distinct CAMSS instances and separate
media pipelines.
However, it may not work with the current implementation, as the CSI
PHYs would need to be shared between them.

I guess this should be part of the broader discussion around
splitting/busifying CAMSS.

Regards,
Loic

