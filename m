Return-Path: <linux-kernel+bounces-863397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEF0BF7C74
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F08014F866B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD3345CBF;
	Tue, 21 Oct 2025 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3RF94Vp"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959D346E79
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065276; cv=none; b=V/wR6027gPYyYhVVA+6+5M9WvrhZLSQ9PR1LNeN9Zb4qxeo8MdhgviUofrVnyloufnhdSIvl/+PI8xPug2U4evcVwMaJdhf8arfo4TC+GiELHcp5BUQyXQc7NbJLcgEo/A4Ict+GKAXgnC5VtggvflhZEzpt/JWogj7iFza1Qws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065276; c=relaxed/simple;
	bh=28qNQ7rQ0dZK2hZ0bRbYpkKxEWOFNpR8yAeDonqWFt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhMXTjCmHE8TLMMpl5YMBL1zjzePEFia+ZPNrk+fMxI74XG7CY9rSBMBSAk7LgNJpuOxqpfTUjGduxqtU1PisMVpWv4xIiA8IlyMdxN3x2ZZ5F8m9T2a7eqpQsN406JgKrpjhVK9ICgGHX3+8ZyRs+4dN9ZFEqrFPA8o8kMyC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3RF94Vp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b67c74c7f20so299690a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065275; x=1761670075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1ntUXOmnFmu9OCpv+5ZoMXNluJmcwruKsf9+rVDB5c=;
        b=l3RF94VprvV6KITv6p+3Js5R4E5hsBVCrEeIEIq9uezdVSa5MnPxbfjYZovA5M7+St
         WZrlfzcLfakojt0grFSLMDUdPWLrwW1cpE/GBOwx3eEmtwmUFU9IViyB8Out+3TFVbj7
         1IyXXNgva09CT+3SNL+cxPvL3fV2dZsMfvcIkMHMVHX90hJVRAPk61i4Q5mpNkxVQwwT
         NgVRCt8SSgUNmRSDqyCrXS/5yylyA+hmHO8yrMNryvTxGuDYCfAKhbknrZSc7IohgP1Z
         KbVsdcPXiCOASCZBdXHjAMZuOag583xtsGjU6HoLJzT0WQs1/BOatJW4UmpOmv/rfwCV
         SO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065275; x=1761670075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1ntUXOmnFmu9OCpv+5ZoMXNluJmcwruKsf9+rVDB5c=;
        b=bvqK35Z/R/lI/Ebe6LTsprslV071sG6/uY3mZgMDljLsrvpOQyyklZS20FkZitvknq
         cKfIV4L8KYtVjE2vAqVVyXMbmVUTzoKSUfJFaAW4BJywgciSWWfVsh5aMuEIk79LvyIp
         NsxzwHZBSC9IxaL9wzggx6m131jq1abpGqmY0hwZcAPkY8jN1fu9vIRgsAxR1x+RyT2u
         U0z8EcJj94mMqxjWfXHRZqJBDEyI4V3NVsRbLh2hX7FeQorxKYB0aDxBSP3lfik8WKNd
         PVvlJEosMmFv2pSDEPd7slaJcZ2oYouDnKmuTDTuwjj2TQeNOsbjbwCgjwq/MvuKSzv9
         bP1A==
X-Forwarded-Encrypted: i=1; AJvYcCXJuB6Qo79JjouppXPggAEXT16R3DhixWOSqBw3FAzOTy+aMVOeHHMQgnz3GqaqV9984w2+scGIsFnsqXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhGK3UF6DJGkLQ9tDODr7ifyHFU+ltKIZ/nnI+eV+mNcRQMpg
	CjaezV+v0PF3fF9Ye6s9jfZiD7zxA3GGtDwso70Ew+FopnSeaXMs+rIyb6zGCEcxodqwBH22IQ3
	C2YZ62HkO1gcBJ9HRYz1wVoy65eR3lMc=
X-Gm-Gg: ASbGncvBFv68KGfR0LP85X7rNKEIFGuQDk82TUVUY3+pAo9UVt4A4BY9yNj/+u5i1/S
	IGcAA83OiHa4RpH12EaO8XGM654SnGwmqgvxW42Ycj//+b5hMglrv5FQn6uQ47hwZDEuMB3pNOY
	0cRQfXh9JfS8nxdhWTtlSvDwJYQpM5k/12ezyraEFf6LE6W+FPsYEh7/CePqVZK1nkknwwIK9vf
	BIgwVx+ZcCVWySiyQgh9YTFypdZUo9oQkzXx3q49F4X02JbNTt/6ZUXxafXVzcb2NgvXV5H7XTN
	O4UKpQdbHGqP/6OzJfqIV51HvxB5KxgdETX7t86LdQ6oOVxEWEFzk1JBALKkuZZ9PH0CjcGdk92
	CjEBW1/ZIEkhrDA==
X-Google-Smtp-Source: AGHT+IE6+zr2kq6R0XUbG0FThRLhPuL0rneOx9WE7IygbOP6VOZmHKd2PRk5rs9w/gQWQpmwElugiOYl8XVdOqXeB9E=
X-Received: by 2002:a17:903:19e6:b0:27a:186f:53ec with SMTP id
 d9443c01a7336-290cc2023d8mr130241865ad.9.1761065274551; Tue, 21 Oct 2025
 09:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-2-dakr@kernel.org>
 <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com>
 <DDO3T1NMVRJR.3OPF5GW5UQAGH@kernel.org> <CANiq72k-_=nhJAfzSV3rX7Tgz5KcmTdqwU9+j4M9V3rPYRmg+A@mail.gmail.com>
 <DDO521751WXE.11AAYWCL2CMP0@kernel.org>
In-Reply-To: <DDO521751WXE.11AAYWCL2CMP0@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 18:47:41 +0200
X-Gm-Features: AS18NWD6A3w6PR4fvS3IEgI9kkvx3dHP14ZgUtZuoQwDL0enZmy2MlsAuUPXLUw
Message-ID: <CANiq72=N+--1bhg+nSTDhvx3mFDcvppXo9Jxa__OPQRiSgEo2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:25=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> We need arithmetic operations (e.g. checked_add()) and type conversions (=
e.g.
> from/into usize). That'd be quite some code to write that just forwards t=
o the
> inner primitive.

If it is just e.g. add/sub and a few from/into, then it sounds ideal
(i.e. I am worried if it wants to be used as essentially a primitive,
in which case I agree it would need to be automated to some degree).

> So, I think as by now a new type makes sense if there is some reasonable
> additional semantics to capture.

To me, part of that is restricting what can be done with the type to
prevent mistakes.

i.e. a type alias is essentially the wild west, and this kind of
type/concept is common enough that it sounds a good idea to pay the
price to provide a proper type for it.

> Maybe the action to take from this is to add this to the list of (good fi=
rst)
> issues (not sure this is actually a _good first_ issue though :).

So I don't want to delay real work, and as long as we do it early
enough that we don't have many users, that sounds like a good idea to
me -- done:

    https://github.com/Rust-for-Linux/linux/issues/1198

Also took the chance to ask for a couple examples/tests.

I hope that helps.

Cheers,
Miguel

