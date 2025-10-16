Return-Path: <linux-kernel+bounces-856920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F829BE5756
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4595242422B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58F2E0B60;
	Thu, 16 Oct 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1O7csivf"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE22E06C9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647902; cv=none; b=uRhSBwbyt/QS8zfVQwA9OxT3xKn8NwKurzpOY9Tp0U2MIRab4WDWSaW7e6yFu7zzr6BmzURc6zDr5K6jNboBzG6V7X7b3wyKqrkmkDNdGDHeAjGGb/fJC+fpgw2VFJLevJngrjXwl3t6KnEVKOx0LfYWmQdCtPmjRGcYDHtfdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647902; c=relaxed/simple;
	bh=GhHU4iPjORnVvj7EJwyv1YvPZ+2TaweSCXtFMjYeZ2M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fX9/ofl2PdDZX2c5Z5kUG5MT9k1qt23l6v8LkPqP+6HrFj4vjbA/40Ri6g8oSnsBcvoAACsae3Z2IrZA7zLW7xDgmTZMqv+qfKraV3+n1IxqTE/TBulyR0wicu2lgzgsxRVic4cHWprfJ+1vC0PtC2sssQ4Y8Jupf2e6IZ21Iec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1O7csivf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28eb14e3cafso21904285ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760647900; x=1761252700; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6nZbTmQDZxpmi+1ka7zwVrmO7uBI2OvTRVg33KzmXjQ=;
        b=1O7csivfcABSyWq236e4wxWge/haoITTgWYP/x6xeQXQ95wN7B8PnYx9TdQt8W7Eg4
         rFD42D7LF+tU7HSUjxSNnD34rBkaRHx89WrdxweN5yijFhaaI/5lXMxw5h/44h16UtED
         iJmIEopRPNmpxNs49JAvVurT46i38xffbE/L6+Qn1S7Ahz7cpzdXARdofqiJPHBjyrEK
         RgPS8y9z3MO52LKjy4nMlkfkH2kTvkgNUKUw9pT2Hs6FudAoqq3W36/KJeQV2ZFWOGmv
         QkI6ZlJQPqrXxljQWbdKqBHLG2gO41lSsvUKD7rXf515JVvDblypDoYWqistelwhW+U7
         zgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647900; x=1761252700;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nZbTmQDZxpmi+1ka7zwVrmO7uBI2OvTRVg33KzmXjQ=;
        b=f3ivb5LhpKAWfuRvZXNW+YTUch7S03mUvMOC8U2qIj68X+27ej8thWHMtv3N0SSqeT
         osa78hO519DoUl+T2Vb4lvlyN8jFXxpFTW2DYHp728xAKiiR6C35XIew0WH2n+Ceku/Y
         savyIzbBqQYt9WEWVOHaylmjMZZpuqP2S/9SX+eOxgtE3dCYIu2VKtkXX7RRTOc6wpWM
         67CL2qN3c3jNX/V1iFvM6XPwEiQcXP3JT6x+rgN4QRPJzCTsGh1NqROGE9iTJai5l5h2
         27+lxe2he+K+Go6S/2HwgHTcjCNtOEqRgYOzuO5uipzFUUos7UuB1yBqcBAGp2ftivD7
         v7WQ==
X-Forwarded-Encrypted: i=1; AJvYcCX413QQ/Z5Fc0pOU/PhiurZAWG7Ia/6NshE77KjcuIkQnF9QmbY7f3x8JbKeUtDerqal4bZaStx0XnOZlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnq+0eybTgU0XMctSTjlfomZEMau79buAjqmzYx9XKiL3LRvE
	ARN/HFv8zswnw6fZVnyUHcBeTbnIr/GHnBZcGU5UThb0Flq1AJjScz66iwXbmM72XtG4k9CaOnS
	DPoCJhwFUOA==
X-Google-Smtp-Source: AGHT+IEHfOY72uJUvBCnJ5ENVW0fS20nzW/B9v5h4y7BfTJmI1t6+XwAYww7St/6smNRI0xBD99JxPcLvBGX
X-Received: from plpw9.prod.google.com ([2002:a17:902:9a89:b0:27d:1f18:78ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cf:b0:27b:472e:3a22
 with SMTP id d9443c01a7336-290cc6da03emr14255865ad.56.1760647899791; Thu, 16
 Oct 2025 13:51:39 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:51:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016205126.2882625-1-irogers@google.com>
Subject: [PATCH v5 0/4] Switch get/put unaligned to use memcpy
From: Ian Rogers <irogers@google.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

The existing type punning approach with packed structs requires
 -fno-strict-aliasing to be passed to the compiler for
correctness. This is true in the kernel tree but was not true in the
tools directory until this patch from Eric Biggers <ebiggers@google.com>:
https://lore.kernel.org/lkml/20250625202311.23244-2-ebiggers@kernel.org/

Requiring -fno-strict-aliasing seems unfortunate and so this patch
makes the unaligned code work via memcpy rather than type punning with
the packed attribute.

v5: add a patch to make parisc still use a punned version of
    get_unaligned_le32 for an unusual boot case they have. This is
    untested but suggested as necessary by:
    https://lore.kernel.org/lkml/202509051042.7KOze0fZ-lkp@intel.com/
    I wasn't clear if this work was picked up, but I don't see it in
    v6.18-rc1 and so I'm resending rebased as v5.

v4: switch the type/expression variable __get_unaligned_ctrl_type that
    is used by _Generic to be a pointer to avoid 0 vs NULL usage
    warnings - always use NULL and dereference the type. This should
    also hopefully address analysis bots complaints.

v3: switch to __unqual_scalar_typeof, reducing the code, and use an
    uninitialized variable rather than a cast of 0 to try to avoid a
    sparse warning about not using NULL. The code is trying to
    navigate a minefield of uninitialized and casting warnings,
    hopefully the best balance has been struck, but the code will fail
    for cases like:
    const void *val = get_unaligned((const void * const *)ptr);
    due to __unqual_scalar_typeof leaving the 2nd const of the cast in
    place. Thankfully no code does this - tested with an
    allyesconfig. Support would be achievable by using void* as a
    default case in __unqual_scalar_typeof, it just doesn't seem worth
    it for a fairly unusual const case.

v2: switch memcpy to __builtin_memcpy to avoid potential/disallowed
    memcpy calls in vdso caused by -fno-builtin. Reported by
    Christophe Leroy <christophe.leroy@csgroup.eu>:
    https://lore.kernel.org/lkml/c57de5bf-d55c-48c5-9dfa-e2fb844dafe9@csgroup.eu/

Ian Rogers (4):
  parisc: Inline a type punning version of get_unaligned_le32
  vdso: Switch get/put unaligned from packed struct to memcpy
  tools headers: Update the linux/unaligned.h copy with the kernel
    sources
  tools headers: Remove unneeded ignoring of warnings in unaligned.h

 arch/parisc/boot/compressed/misc.c   | 15 +++++++++-
 include/vdso/unaligned.h             | 41 ++++++++++++++++++++++++----
 tools/include/linux/compiler_types.h | 22 +++++++++++++++
 tools/include/linux/unaligned.h      |  4 ---
 tools/include/vdso/unaligned.h       | 41 ++++++++++++++++++++++++----
 5 files changed, 106 insertions(+), 17 deletions(-)

-- 
2.51.0.858.gf9c4a03a3a-goog


