Return-Path: <linux-kernel+bounces-797644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A2B412DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEE41751E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E02C234E;
	Wed,  3 Sep 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cf7yh58G"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB731E833D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756869980; cv=none; b=FDhrTfswFr3IfmT2XLWT7AiXq21F69I3bIsazb2AdILyVTjnca10v2xsJ+NaT4IAyIjV1QjDSAx9KQCnMwHm7mXzgRdySGKWJHGKLRIwkSiDOJMTJ+JHWAH2hkz52t3x9PTdOwcFRvdF2CRm8SYp00tiJ0A1PBmHfUfeKXUs9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756869980; c=relaxed/simple;
	bh=dsbUMuchkxY+FLUfTdYfuMURRQP7Su+CBv4AO+D6HWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHOwhoPbPJyHwAxMLlzC5hA4y+6dov83DHXmxtz6+81ub8n9rrdtB7q6KhDstSIylU5D/0mip7xZ2BZkJ3ZdbHJM7HSJkVVDKSW1Ya1k0Yg5/4NMG9o0Hj1klTRBYcumJ+eya30/KrEQ+z3QcJuCXmHsvYhnxQGLhwznfcufNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cf7yh58G; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b47174b335bso680215a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 20:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756869977; x=1757474777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsbUMuchkxY+FLUfTdYfuMURRQP7Su+CBv4AO+D6HWU=;
        b=cf7yh58G3TDdu75szOII6O4Jdoo5jPDQcnohAM9ZAFXPur6FLaxubFN/Aae8PgvTcV
         yCgq9bJQiXz69cO8YVysZq53MS5CbgUpYIWFik+klzQz85Kl/rTpnbFF0xubzRvLQeHu
         72DeQmN7mQlAaBKLAa6Gb462kaKZjCxvT5y0HLotqEk4RQ5xo/hhntWDNQHrCLNZU2R3
         YyjimRTlyk1H6R/EVZsvVjWppHnw17ANKKQbm3/AKNwG49JCBXUph9KOAY6FwlS3jAev
         5B9ncwsr/u8AOrW9BIth+H0WcJLroG+YUYuNBKB2eUYNuq7zfK57R4yXbO2ZR1faD0mM
         XAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756869977; x=1757474777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsbUMuchkxY+FLUfTdYfuMURRQP7Su+CBv4AO+D6HWU=;
        b=WwBF3uRf+l0JixluFdVpYoA2kDYM1rle8pHKsuZL/d5ywjbkCJ03Gqcbq1MXGbeBdG
         SsjyisIXmEFaZ4vMecHEdcn2dZSd27K3ONvPUiYgt8L91/2rNwDST+aQNukGbludxMNI
         rz9ZeikRjnC/YHVxXyy7f6zzJmitt0EhcrOYjEgr17+JpALIAQDBOTpOdHYa6Gbs3RdA
         ed+hlmwQRhwQYe3xIuNP01+q0H5EZWPnZ/CXBt6TfEVbjfrhf5zx+/U1dFuCsKvnxXSc
         4+9I2BRICPD0NKy4UvJGqB4aMMarfyB2h5oSZFjvIjF0gkBGrBb+rQWNyyRih4zJpbhN
         i40A==
X-Gm-Message-State: AOJu0YyAuKUKMy+W01hh1UcUvc01FWzZ7kJQviAMhvLqOlDnR6YrUjYw
	S5mlaeBekiCItyYhylKsxNuJ95aGgxjA0AT1OoEIiVE0rvqkV7EWeNdiBBC7avmf5qNWNPQxnJM
	D1fYCLV3GhECgMKYe3qvMLFx7UfhhTvcEXjZMINZ53w==
X-Gm-Gg: ASbGncv+SylJRU7xphhOGqObV+JHInhSvijFqmmW4BU0qmMPFmkzZyix18KTTEglAh1
	AX2yJXlLLFdjzHg3Z6WgFJT9CbVpp4fpkbQEZHF9RJBoZC4ubIVCCncvvZtzwrpJcS4j6nE4qWz
	Mj6sP9SB2jOnXnOceqjPJgbOJuiQfpzbMQUyw/3XLsaJSEb3T1Qa+L2QxvN98fw/O9DSz+nZcgr
	8kv+wMggxW3C94Wk9zJ0Zo=
X-Google-Smtp-Source: AGHT+IGatbds6HWDknLWZ1L2O9lbrf08fg7bDuv3l8OWOfTUkDBu4wRr1pqOf4LQlR3uGt3Sz1bSIecBZn5z+/FVqKA=
X-Received: by 2002:a17:90b:4a8c:b0:329:cc8e:247c with SMTP id
 98e67ed59e1d1-329cc8e278cmr4685225a91.8.1756869977391; Tue, 02 Sep 2025
 20:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902220803.1932692-1-csander@purestorage.com>
 <97fbbd68-cdd1-49fa-82d3-e3714ca70eeb@kernel.dk> <0be5cd99-9b0d-494a-8648-d767e06eb02d@kernel.dk>
In-Reply-To: <0be5cd99-9b0d-494a-8648-d767e06eb02d@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Sep 2025 20:26:06 -0700
X-Gm-Features: Ac12FXwY7iwtSXSH-lZN7TuzuGT7q6EjXtOBj4URTE5m60ZmkzahpiwrRPL_290
Message-ID: <CADUfDZrwQD8zUoigukvHhZYX7eR6uh1RB-VhmDUH9Hws_NG88Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:29=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/2/25 7:28 PM, Jens Axboe wrote:
> > On 9/2/25 4:07 PM, Caleb Sander Mateos wrote:
> >> As far as I can tell, setting IORING_SETUP_SINGLE_ISSUER when creating
> >> an io_uring doesn't actually enable any additional optimizations (asid=
e
> >> from being a requirement for IORING_SETUP_DEFER_TASKRUN).
> >
> > Indeed. It was supposed to enable future optimizations, but they
> > didn't quite materialize.
> >
> >> This series leverages IORING_SETUP_SINGLE_ISSUER's guarantee that only
> >> one task submits SQEs to skip taking the uring_lock mutex in the
> >> submission and task work paths.
> >
> > Interesting, would indeed be great to kill the lock/unlock for each
> > submit and local work run. I'll take a closer look at this tomorrow.
>
> I just noticed that you forgot to CC io-uring@vger.kernel.org on
> this posting. Would you mind re-sending and doing that? LKML isn't
> really useful, for anything really, the key list to CC is the
> io_uring one.

Oops, I accidentally copied the wrong list address. Thanks for catching tha=
t.

Best,
Caleb

