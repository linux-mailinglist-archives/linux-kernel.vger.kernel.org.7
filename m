Return-Path: <linux-kernel+bounces-828941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DF5B95E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4402E6C84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75C323F46;
	Tue, 23 Sep 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM7t438K"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35769320380
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632178; cv=none; b=Ji1wuC4kZpgSn1+AXn2lCPiPBs4OGeUB8hHQQZ4yPhMNk2Q/EefccbNUXJ/ulkf06CPktLts6OZiMjLOWDwVgP/YHHxVf2c8zICSSqhZqm9vJ/ZapbX3u77ajhEdUcH/Vt1Er7XnkkvTBROQHSRvRpx5wORFXwseG6H+bLee+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632178; c=relaxed/simple;
	bh=2tluKtN1BCzud6kXRW1xroiXueZTffg1NnGk0toH+EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoF0VxrIv2lLsZucO2fusfbv4F5Bwo6BP6xvCORiMeB7EzrhNtYi0CNi3Ubpxa9UGYqTskS7tg2ukUgVlFgnuWWmqRocq2+O92tT7ydyf7oLPzBdo3i+JKeFL7Fb4+iarkQummG34SMmp8jZaDhC+rMrNlxDy65er6QLzcVVUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM7t438K; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5509894ee9so509188a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758632176; x=1759236976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tluKtN1BCzud6kXRW1xroiXueZTffg1NnGk0toH+EE=;
        b=dM7t438K3YlIUO8p/NZNMa/kmC2+1U//F8OI6Rk1kppVC+C9AoffLszDt3Bz+nVga7
         XRcYi2kCexTaLBkSdXrqZy0QONo6pUbZMcpoWdcjNJJajB4Th2ob8LTed3mZvBnBpE8v
         w/ngegT+V9O3jVoX1kJLnk1eMDp8cmLx++1AKFcorEnTHyndek9FXeqMgFtu3slInucJ
         cJ8i2ZW/Oo9DGBj8x6p4hqAq6AH/A6rutscEefkprTKeP0wNLBX0sA1nZccVETEBp8bM
         ZeAxrum2yteKAgwhHA+zdKG1bpSDkmzBnI40zTKos7kUygsUO6xuyA01IMviT/KYwEGM
         AewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632176; x=1759236976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tluKtN1BCzud6kXRW1xroiXueZTffg1NnGk0toH+EE=;
        b=hfnJMVmxcUtDpHplDN9FRuT1hyBj6vxbPgp1hH6jrYnzD58zixxLB19i5j1yKDroIk
         EdN0SgFj23q22YmX3Cf9UVJNKPbcjYCWq/Zx0sA2KxOtcWxGR2GMNYOGrIGPPGrpdmLc
         Jedsd2HJwdHVOkSMTfcTMVRElufk2tjMaUd40LN++J2Ou1YQKcsUuyBTI+l0mNHtyNu2
         15cO12Ht7jNsuTf3zyk536K6GahnfSTlIWQX96ce+vYf/p2pYK0TM0GUv1Tn9P1HN9BM
         HeQwOWLQPQ1jQ3zFNDeVUqjPPyWPlij9Bfz+sqb1kCks6td+Z8Z/7mUAZdg97s6VGbw3
         60Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV2N4FmhEa2Dys1inFIc/DEcSkom77z3YPOTESuY41/iVOirW4inrDmnjX9x921dTAdNPjyo2CxdCraK4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YznK7HWX+nm+3C+Yj3h0r5PtSTMAI8HtR1A9RypfqHAaD0ynK1m
	432OmnwR3ILqI7hdjvB/4VaKLwPPM9E0M9l/HVOaQMH8QGB+q9x27P3byNTQS2YzlNIYkekJcXM
	1Eo1DlX0erE3yp/42pJ1xJd4Tl6bUJak=
X-Gm-Gg: ASbGncvTB63X4Z7Z6d1UfzWXY6KbNNmJIv7H6/WGTmDmCBNZne9rhgSirRBJWuj3XKp
	idpdgnZguuTJ7MUL8JIb+hzxMGZMk/vCpBzWSTVW3pPb6Ijy5meZKy3XxgDvkhTJrEc0Qs+qh8d
	Ik3ZWpbbMuff/mcHgPbd5HlEuHAUAYLYuO0XmD6yshFzh9/kIKg/ztTiEuvPMaaVFHmoEhhsAkx
	koHgHCo0O5dmBjeN5113Kd6Sbk7VxvFdig+9X5EGSvDjr8xWCrq18FrPmzNIsOTG+gJqMFME70z
	+TiLbotIW05+K5jTN8V9dyXRSQ==
X-Google-Smtp-Source: AGHT+IF0/NkAjbrntImSusssyg0q/7Q73fQZB6mEfktvsZqm+jJxVnz928jvTWpp9QHkKMte89aUba+cxGL8oEh0ahA=
X-Received: by 2002:a17:903:41cb:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-27cbbaa4eb4mr16801825ad.0.1758632176486; Tue, 23 Sep 2025
 05:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com> <2025092338-elbow-dash-373d@gregkh>
In-Reply-To: <2025092338-elbow-dash-373d@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Sep 2025 14:56:04 +0200
X-Gm-Features: AS18NWAH-rM7NFZKlCBr66FQi40K38NtL4yX19rUN2GxoJY45g8UXFo0cj5K8Zc
Message-ID: <CANiq72k4VG4UMDJUUfD=LNM+tJmvceNDxG=A-+6GDjLzCVXurw@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 2:05=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I tried to apply these

By the way, a `MAINTAINERS` entry is needed, according to the log.

Cheers,
Miguel

