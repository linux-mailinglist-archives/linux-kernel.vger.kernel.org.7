Return-Path: <linux-kernel+bounces-744065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A029BB1079B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69D41C851F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701B262FE6;
	Thu, 24 Jul 2025 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfTxVfcx"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAC25F97E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352459; cv=none; b=IDArp9Zyz5LVb3q7Wj7j5Un748FOwitefBmQkeT07+83aANxIL2CdW5nzwgreSvgq9J8uD2DvLZ2sbR5jqx9xz8W0WPyOdF4HHCHbThjUygV63xDUd/f4tnebJhXvzLtdE7oTAHXvCMYR+GUQbRCaF6afTs54RsSCLpjpKAS9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352459; c=relaxed/simple;
	bh=WYm6W3lhDtWPf0nyR6gtmDQZY04eZ8vBUrCNtxu4k+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEDLtv1wMht+lkQBy/jO8uJRAzwBoC1bxqNOJMfB8A0m4RwfX3Y578F+r9wO7UO/TVVEWRIYuq1gEr7EjTRpa+7+WX+WKd8/GAmFZD2BdtxUP+9iINeYQwjlqn9ol2JQy5vRhnoerwt2zTeV5nuLix8cPG3ywxyeT9eHkE2+5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfTxVfcx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e169ac6009so93376985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753352456; x=1753957256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYm6W3lhDtWPf0nyR6gtmDQZY04eZ8vBUrCNtxu4k+0=;
        b=cfTxVfcxf1BChLQfiC+DF5FzbBYOGwPsUluqoZsbChvQtk8p7nfuz/hys+dAi1QgLR
         wblQKnNtGLRHYvR4dqyqNpE/TafebmJwsZsPKMsnsVA3ZRe41zj5RwTroKkTbavpt7Zg
         KLh8sHjQoalkPGTGGOfCH7NSXNvG2IK3vUUHhTcJuQMXJZ3BCqHF7Q6eIYoc92u2ewio
         gFA7Q6qrdWb494EsyDS7rUpTe40Qhx3/mpYCWdwvbP5Qd2Y8E7sM8rofv+O6rtjKk+QM
         sa6C/j+ZtHFgpLfbYiL47sb3ulGbruUb+wWrKZH1R28+MigBZ/AOV5XyLC6zHzoyXftx
         lYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753352456; x=1753957256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYm6W3lhDtWPf0nyR6gtmDQZY04eZ8vBUrCNtxu4k+0=;
        b=jf5Qyw22IUIQBVPcZWPWnBiMzLCKh5KQSBfp5sLE3zdVjKj+BUtNA6ELNQuv/QotN/
         a9iyFfo0JaOrIIPU9DSrx6tnKs967crDqRngVPvB6PkY6YAIRHm3HqtN+1UFetvbIs1S
         q2njWlk+ZF8DfXOy5bgraHJhGNYNADoVqKMo1LYzWbst/83QSzysYUDhhmE8S2jRI9L9
         FZsJjwF8n7gN/0bL0idkrjgvOBXcw2cqKtQE7E0BxrslNoxz4BvjPNkiK5ei6vuJIjTf
         w+pC2T9SuI1g9wtJhW+dFa+BDVqqlMBTR8CkQf6/F3wUKeX/SjglnnXd/1aFzySFkQhz
         Gcgg==
X-Forwarded-Encrypted: i=1; AJvYcCUGq0STReKT57PEd+/bHLuKg6TCaSASTSanzfDzc5tQEr35g3vdF9TUOXWpNjgM+8VvjJSjAEvL8GyrOn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgENQUh5nuLsXKI3OnCpY4fRdHO6WWXeJbFAcrFx8e9TJnyCJo
	WfqUjn9UA16RZt+tgoJAcIct/soO/ZJON+6oZc5nyH9qTx5/Gb87WpsuBEZRi+F/OCZQlCtSeBM
	EWH1QTVmFHEe2LpAj07HmxZFxRzIdTeLscHzUNN15
X-Gm-Gg: ASbGncuf6PSprBD/19wtuxlUjp9OUcCcmrtQCVu4+WN7vEJRkd1MZCs7HpYaTYI/FZ5
	uJiYmkm7ccjY07IBQ2YkBe2YQpYPfrjQKOAlhbQvFkqK+qxxvvaey7Ih2ZDqTwpexkO7xIfzUUU
	kan5NQv43ZNQSncbXz40U489Js8RMtkE6DEqOILQb6XOYGA+LGG/fCcCmu0Azfa0vTf7KJswE9/
	5XAyaBlgHQwUDhKmgLJxFrlYzekn2w3s87pM6wgLLXdL2uB
X-Google-Smtp-Source: AGHT+IHm/dsVYrorBJCAhcgFQf8u4HKXu0VmjUBu1gYiDjcjTyaS1Vkb5EZMu2Ly0rKWULvfFSmpC24HSdAJiuC+xUs=
X-Received: by 2002:ad4:5de6:0:b0:6fb:33f7:5f34 with SMTP id
 6a1803df08f44-707006ffbe4mr78804786d6.43.1753352456183; Thu, 24 Jul 2025
 03:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-kasan-tsbrcu-noquarantine-v1-1-846c8645976c@google.com> <45cd4505-39a0-404d-9840-a0a75fcc707f@suse.cz>
In-Reply-To: <45cd4505-39a0-404d-9840-a0a75fcc707f@suse.cz>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 24 Jul 2025 12:20:19 +0200
X-Gm-Features: Ac12FXzt-IFrliKGU4TwKEp3QLTmaoCdMeEtiXeM1jbFZZjxX2c_7PM9ohrYsnk
Message-ID: <CAG_fn=UnykD8Sc-8dfkFo-UKj88rdk2j78+AcH8fJ-TOJfFQ8A@mail.gmail.com>
Subject: Re: [PATCH] kasan: skip quarantine if object is still accessible
 under RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 12:14=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/23/25 16:59, Jann Horn wrote:
> > Currently, enabling KASAN masks bugs where a lockless lookup path gets =
a
> > pointer to a SLAB_TYPESAFE_BY_RCU object that might concurrently be
> > recycled and is insufficiently careful about handling recycled objects:
> > KASAN puts freed objects in SLAB_TYPESAFE_BY_RCU slabs onto its quarant=
ine
> > queues, even when it can't actually detect UAF in these objects, and th=
e
> > quarantine prevents fast recycling.
> >
> > When I introduced CONFIG_SLUB_RCU_DEBUG, my intention was that enabling
> > CONFIG_SLUB_RCU_DEBUG should cause KASAN to mark such objects as freed
> > after an RCU grace period and put them on the quarantine, while disabli=
ng
> > CONFIG_SLUB_RCU_DEBUG should allow such objects to be reused immediatel=
y;
> > but that hasn't actually been working.
>
> Was the "allow reuse immediately" not working also before you introduced
> CONFIG_SLUB_RCU_DEBUG, or is it a side-effect of that? IOW should we add =
a
> Fixes: here?
>
> > I discovered such a UAF bug involving SLAB_TYPESAFE_BY_RCU yesterday; I
> > could only trigger this bug in a KASAN build by disabling
> > CONFIG_SLUB_RCU_DEBUG and applying this patch.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Alexander Potapenko <glider@google.com>

