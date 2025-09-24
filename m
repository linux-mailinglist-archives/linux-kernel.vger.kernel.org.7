Return-Path: <linux-kernel+bounces-831112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B9B9B90A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D119D327778
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB13191C9;
	Wed, 24 Sep 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aCCgyhyn"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD5313E0C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739965; cv=none; b=gqhrNdqplMghzDSqBHs6c5hCla+7cc73g0gBn2xY6WWyKkct5/tgAWnucFv6nutG9iRCMyLnrfAlm/h/FnSPkpwOtOh1PJl9AFVBOtO7j/0WZ5xY6xVNm5To5hvSEGoyAjcHyPKIR06Rqrm0ZBxJ/DLdAljgQBzwMF2HFrIt3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739965; c=relaxed/simple;
	bh=TrnfCbO733+lCXZrSFS09BJmX3fVRMEKZIVSt3/d0Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wpz3qKCio+uOb316YbjsY37HbHLa9uhxXHWDQRHkBOVFvVPD+0SkWJD/FXdTIW8heq2m0N782CEIV/UkNtIhLe5ftxkUlrgzaNVkWs+uN1lMDYODU7cro7oahFUVWCGjBxEnp+k//7SUSh71vuxJU7uy32bYg5C5WaApXjaaA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aCCgyhyn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63491fc16c3so174759a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758739962; x=1759344762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxaSlzLAtScN1zJhK9/qnO+REZ+0VCMj1JhA1WOFJSg=;
        b=aCCgyhynB3igypdVb3DPqjVcgWPnxv3ckeJreBI2LsAqX1tEbBcKqhazbLqacQCulP
         ixOeKFxJjcpMGY9bF+gc9KT+AgLAdGfiOqxfUPiN7d7CdkooNa++nhvma1e4O9iq0LCI
         JUADA9NJcDs1PSug+0z5oVsf3cd3ulS4TYGPDdcbK16CzKi3mcrlP3wlYTBtppzsjrYJ
         JesSyvkOD/09Sfllou60fBch+xUVDkE7KPhhui6aqbZoTfCT1MwoZK0s+VKmb6vh7JQj
         6QcMx7Tst7asfDqW+lmQHqlgzK4MnswKquyhGhwj4xgHvh2zKXd4y1T987R90DkggR+X
         bX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739962; x=1759344762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxaSlzLAtScN1zJhK9/qnO+REZ+0VCMj1JhA1WOFJSg=;
        b=XgqCtb1N+npDTbPaGr9IO24T3OUnywFTS0HWiK5UDWJCf2bfQfYcfQeawmwslaWF+x
         MKjnZWujn3hufuHYxxzyTGURYvQheFYU0zARRRS4XvMu/IarQzEsJp+hwyvLdq1qsxMx
         dP01WBcNTGSqn7vgbNn1mOfnj8GDFhRma+VBz4/MmE7OzL9998pxEbvDLBx3+43/DAQL
         KNqhTyfh/d07tHzM19XAnPdEPlZ8QeUkTzT7FuC3Vom6X/JHTzEQRSRg9Cq5U2ZomYBm
         DTUx1GH4IUESsmbfauVGSJYN/XASLZFHc/EL70ecl9GZp3TybYMQ6N2L66SO6Ot4E7i0
         kbGA==
X-Forwarded-Encrypted: i=1; AJvYcCWkUtnF5su6jamIJyMsyt+ntb5g42CxuPyVSyUPPaV5joRA39KpypbyJ50nkjKLLn4wEAWisAAQG3ZdSSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bLhUr7sTeTwnbBmzCfDsCZ3mznTfxQpbVGiDT8pJpTst3n5l
	DCn2OIgQVOWGSm/9XHJA5GXoifyVrGc65l/C9/PxX9LJkob9FXfomwJVD9zpwQE98QFZH+KTbsV
	/SAPDKYm6xgxhiwa6KIbUtKoiIFLeMA0xoBMsxkoeFw==
X-Gm-Gg: ASbGncuSm8M3IBcXW1yZ+uDzWNZIY9PVBrQo/WRi2lH/2cTqmaxhSAyqs0//XTxMF2P
	bucHGV5vTuuhlEIAQiqJCiFdrLd/ovS8M5e6LmrTzITFxga6sqxUp96xdwbOR2UjV2eo0oh0xKM
	yN6unSXep+oxwUBtxCTf6qtocQPhTZYHx1+X9lar2ARNnj1wlIqPrKSPcxzt9t6KtRfXpqgZecB
	8le6hA7IEhsARGLc0+4YTmAYUNx7okpXCw=
X-Google-Smtp-Source: AGHT+IEfLas0BqTe4LbLvHMPVeWuRAoGKff3BYuwff4/8Ek1I05jBqtCoUMSm2S1LlFiIk3FPlHI234+b1Girt9Hnx0=
X-Received: by 2002:a17:907:7e88:b0:b0c:6cae:51f5 with SMTP id
 a640c23a62f3a-b34bb8f1a7amr87587566b.43.1758739961642; Wed, 24 Sep 2025
 11:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911222501.1417765-1-max.kellermann@ionos.com>
 <745741.1758727499@warthog.procyon.org.uk> <755695.1758728366@warthog.procyon.org.uk>
In-Reply-To: <755695.1758728366@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 24 Sep 2025 20:52:30 +0200
X-Gm-Features: AS18NWBX90PDeUbc5D76CTwvxhtp7GglnV1Nwwby_YGspEvXUsJA3vS2rse6AAs
Message-ID: <CAKPOu+9Ym+dRHQiMvjvdisnb5jwca4_2ECbzOMLYso=xNvxeQQ@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs: fix reference leak
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:39=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> > > ... and frees the allocation (without the "call_rcu" indirection).
> >
> > Unfortunately, this isn't good.  The request has already been added to =
the
> > proc list and is removed in netfs_deinit_request() by netfs_proc_del_rr=
eq() -
> > but that means that someone reading /proc/fs/netfs/requests can be look=
ing at
> > it as you free it.

Oh, right. I saw the linked list operations were protected by a
spinlock, but I missed that this lock is not taken for traversal while
reading proc. I'll send v2 with your suggested fix.

> >
> > You still need the call_rcu() - or you have to call synchronize_rcu().
> >
> > I can change netfs_put_failed_request() to do the call_rcu() rather tha=
n
> > mempool_free()/netfs_stat_d().
>
> How about:
>
> /*
>  * Free a request (synchronously) that was just allocated but has failed =
before
>  * it could be submitted.
>  */
> void netfs_put_failed_request(struct netfs_io_request *rreq)
> {
>         int r;
>
>         /* New requests have two references (see netfs_alloc_request(), a=
nd
>          * this function is only allowed on new request objects
>          */
>         if (!__refcount_sub_and_test(2, &rreq->ref, &r))
>                 WARN_ON_ONCE(1);

You changed the refcount_read() check to an atomic decrement, but at
this point, nobody cares for the reference counter anymore (and my
check was just for bug-catching purposes).
Why bother doing the decrement?

