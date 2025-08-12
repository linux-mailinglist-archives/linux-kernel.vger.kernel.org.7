Return-Path: <linux-kernel+bounces-764964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4680B2298A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CB2586F12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF7C2853F8;
	Tue, 12 Aug 2025 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="K0THCnpe"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB032868BA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006457; cv=none; b=OufdVuXD/uPhfx9xTFoEEahl9W5AxU2r3x+WE3Bsv7PyK7rU0P+3ziuijz3zzLRmkTzmyqxqEsQFtiY5DsCgp3Jvj3N8AQPWudGCUQKYPIw9Z4jX/CP4ZUvrQcSxsXEB+RHelX9cX/QqaEY32zMdVrqaXitwdLWVkGN0C5BOQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006457; c=relaxed/simple;
	bh=ZEQS7dHy4bqa5xEK/OWh6tiW9JpSTnxX7NCQEJRoP3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/MxDyVd+sjIh8bTcLhm0FgdDEV+AjbnhJyfdqGsNpU8kbRyi1nQ+Jcki58j8rFxO2W7xZouY0rghTVCbkDTjXNyyBTtZGeJ3YmGcJvcRSzZL6QhXmWJc6otAMZHQKpMtBWC8Q8mXpEHGOjN34FQGf5hYpsy67Vn2D0VbjPvM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=K0THCnpe; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b07d777d5bso62333191cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1755006454; x=1755611254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiaiHLfj5U8yaY5aeIgIVQg9pcSst1kk2u6M/Lgbw4w=;
        b=K0THCnpeTjOMO+wmtK6BXCJiNqGiOI8E/zYggQPT5DSu/DlHxQylnBcBWtAujk1D8I
         IdRRq7AK0to8H5ZxTlXUo9Og85GnOdqb5eUXv0/u4FZL1eiORkLaoQqpzYqHImicS2O5
         iIzYxIKTWl4Py9CFJcnK27fyl8Po+OERdIbufRP7fru/9fCyR13XnRCXJHGl2gmKR8t8
         dRKQVst+PEfSiFNwgAjXZk5XaXBRrZR6/gvLokiX60z8fKHTqmM6tY4OdIttClwQEJ6v
         qaSLzjdgu0/vLz7wcdutWb0JCH7SjJQCuDSwzm5lYrLtpAizlZ9DFHS3vEUHdPfjZHmc
         uV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006454; x=1755611254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiaiHLfj5U8yaY5aeIgIVQg9pcSst1kk2u6M/Lgbw4w=;
        b=f44uma+iCVTCKJBtJ1zDgIZl6c7uX133U5mP7cUatJv6UaJCgr2WJ64NOWt/j+vKjI
         m6VvxJTlVxdh4OJU/LS3tMI1YlfbL/UTwAxjSvd1XrEryzWswTL3MPZDysR72GQw6yh6
         v9H03q9rfxthJq1kLl3MU2/YgfeFULhReaFVxKLKiMI6yzsoWD2w2U6S9eEVG8txgdxv
         wjZtANy4kexEOAlGfjUeOtHAbAsXHguLlmriAaTBBm4fWWnbVvtkqm/9UMdgX/qWQoyZ
         1DSXs/4CKimadz2Kml6Dohszr+M/KAiRSrCMoo4YRY0I0vn3CGF1tGsMAiB7BNWxmM2D
         Vpeg==
X-Forwarded-Encrypted: i=1; AJvYcCWGcog+0plwzPnMPD+hanvd4y2h2cGYIe0nYpCSC4clAF3zE8B3m/8UoPaTHdOjcJFRzQKlsPbzTLGR4As=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJexD2JGGTUJylHsXuks7tJnU8eSHmVBMUBdGtn6u7tW7cexgO
	8L8BHzXA3jKqDXP1/5E4mfwzAOjQf7EJ8GH8APfQiGJDE6s4kra3wH28f9oMZBTPpTA6ckwDoxs
	UapcyBUYmCfQPhEHm+YH+wf49hcYzuKZLMhRWnrksCA==
X-Gm-Gg: ASbGncu6ldrOzU+ujs1BcG9V6YoeO9+vSZAPTUDHR3GhBlIJmOmhxjXPu2hl0EJWg/7
	c/6VrrIXDKK8lb0jGK7bjLxlZBMGOpOUnkoxRlBoxHXncpVCcrygfpVZkBga1qU2KU0PHtg5+QC
	FRWMumBgOSuwe4qLTQVSv9+0kZbWTiu/HcWvoTnxcpV9a0t9WSZo+ltrv0NEo7T/PoJrTe0wz04
	9ZC
X-Google-Smtp-Source: AGHT+IF9FZQj5pw4nHAwLVl/go1Y++Pq0B8DDhdGaT/iuEWOeTWwC7Lzx4CQw7oh7nPUzVFMmTtXLbUtj63G3OrsETo=
X-Received: by 2002:a05:622a:230d:b0:4b0:a098:1f75 with SMTP id
 d75a77b69052e-4b0ecbb0bc3mr37690691cf.8.1755006454033; Tue, 12 Aug 2025
 06:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812164436.557c805f@canb.auug.org.au>
In-Reply-To: <20250812164436.557c805f@canb.auug.org.au>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 12 Aug 2025 13:46:57 +0000
X-Gm-Features: Ac12FXzdOr9gxDZaTKBaBDu-lCxDswcINL4uysL5NReZ5kaQL2LOxR3gFpp4Bto
Message-ID: <CA+CK2bA=thKfEuiFZ-Nmr1ZNALC7ZcKv5uPVy2RCgc-Jy96Now@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the mm-hotfixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:44=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> In commit
>
>   25ee3c404f35 ("kho: mm: don't allow deferred struct page with KHO")
>
> Fixes tag
>
>   Fixes: 990a950fe8fd ("kexec: add config option for KHO")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 4e1d010e3bda ("kexec: add config option for KHO")

Yes, this is the correct one. Thank you!

Andrew, do you want me to send a new patch version to update the commit log=
?

Pasha

>
> --
> Cheers,
> Stephen Rothwell

