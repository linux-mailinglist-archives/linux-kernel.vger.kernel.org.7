Return-Path: <linux-kernel+bounces-885609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE8C33745
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A34354F0B96
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64662264D4;
	Wed,  5 Nov 2025 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfTaIBmn"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFE3594B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301785; cv=none; b=cuQax3gKjgJ6mdZ5nPVuxsOldXN6xfJIF2aSvyGYs37QWQTtG7iaNp4JaKTVYmCtTCiZGwVbS6nJJ2b5gRaRk3S3SSu8NjAl44w5ZTQfpGqJmT6kD1/O7Rk0/3ou7CDU+Q7k+sDp3AH4Vt0Om9C1V6tfQsPuO+N3oUVbIybP6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301785; c=relaxed/simple;
	bh=48YH2RtI3KW7kaFfM/LY3WnoX8bLd0bwh9yZQxZNDBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEDhgURWPHXYkoLxUjrkayacRlBTzd1KPBmgn2SVhAne9WBQtPlLeDLM9P2kp7W1UDcYl0eGCu5Tz6GgG3Vy6+SDuvciG3oT6u6+GQAAvrkAw+hf1oSqeyo8ULcTcarK+npg4FPWp4wF/KkTN1GwSutMZqJS8ORUgFoNkpeacV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfTaIBmn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2955623e6faso37632245ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301783; x=1762906583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R14VE183UXTiToDun6FbcmEsUyunklyOPEIanXsq35I=;
        b=LfTaIBmniUavpTJtQ/0eXlYlafDnHZXjEg8Y1rpb5ko+zVH5Tnp5bK39+nO1LbLpxx
         cyCLJ14ko5Q6YyaoUaGx6m4GEZ8Puaj18hISU99kQV2bWJPwWAX89m7vBi/Jx3QhxiE5
         CQSbdDbWRb7JbqA4cSujFyNSfojizcAngLm70Whg6wnfb5ZlzbCtve8zKbCOGibWDPvx
         IJ+3vhBWFFISya1/6dHPY3KZoAPIHdAX67Lta4DRyXcccmdUT7KCDnyWofMENvfkaWh/
         CFCbPT+gVCf8IU8L5X26TMDwa7iaRuFrYH3vaR51/VqL+M48Bap/WKq2gH71jW2GEuQZ
         GZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301783; x=1762906583;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R14VE183UXTiToDun6FbcmEsUyunklyOPEIanXsq35I=;
        b=R7edf04CW60omWHxW8xOUafWgM4PHWAicqXIxA8lqyqQHkzoVYhpX5K6lFWo82tJnd
         yX7mZtonnN8gEBgcvFHU2UIDxpz7jk0CesgFvOTYmVsGKDSCca4mmLYGqCUhIBLs+WUv
         PkqpRmpRXxdVBFX9OZkXvuImB8K7r0Bj2WNfreMA3cQXT4LSoozYrmeluHGdhpnvPZpJ
         FmxeuaeJTQDXYotRluod3YvQDyeEpEj9ID+8LCxYee0Yj1R/KeoEpmKPvbklv8EThcy2
         IcwdOaQCfoTESEZ7yiTAJicYVeiE/D3GT3nFVLhVuMsl89aB9TTsSWW7N/dMVurK6kKT
         VZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCU1wBJG6TpOa6k9164YGtrWclgcWtr3ZYC7bosGBubhkxU2zdtumC2gl5MMwjLq0aWhIQgXJj7FGmONwok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxQR2mwh5BvyH5gbHjOuH/4pL8MaPdw8+k/IlDxDvfuD7e/He
	nti/FbRV7kyz/xiHj9XJoNzZKSSxDGNK31POcg7ptHEBF4nom0O7JDs3
X-Gm-Gg: ASbGncuc0pG+dGZmtzYNO0N4rr/hCk8+hHsefy9pf9DRuivIdK07s7nhp/HJQSTGLNi
	koWY3z8Z/2SBpWD9ifFRODvxhFFQXGyd8R5aRIb2InNYfLiOQihNXc9M3ib93MuKNFI9CQqLCUh
	K4Y82a2zh4ta8taFYih2I3C2o+tZ0RiWx9sdqCZX/gnpbg1aOeQUQ6gBnnI9r/m2WEZSSzpgs7M
	mpDUM3XbHZlkamnVPN3Oxt2ZIlnwi85svZ8kElMB8S8JfoL8NuC4eVVQ0Cnxi2A/Xo7sN0Hb37N
	1wVoGBcz8s/Kk8lgJL0ZYvceLJM+/J1Xs3BNORfWgyQz29JRXI+LMnWLWF1k5Oo1tKgVPZQCVT2
	QY23IcSjjWOreXyr6FW6Qv7poa3kdFkQM65PYbSVGHsjA5lJTtaN0KUzUOGYYYxaKnpxOUaEIuA
	PI+gGTnM5jE0RlRGYNWPw2BLg=
X-Google-Smtp-Source: AGHT+IGQ3eQZyWv1ijoQcXgFeW5nEdzJ0bEGgowv/pzjI70FkRTNS0ZWHgI8B0kFFPOf2NtHdfcs7A==
X-Received: by 2002:a17:902:d4c9:b0:295:7804:13b7 with SMTP id d9443c01a7336-2962adb4071mr19818925ad.10.1762301783060;
        Tue, 04 Nov 2025 16:16:23 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a87sm39852035ad.15.2025.11.04.16.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:16:22 -0800 (PST)
Message-ID: <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type
 reordering
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Donglin Peng
	 <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan
 Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 16:16:21 -0800
In-Reply-To: <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-3-dolinux.peng@gmail.com>
	 <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:

[...]

> > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > +{
> > +       struct btf_permute *p =3D ctx;
> > +       __u32 new_type_id =3D *type_id;
> > +
> > +       /* skip references that point into the base BTF */
> > +       if (new_type_id < p->btf->start_id)
> > +               return 0;
> > +
> > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
>=20
> I'm actually confused, I thought p->ids would be the mapping from
> original type ID (minus start_id, of course) to a new desired ID, but
> it looks to be the other way? ids is a desired resulting *sequence* of
> types identified by their original ID. I find it quite confusing. I
> think about permutation as a mapping from original type ID to a new
> type ID, am I confused?

Yes, it is a desired sequence, not mapping.
I guess its a bit simpler to use for sorting use-case, as you can just
swap ids while sorting.

