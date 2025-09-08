Return-Path: <linux-kernel+bounces-806865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F845B49CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB93AB9BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9F2E0408;
	Mon,  8 Sep 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frWswSRZ"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357C2E5D17
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370384; cv=none; b=RmEBZ9VxGzNDG0NjXp/iG9b5UVapOXsyEaezIFAtw9ZYkVD0wxmco6kRK4oHaiC82uw76+Usey6Nz1jybrnoIMRsxyG3ijuwt+Cmie8awB4ffhuKpBcVnodY7+2mXd47VALXEqbniDq7nUpVXnPtUq9cBVbMlvMW6uhrpzzfKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370384; c=relaxed/simple;
	bh=VgFni55X8qG9vgeSaLx0ybECt7pgaskgCCNnoOtbqI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npxK/3C8/sYjVf33JjsZfkrJhJVZMK2YP9iBfx0BvUNRM6HBJK/C7pzvSSJFZ8gZDy8SRCFYSGgaerQ4UVIOChvtortqyn8Fm6lZaMRi/eG6sbIA16We0sSZb8RZ+SJj7KNVwET7jtJAGZnwFhzCmw5d7n4oFkGqs5cBKnQc74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frWswSRZ; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8b7bcc8a291so904241241.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757370382; x=1757975182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgFni55X8qG9vgeSaLx0ybECt7pgaskgCCNnoOtbqI4=;
        b=frWswSRZku9wpOexc9YdrzKLk2ZYOyO2LK/5bkPeLq3UdOMN7XPPb554vRlliiofDy
         e7im6nYI4/FmIrAylZ2D6Leics+TMvGc0jQG3ea4Zy3pmOCLXl95PPZugeEnlL+w/LsL
         RUQi0zhCuFRIp7Zw/LoUJtDlT25Zry7aM4PbMWL70pZUzqv46i4gQd45wr0iqAiMxYeS
         jMhE5i1XXDibJCC12yr2VENgOvZ6ppgvH/yNuKQaNreFTlM4dk30+HDXWbGSbvhezoNm
         ti6/OyOQ6MTVDPmLoE9r7CzGvDzhk5dKF6CY8vz79W/2Ka8b5HFjhleQYQz6EqWdeBa2
         7Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757370382; x=1757975182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgFni55X8qG9vgeSaLx0ybECt7pgaskgCCNnoOtbqI4=;
        b=thsUOtPhHxQcU9UgRE72Gj467v0FuPFT76ihbraXycma6IHhZiRygqtIKjC2rF/C2u
         hCWPVwHJ37k54ETaxqzv4lnwUdzY9H86Jiqx5u3zP/K9Z099iyhmJ8pjjOPEsDEVgXWz
         sDyl6PoOTuS7L3fTbqyt1MxDgBs1mhSzvuYrxqqz++Y8VUsucmhHp4zUvwT1JGUqNbQc
         GltmfSIQeyOmpAsC5GNwlt2GmYXt+89kxjlBYWy1ctNZ/m6bZo+UFqrb+ugjNgLlM6lA
         BIeIwaNwQOfE71xZGBm7c8L4E2D+cDFvr5FixzjROLdLxE9YjgbJUo6R52NnG5uOhXT2
         Ommg==
X-Forwarded-Encrypted: i=1; AJvYcCUX1vmFlIsPMdHwNmeipsxJW+KxTtaNjCYK2xggDrlR/Peyj18Eb4Hy43qqU07+akfm/iIzVkR5vapWt6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhi/5tD87Cumdfy/rPxbvVD0t2WFpAVLoHnH7eVoO8xglRhUK0
	np1R8q07ctfzSxSz+/n0+GKU39b9OIR3x4wZNxnBECZpyM2Pht0ldgxavPVyMekj844dE99uyEa
	VKi9887Emo7yL3SyDSu9MVyMe+FbDqMbUcFEWmJBu
X-Gm-Gg: ASbGncvwon0rCLxgH3iD1ZPo3Epg35/prTX3d1xqSR4450ejFpejC6tMHhuikHrlnvN
	t6UR0pFG00WXF3qCV78eX7jBiP+GqqpOi/fe8LO+N2YFOlDFa9wUAJEYeJLwSgdoIGFSpdzZwFM
	zJZaGe6QVSNNZB/gHAOMqOuu96fvMtE7xcJIE+UQLvjYzC3FXwFbX8JNmlOt+MpZq36JA+/Arqr
	lDOPW1k
X-Google-Smtp-Source: AGHT+IF56V7CsaPSr4pf4Q6ngWeVWL4IRE6beiu0oOUFCAdWy5JF5KhGnfbRj0TKXiUivw+5HPXYBfSja/1eOKTzPJg=
X-Received: by 2002:a05:6102:5086:b0:522:551b:de8a with SMTP id
 ada2fe7eead31-53d0f4eba34mr3083386137.15.1757370381522; Mon, 08 Sep 2025
 15:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730205644.2595052-1-blakejones@google.com> <CABk29Ns_YttEU29AhREcNv-vqxDC2jEvFL-5MyhZh1RReecYsg@mail.gmail.com>
In-Reply-To: <CABk29Ns_YttEU29AhREcNv-vqxDC2jEvFL-5MyhZh1RReecYsg@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Mon, 8 Sep 2025 15:26:10 -0700
X-Gm-Features: AS18NWAnC4PARnhd5I-17uaXrcAbgGhvLFEQUZgSz-TjExsBjxO_dVxPbRE661g
Message-ID: <CAP_z_Ci=E3Bbb3sncDfktugNrzUK74nESEM-qLBPubyx+W4HeA@mail.gmail.com>
Subject: [Ping] Re: [PATCH v2] Reorder some fields in struct rq.
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Wed, Aug 20, 2025 at 5:11=E2=80=AFPM Josh Don <joshdon@google.com> wrote=
:
> On Wed, Jul 30, 2025 at 1:56=E2=80=AFPM Blake Jones <blakejones@google.co=
m> wrote:
> > This colocates some hot fields in "struct rq" to be on the same cache l=
ine
> > as others that are often accessed at the same time or in similar ways.
>
> Thanks for the analysis and this patch.
>
> I was going to suggest ____cacheline_aligned_in_smp, but it'll behave
> nearly identical in practice so it doesn't matter (would save 64 bytes
> on a 128 byte cacheline UP system).

Thanks for your comments. I suspect there aren't a lot of
128-byte-cacheline UP systems out there, so I'm not going to worry
about this.

> Peter, any thoughts on this patch?

Echoing this - any thoughts from the maintainers?

Blake

