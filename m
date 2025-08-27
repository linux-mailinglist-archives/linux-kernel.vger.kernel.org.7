Return-Path: <linux-kernel+bounces-788386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B8B383A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE571B67D51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BE0352061;
	Wed, 27 Aug 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUmw3tX9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78911D6188
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301245; cv=none; b=pbe7aykpUfrieIbiZhU+8g+8WWA4PL3ZdvSEYjhzjCeweilQR6SoeSBcb9KA3ce12dzk8vMxeJqta5TLyaXLoatKoJspFznJWH/aJ+SA6JjZJN0rc0PUGO2TzINwHwXw65aLWnrlILnHctruy2THKTy41ODbB8B+nhcuZx9XQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301245; c=relaxed/simple;
	bh=3lKOrjefgxkmUKwLi1C9rB33yAcCifL0LQZhPHbPOOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki/Nu4FfDJu2rirMdpjHhFvFGkLFxn1PEvysYi0X11ECdiZhCVkxAOpip0/ckQQOzs+3oRI14uTZkcaR9qWhszRMHQMr3xrBvJtFbXZWN88ID2sEibtSTKoWualeawpJGvO1hajG1brvpHr+7kfjWyePTOJXlhUajpzO8kEW0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aUmw3tX9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kB0B003091
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SJVYYjYdxfF4p3sCNzv7moDWVy1fEvP4+O85me4AGX8=; b=aUmw3tX98ouaWrNP
	c7cRcUvLJ/uaKbTmFly+SR6LyDANGw9appliTsxXUvGCHlOQLAmRjGciqGnHrfIU
	/AsQZ7IOZRFww/JQQtS26oTU4t9ZYR/tYgOBGVCeGsNPYDU2JMWsmgM+jnEaMAl/
	4v9bKwvSSSzFEbsoGH6oi9OAEhgB1Rxzw8sOUI2VRQYVBY+iTGeFqfWJRJ0r53TA
	fiZvhbhhg7JB4UENGWF5SVB/7UvNUPW44T7+GSpy7QX4RlSJIaf70FH9owwjicGr
	CvVJLLLpFt2jXzbOsEbkfNY/icvceTtYqWgzxaLKwIRw/LpYfeF8VXTOYikXmu9b
	ZBMjOQ==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x8cttn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:27:23 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e6649d783bso156931985ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301242; x=1756906042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJVYYjYdxfF4p3sCNzv7moDWVy1fEvP4+O85me4AGX8=;
        b=TSHeq9Z0LysF7RTpWpPKcDyTtRGucNRYxduTgjW7TfSVSpcd4RZyTahNCdKf4Ba5Am
         IAj/Udgk0CAUNX5gvlS598EiDsfECUPGrvFkIUmHSoWw06oAgOBKG70/O9S3RndZSewW
         M2gV2SLV7mopCrNEQIyiCn0jkkvOvzG/XDPnSq458vTpO5PEeRzW8QtnKc9BANB46DYg
         QD9MqHsez9jubHRAIBj/sG85RD7/aMAnVq88nm20k67z9GsjuQCfaZiYFyRcgQ3U3Cd1
         unCVmsdfsKINmI7I2AFLLPxRFLiXS8NSuimLr5M1ew97ZydAsXyZzTNXrxq5CQKHmh6F
         IqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyGAjE2Ui35+23UuWa0gfagWf4avX6T5ahrdwzfD5mzgoJSxXDRKpkGHbC20/sLokRCKDLgIfc/xIGoH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQmyISva5je3cTDb4uiF+FPgv6nj0kSbm+DNO4MHPpTMWqwTX
	oFozfgJbbVU5lvgBtPaREsJVHMZeCwXeu7aSNHqh2WV5ugh2WyI1h/sLOs9iUjF9HNTAUR4fqd5
	9Y088Dm6IozjYDKO5vu7eg48rgPsiApYvS7PKrbJvlNhsdFXycoKIa37zZNEYxgvUEGGttDHZ4a
	5DgeITI7RcBhEcWiV5foTpAetOjcoavlQCldn3tTTPnA==
X-Gm-Gg: ASbGnctD+tffYNls1WYRX6M6lFjIr2vZ8aI0lnJUceqfE5+4WT6VDuMw2x4z0rWXHKa
	Q7UTxrjhpymraRYk1B/QSl+f/mWEzoy97Q7w/xXRLrofWlSs6o9hCQRL+RkGfcA8SAeOdBAo2Gz
	GIYOHLVjvyP9MXyWfjAM74kg==
X-Received: by 2002:a92:c24c:0:b0:3ee:931d:8272 with SMTP id e9e14a558f8ab-3ee931d85d9mr86187735ab.27.1756301242053;
        Wed, 27 Aug 2025 06:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXGPWw2hCMcJeQwiV5IoCHGM6jK6hrlxrHOgdWVoa9qCoqe01JmjR/TC3MdI8BwFgEeEyrV49mBsxLH9bfitc=
X-Received: by 2002:a92:c24c:0:b0:3ee:931d:8272 with SMTP id
 e9e14a558f8ab-3ee931d85d9mr86187435ab.27.1756301241703; Wed, 27 Aug 2025
 06:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826135021.510767-1-rongqianfeng@vivo.com>
In-Reply-To: <20250826135021.510767-1-rongqianfeng@vivo.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 15:27:09 +0200
X-Gm-Features: Ac12FXzb8MeF3YNH5KT8aiAXaNlyGCJ0i6W5AAkJ9v519Ak-1GpAJyjOi3X6R4k
Message-ID: <CAFEp6-0J8e1rQbAwEE-E=LzhLyV5x10bhQE6EDwSvL=gz5S9JA@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: iosm: use int type to store negative error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 3iiP1TuepSW-Bqxrs9clXU4belc0UbxP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX3P+H7yt3hOb0
 rJ1aRDUPpn5n4NQvIIUSUBvU3g4y2mKuFRgd2KSTfSBdA4Vo54RvUtTrf1ee/YwlN3cfzXlCJ9Q
 GO7CSZe0WWUWXjTbGwozrkzFEqjZXdyNTTN5VL0ktnl+ta/wjj7pjbPM59BB/UoZvZxeDgjoF5f
 ifWsS08osOGHnMMtm1/cXIu/2YfOPqMdzayA9za3sTI8MGWmzqpWsBqINsZFF76+u8PbtM6U1K/
 0mmaS0cmGYKznQNxxqk8xKWaMO+ifbyKjWghbpZCcCqS45L267CQU3lELOpk6AKCPDeVtLT3Iik
 JGAalRExMwb1caWQLqAvzSRImfoZvHJjMIg2lGgxeHDbBnDtswr1kmauU7U9VU6E6oFJPCNXEgN
 gMrQi3Tn
X-Proofpoint-GUID: 3iiP1TuepSW-Bqxrs9clXU4belc0UbxP
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68af07bb cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8 a=_vuNJv8LpkyJlonoWToA:9 a=QEXdDO2ut3YA:10
 a=Ti5FldxQo0BAkOmdeC3H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

On Tue, Aug 26, 2025 at 3:50=E2=80=AFPM Qianfeng Rong <rongqianfeng@vivo.co=
m> wrote:
>
> The 'ret' variable in ipc_pcie_resources_request() either stores '-EBUSY'
> directly or holds returns from pci_request_regions() and ipc_acquire_irq(=
).
> Storing negative error codes in u32 causes no runtime issues but is
> stylistically inconsistent and very ugly.  Change 'ret' from u32 to int
> type - this has no runtime impact.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

>  drivers/net/wwan/iosm/iosm_ipc_pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/ios=
m/iosm_ipc_pcie.c
> index a066977af0be..08ff0d6ccfab 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -69,7 +69,7 @@ static int ipc_pcie_resources_request(struct iosm_pcie =
*ipc_pcie)
>  {
>         struct pci_dev *pci =3D ipc_pcie->pci;
>         u32 cap =3D 0;
> -       u32 ret;
> +       int ret;
>
>         /* Reserved PCI I/O and memory resources.
>          * Mark all PCI regions associated with PCI device pci as
> --
> 2.34.1
>

