Return-Path: <linux-kernel+bounces-856722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA3FBE4E87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179DC3AD79E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02B21D00A;
	Thu, 16 Oct 2025 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLL4DEZo"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7EF3346AD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636613; cv=none; b=ZNMOOk+cuVboj7/2E7u+FRFFqhrGczeJhu5FKqz8Wkn0rXlbyswhe9jc958pdRYzclRsKLzAm+ZUKFlFiCSASbTArY3oeh/1JUqYtuwAsAsC5Np17kFsQcspRCyg4cfKf80+pGXdJpfVW1BQhqF6q0A67eMnCSsQzh1KxsaEnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636613; c=relaxed/simple;
	bh=yBBjQVRyGblUjJODwrzaNyhah7wFRahcUtCeq/hWuM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lc200pzk5xzWbMz/nlLGj/NAEehGAmL/KAokBN0SAltoExt9FFYI+1nd24jaA1bF4qer9NFe0K1ed5I6C5ZgzAyWL74hscefULf5MHJaq51HO7mTiGT1hMKOTS65kuTi4NYvbOByC19ZFSmUHpDaGlqd9dWY36DPUQez7h5PbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLL4DEZo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so845360a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760636609; x=1761241409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omNt6d8G4KEFJy/lysclxxeLewMXvTfHJErLzzHnePM=;
        b=hLL4DEZonAIdP186lM9em9bV2Q6vnsdqFqARNZkQGoYdqLQXqRl1n7ccgAmIUDOUhH
         bNN1gzHRmHu3zHpD15Iwwv5t3J9l8jiTVbaCnGjIcl5EhsTSuL3mEix054IAQlLcFVHL
         u1hJM3C2Z8kAzNyZEl46VyV8pCuXXWA/GSovCD73oUcpR3PM75qaGowyMcRAqLNSmvNc
         KthXhqhxuzRzrOnG6OyD6EaFdD5p63a1UADSt3n3jDkOoy/kaVmalxasmhEqQHBqhURI
         Xe16lHretoKy1iso5hXe7l4IfkGO/55w8XNoDzkUE+/f/+dCoWzb98r7dDRZJ0QZ1aX1
         xGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760636609; x=1761241409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omNt6d8G4KEFJy/lysclxxeLewMXvTfHJErLzzHnePM=;
        b=VPpD/tAvkpgsqLhf+fYx+qL5UpX/92e2zT6zESS3bY2AyvrF/KIJAU6MW49AIuWGfR
         +7TmQwbw7i3VAXSU95LEMOU5t/gz+HxTEWg57tawAmL7Ijqr39n86VHWYqpq1JaYqgC2
         aji4viALhx2dwsFlIrA/B3gKB5g04CHTrEl/EJeVS2PTFOXOSyqINRybtTzCzH55X7jS
         9433cFtjDnRwACu4uYgWLax8HrkCDuysy3/IhI3bUl5oUa1AO6+SmhHix0iAWv0ZnKQq
         mKSyRPInS+iuTFASf/aSATO5AqPirEWGoSqsJ4rGR9UcPnxg0jcJO7RLpa1OqXLLSd+1
         fDdw==
X-Forwarded-Encrypted: i=1; AJvYcCXnWDhO+icKQ4Ge4n+2ckdV9mT7GrDP1Yt9BCFzOS5LTPc4NUkJYkw4eB653S8KvYubMdEAXmDYoxFoASM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEaE1dWXqzpWe+WTIy6PP3oCBOkmd55se8Lcg09XvAmrXyqRg
	BxXvQnOarE8zxOMYd1XIiEkpN5VdZ8y1c2zJCWclvVY0rfAqQDzEmWyH
X-Gm-Gg: ASbGncsxCb19JNIIHTh7tbHNH6OJC9ov0XvUgyRh0eS948r7g9zlaU0Xe129gfQQf1+
	r/FtdJmqeScZl9Bxz3UV1w4SwcJv0Vaiimro3Fes7A+wM+E4SatS0TkFZuy20/On+rS7tRI2nlA
	eWSc6N9hZ1fex/I9TGJOIBW6fMAKhFpC5/T7DhoHXncvQy5uVKEZv4AG6sliVOZOIkB9gSM4H9N
	GX5X2qmeUgG1lZ9VEq4DsnELdLc+F7+vysGwhvylBE+FRcaQkCfZsIVN1jtxUq/ehOduSuEVL1N
	/4upvMDj/81biJhfp2mCtpuIVI3GPzmN3FDdUz4VfChfE/9z3gFEUn39H15p41CPqREI2ME+fzF
	yHrexGShw6noBZFINOuZgxqwEC0P/HkVdAwKD9N5Q0Np6sVCcM1WG7h9mMdGnn5q1Y+hziSyzbU
	4GdI6Jm5hUvO/Jo0urR0Qlvm1Cfn2S4aUpUN0=
X-Google-Smtp-Source: AGHT+IGE8LmA05+md2R/UN6tUvS8+B6jdz7Y5VdgdosEbxeqfOb/EMnNS2Gq5uXQSuTA+IxzhVS86g==
X-Received: by 2002:a05:6a20:914b:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-334a8534446mr1041614637.2.1760636609463;
        Thu, 16 Oct 2025 10:43:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fe4f:64d:d8b0:33de? ([2620:10d:c090:500::5:b51f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09d6easm23099242b3a.51.2025.10.16.10.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:43:29 -0700 (PDT)
Message-ID: <69d2c22ed0cac19a2fc13d422597d781281e4625.camel@gmail.com>
Subject: Re: [PATCH bpf 1/1] bpf: liveness: Handle ERR_PTR from
 get_outer_instance() in propagate_to_outer_instance()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list	
 <linux-kernel@vger.kernel.org>
Date: Thu, 16 Oct 2025 10:43:27 -0700
In-Reply-To: <20251016101343.325924-2-shardulsb08@gmail.com>
References: <20251016101343.325924-1-shardulsb08@gmail.com>
	 <20251016101343.325924-2-shardulsb08@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 15:43 +0530, Shardul Bankar wrote:
> propagate_to_outer_instance() calls get_outer_instance() and then uses th=
e
> returned pointer to reset/commit stack write marks. When get_outer_instan=
ce()
> fails (e.g., __lookup_instance() returns -ENOMEM), it may return an ERR_P=
TR.
> Without a check, the code dereferences this error pointer.
>=20
> Protect the call with IS_ERR() and propagate the error.
>=20
> Fixes: b3698c356ad9 ("bpf: callchain sensitive stack liveness tracking
> using CFG")
> Reported-by: kernel-patches-review-bot (https://github.com/kernel-patches=
/bpf/pull/10006#issuecomment-3409419240)
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
> ---

This was brought up already in [1].  This is not a bug as check before
propagate_to_outer_instance() call in update_instance() guarantees
that outer instance exists.

We can land this change to avoid confusion, but the fixes tag is
unnecessary.

[1] https://lore.kernel.org/bpf/8430f47f73d8d55a698e85341ece81955355c1fd.ca=
mel@gmail.com/


>  kernel/bpf/liveness.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 3c611aba7f52..ae31f9ee4994 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -522,6 +522,8 @@ static int propagate_to_outer_instance(struct bpf_ver=
ifier_env *env,
> =20
>  	this_subprog_start =3D callchain_subprog_start(callchain);
>  	outer_instance =3D get_outer_instance(env, instance);
> +	if (IS_ERR(outer_instance))
> +		return PTR_ERR(outer_instance);
>  	callsite =3D callchain->callsites[callchain->curframe - 1];
> =20
>  	reset_stack_write_marks(env, outer_instance, callsite);

