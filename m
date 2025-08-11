Return-Path: <linux-kernel+bounces-763646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DB5B21832
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DCA6252F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CC22E4262;
	Mon, 11 Aug 2025 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aIyuiBRn"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028D2E426E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950676; cv=none; b=n/X04Mx3aB3xAm4hD3Qzkfd45x7Tso9Y9iBBXa/zd2vTer5vnxQCtqG5/hEU4ZgjFS5fskXH0uNXLplPIbHBX0GVpg0zduGqyMIet/hJ9QEYpKbcW3H7rrgOaG0ZS8c7lDj+2CvNagmtevtjU2KevSjKCkWgKMLUfjeiz3qw5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950676; c=relaxed/simple;
	bh=rbtZ68rLyf/7ZKQToLJks77uOoN6Q6hQrn9YW8pG4Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hHWaINPlNRb2MBIpcQg8eoXlb6ft9dqf8S8vECjBLdVZLpB/Sekhr7DFBfOBpD44S/nEux5FCKmdjMv9hB4SvjZZVai5hSbYG/+PzCYEBmMvYMGaKSTXKjpRfm2WM0mLaFz2YA4tAO/A2YTNTZEmYISJmbypa6xBWRfhVg+V3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aIyuiBRn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-321265ae417so5403937a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950673; x=1755555473; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr8Dgv5YLH10p9lnbjf8C+c16YUM4Owvp7k7WH6jxBk=;
        b=aIyuiBRnvsSNqNF6dgtyznsnIJ4KGXHt1Z6kucx+r0eCMF+S0CHuL46jpTbAd5yOBB
         q3nKHxVPDMNo5G5YPZPXQaL8797gbQxhcpO02YBQ6fvckTwdDoDLNFSvuipimTCaMofY
         Qd9t5UKgTg3Kb6c+nL+QJfNuBUw/NzXSk0WD2Bg9TEe3ueJ2cdp4xteABgnfUg474Mfz
         9BVvErcpC2yZ7CcpW4dTqNI651GQSkjtqxA9J9TdfzVVVm/fyLZJdrfrJMWQEpuXAr9j
         y8UAQsfqqZrw3wviMOlQ6hQQNEdpxbO9c2zbRamDACXgNIgQiQq7A2kQiMSgpi2RMX0P
         DU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950673; x=1755555473;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tr8Dgv5YLH10p9lnbjf8C+c16YUM4Owvp7k7WH6jxBk=;
        b=Ip/5AnYUxc8QCVyCO13481Kr9RcctxQJRMt70FMf8uqUDR5iQGzyoc6SXv8/kaSjmv
         K5RC1GCMBshUmWSfiQkemzcPqWp4eac0Ha4WO0sGSh30RQ7sIMU3RrtJyYJYwP8NFZ1y
         aDpDRqxTnQ4PCZM0vcBJ1B9jZB7EgCV1Hjik7IKNATbLwub8zXqtJ/XBSTC1J1RSIrVa
         RB1QqJwMSEh6dOHkxCLKrrRlWN/BFYb/oP/MyLawA4AIZZ78a6/uAGCU4FNeIl56D2cZ
         qiEPPQDFnSiYnElIAvHeMfd0tnE4SIcz/yr+4Ccf5s90nWoxxFghacG/tz+qmlHDo0R3
         rhpA==
X-Forwarded-Encrypted: i=1; AJvYcCXH5EQv/UfQfr5iZUouLjAZpl0kFdijt6qck5oO/GxJ84WZ+NHOcxqucuVYJ5jr/BA8CvJPrVqLRteoMlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv9sTGQzawbtv4qr++CkWOyrtqTne/tnltv9E5alHNEAvRdN3p
	SBI6B+PQUBS3mnYyW3q0bmAcXydwlX23nbwT6esKTzOhJtEm8jXaj2A9Pffm0nUAtUBEghwmqrs
	V7mgVqtSqBVq6q5c+qzitivjFm2cYtnc8jtVTSRXS
X-Gm-Gg: ASbGncsSZeKx6P7tf8sjtdqY6cwliv3KgcM1srmmG+/RRO6bY2pPU5bqo4moWBFAlZ+
	/EVsVHvMN9x5kD9mH0glWTACKeiOrVhF3HwxAoAS044V21LsEU+PjMsyK/ByXt14Mix9voVn6Nu
	maWEsdeMx19l8pJRZwMGSDQxZQikOQrRuMn4lzayZh6AiZ+awUuM+QRtakgK9CnwDSq9y6A0fkc
	/RfcV0VleWShT4Zcw==
X-Google-Smtp-Source: AGHT+IEXRfx801PfOc4EG4/BrKtFhf09Jw3cL0NkScavSktACkVTr1aoBoFPmzLZhaTnzALRjHvMK62Cc4teT2kOY/E=
X-Received: by 2002:a17:90b:1b41:b0:31f:2ef4:bc04 with SMTP id
 98e67ed59e1d1-321c0a69369mr1367593a91.14.1754950673350; Mon, 11 Aug 2025
 15:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729091044.95411-1-tianjia.zhang@linux.alibaba.com> <f68d69329455b0cd7e69233547a78a8a@paul-moore.com>
In-Reply-To: <f68d69329455b0cd7e69233547a78a8a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:17:42 -0400
X-Gm-Features: Ac12FXwwv0PJMWmilt3xi132701iQODCFuMOZDvkyW8Rh7xatTBAbHnfX0_-1i0
Message-ID: <CAHC9VhTVNPfEbtqNxLQ3Z+RBt-1gPX-9XnMk72GhJEjA68_iYw@mail.gmail.com>
Subject: Re: [PATCH] selinux: use a consistent method to get full socket from skb
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 5:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Jul 29, 2025 Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
> >
> > In order to maintain code consistency and readability,
> > skb_to_full_sk() is used to get full socket from skb.
> >
> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Merged into selinux/dev-staging with plans to move it to selinux/dev
> once the merge window closes.

Now merged into selinux/dev, thanks!

--=20
paul-moore.com

