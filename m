Return-Path: <linux-kernel+bounces-859435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02040BEDA53
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 21:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFA119C13C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD65286D4B;
	Sat, 18 Oct 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AguFkXrg"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C041DF73C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815588; cv=none; b=ApBNm4vSqMSha8YirkfaUV039kyPqg6dl4JmuCMSHbSK/1Fn3BVFcPgWHSCVmRfxu4z9RFR5vWyUoPOLYcpsYbRYHyhQIqBhubpw4lrXAI1RePqTwGspJSuZj4+FixOnzoAHyJ8flG8VEcsSH5aAhGuo1IYBEyFPWTlvjviipZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815588; c=relaxed/simple;
	bh=maNTnrE3NTYDgn+1DZT+tzJ/tqBln8UodmRQM+56owU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcgVsGxKKM9h3vQJh3ms9v+QQJlh5Lb80YA1j6QsSRTsXczvoy2ntAI/v4UJAqGwCffvFP9H/VWDfvSHhasyKEwUIh963tm9GtpaycAwaimMQC4hGltNXyNNBxH8Ze7dGaA+JTjoNAUUyI365J3B5kjOBmxO/c7tpVFtLy0ClYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AguFkXrg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-280fc0e9f50so4699245ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760815586; x=1761420386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjuivMCtlxL8Odir1CwO9q/tKAJWL5tIgtF8E3+8n3Q=;
        b=AguFkXrgmAfQVGth2z0pFbzY80lacRmV3l8DmzMIH0hKoqbJ/ujDw5sPkt5lQjhr03
         nloaLmpTWkK3CZyX/VQVf3B8V1icbB0pGE0SR+HSJRSgir23mv0Ba0w3f0g+X26tTn1U
         aXn4VNsCcUVIb2e2LvFM2nUP4NOnrpdz3o69N57FBw2c9j4qzGits97KWjzoQ8nztPNG
         rJ63fWdmdhf0/Gakxo2OLaqt8/QdwlHqIKbapZ7G3q0CICX5oieKPK19BCYqWxyu1CtG
         gjTsuJk6Cu0eDNAhw1YUDdOWSCwVJu35iOk61Emgcq4nSTgcZSC7crS/8y4gjA2xsunL
         ttVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760815586; x=1761420386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjuivMCtlxL8Odir1CwO9q/tKAJWL5tIgtF8E3+8n3Q=;
        b=WUwN4gHxojRAlRpnp7evVBgRDMYpZYc7M/V2Q4WI5GwksU1+k16RDdwaKnxTJaUJix
         CFKYtl9U3nNJBT6z3gp9RgnizQNozoHd2lLq4GMdjdf1wJ6hza3qZMt0BIgbrhNtE3IH
         RN6YyL6lzN9doCkT4IAOxJ0seQRA29120RNjuxVjmzJ5bg4z/+r6oqjbGC63H7lU24fY
         agJmBIsXBc9QgNN3+QsNM5j3tx/MDKWJhq0dSAz5jLcVHs9DDQ75nSu6HcpXhCg+uosW
         SXfSinBDLQVUhOahaGKC9eu/PtIgB96ephslhZKgDogRhR6DL/E4Xcn4Yb/oKWcRHB5G
         GpBw==
X-Forwarded-Encrypted: i=1; AJvYcCV4ms8Do7d+Omkb9+eeTCRRmVMYjHZejpp4vzy8/sjP7Qx7jpKopYvXuWGcIAwXaz5opdDhHE7w1JBFTd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1zmt3NWvrSnaY30ufINlm2sgmz3NSaGZmS6VbOEDDFtOCb8e
	qhCQjSAPwSG0xfGiYlae8Q0svJRVtzWG7DXUDo7hpI5UbD78lrZH9V2Z2senoWkG5Ljq7C1hSBV
	cqXHI+ozjfxZO9NwA9aDRcNV5Hp9aFocmXOj7wcc=
X-Gm-Gg: ASbGncsM7Ka/3cCj+fWnFPdLanbn6GWp9RSt9HQyx+al5c3fVpSzyE8AxnlChCw9faV
	292SCmy0IO+fYhDhQDopgA6hriboSrsbwraHbcrH+ExiUKrmh722heiX1pErITPBj+VNSBMyiiX
	WpmC2GTr3oEIz9rbeqgieRPSbrKFCtlxAzhdvkvkNprlZSd6//3OdN+YSSekP6IdIcLsG2ydmYl
	JD2+dCgePwbEwAJVYwK5N1SIsrMH7xOxdCF4k8hbEbR5B6fjUfAxNNu0+yad8nKmyXvcJnoh6k4
	AqwYrI2QipmSCx+Xe3CNYp3eVMX2D2wEC6tdXyWnyHovSq0K/oSU2DHEbQGKgA7mfnZgou8ea54
	o/yQxsq/grCpcQw==
X-Google-Smtp-Source: AGHT+IGBenTbySBBctY/gU3QjDp3HFJHtBEOAUS6R2+K/P12LyE0SPg5Tcul8dIxRRcnUwnIEmZN66Tp9vXAnJJ+mww=
X-Received: by 2002:a17:903:1965:b0:292:64ec:8f4d with SMTP id
 d9443c01a7336-29264ec9324mr8035715ad.8.1760815585753; Sat, 18 Oct 2025
 12:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016211740.653599-1-lossin@kernel.org> <CANiq72k8KmpFyKAFZ293GDUWx5=HJtksR02hTU8-H9PX7xsT+g@mail.gmail.com>
 <DDK2SA1D77HM.38KOTOTF8FJXI@kernel.org> <CANiq72=Qh9sJLKwACr_McnbGdu8JfzqDuv1AgCjSdwKtt-9Gdw@mail.gmail.com>
In-Reply-To: <CANiq72=Qh9sJLKwACr_McnbGdu8JfzqDuv1AgCjSdwKtt-9Gdw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 18 Oct 2025 21:26:13 +0200
X-Gm-Features: AS18NWBrp4AFcrQ0jkZEQ0feystw5Iza3W0OYwyAWi1Y_FxdNAfDUM6zbf8CIl0
Message-ID: <CANiq72mj0L6GF-aebUcezeAD8iMV2mP-ZSn27ufKqQQiTPQajQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pin-init: fix broken rust doc link
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guillaume Gomez <guillaume1.gomez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:58=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> In the end, it wasn't intentional, so Guillaume created this PR:
>
>     https://github.com/rust-lang/rust/pull/147809
>
> Thus 1.92 may end up without this change in behavior.

Indeed, it just got merged for 1.92.

Cheers,
Miguel

