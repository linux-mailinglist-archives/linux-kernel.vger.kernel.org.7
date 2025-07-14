Return-Path: <linux-kernel+bounces-729642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9CB0399B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF80F3B9CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9F8239E82;
	Mon, 14 Jul 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUu2Bx0f"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D837464
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481937; cv=none; b=kxqjXTs9hVSQCIKcMz4gX8o+pMhYjgtL6udf0PtMFpjx16RHw2UrNewyWffJU9kg2+F//n+/LJlTtqx9iRAu73yzoEtjZDPDciN7yWOSOp5XojXHi2rhU/1ga9OyEsVLpZ6stxJ1j6qzw0KJ3ezuYPFloOvsmOoLAuZbaVtjAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481937; c=relaxed/simple;
	bh=Go7IxiOZ0sAIGTwsDe7Eg9RsaCUI0tpzXc8tbaNuhbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEf5N8doxzs/3lYo//dZCivQiSwSsw2TM/Yfc7kwdNpXxlccmxctFMfjm6u7e5mMhEKw26xFUdPKhJm/SFCMkmvtlcqFsIQbwNy9T2DH8KN2PES9prS08OFOjwe0c2l0Ck3Tad4MpOq8IPVteN1e5GlvJephKMlmr2qgMAARZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUu2Bx0f; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-531426c7139so1624426e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752481935; x=1753086735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0M6siWvZJnp6SHGUTLYeoItEe86brhosUCvwv3Sj6g=;
        b=gUu2Bx0fgMVQnH4Y1ljHAqjCv1zHmoEOhcp6agaqalw9P6C7ICT8uNgZjTNUWbWe1m
         TQOz4qQjemDi72079jxycHs+KWeFPmRaQcFqCrTkScpxvZdNtCe0HDNuX5WZ7jg6cw09
         lXfSMpLrY/ga9gg9CN1B97nLHshxtHLD1SPesaFbGMbL085X63ykNftroMp3P19JH4y9
         8EP1Y4X3O7Q0uoVM739r6j6oaCsLLSAkovEjlx0XjAKDnfn41P5zhvryD8xQZt35u0Uu
         JazFfjcuV08jq/Q+R8Sh9nfUMEncrw6ivi7M1m0MJKis6falySdahMZfiwPjZ/OUE7zZ
         oncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481935; x=1753086735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0M6siWvZJnp6SHGUTLYeoItEe86brhosUCvwv3Sj6g=;
        b=XxU7xNhn1M5FIs2wc2HX98XwV3osCu3Hf77e4whovzDoyrIO1Gah6VZ3ZmULC7LYfK
         skSgme4qDaPhzgY2w87uUvHGLVnX4g00FGe8md5e8/yp0c3edYuItRqeJs55obZyGt1E
         oMSwv08WSfqIqbfZEFiySiuFwo2QHGgkKaarn63G3dMjBgh+dtgZEWidnvjOPaMC2Xj6
         Bn+tRU8IZb1ttSsRiQA3EA15xPVE5/PPfxuN1FKZfiW41vcxNfZ39jpGIaHzDSotdICr
         5W/cqlETe5VhbVFgiGOKA863AFfNZjFOYFabbBke8FACmbWxX2FH2ps8mpvJiBHltoe9
         L/8A==
X-Forwarded-Encrypted: i=1; AJvYcCU2I/PvFzuI6gUtbFiTqdREapJFYYqUcRyS/jnhBPiYrhRgaYK00FP2cbkhvTH1/U0Q6+mWFQBYHNf4Nm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxawdnOnqVXr7ponyeDgpipKYqPn9t4vIkG9KOy7ljKA5YpwTkZ
	DVjhxU63O3wx9PzqEGTJFOOf81irDWTVeGUmL0yxM9tY8lkrIrigxfwMp7d8CZMaUMXi64fzvCC
	R14mzJHeVyjbybZBHyEwqJ2/CBn0bP3SfhZuaYuxk
X-Gm-Gg: ASbGncsF5z1eM9WRoeakDXsd8aUXZ+60orS82xEqfs4ltuYliBkYlitHoKXhVo93UwC
	G2DhGG2j8ilW4WHdSTcveOs4d6XPmnX23G6h8y+CAYwDJStJD5/PGW8IqUumqz5F9KyulOAeifl
	4Fp1atJri8H95Ko42fRR4+NaEI7Gb4itU2rnUVi46cYkM1drrf1nLtGF6inMbx6rqT7M9WmgcpJ
	CM0qY7z3y6X2+ofW4TQf4MpfFhZyRCK7XfruA==
X-Google-Smtp-Source: AGHT+IGclyUn0o5DxCYmV+W1r6lMYYeWyJ2l3l3YKph27RKIvJiE9F17q7jK7UBpfFkKyhlun6BZzlofd+c8jNIzjXI=
X-Received: by 2002:a05:6122:4b86:b0:534:7570:b68 with SMTP id
 71dfb90a1353d-535f4558182mr6039352e0c.0.1752481934473; Mon, 14 Jul 2025
 01:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711003502.857536-1-raduvele@google.com> <20250711003502.857536-2-raduvele@google.com>
 <aHCPDXonAevxkMho@google.com>
In-Reply-To: <aHCPDXonAevxkMho@google.com>
From: Radu Vele <raduvele@google.com>
Date: Mon, 14 Jul 2025 10:32:03 +0200
X-Gm-Features: Ac12FXwKEEUbGRgte43q8kv8Q9D0mBi3-qbFkUsMFkQsG4LANLOGjwjdka7KiXE
Message-ID: <CACKy9TJHtA5K2YqdNdnMuTvOsz4OCkRds4Hbj8aZdK5VXpMgWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Add lock per-port
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Andrei Kuchynski <akuchynski@chromium.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 6:12=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Fri, Jul 11, 2025 at 12:35:02AM +0000, Radu Vele wrote:
> > Add a lock associated to each port to protect port data against
> > concurrent access. Concurrency may result from sysfs commands
> > and ec events.
>
> I realized the critical sections are way too large.  What exactly data th=
e
> lock tries to protect?  Is the race possibility introduced by any previou=
s
> commits?  Please provide more context.

With the implementation of the role swap operations from the previous
commit (and also enter usb mode from another recent commit) we
introduce the possibility of concurrent access to the cros_ec_typec port
data from the userspace (e.g. trigger a power role swap from sysfs) vs
from EC events (e.g. partner triggered a role swap that we accept).
This is the main reason to propose a per-port lock. This way we ensure
we protect the state of each port in the cros_ec_typec driver.

