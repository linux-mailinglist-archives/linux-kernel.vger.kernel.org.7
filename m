Return-Path: <linux-kernel+bounces-821129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37263B8082A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1AE18950C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8F337EA3;
	Wed, 17 Sep 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UecDoJdN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870AA3064A2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122702; cv=none; b=RUBJqkhJDXecS5+V8nMxpfI9tpaVxfU3Cf9eBiVoR4GDJpT/u1osUoFC2xy5ABgP/6OG62RsVaSioEmwlOoNgSoxQ2yhufz3aGNKbCzGj82Xz69KIh4zCQftSJ8aCLHaEtLD3aIP/rCiNg9y5UBxrw3uefZaJl1gCdqXNoptT/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122702; c=relaxed/simple;
	bh=le3rR+Y/6+X3RB7WTCbO7Z1Cx/tQDdq7HqEHt580Kts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZ4jDrPUTthmu4V6Vm466gT2858rkfuuN4JWugvF3AzjHe/ndEXZXkIYr56TNiXL50N1kIThwvG5DoUP1KNqE+96/CxdVYFC+oAvlCIWlfZWSZ8pBSUcRD4sE61JaOmXtcaLhWdwSKA1weTpeuQhv5kVnP7YyF7TsKb/tQ/Hu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UecDoJdN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758122699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOCE7GBioLoeEPVZjsvaFHh39u6q73Q5ex3kMGocTYI=;
	b=UecDoJdNPzzHKwmqpU8hn10PEscwt1wWNUC/BWxE4CBcXQYHduBKQh1RWGJf8+YXvalAbK
	Bz4FR7B+tMgdv38jtC7PrYfNNIDJeC8vQiFi/bCKm64ESDaSg5h9xKRIo6pqLPffdRFQbO
	mutaJ5J74Vn4hRhmkueoNdupaolmFE0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-b_N-KIHTM3-qUYDTUoKw7A-1; Wed, 17 Sep 2025 11:24:58 -0400
X-MC-Unique: b_N-KIHTM3-qUYDTUoKw7A-1
X-Mimecast-MFC-AGG-ID: b_N-KIHTM3-qUYDTUoKw7A_1758122698
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b7a5595a05so75930161cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122698; x=1758727498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOCE7GBioLoeEPVZjsvaFHh39u6q73Q5ex3kMGocTYI=;
        b=wjyoV5CLIpol499gfPwAPi3KuYANMKyaN787SzjsFmCDm0fagTEMskffk+aSKLYN6J
         8QtPg3PROF/9yh953mg72hxfunJJ35vI4GQ4hEl2/dN7dB9tvxkxyrJc7y0mj6alN0Mo
         8fSxJwd/LvS3/5jDQR+MAtbcJH0fCRf4RUJ+QJMA2X4krHd/OP/19prAdKRkNAWl2I3v
         bHQD0MpmdwKyxPv/B2cvJMq3P9W+EqvP4EWJ4klhIwnlV4aM7lP9SWJyTqw1ChRgkAuT
         ybGURSJ+/Z1Z3v1+dFB/PojKfdyjjOjlU0PPMiRlEgLWRr2ZZNQ3miS27UMTqmNk8oKb
         1nlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDNVctBBDlJadtBgG37j14cHKUxhTmcKx45GRazhU9K9Ln9bSViSUN3LlJadBcnIf9O8TqfcrzR48BmMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn3tMVWoJZaXkd9i7QxdN62fORvHyw1N1wFFvouDN5ZPgH2r48
	brDnIWsVNJYIGb9W3D1WP1dKX3UkyfVusag6P4Q0CI1oZE0npSa3mGljf/7GTphdbl+GfIfOPST
	HTqjkaEDgfQ+TtJZcG6WsW4/G2xlglAinJl7pcaXa+/UFSsMnJKKijl+QmzvM9IuzT+35fHrhMv
	sWoScHtE0ft7mch8/VzcIJMjxBv7xyWwH+HiDmpCV7
X-Gm-Gg: ASbGncuvA/6zBbc5jNcXKJI4LQn8aTBDSF7kbW9PrXofPUWhe+JqS0r0KZ2ycj+9xkn
	Kj2oN2ew3F51viuiYLTuqi+U6jjN2QQB6OQKsrnGaJPcUFNB8yxF8Y/IKZhHDXEIJGiKyuh4glt
	vz+ZHt4sLvCPj8wrppKzCODSHxmZcfopEpOLvKslHCnsPd4Rzx73cSNw==
X-Received: by 2002:a05:622a:1e15:b0:4b4:8f2c:ba40 with SMTP id d75a77b69052e-4ba6a5db701mr19915871cf.43.1758122697452;
        Wed, 17 Sep 2025 08:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGX/u0/DWoQ2j8jO01gOLX81vhmFXebVct9qpuqQjgpv8prCPbkq0kI6Uh7cjMspWrlS3R3UWH++SHXByzydM=
X-Received: by 2002:a05:622a:1e15:b0:4b4:8f2c:ba40 with SMTP id
 d75a77b69052e-4ba6a5db701mr19915641cf.43.1758122697037; Wed, 17 Sep 2025
 08:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <20250910170000.6475-2-gpaoloni@redhat.com>
 <878qifgxbj.fsf@trenco.lwn.net>
In-Reply-To: <878qifgxbj.fsf@trenco.lwn.net>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 17 Sep 2025 17:24:45 +0200
X-Gm-Features: AS18NWDoDDpQpUCvPoMLIIOoLe9NuL6mhF4S2DmGBGnkJMhA8eLTTv_JNTSuMdM
Message-ID: <CA+wEVJZreV0zpaNT70_FjuWwEujppsP4ZW_miqdRSfcHyXWrmQ@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 1/3] Documentation: add guidelines for writing
 testable code specifications
To: Jonathan Corbet <corbet@lwn.net>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan

Many thanks for your review

On Tue, Sep 16, 2025 at 12:34=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Gabriele Paoloni <gpaoloni@redhat.com> writes:
>
> [Taking a quick look...]
>
> > The Documentation/doc-guide/kernel-doc.rst chapter describes
> > how to document the code using the kernel-doc format, however
> > it does not specify the criteria to be followed for writing
> > testable specifications; i.e. specifications that can be used
> > to for the semantic description of low level requirements.
> >
> > This patch adds a guideline that defines criteria to formally
> > describe developers=E2=80=99 intent at the function and subfunction
> > level in the form of testable expectations.
> >
> > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > Signed-off-by: Chuck Wolber <chuckwolber@gmail.com>
> > Signed-off-by: Kate Stewart <kstewart@linuxfoundation.org>
> > ---
> >  .../doc-guide/code-specifications.rst         | 208 ++++++++++++++++++
> >  Documentation/doc-guide/index.rst             |   1 +
> >  2 files changed, 209 insertions(+)
> >  create mode 100644 Documentation/doc-guide/code-specifications.rst
> >
> > diff --git a/Documentation/doc-guide/code-specifications.rst b/Document=
ation/doc-guide/code-specifications.rst
> > new file mode 100644
> > index 000000000000..dee1b4f089e1
> > --- /dev/null
> > +++ b/Documentation/doc-guide/code-specifications.rst
> > @@ -0,0 +1,208 @@
> > +.. title:: How-to write testable code specifications
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +How-to write testable code specifications
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +------------
> > +The Documentation/doc-guide/kernel-doc.rst chapter describes how to do=
cument the code using the kernel-doc format, however it does not specify th=
e criteria to be followed for writing testable specifications; i.e. specifi=
cations that can be used to for the semantic description of low level requi=
rements.
>
> Please, for any future versions, stick to the 80-column limit; this is
> especially important for text files that you want humans to read.

Thanks I will stick to 80 chars for future submissions

>
> As a nit, you don't need to start by saying what other documents don't
> do, just describe the purpose of *this* document.

Yes, my goal was to explain the purpose of this doc, however, re-reading
this intro I realize that it uses a negative tone, that is not good.
I will rephrase explaining the it expands on top of kernel-doc.rst
to further specify the expectations from the code and the assumptions
to correctly use it.

>
> More substantially ... I got a way into this document before realizing
> that you were describing an addition to the format of kerneldoc
> comments.  That would be good to make clear from the outset.
>
> What I still don't really understand is what is the *purpose* of this
> formalized text?  What will be consuming it?  You're asking for a fair
> amount of effort to write and maintain these descriptions; what's in it
> for the people who do that work?

The goal is to clearly define what the code is expected to do and how
to correctly invoke it so that:
1) A user of the code does not wrongly invoke it
2) A developer or a maintainer can check if code changes are compliant
    with such expectations (maybe he did wrong changes or the expectations
    need to change)
3) A tester can verify if test cases are correct WRT such expectations and
    complete

>
> How does an author determine whether the specifications they have
> written are correct, both gramatically and semantically?

For grammatical purpose, probably an automated check could be
implemented, for semantic aspects the first level of verification comes
from the community and maintainer review process, whereas the second
level of verification come from selftests that should be written according
to the expectations from the code and should trace to them (as in the
example in patch 3)

Thanks
Gab

>
> Thanks,
>
> jon
>


