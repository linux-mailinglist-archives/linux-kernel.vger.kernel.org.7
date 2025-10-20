Return-Path: <linux-kernel+bounces-861089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA09BF1C34
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F6ED4F63E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD012321442;
	Mon, 20 Oct 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2q5/fnCy"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE51A23AC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969615; cv=none; b=eUBhjndQZCeLngAfn6ONjcDVnJhwRZYNG6PWAI8gNjEkNWuVTWSzgkEpshLJiY7/2PtKxEeAUSizS3pXmOjQFN+B+AqIhz/yawfn/1PUQfOZdavmwxoRN/OCNpcvr2QKnvmj+YH1P4Ml++Rqth109+aHOFuReTDeY9enrCH4lRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969615; c=relaxed/simple;
	bh=7lJuyR6K7Eyt0hpZteaPqYWMzx5S/jB4N1wiIADeqMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8AgXgwtyS9CgpS5hYSXasTX/p5oNPQtACzE3yg9fEusMlvmpbOYNri6jakYk6ne24TOaU725UzbvjP+1oJq13bXkP0ZSzTHkTmEYE6mhbrREdzjGX/uCI78MulcSk6HnDxHbYvx+cjBqLM9cJpQWXzzhC+2HaI317W3PeYyYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2q5/fnCy; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-638135d9f65so1328899eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760969612; x=1761574412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lJuyR6K7Eyt0hpZteaPqYWMzx5S/jB4N1wiIADeqMA=;
        b=2q5/fnCyC8Ihreh+OJA2T45Djo8c083FsM8XcHVK3gZdmLlg6WKjnIvJE+erQjU3a4
         uX/EW1ySnfn7yECy9Vp+qUKFvSs2GJc21KJ6swHauroZ49IANG1lSuLKCfWwZBJ5PAXy
         D6ObfP9ZM9UvPPluD99it8ZDbcnRtfYqZHiQmzjNuruZ51K9QsNR+UezuSFHFGK+928w
         7JkYGyNhao2CjBYwuF6s5saB4FDbdjtu3CaiGOAN3ArM2DBRSKOKdzHW+txTAb6YGU9K
         m+UpuUaZTl+w9HLY5K4t7E1/xNbJ/sQQxt3surTtT3yrs2SBV/FT6sQNABtfxdyt+AyM
         c+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969612; x=1761574412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lJuyR6K7Eyt0hpZteaPqYWMzx5S/jB4N1wiIADeqMA=;
        b=MJPJ1UNF7ty08OKmf8ESPusbJqRfIWauKIrV0V3KP24kLg4TF1DOpN21jkKsQqN1/m
         WAxp90MPYuTFFqEHy84i2Cr6YALLlUGKOQPpTCXlmoLyDKLNQ55P2iQbKU+2yO8+R2zH
         2P8IspQrZGht9bT2hqzfm/jEri6g6wIAdRXaBV8HDll79SITKIfInx7sNVsmwnFhbYPH
         PJTSbAO3nIeBQF9GUC9kJ4l48/09cV1N9ak4kbHskkplbDiC/njIPuMQiULX8ETTtvsB
         DLiJzYX+vWD3ol2tqXWQuXmfmNzK0ep2BsMEpbQHn0poji9NIvTJd6SsIhsT2LBsyOHz
         iZKw==
X-Forwarded-Encrypted: i=1; AJvYcCU0FAiGtoS4YPcxwMQk37c9Q9o+ZU50ycDLbAKjjNsGCKklGni1Lbv1NivF3Vi7lVSHWPi59iHGG0LSQak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0vIRfBo/FMjCvvQ8rWbiUukdJgqc4U4qfqEdnFT+ORtHLw56
	cJOMfz7STdI9bOcw8tqzxDo+OTqxO4HTbYQtYUWMvm4CnftY4goGowyiaih9tCyEgRxxCRuuIUi
	GCR/KC3UAtXJUC5w66YRuXN0n01PI2GKOXrExHt4e
X-Gm-Gg: ASbGncvpIZD4Zw0fyBTOJp3wxXyXVg2yGi8KQ8HbTF3BJnQVN7xi/ocoRsOyyLxkIYh
	JuITXeOzEgdYnxtK//kMabz+gLI39FOwaDegvbN6KkXp85b8G7qG0zMHNRNlV6y2cTVW/xYzAxJ
	H02NffQrwNDc75HkJrRDbuflpp3sTW6WBaHvmRSbSfFvAxpa4SRD4DWVEQ6s9mGrEXEMY/4A/HZ
	oJO+pJ3eVe4cxwuujzYsC8sa+Vv39Yyo5D9XAGMP7PgDON7hYfxV82A+8XyJDhNrTlNPLjfs7fM
	ERNdLmk2GaOCLK0=
X-Google-Smtp-Source: AGHT+IGKYboV4DgzhIm34G7rcGBtpN00l5g1+CfCco8yc30ZYZiXCPZrt1Fqgr57F/kqt9fdOOs/pkcuB14jBTW8jHM=
X-Received: by 2002:a05:6870:ed98:b0:3c9:bb61:9155 with SMTP id
 586e51a60fabf-3c9bb619703mr2885352fac.11.1760969611438; Mon, 20 Oct 2025
 07:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-binder-bitmap-v1-0-879bec9cddc1@google.com> <20251020-binder-bitmap-v1-1-879bec9cddc1@google.com>
In-Reply-To: <20251020-binder-bitmap-v1-1-879bec9cddc1@google.com>
From: Burak Emir <bqe@google.com>
Date: Mon, 20 Oct 2025 16:13:18 +0200
X-Gm-Features: AS18NWBBOd9T9tt7e55UHw8yXwua0AtGW04-Uk8_sluu5DZ6XtXxz-sVb-_3S7I
Message-ID: <CACQBu=UPsWUsqN3HE8kG+DDW_g3z+2yFxMWLQns1sJE=7YEtmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 3:33=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> To avoid hard-coding these values in drivers, define constants for them
> that drivers can reference.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Burak Emir <bqe@google.com>

