Return-Path: <linux-kernel+bounces-739918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934BB0CD04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3982718900A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4592E241680;
	Mon, 21 Jul 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cat5VNkQ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A22F41;
	Mon, 21 Jul 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135149; cv=none; b=H/CbuWyAA5T65NboJ5jnyT/EiVbWUOStS9i/br5HUVaMeAMRDpJSP28cx317ktNztdsDtP3PupBu5zW284LsiZA7im/kWvhqgnbAsV8N42gNpvNwTAYxDKjEo/K31pZkTzNWdzmzstgcEaKCbP7vQPtnfLFv+QdcPNwek/nsTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135149; c=relaxed/simple;
	bh=US8qWjQi954VLTSFmdMcAYVzpZGrNn8OUD5t3UgF27k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqp4rTN+skjVKEWQeESnwKqg1dN2KU8rceQ5itcP4ZN4tRwGJqldpN0r+AKuj/w1heEqcBAuRSAkKvpqMASwzAZFvVQzrJzvQjZl8+3fOkxhdm4RyHJqurDfqji41IlRsplfN8khUFonw8bSBcDUEGbX142TpDyEm/Rhqqx3EEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cat5VNkQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso589703a91.0;
        Mon, 21 Jul 2025 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753135147; x=1753739947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=US8qWjQi954VLTSFmdMcAYVzpZGrNn8OUD5t3UgF27k=;
        b=cat5VNkQ13/TSMT6BpkF2t7zSvwXeyDN/lQozKtx8S0DHd1fiXpG56sDLnv7ciGUdY
         mHT2MiJ2JrUMc9THB+WmozEojTDrO2QS7SuEHKyOWJlm0YA67cSJOIYJfwGXYdrcl9Ta
         j8fURaZcRBwf2VuIMGNlOwaTuvaIZUx3XxjQ27fjoogxtVGk4yqewBUuMMj4M27vwKK8
         z4sMyhQLkZlR7dRA92sdah7btl87ku06/Erat1s1nTxFe5lhlfQMlPBujG2hV3EmoSMK
         tQVcYr+Rjd0sMrseFcmLIPpzuvlPRxUM02yU3olWX+nGI+z+LKX+Ge6YLva0edyHUpcJ
         x32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753135147; x=1753739947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=US8qWjQi954VLTSFmdMcAYVzpZGrNn8OUD5t3UgF27k=;
        b=cFfERkg2Ie0UY3CdTmG9b/jTPCTEoMSpjfe/Q6XV73WIjdYwsnVtvcdrtrsqkfpDWN
         U2Hpbdz8nKjyyN2yNuLks8Yj51Fap0OD5DmiUo/gY8WI14FG3LbxcWwcfZ6meIqtCOyw
         BMTgIvxjjtJoiEzn6vbE/RWix/kEBU9dnsCkxMC4fT92OVunmgVLv5gp/MuyVAw8X7D8
         0RChIeOVICzFpdM+IIx+YZ0ePCxL/KzuxycDpWrD/UElSEx1a0knBHiLcE0izWglGACH
         sw9NNZyrjxeNTy7Ve76E/LPfM27pVVxacS/nj6NOFLQ+vJ/SJ1m5qEbZQqo6V26UPY2Q
         NKzw==
X-Forwarded-Encrypted: i=1; AJvYcCVPcdfnT2FsKD1OPlr36BDW4V9skmn9XTDZ0ghz7L3myT27SjVEg4mww17vlPtV17CsccHgzhM2K8F18SVRbTw=@vger.kernel.org, AJvYcCWvowoJsAMQYdWHPxx4deGCLDvFaQ2o7xY0sfhzy5JBLY901WESlRhaU7blUGWDLss/+IV4KLY0Nlq+J/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+u6bWxXXKGUPdr0lL9bpx2DxHA3gXa79GF+j563nK7j3DqMy
	lMg1B4gXoqqmhKvNn1G93eh7LnLS0hVM8jngrAj1QZZv/7dcuFoAtzRTTVcww15BuhGT25T9W4k
	qTmgHcTrug7alaRqyrxBdLSCmijhmPZM=
X-Gm-Gg: ASbGncuvsQcE0rsLmK4zCr6gPdTiTgY55PugxkNCKG+12dNahMPtEvYoRUz3x65KHHh
	cfLh4sKIMhtkMlQfG+kkR3UiS9A9kl+LgkqKA+TzNr0TAyV8ryzclthaYzeICX74Pf6NTOrOe/W
	cV/WDTSxmQd3L3l7UVbjmyEbbvGtlEKLWzRu3XMX3g9lU/p4zZK/jR/sqD7Te1VynGTbV9o40+/
	0Jp1+zVUd9lcPeNaRM=
X-Google-Smtp-Source: AGHT+IGU8TCfjBxUhGXjiOac3BOrM7GbDq3sxV1Z4bPwZDVK1WlM233Jb4nWPO6sCoJiMqgHcDholJ7WNaQewZP42nw=
X-Received: by 2002:a17:90b:2e87:b0:313:14b5:2521 with SMTP id
 98e67ed59e1d1-31c9e79557cmr12915584a91.5.1753135147466; Mon, 21 Jul 2025
 14:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519124304.79237-1-lossin@kernel.org> <CAH5fLgj1k6juFMoBWeeWgdkF0UDewF1=VThj-dnusXwjKGFnSg@mail.gmail.com>
 <CANiq72=Y6aZwZpQwKHFq2D9H9qFYH-b19SJgTRyUZA18UZvjfA@mail.gmail.com> <DA0CHZGFZ860.3RVJ9Z1RRBI16@kernel.org>
In-Reply-To: <DA0CHZGFZ860.3RVJ9Z1RRBI16@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 23:58:55 +0200
X-Gm-Features: Ac12FXwhiM45Qb_dfOAl0Vhm9YfTa8bSlgIyrkiLcBYozu6Tjrarkf_-S9ngahQ
Message-ID: <CANiq72mq0KYXSLVSG7uR=L_TGeqnrfkj1PqaFbMOxy6qjwqfmA@mail.gmail.com>
Subject: Re: [PATCH] rust: types: remove `Either<L, R>`
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Dirk Behme <dirk.behme@de.bosch.com>, Kartik Prajapati <kartikprajapati987@gmail.com>, 
	Aliet Exposito Garcia <aliet.exposito@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:23=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> Another option would be to deprecate it. Do I remember correctly that
> Linus doesn't like that? If yes, then that maybe isn't a good idea...

Yeah, though for Rust we may need it sometimes during the "phased"
moves of items between Rust modules.

In this case, it is just not used upstream, and the only user
out-of-tree is easy to replace, so there is nothing stopping us from
just removing it.

Cheers,
Miguel

