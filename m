Return-Path: <linux-kernel+bounces-808750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CEB50447
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FB03AE937
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A20308F0C;
	Tue,  9 Sep 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZdHAeo6"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2F17A300
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438291; cv=none; b=s/Z5YSWQ9NtZCQZnAO7cK0yM15Xck1yyOgaseErqCjd4d7O5oUVUFYNCe48boK65mTIqmwomQmDAe5Sda5/2l3g++kx/X4smHN9bxwot4oOwmHVnviJUVOwrXa38+uwPWe+5axB3HG/5CmyNfwyCAqH7kTqehDe/BKHO0U2vOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438291; c=relaxed/simple;
	bh=eANuCz33lH1bMwsj7oCJ47IYyMj8B04J6bOmhdmvkOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBfiBHXo4SR4BlbR2fGxZtk60kImuDJntzDh2Dxs+6A2I8S7NF8zeiTw7W8XHkW2giU8dgh0mlGgosSeNlrip43x9Z3J8QPG4m1XPhEXAFrQ6s1RShcFri5P2EgHGVmGdcnQ5ZGrCA5EwXPylSeTZFpJseEkA8fqHSe89VHTHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZdHAeo6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b7e7e81f6so523291a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757438289; x=1758043089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eANuCz33lH1bMwsj7oCJ47IYyMj8B04J6bOmhdmvkOs=;
        b=HZdHAeo6jft2YL/jmzfXkBErUCLaVlF1vBhemzMsBp85HUzujkGiA1NPDcXZZYZyc+
         R4sz0juItQ4ZlAuaPugh9xe5SSa0eVYlF78AKOJqbYfOU7yMVs9UC9SGi4fajnta+MFe
         ab43cH53kjj8K8klu5cgMrxnM34c3xtMrLOewYpcYNRTNWpDvTkbnZ3GgaEXU4uPl8Lm
         MTlNLG4qu5ODB0LArv44HtqfpboYGLUpZvKlU7ERi89oo39zX4fD/8zY4SddRYqq0M2h
         PzUJU47oEoZzjaqqv5qcjfGKVl4e6FV8Uzdt4LwnTamiSQVKa5q+T3eBaGm1XEEZzYAE
         nIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757438289; x=1758043089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eANuCz33lH1bMwsj7oCJ47IYyMj8B04J6bOmhdmvkOs=;
        b=RtGvm21c1bxuIae5OXLWoY9nc3kvkkLTzmwO/gC1kZ4QagjNuiabAM8ow0htzNh/CM
         C48mGaFWG2fmYsS9lj88SuAytXn1jimBx1KRM/wby8mbo+Nl9zQFaBNDrlIs00awzFRo
         5+NKQE+3BPSJMiq6O+SQySgdlZIHboScK7sLuyNhEGyi3EnLGQdv/6EIPl7mPxBSm25C
         f4tT2uwZJiPbg5GZLop7hGOzZLPyFjjJ50QUAyzvnBc9CGStLXv6VZ6kRth0AyAyiv4I
         slQZy4A8Cadc7QWoCIzL7KdhzkCcvWmvkJ82h3P8jmY0h5wBmEorahQ2Jlilb2Fl4CeH
         9Qqw==
X-Forwarded-Encrypted: i=1; AJvYcCVA/DK7vQqtVt3OuQHAehuRVz6SuF8Cid/RtYbaz9InDtCAuPUoYNiOsjqNS03emc3htlEmCXAvbxiOK8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mJ8LoVdbMhyhceI3W5b2fw91UC2fnqJAolnrJsJU1QeoBOnT
	526B979IEVFzQvmo7c/zjtd/Ayv71HlmrsEAQXTm6m573KjV90cLCEaaoZ1jTq4EX8IMloOZjAx
	cUMSajTF1n4+oGkfqNXS7zzuUoONK33Y=
X-Gm-Gg: ASbGnct1z7bX0mj9BRcQu6OD2a5Iuz9I90I0rIKdbsuF/MTr9yiR9XZ39oYPsf8Cd8i
	2kgDZctjBgoOmhz5nhLp81jkcIUo+uIL2p0p3BY3y/PZ7+L/AKSnNHaKwoBoi4JXYyCN8EYVGKH
	Gm3xFqk9j93Ey0W+/hvx8ZLFz0HfM7ArINoNBGA9kZzeqyciQ+Vhn008o9k2fgl7CSUV+ZFToRc
	IQH1iBs+7vAYv9x8UGHALQ2X/unzO/hLBmaM2flonRtrklRSEVceb9FZy2vygVgRHQgmT+SRDIM
	HEBfSaf42XzoOUiSo2EHhPcIWhZ6mx1HopZS
X-Google-Smtp-Source: AGHT+IGZvxHwMJuJTTKpdzQ2seSpBVyMgSszDRBCdloTBJkjA+PRzY0NWCEouBfzawrB0YlxcoPbJsyhaKtUMdZErKs=
X-Received: by 2002:a17:90b:4b07:b0:32b:aed4:aa2e with SMTP id
 98e67ed59e1d1-32d43f8eaa9mr8987250a91.3.1757438289039; Tue, 09 Sep 2025
 10:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909170013.16025-1-work@onurozkan.dev> <20250909170013.16025-2-work@onurozkan.dev>
In-Reply-To: <20250909170013.16025-2-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 19:17:56 +0200
X-Gm-Features: AS18NWArfz-SKR6eBoIPN5tsQPjXO3WdMRNjKjDTQlv9bzevnMWFofEbcB04VyM
Message-ID: <CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original value
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com, 
	tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, aliceryhl@google.com, 
	a.hindborg@kernel.org, lossin@kernel.org, bjorn3_gh@protonmail.com, 
	gary@garyguo.net, boqun.feng@gmail.com, alex.gaynor@gmail.com, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:01=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.dev>=
 wrote:
>
> This patch only fixes the callers that broke after the changes on `to_res=
ult`.
> I haven't included all the improvements made possible by the new design s=
ince

I think Daniel asked in the previous version what you mean by "callers
that broke" here -- it is a bit confusing, since it seems this is a
fix (and thus needs to be prioritized).

Is that the case?

Thanks!

Cheers,
Miguel

