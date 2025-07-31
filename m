Return-Path: <linux-kernel+bounces-751563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBB7B16AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BAE5838A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490FA23E25B;
	Thu, 31 Jul 2025 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jiz8kuGb"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F223B626
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933034; cv=none; b=fSNEeYxZ2yLlXV3cdfuCBo9Pw+DtiIuxPUGF0461HGubcHp5QKX2C5v6aBJn3Sqb5Lp44oJwz64XOLBE+IgnWS/SSe+aiIhAzcSJOouJqdmW8j70XJLl4ZoqZ3BkQ7j5b04G2bfwF0AxOuAReaE/G+KHUTAfkVwVbhP3scqSeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933034; c=relaxed/simple;
	bh=mVdlbDvjpBUsfIst5VALFrQFBmWzvAVnSZKB4vN7Pac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+K2MEvdkNpjezpcphzobuKhYg1Q6OzuOvoJz+fcNMIj+luMifhvEYrbVIa7T4SBfrKV+r80i4Zbg8c+akJw6nbcTvTw8RYl+jYl+BBH4VzlRI6339NuG7U871p09hb10UyGP7uKZH8ikzTX/Uqf328CX1IMWO6nd7CQHE5eXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jiz8kuGb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so546045a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753933032; x=1754537832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cK04kLA/RtYNkU1vR+8jk8KL6xCR0/8uVQTlYXHFZ/E=;
        b=Jiz8kuGbjswUw5d8o5M/rMxKV997aS4kcZVKDWa2GIzNHlL9dq009J4uzg/ID4zkk/
         U64p8pekxGON0Whxn72aF2MCSwX5yc+tJXknl27JCEGYGPR9XjpV+pC97img6v7m/6fy
         wnUO9vWbZkc6zpqdutwPj1v3iHqTbBUanJLog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933032; x=1754537832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cK04kLA/RtYNkU1vR+8jk8KL6xCR0/8uVQTlYXHFZ/E=;
        b=AUiTN/LY/9qVBhFBUdQ0R3mSJgX6wWN5N9eaIgeLDoSoxb3cfjmEVX+AIMTxti00b8
         u2yCXzw1rQzjS0S6DPkug4mXvCHyFtKN0hQSOXqPADoNAaIdO3/g6NqU/oRkzVguy0lT
         kFAdguzjZ8B7ZIhOL+XSmokRYTNZHeHWckdSp9sFcomU5GB//6eFm8My+Ir8ZEnO9Qdn
         YqUsTVyMVmg6dqwc4QQYsTRwJjRpKq40CYRgwn1jKqDEKURSZn2c240Drmf95YgQyR9i
         VrIG9u6o5Ki8aU2hz5naOLQdhFpRLJ7HUJk/O3PT0BfLsEeEe74qVtujoBmwPdt9LpQT
         kzPA==
X-Forwarded-Encrypted: i=1; AJvYcCWxOIGKEZxW7rLmf7yIardgHYspgh0hTCXakvJcByxurvMTrHymmYx5sHhtU7qIBllXU3nloLn7zVp0CyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yZE8Iyn3aM8G/I2t5twdanNWvK94b4P2PaWrMc+oZMvWCmIE
	b9CLnpO3ryxX7jJwHBWqiw4npienGPK7SqXfGVkmNHLKBZkQL0ORCPiY1ixf6qUf8g==
X-Gm-Gg: ASbGnctOb6ZUF+qulMl6N1xeuFJIh66zptEViqgFw0sbfJgND9uFjkfYutv5mrsIJ63
	k6KO7EGl+xvpU0gHB4G2Yq/eKA3T+von0mIgjEzgkRgKwR18g2ugkbFc98UGr4B/37WpXIhSb6H
	HGLFw1C9tjZOIuGnbSfMZ4NoHVl0oVZkW2IJvIucAzyhIdOq+F4Ms2JiB3qm5mP8iw8BT8cZDAU
	ZvIS7yJ4vZY83eHn9XaQ8ezWWqUc7Mcf0hKy2xL39do/87SiDGubNW3bUQwc98IHGnIldbxQfKc
	nWeRftU1ek2Qb4VECBTM+yMMr8hUdFFZ/fhckWzGx/STFWDpMTzwFzC5RJ8ZKsH4fBaUE/wbh+8
	C7BXZvPn27qIg7UMtgvRpGJyP
X-Google-Smtp-Source: AGHT+IES13AFV+AmO2upFyzAzLI+XpjnbnqZIFCycOx/KB+U1DRL+D5Prcw1eIKw+ZWVtNUkjbe22A==
X-Received: by 2002:a17:902:b489:b0:235:15f3:ef16 with SMTP id d9443c01a7336-24096aa37b2mr67006025ad.13.1753933032533;
        Wed, 30 Jul 2025 20:37:12 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6a8fsm5004965ad.23.2025.07.30.20.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:37:11 -0700 (PDT)
Date: Thu, 31 Jul 2025 12:37:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Lance Yang <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hung_task: Dump blocker task if it is not hung
Message-ID: <l27knfwpljnsgwvc47ifxtrwtuwaireojejiozjioqab5va65l@vrkuak2n3hll>
References: <175391351423.688839.11917911323784986774.stgit@devnote2>
 <reyd4bppb5tfon7gtqaelwknvptdeyhrsh5ijbcj77ezini3yq@ivkgxmiqzk3x>
 <e34a1a00-1728-4cf9-ad30-d8a7098b8876@linux.dev>
 <4c227812-23ef-4fe8-9bf1-cc4966fd31ac@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c227812-23ef-4fe8-9bf1-cc4966fd31ac@linux.dev>

On (25/07/31 11:25), Lance Yang wrote:
> > > Wrote a simple 3 tasks circular lock test (same that I had in real
> > > life).  The output looks good:
> > 
> > Nice work! The log is now much clearer ;)
> 
> Forgot to add:
> 
> This circular lock test is great. It would be very valuable to have
> it in samples/hung_task ;)
> 
> Would you be willing to submit it as a patch?

Well, that particular test is a deadlock, not sure how useful a test
that deadlocks is going to be.  We probably need some alternative if
we want to test backtrace de-dup.

