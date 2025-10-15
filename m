Return-Path: <linux-kernel+bounces-854015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7CBBDD58D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77F79353FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3AA2D7DC3;
	Wed, 15 Oct 2025 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="SkWLBK1L"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35152BE02B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516436; cv=none; b=RujeCxXSzjUdUG+vANlmEbuTFKxzERd4RivG3/XWclk6VuqAoPb01JVrdW+22XPvzHFQe5zvF1WayEqUs78ivbLUbpPl2o7Gv+yXX760FRqzN70B4hzIg5M3wPRKBHY4nAs1b472C7ol2jS8PBFve1OetK4AWRO7jhyT+COuSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516436; c=relaxed/simple;
	bh=ujMLqWA/AaU+bOG0VYggNI6i6amNpMlNzvpKsAy+smU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNKGf6irDvQ4EMFZPb6FA6yiZOl50Nl3vDurW+VooOcQOkxiNMaMGK2UbFZ9mSE+ZIDLux2I4LCTzUilgr27V3jPo7qWy/KLdv+BfG/V6voqKDf3lzfkHe4BCvsUzXr3wdxpe3rBLoaSr9GMpOWxMhMOk2KI8NwYePdg0g8ryrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=SkWLBK1L; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d71bcab69so58432727b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1760516434; x=1761121234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujMLqWA/AaU+bOG0VYggNI6i6amNpMlNzvpKsAy+smU=;
        b=SkWLBK1L5/0WoG6jYFEGoNG/knbrLR4nJ1pdGqSuLK/xuj322WLyst01kH7HcLfKWb
         w4ZH67Ce/iz06Hbrbj74LiqHV6B/+b0ncmpy6Aw2AuRbXwhBOlIuSVN/j1hh9Iz2MKRT
         BZnlAavw0LUgqWlxdrRNBCNEQaX7JcjBlVT44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516434; x=1761121234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujMLqWA/AaU+bOG0VYggNI6i6amNpMlNzvpKsAy+smU=;
        b=eyJZSNH/xe1IL7/m3LOd2qAl/oZDCRKYCAgZxUh4QyiSR12AISC6zZoSHl854hUQBi
         nIEmzMMrZmO2zYOjRnrIdys6impF16USllLaUgqI5w0jrkkuO2swg5CduJ9NbzTB0UfC
         jCgrCPv9mnbUWU5wGHaKS4/oml8BW8W5htNtAbwfH0rN/J5nfVsGQfOj9OEnd6MBJ5bF
         cm0dOtoZwPekxWzfnQ7urgxur6z2dqcIEXOPOywtrY7gSehmQupBjGLusVzPg9RIc2AV
         nOOa3dH3g53s2YzeQtL69DpwhQtKU5f4rO/WPgQ0v5lGbaBoo0RSOEPr6O1b5ghcIF9W
         2rSg==
X-Forwarded-Encrypted: i=1; AJvYcCVWYfraEwOhAii3w9PMPLtgrPWZhpOQi9GDU6mV8FIrh+KPdXpj8BYs+sjDdtUs5Df3w6eCUhT9JEh1MLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsk7xgCgo2aCuCfhplBPNNDKrLqOyjQIDT0Tk7u/NeTVHEocL
	4XViAGto93MHe7csIKKHHIEmiA5ymam9tdt2U48HzE1Gkgc4mozHH7mp+5p/Bw7lawLL/Z0S5uS
	958m6Tac2o5Dm9BeS62LteTWGdV9pQTOfVyrr4Wku7w==
X-Gm-Gg: ASbGnct8nztzFEtZ7Z7k+783JeWkYIz+CdMRYxbGG0ao0EXQ6GGEWxjOI6GhD3nUoRC
	ZsI9wDSyKI+9W2PnNGzp4L7tqGUXJPP/+NQEIdeQORA9FsBfS0codgENM4KNtI3j1iXs+CGktLe
	cE+uUrH5kw5lWrCI1o2/YnKVnplf5Kou2mhbtXOm++O5N4LX00Hsbn5lPuwyWUa1aYopU/eSh58
	IaTTD2NUINjVe60yvU6gf2xU5QBRe1vXj7A
X-Google-Smtp-Source: AGHT+IGmrzcWBjp6jhCquKjpdoKoFojf89c4KOE6qlCTGev4ZOzdOefYSCZAWaNAZ+NXKPXbzuB3TzL6GadGRgU9k5c=
X-Received: by 2002:a53:d892:0:b0:600:39b9:b14d with SMTP id
 956f58d0204a3-63ccb903543mr17998198d50.38.1760516433682; Wed, 15 Oct 2025
 01:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005160518.10000-1-ssranevjti@gmail.com> <CANNWa05YhQ9Ycr13e3SOYgD=cms5iskSENUwXUgk0T8zkMy97Q@mail.gmail.com>
 <nsj65dhgvhta45hng2ouj2vq4hclu52bdvlkvpzbucgmkqmacb@w4g5qzmqr5of> <CANNWa04Mei+hLsZ5JkCfejgiByJgu8e1Euy--ypT_ZmWuvvHeQ@mail.gmail.com>
In-Reply-To: <CANNWa04Mei+hLsZ5JkCfejgiByJgu8e1Euy--ypT_ZmWuvvHeQ@mail.gmail.com>
From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Date: Wed, 15 Oct 2025 13:50:20 +0530
X-Gm-Features: AS18NWCM2xJ9KaYeRMppoYhB_wWzCV-2W-2W3aW3R8r_os6gn3Y_Ptp_zxbiXn4
Message-ID: <CANNWa05W9C-Lb6TcqanAM_RNeAzDBdyL=c8AEqS9udRF3YX3pg@mail.gmail.com>
Subject: Re: [PATCH] bcachefs:fix use-after-free in __bch2_bkey_fsck_err
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+55c84106264e92ea9ada@syzkaller.appspotmail.com, 
	syzbot+564efbe31172fe908429@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback. I=E2=80=99ve tested the patch locally as well usin=
g
kselftest, and it passed successfully.



On Mon, Oct 6, 2025 at 3:16=E2=80=AFPM SHAURYA RANE <ssrane_b23@ee.vjti.ac.=
in> wrote:
>
> Thanks for the feedback. I=E2=80=99ve tested the patch locally as well us=
ing kselftest, and it passed successfully.
>
> Best regards,
> Shaurya Rane
>
> On Sun, 5 Oct 2025, 23:35 Kent Overstreet, <kent.overstreet@linux.dev> wr=
ote:
>>
>> On Sun, Oct 05, 2025 at 09:38:25PM +0530, SHAURYA RANE wrote:
>> > #syz test:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git mas=
ter
>>
>> Instead of having syzbot test your code, please try the ktest syzbot
>> reproducer test:
>>
>> https://evilpiepirate.org/git/ktest.git/
>>
>> build-test-kernel run -I ~/ktest/tests/syzbot-repro.ktest <bug-id>
>>
>> I get very nervous when people send me patches they've never run
>> themselves. Always try to have eyes on what your code is doing, try to
>> look with your eyes and see that it's doing what you think it's doing :)

