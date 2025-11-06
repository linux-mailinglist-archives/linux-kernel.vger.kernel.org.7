Return-Path: <linux-kernel+bounces-889035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0609FC3C8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1263BE4CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AAC34D4F9;
	Thu,  6 Nov 2025 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XY/FDOaQ"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA834C828
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447020; cv=none; b=gzbnLtcTJMdHL9qFpUc/5bfgLvP/d60QlmypBxl/UDYgsvjbWfzVVoD+JzwA0QgzLRmX78DlNP4pIySts4VfF2XBA8BCulBL5YWP7MKnYvaX8x89rJgZwjghaygTRyXJzyFGSvtEsU+lqqKcjQnvNNuPoFd6h12KRcihPZICsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447020; c=relaxed/simple;
	bh=/H4aKQiGoB+WRNMdPbS39s+XSOfaGMVBTg+VNXS/AO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRAD2YoPPCUcZBPirCFBbTqaES9NlWT5A6rjn0QD21dJdFI63z8osCc/mPjoblTb7M+4MQPR/mAnYIwzz8YAeq6OTJpZM00X823jS5atfqR1Ew1rN8AkJEkUjv5GjOUl7i6vNVC6snhQlRr6fVlK+WtZnJ+m0SpkWV1Uwn0aVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XY/FDOaQ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso353361cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447018; x=1763051818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unfH04DSjfahtY/Ro5y5JWosPD9lmvBdHPZWteASQ2g=;
        b=XY/FDOaQoj+ZAR8PxvT+5Y2lv7KZxY5LGlkhb8xvsn1s7ZpZY4LqYia5rRHbEUpuXs
         aqae7ZK4Ji4maep+IVLR4olUuACbVMgUVPbMeHYIk6n7JePULk6YpHdC6v59dheNdfhw
         PzrOhLsyJvdR49Gl4TDuCVPlxObpz/aB0LWGnKCw2zj6RyJRrfWtwkxwVO+Fy4fFvHZj
         gw5V/QpL30/X6gqXhaK7eVLXfkNLY5JEf1bTUk92FUSL1a7RuK3+moTT9k9GPfRG9WhM
         fpxbcvw0QRwCUAro5A2zCH5Plut8s5Li8xiyh/6PhLjRlxRI1yfvPqZgXOWlE2j7X+cj
         /pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447018; x=1763051818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=unfH04DSjfahtY/Ro5y5JWosPD9lmvBdHPZWteASQ2g=;
        b=WUNRjvqb7q8IR8uY8sdQaPVboTKV65MG5eqlmamDia45AhVJeOKmyMA7bmgD/oWXqP
         zAlirn1mHGKJgU0gmvy9QaFs3r47oa6QqcbWnoE0bCz4NpCJwXP4q/ktXXBrE0z/Mkuc
         Cz2hL2igIn5abIRa6ywRobOe+fy5TunHdMfBiTGXWxD4rqN1yVI35PUJQ42iuLrMbTa1
         50HYBli8LpSGcvX6fHQgrc+in7/MsfUOycYiunAl+ODvuBAL76bK5tdWcR6sudnKdnbE
         TMNKPHBePL8zqA7wUWrCc67fkzLOENzmDU54BNdnHWyCIkwJc4J+dm5Z9Y9NOCtfmXYa
         BVqg==
X-Forwarded-Encrypted: i=1; AJvYcCVYDOLT5+oG0i2WAuNlt6C1Q8OyyHCdPfv7z4Kp7yaD9fXQofN7wwbD0B4Y3h6RslpM7NJvPZcAldhYX50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKHzP9AZAKPSWy8HX6ensTNgkT3oSi/qKnMi1i9TjmPq6OooV
	cylr+SNe30Lysk26hIJ9mbjU6l9YzSWV+7eRaznxyHrmKdA7QHmhaMJGtl8jhQNr05K2Uzm/O/N
	6+5hS/hhiW7R8LupzT7pSY/A/pvS8S8rwy1U+p9Dd
X-Gm-Gg: ASbGncvVHnvuAV9MQ2JJ7JYeWHKy4bAVoW+o3c72ErwYQBYRSqELP+Fs4GgRgihiJyK
	gl/dtVKDo0ugU564YRYglnpMkk0TsIENfkjuXL483p4KK8JjiAtJwt9wxB9Me+oiXmabM4TF3/q
	fvOI1FvXGRCGDnEG/V5akXVi6C1WQ3atbrYmbYWbBYJ9ZTU/3BdK/LLneSBnFOF2KjObvENqzXI
	lvcS7qE5b+C3zwq93FhUaLBWrdGMdHB37XG7M/CVaca+JBx0TXS1HtD0+U8
X-Google-Smtp-Source: AGHT+IH4D/IkZOkIcH6+QihJJUYRXkSroIwjVIneHKA2+S/ighH3/zauPQTD1YhucwuTFxNEEfdh6lM9UHFcearQHbo=
X-Received: by 2002:ac8:5792:0:b0:4b7:aa51:116a with SMTP id
 d75a77b69052e-4ed813f1d79mr8130581cf.4.1762447017683; Thu, 06 Nov 2025
 08:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104003536.3601931-1-rananta@google.com> <20251104003536.3601931-2-rananta@google.com>
 <aQvoYE7LPQp1uNEA@google.com>
In-Reply-To: <aQvoYE7LPQp1uNEA@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 6 Nov 2025 22:06:44 +0530
X-Gm-Features: AWmQ_bnOnZ7KqbhSC0MJ1bizQMExDCc20cQdxq8DyRf13e7QBXYi53UHkKLSdUk
Message-ID: <CAJHc60xjPktqw=RgxgpOSqJP0Ldq6skmxLQm4QhpiojPAMOA=A@mail.gmail.com>
Subject: Re: [PATCH 1/4] vfio: selftests: Add support for passing vf_token in
 device init
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:44=E2=80=AFAM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:
>
> > diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testin=
g/selftests/vfio/lib/libvfio.mk
> > index 5d11c3a89a28e..2dc85c41ffb4b 100644
> > --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> > +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> > @@ -18,7 +18,9 @@ $(shell mkdir -p $(LIBVFIO_O_DIRS))
> >
> >  CFLAGS +=3D -I$(VFIO_DIR)/lib/include
> >
> > +LDLIBS +=3D -luuid
>
> I wonder if we really need this dependency. VFIO and IOMMUFD just expect
> a 16 byte character array. That is easy enough to represent. The other
> part we use is uuid_parse(), but I don't know if selftests need to do
> that validation. We can let VFIO and IOMMUFD validate the UUID as they
> see fit and return an error if they aren't happy with it. i.e. We do not
> need to duplicate validation in the test.

Unfortunately, VFIO interface accepts UUID in multiple formats. For
VFIO_DEVICE_FEATURE and VFIO_DEVICE_BIND_IOMMUFD it accepts a
'u8[16]', but for VFIO_GROUP_GET_DEVICE_FD, we must present it as a
string. Is there an issue with the inclusion of an external library (I
think I've seen others in tools/ use it).

Thank you.
Raghavendra

