Return-Path: <linux-kernel+bounces-852598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F046BD96BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186341927AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341EC31355C;
	Tue, 14 Oct 2025 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFd3YaD8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C275313555
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445813; cv=none; b=eBibWbbX8eKhK3MIuet53yNHTi0YPUxY0oo5xrtFop4UYCP8JaF1pB0kDFbw0mIDwszUP5eeYeaNHeU1EP4q1Du8ltLhhU5zKTqhqr+mtvB803yacDg5FNizG2jiUKTtBOVAArc4rJvYnlEywShdMUzwy0v5ujhsWS16WVPkMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445813; c=relaxed/simple;
	bh=ZUn+2bWdty+sk/iuCeUPHo8jGo8fRJ7TPvwZ9XUUXDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+PYmmQPQfjNBsXHMutmg5DdkcGv2SeAkO+o//KHMPz4G4nCyO5rT7i4cw67WvWUql3FcDOs4MDmXRuhWA7NbSk721GEhb1oYzDHpCEVFxpJRDLPFFzTZA5nXyX2V6EUQdUrVUYjfRtKrzRNju8GowG7jstsMvLMD4yrbK521EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFd3YaD8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760445811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Lqhwwhq3/j9K14UcUbnvxwFr5CkuzbyydsVhsDSBRk=;
	b=fFd3YaD8rSU7g9+/dsObXPSsLhACjBQeizEtXc54No5HEiuLGdvSR/RMSV0Hd5/emzFuYg
	LnNwk4NjtyiSxAHmAR8hRS0357L378cToIR6I3nbswy9fCzBXaB5ijfK20PSCHkt638KCL
	O1BZQCH6bLhOmfYSWhdg+0Stb3ALn3U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-cbY0C7smN5aKjYpMGawLQQ-1; Tue, 14 Oct 2025 08:43:30 -0400
X-MC-Unique: cbY0C7smN5aKjYpMGawLQQ-1
X-Mimecast-MFC-AGG-ID: cbY0C7smN5aKjYpMGawLQQ_1760445809
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b479e43ad46so502764966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445808; x=1761050608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Lqhwwhq3/j9K14UcUbnvxwFr5CkuzbyydsVhsDSBRk=;
        b=vSX0CMHeInLIEW+qTYp6rO9rtKsD36H7M9l6+jer6J++ShYphaoxuubEYCzq4iMTSD
         1mNEodot5g3QFbwAKp2RiUAVFD5N6bX/RFPOVZ2JYWWD5oClfYgdsYsC6CjcG8smADPI
         H7aakQG5U5fXbWvlPSVxoQdoNl/nK5rcSU6YtESAfzbLoMob3o698Fg+w1McaozA8xdQ
         nLZYnEVLt4UhaXq64hohHg3OWwZ2wdbeITRK0P+8F0yHdthS/P0AusFJcv+Og6beMG9G
         TfWJ0rLKnFf5vHd+2cEMeHFHA3T0eV/Zl8ZqU1mLuu7NERypVQanQhmxyuehGBnu4l2y
         Lr4g==
X-Forwarded-Encrypted: i=1; AJvYcCUFQRhQP+liEGQREc1vYamTSpVgnSAzAMq4QWn9aZxXDSKHMUVwQb3OZtgmiK0HTE/rzhvH5g5S5Ht40TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YychzuHIF/s2b7bfK/KHVa45O7NHRLlcODD8fX67JmASgJKCI99
	tEyLFQTIEtGAFy8nFKDq3ULo5tQ3unSMk+ptnjFVNMws9Bb67raZkMJOBADEsRyQk86z8N87LBm
	ebZFTNqmbSCap7S0K/AykWXnl7s21nz0DH5qtHravu9Mkd0aAcZyJp0GkLmHjBb4PXs8ueYNxII
	OAlL0WJH1TkAjG/Z/a/QhOcqgvze4z93mgu8foXrMNr+gXXpdr9kI=
X-Gm-Gg: ASbGncu2EelS+Y7jFSao9jU9xiyxTH27/z8B8L4PN1edG9uQozw6RX0mQsWw5GBPf9e
	+QYRW1k1ANAjLpIs71RmHPiNb1RYElhesDNYQihza+IRwG2ZYA3Iq+RRysb4fKWulV2aoi2ZY8e
	AhFusg5UNlLgOjoOZubWg0qgUHWzVoCymUspIFHLSpLLiOleLeNXb2Mg==
X-Received: by 2002:a17:907:97d0:b0:b4a:e11a:195b with SMTP id a640c23a62f3a-b50ac7e7627mr2504118666b.44.1760445808192;
        Tue, 14 Oct 2025 05:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSOYeH80eICglV/QLHQmccRFIhSJtB9RJNZf1ns4OKzLqeItz2Pn1wEW8TT69CHUuGe3Of3Lvcfom53E3YGbs=
X-Received: by 2002:a17:907:97d0:b0:b4a:e11a:195b with SMTP id
 a640c23a62f3a-b50ac7e7627mr2504116066b.44.1760445807807; Tue, 14 Oct 2025
 05:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008142719.2564034-1-rrobaina@redhat.com> <586cc14d04810b3154d2eda25d6b06a0@paul-moore.com>
In-Reply-To: <586cc14d04810b3154d2eda25d6b06a0@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 14 Oct 2025 09:43:16 -0300
X-Gm-Features: AS18NWBbH9qWWVQFJlWNtDYR_M3fvvQJG36MZGpSfchBzkBRKgSoycEVXK-Wn2M
Message-ID: <CAABTaaB09=GzphmyNkHQq2S+q4dUbVa4jFpMB=JgEY5f-BLBHQ@mail.gmail.com>
Subject: Re: [PATCH] audit: fix comment misindentation in audit.h
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Oct  8, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Minor comment misindentation adjustment.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/audit.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Merged into audit/dev, thanks.
>
> --
> paul-moore.com
>

Thanks, Paul!


