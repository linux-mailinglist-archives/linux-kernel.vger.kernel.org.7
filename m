Return-Path: <linux-kernel+bounces-893286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC20C46FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C314E1884D97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E9B30DD35;
	Mon, 10 Nov 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYsteZKI"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338F30FF2E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782152; cv=none; b=DPvNcI58QNmDvQRkEwlzdoFxh5NbNkVQZyxSQ0EhtMWJXYruDoNGWIjba7xLVe+FQS6oLUmBL87EgzS4irGRmCgPllv+HHdkYnMhZUAeX7T85eOuC7gSPGP1dEPC/Trda4QGQIkKDbbNejwIGUCaxruUSbonfj3Ct6vJs4mSpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782152; c=relaxed/simple;
	bh=PAdjbqg0ugnMG+0+hkw0gIL4xG3r5RPuYT8bL7baWBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ggM/zg4Ph7CST0daElLzFw2pF2GXr38jweVr7IjiJ+4wFcmZaIBE2nafap4knJlChyNq1lCJExY0CUaUfMPnpLgLVHUyaUY21i2xFWBb9Xewtlfs+/QLZcWPaWS8HQnUmcNDpOOiEWlKZyVLj75t37dU8BLFhM6ELwHvzfzDcMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYsteZKI; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so573068f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762782148; x=1763386948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAdjbqg0ugnMG+0+hkw0gIL4xG3r5RPuYT8bL7baWBs=;
        b=WYsteZKI9i4v4if8baaqBjwkLKPAp7E4xHC906b6CGLP7Gj2G6qsLuYy5YYpHF2t65
         fZPBF0qQWttyAav1lvcoR6ZaVKtcYMdjtJ7kDzVKOGsczC9sYBTIYxBGz4umM0OcK5GP
         yl5Zacr4jenfO30SSii2Z7VDinrObqQYY+imR81ogbE+YpokuHD9aoJiAq1xaM8L9HAs
         bY7AFE7hC8So2fgsPzHT0fE4joeMMvyYQOATj26gI9eUR65tim1TWcFlcxmB3T1wJmoe
         oACoXphst43rMMAN6ttgelZYZ+fW+BJ2dxknu785mJ+fHRSrrRk+7amcq/7XbwruV4pF
         8wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762782148; x=1763386948;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PAdjbqg0ugnMG+0+hkw0gIL4xG3r5RPuYT8bL7baWBs=;
        b=nz5mg3twdA+MOU522duQnVO1qSWuM53BjcL3rdZMQyxmHfRy16/FWEujE8Q5xCiUPT
         UVZYH98kSeQ0TyDoznbu0KXPjhDSvdvGHQgmziK7U3Trt4qCduBuJnAozM3U56leH0ua
         aZlhtkSqqER5x1+soT5kViZHuELua1RBbeebjiFQ2qdNFxUoWsFS1mIdglf/NcU1HNaH
         bBzwZjFLHd+A54eoiswFH/YdJbAph19ClZzD2VCq5gqABbs0xPwCW9SAvf+swUCXBmg8
         tV6UOLEoKbW3JERu1aAiEUckukjNwN9w3M20fWfAox0BFsR4RlayPwQTQT5yRoKG7Xjs
         /sCw==
X-Forwarded-Encrypted: i=1; AJvYcCWKlS5Wx97E93leciWjw2qZvzLhRtbZH2l8RVzxF44tjvDDwO4xuQg2XZDLSl21g7K0yiPi/FKHbGuUP40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzQto0JT1lDxZH8Szhgr/ZI6rYZq8d2sqkrL0GCcGpEMf0pwh
	R1o4o/8dPoJmiFDwLrCNixF6GtUje8973WXdViaDKYWIYsyafloep6fZAQ9buLBX9dOHX+Aam3j
	IenfKQsJM7rXHvU95BQ==
X-Google-Smtp-Source: AGHT+IGdYLsMwQu7IW6P9IMv+n1Ga2zIS4ZW4YRMrMw3h6aVj+LGhXmv8UdaVn1QueN1sB3azN/HLRdoRa7dYS4=
X-Received: from wrxf7.prod.google.com ([2002:a05:6000:1287:b0:429:de3f:827d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f87:0:b0:425:8bc2:9c43 with SMTP id ffacd0b85a97d-42b2dc12867mr7026361f8f.1.1762782147990;
 Mon, 10 Nov 2025 05:42:27 -0800 (PST)
Date: Mon, 10 Nov 2025 13:42:27 +0000
In-Reply-To: <CANiq72msN1B8c8QFuH2VK40xXY3=uGiGL=YgAo68o92LTO=kLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-19-ojeda@kernel.org>
 <aRHRYbHIfxMQ77eh@google.com> <CANiq72msN1B8c8QFuH2VK40xXY3=uGiGL=YgAo68o92LTO=kLw@mail.gmail.com>
Message-ID: <aRHrw2p2YX5TyDYq@google.com>
Subject: Re: [PATCH 18/18] rust: syn: enable support in kbuild
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 02:38:58PM +0100, Miguel Ojeda wrote:
> On Mon, Nov 10, 2025 at 12:49=E2=80=AFPM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > This change seems unrelated?
>=20
> It is needed to actually use them in proc macros, e.g. to build the
> new `pin-init`. We could move it to that patch series, but then it
> means it is harder to use this series (e.g. someone was waiting to
> port other macros).
>=20
> I can put it in a final patch or perhaps just mention it in the log,
> similar to the `quote` one.

With that mentioned in the commit message:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

