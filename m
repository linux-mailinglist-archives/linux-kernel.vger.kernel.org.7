Return-Path: <linux-kernel+bounces-724543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF1AFF418
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3731189618D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E6F24500A;
	Wed,  9 Jul 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M+Vjkmar"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33D23F27B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097457; cv=none; b=iBVGUbZy81TP3Kr7uSw6e7a09Q6u3WcyEOxrmTZJqqeC9uIpfiNyLuYDJzaQYHv0llFeiAdj3o3thZBQpn3MjxBeX1yuecqRIYuPBjPcifHqaBBWuJeDe6eCT6OqWj9xg4cdKci6Vevzc8xwVpYNRQsnsBjFvKLyRZxR5iBxye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097457; c=relaxed/simple;
	bh=QM3ZwKzZ3tmooQKRsyzdW8dMI+e0bgrGReSxQbsBbz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhxf74pud0eo8E+W1LTwvAqhKAf+NVi3iKyR9aUidPGr5o2V6nnbRqS9DVvWLxoGhBYTY/zA21OUSfoLHlfT2rpSUymHJCQgF7O3zTht5bjD98gS3MsQwVsh/k9PmXlaBUXEClD4QeTUnm2l+FopTYgg1ytRrZTXK/tjG3sHSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M+Vjkmar; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae36e88a5daso50505166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752097453; x=1752702253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=M+Vjkmar2DZR01VBbGidpjLsj5WkhccV4HkYK/+hg7utLrEMINgnjypBRimA/63N9Z
         yYsj7DHfmQMKO1QAv71VK0sNBQkM9peUJhNd+uT1+KdZik4D91/04Eja8bsYuFfp0NYO
         FQ3oMpJJIDemPPNuxCCNSfbuS55si7hddv+RnXQA0b+5DhFQB8Z7rNyJQXBnKOOuK4Rl
         95Iib0HNh/m9cbmeeGI8t7IUpxYr+cfY+DNwK7eo7gUezPshoSEvsBIeAy7Pg6vTmmhV
         h3t0qqhwOB/bMwwUqNpEiS29wNroRRQR/3a4uP4NUgAMh9KoBsErPHFfXlzrhjWBnwHO
         DNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097453; x=1752702253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=HdsoYJGX0wHiX9Vu4fUHlmMX5n/ROLoNx1wWJPfhUqGC3cfYl7YInpL6Tnxx0pMWap
         0/9ts0zWA3m/Uu115fijO4y9VewulUUGec4jdFkyWHyPeZ7EP/mnAPNU9WU1uTORwHrw
         EuzuHVpAVFfFHJ7PMPDNNvenaBB3XXdtuSjIHPEdY3GOgzzskwctQa53a44zPz94Uad8
         IcJDKHDQr8/Pd4MEwewdeRtnxwJ90eIfTyDzG/cuoBtOmrWkk7pga5TSGzLUZWZX94vE
         LtFpiQWqLtEIDAvNnxydlxNpP5WPkA1RxBV3keiZNzU0r3QkPEwcFWV7qRzSc6CfY8NP
         gubQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQRmFma9z5NElh237jkpRmOM4k3DZgjUh8fwRdWa18iNLazfheRxuxqea79Pg7vkaDKKD5GehHF5t/U2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycg8QN6ji6t3TTjUQoVhkZWKxzvoUg2vDKsPUmhRe9HSlGbvgU
	6g6JvO1H7Le31o5/iE/VtYvphPcyMR1roFG13pqIjPLcAuStOOExdxIMWoAHTnn4lpjMx0VdBdk
	eF/qUAcUmgJ3fFW6iV55eczyLVYNzmvr8D2I4wTJYrA==
X-Gm-Gg: ASbGncvEzOtew6aysz7Hf8OldlKSlU9ltjqyysRSvsta3K3E7yOt8rPwA3cFFQeAy/a
	eGEHgFJOJdUGolUa9f3CeA2GyWiQulcAACxMMliyzp8RZcAdX6VjpvX3Rr6OjPKN9DKmifmzD4+
	UW3flVHK5ejF/0kJ6UPdZzUIkzWwcKxJ9T3c0gYrOEfuOp2K0DyJ7UEvWz7QE+LP4M2WhQyh8=
X-Google-Smtp-Source: AGHT+IHRfBgI+JpvIFW5bdEhu8EMbBsinsmaICn0S2xVCrLK7zPglEC6AbVpvLywHBFg/8fSMjerPI4gbWHSZhnMN/4=
X-Received: by 2002:a17:906:46d9:b0:ae3:d1fe:f953 with SMTP id
 a640c23a62f3a-ae6e7099e16mr25848366b.43.1752097453229; Wed, 09 Jul 2025
 14:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
 <2738562.1752092552@warthog.procyon.org.uk>
In-Reply-To: <2738562.1752092552@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 23:44:02 +0200
X-Gm-Features: Ac12FXwGyOaYIBhD6kJLi5Rdp0KMSI4jWTqWW8bY_UVcRj5P-WQCdanG6BjA4Q0
Message-ID: <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 10:22=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> > (The above was 6.15.5 plus all patches in this PR.)
>
> Can you check that, please?  If you have patch 12 applied, then the flags
> should be renumbered and there shouldn't be a NETFS_RREQ_ flag with 13, b=
ut
> f=3D80002020 would seem to have 0x2000 (ie. bit 13) set in it.

Oh, I was slightly wrong, I merged only 12 patches, omitting the
renumbering patch because it had conflicts with my branch, and it was
only a cosmetic change, not relevant for the bug. Sorry for the
confusion!

