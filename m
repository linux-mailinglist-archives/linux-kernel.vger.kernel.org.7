Return-Path: <linux-kernel+bounces-817034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82AB57CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A07F3AAC66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C29F30E0E7;
	Mon, 15 Sep 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPgFfS0f"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FAF30BF5C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942380; cv=none; b=q/oE7CJmYgPkUn3o0X241POaBDyrdXqLl0+xFoDhErVtb21QN/BQx2i+cIzIgwDcqWyRBebcc+p96JM1g6PsE3abcVVMTuK98PpNwSicQ8uA77VGUcvGsjctcQxRZZ/Fm7TL8watLVql9+NG5w99cxO+YBb2rPbEe/JKaUzoEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942380; c=relaxed/simple;
	bh=kWs2N9IW0F/jW6UNNxaOJUDKMxrd75Yi8PSKSAkHppI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zuavtbdz/5xCXezTCZYpUKj3TlRQhyonkbpbBs2AjK+95h9zUXsLd9t6UjKAjS3ZSpVfq6TwLAmXFODeiDOm7sC9WB354YkM3pc91dL3kwC5j+UJ29qKFDyVUPZK2RQ5yXDhw9ANMAgE3oYy+yobNkG4ruT+F6m13wMjpv/bVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPgFfS0f; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso2905979a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757942377; x=1758547177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWs2N9IW0F/jW6UNNxaOJUDKMxrd75Yi8PSKSAkHppI=;
        b=HPgFfS0fYozwt6LNx7kxocHbQf0GS34++8ulCCPDYABqu4DkgSMIbel3GELFjKdzEP
         vR0e5MyCZlbJVn1XyGZ/aAKb0gNwypdCs0km7dylA0z1zstl8ZddKMQ78oPXg6P7Z6Nx
         9GI/knZ/raLCmyc4jxbhhv5ta5xebF4TwnrWQQR0A262tgVsEeXg6TOZ1HW8qJTsBDyV
         Qm36unqh2B2nZOQq51GxKeKO/w8MauRA5OECquQbmQ5BomSg/5H66mx+QAML15F+JdxS
         TAc2JMdibJ18RHpcYq4vwIO6BhtYqAQ0GNnyQEEXsox2ltrAt3qsZ5XcJDzWCCYM15sU
         LAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757942377; x=1758547177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWs2N9IW0F/jW6UNNxaOJUDKMxrd75Yi8PSKSAkHppI=;
        b=BfbmapDXsiBrYhS16dypjLgyyKtMyBLkF2J0xQ5YKZqN1s11OCGmm9t7loORs6Jl76
         PD8Fgv1+/+FZnwjBSTH1ai7R1r6JgFXrOwCM6TZKQiydiYiePE97NNmqkTTLgd8uffDo
         OL4n+JdyNYAYSVV4Lf3RTnYZLYPZOLPdZUnmvGfwHTT+zwWmziNkqfHCfd5XoC5d+vBM
         629jEQ03rqYeOScAF9XFvs8zun7uYM+nHCe0oHRKcOahn9hV1CPvA4Vf0heiEBW4qja+
         cKS03HUdgyyDKU8fMh7hw39VkKVYsEX7rI78rN/2/VN0UbzvWbcWgXcAqYYKA/zWIzhZ
         GXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkltzEu5bYRGu2logNlFEtjVz3ULJcMDMpfg+bzy0FG84ntf0+lmDEjRHhoPMyA+7KcwgMrwsZrTJuxic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiThz2vYzINfUoRIrCIypXgh7w0NuwnQbk8MEWf35MpRwLSKrb
	ZWEPIwQvj9C/3a0LfLehZbIWag1kMbnwVuM4oMmhSbLV7LFDlPb/q87T4HqL5JzmQno0nQHONdt
	ErtjKgxgv9bRsRJUL3hx/0GycOIlQlrY=
X-Gm-Gg: ASbGncuXxbD//1EEXd/7o811Fz3HkZkSStaq6HwYWB7mzubtj3tFlUiaSinPW4OyD5c
	QseWLjsKmqN8Z0Uo0s3eVGM89v7Jj+WRyrB6Q4zUH3wdKc9Jv3Dn47qUwS4xvzD1oXQhJjYiVQy
	qrGlK9d6Qh9GO8KSQ7R/9Kow6aBgOffrepZRYT6YXR1Xndivb/+FtElxH03LorBMQV3ZyFfn41g
	0DLcs48g+78m8YRXR2ZlHhmBjYwQ38DxaLm4yMd+RA3KmtUow==
X-Google-Smtp-Source: AGHT+IG8Jz2ClSytWw6aXpy6sWj+/dN54j/2vS8AOejF4DxG9vLkSfUTEiMTCKYs5885/sN5n0C16pBaSa5Ip5Mb5Fo=
X-Received: by 2002:a05:6402:35c7:b0:628:b619:49ca with SMTP id
 4fb4d7f45d1cf-62ed82fe63amr13073678a12.25.1757942377008; Mon, 15 Sep 2025
 06:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914110908.GA18769@redhat.com> <20250914110937.GA18778@redhat.com>
 <CAGudoHGwEYg7mpkD+deUhNT4TmYUmSgKr_xEVoNVUaQXsUhzGw@mail.gmail.com> <20250915120537.GB23082@redhat.com>
In-Reply-To: <20250915120537.GB23082@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 15 Sep 2025 15:19:24 +0200
X-Gm-Features: AS18NWBNv1Z1m2QuaEOld3K3Frt8SBI55oUxttDDylyMl8Ayd-ANLAUlZdNXVpE
Message-ID: <CAGudoHFbsMxEfaNny3xWv=pd-y62fPunSjHc+6_3TVa2hdixYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fix the racy usage of task_lock(tsk->group_leader) in
 sys_prlimit64() paths
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 2:07=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 09/14, Mateusz Guzik wrote:
> > As for something more longterm, what would you think about
> > synchronizing changes with a lock within ->signal?
>
> Agreed, we should probably change the locking, but I am not a new lock
> to protect just signal->rlim makes a lot of sense...
>
> We can probably reuse signal->stats_lock, but it needs to disable IRQs.
> Or ->siglock, but it is already overused.
>

The woes from a lock from a different structure aside, I find it
pretty weird that reading rlimits requires taking a lock to begin
with.

I'm not going to argue for a new dedicated lock. I do argue for
sequence counters to read this. With this in place even the
irq-shafted lock wont be much of a problem.

Again I can write a patch to that extent, but no ETA.

> I dunno. In any case we need to cleanup the usage of ->group_leader,
> it seems there are more buggy users. I'll try to take another look
> this week. And probably it and ->real_parent should be moved to
> signal_struct.
>

I got myself into some vfs-related stuff, so I'm going to spare a rant
about linux not having a 'struct process' or similar. ;->

