Return-Path: <linux-kernel+bounces-813608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE8B54833
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155CD17DD03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DFC284B4F;
	Fri, 12 Sep 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sVxw6Wz"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF917241663
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670333; cv=none; b=BZ0IEfp33/8om5uAd3Fbnmwby9FiExzv/bEF8T6JiAjH2fj/80HxKkoCMGaddK9Ixc+NQs+9M6EUBuL0FsCv8WGWSZ98PXyKhlwU0nZQUCm+4QxCTS27mIBNCt/yddjQM1PF4G1fqXwesyxt/sdDqvJjGwZ2AdgawhrOKisz8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670333; c=relaxed/simple;
	bh=Mw1tvDfrEkD0vqRhNIGrI/cTTOsCCyJetHroo+JH5ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoQjnUsdh05rnbJpAiM0DRgq4cI8ihck+cfMjzg6ZMv01ndL434LjrwoCXyayRyR2ZXxLPzKS4yA7LeASPbn3rFKXkLBceL/SfXvr/Cf9fsVabblbv+LjxC7mP1CK8i4/rlRiILe3TXhdlN6fR/+A2cCDXfJ9kfJ+Xlg8nosbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sVxw6Wz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e7622483beso892001f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757670330; x=1758275130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw1tvDfrEkD0vqRhNIGrI/cTTOsCCyJetHroo+JH5ik=;
        b=4sVxw6WznNHYAWEB9WZQku8Pski1E/qXfN7LzbCEutRvOOyiNS1d5iA9WTf1Y+h5mN
         SEYg/m7irnh40Nn/4tW3LbMYkKk+Y1dabeSyv+0mvmaPs6S2fd40rrUjeTZF/LIND0zG
         EdyfoPBpdA+43bePs0+m5zPZtTxi49D+XZOLyGh7qp+u9cMVGYs6dBFhYAqScT4ogfU7
         76Nm1KQnJoz1Y9rvMWQCMjR+aXmSOmdqeBerH5LgDuECX5GMHHMyTPUzsXVFSVrbU2su
         +tLOwmjvi+r5mDFEosPACukgTFGL6TQQkMgoxibP5UVZgzRF5IlmBwpbcL9/y3qLlfc4
         q/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757670330; x=1758275130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mw1tvDfrEkD0vqRhNIGrI/cTTOsCCyJetHroo+JH5ik=;
        b=PVx8Mh91zHeuMfuf2XV+4D57mdHPgY+8mZz46eZjWSMwTbtMz3gtkvE+4s1q9xEYy3
         SdMV2jh6FMhwh8UceW6f+M+GA+1s9bX3Ypmw91S8s/ScCqpGa7gxLaCeFSwjnVkkcVDo
         sX5MMZBNrj5cr61K79KsW52UAJ4Wqlg4rbGwgH+06RHf2aOtP1pdW3f9r7s2JHfu1Xrv
         yCRHLP+RdQRQ3tfxV+fooJNBjDK55COk7TFF+tPwLmr26spJDZiZ+3bNHYsQAPFoMQOj
         1FwhUBU43NeAnQvnahXGz1I6G3sJ242PK/9BSleHBjxc3TcgQN9tcoxnMsqo2hhWvYFq
         AayA==
X-Forwarded-Encrypted: i=1; AJvYcCX3vY7nNn2sxcLuuVD08fF4yJotLe4JeZbkGRXcjV/W2chjBvLceh8N4XW7uoq6OVAaCIf7z2VIHRbW1xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasIYMMVSmmcG6ggrTp32CVO6mgvdLrOfQQioaGCjmpQP8mFbq
	KhgRDb7lEfFMdaUh/M8fz9Qpn14cfAcAZH5UJec7mw+Xe3/fRstr2qfI/nVaoz6NuPNBQDVACIp
	IqzBYDgT0TFvrux7YqZMvkGfMTaVTDA+D0KALiJLI
X-Gm-Gg: ASbGncsVuVtGLkK6H0IIV5aI37OP5Jl+msmwWBi3B1r3dEQ1vEm0J+ya3XmwKTPw/3w
	zzk/kRRmCh87jdPNiWuZ7DMUP7V6dwy2KVWLaBQhpDPZUapsjIcnnhUh4kMcIeXVrZ9YXHz5yAn
	ezQpY1GhQn5WZq8FdMZ4bPiVhP48uVNpSOxUSSdpmpdeFN/i8ECZLd0Ed7n51Ir2JEo9LPRob4B
	NBx4iVPxjdjsP6S2pE1ylTDIApyoNHOGeqB3ofsGziNxrDYvz94VKt14GH3r57atcLVL1xQ27H1
	OhpXkdKl
X-Google-Smtp-Source: AGHT+IH8Wx7aYDSjWGUDy5HYTHvs5te6PAR8YoJQwM/9F63oaFGwqOu/DLW2n7FD5zTPDogqXwQoXh14w7BRpqq3blQ=
X-Received: by 2002:a05:6000:238a:b0:3d4:f7ae:bebb with SMTP id
 ffacd0b85a97d-3e7658c0f60mr2359259f8f.26.1757670329961; Fri, 12 Sep 2025
 02:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911213157.GA1039411@joelbox2> <aMNo7qRCp_yprUAW@my-computer>
 <20250912025343.GA1376629@joelbox2> <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
 <CANiq72kZgZdU4Dut3rmcWT-cujyJaP_99ekis_XdfQ-7LmgZ5Q@mail.gmail.com>
In-Reply-To: <CANiq72kZgZdU4Dut3rmcWT-cujyJaP_99ekis_XdfQ-7LmgZ5Q@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 12 Sep 2025 11:45:16 +0200
X-Gm-Features: AS18NWBwf40JnAm6-b2l4TvNLfRabNDc0CxhktLrtMoAJ2-o4_5NAjP0nqdJ4vk
Message-ID: <CAH5fLgiP2DRcGy04YdsWS9+N1=_CCNEtAGrCn31vUHjnDLW9xw@mail.gmail.com>
Subject: Re: Printing with overflow checks can cause modpost errors
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 10:28=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Sep 12, 2025 at 6:08=E2=80=AFAM Andrew Ballance
> <andrewjballance@gmail.com> wrote:
> >
> > The pointer passed is const so rustc should assume that the c side does
> > not change offset, but looks like rustc does not do that.
>
> That is not possible -- a const pointer does not guarantee the value
> will not be changed.

I believe this code is using an immutable reference and not just a
pointer, so it would be UB to use it to write to `offset`, and so it
would be valid to assume it has not changed. But I think that in most
scenarios, Rust only optimizes using that information when the
reference appears as a function argument, which is not the case here.

Alice

