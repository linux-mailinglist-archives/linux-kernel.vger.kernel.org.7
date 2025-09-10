Return-Path: <linux-kernel+bounces-810974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E199B5229E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4907E18992FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1A2FB083;
	Wed, 10 Sep 2025 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JH+b4YIT"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE32F83D9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536953; cv=none; b=cn6MvGbdNU1MVJOxGc9Fq84oOvxA//vFb/IOHN4xMV3fLurSJ+QB3lHa3ewu2PLsKGn+Hf9nDVUl0eNcNid0hPYav4o/FJS14RVVnTCAIdg9M3JYh+A7k/7AzzrqV6qQV1jJTJERo9xCZ2PIl55S/uWpuvXF30GBeDmbMVgfSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536953; c=relaxed/simple;
	bh=C88Z6yKSJr7bB/FUWb+rZ6Hdjykf0Z3txcxqaDpT7Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVNKj043xBjDkNMP5T+Nc2lnnM2m7CT8KAx5N9irCKzLv3DnBl5aV9dals/Amjr9a1tGmfMz2tLZDfs4jXjYk37JTg+l5zegQWAyfhrFKWtq1Vt2I9xh0X6QT5fRU/ezBO84DfISPDMoOr/oUon+xPbBrta9s4wVaPpaomTUkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JH+b4YIT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62bec18abe6so5125052a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757536948; x=1758141748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQKuGly96CNimNGwzLAgsvxPKJmLcpk/7vDNtAXEJDU=;
        b=JH+b4YITZV31e5mp7HoptSP7QkzTuMEIs8LoYHFON6Yato2UjdhVK83WJAB4ZnAamS
         LErkMsSI0v15M63rZ1XR0GHFAh6eFAMNUkJLABtkCIdfV8gYBp3Y1R1++UqFtanhmmc2
         Fnzy+/T7t9oAOSKW8jbcn9BoP7ifKxr+Cyk7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536948; x=1758141748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQKuGly96CNimNGwzLAgsvxPKJmLcpk/7vDNtAXEJDU=;
        b=K+uKox08sgYDY6KLT2gdOFHiFotF8X9XsOn2K7Koy14NrbSk9+h69dkbrwITnyxhrD
         GvLYoWYKVgPleKaMoXnieHkmq5EvduD458vT1PJjaQ0TzcclM1zVwMjmsIW6GQ7kl7vC
         Od5CGdepkn75lTPHS3V2ZN4iArBsSLmjjtxj4DvAtACYr1hBTagULGXl5NbaoEPenjls
         lfmd4H1uF0D9HMzwP3s/xovHnhL3IrHtkE5xrOxnlF1hj8oRtqUZK+LKJjXcxZOWTITJ
         mYRc1EjqNhnQz+Mp+AA5gS+Zxvd1MiGeQp2Py4f3SksaFlrRpMC4hV77x48lE0vD6LMH
         /rbA==
X-Forwarded-Encrypted: i=1; AJvYcCUmjVxFBlEbCI0kBy174QtEfmeBxU88bQ+SokTHD1OejknlsTaJmgfB7/B+BnGAN+BcwaspPiwsU6U3zbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsTnx5Kx0qyWN5K6KTJkYme3dkJeay0mK7NYolkWUtw2VoTCe
	z41PHjV/cK40T8kiX+gomXXN9ng4pLv4lrvJWIle3YiwXz4COJsAqQxBnDjs4HDuO7vEpWlrXFM
	WcCzqARoUYw==
X-Gm-Gg: ASbGncs48Q4w4ydlPqCQdIjSb8ksJpBZ69N85zJJ2quiZ2e3vvYDiSj5CAMGUhWlsJP
	mUVyNAtX66BCTRlJtEFmt7GDzdT95pirKEz4TicOCdGag0tjmFJS8Ag1eAdTbeZj4OjSpQztM+q
	w1ucrg3xiE6xDC9K4LPq8Uu6d5/COQNt+yqdigLxo4Y8U+9wOZB5VlboprHid+2TVWYKC3PvOtR
	3QiWOCsJXuXEW+2BVfWtXnvDBxTUSrtqfhOHC8nOGmypg7IrAsU3uFME6/a6uNl5njOhDH/Y4BP
	aCNS8MRmc6lsQ1kLrqSdOWZGCf+zXKZQTLj6QwjTA3DzNezUKsWodtzIp/QnvEx9vz2uqbc/f5y
	Z9oqZgj30ilozcCke2ScVbMp2ea6wreuFGbDDroRsNdizjnSAde/htipxE1z09+erZ1uaCUPopC
	Vn/EowZxs93qtcircT7Q==
X-Google-Smtp-Source: AGHT+IGT6mxgQMQms7zczogFHYTfH/n4VaYwK/lC/sgyhWGD133NpVIm/FHFaMHZi+RWqVlU7fW5qg==
X-Received: by 2002:a17:907:7f13:b0:b07:88ae:4b80 with SMTP id a640c23a62f3a-b0788ae5ed1mr342331066b.65.1757536948445;
        Wed, 10 Sep 2025 13:42:28 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078304655dsm234054666b.11.2025.09.10.13.42.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:42:26 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so353666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:42:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnijfEtun4xKTI82JLaXsmCmYH99S+faJIoll9mMx+GZp1Y2TXAdTew6aFVZ0ibo+ofq8N44eELlEHhmw=@vger.kernel.org
X-Received: by 2002:a17:907:70d:b0:b04:8c45:4bdb with SMTP id
 a640c23a62f3a-b04b1666fa4mr1469786966b.34.1757536946156; Wed, 10 Sep 2025
 13:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909162155.76756fe3@gandalf.local.home> <CAHk-=wi0c5oBqQiZctP1SYAW7XGHYEDchJWBUSXvQA-XGmNk3w@mail.gmail.com>
 <CAHk-=wiDe+V=kc1HL-jT-C9Pn1AibAU_6CG4Bh9DLeJHfhrHWw@mail.gmail.com> <20250910162106.6624752c@gandalf.local.home>
In-Reply-To: <20250910162106.6624752c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Sep 2025 13:42:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMwTgHbkZ+Cie6EF-T8kF71Egw1e_KBtVufxX6kzSAnA@mail.gmail.com>
X-Gm-Features: Ac12FXxzxolGVbmyvt9tl-VWN9U2oKAtrInN6tOA_54AXjMph1kMGfVf3LCFEzs
Message-ID: <CAHk-=wiMwTgHbkZ+Cie6EF-T8kF71Egw1e_KBtVufxX6kzSAnA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Guenter Roeck <linux@roeck-us.net>, 
	Luo Gengkun <luogengkun@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>, 
	Qianfeng Rong <rongqianfeng@vivo.com>, Vladimir Riabchun <ferr.lambarginio@gmail.com>, 
	Wang Liang <wangliang74@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 13:20, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> We figured out in the discussion that the user that triggered this had
> CONFIG_PREEMPT_NONE, where in_atomic() always returns false.

Ahh, ok. That explains it. Then that in_atomic() ends up being a no-op. Ack.

So the patch is fine and should fix things. Good.

            Linus

