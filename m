Return-Path: <linux-kernel+bounces-801108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F10BB43FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3592179A24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7421F305E1D;
	Thu,  4 Sep 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UmgIrN24"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B73002C3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998395; cv=none; b=GvQZulFZHYcyXuXXgsgwtL0HBrsV50I8ZUtrrURQFh4X4mzIn3yylI0UwPoqWqAWsPperTiUlUO3pooCK6qGRFsKWPiqkc39rV3ZtBZDhMgASOceIsLfYMwupjL3Jk1mPAJfzyl5YTEmieRf8tww88DdG+/HTQ6RByNbpdnutZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998395; c=relaxed/simple;
	bh=GjIMhldMZjLi/k1VMDA0uSdrpQ2tcOhNKetfFoIFYTw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Dd2HymXs/a8JbGHymWgriPgRA7Y7wEKGyGRSrpUtIgAAblkl+Xu927cuebJxiGsme4Rs9+3C00FlfHLt6wwO9KwC0/o5mfmLwcLcQvfsxvHAEyWVFU9nzIdHvAtjS42MTSZkFSRHx1EJnzoRJRcIwFGfIw9CQFBMivOIzucWDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UmgIrN24; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7f7742e71c6so108102685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998393; x=1757603193; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7YNCGfuLeRJGDFZxThdtxp2uXd/nIXSU1+d/iqpvn4=;
        b=UmgIrN24bZcnKDgQ+hfbmlbI0EQX7VCiJ0iyk6Ht7loHlFNEh3cSEFxt1ZvIsQOUZp
         61rke9doJgKSUWbMEJMYeLPaOsdJvRBpdys1a53xdDMMcIMcdFBwg1V6w37X6zNxMQQD
         m3YGJ/jWzQA8fwaoOVfGDUQTEqtDZgznENXvO6I/KyW+bV2esFgYkKcDcCzIheBzXICQ
         c4XlQhhGBy9+fQ4CCPd+8k83FzrlLRomG6JUoNdYqyn5fAM337Pn68z8FTLAtGOxDD3R
         UJ1xhBPlWvEMAXVyicR16D59bY5BRqTotBv3p6JCgsy8D3MZpuXnOazdo7RH+rDO2+tr
         G/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998393; x=1757603193;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+7YNCGfuLeRJGDFZxThdtxp2uXd/nIXSU1+d/iqpvn4=;
        b=Z4HdVngKV1/pHaLLj3V2r3kNq9VBNhJIooc4qLMGBWeKPuiBOCzgoqFVDka5fhqCo6
         boX0o3Xn+jeENE2v3grH5m0C4mpVthxIAiRMqh4H4N6/dNfJwtl9ft1dTW/cXpDRY4OZ
         MQwajJL5Ta5vF2iQaG0SXA1mzpzfs9hUnbIvGgNfiVVA7nAB9ut9uG1jXyKRy6Jrf7Rd
         e35T1E3jQ7wpVQPVngzh8u/qtcgctnnwsU3SDr8IT0xfj8FnOwJr6PRpAcXr8EfR28WC
         4Z555prJmYMo8hir+KtpO1mSPGyF3b4a/3yFy1lSyfAZxnhk8RHQu7nuF9SQ9H/Y1z1T
         0bzw==
X-Gm-Message-State: AOJu0YzLsKRJiKwMfEXMjEJZ3jcUFpJNyRjb9ZKwa+7IjFHOoq73jRiY
	bB2LwcPLdXzhNrNJLa1R8XM7TxF67s2xRrDCSQ4iX7KmldVgzygujRQBffgiwrl+0Q==
X-Gm-Gg: ASbGncteIRSEn0k2ei3K4917AtHFy6gc754hVX711fc3oLNBOAUtQbKziVF36OUCECF
	q7gHT4X8pRfDChi/PFWjIXsyBMgr+Q/JgZfZe25T7LGYnUQIKxzJXE+x/bCdm9/B5fmeE0YYW3o
	OF1b7xOdewa8goZ686z+ruWEj2qkslr0Y8XCNmXzQnpZ95ckORdUhVcW8JL/lWwKmEQCHZlVNOP
	P2ap072GgbSkzBYXyrwbcZMqJMWItlHlX1RrrxXS9CKUtyd0p9PQX8SyiK1zpNfcIEroM0FRG1f
	oHYeyHrYezP3hhgSTYqj5ybzl4g0xMAux4WMktbvw40854NmSIagAo/HDg4ygn0Qkzj0r/tLD/K
	jy9ts+itYlJiYkgTZxQJfiXNg0ro2WWN5PPcfemkj+m8QkKbl8FnZsJmmuAJ91h7fcwGuo0bH7w
	W9Ozs=
X-Google-Smtp-Source: AGHT+IHEZYUVpRQ02k7NJUaQish8Bi6v9XojrzC/OeiOZRuFggywJiau6M41XffV1wTKoVjcjfFHig==
X-Received: by 2002:a05:620a:1a81:b0:7e8:14c:d1a9 with SMTP id af79cd13be357-7ff27b20216mr2265110885a.28.1756998393152;
        Thu, 04 Sep 2025 08:06:33 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-80aac237b51sm289724485a.61.2025.09.04.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 08:06:32 -0700 (PDT)
Date: Thu, 04 Sep 2025 11:06:31 -0400
Message-ID: <cde565adc43452e83958fbe0ab54080d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250903_1645/pstg-lib:20250903_1606/pstg-pwork:20250903_1645
From: Paul Moore <paul@paul-moore.com>
To: Eric Dumazet <edumazet@google.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org
Subject: Re: [PATCH] audit: init ab->skb_list earlier in audit_buffer_alloc()
References: <20250904072537.2278210-1-edumazet@google.com>
In-Reply-To: <20250904072537.2278210-1-edumazet@google.com>

On Sep  4, 2025 Eric Dumazet <edumazet@google.com> wrote:
> 
> syzbot found a bug in audit_buffer_alloc() if nlmsg_new() returns NULL.
> 
> We need to initialize ab->skb_list before calling audit_buffer_free()
> which will use both the skb_list spinlock and list pointers.
> 
> Fixes: eb59d494eebd ("audit: add record for multiple task security contexts")
> Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/68b93e3c.a00a0220.eb3d.0000.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: audit@vger.kernel.org
> ---
>  kernel/audit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks Eric, merged into audit/dev.

--
paul-moore.com

