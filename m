Return-Path: <linux-kernel+bounces-730546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A951B0461C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB3D189B131
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE8625B305;
	Mon, 14 Jul 2025 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="DSBtfGHE"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75D3FD4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512885; cv=none; b=tF8QV6FZErS3esmgctQFJHA9WnN5pdQfi8IM89CDyiKhVblg9b4CPxbuqeww6jM+o+YaN38rJ4hRFC6xvt/JNxcZhNF5PGOrVB8GWFNBhsNSI7TAppaW+Zw8mqvbf95of6l0JcrgAOdyRZ/mYkzAUD/jvIvd+44yNOn8Vs4F3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512885; c=relaxed/simple;
	bh=+3v7+b1ehnggXqkm0jzZkQ69aP+I0/5VqF3N3qUtMXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niEan/6V3IDsjimKvKpJGJfMNEIIVTzV5oAwtY8TLeGJvVegSaO6dwz9NVJJShyldjIK9XFccdCy9IPcq3pIF1zgkF/1M/UvtVRtlwgytrfq/QxzL3pb+r/Z5FnK/xETuViZ7gHVqh+Wii578PznVL/5MaHewy2oAGvK+3RDWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=DSBtfGHE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b391ca6146eso4123011a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1752512883; x=1753117683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVJBFfM91k1/QXkeziXOx6LQlH+gT/HrnnZsfkv9bfM=;
        b=DSBtfGHE77hpgkSZazdFmHkVk8sZbKnZruB++xFSZwXImKFEC8ogRdEbgfOIevccIf
         nKe8uC4fQcom/noBSWUn1S9o53jVHNDM7fsDKL5uN7D+fVvR4sxYHJVaJ7qo/9EYz1PX
         fcIrMLpNgJ8TEYtWPTnEQvg6aq/4o6FczdYi8DaNA9J+QsSPOePEcKznSwEE2NUMLADZ
         o2VldNx8swkgUfhiUbztyP9HVZlAeizy8SPPjxeC/aiHlJt5v2nU7pVU0pb0/wn415dt
         ivJplw5mUV0/83fmG+hAll7Ax3/L3Nyj8PnLQPHmuaZG0cIfWi2/BeUhOfm+t/zLqh4Z
         OWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752512883; x=1753117683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVJBFfM91k1/QXkeziXOx6LQlH+gT/HrnnZsfkv9bfM=;
        b=viRMYzhbs600yFGPuByFLvBc4Q1RCw4ELT/NbDrBISLO52nS3xRn2M+jhLCjvdc2zS
         7AlLXWYuNaonXAWWYnp9d+/63WhPwWdRCIgnrAsaxsFVx+L5+KMWbM4sxQx2DzTX+qAJ
         bMLqZhwJHzkWeMCVn1akwgePUnlN5KLRFjHoJqJbtsOebFE6CeqyifP8KPE4x7pa3GYr
         LaSCmEqurBvfTv5Yht/3VYbGIilJbV8JAfjHLU+tVpzkW6MGi35fPHwbB0RVPbBSu8mC
         +O4VO6ddAzHlpZ9BxvO+bfd72SdoDf/L19mdhPm06tvfL0igkVdmiHYqqrOBD6KKxuhd
         IviQ==
X-Gm-Message-State: AOJu0YxcABM4zmY90v5i/JWWVwqkgGUJzLzbgNIwROopy78O03gEsqq9
	05dknZk4pCmYv1tLXgruv0Klz4/HvWQYhrN030r2OsrhrJFfodv/XipC/dLglHQHdDdHCJKvbqi
	uOGsq7n48Qo3dg3IFYFuQbu2/41IpUKGTXkyXAOwJ3A==
X-Gm-Gg: ASbGncv1/MgLS1oNRWdN2kqHNmzAhLaC9jVyiQIIIAbHn73mrqwRA6Qtctr1EisptYS
	Zy4IdK8rz3wJxqjBrWVGKyRHBv1tYkHX13S09PQ2SBRcqfdPV8BjgOSr8qiuaLAvWHfwvF4CFDz
	VO9FB3h9KuAQhonqxkFucVnx62cUvEOYL6+BRs+oYwXHCJQ2m0xyoVPN+5oWjgpz+lI2HdEWaQF
	SBbsxntM8O4rGHsYD+hpok=
X-Google-Smtp-Source: AGHT+IGx50VYJgYPMvySQu3UD+7yIVdha2dQz0zyNz4F6UPV5w1slEAPG/jzrvC4RZBcuK+3VZpYeJyV7lS8G/D0+jg=
X-Received: by 2002:a17:90b:3d86:b0:313:d6ce:6c6e with SMTP id
 98e67ed59e1d1-31c4ca845e2mr21002888a91.8.1752512882930; Mon, 14 Jul 2025
 10:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714143332.264997-1-matt@readmodwrite.com>
In-Reply-To: <20250714143332.264997-1-matt@readmodwrite.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Mon, 14 Jul 2025 18:07:51 +0100
X-Gm-Features: Ac12FXwxpIJKyWvIPbZqG8ygLHQm3L1MqvcOprJASpvHuNJwtyhA39zZyaIk5ho
Message-ID: <CAENh_STUEtz4k9w9106sBha465thGgv5iOpdfneag1nbcEcDsg@mail.gmail.com>
Subject: Re: [PATCH] stackdepot: Make max number of pools boot-time configurable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 3:33=E2=80=AFPM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> From: Matt Fleming <mfleming@cloudflare.com>
>
> We're hitting the WARN in depot_init_pool() about reaching the stack
> depot limit because we have long stacks that don't dedup very well.
>
> Introduce a new start-up parameter to allow users to set the number of
> maximum stack depot pools.
>
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---

Sorry, this is technically a v3 patch (even if it's very different to
v1 and v2) so I should've included a list of changes:

Changes in v3:
 - Switch from build-time to boot-time parameter

Changes in v2:
 - Replace BUILD_BUG_ON with static_assert()
 - Hide STACKDEPOT_MAX_POOLS behind EXPERT

>  .../admin-guide/kernel-parameters.txt         |  5 ++
>  lib/stackdepot.c                              | 55 +++++++++++++++++--
>  2 files changed, 56 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b5cb36148554..6a6d60de4530 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6542,6 +6542,11 @@
>                         consumed by the stack hash table. By default this=
 is set
>                         to false.
>
> +       stack_depot_max_pools=3D [KNL,EARLY]
> +                       Specify the maximum number of pools to use for st=
oring
> +                       stack traces. Pools are allocated on-demand up to=
 this
> +                       limit. Default value is 8191 pools.
> +

The default value is usually 8192 pools unless you're on arm64 with
64K pages in which case it's 8191. If this discrepancy is too
confusing I'm fine just deleting this final sentence from the help
text.

