Return-Path: <linux-kernel+bounces-853046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E82F3BDA896
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25D41502F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464E1303A04;
	Tue, 14 Oct 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qB6KQbPI"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF62773F7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457402; cv=none; b=A7GZLe0eHarEN2Wddb3YdlKZr2MyMfEGq8wSrCQqWi2bsUkK3mcrarfMHQyIht/28sWfsYJs4jhIVOPOmB8z+0r4Vq4Yech6/JDB17R25lZHuEmRouSNJwcwAQxNZLhcrGYtxIZvg0RksH7QucZ1/LmUYD9Rk2qq1rhyBFC2L1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457402; c=relaxed/simple;
	bh=nunGWOtz+XGGBYXEFYvnFbGnmcS3tFQEGkEK14z7P9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdhZ1b10aCM3uODbys56eH1ypCndul+Owiu25/yav/ytxnvFQ10fHa1v3cyLaCLNfjWhIknqCs+k4PXp8TPKF2Dkj5IfKG4QdfAd2agGKe1oP5rEcFsbnhxD6D5jRiPkHFVBaQ+s1rbys+FHD8oOBAzro/HNrcMq9cg9SU/PVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qB6KQbPI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so37449a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760457392; x=1761062192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ71tNRhJ1C7d7gKrHFcOSRgM5Z5VD8Gv1fa0j4u7rs=;
        b=qB6KQbPIHvGZLs6U2VSTXvr2A926tAqRLUpaFKLASC2HwebsAV4tuyhPrsvm8OzuzZ
         gTWRT+VATi7dPOcqxtkW/eYMntzFcyYJXp4tDcBlcDBk+J9XCVcdfTFY11vOLHSiixlc
         rxH/4+UmX5XMuSTqGRH0YIRaKkYNT3XXyS65j7MQZCysTDKftSi/h7z73+GTNnd6k4h6
         n4hmEi+8sO1shfNPgoGKmJajsZ4ophXkNtXWG8AbB/KxFNTkLQUB/V69pPuZ4d4WgZSL
         QLM4uMxSL3TMUGrq4JB126V3Ek1TTgzktXm9tYXFLhEpKz2qovrCfj6hLAedBwdUO64K
         K23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760457392; x=1761062192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ71tNRhJ1C7d7gKrHFcOSRgM5Z5VD8Gv1fa0j4u7rs=;
        b=noMtCqROtEVVX4JS21VlEum1TRWa+TXnD7i7JwkkuT5W4HDlSKKTlkK1OOQr/wbZKh
         ZA/bFqeFO15ZvbGjyPlaM7qM2ijWIwhgSigPPxltE5j/viTqlOvI8RzJrFVWBJJZFACT
         Iim5znZA8WU0GbwOUzdunbhk4qrktqJNtvEJp+PizcuiOmx7ao3owwaju9gTIzN0qOyA
         zdMdNFp4KsKArFA+kizp4EgZIZPBIrJjDSnPhGUxtE2vZE7gGs8oTheI1ZfYf4Acd+G7
         0zoMEbpyz01Y8lqGLxc9xFUL+iP38tLdJe2VAFni+r/veNXz6G+ONYjOZeYJd0YhfjyC
         ubEg==
X-Forwarded-Encrypted: i=1; AJvYcCXrCdudOxFdeag7hYhJxFUnkJ4O9dclgfJBgmSj3dwRTcUSquoQW7Lqf+gX2Y7K4OCU2CwsuznQp2XGjBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhzf5w0LNiXIHT7ch/G6EoPmWoIs7CoWlpYDevzDJo/0egDho0
	FVW2gfbeaqm8BYPBCcsaql4MmLwpk2hXoPqGB1DcTB/w5KeO3WdtiVN7pwgyQaBdNSBKarrUsuZ
	z/DRn0V/cRLdgn0aJLJX7nBfsTxPfpvr2AXvy4gL5
X-Gm-Gg: ASbGncu8moKz5Xu6LEcWmGdLkBa/XGrZR+fnjJkKJqQrZdNUtTKC9CusJXGNUlv1DAF
	RSkWU9mwibCBWO4eIhuctXmGHT+cQIg9roy5EhVZgwTt2pX2gk/l3wIcwDGh1u0xu5mKjZu+PUj
	Uq6+wD+oVN9fObUzGupzm2PmqBHCVO3bRgL6+qpGIDv2+3+bwANTaX7L/0kHic/naBxfJF3/u90
	SALV3eILoJ7LWV799yZZJ4F3+CFOT3/5AgFsF4PHoel+uPmdVsu1vDOi+FkeQ==
X-Google-Smtp-Source: AGHT+IGKIV2Bi31oYcHwKI2YSzrrIbKf4rj3xHwGkR3kvGZh9Hy2J8pJL9RK0nSsdzque/SVaFFeuGeMp1gKigXmOjY=
X-Received: by 2002:a05:6402:70d:b0:62f:c78f:d0d4 with SMTP id
 4fb4d7f45d1cf-639d52ea25amr605212a12.6.1760457392068; Tue, 14 Oct 2025
 08:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com> <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
In-Reply-To: <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 14 Oct 2025 17:55:55 +0200
X-Gm-Features: AS18NWC0yNNk6h0sxtRsikFqG7Y_VQHcdMiPhHyUTg2KdS5Sjowz2_Kiu9CEWCo
Message-ID: <CAG48ez1hcvhoEt8b7wTX4kFq7DXS3HLF-9C8iGcTtVBW7V4b6w@mail.gmail.com>
Subject: Re: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy language
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Frank Dinoff <fdinoff@google.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, Sep 30, 2025 at 12:23=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Fri, 2025-09-26 at 01:45 +0200, Jann Horn wrote:
> > This series adds a "dont_audit" action that cancels out following
> > "audit" actions (as we already have for other action types), and also
> > adds an "fs_subtype" that can be used to distinguish between FUSE
> > filesystems.
> >
> > With these two patches applied, as a toy example, you can use the
> > following policy:
> > ```
> > dont_audit fsname=3Dfuse fs_subtype=3Dsshfs
> > audit func=3DBPRM_CHECK fsname=3Dfuse
> > ```
> >
> > I have tested that with this policy, executing a binary from a
> > "fuse-zip" FUSE filesystem results in an audit log entry:
> > ```
> > type=3DINTEGRITY_RULE msg=3Daudit([...]): file=3D"/home/user/ima/zipmou=
nt/usr/bin/echo" hash=3D"sha256:1d82e8[...]
> > ```
> > while executing a binary from an "sshfs" FUSE filesystem does not
> > generate any audit log entries.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
>
> Thanks, Jann.  The patches look fine.

What's the next step here - are the patches going to land in the
next-integrity branch, so that they will go into 6.19?

