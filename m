Return-Path: <linux-kernel+bounces-776711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C852B2D0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB981BC7CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F013A86C;
	Wed, 20 Aug 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AM9fsCHn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C663C17
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650368; cv=none; b=GcmMtpfRL0rhN/Em6yqIjiKphgkAkkuBCxpZyeXcq1DQfMrfUr7A6oc2cm9bFcWC2mZLgEWoxng+6WrDHp/7nVerWTmI9/IkjqvyjeZEHgMBlm7eGvpx2snS0sPFaQCl8wNcpk4AP8on3OHUavgc6SkYClFMLza/yIXjSEW0Ohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650368; c=relaxed/simple;
	bh=4a1JjHkoJG6TkVaXFoGyoFKyk+rXlM0pvEPuLvJK6Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnOn013asnwttSUQZ8zbo5N1UUnxvpFwvP/XWTMd7uFd+67CpILcZMvSrVLoSggMoL6EMpeW7MOxiFevX72T9W6eswrEVuU0GcGJCdY9KZWHke4cWudoWADRyKjnLjawa2nIHXmIfdFzdEgZdz6/CwKFdTy5zhjilaWpOW5pceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AM9fsCHn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JL0pQt010823
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sZLOgOakm+kbXuiWKsG+J81Fb7iSgA1HKL74lsfZzlc=; b=AM9fsCHn8QL+D+JE
	G1UKcmlhK7p5oI5iqRxIOqI1Tec8XCsqedvnvBW0esUkYW0iSVvoQBRfDY/L23In
	60EvR2ZM8N+fQxWsqZL29C/3oU+MwCqP630WSPgSLR5MAbbKi3dQ//UPHqYhCngq
	AtXwJohghgYfZxM7v4mbWayKFnzdxOZbxRheLSfIyT9YK6DuOZtwtpNEKMPmkvl9
	fG9/YW5ZqsWZ3CJ6GBrOJrKJ3yhRfxmO5LNEra6NqYYM9sqRlkY7IMLFDKux4m6n
	QiEHqA1wHN+QyoTwvplUNdSckATboOD1gYHqHYx5YcON4m1tb5p1MTNpUb0Zsykb
	qe5+TA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0td8dpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:39:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47610d3879so580721a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755650365; x=1756255165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZLOgOakm+kbXuiWKsG+J81Fb7iSgA1HKL74lsfZzlc=;
        b=LSkoX5g50YQUuX4Lf91WSbYWXPPnLyzsqG6kRLwtM5tNv7uDerQgC/VlS6C6ZRgw67
         bcTrZR377IaueXsuCE1Mjsy6hVs74jPAamX+NKZS9gUQW11NEJxJssEf9JfRTnqtfRKl
         EJCivxBbABiv0JaxX18wjmVAgiqhTdMGT44i876pqm0HssR9dx/Wa3/seiX/p8Kv+pS7
         5G0TNlw6DivEqAFbm1dO1KWq5WdTvn3dvc8w8ey5T46D6ckKIGhXkO7EDZo4YcU8FnOr
         yyRN33uqQVV1Y7D854z7sq3OFtUhxC3fQ+O00Fb67FBsw20HE7JfMlr9uIu/BCCNKPIM
         2dEg==
X-Forwarded-Encrypted: i=1; AJvYcCVC6UJ+EExUOqOyzSU+RaojI9B89BIA5qBAiYCVvnO9cdvoY44pnL+Q3dmOZiApLsdpfbnaI5C/vyVTK5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeOwcmQwlzFsFHzBA8XyGAKZ3hR/MUBmel9riT+Imgi9eOm8C
	orcyOk76nETi6CinI1GQbxP6gANnAy20OEv/UrQrQURCdERXz6BvrZRnBv1SwnKryNWy1hK/OaF
	EWY8rNg7yd4NgrSgKOhky2s19L2MSplf2u3+w27SzsXNJBBNhUTpNpDWZ4E15vh9I904tX87XM2
	nMXU8TrJfy1Ei4OYs81/z/Fn0P6goF6kmdUYPUdg3Y4g==
X-Gm-Gg: ASbGncuY3J/a3rkMZXWKbyPdETrCfwVuaMtUFk1I6Ct4VMAuXiNsehVPo/ULt1nj5K0
	c6c6BBYlbWmkZIAi6VP7gfi4hbxfp2OhBUDJYMESX1uiyN3gLssgE3EwXQI1kqX0weuz4y3ZTPM
	ovyHR4b6xs1/MBS5TIRiodEA==
X-Received: by 2002:a17:902:f0cd:b0:240:58a7:8938 with SMTP id d9443c01a7336-245ef0eeda3mr9115525ad.7.1755650365067;
        Tue, 19 Aug 2025 17:39:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE+lwzJc02JwGtvQsFoWimeOv9a5hCP13MeNKKTEHXQTeefVF7wVVw5AarZciu+sMP5CbvXWOpoOD+dV+l/zI=
X-Received: by 2002:a17:902:f0cd:b0:240:58a7:8938 with SMTP id
 d9443c01a7336-245ef0eeda3mr9115375ad.7.1755650364589; Tue, 19 Aug 2025
 17:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-numa-memblks-refac-v1-1-936b4fd35000@oss.qualcomm.com> <aKSNED01R-AaclOT@kernel.org>
In-Reply-To: <aKSNED01R-AaclOT@kernel.org>
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 06:09:14 +0530
X-Gm-Features: Ac12FXxe4_RLjord-WMcAQ-D9q1Jse-uFVm7Kpvg0wqknococsL8UbxY0BY33d8
Message-ID: <CALzOmR2zOpiN_u1GfudY8QKWOf=w3ytOPuK-dznY7bqKJgJGnA@mail.gmail.com>
Subject: Re: [PATCH] mm/numa_memblks: Use SZ_1M macro to denote bytes to MB conversion
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=OfLBzhTY c=1 sm=1 tr=0 ts=68a5193e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SxtzLQ3OghRKqkiKGnwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfXzTcDL+SpBEu9
 nDULIHJvETzvaxroO6OucQmqOZoavzpRIV3mHnpoMdzeVCRwKe6JqtwKmwfvz7QXSdIcmufvLsJ
 K+yyUGwjebv2nk/AIwQ18kV520DuuuGSWNdr/f39kpAnY/N7DLKBStbGCk9aK96QtRWiWQwYH2k
 Sal0gseTlL1zQGyxI7cptgqJdBbOuWF0Sx7JQACVefC28kChou8Bpn0Mh6cY5+jG1gylf+sRATM
 CmoZOofCcBD1mQYdlPxmR7GIeMk/KtzRmd4/nEAWNoXyituihJZ4qkXR/7gMB8gh264Fcd9oz+R
 AhTlwktTBD3TSJMXWSNP2oVj1pASlPOOY/3ElilmiKcHUo/eAyavgAIpQkCflzyQhFrdyyAZJVG
 hg4hhVwLs0Vbc8AF/SJHMzKc0/rHiA==
X-Proofpoint-ORIG-GUID: fr3MsJhcgUnzRjxfZ2FFo-fNmmBzLS_h
X-Proofpoint-GUID: fr3MsJhcgUnzRjxfZ2FFo-fNmmBzLS_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190196

On Tue, Aug 19, 2025 at 8:11=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Aug 19, 2025 at 02:21:44PM +0530, pratyush.brahma@oss.qualcomm.co=
m wrote:
> > From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> >
> > Replace the manual bitwise conversion of bytes to MB with
> > SZ_1M macro, a standard macro used within the mm subsystem,
> > to improve readability.
>
> There are few others:
>
> $ git grep '>> 20' mm/
> mm/memblock.c:          mem_size_mb =3D memblock_phys_mem_size() >> 20;
> mm/memblock.c:                 (nr_pages << PAGE_SHIFT) >> 20, mem_size_m=
b);
> mm/numa_emulation.c:           nid, eb->start, eb->end - 1, (eb->end - eb=
->start) >> 20);
> mm/numa_emulation.c:                    size >> 20, min_size >> 20);
>
> It makes sense to replace all of them in one patch.
Thanks for checking. Will send an updated patch in the next iteration.
>
> > Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> > ---
> >  mm/numa_memblks.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> > index 541a99c4071a67e5b0ef66f4136dee268a880003..a47aa262a33366337c38ccc=
7c7064da818523dd2 100644
> > --- a/mm/numa_memblks.c
> > +++ b/mm/numa_memblks.c
> > @@ -427,9 +427,9 @@ static int __init numa_register_meminfo(struct numa=
_meminfo *mi)
> >               unsigned long pfn_align =3D node_map_pfn_alignment();
> >
> >               if (pfn_align && pfn_align < PAGES_PER_SECTION) {
> > -                     unsigned long node_align_mb =3D PFN_PHYS(pfn_alig=
n) >> 20;
> > +                     unsigned long node_align_mb =3D PFN_PHYS(pfn_alig=
n) / SZ_1M;
> >
> > -                     unsigned long sect_align_mb =3D PFN_PHYS(PAGES_PE=
R_SECTION) >> 20;
> > +                     unsigned long sect_align_mb =3D PFN_PHYS(PAGES_PE=
R_SECTION) / SZ_1M;
> >
> >                       pr_warn("Node alignment %luMB < min %luMB, reject=
ing NUMA config\n",
> >                               node_align_mb, sect_align_mb);
> >
> > ---
> > base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> > change-id: 20250819-numa-memblks-refac-7b4b5017b598
> >
> > Best regards,
> > --
> > Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> >
>
> --
> Sincerely yours,
> Mike.
Thanks & Regards
Pratyush

