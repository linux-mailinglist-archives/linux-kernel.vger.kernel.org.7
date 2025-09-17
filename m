Return-Path: <linux-kernel+bounces-821758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD2B822B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B721C8109A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B1330F54F;
	Wed, 17 Sep 2025 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B+gLnnSa"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6412FB991
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148474; cv=none; b=fzpS5XkyYUytUfO6qOBMm7QTTu3IXUeSMSupoA8klwqLv4ags8Bto6Gkxevy8VktDMRBMIDikwiZNx1mjMSsHoCpNlPIwC4mfO3whu3oqD7hYzRMfhg0i5gN442t2JrmwFjim9/kIFOeO5wG8J0Q62AYS7UL5DOgTh83oA0amjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148474; c=relaxed/simple;
	bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Coy8tiOXu0A5Nh5ikP2XSaI2tiMSvBz2gU198VgTn3BS+rmSBk1ypWJaVpBAv6k+IAAGMtCqzIt9iqFS8mBzOFvOT8h8Au2jdWWEa+vwuQJjTw49qigGuNzPtOu33x0BvkOkA11mGg1WWtaj2/qhKQDD1abeqVvduezmK7dcduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B+gLnnSa; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88776dcac7aso14315339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758148472; x=1758753272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
        b=B+gLnnSaaXzdaGsXAUUdE/EbmRilMBO99Ow9rAbRw94GX5mBBRtYHiaCHiS01a+eV+
         1n63IMAoLr5s84tDAXr+O50J0KBS+o32qblC/BdQ1K6rXeqC6JsMsieU8WzgsMEaaApa
         /cj8Qo/0R32ODYZi70PxfzGuEhQEngduLShWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148472; x=1758753272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
        b=ZfrnwPilCGfHI5Ta3Q9CsX0/nR/ietrCzLQx5u8N93E/wgVkvYXAe9OCAfzSZMw9Pu
         hLZWAjMRgpTucg9DtGbiODpsJ2hm2T6uFPVIgHUOfF2SgZ+GJuf7aGgLLY/Z/vRXcfRR
         L1md9QSCm/Li253A2fpf7vSUqSxMUxE7UczD0enE437FaYeEwLPyk4mG4xb0DLH7Jymu
         54Q3XU6d53LxrjMy8HmB0COYBULmf4oVGDQOPsyXWslL7ZvMCKo4pDyve6EWqZDkMlkg
         F7T2fZEu8zlsAec/7niVKkh6sUUZVJlX2y11z4d3s4byzG12aUvlfRNRhEjHCFcelUEz
         cMbw==
X-Forwarded-Encrypted: i=1; AJvYcCUq4gf0H0BRFAQlZyrj6E0CRUmptrsIah8bR8XtTOIp4XGyJ5eYrDovP75VXPwJH61wDKwUE3nkuebtc2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRG7AQxAhpWNUFY9L+SZpNLjW3rpOX3aPHpmaMVBrWjZLvVWW2
	ZTHIMwuN9X1YaTdKzjIRBZ17YiY42TP3TCdM2zotInb4M9bgsa1H6hNjc5u0rEZIdX6+641+NDx
	S6MiR6Q==
X-Gm-Gg: ASbGnctjailx8KinLTdSAD+0aR4soppngM8t496urgT2ZmHS1PmNZzQ8OFiXzvtDZ3I
	3Amjo1bvPyaowbb3dE6TeU7lEeHOg4gBV78mwxLuGzrUAFS/O7bhN/LwlGjIUYiTTiXMGsVkoCe
	16HUWqQu7DcPtZlGYtEd+OhmwdlMpqzT70TQPQQHISMAMv5A9Czy6pYrH03R8ntSWYA29QEeLqb
	2E4cBhTe8MY9GvkZbV2YFbdUCLZHffFoq3d1h/fE/U+uUdnw7//fK3Qh6isSrZq29NtbH5hm9V6
	oIKvtstYCDlFsABpBNpRx28/1P3BjcxLG/u3LA5govrR5ATpErIuKRgn51/MQUjlqs4p8sqWBP/
	zV0d4c4cmX6Vak+n493drp1QbmqqdBrD+dxqKdNvOY8rMed+lQC8JxbgmcD8t8fSjn/TaZdyStQ
	duXuDOGQ==
X-Google-Smtp-Source: AGHT+IG9bP6CUTzPQyW3oHroWRqWovzrjQ+BC6LQ8brrSherNIYmI578mmb+f2p/6B0OPhzRHF/sGg==
X-Received: by 2002:a05:6e02:1254:b0:424:5da4:b9c2 with SMTP id e9e14a558f8ab-4245da4bab0mr2381605ab.24.1758148472169;
        Wed, 17 Sep 2025 15:34:32 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d592a555esm227917173.84.2025.09.17.15.34.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 15:34:32 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-424195ca4e6so35645ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:34:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwiNax9ybTVpeMeRCKTo7o+X0cgOr/4qFcAY+4kJO8sbHL7wuxkB7DugyUF900u9mAeO/ujw1IVGTafLg=@vger.kernel.org
X-Received: by 2002:a05:622a:290:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4ba2dbd91e3mr7888171cf.5.1758148118686; Wed, 17 Sep 2025
 15:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com> <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
In-Reply-To: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 17 Sep 2025 15:28:27 -0700
X-Gmail-Original-Message-ID: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
X-Gm-Features: AS18NWCUMtpdk9H0fWidPAaF1Bc8oxlz8rdMZKPuVQEPlj7Pq_GvycrjQRByVOg
Message-ID: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:03=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.or=
g> wrote:
>
> One ordering thing that sticks out to me is
(ordering can't help here since we'll rapidly be flapping between
ovflist in use and inactive... right)

