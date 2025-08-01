Return-Path: <linux-kernel+bounces-753690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C92B1866C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB97189313E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED31C2334;
	Fri,  1 Aug 2025 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dEWyYIe/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812BB19C546
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068770; cv=none; b=Dn8/BncokdXK87xIa1MwTji/LB7Q0CVdWeKptyQlxsFE0jNJq/694d2XjbCoTUGyLgn1KB8XbJ5zae78GWX1hiIKPauthayF0pyO7FwVZnU0KuWkM3/xsbx7QHPkCKt62rWgJQti1lSpkk2IC7fHYjQ+z0V+4ZNTXMxtRlzkrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068770; c=relaxed/simple;
	bh=5K6MxjJLV2T8FHkGPWSGO7jpkJ2aH7lJcaItGskxyRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4dbJT8/lyEH0TI6J0oYFhG/RTspzPiSKUOkTrVgJ5ILzl3vB1Ry4R65wkH2xErG+M4AgtBoLN6LK8WEvPD9g/LcIW3GXgupibGDMQW87lqX/voQ8YhbE5mSymZ4zZ2BBMGAFJr+PpSNi0NMmn3YLiV4Fydwy76Def1Xl0Wh45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dEWyYIe/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso2933652a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754068767; x=1754673567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y6WgA+qVRAM97fSPDFIXmz5siWPmuhU890B+6UX7AAw=;
        b=dEWyYIe/vk0u20z7rXZwhyEYMqxYs+nxvYLoGWoHvDI62VxU7N3223PCimr76R7kbk
         YXm+/gk5OEha/XoN+VpyFeDxwPvsVWYLRjhVxZZpcmIQyueJnMPIvNf3WiGcVRj1CqPw
         Y3sOVJRHYTvB1K9S7bDX5qDHeTNIiL0edBEgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754068767; x=1754673567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6WgA+qVRAM97fSPDFIXmz5siWPmuhU890B+6UX7AAw=;
        b=aVoctwRx7w9fWfyAFfvlV4iAhdbp0ex1fCb9hNpmdXH3u/lEKuBJSVr+J2OJzWdj4o
         aavPmpSdm3vnvTh79I+w24yAp/F0nafUIn7++zbGZj0E/tBHBT/i2JVWcdr2+awZ6VIT
         BCT2cTqEKYG9ITlHLm8iXZSG6s1BGjgwFAcXws5DMZXt7Bw+0JUhRlXIFfcKM8RWHc3A
         6QfCY5sbm7IOMGjXTpyasFtgf5FCd0PUdtxJaTvTMYsS+j26Xv6RwLER6pYFwOylTFqi
         Tp4VhlSOqEC5eOjlhhBsJQeBFhrzp8nlethXcEZUMSTF3FX8aaBOJjl30+27itmsDSB4
         2dng==
X-Gm-Message-State: AOJu0Yz9s4vBlwxuT7hydr/RABnCml4SWYV1hOcNhB2/Z0gxL1BfkpZl
	g1fCATLYAEwetBJqnNILam150AAHaT1H3qvkK2RY+0/+bwnwEI7sNZOJTn5vcGZVMNo3nWj9oao
	5kGzg1lY=
X-Gm-Gg: ASbGncunhe8qm/dWtDKNZ/N17th3NMJwRseO8VEHlTaGk2t66saCeFvVlk6ZqeMAxZt
	2riLfA6ae+6/xEqGxm0xQIIT0StGHOvHhXpy5U2m+biIFKszrMBqIU3N9xbTOVSeYAN9oUge7kk
	dJRrMo4DISd79avCXUheeY2FCdkmIA7Qsh3Xkahot8w8FCE3ZWLQqVrxLmu7tcpYP1YprynuliT
	q5DQaGf/uOmmIvrX1kn6/NIWSZMZXexMJtwZJKCd8uVYxZWb5gq76fmO+QxB4o5LNNGlVUqJPZK
	NlMBByiKYesxK0j4bRiSpK1SZ79Z7n8Uv0Jh8qFbpuL5K04n5TFvnAnKnd0cpTjRnf5yl0ZtJL3
	9qQSxtL8B2rNmgePGl8nbGij786tWWGtBbV49Jq4ECmJGShnFkHm9B+jgjeAL96N8jVGvzg3KCO
	ElrEk8pmI=
X-Google-Smtp-Source: AGHT+IGuop8LHBiW7vol6P7A01R1QbhU8UnfacxyuvKpnR5t16WY9GRpU08Rx+/m56QcUF2Fqnr5PQ==
X-Received: by 2002:a17:907:9716:b0:aeb:fc49:3f56 with SMTP id a640c23a62f3a-af940015705mr63632566b.15.1754068766669;
        Fri, 01 Aug 2025 10:19:26 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92a2ec9cbsm204441766b.79.2025.08.01.10.19.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 10:19:25 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso2933599a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:19:25 -0700 (PDT)
X-Received: by 2002:a05:6402:2684:b0:615:9b3c:5918 with SMTP id
 4fb4d7f45d1cf-615e6eb6940mr127296a12.1.1754068764721; Fri, 01 Aug 2025
 10:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731103211.10b42cb5@gandalf.local.home>
In-Reply-To: <20250731103211.10b42cb5@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 10:19:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVcUX7k243mgw-d2BSJV-Z3S8DHnwTn11ZweD1y5Y9GA@mail.gmail.com>
X-Gm-Features: Ac12FXy3gDN0OBl6YkZsMCiFIrU4dQDT5e6oUsATdxLO0w8QpEiQ72bcPhChBY0
Message-ID: <CAHk-=whVcUX7k243mgw-d2BSJV-Z3S8DHnwTn11ZweD1y5Y9GA@mail.gmail.com>
Subject: Re: [GIT PULL] unwind_deferred: Inclusion for v6.17
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 07:32, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Deferred unwind changes for 6.17

I'm not super-happy about merging code with no users, but in this case
the code does look pretty reasonable to me, and the reasons for
merging it like this in order to have the different users not have to
worry about seem sane too.

I think it could have been done with a shared branch, but I guess my
tree will work as a shared branch now.

So I've merged it, and I did a basic test-build both with a forced
fake 'HAVE_UNWIND_USER_FP' and without (well, the "without" case is
technically still building, but I don't expect issues).

I didn't see any objections in the threads leading up to this, but if
somebody really hates it, holler now.

                  Linus

