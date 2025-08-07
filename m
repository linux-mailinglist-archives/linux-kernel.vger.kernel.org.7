Return-Path: <linux-kernel+bounces-759228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3EB1DA94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3010A188F2CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6EB266581;
	Thu,  7 Aug 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1J8Wu11l"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418425CC4D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579380; cv=none; b=jALtSEyW13zPlF+VennnfHmm46ohxkhnzlHlM46MvRgzxzP6VA6RoiLKKRQucMpgMHO4gDcqGXWFZW3AgMmSexGJ/AJAPoooAD9tpC+iaicbE34q3eboS0Brk69COPh5km+783lTvOqwSNaEVC6CFgDlbuzdvSo/UbabR9HE8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579380; c=relaxed/simple;
	bh=vXI9Zam5eYCmdhXZAZEND+qlnOZtF3m0aq2gFtw/4+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkJC6S71WgDEhbdjHjtLIhBaJqDtuX8auFELj3J5Mn0QHAmSaw5er1kUVDA4ltqVqaSfzAf9/BwBZnVGLIqm15O+BtjQ8XbKBG8Yjh/h6TBVMhCAZ5xPlj+8pUpZ8OVfzBwjWAcMsI1gf/JHwRnf1DUfcB7MUk7Zm91s8e25WgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1J8Wu11l; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76aea119891so2280257b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754579377; x=1755184177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXI9Zam5eYCmdhXZAZEND+qlnOZtF3m0aq2gFtw/4+4=;
        b=1J8Wu11l6Gy7VVNO/QwqqYEuaa34gA+Cs7/kv3fet3ag6W3hJrZatjQfMUmWECQ7ni
         soXqdD0BKLYhti0KC+r+cJ6LmVFAFcm+UtRT41bhZ/5s7gHQcOkIlFuRhu1jdLAQI4ga
         4KAawXhziw/1r4vODcSQZ6L/Qk3raaZ6bN8gOO6jmmacDKfw2rjOjHetC99EJAh1gn0P
         HiE1iNCQAsXF3SiZ67qnDK0GL+Vwq2ciNUe2z2TY40bfvQBT4LE+RH62T7he1UTHGt/M
         dYEJ5+QtKwGh0MaT00T7o0dGurtb6XqnugI9YAvOHRGpzMEdn7ybx832QZTQfLh6r0pI
         myLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579377; x=1755184177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXI9Zam5eYCmdhXZAZEND+qlnOZtF3m0aq2gFtw/4+4=;
        b=VswTHSAJyLi7kDD8rKaPL1gBCQZHFd0H7e6pQJROj3DvcETQ/49JQ9Ax4imH/FrjV7
         hn2ZuBj/e7Wo45+fty3lOJid/E1s6L2mrldmjHmjLRiba2GIPnWV7hYtouKvGfd3zKcP
         qyRBM7eptAZRV6s9t0MbN1nf7Yho6X+CwP/EP/TNAcNuWO1/JybQSmKRDS/wBJHOJS5Q
         5l4n/Mq8ZpRV/+Mq3hzOof0RA5ycL28zjZDZMEJIFy7qm1COnrpyYg8ao3DAQE/88mtD
         TmsEzYoHt613hHcCuB+INGPr/2gd/9VCJheIRe2o1F+Os/q+0OnEr8PWUNqMIo4vkZoa
         KrbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8kMwwE3+WuMUd3QRwqKgTqXPA0eXxyWhVPB54PfXyh3MV0ZaqKVfF6LKcmIGlxQJM2RxkTQTX0DWJjuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJ6RZi43flFpysAsebCVe2t3CuiSHX49UzTAebTUNkSonbzfX
	/pfAiLUv7I9ICRUCIivhpki1qPgEM/7JA9wsdWuHePVwjIjmtWdcRCZgvpGUURhHwCPSeBxUWns
	LT0a5qeuXbJEvnyUJ9q30FAc2Hul45RhbTrIkKMa5
X-Gm-Gg: ASbGnctoMghAFfOGSFRCs0jVeX3nze+GyV388Im+0BTx1pSB3WMrmqOlk8wNHVnXpbT
	ujLwC5izHM5rdhFNnC2mYoVNOYHUI2n3UZP7bWLsKBHvpIVuVJOcrcpnl02NgQ8kEhxkGWfDpX2
	afilqfvxg3EaChsi5SfALc5/UBKtigOVWx/bI5RQSboPR7hFLH7nf/2DO8bee4u/jHizYbQGHQQ
	I4TkTDlXbem2mTMvc1jclNnyd3QTfMbUkZTNUth2GMiPFVH
X-Google-Smtp-Source: AGHT+IG8QlJyGrI/LcZsqPJ4tTpGg3cKXVWXjR1Ly1wLcsKoXFz1GMnQ///H1MLhMEXGNQE8r3JHiVH9uD53B/zlYEk=
X-Received: by 2002:a17:902:f64a:b0:240:4d19:8774 with SMTP id
 d9443c01a7336-242b076a24amr47832795ad.24.1754579376834; Thu, 07 Aug 2025
 08:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722100743.38914e9a@kernel.org> <20250723162547.1395048-1-nogikh@google.com>
 <20250723094720.3e41b6ed@kernel.org> <20250807064116.6aa8e14f@kernel.org>
In-Reply-To: <20250807064116.6aa8e14f@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 7 Aug 2025 17:09:24 +0200
X-Gm-Features: Ac12FXyf-LII2oKhENT74R1IUHeqtiItmnUOlh8HIq0rExOfD6gVb883YMc88zw
Message-ID: <CANp29Y5mZJJgn5LYDiLx11bH__NXZ32ut6VUTsEyXwqrOhksTw@mail.gmail.com>
Subject: Re: [syzbot ci] Re: net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Jakub Kicinski <kuba@kernel.org>
Cc: dvyukov@google.com, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, Aug 7, 2025 at 3:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 23 Jul 2025 09:47:20 -0700 Jakub Kicinski wrote:
> > On Wed, 23 Jul 2025 18:25:47 +0200 Aleksandr Nogikh wrote:
> > > On Tue, 22 Jul 2025 Jakub Kicinski wrote:
> > > > I think this email is missing a References: header ?
> > > > It doesn't get threaded properly.
> > >
> > > Yes, that was indeed a bug that has now been fixed, thanks for
> > > reaching out!
> >
> > Thank you!
>
> One more thing, would it be possible to add / correct the DKIM on these
> messages? Looks like when our bots load the syzbot ci emails from lore
> the DKIM verification fails. I see a X-Google-DKIM-Signature: header,
> but no real DKIM-Signature:

Thanks for letting us know!
Do these bots also face DKIM verification issues with regular syzbot
emails? We send them absolutely the same way, so the problem must
affect all reports.

We use the GAE Mail API, and its documentation[1] says that it signs
emails with DKIM only if a custom domain is configured. Since we send
from the default GAE domain, this would explain the verification
failures.

We'll explore the ways to fix this.

[1] https://cloud.google.com/appengine/docs/standard/services/mail?tab=3Dgo=
#authentication_with_domainkeys_identified_mail_dkim

--=20
Aleksandr

