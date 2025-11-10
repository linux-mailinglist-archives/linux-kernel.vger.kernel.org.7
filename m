Return-Path: <linux-kernel+bounces-893639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC4C48141
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F239E421252
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5F28313D;
	Mon, 10 Nov 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSN6io5Q"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78B27B34F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792087; cv=none; b=SKdWMpf3ltF/s1fiLygaZOui3NTGWXORtdPdZ/gUwb/9FvmfKmv9Sag68BXbHOgxMXfZNnl4PmrpgeQKlx7qFNWQTywfHfZPmuNs7A0vZGUg0Hq4UNx5hxF6Xv57XvEjaJTdH9Z1NW7P2RGrST8ZJ6nSqO9AfmxeLPKICLIgtPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792087; c=relaxed/simple;
	bh=7KIXK0iuY9HU2BwzT2hpkkZ4LNFZPjAGMbfebt1Gwss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afXhH4L2r4pUUmxg0sGNUOyqHQu6CGDDvj8DmfI/bLeTvd1MxsLi0V7ZhZg/8iFZFiHLTLeH7LVJI9uVb+1aACJeyiLlpK2lZKWuW//ZPQZQeu/siUf8I2jlG6P2xvo9mx/ge3PKe0I8m9xCgFja1mg6hf8di7IrLJGislS299g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSN6io5Q; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bb54b6a8abfso48400a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792083; x=1763396883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KIXK0iuY9HU2BwzT2hpkkZ4LNFZPjAGMbfebt1Gwss=;
        b=NSN6io5Qmv3vr11iAZqwp9cyOycPzcDRDVEcKrzJKZh56lFUDluqoRQx659Eu57PGR
         qB2n5VF6wJxyNrwuxbYqu1nL3GNzOCt8Z7ia2ln/fnwON8saW2OmjsaB47+IG2J2ChtX
         gxJiel0g8Em1B7bwrxtopMtKfoHC5EWmR4RjU1+Dr0fLl5emNFFUSfCtIjvBYj1wDLNi
         DGo7BlYrnLfUeoq2vyzF6RISAYZ9PCD27idCRLQVC6bYSaDCkpeijP7jichFpSlVSFO9
         +lnF7fkDwYVRN1xpMQWwNLOiwhgriHZe9IZABImshilq2xiZwM+29ipr7NWyJcVTERnc
         cAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792083; x=1763396883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KIXK0iuY9HU2BwzT2hpkkZ4LNFZPjAGMbfebt1Gwss=;
        b=hBnKKFAO+1v7WFDAdH6T8FTVr30ND6KOfxvkxkf9e4/USAvTkCJnHmDVbVYjDQnUi/
         FJnB/2tzuCvJ4w3DUF0KJdUCObU0gSDIE2casHUt2k/JywB/qhlZnTOIiWAbCc22fAx0
         16FNHlRASr4tDvU5Jnfz3aWU5qiZ3svMqf0xoIWONhRs8Oyd5EB2aeRmCh5MrwrkenQk
         pc7Kq7IGehznwLFVSyD/5mJx+NKh7CGZZhGZ2NlW9RZ+naDFkB8iozDPMSKTFPPi+DBk
         gn+cWINL+VBoAytFmMYm1iBKJFSa8WztcYgnyyIaqKClUG8tfc6rI5A8TMHwjCcK+3hp
         DSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZavSvrbgqenpu2hi79Tv8vg0UW7dQcDCqNuB0iviBWH4VViUGqZPf3hREpTbXaa/79PAD2zXp8jA9kaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3IdiYXQHRDRf14s4xmXoEFPO5lUcFp+b4OMYtsXUP0NdAhAXw
	jir//Dd9Fx3tY9fT4uMSo+uuQVQ6qsxdM5DqOj8/N1FdEXHjsjXzXuLucQH/JVn0D0gnL/bhSkd
	LykyrvLXI4jz23tBJGIsvMKRs6H5bjBw=
X-Gm-Gg: ASbGnctR7LdNsG1NkP4PkAKJMairTp4an3pmegN5HHy71f9TReX1ibq0yMCpT9q4Szd
	UsxJqH7jf3J6zY2NCUzdA9jjvlTFcM9qOdvfXlKnMRvmUpsHHFbPnWAP+dGaSNOsxvmizeKXk2p
	a8nSOqWHFLjQd72MsqWPsWe8nEY6ccUNyZL40jFIsRte7YcP6dhdLmQAHq7XnthMx+Si8N0u+t1
	cBQ/KNFzvSay4rLBDo6/omMHYC2btvfb8m2NETYeZNmSP//tTF9ewP1a+3hu1Yio9HaZBFhoLem
	hmaAaQMLYaz12BwW6XPau+tgP8A2wlRApaGmS5xtPgbIFaGX8Q1yZxkeiQEG3U+g2dwAKf0DUZ4
	ehN6jkAPdqvn1Uw==
X-Google-Smtp-Source: AGHT+IGEBFmVPMI5NICewEorUkL0ds7+z3bi+UEi4xsWzIwL5kT2S2mSCMP/63srdW6rOxPPTGD2icUW9ucKWI0bRKE=
X-Received: by 2002:a17:902:d48f:b0:295:54cd:d2e2 with SMTP id
 d9443c01a7336-297e4d096a4mr65754305ad.0.1762792082779; Mon, 10 Nov 2025
 08:28:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <874ir1zxng.fsf@trenco.lwn.net>
In-Reply-To: <874ir1zxng.fsf@trenco.lwn.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 17:27:48 +0100
X-Gm-Features: AWmQ_bkGZ7lpasgtIBPX75wmrrnwpcmnoNKRPRgat20Oz33yBel4ISwgnlmOOUc
Message-ID: <CANiq72==SimzoQARA5uprXs0-iKnBNS+EiKCz1L9V3K6LO1ftw@mail.gmail.com>
Subject: Re: [PATCH 00/18] `syn` support
To: Jonathan Corbet <corbet@lwn.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 4:59=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Just in case I'm not the only ignorant person who didn't immediately
> know what "syn" is and why we might want 57,000 lines of it in the
> kernel... :)

Thanks -- I will add something like that.

It has been such a long and recurrent topic in our discussions that I
guess I was writing from inside the Rust for Linux's bubble.

Just to give a bit more context, it is the most downloaded Rust crate
(according to crates.io). It (or something like it) is essentially a
necessity for writing complex macros without too much pain.

Cheers,
Miguel

