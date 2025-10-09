Return-Path: <linux-kernel+bounces-847508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69293BCB0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909363A13FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D1BA3F;
	Thu,  9 Oct 2025 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Me9SBi4a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1A2848B3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760048118; cv=none; b=TQIeYdGAI/dkThrTexDHkKmJZ4CZhuvhFt83RDDUDHdsRDsVb+HkbokQzuzgRhH9HUiK9LLsEXUMmEFIxHT1DdFALcHUeml0OdK1Ycg24N6775HbhLvFf5Kli5GH3Bv5i1AwMpwgRHHiGGn4uQWPasSDNo0POvENDBuvvjjoHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760048118; c=relaxed/simple;
	bh=CAmMNZVsOAfUSUH8/sxLIbfrEtbnXhByFsSqcMUoCB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRIOJg9bN4TBlsT7MdYVdY1IQZ1m0c2dV0cl2YhWdMeJWI3rdKuuPQr7urTt1a/nmstdlg7wpxn00jBkdf5hjnEve83t5RjtJI3l5IfEHVVFcAq0o8WZl9O8925kA8s8adYo0s/3nA0H1KRPYQgENi63rjLrXwvO9Zq45FKp3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Me9SBi4a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599EfrxJ005152
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 22:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TEGE7MtPOLU29CE3rOPx6mUdX95cKZ/brE87YcfnXLs=; b=Me9SBi4aPxZd+E8b
	/EaSaVJLYTbk2+qnY0pi2S2jZz5bfJ1PXnwZRD34/zmFDkxh4skpHXKgZJLHWAuD
	r7zG9gAP1mvOlR/swCpkQ3J6JqtQLnDLSp7ngtd4HWOeQ6gszDplbjokRsIEYxOg
	sGyGlyERO969cHaq0Yd56xe9Ixubs4OqZNl8jFufVe7bgDQr/I+VE4E1RVKHov7A
	fzAEoyTJ5YLDlqmYkxq/7YYhAFQnS1u/EVjuhJbNjlUci+D0HzJY1UwP9+ivrAsj
	PCv0KrZD0u0+nhq0t6UHKOt7oU9CdwTQYJKB5wgGucWaKU0kq3kkVrPASX+tVYPo
	34xhcQ==
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u4dsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 22:15:15 +0000 (GMT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-425788b03a0so81003945ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760048114; x=1760652914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEGE7MtPOLU29CE3rOPx6mUdX95cKZ/brE87YcfnXLs=;
        b=WJqPngEdEik//3d27Le+b/x7fEpGJSubCiW8JFT0cXbuyk+f0x+D55eK/pddgNTFFO
         cjugOqY8L4RZew8EIz2KR77h3c587o2SS1ttfCRijwUSfBtUpDE1Lo6myjE0+9oE2Axk
         a8Lihv3YRLdTD45kLOS+UZFtCtH81S4O9QfxTz37mWkex6LLOsahf8pFnOx80vw/KTje
         4bnZkNKxIIsQKQsZBAPFsvaTs7Mvrq9ptDxPgWAC8UzA7eHy2PzKPGSwzQYtOCZoGbZ2
         zkGGM6zFuU3IEvVHnXhK5ljmMhQ26T1Tos9Essjxwm3iSBDCYjIgVAfHXSltCem93IrE
         qdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjGh8vPu/aKjXO+sE+bCYeybAx/4NP3NhZsxoL2r+DkGvUNNxOKoayj5bb0ZOnRdAgPPvBqITKylF9TuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqjQwmXJaqoRvGsKZ40fcYML9SP/x7iKzQVah5GYchPd4+UI8
	1/J9e6mmToqX7zONapY5ED6hXHKPHESIi9X+ugiaRR6ZmBXP7qHTn/+wQlps8gNSrni1j9exKd0
	WYz/XZTn6yx9bDR3pUGf5yQXewJ0Pz6KAnnmzLHcmmvrkI4Wqq5wC1ExNVfgTc9Tgdnp3GpEXYp
	ee5cY44y35pFYKaUopeGuF4vhGEoboZQ0Ms0D3NH/jpDm8ZT2veg==
X-Gm-Gg: ASbGnctBYjPZgDGQ7G9ejGm4UKVbk0qFYjyNkBUBqdXfd3SyUUz6KExT2m/xS0JuVmI
	zj15FyGYmhyIhGGAfAD3f2tEjuQmRp8hfcfJIxIqv8ABQ4opbZQ+lctfnnSIf0MpTl5HhK2sUk0
	tos2PYCvHi+4XsXYOT7war/XkXYTC/AHj77f1KEK9OkBGuAVuOv/JJmGEfH1J6
X-Received: by 2002:a05:6e02:2163:b0:42d:8c22:5e05 with SMTP id e9e14a558f8ab-42f873fb683mr85535235ab.28.1760048114162;
        Thu, 09 Oct 2025 15:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVQtbuCJQssPrdKX46PJ7DAAFYeOxNJAD2Relxs45ETN5o45xTycdQbeCutyxrSpEebfYJ3SP/lkgeMI4KzK4=
X-Received: by 2002:a05:6e02:2163:b0:42d:8c22:5e05 with SMTP id
 e9e14a558f8ab-42f873fb683mr85534945ab.28.1760048113805; Thu, 09 Oct 2025
 15:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619010506.296494-1-linux@treblig.org> <CAFEp6-3U2rQEUtntb0cdJeykURocEZQdeVHXFbXXogZV=wxGWg@mail.gmail.com>
 <aOfT806hw7l2BeJu@gallifrey>
In-Reply-To: <aOfT806hw7l2BeJu@gallifrey>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 00:15:02 +0200
X-Gm-Features: AS18NWCYtpbKdr-iu-mqSQHX5SYJEqWEWJIC9tCth5IYFSEAlI4kq35y2VXAUh4
Message-ID: <CAFEp6-3tq4FkiBLO20mk2HU1QkbyVMbyutu11v7b8PSyps2Qjw@mail.gmail.com>
Subject: Re: [PATCH] wifi: wcn36xx: Remove unused wcn36xx_smd_update_scan_params
To: Jeff Johnson <jjohnson@kernel.org>
Cc: wcn36xx@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e833f3 cx=c_pps
 a=knIvlqb+BQeIC/0qDTJ88A==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=3WJfbomfAAAA:8 a=EUspDBNiAAAA:8 a=sBOc30HxzSulqMI3qHwA:9 a=QEXdDO2ut3YA:10
 a=8vIIu0IPYQVSORyX1RVL:22 a=1cNuO-ABBywtgFSQhe9S:22 a=_Cyqi_Il7Mi3aeVNCMp4:22
X-Proofpoint-GUID: OC_BUPqLdr4ovAk6jMcT8ynkITXyfzj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX12tDp6d+YgPx
 yoh7imzQHlGFF4gD3zotkn14PXK4AJHqFte3FAvjmK9zoYaRjJ7/JyJrO2cK97RN0/h13c1RtzE
 5r0v8TVwCC6BWsi2iLWqfBuCT4QmhMG8HmV3ltkcqCPYxk1ko2wbFE6+mAjIp4chOK6kzuWMpKk
 SV4mFratbfYlow3hEuSqlOJJ/f41lLCAggbhd7EGnxtxJ1toAdfOu7aehk6sadMok7RdAkZRVV8
 AbCU1lfE/NDzD9EmvSlrvR9amrx0SFHnwI3VAr1uXllh1fmgQ1+S//8Ebn5gBOvOaQtGdnwZmdu
 sZ7tXhePzTbAEmyTu90I9cN/799kVLYZeGOfB6IERMmULQ9jQ8yF2lWz/WWvBTC1bp87acxTj4k
 hABjXFMc+uZoGkBnlkvJBM7cfSltTw==
X-Proofpoint-ORIG-GUID: OC_BUPqLdr4ovAk6jMcT8ynkITXyfzj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_08,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Hi Jeff,

On Thu, Oct 9, 2025 at 5:25=E2=80=AFPM Dr. David Alan Gilbert <linux@trebli=
g.org> wrote:
>
> * Loic Poulain (loic.poulain@oss.qualcomm.com) wrote:
> > On Thu, Jun 19, 2025 at 3:05=E2=80=AFAM <linux@treblig.org> wrote:
> > >
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > wcn36xx_smd_update_scan_params() last use was removed in 2020 by
> > > commit 5973a2947430 ("wcn36xx: Fix software-driven scan")
> > >
> > > Remove it.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >
> > Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
> Hi Loic,
>   Is this getting into a pull somewhere?

Can it be picked for ath10-next?

Regards,
Loic

