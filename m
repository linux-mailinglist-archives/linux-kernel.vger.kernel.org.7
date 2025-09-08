Return-Path: <linux-kernel+bounces-805653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0E7B48BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9EB34378B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8499D2FE564;
	Mon,  8 Sep 2025 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5QHrCUD"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA81212546;
	Mon,  8 Sep 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330164; cv=none; b=IB1r113FFG+nZrlzruYbU4hNCSaROTrkW1tyasJxSbnpl5VLz6/A+I5S4mPRymDulfzSco/G/6Dyu+Xo7uOH8EydnOZh8FNHuUbAViSWcwQ2BjqE/xAe1l/mQDy2j++ks+q7ip//hyDYT5zrlT04VmhwmcLDXs9rg2TMHtLhnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330164; c=relaxed/simple;
	bh=JK9jU98tgHbmM1z5ZHenWrJxfgqVbpi7pczkbfSWkXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+K47AVPCN9LFJ25e013XO6OLXkGBxfTtd8bMPFYTXEguvzIqTE4OWwSxpMdwSzgCzXmZClRlBcIxh22Qubb/nv+h5WkeQbRgfOw7CZGTVrC3gkNkIj6f2uCKVkaA8YHkeq25ezdSGW9OKZx1gXCgmj0xbWLtTobRPPpfalS40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5QHrCUD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24ca270d700so11193195ad.0;
        Mon, 08 Sep 2025 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757330162; x=1757934962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JK9jU98tgHbmM1z5ZHenWrJxfgqVbpi7pczkbfSWkXE=;
        b=f5QHrCUD7Vaq6uZjVjhcKEURs/nXcO87qTWTEyT7kN9qKoW676e8+Ez+7YKyeD1T6S
         aqJOW9NC82xGtfwCzXTo/NXfkn3Wj+d5MmLA8ZHBznX76Wop9iZvAbILQZQKo9tTi0DJ
         OEXaa9hpoDT/a5x9PpIrC8bdEtDlXATigfFngfeTw7bZrn1H6l3ItWBl7lMC7ZFABJyN
         DSVICQ934V9W28JjknWjn+03+rkuNFeYDwQvvXcW9T+eA1cOOFR/hRsdeO8pYxJvHJQ4
         jvci41IfUshsGYmVZ1ETOq2/FQw0WBCQuXMANg5XRWtK56XeSHWxqH+T9AyDVQiY5a3s
         A+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757330162; x=1757934962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JK9jU98tgHbmM1z5ZHenWrJxfgqVbpi7pczkbfSWkXE=;
        b=F7me9SPimeDNROS3VYHQc/NsgrLDcUgbrLC1fRw4LIe9DlttG+mTM5/pu5entQVDrW
         vxuTA9mqBvgaaOiaxpBY7M7RAzmcZfLDJBGFYkDud8upgMOqa3hhQLiTChy2LyiKpCRn
         IQmb+q8l9aAKQHYzNbAEYFY7JVXOkkHO+CTgomkJ0MVOy63WsNeXEQPGR5qpx/S5lu+L
         k1P0d0AkVz6wXA1TVjNVNjrnkgLXLjkhaBUuP6VpRqz3OeQ+fSvfbSQQRSWpRznu/dps
         9oQTKqOwNiOl//6Hng62qIqc7ihy1XLEsozX4GxNViLX5wG/obZRJpLUwOVjLVM83Xnc
         /5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8bk5iv+wadS7i5AWFkgan/PpyoawvyOTM+ueR7mIREDCO702cYJRH8q4dkiyst6tYA4uT1HOC81KzkeE=@vger.kernel.org, AJvYcCXsWbSytoIrM6dx8QbsCynNnYIqclrIwqyDYWq3ZBXgE3ZIr+Cv2cfJoO6TbWNb7/pST+9ND99PCcvzt2ZCOkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FvYGy91r32qb1jS0sxKBHtfR9o7ZIv4JfQ1BxpoTPByh1Abu
	0R/S/lvciyRN61qeG8Wl6M3Lcm9NwHCq0CpIrYV/XPWnGOJ+evJndqtMPm5xZV2lNUvy3KYe2dd
	Y32gVY6rFT8lA6w5JBc0ms9hW3NY4adQ=
X-Gm-Gg: ASbGncvSYNisu65p6oTZ4nr5SvunLGK0xnO1K3rCJR4uqz6ZkzOc+cUDQw6unUA0isL
	vcKAOsB6mDz43AMS2cfTprlUDilY2nk1BNIyhJ4PsyNeflug+QbAtM7gxIFxHoLRzV40bP1aKKe
	9/S8qykFL4igVYetIZrDkKZHApDRTwPiDAWirU3abhJ20SDfQTUjwh3H3tlSlm9pj84BXvhJqWC
	pDFt5NxysxFqyhryMQmmLW3cOQQoS5JpylCHQcEODWk7dHgb4wrrMm5kEYXP4iIWLBDuLKNyII3
	ks+cmwEVf2PQKfZhK7bAc/fiJoq0l5+UqbSP
X-Google-Smtp-Source: AGHT+IFKErv/5AF0bCiz4VhTs1E/0tBQqforP73lRQ3YpiiqgqcgNn8qnPwok6a0Zc9AY8zUNwX5Kt5U/xVrcadTDl8=
X-Received: by 2002:a17:902:e890:b0:24c:e213:ca60 with SMTP id
 d9443c01a7336-2517446e925mr59279915ad.11.1757330161682; Mon, 08 Sep 2025
 04:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com> <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
 <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
 <CAH5fLghyDNd1SSL5uTZpSR-5j3q9=frAa=AgUjvap45b-DuUig@mail.gmail.com> <CANiq72nRLqNYhph=ZE7B3vH1ufHtQUqkfwu60vwLm-0NGQgW7w@mail.gmail.com>
In-Reply-To: <CANiq72nRLqNYhph=ZE7B3vH1ufHtQUqkfwu60vwLm-0NGQgW7w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 13:15:48 +0200
X-Gm-Features: AS18NWDdY9qN6h6wAV9-0nKdDuCIohuiHs7peyK81gegy5yak7ACtzD33M0xe_c
Message-ID: <CANiq72nSrQPBksy71d0hTUCwqW7RmTWat4-wGH3w-he2zFnufA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:13=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> https://lore.kernel.org/rust-for-linux/20250316061429.817126-11-contact@a=
ntoniohickey.com/

The latest version at:
https://lore.kernel.org/rust-for-linux/20250418014143.888022-9-contact@anto=
niohickey.com/

Cheers,
Miguel

