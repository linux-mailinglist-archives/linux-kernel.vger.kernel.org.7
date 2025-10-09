Return-Path: <linux-kernel+bounces-846833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16961BC9290
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DB019E81E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4AD2E2F13;
	Thu,  9 Oct 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSrqB3rC"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020161339A4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014907; cv=none; b=D+RTJ5N3OJCwphnDN+trsCU+URRmOtrfeZooGjz7ieC4bA9MjZHiQuNzNbFi7CTgZQbWkAe3ZL/zVQcaHS9lhMELQWNVOuo3apntX7qfGfA1oT3DukwO1btz80Mm/zM/+Bsoumb81gYIMo7zRvBqBYOQofuEYV8hgwHziypFrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014907; c=relaxed/simple;
	bh=Gs47qKyjjCbUeDk5wi2/Q6Ba91DMd60WfEY1F85BEAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ai71Az22211RLpFuRRByEgxoAOJD3p4GX7f748F+zs3DrD7kPh7GBsEmiu4ncu779vRqKy5rKhe8abTFLsbzQvWliTHxPcme716B9YJIflJn24hcrDIYCwdAg3pev8UCHxQQnz76en3hTmTc/hWbTdAZQeTyTgmHwJMiUl9ynyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSrqB3rC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso773894a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760014905; x=1760619705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcgGyufeWrwbNvU76gdgcnETjaPRCIETyHV991hM71k=;
        b=bSrqB3rCEnP8PsQUegBgfVVmHsiLaCuvDfV15AkZEaP/yCojaX6oE3kDqO1aoh2rVw
         kHcok5YYKxEqwIR8yJkLZlKfO/cKn0XMbB3YCx0bpY2SwZXgOd4vYhw3TSDGysjW8slz
         dl4rNGYXdL4qhF/hmZPMnXH+7i/xozM8MqemOwrtna3GY2gOjlqlobm4g/2rk9JtKXTv
         Z1wMckwYZx1mULsXIHlFR0WRaxxEnLAUz6N14vwLiQVPlvUilLWhQPEZgSgiqBOX+FbW
         7ge8N8iOQrZwo4+TdqTAI0jY7rpgWsfw5lx+kLBxbqtnzPzOwzW2ebwp2Zqtl/d/YdDQ
         ISSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760014905; x=1760619705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcgGyufeWrwbNvU76gdgcnETjaPRCIETyHV991hM71k=;
        b=wZ7wkSIcTyAWfvPUuzVE4x/d2+uaNSnvWJouzcsbvZR+dj/dINZCTAk0qGOl8ApF6D
         9+yoO7Ld+Hb5eXkjNYvhJAKFJdjcZo8oratjnNhuwxYVmgc7j6paZsBtT3aj5nrJ5ijE
         Cd0hN7AX2snsjVFx6wc/Mxk6ji91ZDdJBwoUvnyy2BiDzcHAE0hp8pp4sh6wsB8G3Pqb
         aNdCG729LKyVwBh+QekS2QJNhzzl2EFYlXVidCnGCxVvIbYTzIdcMoEYjE7COWttL8n1
         chUEkbZulf12QTcFaYUAmR6lg1Bh1Uxa9OnbNf+ZFzYaZbrElXVlU4AS7UqguDH/z3AH
         geyA==
X-Forwarded-Encrypted: i=1; AJvYcCWcbs5dIEn75daQvljotMZa0oH3UyTOnzySBJFQP4rFWUtDp9Vtig7ljIn72SBz6vR0Y0nrmDx0EO40KDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+0vJfZOAECw7TB5FDltQh6uyxsnC5J1vvtoiqDu4q89T2D50
	nNX6a85zVlvKNOKPAi6l9FJapl1LMeQpX+rCxsMlPsWvYzpSnlm1Rww4JQjQvVJk9uAqQJDUnIb
	L8A7ureUZpZc0gqc+Z6IjN8FhsOhiAME=
X-Gm-Gg: ASbGncvd86YouZ+j4KizqkrkfXd6+zhrKlNveKKZ0iCKQvhvrvjBqWrs7vSnz9bksyc
	veAsD8MhgifFiT9JQuBauWHcmZLJczH746KixWCp9TlY3wMR1+bJ6tAVcdFVLAwgsolaOChMwz1
	O2ZowJaBwA4DUgSZLBEeF/Wy8QQlHJQDlLG61YV5eI5cB4yXYb1EOAhau6NLr07HPHTcGuaZOkb
	GhhArcPMCM7B4g+W0kjp/xpn6KrZttgdI9zZgv2LQ==
X-Google-Smtp-Source: AGHT+IGYLUuOBqqW0GFGNDMWTwHGx99IL3xPXeKehrsNaPNEIwJoQjw5SqCX43PuDYbkab8vCV+1w3CcEjSwf8x0pa0=
X-Received: by 2002:a17:903:3848:b0:272:a900:c42e with SMTP id
 d9443c01a7336-290273ef069mr91199775ad.35.1760014905030; Thu, 09 Oct 2025
 06:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806094855.268799-1-max.kellermann@ionos.com>
 <20250806094855.268799-4-max.kellermann@ionos.com> <CAOi1vP_m5ovLLxpzyexq0vhVV8JPXAYcbzUqrQmn7jZkdhfmNA@mail.gmail.com>
 <CAKPOu+8a7yswmSQppossXDnLVzgg0Xd-cESMbJniCWnnMJYttQ@mail.gmail.com>
In-Reply-To: <CAKPOu+8a7yswmSQppossXDnLVzgg0Xd-cESMbJniCWnnMJYttQ@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 9 Oct 2025 15:01:31 +0200
X-Gm-Features: AS18NWDgVXdJzaBexOMeDAOr15F2R2gpSg5qJuQMSqlDa3Ke0Sh3XNjKn1-fGxQ
Message-ID: <CAOi1vP-FVKUUvQQT7=EuHij9uerqRvdrTQegMch4_JYQp64Qvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] net/ceph/messenger: add empty check to ceph_con_get_out_msg()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 1:47=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Thu, Oct 9, 2025 at 1:18=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> =
wrote:
> > I made a change to net/ceph/messenger_v1.c hunks of this patch to
> > follow what is done for msgr2 where ceph_con_get_out_msg() is called
> > outside of the prepare helper and the new message is passed in.
> > prepare_write_message() doesn't need to return a bool anymore.
>
> But ... why?
> Your change is not bad, but I don't believe it belongs in this patch,
> because it is out of this patch's scope. It would have been a good
> follow-up patch.

Changing a function to return a bool only to immediately undo that
change in a follow-up patch (both touching the same 10-15 lines of
code) seemed like pointless churn to me.

>
> There are lots of unnecessary (and sometimes confusing) differences
> between the v1 and v2 messengers, but unifying these is out of the
> scope of my patch. All my patch does is remove visibility of a
> messenger.c implementation detail from the v1/v2 specializations.

ceph_con_get_out_msg() is a common helper and given that this series
changed its signature and how it's supposed to be used, I wouldn't say
that adjusting the specializations to do the same thing with it is out
of scope.  This isn't unifying some completely unrelated aspect of v1
vs v2 and the resulting patch actually ended up being smaller.

Thanks,

                Ilya

