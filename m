Return-Path: <linux-kernel+bounces-793283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C234FB3D187
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362D4189AD7F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525022472A8;
	Sun, 31 Aug 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VpA/sh4O"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DF246786
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631265; cv=none; b=WBNTkmeNSMsgWifvWNEnpGm+GAoQCZLjrv7FB/wvGPVFPu/DC+s+MJb9zMrkUk5UWG1hmxZcOtpCtoNc6ST/MYqR8SLHEagWgJ7tsxWZnifwJOsFrON9OZQ/nqVWwy0dvFqOsNFsmTIMnQGWtHtK5yjtPRqL6LfxmqW06gVtH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631265; c=relaxed/simple;
	bh=nGZwzPbeJSH40yHH/9NENXW8DuVrJPeqrN0UawxoQbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQjqQnmDht8dbUqrS7229Su5dD5ZcDiEuDc9eaUH7gWwBLj2NFpVcq1vNXN3797gm29P5wfVCJyUJIiwufbVkOXH9UKxc0zpkKFOHJmowUJAtZlFUpBn6TczV/nDTW6hcunDTaeLv+ya/ZqofpDxxpJFamvzuIx4TKE9dFGPbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VpA/sh4O; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b040df389easo121994366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756631261; x=1757236061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGZwzPbeJSH40yHH/9NENXW8DuVrJPeqrN0UawxoQbU=;
        b=VpA/sh4OewqTnCno6EMvPdT1W4kdMns8wFVxAeS+MZVWQLKyPrGbrReJa7QTmTuBlv
         2b0pmXjjQmUxgKbRayQxJc6RY1FmTaMc8rczY9BAdM0HGf+shWPugzMf+gl9E2vEt5cB
         JuuynK+2vZ4nmO1KqcUEwIJFhWd9FDAR5rztyI412EFrdP3KSOMBpYXswyNHxKJiX8Yu
         amW+04NorZRuOjsLrwkq3ot8V3U/54imI7l46ECFzH8WdCqbdItEMNP3GTjrnUOaJ1FW
         YvJcFzBSm4otWMfmtUESd0tTS9Ce18Lp4Dt13AC9wxlOzcF0RfP78njwUnhZ1bmeoQff
         A1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756631261; x=1757236061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGZwzPbeJSH40yHH/9NENXW8DuVrJPeqrN0UawxoQbU=;
        b=SAn/NUN7powy32Lx2I2O/GNmTeF6rixzyT2K75nK9tyxgxK5bY2sWyvybvuZdalisa
         aI3fQyQEUO4lABVhLCl7Fiuh5Dp8a8uHMLrUwgfOm8R72XzcnRYvQlS+0XQ9/mdnfrOb
         CIvFp7ttE1ZCl9RornuYdfd5WoTHkjNAW3jBZ5+HQWZW0BA0TuSMBkB6li7zMGGpQZEG
         EapzAOMzP1SOYblaBXNUXxvdzEHsjsXP1783nGTmXWZiLBht2C/eJJSMs3jeJSgS/tXJ
         GS207AQ4jlnu5FU8y7AcEA35+Ityf/9mIj+mGjYJotJWrWz392PvDWMW+KVln+IBxDPl
         3etQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8VK9HvqtpyPFIb8h7UfxM0Yz1RtFSIrAb15T6hgRi5YzDQf9vqckfhqFIh+hX3lqbTItqxiT+GhslZ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8IqBSpz+qYVf4PldU4aGKehaYKgFo0dJfvj2Qbql34aWVGxj
	j7usHhGdwVgodTAKsKxD6+ak9qCA3tmEXvW4uhB8J+euDZLZri4ggtnEiLjL6yZwP9pRclBQ0ZN
	zu/jyIcLfQEqVrBkz9E2PxA5PAJpFkFr4W+Um0N4wOg==
X-Gm-Gg: ASbGncssN/YopJoXK/9qyGzsdnDW5iCDzsR+kj4c480lU6o098Pq1905lDSzUxIXbt2
	ZT5K/Lk/xMumnyudrnq5FVOjTYju2Vo7XWZBfwUZh4L2nWQe+gYatz9hoWTcgnS8x7EuwWTV6Dr
	mEOoMgqSJWpn5PAW1r24tjdRZ+sHgwo912KHnxCTR6kaz7xmurnUH27lAYZi48EVnt+jeQbDsxi
	I/JvPTSjDjYto2tC3sEa9YGU8pmR8Eblg3J4GNdSE+xIg==
X-Google-Smtp-Source: AGHT+IEES7g66ko6SWQsN8+WIUxdk07+Eqy+DmB6hNaUA83IoCSXr1Pf68kunVGZ4gGRru9fXEUF2A7+RGCoF9PyX+E=
X-Received: by 2002:a17:906:9f85:b0:afc:cbf4:ca7d with SMTP id
 a640c23a62f3a-b01d979fe6emr455913566b.54.1756631261091; Sun, 31 Aug 2025
 02:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-9-max.kellermann@ionos.com> <aLI5dKVl_7bPqB57@fedora>
In-Reply-To: <aLI5dKVl_7bPqB57@fedora>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sun, 31 Aug 2025 11:07:30 +0200
X-Gm-Features: Ac12FXyUUe1BE_1yIAq-T4Ag3V3wYcj4eFQvKTMVnq1a21mdj5Etofq7OAHlhWg
Message-ID: <CAKPOu+_VUMz5LxXEOVC9qQCQxjpHtm0dorJRxr34U1ff4jP7xQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] arch, mm/util: add const to arch_pick_mmap_layout() parameter
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 1:36=E2=80=AFAM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
> > -static inline int mmap_is_legacy(struct rlimit *rlim_stack)
> > +static inline int mmap_is_legacy(const struct rlimit *rlim_stack)
>
> Thanks for splitting the patch into all these smaller snippets, it makes
> review a lot easier. But this function should be part of the 6th patch
> since we'd want function signatures to change together :).

Will do.

There are 3 copies of this function which are slightly different:
- arch/s390/mm/mmap.c (checks rlim_stack)
- arch/x86/mm/mmap.c (does not check rlim_stack)
- mm/util.c (checks rlim_stack if CONFIG_STACK_GROWSUP)

I wonder if it would be best to merge all 3 into one? The one in
mm/util.c seems to be generic enough. Export it and have its prototype
in linux/mm.h?

