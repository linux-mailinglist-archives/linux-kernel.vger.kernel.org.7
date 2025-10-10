Return-Path: <linux-kernel+bounces-848685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0B0BCE564
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C451899811
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477AE2FDC5F;
	Fri, 10 Oct 2025 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGkzwZFD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D96253944
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760123632; cv=none; b=jyP4agI3bOVFAdbXEqLEaoFG2TdLOPpK1CsLrRYhjdKc/oKedCQ4ALezN4GWd/Tt1BuiqJbGEs55rDIPhEPcxNQnibtD+Tuxe2cRebSgUP+pz3ALdiZDvrb5B+70NPvlly0RBDCiGYzOBot7FpNYCsmTHmVd3EJGMTBnXdW9pYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760123632; c=relaxed/simple;
	bh=CfT5BszHKSJvA2ZanE+pOuKPmpTNK/C9X3g5lQ4MMsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBOSLHT54lKudAW75LNj6/pISL6smapxuStiKx2ON2KRkyxQp9JSLXerRifHvmTSvtysxWO9S6OvG5iRWo+j0LVKah5WBIPCUYm0UazqCKthgWkBcVfIeP+drq/9TpOUA6gIYmlJcmyirZp3A+xRc5Gp2n+2gXQa7dUUpj54pZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGkzwZFD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFa4Rc011725
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yi+RYwEK35r3Ck4feOqrhe5jXn6qciEEBJantOUqzjA=; b=ZGkzwZFD/OHtWpCn
	QpUYotgpD6AbszbHsJW6AewaVRGWhNmi+ite0NCwWb7A6sIpNjSfjm1ttpwUIcU7
	jMtM8nvdF/m3IA3No8/fAeNaR4u3eEXMk9o9SG56jf5DUW4FbTu7ybN5RpSNHQbv
	NCSYi3kPfhLhuUozLIknD9nD/SxsqqrlhUpOV1pTmat8YGNulQ1iXas+UZqAFjdZ
	VHHv+ohM4+D9HwuqVBrUw/EE9ytX56T5oS+J81bbzYBAqB9EuotBFZ2lwaEQdW96
	j1L4czXeDK32uoD8uHCvMXLCiE+H4h6kP5NvtU4upjXMZxizH2xAla4zmPyiLF/Z
	bG754A==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49q4x1gk48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:13:49 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f86e96381so77120795ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760123628; x=1760728428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi+RYwEK35r3Ck4feOqrhe5jXn6qciEEBJantOUqzjA=;
        b=eSdD/BgrwwA/vL42OLtPGQ7uQsbB1AMtXlS9zAHcNHKfFCbHdJ47Ck5MkzLWKrpJ9+
         3leBW4ulq1d78WLaF6uc9rmx6r/YTXO+ypntwVnFZk7IdZAaqkMdzZbvJo76N9XPKxjR
         845EC4igqm8CmczKAbwh4RbtKaWvCc8Eyn5NRVruLbgD2lgu2pK2hrS5Fe4A03ATgfb+
         o9I6x4FqeDARz2E90gz4kW2lRn5nrkoizB+y5XjXcGqMZCsV6PIp01bBOHJZY25dUTgx
         QygB668v/au3pAwfYZPD08boFpl2wqPPAIN7iXKHzZtp/RhuTQo1z7jYm85URZbh0OK7
         KsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBYi5cdAubxIPyJXxNWchbZTNv5it08sHAdy5X3WCY/RXlGLS9H1HWU1sPx0TKBN7Y0kBUiFYZUcpa3zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJFNk+dEKVoPnkq9KenlDfFs8oF1lGzrx/ovMsSvc2iGbx3iL
	XZqaQ5wFt31N8xk/K+7vJ0fJblFnV07kVq42ASN2q/Gg08jVclSXUCzHMvTd+ansInV4BEYgh1L
	i0R9eCqmYDu/Iuw3ZFNKotLfNn6EIjiMYjnwBxh4aMBqs0458Mi2z6w2eWBlxRKMhUXo0qYnDuO
	/+nzhlQx1vpYB5KbvM80YsASFpAVYn59hdaAAIQf/0kg==
X-Gm-Gg: ASbGncvWqWZJsBSn+QGDQU4kWMLYn0XSen6hNn+C1ibsNmQcRUToB9qI5b45gsq4ORQ
	+qgFfWs8+2EDCE7S+JPLBJ0x3WDLNp5FeFCjrz8bWIkKeL7kpW7kOcaXNBi0mtIGdxv5tQyN5E2
	2wuGTkvX01Tt7rHbhfgA2I99/FAMFcSlAHq0KnISzGyJtFTGD21FokIA==
X-Received: by 2002:a05:6602:29d3:b0:917:f4a5:1068 with SMTP id ca18e2360f4ac-93bd188e14emr1627465639f.11.1760123628462;
        Fri, 10 Oct 2025 12:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5QZth4UcQuzQ8TFlXB2/caRVQFYMIvC/4urzbC5T9cXZKl1xHTsHxF0r5qhXeC8vwnSEhj5HGFBKHh31x5pQ=
X-Received: by 2002:a05:6602:29d3:b0:917:f4a5:1068 with SMTP id
 ca18e2360f4ac-93bd188e14emr1627454539f.11.1760123627813; Fri, 10 Oct 2025
 12:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619010506.296494-1-linux@treblig.org> <CAFEp6-3U2rQEUtntb0cdJeykURocEZQdeVHXFbXXogZV=wxGWg@mail.gmail.com>
 <aOfT806hw7l2BeJu@gallifrey> <CAFEp6-3tq4FkiBLO20mk2HU1QkbyVMbyutu11v7b8PSyps2Qjw@mail.gmail.com>
 <83b4ff7d-2443-4ba9-8103-77c8dde518f2@oss.qualcomm.com> <aOhXV7IdoI0aBT1j@gallifrey>
In-Reply-To: <aOhXV7IdoI0aBT1j@gallifrey>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 21:13:35 +0200
X-Gm-Features: AS18NWA1FCnZftZ7mLzx2vwPrReT2r3lCGEFybSRtdHW-xTJ73IXHkO9Cd5WniY
Message-ID: <CAFEp6-085_uTZtjpku5ffq9+81OpPcFBJb3jXzeWbzKmQwFy9Q@mail.gmail.com>
Subject: Re: [PATCH] wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, wcn36xx@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Vbju40P8HCWaNHZMC1CcmR2g2RRuSx3e
X-Authority-Analysis: v=2.4 cv=N4gk1m9B c=1 sm=1 tr=0 ts=68e95aed cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=3WJfbomfAAAA:8 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
 a=G5lWb3F_BZYHzvVYTGAA:9 a=QEXdDO2ut3YA:10 a=Ti5FldxQo0BAkOmdeC3H:22
 a=1cNuO-ABBywtgFSQhe9S:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDA5MCBTYWx0ZWRfX/J6buSETy/e8
 Q/qqvIAyhAi+gV0aWjIZ4UPcghqK4zRncDCHsXapyD89SFxTCeqak0aUhiSgJ83HeNxPBc/Ws8D
 hCreG//wSlhx0aHOUqdsUG2/Kt/yyr1eC/gaOCgvDw+CdQx2qocD62LikUnpi7GuClGHwQaSBxb
 zw/FZ08HMGrLYm0VPtTHiNrbLlBosmBi3CtjK7Vq7xeu+prkQq85p5rM957uaGK/SrupA4bVSAV
 lFx+rq0+RyqBozWHAjR8wAVyUZ6tp7Vv12CbSOQc65GkrwnsKE4Li41EysjSjdxH9qNtuI2DtPu
 28ky4iKW2k5o3Z69Qr/jZieprCpcOuWcHUNCwa1D2rRaRG1gFKHo+Y9VpGjOpfbspqZtfsquX08
 jJ4PEd5wUk2om9loBPS/yo9EdLvSpw==
X-Proofpoint-ORIG-GUID: Vbju40P8HCWaNHZMC1CcmR2g2RRuSx3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100090

Hi Dave,

On Fri, Oct 10, 2025 at 2:46=E2=80=AFAM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> * Jeff Johnson (jeff.johnson@oss.qualcomm.com) wrote:
> > On 10/9/2025 3:15 PM, Loic Poulain wrote:
> > > Hi Jeff,
> > >
> > > On Thu, Oct 9, 2025 at 5:25=E2=80=AFPM Dr. David Alan Gilbert <linux@=
treblig.org> wrote:
> > >>
> > >> * Loic Poulain (loic.poulain@oss.qualcomm.com) wrote:
> > >>> On Thu, Jun 19, 2025 at 3:05=E2=80=AFAM <linux@treblig.org> wrote:
> > >>>>
> > >>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >>>>
> > >>>> wcn36xx_smd_update_scan_params() last use was removed in 2020 by
> > >>>> commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
> > >>>>
> > >>>> Remove it.
> > >>>>
> > >>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > >>>
> > >>> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > >>
> > >> Hi Loic,
> > >>   Is this getting into a pull somewhere?
> > >
> > > Can it be picked for ath10-next?
> >
> > This was not on my radar since it wasn't sent to linux-wireless and hen=
ce
> > isn't tracked in patchwork. I just looked at it and it seems the follow=
ing are
> > now also unused and could be removed:
> > struct wcn36xx_hal_update_scan_params_resp
> > struct wcn36xx_hal_update_scan_params_req_ex
>
> Oh, I'm happy to cook a v2 for that if Loic agrees they should go
> (I know some drivers like to keep struct definitions if they document the=
 hardware)

The software based scanning never worked very well, so I'm not even
sure the related structs are correct or complete, so it's ok to remove
in your v2.

> > Let me know if you want me to take this as-is or wait for a v2. If you =
send a
> > v2 please also include linux-wireless so that it is tracked by patchwor=
k.
>
> Sure.
>
> Note that linux-wireless isn't included in get_maintainer output for this=
:
>
> $ scripts/get_maintainer.pl -f drivers/net/wireless/ath/wcn36xx/smd.c
> Loic Poulain <loic.poulain@oss.qualcomm.com> (maintainer:QUALCOMM WCN36XX=
 WIRELESS DRIVER)
> wcn36xx@lists.infradead.org (open list:QUALCOMM WCN36XX WIRELESS DRIVER)
> linux-kernel@vger.kernel.org (open list)
> QUALCOMM WCN36XX WIRELESS DRIVER status: Supported

Indeed, would you mind submitting a fix for the MAINTAINERS file?

Regards,
Loic

