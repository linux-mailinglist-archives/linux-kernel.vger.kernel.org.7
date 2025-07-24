Return-Path: <linux-kernel+bounces-743793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C43B10364
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18F7163082
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50822749CF;
	Thu, 24 Jul 2025 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h71r/Vgw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F32749C9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345249; cv=none; b=jPhDxCN8hRMwYIBgsVbM3mTs2lwqrc7+/dZk4SJ3W85HPHjFQt8wD2yyjz2pY0ycN7ErLs4BYNZJbTRNjrrT72fg1mrjXjrWZDS/ACR7Wel3RKNSe6gFaQUAy50sAbVe1byQ+/tagioGtRyj/vxr/bM2YmeLcyF2XdLqo5CFrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345249; c=relaxed/simple;
	bh=PY6FA72lx+rsHdWf/O1btP/hvDoM5PWlZyolAQrsaaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8n6bKgr8JKHtEGBl7unQpstlZIDVb9fl4Y8NZpqMFWDPyz4bF7t5FVz6IgsO4RnzMAQCUD/HFHgXwXK2eZ8yproDdRSY2jxLfbPeei7YSgFaUl+bc47cEGxdh8rTRVkpOxotp/ccqgsyUILbSy7POlBoJyef7BppO4fSLjpDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h71r/Vgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753345245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty1Nmgr/yohBN38P9mzD5LZanNswcBU4P2JN0tNImlQ=;
	b=h71r/VgwubB1cae1WsAI0QVWAvw0P3FY3VhTeFHD/2/ZtGgEV9w6WTyyn5ixpkec/LDXLD
	7FxJuKGub+V1vWUiFlQPe1OhiYbvvdmETVOtcbZF+NpdAHzvdN1KBacDFhpI7yc+NAq2RH
	qV9VOB9CjSOfo/3EpKgwurcpzbXPLvQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-boLw1cRPP_O9sD5X5PqlGg-1; Thu, 24 Jul 2025 04:20:44 -0400
X-MC-Unique: boLw1cRPP_O9sD5X5PqlGg-1
X-Mimecast-MFC-AGG-ID: boLw1cRPP_O9sD5X5PqlGg_1753345243
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e819e8eb985so857238276.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345243; x=1753950043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty1Nmgr/yohBN38P9mzD5LZanNswcBU4P2JN0tNImlQ=;
        b=efYdbtH0ERbfSfKouyI/xVUu5oeHwZ2Zi/vMZ2kXTRTW5ziOyE+reiKLOdE2Y1e9Ds
         cBNdGxge5RIw4kEFB3ghEL+JknrGa5eSl2X6oHlMvXI7a6lDHBEx8AE3tD5RGYWEOQO1
         A3Vx8re6919mgyAGFMEOHkyr8pqTtMMjUccENMf0Oa39CzyKjgJEbSSdpaI5ox6mFrV/
         PoQvBZC7fel9jf9qw6744lRdsKHS3iws2a1xFEU741NP5bJk0/992YZbYSjlQgVRdH4m
         lNIh3bRua5p4KQw1BqrDcAijIiKk+Q2b2WagBss+f5jGct9aVs98F2/r88ASpI4Nxb2U
         P7oA==
X-Forwarded-Encrypted: i=1; AJvYcCUxq8bhHYgFNcqHAhRqTClkjXnNM5J2KWGQhTB7yYF1MX5RsnzIaNwJFu0wJxIgeYVDFjbAFYpMMaoEjyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt69Lq2JcnTAm46TuTj8hL7pQjoTrmJz11f2itvyudkNrPIbCO
	tSz03UUEJiFYPUe1J0qgqw/5skO2YFexjZ89vEJiqEA7bTHK8MTV9M7ILQeacmFS2/eh9+jLxzU
	zhuMjL5vR6nAaS9L01G+G1EbLanDS5RqVWckhcXEyH147G8AVqF+41TUa0RkcmlyFFjHNsOv1pF
	Ek03xkD0TjpwOVuRfm/xhayrfTkihmIe2jGuWYRYha
X-Gm-Gg: ASbGnctQTOC7bMob4j9ultEYxRa1IeOPAud9fniU4WoklB1aSGjmuKa6EX23K53BBzb
	u2hslkFYOq8yREZ7dXZ0Xd+DvXDKh6p0w3m9VMG4fI/kwprjLyIKbgNqabHX8loNL+tr5WEpXD2
	5bRRA16xAG4LPtNRYugarX+w==
X-Received: by 2002:a05:6902:310f:b0:e87:b33c:7981 with SMTP id 3f1490d57ef6-e8dc595b0abmr6776102276.33.1753345243354;
        Thu, 24 Jul 2025 01:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhtmOQZoG8MJqXUBbHZjrjfL2o69nkUHbskfHC38XgsD1gmsQVJ+5FqH2fq1iw+bluM/HBXchsFWiPGsWmksc=
X-Received: by 2002:a05:6902:310f:b0:e87:b33c:7981 with SMTP id
 3f1490d57ef6-e8dc595b0abmr6776091276.33.1753345242975; Thu, 24 Jul 2025
 01:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <238b803af900dfc5f87f6ddc03805cc42da2ca35.1753332902.git.xmu@redhat.com>
 <aIHRwwOl-FS8KOV0@fedora>
In-Reply-To: <aIHRwwOl-FS8KOV0@fedora>
From: Xiumei Mu <xmu@redhat.com>
Date: Thu, 24 Jul 2025 16:20:31 +0800
X-Gm-Features: Ac12FXzu1I7NXeznfsc628RU_1n_SK2CsVM_ZFesDKVFeRN_1fJs6j-4D1IwnIg
Message-ID: <CADdRzaF5Ck86fyEYaeWjvoVt=8qEhNKJ8J3ye+x0cb9EATqQ7Q@mail.gmail.com>
Subject: Re: [PATCH net] selftests: rtnetlink.sh: remove esp4_offload after test
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Long Xin <lxin@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shannon Nelson <sln@onemain.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

resent the reply again with "plain text mode"

On Thu, Jul 24, 2025 at 2:25=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> Hi Xiumei,
> On Thu, Jul 24, 2025 at 12:55:02PM +0800, Xiumei Mu wrote:
> > The esp4_offload module, loaded during IPsec offload tests, should
> > be reset to its default settings after testing.
> > Otherwise, leaving it enabled could unintentionally affect subsequence
> > test cases by keeping offload active.
>
> Would you please show which subsequence test will be affected?
>
Any general ipsec case, which expects to be tested by default
behavior(without offload).
esp4_offload will affect the performance.

> >
> > Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test"=
)
>
> It would be good to Cc the fix commit author. You can use
> `./scripts/get_maintainer.pl your_patch_file` to get the contacts you
> need to Cc.

I used the script to generate the cc list.
and I double checked the old email of the author is invalid
added his personal email in the cc list:

Shannon Nelson <shannon.nelson@oracle.com>. -----> Shannon Nelson
<sln@onemain.com>

 get the information from here:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Da1113cefd7d6

>
> > Signed-off-by: Xiumei Mu <xmu@redhat.com>
> > ---
> >  tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/s=
elftests/net/rtnetlink.sh
> > index 2e8243a65b50..5cc1b5340a1a 100755
> > --- a/tools/testing/selftests/net/rtnetlink.sh
> > +++ b/tools/testing/selftests/net/rtnetlink.sh
> > @@ -673,6 +673,11 @@ kci_test_ipsec_offload()
> >       sysfsf=3D$sysfsd/ipsec
> >       sysfsnet=3D/sys/bus/netdevsim/devices/netdevsim0/net/
> >       probed=3Dfalse
> > +     esp4_offload_probed_default=3Dfalse
> > +
> > +     if lsmod | grep -q esp4_offload; then
> > +             esp4_offload_probed_default=3Dtrue
> > +     fi
>
> If the mode is loaded by default, how to avoid the subsequence test to be
> failed?

The module is not loaded by default, but some users or testers may
need to load esp4_offload in their own environments.
Therefore, resetting it to the default configuration is the best
practice to prevent this self-test case from impacting subsequent
tests

>
> >
> >       if ! mount | grep -q debugfs; then
> >               mount -t debugfs none /sys/kernel/debug/ &> /dev/null
> > @@ -766,6 +771,7 @@ EOF
> >       fi
> >
> >       # clean up any leftovers
> > +     [ $esp4_offload_probed_default =3D=3D false ] && rmmod esp4_offlo=
ad
>
> The new patch need to pass shellcheck. We need to double quote the variab=
le.

Thanks your comment, I will add double quote in patchv2

>
> Thanks
> Hangbin
> >       echo 0 > /sys/bus/netdevsim/del_device
> >       $probed && rmmod netdevsim
> >
> > --
> > 2.50.1
> >
>


