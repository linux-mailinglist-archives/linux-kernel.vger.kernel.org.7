Return-Path: <linux-kernel+bounces-843707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4FCBC00B4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 04:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 001A34E123B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 02:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2842D1A9FA7;
	Tue,  7 Oct 2025 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9akHRXQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7448F6F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759805351; cv=none; b=Z2NXwIl+B+GsMwKKfOFUCL00Iovn1UqH+tC/FI8HJkh7/+t6xmuxsbDgKznX0XQlNz1SFdP9zgSF1rtggs+fhg3ZW2rykbMpMqspQzsBno5bu3LY6vTajw7akM9ZIOf4xf0qoI0chvurqLjR+2g1495ysFqvK3kktuxPOAZaWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759805351; c=relaxed/simple;
	bh=06gdcexDE8Xgtqs5/8XIfXWjL/ZC+h/cxJ/K3cMmh70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE+VIUY9Sd4TmrjsVVwYR3lo+9LZtDCfs3a71Dm4xG89ltEtjAOkKMRmHWABIFGBwVJf1+Qfu2555NUQ0NDAvHnj5j4O0vh1WokDisfBr5G9DdVNyQY5g1Jk+jB+6ZtSqa8/6hN16Z4n8sK2XzKvqOE6kBTwcqEnBRkQrybbBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C9akHRXQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FBIhP023928
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 02:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZaVRARoA0Utmb00lsi/x3dreIJP+vK0P4UWKcbv4Zgo=; b=C9akHRXQXeF4ftyI
	HqGYpjPnKE68qbE9NVD/8nyXf7dC3l/iqvUblU3a66gCUGQmj+VhHj2iJ9/tu4X5
	ITS7ipt5Ho+pCpzaBu3IkVQeHXveMb70sIoMGw/BnZu2ThhC+X3uyj2sFzCf8FKj
	3CEBFWB4bulVgIh8siTZnXy3IyLi1WTrwERklVjNDDF7FQTNJtEKXOwaSq3OWpIG
	bv+zB2YU79VswFwnouMFGpxm7g4AEaHvFOe5/hRd8O0V1yxmP5gfznIKwJXuR1cc
	qshuYJIDJ8o3S/6wz5Y7AzbMUJcOzMgGxxyTw0d7yrgJ8Xy0tvfFhnvRJZDGlfQr
	CMnDrw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mg6a9h9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:49:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28d1747f23bso54320705ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 19:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759805345; x=1760410145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaVRARoA0Utmb00lsi/x3dreIJP+vK0P4UWKcbv4Zgo=;
        b=lWQfQR+febYxY/P+dbWhzu/wOw9lnaC9LA8Ol7jXuzaI6QLMGvu+uAVlpDPKptQR1T
         BGRCnujBZ2cLe8VqYShhT7+u19QN0YhhtiSxezSZNTRAc4vJuM7g/QoZyLEgWDxVCiub
         4KqvZz9JG/DqQBgcxhkzF9EDqCB1E+ynWr8FOKzm+yAbhQ4rdEhr5zmfqfbLBSZ4BpEu
         k/cjn+wxUa/Sg4Ya4LEI9i5900tFNmZq5VRfSmeZlQidw/ja6p/JAX+NjfJEmSvPKwr3
         7NK3P+0InJ197rnk0FUYUJ75qFo+YVdSqpBsrkmnnyv6Vfnh6ofeLYfGYQpe89V/SaSM
         AaLw==
X-Forwarded-Encrypted: i=1; AJvYcCVqcCwFDDufSXTGvI+lsqZcBZ1znMQAcRc8+NPyDKmNuiD4iWSlOVYhXyA/DRe10pzrmQGx9cmdES4dHSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6JMuUz0KBH4biijNf98pDZjwvMJpDWAPqyQC3rHgDHCkD0aT
	Jcycg5DtJ+Gam6KJB6z5LJEeI5TyBMQTSbN2f8JPHkFsD3bo6EwqZGMXJ1QcbMiTD9aO6eWl43X
	qZe/dSaoOqra2RfCHfwVIvRmg9doJdHvPGXd5n62nxp2b1ZUw0up4PlHnIGGTv+kf2ZWiCrrYG0
	lsKyoR7zBTxhQ9OoVg/kfdQjSNrNUJdWTYSDi4dFKywA==
X-Gm-Gg: ASbGncuSFG9ry9CbVdw1lHNAopi36nBWTUs9R8b4NstOnLxN8DC+s/4xeVke6msX7av
	wAiVr+a6I/CCT1SApwoWIB4DcHilvi2lh9pqz5CQ3SC2vgsqI/LjDzsditg2ddruQ0/sIVGGLxq
	p9bibgtKtV+lEj2Fb6WVDzY3Oby+w=
X-Received: by 2002:a17:902:d50e:b0:269:96db:939 with SMTP id d9443c01a7336-28e9a6b0dcdmr199099655ad.58.1759805344806;
        Mon, 06 Oct 2025 19:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRw/gCNivlB2gJzL3pzI5yAlRdbCy22/fFa4QaQE+YWcrxo0MZumJE//yiECCnuHYpwKKk9WHBmMtTy9sAQ0I=
X-Received: by 2002:a17:902:d50e:b0:269:96db:939 with SMTP id
 d9443c01a7336-28e9a6b0dcdmr199099265ad.58.1759805344266; Mon, 06 Oct 2025
 19:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-numa-emu-v1-0-714f2691bf8b@oss.qualcomm.com>
 <20250926-numa-emu-v1-2-714f2691bf8b@oss.qualcomm.com> <3a1e75dd-6b39-4506-b4d7-806915d2a6fa@csgroup.eu>
 <CALzOmR06+7wz1mF4PcA5oYn-1HJg7ZEn0WzCQyCrUK3WZT1E9g@mail.gmail.com>
In-Reply-To: <CALzOmR06+7wz1mF4PcA5oYn-1HJg7ZEn0WzCQyCrUK3WZT1E9g@mail.gmail.com>
From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 08:18:52 +0530
X-Gm-Features: AS18NWDuD4sXAZmnnUGTHv_6__r29Bqwu2piwwlOTsCHSiyCXxtoTQWAGSnstCM
Message-ID: <CALzOmR1Pi0Uf9q=kW5ooLFxyxZ79J8rkMQTgEKH8s+aa8_rAEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/numa_emulation: Move the size calculation in
 split_nodes_interleave() to a separate function
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QtdTHFyd c=1 sm=1 tr=0 ts=68e47fa1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=EUspDBNiAAAA:8 a=1UX6Do5GAAAA:8 a=rmvc3b5iyUt8DdIxB8EA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: PLnlvWGtkNpJ6MQ-2Z6Yh6mqD30DF8h3
X-Proofpoint-GUID: PLnlvWGtkNpJ6MQ-2Z6Yh6mqD30DF8h3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMSBTYWx0ZWRfX9kVLPG2QSv1c
 fS4KiOmqd23X5puqG8z5aDlQyCS4Sde/piMjko38KbzUQate4S+KUbwswsFxBcDjiPYfDqBEw34
 Ag5mYmYDWqyG2/EptzWAXh1uxnoWgzARZIjRKZFubjcsB9XKUMjgr3TahlufaJXAzZWfdsoSpEV
 JuzprWQ5nnKWxpix94KcM/DaZKuUIMFeFzVBHnLQ7Qp+GHkTmNqa5nQV0MZ7Olmn8KkizUWH150
 2W18R5NzQYRY3I2aw4d+FyVPClXaVgtvSp6xgO+IWJzZVAj6cPS7221RRs33S+TU8MLxMkU4LxS
 RSdKVxv41mtNV1XdVUju0GpptXVzAjoeqDxYzBhtjQBr7kIonpLv00uNfEc/FhuPxabN9UkHyka
 /e5Fbd+dy0eDRKwY71Tbx5tTZaQh4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060121

On Mon, Sep 29, 2025 at 12:46=E2=80=AFPM Pratyush Brahma
<pratyush.brahma@oss.qualcomm.com> wrote:
>
>
>
> On Fri, Sep 26, 2025 at 7:50=E2=80=AFPM Christophe Leroy <christophe.lero=
y@csgroup.eu> wrote:
> >
> >
> >
> > Le 26/09/2025 =C3=A0 12:34, pratyush.brahma@oss.qualcomm.com a =C3=A9cr=
it :
> > > From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> > >
> > > The size calculation in split_nodes_interleave() has several nuances.
> > > Move it to a separate function to improve code modularity and
> > > simplify the readability of split_nodes_interleave().
> > >
> > > Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> > > ---
> > >   mm/numa_emulation.c | 44 +++++++++++++++++++++++++++++-------------=
--
> > >   1 file changed, 29 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
> > > index 2a335b3dd46a..882c349c2a0f 100644
> > > --- a/mm/numa_emulation.c
> > > +++ b/mm/numa_emulation.c
> > > @@ -76,6 +76,34 @@ static int __init emu_setup_memblk(struct numa_mem=
info *ei,
> > >       return 0;
> > >   }
> > >
> > > +static void __init __calc_split_params(u64 addr, u64 max_addr,
> > > +             int nr_nodes, u64 *psize, int *pbig)
> > > +{
> > > +     u64 size, usable_size;
> > > +     int big;
> > > +
> > > +     /* total usable memory (skip holes) */
> > > +     usable_size  =3D max_addr - addr - mem_hole_size(addr, max_addr=
);
> > > +
> > > +     /*
> > > +      * Calculate target node size.  x86_32 freaks on __udivdi3() so=
 do
> > > +      * the division in ulong number of pages and convert back.
> > > +      */
> > > +     size =3D PFN_PHYS((unsigned long)(usable_size >> PAGE_SHIFT) / =
nr_nodes);
> > > +
> > > +     /*
> > > +      * Calculate the number of big nodes that can be allocated as a=
 result
> > > +      * of consolidating the remainder.
> > > +      */
> > > +     big =3D ((size & (FAKE_NODE_MIN_SIZE - 1UL)) * nr_nodes) / FAKE=
_NODE_MIN_SIZE;
> > > +
> > > +     /* Align the base size down to the minimum granularity */
> > > +     size =3D ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
> > > +
> > > +     *psize =3D size;
> > > +     *pbig  =3D big;
> >
> > Having to return simple type values through pointers is usually the
> > start of proplems.Whenever possible you shouldn't returning simple type=
s
> > via pointers.
> Thanks Christophe for your comments. Can you please help me understand wh=
at kind of
> problems can we run into so I can be mindful of this going forward?
> >
> > Your function is void, it could return size instead.
> Sure, it can be done.
> >
> > And big seems independant, could be returned by another function.
> Had included big in this function as it was calculated before we align th=
e size to
> FAKE_NODE_MIN_SIZE. If we move the calculation of big to a separate funct=
ion,
> it would compute the value after the alignment of size, which would alway=
s render
> big as zero, wouldn't it?
>
> And if I move the calculation of big to a separate function which takes i=
n the precomputed
> size value as input and call it within the new helper, then I would still=
 have to return big
> from this new helper, won't I?
>
> Please let me know if I am missing something.
Hi Christophe

Can you please help me to understand here?
> >
> > > +}
> > > +
> > >   /*
> > >    * Sets up nr_nodes fake nodes interleaved over physical nodes rang=
ing from addr
> > >    * to max_addr.
> > > @@ -100,21 +128,7 @@ static int __init split_nodes_interleave(struct =
numa_meminfo *ei,
> > >               nr_nodes =3D MAX_NUMNODES;
> > >       }
> > >
> > > -     /*
> > > -      * Calculate target node size.  x86_32 freaks on __udivdi3() so=
 do
> > > -      * the division in ulong number of pages and convert back.
> > > -      */
> > > -     size =3D max_addr - addr - mem_hole_size(addr, max_addr);
> > > -     size =3D PFN_PHYS((unsigned long)(size >> PAGE_SHIFT) / nr_node=
s);
> > > -
> > > -     /*
> > > -      * Calculate the number of big nodes that can be allocated as a=
 result
> > > -      * of consolidating the remainder.
> > > -      */
> > > -     big =3D ((size & (FAKE_NODE_MIN_SIZE - 1UL)) * nr_nodes) /
> > > -             FAKE_NODE_MIN_SIZE;
> > > -
> > > -     size =3D ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
> > > +     __calc_split_params(addr, max_addr, nr_nodes, &size, &big);
> > >       if (!size) {
> > >               pr_err("Not enough memory for each node.  "
> > >                       "NUMA emulation disabled.\n");
> > >
> >
Thanks and Regards
Pratyush

