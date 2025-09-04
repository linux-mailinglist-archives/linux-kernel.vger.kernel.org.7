Return-Path: <linux-kernel+bounces-800859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2DB43D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926035A3F11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA0130748B;
	Thu,  4 Sep 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="biGoIWD6"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CACC306D36;
	Thu,  4 Sep 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992198; cv=pass; b=dk2ZHgQ9Dg2js2Jkma60iE8uXTAQNO6+ek3MqcIGewXFPmzmnNPAIH/99HVMSlV/zOf5edVD/PEk41d14L11Jltu00Xb3+sQ8GOPHBR45EL2vAsNkpzUotcDHC/4Nkcefd0+4+49wJPLKZMlKnYlaqdWYZGGfEpe124pSMJw3gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992198; c=relaxed/simple;
	bh=bhm73F+M8pEYKYlPp5PI3Hp1kRr4g7QcydbznI7A32U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JnbnvaB+x2TwuBkGmMR/T696sdAJORb5IQlYneNAjevz/HUYfi/Km/PR8QUYvx/iD6PwIkX44i6tIUOZYqVfPvHzXvqbFyaU+dT8EP3GSh/6p3vYRO1Z2s4B89Trr2haj6qwjkGTYDRUJkZ4Xq1hy0ucVLCAClAveem4uJOcQbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=biGoIWD6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756992177; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cO56TXW5CTX2VSlBygMfNXZE5pVgeqmiBd8IPspLvAF0EqxwKr7unbvK+2e/JA8xmfO1OQFhDzk4yQbD/wG4wClnkXmAUV6XLGSnnBemd8aa7gs3+MvbxCUiKkaBwxPawiBzUWdIxxf3x9yXfmaaFZJUgxfnm2BpBA9U0fq7JQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756992177; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bhm73F+M8pEYKYlPp5PI3Hp1kRr4g7QcydbznI7A32U=; 
	b=iybKfrGxujqX52H67ZTvRW4oR7IXRXysPK4cB+mHu/+iwz88x7FrjbiyuB7irdEI3GLeeMDabprY0WEqtZlU6iZQOiuLV8aI3o0U/IBrWmSD5mtyVFyrgU7WxCUNeL8Qgil8TmlmrK9QhnTUSwWkh+L0m44yeE1MivU66wzSlr0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756992177;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bhm73F+M8pEYKYlPp5PI3Hp1kRr4g7QcydbznI7A32U=;
	b=biGoIWD6eb1ILuKY5I79GXsb+v6IQSAQ/bmJoqRc/21sMRG/KwTU5ZV22RqUtj7m
	TCskeTjvo/e8Hg1oJtZCqz5/wC5wxaAaq80FKejTrGRwcELtkayLV05ASTSfy7wx6Kp
	jnIxRr8IUY1aPkbdh+P5xcAdUkuTXvspWQ+6EbrQ=
Received: by mx.zohomail.com with SMTPS id 1756992174964253.37598761629408;
	Thu, 4 Sep 2025 06:22:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: clk: implement Send and Sync
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgjRaFjiw84_uP4N2kTs_iuDCe1vcZ7gyF4XiwDkbEgiWQ@mail.gmail.com>
Date: Thu, 4 Sep 2025 10:22:38 -0300
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <06C4ED75-E370-4F19-B6BE-6D2455C94180@collabora.com>
References: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>
 <CB9F3786-48F0-46EE-BE61-8823E437C786@collabora.com>
 <CAH5fLgjRaFjiw84_uP4N2kTs_iuDCe1vcZ7gyF4XiwDkbEgiWQ@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 4 Sep 2025, at 10:07, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Thu, Sep 4, 2025 at 2:31=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>> Can you base your change on top of [0]? Otherwise it will become =
stale rather
>> quickly, as this introduces new types, i.e.: Clk<Unprepared>, =
Clk<Prepared>
>> etc.
>>=20
>> I will push out a new version today.
>>=20
>> [0]: =
https://lore.kernel.org/rust-for-linux/20250729-clk-type-state-v1-1-896b53=
816f7b@collabora.com/
>=20
> I would suggest the reverse. If your series is based on top of mine,
> then this patch can land today regardless of how long it takes to
> finish the clk refactor.
>=20
> Alice
>=20

True,

Ok then:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

