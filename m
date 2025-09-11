Return-Path: <linux-kernel+bounces-812473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D1B53898
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138A81CC552B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4A3568E2;
	Thu, 11 Sep 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BubZYe3h"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4C2153D4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606564; cv=none; b=HToIBh6JE2RvHWTY8cxgSjeEkowh6mDo8W6LTTFvkSx3djY2a1TPwKhh2GscbSmxH742lESL5OGWyL6QC1UV0tEzdqs1wI9LPuCMkXYwl3sf/EAlB691eeFNXbiNp3lHeE9JKjEN+SD+NibUrBRFeu6khDtpOasp9eLa8S8ZXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606564; c=relaxed/simple;
	bh=br6EOEaEXU1W5/Rb/Lht5jWrh+9mdSaxvvkmi3rL+Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3ZRIommJ9axHSh4+rc5o4+7nM5JXl4nD/3YZ6Y5tkyHUnU7+AcPEkilzsnPzSXrSHk1HWmxbl9q4SYzRMfp0CIE9F01V6zs7U2H3Iyb5meYfdEt81IjKWpuwX63FvBXkKmVGqypGVbGuOlz1E59RgmZRWYxHfJb32C6qY8WK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BubZYe3h; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea21430so63072b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757606561; x=1758211361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6obS77W4gL8mbr6C+eeuSSKKzH7RwZdvT4ZIG8wkffg=;
        b=BubZYe3hKelZ7gW5zAwsslrfefs8LcKZXEtM++XFeYYrWKyk2TN8F79rxKK++iHRrY
         iMbt8/apuklxainSeioD3ABaz3JjE+mLfcALfgfU+s4zVqQx1KssSrwZj++Zim1P7xGm
         NjHdLPiKFTlbcxQeWKnWfJ5IWBaNUBsHmf0xIEnV5ww/ywkWSjoBc2Aqa1WR5UQvJioS
         2JbviwHvVkmCTTf0SzfKBBp5aCvhdOUIvoHthay5GbB/GQ+XVAN/F3CqynEM2TMSzVhI
         7mBQ4qN151KMxxP52cNLlVK7BkmVXCRWGJv1aKyWOLdxDqyGvMM4WMxKTX0KhW6FsNJP
         znmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606561; x=1758211361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6obS77W4gL8mbr6C+eeuSSKKzH7RwZdvT4ZIG8wkffg=;
        b=GR1YKD5BNa4A3OCAcI4tCADu9OgdJ5xGxrDHEbfbowJrqYg8BhgBBQkMPDo0W2xTsk
         5Q5LY5qP0pHf2goGoAdEjSnW4bIZEGmMpmYCrnxCtAzFIRKISNv4Mb0YlSevRkGiagVw
         WyYu/LHrUoawFKVgoi9HME6Y2+5Srm0/vvizgNIoyLgo49eFsnDkEcccdteJprbhHOV9
         9c0M3qlNPI0Khuk6g3cjqtkleao4dO1Mer0lSWr1a9U0iLcJw9Hyz0PxGa2t/UXYGFVj
         I01x0LFYQA3c6GKZiO4iyWlAyCjX0f0/QgsGKmZzbL/8Jim4ci7b4sOuQbvviPJDNTyx
         yEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKjZmEEJAOP/okOrgalsDESpdME4yqP5qleg9fQrMwmOrpG9sS6g17zvdooWWG39mkky37dGK+BUQNaXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DlbcKtLKJJ2VtryLhwOU7WiVhuybqBMHk1SilOl8pVrDPoKx
	OAuhLzbh+VLvqfcOOOzmqNmsjM4Q2422ytaqHM3Jzq9QTJzy47dK0AOgP7zQuV+x2wkbdxNyE4R
	sxo0PqOCb1SSqYsK8Qyrd4f/0pZ06QaAemcOjMoG94Q==
X-Gm-Gg: ASbGncs5xYbFt/ftNZwipxq+Ln2OTODvjSuh3siAc6jEJNh9B/8ned29fVJMIzuWApf
	AqavuTlLPo1FoLYx12dK9GBbxrO9H80nctAnaAm5Z6VJ/2nO5RhuyvxLTDnvZxuRbDRm0Hj/pvr
	dgEEEIMskw5mMj/7GvAcY+fcvpwxtk6ssf2a0LTa3/h0WW4i6dOb+3T7YXUZgWr2qN/2u7rDFIA
	HQzxGbaqTPry5ruGTzmzbfqIvyRHFtnWJE0xkzJjKGsWBB5XA==
X-Google-Smtp-Source: AGHT+IFBr1IxqXcIUO6bB0xT/+wQnm8xy0aPESUSNVEBROoDUbw28I831Lcf+8PW91sQeC1Tp7s6n5Wn1luV5rDxNOA=
X-Received: by 2002:a17:902:f708:b0:25c:8005:3f04 with SMTP id
 d9443c01a7336-25d217ec277mr163925ad.0.1757606559660; Thu, 11 Sep 2025
 09:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw> <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
In-Reply-To: <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Sep 2025 09:02:26 -0700
X-Gm-Features: Ac12FXzfe0LPetqhsRB28hxh2v9SigeWVoVMRD9W7aqYfRcyJIKVJDep7LH3j1c
Message-ID: <CADUfDZo43a2w64umSCeqJyHrsujh2jHFTQADC5kGuX+d27RnVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better performance
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org, 
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com, 
	jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 8:50=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Thu, Sep 11, 2025 at 12:33=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.=
edu.tw> wrote:
> >
> > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> > The base64 decoder previously relied on strchr() to locate each
> > character in the base64 table. In the worst case, this requires
> > scanning all 64 entries, and even with bitwise tricks or word-sized
> > comparisons, still needs up to 8 checks.
> >
> > Introduce a small helper function that maps input characters directly
> > to their position in the base64 table. This reduces the maximum number
> > of comparisons to 5, improving decoding efficiency while keeping the
> > logic straightforward.
> >
> > Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> > over 1000 runs, tested with KUnit):
> >
> > Decode:
> >  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
> >  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > ---
> >  lib/base64.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/base64.c b/lib/base64.c
> > index b736a7a43..9416bded2 100644
> > --- a/lib/base64.c
> > +++ b/lib/base64.c
> > @@ -18,6 +18,21 @@
> >  static const char base64_table[65] =3D
> >         "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789=
+/";
>
> Does base64_table still need to be NUL-terminated?
>
> >
> > +static inline const char *find_chr(const char *base64_table, char ch)
>
> Don't see a need to pass in base64_table, the function could just
> access the global variable directly.

Never mind, I see the following patches pass in different base64_table valu=
es.

