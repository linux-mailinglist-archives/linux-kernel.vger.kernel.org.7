Return-Path: <linux-kernel+bounces-843456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B541BBF663
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777C0189BE2C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8026056A;
	Mon,  6 Oct 2025 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dlcmOhfd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566C257AC2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759783940; cv=none; b=MH3BJnnupf5Wz3rSLdHopAKWtYeeFf99gXalafuKqDb02lDDTsmgdj4XIWk/sFyggI6SOaHWhIS/p5xJurNFnyrn8L053XbvbJim8HJAyNi8AjrNqIJn3yX2YInTIBqcG7EXNHNtAx8rlYeBB4OKeoYLv8bdgR4WtdVEJc4gjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759783940; c=relaxed/simple;
	bh=eopXqYs610smqpBTTXCyoJ4YSv89N9CU5jwYMQsPmaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTr+XPCgujNzO+scwtM/Qcmm1yCBEbjaRDUzdb1tQsFE1iQhVvoejRf4wS1DNLH/LInVp9o9LlzqVst73Mj75FSXlEuih0tgI9r23HuUw85myZmKJrgRiZ0+3ePnpFOfXBSM8y6EYsfjXaj/oKnJ2kO1FKNwkeKypOP8VKKbzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dlcmOhfd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b403bb7843eso1111290166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759783937; x=1760388737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28uZ8S6zg+lnLWgtyv5+s++GpisVFfNjp0/ZtTqXDf8=;
        b=dlcmOhfd9Ql/df9wEYKsrztk4blFGrU+5GqCu8Yz9aYy6s39/0GqKtPlUM/KxRC5xT
         sdf6mt5CGWaRN1Vc2Y2bkbi0lQQ06k07n3A0tIDScZdKmiR7sk3uTMF+lWsxS7ep1aB6
         2Pu3C5hszWAJAgpiL0GN/JBYgEqhoGpw4acmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759783937; x=1760388737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28uZ8S6zg+lnLWgtyv5+s++GpisVFfNjp0/ZtTqXDf8=;
        b=gCyuG6NY7dFxRPJNb4bMtEMWWvivdppmn36KkLcyEe9GWoGYZ6evH6Wmkw0peQTF4v
         uRvyc91TQl8KaVFs4dshKFOiSmvMwHKh+y/HsUv82y8axFDy2ASqlOTpAfiHSk3EQqEk
         aMrq+R0HUzY9hxDlxiEs3Ki4GmwBb8uHVyflETMHw5H3I2Wx7tfMI0nTrsZK7WFAf9x2
         OEPCfYyeF1goPqMeGirnhXF6uTRqiAi+Iku9fn7yCnTkUk3izNh5hcxhkH87Nk0cJH6S
         nCgfyYzhvcrREyBtLEeTXKGo6boSlH54xhmbCPmy5e9o66tPW1ZXpUTzcv68Hp05TScm
         utZQ==
X-Gm-Message-State: AOJu0Yzisd0JYK7Qzv0qoYykbT/dxxhh2v872l4rYBI7yjMmPWv2bO5a
	Y5wTh3vSYeo/Uy93J3C4tg4R7rUXdGAed0fVOAsAykalXOtMbEkZGUk6blK+nA8hbD4m4rulUSc
	0QDIBG+8=
X-Gm-Gg: ASbGncslkLZXTbj+vdUo8BebKbyIlpIopGN53e50tpLJHz0WpBHXSWCDBTMt39Tg+H5
	jz+JKluykPZ5vz/H9msoyh6Fb+p3Q/KOTsFf3O4Gtzfa9Ykl9v5pi28PB4AhIvtjWLCCYOxdC8S
	cggDx7fdK3egFCC+g5vdxK62vMQqWxAabyEki19xEwFsBMWk8TH93x1ZjrZc4vgeY1gFTIWlsT9
	/2n8Zt3ugZKwQajmepEJI1PCIxhZf6PgUeLPDU9R3OWekXwF9UrtGTsO275FFCGPosbyokyBczU
	WlTHAvFbrtmPRopz5IDcFfz4+IZjTKBPS8tpKbNKBODt9lZ9FYAPSyIfA8aU47n7IJMWzSt+Ywy
	2QA8k7V/rYpkq/wpNzVrnn77EhEWnKz2SGOHKoudJJU0z5jP9NzmazSFAxca1zFYsu4plQ4AeTd
	nqXRSaDs7wFq+cr7RINL9mVLrHva1XdXOX2pjOhITkig==
X-Google-Smtp-Source: AGHT+IECS0E/08+1HrKnUqYa7PhnvqII3KDkIEDqZdvbS9H5du9ZGKwHBffpK4Gi5pFJ/edHQFBDAg==
X-Received: by 2002:a17:906:6a02:b0:b45:cd43:8a93 with SMTP id a640c23a62f3a-b49c5267f61mr1703012466b.62.1759783936815;
        Mon, 06 Oct 2025 13:52:16 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a177c62sm1201847866b.91.2025.10.06.13.52.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 13:52:15 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b403bb7843eso1111284166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:52:15 -0700 (PDT)
X-Received: by 2002:a17:906:6a02:b0:b45:cd43:8a93 with SMTP id
 a640c23a62f3a-b49c5267f61mr1703004666b.62.1759783935038; Mon, 06 Oct 2025
 13:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006135010.2165-1-cel@kernel.org>
In-Reply-To: <20251006135010.2165-1-cel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Oct 2025 13:51:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
X-Gm-Features: AS18NWCdXOOHQdpXutgs_Vd4CxaltjeaTJ7mu_wP84QmQM4uVS7nGJ3EOSnaKFI
Message-ID: <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Chuck Lever <cel@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 06:50, Chuck Lever <cel@kernel.org> wrote:
>
> One potential merge conflict has been reported for nfsd-6.18.

No problem, this is the simple kind of explicit conflict (famous last
words before I mess one of those things up).

Anyway, the reason I'm replying is actually that I notice that you
added that ATTR_CTIME_SET flag in <linux/fs.h> in commit afc5b36e29b9
("vfs: add ATTR_CTIME_SET flag").

No complaints about it, but it looks a bit odd with ATTR_{A,M}TIME_SET
in bits 7 and 8, and then the new ATTR_CTIME_SET is in bit 10 with the
entirely unrelated ATTR_FORCE in between them all.

So I'm thinking it would look cleaner if we just swapped
ATTR_CTIME_SET and ATTR_FORCE around - these are all just our own
kernel-internal bits (and the reason bit 10 was unused is that it used
to contain the odd ATTR_ATTR_FLAG that was never used).

Danger Will Robinson: hostfs has odd duplicate copies of all these, including a

   #define HOSTFS_ATTR_ATTR_FLAG   1024

of that no-longer existing flag.

But hostfs doesn't use ATTR_FORCE (aka HOSTFS_ATTR_FORCE), so
switching those two bits around wouldn't affect it either, even if you
were to have a version mismatch between the client and host when doing
UML (which I don't know

Adding Christian to the participants list, because I did *not* do that
cleanup thing myself, because I'm slightly worried that I'm missing
something. But it would seem to be a good thing to do just to have the
numbering make more sense, and Christian is probably the right person.

And adding Johannes Berg due to the UML connection, just to see that I
haven't misread that odd hostfs situation.

Comments?

            Linus

