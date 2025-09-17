Return-Path: <linux-kernel+bounces-819813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6579FB7F4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0139B523011
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304FE2116E7;
	Wed, 17 Sep 2025 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zze9Nx/y"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6036ADD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071345; cv=none; b=RTSg/MqFSm9UagUEC3l+1/GVqFCiX0cP+jQrgosuugRRoTTvr5zWJdt1HKjVY0RovlXV3V1RfHwUEQnulZ7/fwUzyiToSIoVWO67oupcDRxTKIDXKPtM+lExS8gcbGWtiB2vqLhp1wagMu933DW9G8dPf8IaoAiE/0SE7j5z7nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071345; c=relaxed/simple;
	bh=BUtYNeWBlf5QHi+IaMjeNB93VcPuCp37DQN4gnN67q4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MShndu25Op6WzcToAMwORqa3JTVnoTFt9Y8z36NAu+jgwwKCebQ43U+9Ku5X9w97mV3/cpLeyUIn5IZhacqNWdGM4z8iTG/zVjgyQXKVq7dGyv5Bo+tBty3B8s43I96JSOTkfvKee9hSIl6MFqmsiZ9JYsiH+5DRCCW2XUbKFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zze9Nx/y; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-72e565bf2f0so47090927b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758071343; x=1758676143; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aANTVr5axolQ7BbjwnLuDvhkzbQohdfLxP4+qHFFkZc=;
        b=Zze9Nx/yMv9i9K9HmyB1tiJMq42YlgZCe/4u7vPBFeAshXaqGPcKufgKokFr3+TtIY
         Ri8PZoQpFKttoy6BJP9oDJeB+PwMCwIrRj5Ptm6s2ucSndS/mT+TCGfmRxZnJZFqRlRi
         XTOMCZMvAh3RFTu2cFnNCz6VWWFhWp4QBqm9UyrjXBrZelk1Hpsx/tGmx5pYgZbR/F+d
         hn9RvIl+dnzVLPHusZgqfydoN5JYI/MN4gtMzjq5oBycVQs9QwCw0b1ak01RhX2VWKLH
         XfO1ni5D5TrQdBMOv4WCYU03TiAqaeQEA7k5IoDi8KTIZjq+/KUjO3T+e51IbQpzo/Rp
         OtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071343; x=1758676143;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aANTVr5axolQ7BbjwnLuDvhkzbQohdfLxP4+qHFFkZc=;
        b=ElZdjtZ8Zq+dQ18Spd/aYAGS+5lBg1XT1GBnEKMXz3P4nd67zxKpAbQtGOSD9GdhoQ
         m5UH4/uD5cUHGzW+7w0eKQvBb6huWrTKSCr00SgYmy5Qm0oM+eszEGcfdAoqxFdYZlPw
         lzQrxbj1IVoExeO8i8m/4qj7++rZjgKlvW3Desl1WroRU7XpAKY0JsmckEqYi2itiff3
         x5s+HiBK9H2rIoBsFntJDJZCcwiSNcOD9pXLZnVcz4EOyuaRSQnURGPgos2Ub2YSVwZZ
         bN9kyGgrRWoMa+bDhXAk9RaTl0gjdiHJ8TNEkbO0OcMhOK+7xtK93WkF/u6WQc/TPv9H
         PaCw==
X-Forwarded-Encrypted: i=1; AJvYcCWi+vqNTuIeLf4Ej9vBc8sJsZDoVqAirz9rKS4nA1pfiaOoUimCbQ3FsvpqtbF1LUKaqMuZC4nws3e/HZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2B9ufNNgLkXHpYUfxp4VAFyirsrzQz3zGNblJr60naHGdYISj
	utQ+dEY3SBFQ+eGXfnjtwBp27WFmY+e9DGcS5zj2cSfkk7w1H/JXBK0MNL3A/BLzAw==
X-Gm-Gg: ASbGncv9V6bg4r3lMbHgTY3RHyFOvOjBJGUVceoV0VM+ksvi+79ehuxAy4igVmpj0iK
	vfNY5VpoBbMANvbwIM4kyXCMkHaoEVX9ZVPn/Kk59t14YStM6X3ShR804e1VupSzfiDV0bupdvm
	R4aah4s3eustTEAmceBUHzS3tOi5kbGuNTIkrdni65P+ZCO2UB8SCeH3Fkzmb6HdMDVKyEntMus
	TsWZdxZ3A/pYIuHDSes1juNJDrmbaYScHk4QR4q8gASK0MK87id9U7nxbpRMi8SlACn0wTEy0ZP
	ICDvzv53f29+GgoKEPPjrD9SDETIfOmxxAl8cbHvm6sBrdF31VpO9vhEfZituZn1HrHWFtP+6EA
	Yoxacy8HeBqnhQtyEz1GZSUcM9+vvhPybriIZFwYIK/XvQ3lIvkB8lZ6ehyuaZpa9EnOs+Congk
	6U/1ubOI8lJLjB0XeR/FCe7qWo
X-Google-Smtp-Source: AGHT+IFGR6+9Hx1aPuBvMpaobAq/qWl23NruMocVjrvxvIXrOI6tSCiwuhhjzQFtoMNgnRtW9cEMWw==
X-Received: by 2002:a05:690c:dc3:b0:71f:b944:103e with SMTP id 00721157ae682-73892c5726emr2575027b3.47.1758071342433;
        Tue, 16 Sep 2025 18:09:02 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73266fe1782sm29375867b3.46.2025.09.16.18.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:09:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:08:47 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
cc: Paul Moore <paul@paul-moore.com>, Hugh Dickins <hughd@google.com>, 
    James Morris <jmorris@namei.org>, 
    Stephen Smalley <stephen.smalley.work@gmail.com>, 
    Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
    Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
    linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
    selinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
In-Reply-To: <CA+zpnLe8Z=2qY3rVCyZXyGPOaO2a0V2BVrdMkuwKs789igGCzw@mail.gmail.com>
Message-ID: <b266fe61-7a7a-b13f-a73c-f30f5edc22a3@google.com>
References: <20250826031824.1227551-1-tweek@google.com> <6afc91a9f5caef96b2ca335b6d143670@paul-moore.com> <92255d5e-7e0a-6ca3-3169-114ae7f6247f@google.com> <CAHC9VhQejS05C8AExkh32GidBdzXjauKPP6T_3eSGZDEwfwDuA@mail.gmail.com>
 <CA+zpnLe8Z=2qY3rVCyZXyGPOaO2a0V2BVrdMkuwKs789igGCzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-746452338-1758071341=:25424"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-746452338-1758071341=:25424
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Sep 2025, Thi=C3=A9baud Weksteen wrote:
> On Wed, Sep 17, 2025 at 1:26=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > >
> > > So far as I can tell, seems okay to me:
> > > Acked-by: Hugh Dickins <hughd@google.com>
> > >
> > > If I'd responded earlier (sorry), I would have asked for it just to u=
se
> > > &QSTR("[memfd]") directly in the call, rather than indirecting throug=
h
> > > unnecessary #define MEMFD_ANON_NAME "[memfd]"; never mind, that's all=
=2E
> > >
>=20
> Thanks for the review Hugh. In our case, it is necessary to expose
> MEMFD_ANON_NAME as there is a string comparison done in
> security/selinux/hooks.c (see selinux_inode_init_security_anon
> changes).
> I would argue it is cleaner to reference the same constant. The
> alternative here would be to have 2 copies of it, with the risk of
> them being out-of-sync at some point.

Oh, I'm sorry, I simply misread your patch, and thought that the
#define MEMFD_ANON_NAME "[memfd]" came at the start of mm/memfd.c,
whereas it's in include/linux/memfd.h just before mm/memfd.c.

Yes, you're perfectly correct to do it that way then, ignore me.
(I do have to reflect on why three instances of MEMFD_ANON_NAME
are safer than two instances of "[memfd]", but you are correct.)

That does lead me to look quickly at the security/selinux/hooks.c
end of the patch: I don't particularly love what I see there, but
that's none of my business, you and Paul have constraints to meet
there which I'm entirely unfamiliar with.

Hugh
---1463770367-746452338-1758071341=:25424--

