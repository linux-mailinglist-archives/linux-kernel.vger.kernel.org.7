Return-Path: <linux-kernel+bounces-897069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCCDC51E92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A533B02C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AEE303A1E;
	Wed, 12 Nov 2025 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXSQr06V"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07126F467
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946082; cv=none; b=cW/JszyJ8cjh9bz/vaRpLYtev0kVPEzOuhUwADI+RwwICsYfob6w56QHzlHA6iWfZMPi1NhT1YRdFMGigeBWbovg49am1e0mnwolptIknPheWkAKTaZghY64vf6CSqmkk1dRVjMWSZxx94NhtJOpXw6KcKPJda655swv+koQNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946082; c=relaxed/simple;
	bh=h6hMfbhgFDo+gCBofNGaIGR6RdADey1hjtSNOkDpSwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzQVHfNUQDg0vRfY7pX3cEsUpgCKE6v96LyggPPvsjc19trwOYfZRWWaSbuDZMdaHcAEd+FXzTNzt7sEc2p7xImQ+GL2PenczFlufMgNXgHRk3xCzuFXNU1EKix2wIdDxR7Q3ffJD2EDfAiGjBiez3PT6PUJbPEqV2oQ3GkNxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXSQr06V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297ec8a6418so550435ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946080; x=1763550880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6hMfbhgFDo+gCBofNGaIGR6RdADey1hjtSNOkDpSwU=;
        b=XXSQr06VR3icfBrhIVBXYOhEkXBwUypD2/Zbn/OeMbIgyQb9NlAN4cUmi1b+qwzrNZ
         TfmiyBnmm01BMw/VftgpiShBR8deP3nhco1AMvpBAwOUfKNCrQ9o3l8ofYrrz6rgxeGa
         XPinzy3OFFdr5+UoqdIpFrNMldYJEUvOgXJzsiCF2H2ASY0ee+tFnIYzYpoTBdowl5cy
         cU/73ZrH4vmlmfLuOKvtsoaiQu6koG2qhsQAvYc/3sLhjoKozhymp0PtHeFq1RKx9hVJ
         iLt7CPvcEgW/CLsM78p0ZbN6paiQtho4uMPzVzRPWdI/oHbAyFtDx1zwIoHDLzpqIoM2
         0tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946080; x=1763550880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6hMfbhgFDo+gCBofNGaIGR6RdADey1hjtSNOkDpSwU=;
        b=IveU1fLkxbbEFsPjq6gV0L9uJcjSm9tscdF028RPKNa+XxXqr5BreHndKH3thhF5tM
         azkDSCxHLFO083XuGvR2zpOUc7Nt1SdWldjHKpVi4bKzNp0VEzrEugQCQvhYKypUS3k/
         TTRujwRSCB72NKKu5Z43GoVEa4f1BVugP6cxqMstM0qd/cEpanNFaVe7sdG47OWlVlBh
         hxARHzEfzQ8L1sVl9YV09e9mYgaPxPwo+xVLimjUaV+LvS6Whu6dDTmof7vlA7nRx7ud
         vr/gl8GiSKwwl14SCN0uXPpwbIAitWEbA9tYFEJS6lEB4rjo0Zqp9GTVz/B2gYjsqx/F
         nUzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbHiKkrdFmQrQeraFzhp86UVsd2yzlswecxU7I8EzKLlZ6WYm4ikwKWXbqPgqQtav7TCb+HmS2SAHXg9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YygV1P4fmsv+ejNZo8Hf+kEvzHWN9HP9shUaWqBzE9kvcrhPgx9
	8P+Iq6H1P2F8vCrmtRwZ62jQYGMapwhQnpuBJ0op2JiFSotSvh1EJmy989d5dHhuerhOFcAZjkT
	G3nFRUvn4FNalgaUelobNZgE52uRVwvM=
X-Gm-Gg: ASbGncsruxClNAT6tbZmmTDPQO09w4wu65URm8UMcpeCkOW1uQJsX+e5VmLXAitnu7e
	/27s/3/LA6NOJDpJ1T8O3TGPSdG2Fyd0/pOgEWk2LnX3gL/BclT1IaEajhFVyQ3+mGAiZXH3btK
	inlSPDEo2K3+Pwl63ujq6Cg7aHyT5JHpuQQ0SGQ8HXKMq6VZTp7UZiddMz68KhfqtHqyL0nwAuG
	WPfIZyqssMYpn+rs94M13UPipPDOooSN+/74TsAAnli0i029KzSy7hELxqzRVKsvoyg4+gOquuy
	vRoRA8u+Xm1w4pmtbhW+FYaA7dOOkmF5PhU3B5Q/OQobx3QPwJJyxqWVT/MlnVlcVp1/OhdzkIe
	j82lImZ7O/Y+ueQ==
X-Google-Smtp-Source: AGHT+IH+LDSJrK2CxsT+xWZOdZ7gKFmElQbYj/uFX0H6HJGbyKRr591NNlUWdNkrfJ7Nf3ybqLt6vVVhtmriacHHU64=
X-Received: by 2002:a17:902:c409:b0:295:3262:c695 with SMTP id
 d9443c01a7336-2984ed6e08dmr21652545ad.3.1762946079913; Wed, 12 Nov 2025
 03:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-10-ojeda@kernel.org>
 <98e549da-b7d5-45bc-8a9c-d05eb06a75e6@nvidia.com>
In-Reply-To: <98e549da-b7d5-45bc-8a9c-d05eb06a75e6@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 12:14:26 +0100
X-Gm-Features: AWmQ_bm8KNkpZ7dumhoSEH6BrwUYU-Dw3GKK1Imj_lLMN6rly1tXHJZJQTQ0s2c
Message-ID: <CANiq72mcQJnW-F+nb=Vseoa_amcwwhkC26N9BOs12MVfMVOdVA@mail.gmail.com>
Subject: Re: [PATCH 09/18] rust: proc-macro2: enable support in kbuild
To: John Hubbard <jhubbard@nvidia.com>
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

On Mon, Nov 10, 2025 at 8:34=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> Looks good. But for future code and commit log readers, should
> we leave a small comment, to explain that this was vendored in,
> and therefore excluded from "make rustfmt"?
>
> An alternative approach might be to create a "vendored" subdir,
> to make it clear which parts of the Rust for Linux code are
> special in that way.

Sure, that can help, I will add it.

The subdir makes sense, although it makes it into a different level
than the other crates and I don't see it done with a folder in other
cases either. Hmm... I will think about it.

Thanks for taking a look!

Cheers,
Miguel

