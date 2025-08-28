Return-Path: <linux-kernel+bounces-789881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C8B39C14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D11980557
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B31C255F39;
	Thu, 28 Aug 2025 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMnCl7fR"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6E30F527
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382351; cv=none; b=ivJg10tp4uNCjd8Ie2JPRzU0Fzgkksun/3VX/yXFIV65icUjXK9RyG/1hTk/WJXO8t/g1ZpbOypHa35pOo/NQkQ7YoSV6Fm1ZMzThK5Y/5+KVWrm86DirITwwGOJoFh0VOCktwqHE0mKC36pQOmUABjEcRqQJCJQj2v9OREHCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382351; c=relaxed/simple;
	bh=fvV0uRWZb9zMA8GIt6R7az+dNPAac4K4DKVbyx2Wsso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DPso6oqtJgYnj3VMlQDVU8aL1Av/gG/EYt9ldvASxprmRtM4UUWmy8jZJKQ/w5lbjXIQTtxkYMOvpfOv72LpcGiTYYJHbHFHlBIx6I4WT64Bx7aRi0D/KFf6rn3+l48e9wpqQWA6PD8Eqt5kEa3++/8PLniwZykfWmdKabAYhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMnCl7fR; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3cd08f3dfb3so360799f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756382348; x=1756987148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+rtF09vsyR3z1vquzLvFEkrCt2s4j2fQ8fnMbWB46M=;
        b=fMnCl7fRmlKZVJ9Sv1vnj6bWaqUO5jESCsSOmWDQPWhIVh+N1rSkcpPioKkyQn4KFZ
         vYkF1tb7m/OBHip+dmSJ6v/qnUAzNKWKO6ljPCX5L2cT5ny5o9xKNh0+IV5gLQHRMBV5
         pyoV3iIMnhiOU2cSNxWmwqRSwZAJ1s6xj9I8oTxJf+Ge33TdP6rdUyG4y3w9cKVegDry
         mq0t7Qda4nfKh4OvGNAtvy9gKQYchlYXyTtOvKWCn4I9zQqGwmixutEDO/UlR6Qn6nQV
         A8k+jmeEavlIg6V6CpJE5OET3+eAIrJ7txCMJrjcFq0aXsCVaW+nUYSyUl2CvkMXLnKm
         bj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756382348; x=1756987148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+rtF09vsyR3z1vquzLvFEkrCt2s4j2fQ8fnMbWB46M=;
        b=usEQnXKjyh+hi3eWmodhCeRaVZX/DEz74UX5v/4a9/taGutw7OXlsjJMmSqvnPL+7S
         nqXmxkpnrFj57fQDOvSYbCJuEV8Ec/nPVQ3TbaUNQ+4VO5r4Jrw0Q9nVDmXJKnZAZ+IX
         nbWaUYCabw1a8UUXzjLcJ5TwM1s+zS1RHi3Tq5ytphHYKBNuWw8XBUywmAsh3CEd9kb/
         OvvwGYEVNIYBd7aPYy2UpLvAW7di4s8ZqOJk/b/bl4RrcN3v+9a+OeO/J5vkcy3DT+0q
         1uMINv9APTbP+n7gzTO89r0Tz0kMLu+ILBMsNRykdUgnvZjPX92OJp1G6XoozLB2bzNe
         I1/A==
X-Forwarded-Encrypted: i=1; AJvYcCVtJidl8fSCfzUHOnYvztwP1solZysbOYgqf8XJN0TRGoi0eAgINiN1pW5o5i/vwRmvHAWb4Yg6dHpCDiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcK/wFseyCzPImqKNA4b0KbF3kNgTF2MNE8nDtA+eyXUkjx5e2
	8fkYtLp6oq6+CiAIg04nfsJGV7epYgCQKD9Ki3eBQjSw3VSvwHys2LvTs/Zkac1C9OaC9T+1NOc
	tcSwYXFE/0+nMUg==
X-Google-Smtp-Source: AGHT+IHM+z4NVdXcW6ETQKsm+fLI9Qi/C+PiO0rUWizOJbkT9ESYF03mbeOYGhjfDtE5UUjwF4japFOv99SrKg==
X-Received: from wmbji4.prod.google.com ([2002:a05:600c:a344:b0:45b:7262:8426])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d87:0:b0:3c9:469d:c054 with SMTP id ffacd0b85a97d-3c9469dc236mr11331425f8f.63.1756382348227;
 Thu, 28 Aug 2025 04:59:08 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:59:07 +0000
In-Reply-To: <f9713ea8-4e3a-4039-8cee-bf64edf2aa99@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-1-5d3a94ae670f@google.com> <f9713ea8-4e3a-4039-8cee-bf64edf2aa99@lucifer.local>
X-Mailer: aerc 0.20.1
Message-ID: <DCE1KVGTF2DV.3PRW2Q6PZ6KCA@google.com>
Subject: Re: [PATCH 1/3] tools: testing: Allow importing arch headers in shared.mk
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	<linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>, 
	<linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Aug 28, 2025 at 10:23 AM UTC, Lorenzo Stoakes wrote:
> On Wed, Aug 27, 2025 at 11:04:41AM +0000, Brendan Jackman wrote:
>> There is an arch/ tree under tools. This contains some useful stuff, to
>> make that available, import the necessary Make helper file and then add
>> it to the -I flags.
>>
>> There still aren't that many headers so also just smush all of them into
>> SHARED_DEPS instead of starting to do any header dependency hocus pocus.
>>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> LGTM, + works locally so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
>> ---
>>  tools/testing/shared/shared.mk | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
>> index 923ee2492256b693c5cf16cc014d9d2410be5457..937aaa7623320da1085a8e0f43f6a728ddd3ab1c 100644
>> --- a/tools/testing/shared/shared.mk
>> +++ b/tools/testing/shared/shared.mk
>> @@ -1,6 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> +include ../../scripts/Makefile.arch
>>
>> -CFLAGS += -I../shared -I. -I../../include -I../../../lib -g -Og -Wall \
>> +CFLAGS += -I../shared -I. -I../../include -I../../arch/$(SRCARCH)/include \
>> +	  -I../../../lib -g -Og -Wall \
>
> We're also adding lib! Very very nitty but maybe mention in commit msg. But not
> a big deal obviously!

No that's already there, it just looks new coz I split up the line!

>>  	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
>>  LDFLAGS += -fsanitize=address -fsanitize=undefined
>>  LDLIBS += -lpthread -lurcu
>> @@ -11,6 +13,7 @@ SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
>>  	generated/bit-length.h generated/autoconf.h \
>>  	../../include/linux/*.h \
>>  	../../include/asm/*.h \
>> +	../../arch/$(SRCARCH)/include/asm/*.h \
>
> I'm no Makefile master, but I'm guessing this will always be defined _somehow_ :)?

Ah yeah this is what the Makefile.arch include is for - I'll update the
commit message to be explicit about that. v2 incoming shortly...

>>  	../../../include/linux/xarray.h \
>>  	../../../include/linux/maple_tree.h \
>>  	../../../include/linux/radix-tree.h \
>>
>> --
>> 2.50.1
>>


