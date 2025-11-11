Return-Path: <linux-kernel+bounces-896103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5932C4FA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42F13B1359
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC30A3A5E94;
	Tue, 11 Nov 2025 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6wvzAoS"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B13A5E86
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890872; cv=none; b=X4geUSJePhGc90Jwy39nH5bVRxMuM6SWN2yGpKaJLrj2k661S6rNq2bNFbpeUKbdPsRFf/NZABXX8TKB0Ay+crQM17Xz2EaJUaAmA/c0ASDDVwhxWSRIlqR6NrGubYZzTK+cyCQTVaC3dUCi3mii4dzv8cEwpN2obDsPkoIEeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890872; c=relaxed/simple;
	bh=s9+a/eFiDoDkgzy9Ul2SUezw6cD2/LMwGt4BI4jMuWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axDwPQ7dS9S2p/YVSPx+nQxUWwuqkOwUKBY1T6i3tRMevq4bljWPtpffuRxfiU0Nt2Rg0CKqL4oZrwhWbcyTlg6gd8HPkJgZoEF6FgwssgSHYLjcWEnaWc8nTsPexOtS9BzRH8auToF2dLhz+xreLXtrAaOrkrQvHPkPTBNkfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6wvzAoS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297f2c718a8so72335ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890870; x=1763495670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9+a/eFiDoDkgzy9Ul2SUezw6cD2/LMwGt4BI4jMuWE=;
        b=U6wvzAoSkY2k15T22W4yOdF48wWhxYUep8p7av8A+5FJXJeWTUfLdLpLZYKS3DLqSR
         iSVHdagTiJyGuZXe+WARAcFHhC+0fR56yDkUJGJb5AK2UD4pNQJQbBuhH2zZe5gjO7NB
         gqET0z+VnG1o+FsVCIebqUAQ87rxaPs9jgTU/5Uq0DG6JaYxUbLlHHNYfv/M3IfeiAnb
         1t81oYQP/XTjyjHCeP6xYbBFGD3ECIHDagyZ0xG7wiOmSF21DnbIkB/txTDO2M9Anoqb
         0fxlNU5lf8EAXr6okY4e8iky2RpUwSa87yX7Y/tATPtUyBsy+9bZc8NF5hGPdxHa+l5S
         K5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890870; x=1763495670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9+a/eFiDoDkgzy9Ul2SUezw6cD2/LMwGt4BI4jMuWE=;
        b=j/2EFQ64F/IcAy3S3r5oHa5XWB6iVM7XBxIOXCJQ9lVNN4cQ/bZ0yP1G4MHSMEjNlU
         bbgn29yKGfjrFKkNdvUXoxtaERo4PBkTRKxyCFI7jPv0fjiqiR/c1JRSOtFE91Y2sE07
         046JpiiRkIkfHcZjqYr2amtONrYjW0L5qWuOu8VoY/hchMfr9mgKFGTfglkhCiyi6Dcd
         HSJT5/TkoPgeJA7M1fnJFdkqnt3JfiwlTaFDUrrXBdf1sFdthIp/XWD61qZo49Eufi1d
         psx6N4afNP3H4khSj0zUVZFwNduc/RVnpLFzTCiwEKxULTsdd66zx5gOo1V+bgvM2dcc
         48Gw==
X-Gm-Message-State: AOJu0YytoBtTANqxpTenmAtZk92YOYQ+J4EWJm51LbnTqOvLak1sv0r6
	ZWxBBA6UepHRMyfLtmZVJWJRh7pxitiNRVFMzc82L3HdTQUhW3GuR2b/n+pz4jv9ABZg3jgueD4
	aLDLxfCym5W71d9875bJqC3jyG8lt78c=
X-Gm-Gg: ASbGncvgqYOdpBBDZxIEtP1PXEixZR9oetv45qDuaThG1zFBrRQEpeqqhDyxcElLdMw
	Lytd1SQCemJXX22D4eqJLGSBAYYzFGExxsBylvqR3/ICbYyA5BUZBReK+12UOtq+3uqecRfQU6M
	otnCQNw1RS4EdAeQ4Qzs9NMF/whaAAMK/Yfp+wWBkPat3PvTtPjLfFFksnPs8DNlNs9YBHXzSmu
	dC9AsA+ccZ3kMMuMKgdaxgGB1BBnvwVYDcndQqij1q0qQ/IZ7PLHIKRHJr+fT39rsEfIk+K0b9e
	KYK+KATZ6SAask/U1rK5/XFMWRr+Jk6HgfBByZ7pQhYGfr+uad5ZYE3gJFLlGjFxeLjpV6gO11t
	t8G8=
X-Google-Smtp-Source: AGHT+IFGIw0sPldyd+rtRft0su885bkTxqqUTUuhpd3lcLBUxXPnk/ZZeeLUF53/y6iwwN8RrfJVa1Wt8ImxuyYODE8=
X-Received: by 2002:a17:902:d50f:b0:298:371:94f1 with SMTP id
 d9443c01a7336-2984ed2b38amr3798265ad.1.1762890870059; Tue, 11 Nov 2025
 11:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111171315.2196103-1-joelagnelf@nvidia.com> <20251111171315.2196103-4-joelagnelf@nvidia.com>
In-Reply-To: <20251111171315.2196103-4-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 20:54:17 +0100
X-Gm-Features: AWmQ_bl0L-0Cea_Wx26TMHEqrDOWgYHY0NBpoDZ7Qy4Vo4Y76uHd2eVw2Y9spcU
Message-ID: <CANiq72nuHUFGMsEYr-KhCB4oMjX72YskG0s7uCB8dcVtTGW-jQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rust: Introduce support for C linked list interfacing
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, airlied@gmail.com, 
	acourbot@nvidia.com, apopple@nvidia.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	jhubbard@nvidia.com, ttabi@nvidia.com, joel@joelfernandes.org, 
	elle@weathered-steel.dev, daniel.almeida@collabora.com, arighi@nvidia.com, 
	phasta@kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:13=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> there. I rebased the patches on linux-next. I can also add MAINTAINER ent=
ries
> in a future version, if folks agree this should have its own MAINTAINER
> record.

Yes, it sounds good to me to add one. Please do -- thanks!

Cheers,
Miguel

