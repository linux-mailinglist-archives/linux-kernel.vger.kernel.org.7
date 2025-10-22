Return-Path: <linux-kernel+bounces-866017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E091BFE9BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4D23A22EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8EB29ACF7;
	Wed, 22 Oct 2025 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fX1+yfrr"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9832727F8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177107; cv=none; b=HhxmD49KZj0CZCNqKGKf6x50W/Py456nQGE6GKS9J+l17XaK9KbbYDcpSO9ALhWzaG2v1nzghMvDdY2gCKIWxrHK9mls4+DXMsTKb2cv6pWzL2E4xNMoDFYH14XC5IEz9egi4b40KKeXV6mUTajApbjKymNMsfuO5IK9+Va5Bj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177107; c=relaxed/simple;
	bh=0HnkBz48QvJZzXednXl+94MDFURz3HXUwL6Q/CTRJCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKq/9eKB1OZE2jL/qeCCnQxv48yMz2v4N/Jv4DcZcBAHljx6GAxn4y9LZgEO6AkKBb9BLJXY8Ubul4vKvR9XNcZnG0XEkxzCaK3iQgGHYsp+b+1bQjjNZyfnyeZsYXmEXTkDyaRorcLamDKcQVRdlLDZ3z0I2RZupv7zOuzkjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fX1+yfrr; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so197127a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761177105; x=1761781905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRk9MlmPKR5HFU5QEYjXFuCzewos+jdNvVe4ZWQ9TcU=;
        b=fX1+yfrrIG19BcExMWdFZCbJLhg1IpzrMhxd5QLLqenfCbyIyyj6eKTvtifobjT4dE
         5HnqUFvfR0OOfbr1nJUcCO5nj/GKXjQVYpHi969xh5TR97yeMZxbHqQWgICLelyKoeuI
         RLeX2bXhsoqXbuekIvP6o6i5Fi0vKbj7Vs/dVHcpWTqOSaLzgBcv0ULaQSpoXx1WIclB
         Li67y08h0ihW+VeG48uJ+D3BHoJu6rIktcK/Ft9faDh88Nu/wwiKtOR1P4RLtJcl2LsF
         +FQ8qK7QRg617vtCww4HhV2/L8nRCULt0gdu439BUNpVE/W6f5JlX8xamRVTLWf5icTh
         Wy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177105; x=1761781905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRk9MlmPKR5HFU5QEYjXFuCzewos+jdNvVe4ZWQ9TcU=;
        b=k+ZEi2cZOEhdtBD/g9tclSUCA+B544aHzUCZ0IJ4RjJiKC8Jh9J3IHrk3rpHEMCwRJ
         826GzWPe9EHA+REWTE+CF2HIb88LDFzKPO70lKaaHqipdBJ7foZadPdsOaRyf2DX0e3X
         o86anIlEg2Tthf6RdLUh8Qw2QJuQkua9J2WOFIuVu8kmM2v8lmc2uMIaKIBMZ+kIpGyz
         1+7YNoMRWQEY2+tvyHi0MgQTgMX0/IkKhlIGreHGDJT+qtWbwoXV92bqeRJgNDXxLEz2
         zrPhZTcftSauk4wSmMbRzoXs6oq7SQlvDBTPTXKeNe/N/gOFVL8DcVgaeiwk3asEsZbC
         FQSA==
X-Forwarded-Encrypted: i=1; AJvYcCV8zmQClaBdM/qgmpaD3uKYwfErphT6X3+CGzsJPX5kWhO8Fza2KczjZ2rqKmm5IGOcmNZmIahF2Q/tXFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDyQ2WtRtZKcBYhANI4f+WQAPvcb71CUWp1PtIbuCNIh9EfmI
	IzACAdnKs6YHMZql4F1Ka6uuJ6FsyWEnQtwZB/Fy3AMpIgHmzSEC+a5Tbk/U/HODg1htFO6pNiH
	QPhq+K4Deboo8SZCdl5A1k5V08DsyGVGDSDeuDMbw
X-Gm-Gg: ASbGnctId9b23rdX99oaxz5T7DtgipzJgPx4rqGw1H8uCLp7PGckf1hRnI6gvV1zXS2
	VtfIobUhvCcTofieR7nd6ycYJvM4nXHb4eTelBFCV5fqiIh2pKrRkLx2E7m8ias+6tY3rZSeNdg
	kYXojcDIDE2Ospn2L6sNo3f5dR1eUfkXJFMDf0h8oXVgaKT+MKihJPU9fO0VVE2wbymHEWDS/KV
	zW9e2k1V7+By9iekkxOfnkaHqA7GKH2QBFSEHJAW4qW8PQM5qvQN8PSHKWO
X-Google-Smtp-Source: AGHT+IEwlMaQOl9puL9H3j4RVRiWWH8p4tkZvmQ7L6tcM6YoBaILSohUr8q3A9r3E/tgEkjIQ2tQrqckVMxJhDQ8xwo=
X-Received: by 2002:a17:90b:4a81:b0:32e:ddbc:9bd6 with SMTP id
 98e67ed59e1d1-33bcf8f9431mr26817603a91.27.1761177104952; Wed, 22 Oct 2025
 16:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022123644.1560744-1-rrobaina@redhat.com>
In-Reply-To: <20251022123644.1560744-1-rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Oct 2025 19:51:33 -0400
X-Gm-Features: AS18NWCjjxJDVXK6gy0ArW4uTuZrZUzZEn5H76dSeZUzjVGBghkWg95D0azSWLM
Message-ID: <CAHC9VhR1PJQKZgLX98HMkmswQ9XvDtic6jFuqxSssY9_qcdwaw@mail.gmail.com>
Subject: Re: [PATCH v2] audit: merge loops in __audit_inode_child()
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> Whenever there's audit context, __audit_inode_child() gets called
> numerous times, which can lead to high latency in scenarios that
> create too many sysfs/debugfs entries at once, for instance, upon
> device_add_disk() invocation.
>
>    # uname -r
>    6.17.0-rc3+
>
>    # auditctl -a always,exit -F path=3D/tmp -k foo
>    # time insmod loop max_loop=3D1000
>    real 0m42.753s
>    user 0m0.000s
>    sys  0m42.494s
>
>    # perf record -a insmod loop max_loop=3D1000
>    # perf report --stdio |grep __audit_inode_child
>    37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child
>
> __audit_inode_child() searches for both the parent and the child
> in two different loops that iterate over the same list. This
> process can be optimized by merging these into a single loop,
> without changing the function behavior or affecting the code's
> readability.
>
> This patch merges the two loops that walk through the list
> context->names_list into a single loop. This optimization resulted
> in around 54% performance enhancement for the benchmark.
>
>    # uname -r
>    6.17.0-rc3+-enhanced
>
>    # auditctl -a always,exit -F path=3D/tmp -k foo
>    # time insmod loop max_loop=3D1000
>    real 0m19.388s
>    user 0m0.000s
>    sys  0m19.149s

I couldn't help but notice that these numbers look *exactly* the same
as the v1 patch numbers ... ;)

Assuming the rest of the patch looks okay (I suspect it will), there
is no need to re-spin the patch, but if there are different numbers
you want me to use I can update the commit description when I merge
the patch.

> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)

--=20
paul-moore.com

