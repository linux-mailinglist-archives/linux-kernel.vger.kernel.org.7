Return-Path: <linux-kernel+bounces-779947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF7AB2FB77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DF4AE53B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECE1221739;
	Thu, 21 Aug 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9vzSFVc"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DCB22069A;
	Thu, 21 Aug 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784251; cv=none; b=X9f0xLgnKMpsNPLIjtF8HoFllrJK+lv1ao9bpgFu0jZMe9xgrtN/a1aMq2HkVxyBEx0Vm+bttB5PzjxlGm1njUjRrT8QeYUoFaeuzuea8paLzkCZE7g07XGXMCX+VUegsIzzZsI9H9PSLXv3vdBwA6dnuSsn23CCh7K2sWXdhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784251; c=relaxed/simple;
	bh=T4MnCarEhPH/NQ2wkPpDyOX98cn5/n80EHStoIC0yMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5otXZqe4DSHoX0U5DhOVTi8MyzAFAYdk9G+vX/4I9RDKkfxwPwoyFKbGiLYT3rEqbplJ9XcacTqiwe+3iroPsum8V4KQnmv/htgTxuXmLRPMcE3t0098jRyKvTSfbZjZleXHLjQFRip+kbRLAMhCsUAaFv8CfD26CueeftBmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9vzSFVc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445813f6d1so1779965ad.2;
        Thu, 21 Aug 2025 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755784250; x=1756389050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4MnCarEhPH/NQ2wkPpDyOX98cn5/n80EHStoIC0yMc=;
        b=O9vzSFVcRllLIYyD7ZZmFdUeFRz7VKA0PQ6K3VKOhvjQlw9WvULOL3Dy4MmzcmBFCe
         FRqnYNpJJRXtNVOs26DJcqQlzwURSoJNxtcPT7rLc+wg3wKOLlGNARpo0GVX6DVkUUu3
         Sn1Iwto7aGH8hSJsemu34oR8vOJU3vbosvqtRc1xbOWHs2mbsj6qvSyIhvW/5gdquumw
         42nDYKpBMasjZSw7eeueCw3jaKhIh47g7pGV8izVywIYa7ksa6URiGiL1SWshWlg2A49
         qMlAmgcjzhIOrlX641zgKV6T3DMkzRna3+JbYLGJXKhzZM8oGn5ck4BkG0i95HWPOHF/
         onnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784250; x=1756389050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4MnCarEhPH/NQ2wkPpDyOX98cn5/n80EHStoIC0yMc=;
        b=kRPYnn7IUWhO0tv99M2bKfjSliDMQ0L1rbtwRkPiVzb1qD4kaktPtOWZVVGLDTQ8Li
         u1t9Y0sUmqVhgAjeGjTteVyA9c53/vGYF6jN8XJjzitrmoqAdR0rbCiAtu9tPNK42UtP
         lJyFMgMfbdaYk4v9OGbYH8pk9JbSIl5JTDeN4elY82QTLX6ESX4iE7+IR+3mq0+9N/pV
         s9JxdsfWIBE6IXJyCmIe53XK0efOLuS7xxUyxWoOnhOy8v7CSBn0mvESABPSXHDs0CVi
         kApva6Hp1/rLJYqmjBoJUePIEArqIjVKCPc5oj/9GqNcEnLlMREroWedMKS7t/es8Y/i
         Ls5w==
X-Forwarded-Encrypted: i=1; AJvYcCUxUOqFyXRYtz/Xm443dXhR+fzuk65Yp7jqLV1FNBdqU7e5uzj37NytirzXGKXDfrtds3pwBBCgk2d0BD8=@vger.kernel.org, AJvYcCX3xuHPstkd87Oq4kP84/NR3py5UFk6PLzQhYBcJYqRQ6Twvo0Yd8umb2Zx2hAAmxDAjXNNfbVIYI9oNQqkhWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpWWB/qF+e0Fiv40hAy/SeDHYEOc8YYrwcrW8kQLExogizNM5
	/wf9NTl//NKtPJF+ClHswJulB2YD5VYjCha2XVREmBsA+UIVy4Jv8x9G2S7AJf6UMoxjJ+2wdlO
	cf4OVDij1p5WKbPwZz1md/IpHYpCnkLo=
X-Gm-Gg: ASbGncu4k7SYSJEcxZsvjpPQUj6IeHhZgD+hp70hZ/SOl6Z20qVruI/hKyOHAzj+szD
	nUD8Xg7S9zhnzEuWCZK2RdpF74j+6DoYWBxdHxchRlzsk/e3gbQoQgxx8fXHux61WkZ+cTf7PYU
	Lv97luJwjnYhonFrUMaylqHLfJ6AfFBU7yOoQuTumBGVw11CvK2UGB7thWet496w0HEHSS5la1M
	H4Wm1NxpDpJ3oT5Cw8=
X-Google-Smtp-Source: AGHT+IFVesOrU4t8OSZvuxa6n3ouu4N/uHmskHWULQTTapDYm8978CBixUbXAiJw6cpZu8GXrMg4rFy/HsPr1ps7j2Q=
X-Received: by 2002:a17:902:fc47:b0:23f:fd0e:e5c0 with SMTP id
 d9443c01a7336-245ff86b777mr19216155ad.9.1755784249729; Thu, 21 Aug 2025
 06:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com> <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
 <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com> <CABm2a9cyvsXd1OS+tvDoDDEfMgBOJeetBVQU0x3m5E1vV1CApw@mail.gmail.com>
 <DC828042PKDV.16NDVKIGBNTJH@nvidia.com>
In-Reply-To: <DC828042PKDV.16NDVKIGBNTJH@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Aug 2025 15:50:36 +0200
X-Gm-Features: Ac12FXzEpP_bbAh0ypBeJKJ_w8r2s3Q60QOGlxM_uzkQsxRGh4T_S5Mc0-CE7N4
Message-ID: <CANiq72kDUK0nScg+nK-M2U=MmxTmhayyRUv7n4E3UMQHr8RLQg@mail.gmail.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Christian <christiansantoslima21@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 1:13=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> (adding Miguel as a heads-up, and in case enabling a feature is not as ea=
sy as
> I think :))

Thanks! If it is internal to the crate, i.e. not something generated
by an exported macro that others can call, then that should be enough.

Cheers,
Miguel

