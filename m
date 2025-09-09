Return-Path: <linux-kernel+bounces-809077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72D5B50836
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4481706F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D24225D6;
	Tue,  9 Sep 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MmZD3hM7"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECB22157F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453556; cv=none; b=CPNa7G+i4xwVLxNRCJM4XPEYJEkmVejXrRn7kI+rf53xr4RQhcVTH1AyNh6jHsVl5RLB6pqgjmuCf5zAOB8xSunuMgxZOi5p7/soNZ9ZzMk23z4FCfSY9VJFIYjGIEfffeyA/w/+cUpQCqRY/l1PpqVkxvzw3bQumWJZjhiWVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453556; c=relaxed/simple;
	bh=asYCnis4mSt6CdqmJGzu+Uw5kUXiEII09UvJhb2qu+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLcjXsye1u8B/eWUTKz6IE9xpJPy9Rk2vGsynQZHXWo+UMWgKQQaLa5pdhDo2s/nQRtz+hyMWWv4SiBSfSKSDR+tlYAu/zwjAnDwrZpkDIh3/H34cZ43Rj89W7PdCloosUvhNgEazvR5pg1pD13cS6WasifRxS2CQkx2p5mj0Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MmZD3hM7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso5287846a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757453554; x=1758058354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asYCnis4mSt6CdqmJGzu+Uw5kUXiEII09UvJhb2qu+8=;
        b=MmZD3hM7QvY841CrjUftBYyB9mXbysv2R531wqu8iH24LaP4HsvpCdpwNeUKZ55Dd6
         WFys/ST4OSFUEQ0DR4vWNsnMU8CZXnv826qNVf/7WgNH9IGIDsdQ+5ul/MwBGRootB9A
         injXW0rv6Mj4jEPEWt6rV6sJbrsuiBffZK5ztdFX9f3bMBwcwimTgo9Fhxl5vnHU+mxr
         9jgtUCaxOFKaKMTJ+5hK3NHNGM0/2neGHzCnzMLKk66ShgpGg1RbXrkBjcSLBjXSyB1k
         2uZiV1b1SAKyw76NJubiiPrPDezSVNs4S1NpPWcKL5wc3VfmRVXCbvbGbdBAGJffXubd
         NMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453554; x=1758058354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asYCnis4mSt6CdqmJGzu+Uw5kUXiEII09UvJhb2qu+8=;
        b=iH9DPhIA0Bsac+ZXA+8u1PbMwY1ayULvKy6UkuiEGMXNq2cgO2OwY3Yd8CEqFdlmZu
         wz01xj0OxQ3Mr8XOMux8CpQik7x43WhdSTt1HjwUMTEYAw59SkLW2gb3vxXZMBO/VlrI
         h5XLlrMAtbtdFBhZewy4WYnv7VvCoaiF0DVLPJHd2xg+MwW8qJ4LPnAjyOITXS6+c3pp
         QZWUbkkHs645rY0ejCG0IR10kyfhOdn+M4I/m6JfQsi0uvmJoRw9fF7Q2KEgtSpb4lS6
         q3cizHLtVV40v/5JE2NQKZwBDpkvH0xXgahSVgNpvStZoH3f1/9GFzDS6byl1xJRatSa
         Lb4g==
X-Forwarded-Encrypted: i=1; AJvYcCUVTa1dsnCOQxGzIo8PtaZHE48NWGMJbhWXcO5/olz8z3xWegXonPSqXuAylyYMAV6LH/Aju3/iw2jgpGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxveE8ndtop07ybLC/rkk8FYTHVfGACRLFh/ymU9W0qjaNSneHh
	CxoBKHgxVondCqsV8r/K++DTzLQqs5oo0Xgx7t4+JqJjGwcP8ZHxbXDui0N1Yj9l11SmPRfl32q
	kWEzLGJ7mzlsiCDp/fLHYlaa+ajvIrcMyI8inz9u4
X-Gm-Gg: ASbGncuruIybnPyBoG7/MuoH5hbhaEWya1UL+oR5DB1Fpt0WiL0GjegR2LSoFkOa3DZ
	sU0diWCVIxRhbbRfJz0t+w2Ck9XMUUc5YB9FE7NG9vrjKBzA1+ulsVTIq5Rf5VhCAMfCWRynlFB
	U4wuTuCDTtbAnLNmkL1i3pnXxlPyxjlgx9cJREurF3uXPoFL0i/qXWSFUoENMIqErrKt2fnbDpy
	Zf7h2Z9XOVMToGQkQ==
X-Google-Smtp-Source: AGHT+IFpFxNo6dxCBm0dGcRZj8ObBT0pFbtG/sSiVCHxphai4thKxc4JU3AVtrF10UeYjdGdH9PqFYTQ3Uv4NlDmlp8=
X-Received: by 2002:a17:90b:1d0b:b0:32b:df0e:9284 with SMTP id
 98e67ed59e1d1-32d43f45856mr17772256a91.10.1757453554206; Tue, 09 Sep 2025
 14:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013419.4186627-1-tweek@google.com> <CAEjxPJ5q0eriGjo1tdfN+pzBBN5OeyfMaYp_sNQcOg-rDaXVCA@mail.gmail.com>
 <CAHC9VhR1pEFYzSFaqqWsU8C6vDaH_E8uZZ5g=KyK6TJvA7a8MQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR1pEFYzSFaqqWsU8C6vDaH_E8uZZ5g=KyK6TJvA7a8MQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Sep 2025 17:32:22 -0400
X-Gm-Features: Ac12FXyL7eL3X_jCKFwoxMjKs2tue0NW6-1wqyMzPYDoAVXjw8OY2Gb7ih30uV4
Message-ID: <CAHC9VhQLZ+mWS77OG6cDddXYfJy+eTqkKSZ28PJNEjLigsNGhg@mail.gmail.com>
Subject: Re: [PATCH v2] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	James Morris <jmorris@namei.org>, Hugh Dickins <hughd@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Considering that we are at -rc5 right now, we only have a few more
> days left in the current dev cycle, I'm going to merge this now (with
> a subject line tweak and some unnecessary vertical whitespace
> removed), and I'll put together a quick little patch to do the
> WARN_ON()/EACCES conversion which you'll see on list shortly ...

The patch can be found at the link below.

https://lore.kernel.org/selinux/20250909213020.343501-2-paul@paul-moore.com=
/

--=20
paul-moore.com

