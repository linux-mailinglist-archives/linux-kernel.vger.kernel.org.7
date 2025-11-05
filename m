Return-Path: <linux-kernel+bounces-885611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73371C3375B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 799444EEE5C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC23A23D29F;
	Wed,  5 Nov 2025 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SctNo6F/"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD26239E7E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301963; cv=none; b=qhgTYFMoc9na6KxspOfbtyMfmuT1za0grWtctBF9HIHE+O1jGxj5pjhwjLz+rqXS9GuRXLG3gL3vIVdoUCCfhG7stJKjkJcAOdnJK8C7tQbkWW9LJTo1uA4vTQ3OMIz/Oj6F01ah9GhLUC0iZvwefIhH5KXoaK5apnorl6IPNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301963; c=relaxed/simple;
	bh=QDwYksSWVzmrhGL6bChdX4vnl8TjAu3iipcMTTMEHVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmkeMilo54y0m0YS8dNiAVdN/rRIbsNjDIzEqOs9fK2Yj1qeITUD86zaDx41Dg209I66v5vhU2aP5pVJmQQmtQWgzNgGlLgzCVoFd7rBg+/n8U2J/1DzAtpn2vXXnWeI05W55KG8JOMZjpiB+/LSa7iR52e1HfxbR8YrpVpvbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SctNo6F/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so2149826a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301961; x=1762906761; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PQOo5M0i6Q/NGE0WSQPjyiNe2YqX4cEHbsFV38mV+ZI=;
        b=SctNo6F/QsJfysFeTMPqhhPpAV7IGBx2K1OG8eIsnCRYkKIrnuBDycoLxD9FMCCAqA
         pIkC6mcmtPfeN8RYXSywm6Z61Cz5TMvBJaadQm0/4Uj5X9tT6gPEpZjnb70s5f/X2aWv
         nJzCxq4l5YsFP5MyCET4HlQvTigi0VLWJi6vA/qqHDXu6sbTayNX0NXlgd4OtlKU7IWv
         OulFj+4jNiVq3jigw+EZTz44C13gxv6x8YP89EhgzhgTHlcoo/4t1eNdTMtWVK8wAhW5
         Z+QqfqBZFmEFaWdluwRGnN+00f6l47VZFGCIbQqi9JbxjaKUef5IOQXxSLTfdDGJew1D
         5dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301961; x=1762906761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQOo5M0i6Q/NGE0WSQPjyiNe2YqX4cEHbsFV38mV+ZI=;
        b=aA0FIH6VWY+od+wuN6610gpRfWT5WucrkCh8dqfXI8+y2cPWwXGvaq4JGDMPu1NrgX
         Y9uR1GHKS3Gy/HGolA7430BG8YFBuynX0baOqj7K54/a2M9W2VUBkb7T0DAZeutOJVZR
         SmeSdixV4y98Wr6jcFdjK+0YYLU/EcTnZldV4uqBd68qDGGNetZsrZzTLyt3i3Rdr3Y9
         s7jzlQppG2nM54i1VwBmbMZHRYRRz4Yeo1i7Vs534JKL+RgtM4vMvVDA9AMmT4Jn6hWh
         GZmc5U0CPDkN/BDT2XsGVJgtOfCkkeA2rlp6iaoGXsyyTlN3v4wZ9Y5qReXcct3L+TF3
         aPvw==
X-Forwarded-Encrypted: i=1; AJvYcCXxDStWv3oYSF1mfgTxOIHBgQqW2kOk+B/kcGwBaXqUQffVU+cZWHm9U2LxNEIXunMug8Ch8pt2SS+wRnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTBqSnLNK0/8+vetl/+GZjPs0v2GieCub1tRBXDbaCBR+bfac
	bZXNGrr3kekZWjlDNSF2EenDUdWy82fRTeZJBcM8cw77atEKwfjjJjTb
X-Gm-Gg: ASbGnctXSVei/slsTMr8B/rxRrORgVR516AZCjvFY/Ns/p88Cs//SuJWj+RRY/IeUFV
	luDehpahYWheWuDP8aXS9Fh/CQlhzIFaYbVP5npLoeDMlYuIUfwtb1r3xJBN+RN245rCGc7xCRW
	j3zol99S78E+YgqE1/P5g2UbRvQj5z/muihQymWneleNJ9BWZ2GCuYxybXX57RjBw+AgI0ecvIN
	025CtQEsPxY3/UuDPNn3Q0ekleKFcZ0w12A9AAKk000KiB3NraJ3I1YeU/Vc7OAhpQsQL1xoaSG
	5AYjm10WdvlKxj7p+B0+nJXGwbWwmCcBOJ2tfgJhvxZh1eox8AYARhJCettZCpLRD5OPBEAvHBk
	Sw1lzAOZZSmFvlDg0QEh3v09y0mRHUl3ZqCHCHHOkWodaI3ViksFvaTley11+UuShieho/bsd1s
	PlUICQ5OVtzd0VGDbPFClXOqI=
X-Google-Smtp-Source: AGHT+IHD2NG1fQ3xl98wFzeuOQRvtfU5I7A4mP97EoxmWWPr5Ongqgmj+Ju/4NPWI3gyRmGoE0iydA==
X-Received: by 2002:a05:6a20:f20:b0:34f:b660:7723 with SMTP id adf61e73a8af0-34fb6608efamr518592637.48.1762301960948;
        Tue, 04 Nov 2025 16:19:20 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a710asm3616987a12.30.2025.11.04.16.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:19:20 -0800 (PST)
Message-ID: <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Donglin Peng
	 <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan
 Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 16:19:19 -0800
In-Reply-To: <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-4-dolinux.peng@gmail.com>
	 <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
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

> > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf, __u=
32 type_id)
> >         return type_id;
> >  }
> >=20
> > -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> > +/*
> > + * Find BTF types with matching names within the [left, right] index r=
ange.
> > + * On success, updates *left and *right to the boundaries of the match=
ing range
> > + * and returns the leftmost matching index.
> > + */
> > +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, cons=
t char *name,
> > +                                               __s32 *left, __s32 *rig=
ht)
>=20
> I thought we discussed this, why do you need "right"? Two binary
> searches where one would do just fine.

I think the idea is that there would be less strcmp's if there is a
long sequence of items with identical names.

