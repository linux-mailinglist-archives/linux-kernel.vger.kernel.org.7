Return-Path: <linux-kernel+bounces-803985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38FEB4684B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D3F5C0664
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 02:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E91F8908;
	Sat,  6 Sep 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QkqSz0pY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A49189F3B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124795; cv=none; b=ejrQSxkfjI3QYUm1wETjKr3KcL57/rT1dRsQZzQXP2YSw4imJBswUvf8+zPH7XBsC5iH2/I6Rq3OR1NUNGHe63yOWUUZT+l/KTqAqTKilahDg31vU3wWabg3RIIkU1hva5xmE7vhNYhD3X2ix07OWd4U8Wxa3yJI61FBjGqxJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124795; c=relaxed/simple;
	bh=9NrwfOPHgYRLFnDlIWX7EiOvZy0mIg0YZcKwWQhi2P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSz//BRNAhHpBggnX923vhDra3+uKiim8/zQr/sPxuYVKo/qXbemmzYk9ZCqQ7vt2QMkcmxnt5hN5Fmv9uLlIHfErF0rj3WaNyuSckSqAYW9OmIX5/cZLp1XgkT+ItNL7hqMuMUyIZv79Uktm7JtbssI2OzoZchbyubEyM+HBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QkqSz0pY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24456ce0b96so29057595ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 19:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757124793; x=1757729593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1pL8bTYf3cFMEJdozUvsUvrpDNfWNl6DypfSxz8EtE=;
        b=QkqSz0pYUXh3uXy9BExCY9H77/YCH9hyb7PKtbWbPaXSSvmLKLh8OTODHDqd6nr48G
         s4n6cRJG/YWxZ90xGBzPQc+QaFGc5N7C8R0cAOYz2HUGnRAb6WLqTMYxQ2sVHJ78d85k
         oD//AJcoA2LWNFhrv4K3KRoSJthxyCHHSAnP2UxLNsAF7r66ueK4vQjMa8o8+gPVSkkW
         wxlBvbH6p0EV1sNNzu3esI/+0EB0MjxiYCnvj0gBLEDSYFmLHy8Z/W6QeT4oqSL+TZRL
         hiOMT5vEGo/a6CS43UvE2G05f7/HH3TKRAwiblxgMw6SdQAVRZFMQZmnUjTlmUTctiEv
         rBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757124793; x=1757729593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1pL8bTYf3cFMEJdozUvsUvrpDNfWNl6DypfSxz8EtE=;
        b=MbQKpys4IRSUFQnrnjMQivQuSmuP8tkDDUJwqOwHZlrqkvwTnN8zBI+BKsX/tmAI1E
         RJkxlpLsiq1vmj5QeiyI4xLIm0qWv4kITK+2JmMwbVhm+TPz9mLQtltasdszarKX9er/
         P6vmZvfzQrlolTp5RBOPLmf8WywWOs6KobaIWBBcIUiyvogwwyznfQ1zCalKeS0Hzy7B
         OL+ZoKknu1oGhkv+oIn+T73OZRV9TbGK0aFAZtboiRrOAOa8VHXgjlho/9UbORYVHCyc
         ICedXDof7MlXNnP/0K/V85CqXz3++mmgqVlowqGlUmnwIw8gH5FvD/iTBMqK0IjugZki
         sMDw==
X-Forwarded-Encrypted: i=1; AJvYcCUj3uaBmckJLZDuOL318D2anpsEcWlXq4NKCFLVrWcNtvKYpK7pbhP2Zp9rJYTUDAchPhqprWPLXbrswaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuR+2EAUharrQZCkduRTbIm56pUsNlN6QM0vrKV+a5Ebs+Nk8
	+oOu8ufIcA29MigmBJNMz2NM+RGBNKAFlsDDo5eHXUIFlQSc/ZywZsSrkGEBxAF/v8s074W0T7b
	5ef5TyeCV+cOu6Xr1JlilqqYcTjXsNZms46vVAb2C
X-Gm-Gg: ASbGncuKrvhJuWi0g4VN2FGQYTIzYcjYhGCbQKAnGgZQ8eajqyUs/LLhE4dT+10WlOK
	n7dXfoDTyGRPaStJnfRXdmte5F25QkO374+pky3YAV1bieFfKzyije8kIOwPfDd40FA7C0829XI
	X4+AOfP9OjeJrIysuuVQ1lMp8JVIRPPFM7IZDyMESgQCEd411uRqJAoN/0cWUmSEOEhqCem9O3J
	C9yW8zpYH8EgLrwCw==
X-Google-Smtp-Source: AGHT+IEi/myKnyBGcUaz9kKLmPHDx0tAAOxFqlYZaJrAtcZw0dRkAUN9iSOqdhe2KCACDOYK4usfLZF+9IEiHa8olEg=
X-Received: by 2002:a17:902:e885:b0:24e:e3bd:11a6 with SMTP id
 d9443c01a7336-24ee3bd127fmr34267895ad.23.1757124792885; Fri, 05 Sep 2025
 19:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905222656.3692837-1-nkapron@google.com>
In-Reply-To: <20250905222656.3692837-1-nkapron@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Sep 2025 22:13:01 -0400
X-Gm-Features: Ac12FXwqmqbrwtGWFiMzNcuv1t1UFv_o1QgH9SWzK_JphbAkEpScv8DY3Kh96yQ
Message-ID: <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix logic issue with per-file labeling for functionfs
To: Neill Kapron <nkapron@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	kernel-team@android.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:27=E2=80=AFPM Neill Kapron <nkapron@google.com> wr=
ote:
>
> This patch resolves a logic issue with selinux_set_mnt_opts when
> selinux_policycap_functionfs_seclabel is enabled. The issue was
> introduced between v1 and v2 of the original patchset.
>
> Fixes: 1b22454bb5e6 ("selinux: enable per-file labeling for functionfs")
> Signed-off-by: Neill Kapron <nkapron@google.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

With the original patch sitting at the top of the selinux/dev branch,
are you okay if I simply fixup the existing patch by adding the
missing '!'?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 333bb6cba25e..0e47b4bb8d40 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -745,7 +745,7 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>             !strcmp(sb->s_type->name, "pstore") ||
>             !strcmp(sb->s_type->name, "securityfs") ||
>             (selinux_policycap_functionfs_seclabel() &&
> -            strcmp(sb->s_type->name, "functionfs")))
> +            !strcmp(sb->s_type->name, "functionfs")))
>                 sbsec->flags |=3D SE_SBGENFS;
>
>         if (!strcmp(sb->s_type->name, "sysfs") ||
> --
> 2.51.0.355.g5224444f11-goog

--=20
paul-moore.com

