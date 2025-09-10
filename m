Return-Path: <linux-kernel+bounces-811065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00466B523AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA185A01CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D46285050;
	Wed, 10 Sep 2025 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="afQSqLgi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5BE2DF136
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540719; cv=none; b=vDYm6eXjefMjswXu0gf4xiRwAuzW3Jz98bfCqA0/smjGCWddWn0MGZN11YuQZZYYnEaSX2aGlxO1EHWJPbxNU7d7160sIKkpEY/6HKHPIiNsR0pAtPZm1rLwOMtF0tU64f8u5KNrUiS8Lvl27PGeJ3/3DKAWFOVDlkNzr0LWVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540719; c=relaxed/simple;
	bh=Nuc/Dp+QxAfVD1t5zlQhzhPb/Ldfq9L80zQIs71n/kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjYuLb/s3CXDgEijLK9cmUGObfK9rFfBJo2mttOaDgbixLcpnlXmbVodu1P59quv4cyyurn352OjK6hMY4HL0kgu11biQCm0SP43iU1wrhthsMCFSvbyH0LsATdtcESf8LbGpznga7FklLVxbTK0NnlfoofG57qi4JdjNdpxaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=afQSqLgi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACga0k024126
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=w/Demwy4FFKT7wLR0aTkZ0G5aRoHqReEtHzkVf/kk9M=; b=af
	QSqLgi2w1YJVdrThDNuPd9hmdEaSNEqZYJC775XZYXiXqpZ6x+cbC88fQiSzO0pa
	8m3hc2VmCLSWcH2yVTfyCbJXBwVnDvxz9yFGJG0BF+rReKBoZuKTItEPQLH/OkiT
	u5MQLMGkPFPGc0THe4QoNRXFnjf2a/OCgDggVoafUGGhtfpvijOFkBtgPFnicRaR
	p6XaQxKnlptFJaN23Sl8buj06gh2fHCnz2RbBTDH77PqTacdb09wm7Le0knSqhGj
	01VOP7B9Zefv0kxiu9TjHqna4JzMB+ahI51/lB57HxPNW8NHpuEJ4NxM7/9OdX6O
	k6+KtTA7afXD5lvKVq5A==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m5a0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:45:16 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-30cce517292so31178fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757540706; x=1758145506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/Demwy4FFKT7wLR0aTkZ0G5aRoHqReEtHzkVf/kk9M=;
        b=kKNcLibqHr5T3hRe9LAHEelIgkr7fJjJUm8eJfPH4BqBH2T7T4Z7nLXoWluBOEuh0L
         xQrVITJEA9RSyFlIWu6dLQdgzEpPiXimU6llex5ShsFJfmHMwjeWZK8hxZv3xdz9fR2j
         9vJngflqoBM6ZaGpIxwKwcEp99HUFkyBE+yyAeuGQWR0Q97FZHDKTQrzg4ap1JC+dO0V
         IjeYYe7F/Bn4T94wg1Cp4iGRRjZfA90deWeeSJK4xMM88ZjoFOhYH0DCyuUryHtVs0I/
         AVREJL8VnczkjFt/UbZrdLF7hSjtHMY4FKCYHv3AjWqz93tPOv/ohcoUamJAQy+Byp5M
         AW+A==
X-Forwarded-Encrypted: i=1; AJvYcCWPQZTzWNCEUHnTEZKJwVwmku5lOg/Vb++fQ8rAcvFhVmEgcadGpbE5ip4jJmBWjpR1I5Yb0NW1F8Tonl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSiWyjrzipfsWtifPUQWAD2ErjpDqM/RSQrD6nvLdC24wjxzDi
	oD0P/5uQGS4P/6ke5etCgph1yg7YzQFFkzWkwvEv9hp2Hn3HpluV/XcUPzjqYTW2BR5fafgrW+j
	cEY+K4Z+Ek22gpxWC8hP/mw7U9/HslcDqp9AvP1yJZs7qAH240aSHs7IPGSnKKAM8BIgE9vfqUv
	+6u5AaPU8qazfM63YnagGJ2JYVGDtk3M5JvWG1I+JXGA==
X-Gm-Gg: ASbGncu1Qslp/zjOGr6ky2m8dNBZHMj0ruwkFMODeRe8mj65tCwd0OT6ydHtpeG/EeK
	PLVJ5i8bEkK3r3I8RxbRI9u/0/BbXnjURZ2QvXqGx/F5NRQ3/wicl/auI+ttZpnbm2m61Z6uLmY
	9how9VEpH4F0lL3x4OhlPaiUexIIr96AjqMgCIZdxYupjQ/YE0PW8I
X-Received: by 2002:a05:6870:9a1d:b0:321:2521:5a5 with SMTP id 586e51a60fabf-32262a6d362mr7274769fac.3.1757540705903;
        Wed, 10 Sep 2025 14:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVJ/g50t9kZW/ZaLe6GVeeuLBnWoaA7n3zqpoh6NbWQOdQF2WIKC87B32dbYHeYbUE2X9ZEP7MoGbxj7Ep8to=
X-Received: by 2002:a05:6870:9a1d:b0:321:2521:5a5 with SMTP id
 586e51a60fabf-32262a6d362mr7274754fac.3.1757540705293; Wed, 10 Sep 2025
 14:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
 <20250908193021.605012-2-robin.clark@oss.qualcomm.com> <o25axq4soxjluqnxjad2f3blhezuglsvex6k3aav5v65ynn7qd@5i3wm2lryr7q>
 <CACSVV02Zym2hC-fFcJsP4M9T4mYGXsMtGrmnux6Eva0C7PHdfA@mail.gmail.com> <sydyej7hrw6tryx5lnidqucx3bcw34dkinj5c2u6szbv2wgnuo@utrlq5q5pt6n>
In-Reply-To: <sydyej7hrw6tryx5lnidqucx3bcw34dkinj5c2u6szbv2wgnuo@utrlq5q5pt6n>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 14:44:54 -0700
X-Gm-Features: Ac12FXwEpZ-r7IA8mOiamsbu_r09tIKNVWf2xHQxyoK9apW3k-0zqtWLdY5g9aw
Message-ID: <CACSVV02=+=PXtW-MrZVBKkFpadbMC_twKyRDPBb+YSJDX7dqTQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/msm/registers: Remove license/etc from generated headers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX9L7Xd8zTZhtf
 Zt7MMb1Ep1A93CofzSysOGze9iKkqhyKk4z63k1UrAyPWTY0AJNqh/npeNhRn/J6HsuRf7ZVM6A
 Y7A43Jkx3l1tkRv3cHiTV63uL0ICs2Kqqqb0bNJUXo87CK08eY/mBzKm2sqiVAOIkXAVEgD6Wh9
 3IqFAP9eVtl2lf2tCqYcheTbG2NI4yqjfW+dgCZnzKhqGkkwcm6e/HwLoSSjxM9DcaK11n9evPx
 VKKRGewIMynTTdxIh/BNFrz1Z084m57PGccetHcB8y07Z4J4/m8sY4nqpubc2kB8GGR2wYSNNBZ
 SEphEBLKzuzQOJxUJfkBUhCyo7wOXNxugMf6XJoSq+JaFPd14SxgRlykPte6Isgs9pfFxx2tNGh
 1hN7CRt5
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c1f16d cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=mG2Gs39SVwW7J4BDEKgA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: jXPTiGt94Mfrk74RFcWKvSYXEZpD8R_V
X-Proofpoint-ORIG-GUID: jXPTiGt94Mfrk74RFcWKvSYXEZpD8R_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Wed, Sep 10, 2025 at 12:38=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Sep 09, 2025 at 10:25:52AM -0700, Rob Clark wrote:
> > On Tue, Sep 9, 2025 at 8:01=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Mon, Sep 08, 2025 at 12:30:04PM -0700, Rob Clark wrote:
> > > > Since these generated files are no longer checked in, either in mes=
a or
> > > > in the linux kernel, simplify things by dropping the verbose genera=
ted
> > > > comment.
> > > >
> > > > These were semi-nerf'd on the kernel side, in the name of build
> > > > reproducibility, by commit ba64c6737f86 ("drivers: gpu: drm: msm:
> > > > registers: improve reproducibility"), but in a way that was semi-
> > > > kernel specific.  We can just reduce the divergence between kernel
> > > > and mesa by just dropping all of this.
> > > >
> > > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > > ---
> > > >  drivers/gpu/drm/msm/registers/gen_header.py | 37 +----------------=
----
> > > >  1 file changed, 1 insertion(+), 36 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/msm/registers/gen_header.py b/drivers/=
gpu/drm/msm/registers/gen_header.py
> > > > index a409404627c7..56273a810c1d 100644
> > > > --- a/drivers/gpu/drm/msm/registers/gen_header.py
> > > > +++ b/drivers/gpu/drm/msm/registers/gen_header.py
> > > > @@ -444,9 +444,6 @@ class Parser(object):
> > > >               self.variants =3D set()
> > > >               self.file =3D []
> > > >               self.xml_files =3D []
> > > > -             self.copyright_year =3D None
> > > > -             self.authors =3D []
> > > > -             self.license =3D None
> > > >
> > > >       def error(self, message):
> > > >               parser, filename =3D self.stack[-1]
> > > > @@ -686,10 +683,6 @@ class Parser(object):
> > > >                       self.parse_field(attrs["name"], attrs)
> > > >               elif name =3D=3D "database":
> > > >                       self.do_validate(attrs["xsi:schemaLocation"])
> > > > -             elif name =3D=3D "copyright":
> > > > -                     self.copyright_year =3D attrs["year"]
> > > > -             elif name =3D=3D "author":
> > > > -                     self.authors.append(attrs["name"] + " <" + at=
trs["email"] + "> " + attrs["name"])
> > > >
> > > >       def end_element(self, name):
> > > >               if name =3D=3D "domain":
> > > > @@ -706,8 +699,6 @@ class Parser(object):
> > > >                       self.current_array =3D self.current_array.par=
ent
> > > >               elif name =3D=3D "enum":
> > > >                       self.current_enum =3D None
> > > > -             elif name =3D=3D "license":
> > > > -                     self.license =3D self.cdata
> > > >
> > > >       def character_data(self, data):
> > > >               self.cdata +=3D data
> > > > @@ -868,33 +859,7 @@ def dump_c(args, guard, func):
> > > >
> > > >       print("#ifndef %s\n#define %s\n" % (guard, guard))
> > > >
> > > > -     print("""/* Autogenerated file, DO NOT EDIT manually!
> > > > -
> > > > -This file was generated by the rules-ng-ng gen_header.py tool in t=
his git repository:
> > > > -http://gitlab.freedesktop.org/mesa/mesa/
> > > > -git clone https://gitlab.freedesktop.org/mesa/mesa.git
> > > > -
> > > > -The rules-ng-ng source files this header was generated from are:
> > > > -""")
> > > > -     maxlen =3D 0
> > > > -     for filepath in p.xml_files:
> > > > -             new_filepath =3D re.sub("^.+drivers","drivers",filepa=
th)
> > > > -             maxlen =3D max(maxlen, len(new_filepath))
> > > > -     for filepath in p.xml_files:
> > > > -             pad =3D " " * (maxlen - len(new_filepath))
> > > > -             filesize =3D str(os.path.getsize(filepath))
> > > > -             filesize =3D " " * (7 - len(filesize)) + filesize
> > > > -             filetime =3D time.ctime(os.path.getmtime(filepath))
> > > > -             print("- " + new_filepath + pad + " (" + filesize + "=
 bytes, from <stripped>)")
> > > > -     if p.copyright_year:
> > > > -             current_year =3D str(datetime.date.today().year)
> > > > -             print()
> > > > -             print("Copyright (C) %s-%s by the following authors:"=
 % (p.copyright_year, current_year))
> > > > -             for author in p.authors:
> > > > -                     print("- " + author)
> > > > -     if p.license:
> > > > -             print(p.license)
> > >
> > > IANAL, but I as the generated files contain C/C++ functions, I think =
we
> > > need to have a corresponding licence in the file.
> >
> > I can't find anything that indicates a difference depending on the
> > contents of the generated file (ie. whether it be
> > functions/tables/prototypes/etc).  And AFAICT it is implicit that the
> > license of the generated file is inherited from the input to the
> > generator.
> >
> > Some other points:
> > - the various *.mod.c files generated for each kernel module do not
> > contain a license
> > - various files generated by asn1_compiler do not contain a license
> > - other generated .c/.h files are a mixed bag, some contain a license
> > header and some do not
> >
> > (In all of the cases the generated files should not be distributed,
> > IMHO.  Yocto should fix this.)
>
> It's a bit funny. Normally you use something like linux-headers-foo,
> which contains just include/*, arch/foo/include/ and some other files.
> Yocto has adopted a way of building the modules against a full-kernel
> source & binaries dirs. As such, those two directories are parts of the
> cache aka 'shared state', which gets shared, etc.

So _all_ generated files get shared?  Is this about building
out-of-tree modules?  (Which even in that case, they shouldn't need
these generated files.)

BR,
-R

> >
> > BR,
> > -R
> >
> > >
> > > > -     print("*/")
> > > > +     print("/* Autogenerated file, DO NOT EDIT manually! */")
> > > >
> > > >       print()
> > > >       print("#ifdef __KERNEL__")
> > > > --
> > > > 2.51.0
> > > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

