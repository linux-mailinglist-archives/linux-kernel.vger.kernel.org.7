Return-Path: <linux-kernel+bounces-740736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E469B0D865
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594B5188ABE2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B852E3397;
	Tue, 22 Jul 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELC2jZjR"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43562417C8;
	Tue, 22 Jul 2025 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184407; cv=none; b=K1GZYT10ycDIRvDsQOLoBiVfORmeoR+WFKWuTy9NkUNte5ukK+ScZ0fEVey4bke2OvNaeZQla4qRln8akFWKc2vXVoP2djWbJakjmKSG0eM7UXe7EtPPEMXUtI2KnLIdUltaxEKO5GRhf2MIwdmcIck5TZ2XurYSxqENwsTlu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184407; c=relaxed/simple;
	bh=tnML+5yTFNBC2rK++K7WRcgFRoT8kDGnbLmMXmAO0Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoMffvtrY/d5DWvdVp3Vfr5CJ5biLXZzkWX/ioOBHMDrdxq26rqLJCp3gN3rTGAhJtQ9q5CJsL1QgkMzlCqYEEncZkbDyPQ03F1H5BmtQi1rr2AgmT4Pob2XOd1tnV0dmTFTJm9o4LxWZyxHz/mDZKpdw2+fzXvdQtv+Sf8l3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELC2jZjR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234b122f2feso5830325ad.0;
        Tue, 22 Jul 2025 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184405; x=1753789205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnML+5yTFNBC2rK++K7WRcgFRoT8kDGnbLmMXmAO0Jk=;
        b=ELC2jZjRt9tzp7BM4Z53FiqbTgn7GP7BE7jXCQ9kTuObIF5r/X3mEvunNaJyziydeK
         r4W9Zq3OVbiEloMcJrQG5/QQXILbCiY1vNF5dZVTZD6vcaSV7TytZe8IqrUWkzw7yfZU
         4Q45Ybg4ef2Vion+sHfQMC64i7tIvYG2cfW88ZULH/NecR8txGQVvAObVE2kn7DGJtxF
         TiWe1ZChYH368hBO5FgPSb6sOHHuTisZK5uQ3a3Zj5JHiZzh4nwuOGxiXv0bjsyy66BI
         +t4+0Jjp6AI9pu1FjC1LJH6FnhVMq3l0PLeWPJJThjjUZ8sqCjn4ITjv8avFzaM+twp6
         ojnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184405; x=1753789205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnML+5yTFNBC2rK++K7WRcgFRoT8kDGnbLmMXmAO0Jk=;
        b=n9DbO5MEptvdyoXsujh2yt35SY0J2l1BQy4t2vaRTWnueEEd1TXnHHrYfoezWsuE/W
         exoyHkXKB6QXn1PZTRTNyPBR9K/RuGfO0sYH008nlBCjsgk8+fenw5sdRUL4koizxVOp
         7d3aa9cupiKxZWaLX570VLLBZJKyVqqSF0TNtCway0L6pWba5uxZXHNotzBeD4Oc0XPs
         RLUrIL0fs1AkflxswK7oVn1xrLPIOM7KoS12BaGVBhWx6wraMNN2pkCLcO1GijxXSvki
         jIluRsKXlFj4W5n0HeyLq4wnDb8GzNDx0ymEgZ3rbiDOmmQATWhZdJLJ23rqEE18HfYd
         0sag==
X-Forwarded-Encrypted: i=1; AJvYcCVuidDwMo3ZlDTUu/SPGCp33XE/anqDD6KRkKYjs1C0FM2VIjk3taa0sovAdeVCzo4q3C2TTVjSm8e6MC4JES0=@vger.kernel.org, AJvYcCXOD+uf+56A/WzrNOdcXNetiksp2VqM7DCT2hKbHFomTT35kK16WT9eUg+odOBhfLfwnXM9B1c8blf2iKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+Z/luc5T7rieuQ2iK1ICk2S4z4W63dIHmzuhMyle5sCnLwbr
	tiTVZXAuel4KW1ScBfvfZkurGn/BeJjo8p2+A9WDgSmuge/sZ9dQwszw1/1PXNROSChAT7jqhSm
	DygX/C+lXKUWO8beVskwCeOdUMaPjFW8=
X-Gm-Gg: ASbGncs+uQuKtaNOCDiegEt5+fmO0K8xMHQx1uhKCMwwSv4ClKs3CZpL4khkBATIqw0
	4Cg3Ru/y7ovfL+qg/psVWW7A+0BljNxS606ff6SRRb/1WIuFX3pgURA0Mm6BWUnWjxDi45naEHh
	XtEO9SoxL3GwJ4Frdl0rHIJZCWR+ZoLMFv3Pw2+ufYK12rG7zjjqhMjWok9IrzlHLX1tECWqvNt
	zCQRIo+
X-Google-Smtp-Source: AGHT+IEbdCBZvlB/GejgG1g+RqBB3MqgA3hZpFmYgzG8Cex0ZLgargr5t3nsLv6aQ58m0ZcdSh1SOurU9tQP0CYO+/o=
X-Received: by 2002:a17:902:f547:b0:234:ef42:5d52 with SMTP id
 d9443c01a7336-23e24efa96fmr129398595ad.6.1753184404989; Tue, 22 Jul 2025
 04:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520231714.323931-1-lossin@kernel.org> <DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org>
In-Reply-To: <DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Jul 2025 13:39:52 +0200
X-Gm-Features: Ac12FXxbzIlBUxG320GgZ3aYPXgLuQbrj_jdd-5FoBbNMvneFjuDW_s41-WIGX8
Message-ID: <CANiq72k+_UsRTVNWzz3jT+Nkjb-Xom2JmZ9Kaoba4=Omh2EgaA@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: fix safety comment for `static_lock_class`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Mitchell Levy <levymitchell0@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:21=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> We can take this patch, as it definitely is an improvement, but I think

Yeah, thanks, that was the intention -- we were checking a few older series=
 :)

Cheers,
Miguel

