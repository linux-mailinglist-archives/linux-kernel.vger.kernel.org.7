Return-Path: <linux-kernel+bounces-821759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD313B822C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B4A624883
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894D330FC0F;
	Wed, 17 Sep 2025 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo40RZj8"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D021CA00
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148722; cv=none; b=aDVttU5sm7KZWngWYXhgHYvtlOXT4KnEWIA4BnjzQ1lhYNbi94C7X3iQWFiOrfaCQ3PHO/CX8dANP99DazBD4EBQfGfjxJ1SksZZI4Rx9dKpvbfqiQA7pO94TZqP5YADLfgskJNIGea95c79pv3johFPEYayE3DaV8PAOauMBsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148722; c=relaxed/simple;
	bh=/ThNkGr+ZEjqTZAQF+vgJk0idxNVNcO73FYaVFQDEHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qteIHMYPEbtQBs8BZugeX0XPmCgzOdmro8Hx3wxWxDduqwpZ9Xb8YGirTM9WX7Ra8/OyOuAoURqgJo3eE+SAl4mJnE6R3nMHRN/uN80WGMuMOhnCeWGJYL4VaiWpQPdEzzxVD914WpeFxzRj8A4Y2WKkOxLUPgW0DqWYPgGVh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo40RZj8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0787fc3008so40290466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758148719; x=1758753519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ThNkGr+ZEjqTZAQF+vgJk0idxNVNcO73FYaVFQDEHs=;
        b=Jo40RZj8Y+fSh8WxQwb4kkcp03yvJIUpOWA9cdy7FWTd6uFBhU1hZS90MJGxe9XEoc
         yAOJ547sKIMtJgLajvQ1VkSS9XqPlLkkbrg7/U4iSkFFJ8vW1tK91wcUTyfwsjTGqHZl
         7/4pbwhK/iReSUvORozQL71GgfoNSOm7T9+8hK5vYa0Fj9SsyWmlVhb60xVUH9209Zu6
         Mb6ka2sT1xRD7SquiptIIRE5CHOYNWld0RMeEG8EPN8whZU7Ob7Xd8R7/ibvDS2cCR1z
         UpeQBYc/XWZuiNOp9viNOYHbFLLoe/sPmIfsrhLrIWTob0MfH3E9+S4LgcKZcapAq6Tj
         twRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148719; x=1758753519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ThNkGr+ZEjqTZAQF+vgJk0idxNVNcO73FYaVFQDEHs=;
        b=Pmjv9qSNqbHr/dAmBA6IPnzw8M4A6L3oKNfI8oUvDCUj96YGxFHGF6Oteo62lmpmIN
         28wDlQUM1RNE5fbRW+2K/5AKgiKjNYgw45xriOwPcSGPccRPAGn6C5aWGYrb8ZKByo/C
         zFKx/uraf2+rKlF4V7613CBbIkyY4Qmto1qPkXd0WuhXglWVCgqvWA5zNylHgqJsF5Z5
         5qiITyog73DiP9vWtxRFCY7NnQHCoGuVq6CUnU8mzhS5J+yRIemK0iQh4sekdjW0f44G
         RYBYUhyvX+IqiAu5DMtRRTDI586E1O8fRA4MVFVWoAB02UqAFMpavfhW/LZ3h1kJocpD
         Q86A==
X-Forwarded-Encrypted: i=1; AJvYcCW8IlM0MI29ChgGvXfzRhv7ryJAreWMhHBcLhMmZfhP9yuKw8hMhMIxMcGh0YsRy0S3mmotocSJcSZRSbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8VOPXTHSrnCID0+bpcF7HHaAZ4Wxq119MU6QAODDX52YANi4
	Dr4H3peJh2OzprEZ3X+CvsKJOR2GZIrO4p07Bp5o+iHeGhHPgZ+FfydQK/ll5NL2lT54sbmNfwU
	1P0ZSQJKkQuwUoRZxMMjk2AhnuiRAi20=
X-Gm-Gg: ASbGnctU+3t+duWyJ6NIJ053k5CH/wmTSKsuMa1p6QLvOwW6Hq684O4O75CvtL24MMc
	aIsDeopWEaoJnKx2LSJGMa8eDzTx2IWVgtqlbeXbjXw7TFU2TaaAh7DkqO8dALgeWCFufMU1iCB
	7jgJvmo5sMLCA75qimPZ/jvXTudtdjkB17BFRI4wTI8MxdbAoCntRN2wk1aVsviDDgww9dsXdoz
	KCRvzMsuePMF9AXB0IszHqbL1VVSD/dXJUGqv5LYB5S8O3/pksA74qEEw==
X-Google-Smtp-Source: AGHT+IEfSJAKNHpWgZVUf8o+j/Jls/Qpg0S3h5SUv32JXiLjp2fei3IxBHlxD5hh5CStRz/jkhZR5P7q7aYPIS20EDs=
X-Received: by 2002:a17:907:7b8d:b0:b04:3623:a9fc with SMTP id
 a640c23a62f3a-b1bbd3a68ffmr460226666b.30.1758148718744; Wed, 17 Sep 2025
 15:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
 <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com> <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
In-Reply-To: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Sep 2025 00:38:25 +0200
X-Gm-Features: AS18NWA4pOwDUosllJlj4H9gooia92TA6PwJgeXuzaDepx3vHsHzDeL6mCXiLr0
Message-ID: <CAGudoHF8pKE3ODqY-WnbV=ZpjC9hH+U+COq_KE=aH7mEW8fsKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Khazhy Kumykov <khazhy@chromium.org>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:34=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.or=
g> wrote:
>
> On Wed, Sep 17, 2025 at 11:03=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.=
org> wrote:
> >
> > One ordering thing that sticks out to me is
> (ordering can't help here since we'll rapidly be flapping between
> ovflist in use and inactive... right)

a sequence counter around shenanigans will sort it out, but I don't
know if it is worth it and don't really want to investigate myself.

