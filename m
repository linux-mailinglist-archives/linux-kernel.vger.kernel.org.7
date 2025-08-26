Return-Path: <linux-kernel+bounces-786484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF04B35A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195B416FE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856722BEC34;
	Tue, 26 Aug 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DT3cQ/a/"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF321ADA7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205458; cv=none; b=TpbKTG3IBv6jH9yzl67V8Xh3pKTqrjEBMFoeTvE8+VT9jphorhbaLe3ucvGM7qOWBDN4KnS8qdy/xKfYjhHHnBAWtvCZrsUSS4HMW3/57bIEWHD63R6Z36r+xF/UH5Nn1u4qEZzXLCQXkt83iTfcQmOpfHTiVb/7fE+bCdjaZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205458; c=relaxed/simple;
	bh=LBKQHJXt7k5q/EQimxKbRfxnkhOmIaY3I8CzQ5DxlNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6y2BRZsM40qcNYWrlnPT5ceeZm0UFRiwuOdReq5zazH9dKseB2lRv7/fbBM/X5gTGbNWT4O/h1JpF3MwQvMgI5EN4f4x365iPdQZ8LGmJTfZkHxC9jKgBgNeWgtU4hU4E8cN00zYL708EKvx0YwTgWdvgVjpxTM/2La1oiXmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DT3cQ/a/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49dcdf018bso1634509a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756205456; x=1756810256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LBKQHJXt7k5q/EQimxKbRfxnkhOmIaY3I8CzQ5DxlNs=;
        b=DT3cQ/a/uuuC3xUcZQ3Z+xwz1x50T5fnE6KZJ2JuZwyi1hINdMnrKtKMbJM7t/bm0w
         US69ZKvUC4S4Ce5Se0/BFllzOCpr0jHDsQU+GHdyZMuL/RtzXVeer0ixAXBQjFjL4577
         htrFfewxgC5Bt/gYWYPX0NI81Ft3JmSRV0frNldNxKrZ5tPyD4Lu5MDDAlyLb2H2gsml
         j+ZAaj1FIqN3mgAmaBkrhJc1NzWXVD1MtgfLTZjKSUkpUV5DaDbcQxmJHfpwV03r2kaR
         q5yESMXdiE+B0uYki15AUGlsjZiCc2A8UsiSVhGw2KfJS/ufahxExHAztKL3L+GFEJTw
         qGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756205456; x=1756810256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBKQHJXt7k5q/EQimxKbRfxnkhOmIaY3I8CzQ5DxlNs=;
        b=Z7kJOy5QfsnqlbzXR9E++EfcBcjJruG9x0Ibb28iGxduMjoJ8GH848LUN7QYE9Avvc
         gUnLUVz+24omiqB61pqUcdGLItR3G1nyvHLIifZ0rpd9jdR5Lhqc24yUvLHEHf2vTU7O
         R7J52QtUcC1N7j/eaviFdKBO7de0hNjqdIS8t4iFmUWg39ZrE5JWb/MysXZr3XJ6knn9
         I2aoo89ZVIOP/kEMvTbpdW9dpRwN+iJCNxkQtO5+vUVpbEpYYivPT74UAydk7P8D1uVz
         m2TRUgqpjEaffBOo6NUWuutwDjCQEKgWNY1zD352ISGnE/3VTrM5NLf/2yekloehUm3x
         adWA==
X-Gm-Message-State: AOJu0YztJI6xCSuMzq0WWfY2zsBrU/rGs78Qi/TAfkUzg23bGm82ZfDk
	aNxpLs4rQ69d1pOhWAJxx5q6iLAe9RRKgxuxccWempWuaivkGFw3JFVlFOU5kdcUq8FY2gqFWrM
	9AS6wFSpLosMAcyWDuYJLAPGwSdmDigJukBckLQfz
X-Gm-Gg: ASbGncv4er1p9jGKMjsYej/yC2Vt0dRaZoNbdgRQxsDQJimCHT+r5jBrj0ce36wUg32
	Nb5PMdYN8qTuMOXJdiKz7QcDbpWUVdrhenkOdPro4XVWdBOimzw8zL0EUKs1Se/ijUtUj8NmPeI
	vWfcJV13mFAJ1Dgxkk33f6FEa5hkg37cwuDxlRoeczp+vvXPT4taZmz+M97j0nVSzi7V8N8rvg7
	GWSzyuXjCxHf+iI9CU2/YNBBqA=
X-Google-Smtp-Source: AGHT+IHf6qim9cZNDk1kCo2rmmsC3LEblFH6JZzN5wGzcAVCxtsbcMX6nHM5LML7vHzagExj5m6bdqA2j2JdFPNAzSw=
X-Received: by 2002:a17:903:40d1:b0:246:d00b:4ae3 with SMTP id
 d9443c01a7336-246d00b549dmr76053385ad.61.1756205455660; Tue, 26 Aug 2025
 03:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825154505.1558444-1-elver@google.com> <0DC67CE5-6006-4949-A81D-882DBDF4DAC4@kernel.org>
In-Reply-To: <0DC67CE5-6006-4949-A81D-882DBDF4DAC4@kernel.org>
From: Marco Elver <elver@google.com>
Date: Tue, 26 Aug 2025 12:50:18 +0200
X-Gm-Features: Ac12FXy7R8YoW-2EpRHczPhHZJ0RjV4YJMdaLPQVeIhDdwxbJBGrafjAEUd74Ec
Message-ID: <CANpmjNMpnyQ=PhZ4jkSiAR7gg8WJOiunoxwhRWuUD1U_EEnyrw@mail.gmail.com>
Subject: Re: [PATCH RFC] slab: support for compiler-assisted type-based slab
 cache partitioning
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, David Hildenbrand <david@redhat.com>, 
	David Rientjes <rientjes@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Florent Revest <revest@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Jann Horn <jannh@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matteo Rizzo <matteorizzo@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-hardening@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 22:18, Kees Cook <kees@kernel.org> wrote:
> On August 25, 2025 11:44:40 AM EDT, Marco Elver <elver@google.com> wrote:
> >Additionally, when I compile my kernel with -Rpass=alloc-token, which
> >provides diagnostics where (after dead-code elimination) type inference
> >failed, I see 966 allocation sites where the compiler failed to identify
> >a type. Some initial review confirms these are mostly variable sized
> >buffers, but also include structs with trailing flexible length arrays
> >(the latter could be recognized by the compiler by teaching it to look
> >more deeply into complex expressions such as those generated by
> >struct_size).
>
> Can the type be extracted from an AST analysis of the lhs?
>
> struct foo *p = kmalloc(bytes, gfp);
>
> Doesn't tell us much from "bytes", but typeof(*p) does...

Certainly possible. It currently looks for explicit casts if it can't
figure out from malloc args, but is not yet able to deal with implicit
casts like that. But it's fixable - on the TODO list, and should
improve coverage even more.

