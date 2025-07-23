Return-Path: <linux-kernel+bounces-742241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8EB0EF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F29C17FE78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E086928C2BE;
	Wed, 23 Jul 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ayGFd5cL"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0328C2A4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264845; cv=none; b=pLsg2vvxKjfET7E3iw+JlwAx/cIVKxzfkYIsW1y1P2xpWngX1yNbUOQPPq2K0JJVPTlV1gTrNIBxBHt4BMevvPS8RAbqi5O3PcpEtlkV5IR0++HQmhWdxGFFsa+UjAD3AUYIJO5qJucDbtbc23EqkccP5za5YMCBSeCjf8ezck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264845; c=relaxed/simple;
	bh=HPZwATo2v7l2HKnBADp1hY9EvYt/2s2FvfAZXn5KMgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+D7dOS/CtDQqwwxvzjD9Y6e/aO7Hn0a4gz8bYFWxUMqXKWG6gBmugQzWJG9P3JaifFYXPOFqcOZft2w/7Zry/QHlkyNaXO5crgCqdzPEwuwtb1ma8pEMrTacswf3p8JgRBcViC6xPqKd5kaKkQxTKjrxaSFG0MEUhg8eBNzUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ayGFd5cL; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b271f3ae786so4810590a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753264843; x=1753869643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPZwATo2v7l2HKnBADp1hY9EvYt/2s2FvfAZXn5KMgo=;
        b=ayGFd5cL3R3LoL/zdxpCk7+lUry2dJIAnit4piWTrOUcabWqWOyMcg0/8oQduUf18u
         MIdeeQhnXgqg8PBeChU5pHpDYfMGcMzSDatDWMiEDjdMp+XI/SjjWqqm6yNYkarseP57
         o8LytKX7r4zJBFJ1vUtjdfZODT2N9RCVoUngGqCyJB5E+oD3hCYZOMuxbkS4idwGYZID
         4LNR2tyH4/cheSmGNr8eEeD/SaNbUqnQ3D0x6XDiX3SftHTog7u5Y/vdMBkgYexH1qMF
         myDaYUu9fErPad0f6dTB4vL/CIiia0P0rmGuYLJt1tyaxg/ogzaSxDdSukIVdfNz4y+v
         nd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264843; x=1753869643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPZwATo2v7l2HKnBADp1hY9EvYt/2s2FvfAZXn5KMgo=;
        b=QwgdUFs2/Se2dFTEWkqt151IfXumtw/lUH9+3V7RqZg0eEjgL0zTisKNHfHSJ7UNDe
         uqN6HkTut0p5FRkhVxq0+OAI3xRW1NoanfUozCT3nu7yDahx2FxZWR8ljqPW8uirOt7H
         nd2/jxSecf7eEy1zoH+qb6uN6/B8Kr/Ewo1FV8WkGlRhC/nBwbSR7gHbRaiCH3IQYkMI
         1QQxc/3CM6PUbLSFop3gZvH/lBIalGpScyMT8Tt2BLe96YNoB1iDGO/A6Jtx3pQ53mQS
         1Cj9AMgJr/g61kcWTzYXiMiAk1OeGqvDgfYsqYLaL5pdOTrmgs977pYg4eaqMGpGVInI
         k2/A==
X-Forwarded-Encrypted: i=1; AJvYcCXt7xvEHl5j9VDqXPq591kUxBSjKuPaahVgJhD8Mw5dX65n+4Aop2g4nJ+uo2lt9u0jna3dcUc6SVRntNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92fB8put4DnuOZ4LOVHtw5smzM7VDBKx/gaKvJoaIRHmO4qE7
	Y4jeh7ONB2tbP2qWQxd9IKkegkhIrVnpNshjD2+M0UgcMRouYAXAk6BCkw7oHjdjVZngX1BqUNa
	v+DZ0399pdGw3EzESPnn6wGyiwhjlzKv/+OsM49V0
X-Gm-Gg: ASbGncvss0154q50xQBhwkw/3oz18u9QtUh9YChm9cgiB6dC4PpFnFfJ3QRyppp1eAm
	7juNwJVZvVsZPYZX0BNFZBsUiaqSBqYvq1V9X6MO5goWm5e3RJMnWVXoh4vOTwd/EhMJxkuucw5
	318hqhEpZVE2rTFOePAe1AtLIUSE4sipJsa1k7BLnCT43BiJT8m5dAN2FgglFKsxrXD8ek0Tt/S
	D/39odkHLTstM+0D4fOqyDSlfpM+PeWVHI=
X-Google-Smtp-Source: AGHT+IFKdgMVv6MdZ6th8VYi+G1eSJ+usUdsbGov5YnyFODN1/ouqeIDAQd3Vhyn+lwAM/oVscstn/wc15yDdHf9Va8=
X-Received: by 2002:a17:90a:d004:b0:30a:4874:5397 with SMTP id
 98e67ed59e1d1-31e5076975dmr3527915a91.9.1753264842865; Wed, 23 Jul 2025
 03:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <687a71bf.a70a0220.693ce.006b.GAE@google.com> <nxgsgizgeja6265rgz3uezzpgy33toz7aiicwy6uf5g5orhbcj@qmqipkujhg5c>
In-Reply-To: <nxgsgizgeja6265rgz3uezzpgy33toz7aiicwy6uf5g5orhbcj@qmqipkujhg5c>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 23 Jul 2025 12:00:29 +0200
X-Gm-Features: Ac12FXzuflPvvUMLvR1nQ6j-JAG-PFzkYytPhhrcjQwHerDhhO2eoYNb1CHvQtw
Message-ID: <CANp29Y4K9fU_QFye5E-J00PvY8FcCGtRFotY1yUAa8TmKFwsPQ@mail.gmail.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Write in bch2_get_next_dev
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: syzbot <syzbot+2b98caf09c41174a9697@syzkaller.appspotmail.com>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 7:35=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> Will syzbot reopen if the fix is still in linux-next? Let's find out.
>
> #syz fix: bcachefs: Fix UAF by journal write path
>

Syzbot will actually "close' the bug only once the fix commit has
reached all the fuzzed trees. So it should be okay.

