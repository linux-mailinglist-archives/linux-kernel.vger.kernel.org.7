Return-Path: <linux-kernel+bounces-847173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BEFBCA2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2038D1A63E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BE522541C;
	Thu,  9 Oct 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fasheh.com header.i=@fasheh.com header.b="JHInrfvi"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659822127A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026720; cv=none; b=EcBtDqbKQt2woTnAx4loH96TellVYTZj/QVQP/j/IzNdKVSWiqGk8IINZl1oh6TJ6ukUSXagIF58DAUvdkjT7o1CUOh3RQCDzxyeRnibE0dGfDPonyKHVs6+gcn6SQVC4J/UiHPWYeIQoejR+kkRakOTs9XujtdI5he2XtpA+DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026720; c=relaxed/simple;
	bh=kxVHxMc95GGXvIkwI+FLL8BN/0LlIRrn4Zoc+7oMMro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEuFKwjwccE7/H5afC23B2DVUwkOboBiZYfjd/SgU3PesjwW7XniDs9vffPbGjvTijtrMZKQpTm3IQvGQzcT+PD2RMjDzS0qNFiaHAQpyGQwAisPquOIVqkQ6gJsuWwWQEpN2noAVc5zhC3Nn8pMJCs1mBQsUPgdXe4J34uV07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fasheh.com; spf=none smtp.mailfrom=fasheh.com; dkim=pass (2048-bit key) header.d=fasheh.com header.i=@fasheh.com header.b=JHInrfvi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fasheh.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fasheh.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ddabf2ada5so16775481cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fasheh.com; s=google; t=1760026718; x=1760631518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+yglEpiCczijhLlnigG3G/VKFVz3v4OuKtLzp+LX7k=;
        b=JHInrfviX6zlsHM0AHnRK20F1Veb78Zjz0wHy9UtWfTlNplgnEr6DFpP+7zSGloD24
         WOb6cHyroxxGGDZPwPyeN5+m4g29iHF4h0o7Fd/QrQq1quiCmf6GLi3a7n6hbG5AIsnr
         iA0DH4r0hqY0FbTz3Kj4fPwXPAiogaRhfQOjkoCHrjxYZeTqduK6IJrIzfqRsE9cO82O
         pBXGyT4WnkDQA+xqLV+w1rF5kvAtpZ3YRDQcV9lNB1eqGU5gkebzBp8aUFOlBSAzjxDf
         uZyOyNfbWOY1ujiafGcPtE2xoSqQcALJrpAKU+hCvaVbL/r03DC/qVrvcuY8WGkvzPyT
         glaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026718; x=1760631518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+yglEpiCczijhLlnigG3G/VKFVz3v4OuKtLzp+LX7k=;
        b=PZTkWGTQwhKfsUSZ+xZ25b+kRPxgxVopYy7tj1U+YzwGbCz4RcsSVym2JJkeJvBhzr
         202Ym8556oG/O9EUvZ3AVHL3C+TXyGf+wfTFyoi1/nrHBfleKV4AmRmJ2RTxN1lBKBQr
         7FI8xw8lfXbcoS1atTo603SYXK4cZ+iDzvCZkN1OzJVpgURxJrjNIgJx41kszPbN53Rc
         mNLYPJOeZ8efqFJ9YD9o8UVpLMKlIE797tJp79JWi9UxOGTUzqtigZyJeZeggyXqOeO+
         iV5rjIY3hYvQRJdktoh0maDyevyTu/ME8vw8npErGP8f6kEfbvmgUx1EL+Q4c1swq0M6
         L1rA==
X-Forwarded-Encrypted: i=1; AJvYcCUv6+WfX0RKoUcxBIRM6EF5AoMhv1gAxfqT10EUm44NtVwOfIvFR/GG/7ZxzvKPLTeiKKmls2qvK3mO3e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/fjx8SWvEwrojq75Z21yQZp/iEgMsPVDOnY/pyZcb9yfTFBE
	5dZ0VY5zJoguSEPvExff6bcFCUltMqg4Udc8DOpyTtGVm2JvvWqMuU90/8drS+ijGbTFNCctouS
	CJeXcag84yvwHpY6juVfUjMo+Csf6ATUc+WnsMdYK9Q==
X-Gm-Gg: ASbGncst9m9RXkVmqIyIcIVFNAlyr6P5h1ZPKvmtKk6UV15ySIvL34tF41MUIo2rpTi
	C/g7Jo/Kh6ySfsEalT8EaQFsaudrfe2wwmXm6I/Kt9rg5TZrtpbQqMxB149Kba9S6ioGa/S7yNZ
	+sdNXQlcbqwZT+sMQT+qFnqyiFMgl1v9anH8hmoVZXA48S6eXBrjFEG7f+FTw0dLInm56zz9YO9
	Q6DB6ZdBc7hPCKxinzxyovc0ozzyT/8+do5BGOwGyP023GCBchJew76PgCton3R
X-Google-Smtp-Source: AGHT+IGSDZQ91zkPiorf3Ebe4MIrTohmsmEWtbBJXTxxH9beyjPQsa9hq/WsR7pKHUgmveibuCGt0jSW8LvPr4NIfEY=
X-Received: by 2002:a05:622a:1b24:b0:4e3:970:661a with SMTP id
 d75a77b69052e-4e6ead91fe2mr116013621cf.75.1760026717692; Thu, 09 Oct 2025
 09:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009154903.522339-1-kartikey406@gmail.com>
In-Reply-To: <20251009154903.522339-1-kartikey406@gmail.com>
From: Mark Fasheh <mark@fasheh.com>
Date: Thu, 9 Oct 2025 09:18:26 -0700
X-Gm-Features: AS18NWA5Pj-hSBrzbQwf_Ctu81wdTtwASD3kSEuUG2O5T0FbiO7a4qiMtv8BTWk
Message-ID: <CAGe7X7nk+XJdGX0vGFy4geXfeWdHBwC4rw6CoALr7L9M2REV+A@mail.gmail.com>
Subject: Re: [PATCH v2] ocfs2: clear extent cache after moving/defragmenting extents
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 8:49=E2=80=AFAM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> The extent map cache can become stale when extents are moved or
> defragmented, causing subsequent operations to see outdated extent
> flags. This triggers a BUG_ON in ocfs2_refcount_cal_cow_clusters().
>
> The problem occurs when:
> 1. copy_file_range() creates a reflinked extent with OCFS2_EXT_REFCOUNTED
> 2. ioctl(FITRIM) triggers ocfs2_move_extents()
> 3. __ocfs2_move_extents_range() reads and caches the extent (flags=3D0x2)
> 4. ocfs2_move_extent()/ocfs2_defrag_extent() calls __ocfs2_move_extent()
>    which clears OCFS2_EXT_REFCOUNTED flag on disk (flags=3D0x0)
> 5. The extent map cache is not invalidated after the move
> 6. Later write() operations read stale cached flags (0x2) but disk has
>    updated flags (0x0), causing a mismatch
> 7. BUG_ON(!(rec->e_flags & OCFS2_EXT_REFCOUNTED)) triggers
>
> Fix by clearing the extent map cache after each extent move/defrag
> operation in __ocfs2_move_extents_range(). This ensures subsequent
> operations read fresh extent data from disk.
>
> Link: https://lore.kernel.org/all/20251009142917.517229-1-kartikey406@gma=
il.com/T/
> Reported-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
> Tested-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=3D2959889e1f6e216585ce522f7e=
8bc002b46ad9e7
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Reviewed-by: Mark Fasheh <mark@fasheh.com>

