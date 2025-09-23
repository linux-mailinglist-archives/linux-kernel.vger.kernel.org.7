Return-Path: <linux-kernel+bounces-829556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC180B97555
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEEC442163
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98653043A9;
	Tue, 23 Sep 2025 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmtRJBrJ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B126CE2E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655558; cv=none; b=M2Phlvi1l8/y9KVgFPUzc3cgMOJHktR88rvj7J+kdoNMc9ZqO3iKA/ZTiUlNSNnW92WbnsTuOSsmqnuIefM4QCl2rkpQvy6rG6HEt/l8y3M2fJyiIGhvqPPbVN3IWmGKPPB8SAAgiZh8Yas6nXh4NPp1NVtpbM+49wOJzAeAREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655558; c=relaxed/simple;
	bh=QGET12w7i7XBXFuWL5bz1REoMzgUFbmhweQM9vETKkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0G2NYyJUnpnjdxXJM1ebhdrJ1oy4rEqnJdzUkM1Idt2rnhqjrbbJm8PJpj7RQkmB9VzlQU6wffOVRTaH2G6u5ZZK9Wcl3x0bwg4bX1nkPiwBqSk3H6/rLkL3EGI/aSCh8JHdpTqVuuofOEYnIFbL9TMq9yBQ8KZeroJkxfmxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmtRJBrJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26987b80720so6405575ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655556; x=1759260356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGET12w7i7XBXFuWL5bz1REoMzgUFbmhweQM9vETKkg=;
        b=KmtRJBrJakIBXOLn+UIbJrOdHTsWTwtNabIHYCdLOJ0ZCkIauU75OEey6s3cqJkwvS
         6fwziCPj7Lb0I3LmjZiyxf8hrXCrY4FAQklLGDabbwQXnH+rSYjwn9usTsOAUOtBJ53Z
         lnLzukQcG9geDjl0XUvhwS0xgFlzOq6V2oAXeIwM57CVBoqnal7h0tWRf2xEBXw55NV0
         SWFGAGHXj0CZTWmHaSaf4cnzDnmiQjv4kofQz0A6T1pfk2nYLtbLsMINplDarwL9WSXK
         meSrUSsHXV+Lv3znqIq1kf/mFu3cgiGhSlOb5WDieBK3CerOBCQznHV8tPhVeeQ06vop
         dtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655556; x=1759260356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGET12w7i7XBXFuWL5bz1REoMzgUFbmhweQM9vETKkg=;
        b=dODEGtEHXC7DC3ZrAhyuEJL6RRoqcLQPv03H2pC1DH2nQ09aVULCLZ2bFus+XIzNwF
         6GoXmjUnusjgG150UiQcrxXAcc0YJunhV8DPiREoYla7oQAJxwl4ZLhC8TOAKtpWorWw
         IA4A3HfLRMwJVcvqOll9Dan0aWw/rf/lV0GHjuSWIYSlgtI/LF31v58iKhg5R6sa5TtZ
         Us+rH3k062eizOS3uGIM7+V1g/lRUrJEln8r2IMAwekyYapS0txToFvGqpbuGO3A9ECL
         m8iGYRI5cw55bMCMl+VAYUfSGQ69k2ozAbkwSudOhlfGFuJiG4DvZoFi9qmxLXY5W+DJ
         8V9A==
X-Forwarded-Encrypted: i=1; AJvYcCXbtjVVptdS/1jcl5wOVB2F7yjskukJx/re5lgiKSgUrbjObnJ4SYon4WyEwPDZad33x8bHkPk5homy8Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYC/laqHKXdNYzRmAb3Fdtmc1uYfIcsdl7g4+cubhI3+5HrN8
	lHHNeTkfkycvertN2gSjSSTISiHP/RlOnAmCJUmwxNDemprGxngVfjiinF1KQg6V9h2pyXExU+Z
	bQgVOpOvPGBGdm0hwBAsz05DsBf9s1Hs=
X-Gm-Gg: ASbGncu0bF5vuyIIWGx0ccn1ZXw/Ua4hQiLiVGrnnKfadHDtZU6nAB+euEfWjZBmAmJ
	mSJEtq6rMjCHk37l+FKHmcTpSv6Qe0ZmadGVnWunq6xZYoXju4kvv6qCD1kH+37aAF4gVyWoj9k
	VW65J/1LRu1CzK3Ij3rGpkzLnNRsH/fFEuzMyZbeiWYR7Q7skiLC7xiXzhmwbNZjy+fMyfREst+
	NU93CddyV/fk/h14jPFYZNzDYCCJl+7uCktKnQSAXuYVcIpHd5bXDcepYSCm7ZNIE9h1v4uOcny
	iEAin++cAOi4ewY/wW4vOMmiSQ==
X-Google-Smtp-Source: AGHT+IFSy0WlT1BAg3zYZsjD89CR/U6IXs4byyc/pkJyLwnuJ2ru8QRjSH9bFey8/JiECgwWevhMZ/QPBA5zdVq04MM=
X-Received: by 2002:a17:902:d48f:b0:272:f27d:33bd with SMTP id
 d9443c01a7336-27cbb8b9fd0mr27378145ad.0.1758655556180; Tue, 23 Sep 2025
 12:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNLN45NdHatkNUwg@finisterre.sirena.org.uk>
In-Reply-To: <aNLN45NdHatkNUwg@finisterre.sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Sep 2025 21:25:43 +0200
X-Gm-Features: AS18NWAEfe2HZAxb-xCThTaab7MFGromeGwGjopKxtKyCzeBQ3znIF3ZNmm9Vr8
Message-ID: <CANiq72kv0auCd_ZDgpyC-JYY1+s=DUwJ6NYt_XTCnKdZQ2vCmg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the drm-nova tree
To: Mark Brown <broonie@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:42=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> I fixed it up (see below) and can carry the fix as necessary. This

Looks good from inspection -- I will confirm in my CI runs.

Thanks!

Cheers,
Miguel

