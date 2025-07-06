Return-Path: <linux-kernel+bounces-716557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56EAF880E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 08:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C893544DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE7C25FA10;
	Fri,  4 Jul 2025 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMaIgTlk"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888E1E32C3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610852; cv=none; b=ArZ73U0dnB3wD0lMYMgus3UMdkm6hQvVGxNqndXMo8KxKKaeLPGp2I0fdUrbEmSlfMXH+zPJNiDvTIby8PqrziWDvRDfw/hVh/PAVdbwpgl/NGa9wIDcRjS6MtK1XckHn1Yp625w94jBpjHNJNd9GYYYMmFtjQIhR7odZuQFiBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610852; c=relaxed/simple;
	bh=5M8Fr9I/dtlN6rU9kw+YGHD69fp+xGqnTo7cWHU1q0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VndDP3AvWozJWx/x7mm4+VBI/3EbW4X5bVk8Y0PLhnrC5lwJra0kW4ZeTzNSZvo1pr3wxKCFtuuMDHPedInfikHsdBCyyy2rm/n4VF5bgUNPwlp+pWVlyI1HGPjl4IzPPsJRecWKuJZCXTgT1MLJaI5mhXFBKnT8pkd/fZHtCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zMaIgTlk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so697138a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jul 2025 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751610850; x=1752215650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M8Fr9I/dtlN6rU9kw+YGHD69fp+xGqnTo7cWHU1q0k=;
        b=zMaIgTlkzImlZu/AXi4YPdsDo+aIBzXezxpx/CYB2/BxXFk4xtg7sJZ9CNvlbntoIV
         LYSDNSe51R/McAtuaNbZKjaKHhmkGtHkspei+S+CP+BTKvQXBaOzJPG8iFdmmuuH3PLW
         ZBNJKAQU4spl8C10w2zUK1X1ImC981LINvrzELywK0Q4v/0mpo2Zpx91cVeX84vytLIa
         zxeIcW0iKm5Pvc7wly1ZiqCibbKU03V2YBBimuz0oV5erc+qBFaJDL306x4C5yPcjlgi
         uveB370cX3wJTbcpE9GhGR4vD2oAVRP1EiHYgMuA5vBJIltuDrRk0ZW0JoTDeME9LEvG
         hfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610850; x=1752215650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M8Fr9I/dtlN6rU9kw+YGHD69fp+xGqnTo7cWHU1q0k=;
        b=X1FYrdV1H3NKbbrBtBFJwwaNZ4I0BVzcISqnn249m75QimNO7UUW1t5IByDNmfaY6e
         kyZ86Wbch8Pa8J40zxzK//1LO7uts8EEqkMll2IxR7+OrWLa3AIZEuWqMdsnT1tqhuK9
         vSQRnZyUcffHwSReLJYz7IAhCk4y4ZX1Br2BFe0EJCpyc5+29rtxdbOdPDfLOS+BLGrQ
         LsBQ6fLYBdFWMbxKFRqDhiyaSHfyrHgT51mBst2EjBH9dMqJUCghCjz20TSGbg6ZQSjh
         TAIQX1kiPpyGhedcRQnGVSy06oBWOv6n+XhKDxnWemJ/aR/jmMx2h50eV5bOKfJ2/I+K
         5h6A==
X-Gm-Message-State: AOJu0Yyov1/y7Mip5KTgfE/FWgJMd6fUfWFhIm7EnzHOrmIzpp8ykfdx
	dZgAnCgM3j5FMuKvoaVeVwwEfw2IWrFXIf+NiNObrq7uTHpDflR7K8Y6USqn4roPs0YQf+sL6Og
	1WGrCZXXHQ/H3IrwGh70EmeASFgqY3lPkunR9A018
X-Gm-Gg: ASbGncvsHHqvKe39M8mYrJV9dDL8xLLp2KE+Vea3av2gLv2lY7myO+5jQnW+DDz1de1
	vSimAE9ZedDSTnMDILYZyARgzAns4k5a9usweTYQNBukZCgqWvODGWm/Rf1vJdZ7Odm1MjfGzDS
	SqIBEZ/kK/GDHAw7EZtZN/MhHqLU9h6nmEthpnqN5lRwA1aLhE0rDMUN5EX1gbQlSP/c1kqFpmw
	A==
X-Google-Smtp-Source: AGHT+IFFs/KawIynWOhHfGaZuYOow+fzoxajeQIF6PVhYbAcS/f2hMXHIzwk22sZz1g0HIB8ntVe/IhT0BCAJNaeQFI=
X-Received: by 2002:a17:90b:4d8e:b0:311:b0d3:85d with SMTP id
 98e67ed59e1d1-31aac439638mr2599654a91.2.1751610850065; Thu, 03 Jul 2025
 23:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com> <20250703222314.309967-4-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250703222314.309967-4-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 3 Jul 2025 23:33:57 -0700
X-Gm-Features: Ac12FXwN2MLhXm0DuyGPgF2t_e6iJdGzxpwDP-93FsMhv9dosxci8gCd_v4uq3Q
Message-ID: <CAAVpQUAW3HMVzxyqB=jzSMb1RwL9y733icCLSQS-RbsYbwWcnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] af_unix: introduce and use
 scm_replace_pid() helper
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, David Rheinsberg <david@readahead.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:23=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Existing logic in __scm_send() related to filling an struct scm_cookie
> with a proper struct pid reference is already pretty tricky. Let's
> simplify it a bit by introducing a new helper. This helper will be
> extended in one of the next patches.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

