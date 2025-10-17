Return-Path: <linux-kernel+bounces-857454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498ADBE6D71
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EA31897191
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA038315D52;
	Fri, 17 Oct 2025 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTaWssND"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D231691F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684108; cv=none; b=bSzgLnBgg9+HTjKDvsiyrWfmgkUO3JgS07eQ4xYsuIN9Vd+4R6wICFz5rVDn1ckf+AYyW1Fo2mfSSYy/KDNne4a+NDa1N9j2dcwhX2K249YPL9kHQ5zUCd2f3k8Cord3SHvzs0ZIf34mVvel/o90TEcTa4x05RNWztTZX2exV+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684108; c=relaxed/simple;
	bh=8tn0gsWadcmuVvf+2fan/jdMsAl0+pqxz9YytNP2Gok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvEfOj7Pfeo/1Hcu8I0pAObRjUNvwq7dXbImSMcEvu+q3mwUJRMnLIXWeSCh1cO7uwLu0ngxaaaqmEeMzDUjUvs7WQ9QeKHO6MQ4Q2ILIHnA4I0EcsX0iRwcXt5XzGGQ1fVgg+leXpTAse9cdDH69XV97LEeh1/SCA3o5xNAxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTaWssND; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b679450ecb6so1211579a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760684105; x=1761288905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAqfv53kZsbzluNJMMw+hqN+0n9Obgjt6ztN3dEZZ3M=;
        b=VTaWssNDzmVvKZR3UXVprut0l4vOhrLgflFvQZV7740D+i/vXESZM+WJmEEBZU48kU
         vJSzqR/c+I0Xz7+OxJl/erepGNNP09oE30+1GKGtyLgPjR0aZoP/7DmP4L8hTJl+Hxwv
         HKgljNr49VBtWPM+cxK1jZOnK791/EMuBCQljRwl45WoKHidiYKUcwEj7r8ZSYQ3pRI6
         kC9rsMSPxjO1VZfMFGWEh3ocABHBxc2EZ38ixgEdOc20lkBLkcZ3LLkXhBARs2GEUq1j
         Tfut44c2d4xwqoNrLPmRlMxp3YUA5qPnN9QyxM5g8F01uo3T0jMevQs62jO0Vc+eYuKJ
         n8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760684105; x=1761288905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAqfv53kZsbzluNJMMw+hqN+0n9Obgjt6ztN3dEZZ3M=;
        b=R61xR8BCu0wejFOittNmauQOkusTFZExqNaoXJSaEL+G5OUZ9Ifi95zjLryZfrr7yY
         RU22amLg+wtVRLH4iG/ZNIS+vjk3S5F0S9+u32f1jD+/nkHL873h69JgFTovH3TtMIj7
         jPnjVEU7q5hU41Z/XxifV52ELrizsxIc1yYIj+TEKjF4u/CD5MEA6dN+mfSu7CZnarn6
         QC4r9Ur1yL5l2C5kkbfcetgJZAIeSNEayxqXyqUyFNhxSq3zINViofC/fN8VGG/W3Hba
         jq9Owkah5V09HslFYvcGIKKYV1d4WymasTvML78J5jMeFU8ghgWMWOt9bwBb6Df+6Q9x
         0G9A==
X-Forwarded-Encrypted: i=1; AJvYcCVjxfp7qb6/Xu4/sk001TzA83akpjUX4t/fifBLD8BNyAS5BIKVi+k+Tg/WLnglIsco9+mCz69G83TU0uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/J+81i6kHjCWhkjkWcjmacvOpILIa63R0RIktB02z6fGSQlN
	fP76aToB8ICsxs5bpz6K19/XwirkZLh32WYT7NaEsPFVt0sR0EiHn4ey1Ea6h4GSO/2ifGkJ4u4
	Gx5I/Lq0rnhNM4LJtc8p+ESb4itiVVhfx8tDersM=
X-Gm-Gg: ASbGncvXArv5P38E3I7rNpF+L5wgYTrfCIhkY/SvJhg5RqDreT4nKXISgJHhFh8KYIS
	UmxSxOgOWqPSbwTtas/dTDrBbc5YNwvSzr+C6YpT8nPr4R1m8+FNuB2PlNS2GtBNU6eMP/IQKPQ
	Ur5w+1eRw2h7JC7D/irn3w9FeZqtZjvVgJf9WIJ4Gm6PXoE9T86FvpFr6TxoVd1LJU+9TraRGDC
	AC8q8BCk/F5QXj9uvY4zb8+NlmL3CMWGGtJOgsTcUWtNZUvgs5NAwO3/Ak=
X-Google-Smtp-Source: AGHT+IFA1wbUFs0rKwKqAf6a9VqNqes/rB49gdi9wcqB+3od0alN9RlDJV05z8oscCylAZCpE64BJvJsh33fzkKAz/E=
X-Received: by 2002:a17:902:ccd2:b0:269:a23e:9fd7 with SMTP id
 d9443c01a7336-290c9cf2d7bmr32033405ad.26.1760684104996; Thu, 16 Oct 2025
 23:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016131651.83182-1-pilgrimtao@gmail.com> <aPHh1eTQRDO3z6Yb@infradead.org>
In-Reply-To: <aPHh1eTQRDO3z6Yb@infradead.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Fri, 17 Oct 2025 14:54:53 +0800
X-Gm-Features: AS18NWDZdxBzJF4fAJo9f2GgN5oBARXmET52Mi5LxrI2DP2bqSoRyMbXbjTk_DU
Message-ID: <CAAWJmAZDt4yiqNr0246Pu3WQZBG11Wnhkk1VB9fxTQLg0+qwvg@mail.gmail.com>
Subject: Re: [PATCH] block: Remove redundant hctx pointer dereferencing operation
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, dlemoal@kernel.org, yukuai3@huawei.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:27=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Oct 16, 2025 at 09:16:51PM +0800, chengkaitao wrote:
> > From: Chengkaitao <chengkaitao@kylinos.cn>
> >
> > The {*q =3D hctx->queue} statement in the dd_insert_requestfunction is
> > redundant. This patch removes the operation and modifies the function's
> > formal parameters accordingly.
>
> What formal parameters?
>
> Basically you're passing a pointless extra argument instead of deriving
> it locally.  Why would you do that?

The value of 'hctx->queue' is already stored in '*q' within dd_insert_reque=
sts,
we can directly reuse the result instead of dereferencing hctx again in the
dd_insert_request function. We can eliminate an LDR instruction.
--=20
Yours,
Kaitao Cheng

