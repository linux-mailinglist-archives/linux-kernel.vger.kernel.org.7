Return-Path: <linux-kernel+bounces-771248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00956B284AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25664179669
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5E831813E;
	Fri, 15 Aug 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMWR2raD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179822331C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277612; cv=none; b=I8fXHCbgEcB4hRpdfaX0PMY1iD/Dufz/KpYvtKFqIIuC8lM3aaYH/G+uvE8KrJ5j6qvXX4z0/07WbjJpVBC3h6Fo18gr5rLZHAaqjnXVZmO1s54ptRGFUQRXoP4fgq+3wxw/6OjcDYM4QUpt08KBwQf/oDv3+S2Ytt2qNaEvtx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277612; c=relaxed/simple;
	bh=pL+KIUNonL6GieFzGfDFgPzMGRCJoSc59aGwIdQvhhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8Q9EUQ5uD1U62FlxKR+yrPVbn+8Wny87EucSSjr/L5AmUxaSuHF7FxH4xiF2HW/m3qSw5uwtc5HJBH+PtPxwmP3oU1bljLNHjLe3DtJP6ovjbkpdu2S1D6cAZ9xjcPUh8AmbPoM919jpJc9YTRhFbK2Vj0RU3TnoqtaoWgTF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMWR2raD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce5277b8eso2276707e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755277609; x=1755882409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL+KIUNonL6GieFzGfDFgPzMGRCJoSc59aGwIdQvhhI=;
        b=MMWR2raDt4u+TmwPN8wEaVMqxqOCGxkpfm6MXN5C6iA3BEaDeNf1Tw1CaAtuft3ip7
         OsmbrRSipsgp5WakIZzZsiZkVkvLNO+PrI5U2EJuuNz1um1yBj+n7V4mM5tSeP5rnI3j
         eil/VT76nW1i5qVVsk0/OjLuhnZ3fM3/oSusc+ZMpyYYLJtvFTj3XON39jwfSva+RRjA
         OXNHyCSSJfVQo6UOW7orvZW7OUKliCM7RDQz1PmNxx/0juR/ryFGSIiOShq7PAuEpHRb
         /v1bo/SlxsqDWU54QqZxHtsrGH/twsQeCLmnAEAD4spRmRzeteWYUAsgKx3MF+lYL9HN
         yHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755277609; x=1755882409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pL+KIUNonL6GieFzGfDFgPzMGRCJoSc59aGwIdQvhhI=;
        b=B70rp8OfUphgsHt+wvnFGM7EaA5HfWT307f3ePRmZHR7qrWaRJVP6g/zMpIwg0VZlu
         0w4T12m7hm6XkoYY7wl9pBgz7zbevxNj6y8BqiF5fomg2I6vQhTKiVBFAl8c8dKhdMnZ
         SewWmd4QV5umvU/xVTs/62vhytzpbdJHChO6hlZt/Vg0VCO4/IUqeZCZY5uCi/r0GeZ2
         e6S9UQvrnZ4rYLYTU0GdIjuJMidg/muqNLkYcb5VC9AifCV82zq/Jyo1y32zWzfsl7Ho
         CwWMoEOKGqDVLCDch5Z7mIJ+dbi2cvxBurNwvmrVMdjPcjE0T/oyclRJ6tEU12VAQ8uh
         8yOA==
X-Forwarded-Encrypted: i=1; AJvYcCWxLvRjl0WXAoUuE2ZiPrJ0Qf6ASt0DH86fyS0aKbDWfVwAr2YvruoBgxJXax7YuuRQ4mkC4ii9Wlx6qng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXmK2mjFubBvUh8UpMmCFLZw9M/msKLDwerNhqjbpCZFHmshM
	1dPI3egNCROocPvOZIUdk8tgfOH7vk3zvt+LfjNwUt57f9JBZ3AEvQZWBIWQWDMOs5ZDO6xXZ7r
	x6uvp6SXdO+UrNcge6qdY4lRq+MKjUsE5OjlV9p4b
X-Gm-Gg: ASbGnct3RcsLEm2EvYCjGQWCh49w4KwiJmPg748nm6Lu36jO3FJc67GGBIJpZvYKMWL
	s682LqUlwMSLi6gC1TEkmzHKInMG046+AawZeuogLK34+CASTJU/+ASjeTLc+o/QiKvKB72qxIX
	Y2/eovSeB7OdaoPiIkrwu+lLlsOoEbBCSPd5Sr2N3sHh+ufg5E8Wm9dWY2PoxZHxwioy9CuQfpO
	8YKPFTi36mN
X-Google-Smtp-Source: AGHT+IE00vYYh6yZ2ovM5beTH+9/5iG2gqMZLSk5Mk9qR//MtgKHHWRi+VX3T8bpUsXQfN41PGgiSv5Jgv9nB4pa/qE=
X-Received: by 2002:a05:6512:3b09:b0:55c:bfee:d959 with SMTP id
 2adb3069b0e04-55ceeb8e4a2mr645923e87.55.1755277609209; Fri, 15 Aug 2025
 10:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814162252.3504279-1-cfenn@google.com> <aJ8iNLwlf4PAC0h1@kernel.org>
 <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com> <aJ9fy_sO6tza9qLF@iki.fi>
In-Reply-To: <aJ9fy_sO6tza9qLF@iki.fi>
From: Chris Fenner <cfenn@google.com>
Date: Fri, 15 Aug 2025 10:06:36 -0700
X-Gm-Features: Ac12FXxi9rDKgCbCPcDjkhN0YzfqTpcE1IQTDtiiLTRyzFymdSe7ALv45u7gK3M
Message-ID: <CAMigqh2=Kmnv_rrT-gBtESSXtnMrxU=VJdrYE6_9NGhKBN+ZrA@mail.gmail.com>
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:27=E2=80=AFAM Jarkko Sakkinen <jarkko.sakkinen@ik=
i.fi> wrote:

> I'll with shoot another proposal. Let's delete null primary creation
> code and add a parameter 'tpm.integrity_handle', which will refers to
> persistent primary handle:

I'm not yet sure I understand which handle you mean, or what you're
proposing to do with it. Could you elaborate?

Thanks
Chris

