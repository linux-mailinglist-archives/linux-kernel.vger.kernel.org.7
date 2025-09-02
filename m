Return-Path: <linux-kernel+bounces-797207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C701B40D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584B3480164
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56CA2E54B0;
	Tue,  2 Sep 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UFfOsrgF"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F52E2F0E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839044; cv=none; b=E+R+L2jykFQypWB8IazIP40MuAhpTYOiCpXlHYEW7SbNxS6VNrCAHBhyXZ8MB9oZ/De7GaaaxEHXmlpsfeHYwhc5H06a0t4VPjdYOZ438AhHBRvX9xNkS+vKoZd/vM3429PF2z2/0UguVZudNQ0y/cimQImfFkXs1cTWXp/ET1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839044; c=relaxed/simple;
	bh=yGe249309p31JQAq7oNVPdCjAq71xkE0CgF8CrWKt0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrF+r/7KHEnGIth8G3a5z/UG+/RAudiSNc5mgYxORBip3mSKd9U+P9fILkRp9H9almls9k3xi7NPmOkkZNQu2otNqUjXYwxs41Rp96dOfE0Tjd8Ny1c/UVwz8tZKUnQcoq4idy+qzKl02PhJajW/CeOhA8P1zx2GGsndwVtUFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UFfOsrgF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24a9ccbf10dso29008985ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756839042; x=1757443842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3HHMEjcFRdUbHCUuFrXz8U6hwslDMN4EkZx8GP3P/Y=;
        b=UFfOsrgFPX5LSl9pDMy+kSa6bQwH0vL01qscNsiNaFFUPofrVU/GGlVP3xjmfmppzD
         b2FvnBZYH00mwFhMIi90ayB+yJCMexZzhUvxaY7eo64NImujny6tDqStHkhO6BAxVOBH
         S8YQA3vNYH8ZotN0WqJuQTb/DbGR5IBfm6XXmL1wCmftTDV/f57TpvCyThjoWTmVN335
         tlVGNa7mUllQ9kPXHzJdPauDDrKqVK0pmeGubauguCwyL4MpVbd673WSrp1FtNEOOUuc
         IzOjTEnAYWOfyWYXmeOr6Hpm1rThCJ385/uEkK/5EGyGkMyTRxCUYEqOA6sRQ+xWFcno
         bLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756839042; x=1757443842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3HHMEjcFRdUbHCUuFrXz8U6hwslDMN4EkZx8GP3P/Y=;
        b=uxH5PG3zFcO+rLNS6fWvYluqo6m6vr1qbOR9IW18qaNrI/h3njKqYzYdLbgkrw/tca
         COnnWTKGAOGjL0Q9I4nPunuEAW6hAyR4rX5qyGBZF8ZVS3Bqj+rbbklmLmKgtjaSGmBb
         pKJbWBtBAHbxe+9QEjFvFxCdvrwvE35SfL5R51AJNB7BgAM3W4/crt6KLxABnDk0Dimn
         hlZPYNM4tMNEESNMCimy4aTqCuaNmtCE9L7kscpWEdSoL7zoof0RHJic7LVHavdWAAUX
         /zG0mtQ/5zd/wyBF6/VgARv0AY3znJ9JeKmLr4PpWdD0gI8BvEFejYjHjTiiA5M6pg6L
         zsvA==
X-Forwarded-Encrypted: i=1; AJvYcCVwei7RodiCb4lwE6btV3Hd4XuK5DHCGm7poO0aFHJDuDqGtnc1ATpLywbpTzK+r3do01Di6IR98dhXNXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0aqqUSVhJX87YdR8ivgEznHl/TPr5UrOQ2LZRKGdDCRUnFZ4
	4WYTGrsAYHyaeEMnV/aoGnI42E58HluRigSBHDKeOe3ssa99/vPNnX6SZy33fiDPR7cjdhHMn3y
	C5UN6UODM38pJKu3YqFgB1sW3MwuTcikKVQfGFCQrdTI/ldjOlSeFOw==
X-Gm-Gg: ASbGnctWRU6iS8EnaKfXj7eiYk2D+34xiHWmmowLvq7Uh/3sfqAyYsJ2bvmoYP09Dka
	LEEgyprEZqWSHILtScszJ/65FVIKpdxtgVRQgzbFxsGB3ICWnf17XYvzY6ohpPUUJbzUdv5SoFD
	l9NhjldkE4s2sq2cjp2neR10zqfdY2TYivMfQeVzTSQu0z6T5f8sxnDbq/pAnNWF42NBbi0B94N
	xP+YOTgtv1eJt7LMg==
X-Google-Smtp-Source: AGHT+IEboz/X48lMtkkWhW7IBH9j9AuVYruPq6zQU867OYgOwE79Bz6lqMJ16wDxMHHP0BdnDkuOI6Q3V16c43Vh1kI=
X-Received: by 2002:a17:903:28d:b0:249:2c40:51b2 with SMTP id
 d9443c01a7336-24944b8143dmr166068905ad.59.1756839041892; Tue, 02 Sep 2025
 11:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902110049.4437-1-disclosure@aisle.com>
In-Reply-To: <20250902110049.4437-1-disclosure@aisle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Sep 2025 14:50:30 -0400
X-Gm-Features: Ac12FXzq1KopE_SQ-WserLu3QL1ICR9nlutL__PngqoTgqDQiO57U5xsmg8bcKk
Message-ID: <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
Subject: Re: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: audit@vger.kernel.org, torvalds@linuxfoundation.org, eparis@redhat.com, 
	security@kernel.org, linux-kernel@vger.kernel.org, 
	Stanislav Fort <disclosure@aisle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:00=E2=80=AFAM Stanislav Fort <stanislav.fort@aisle=
.com> wrote:
>
> When a watch on dir=3D/ is combined with an fsnotify event for a
> single-character name directly under / (e.g., creating /a), an
> out-of-bounds read can occur in audit_compare_dname_path().
>
> The helper parent_len() returns 1 for "/". In audit_compare_dname_path(),
> when parentlen equals the full path length (1), the code sets p =3D path =
+ 1
> and pathlen =3D 1 - 1 =3D 0. The subsequent loop then dereferences
> p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds read.
>
> Fix this by adding a pathlen > 0 check to the while loop condition
> to prevent the out-of-bounds access.
>
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> ---
>  kernel/auditfilter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Stanislav.  It looks like this problem was likely introduced in
e92eebb0d611 ("audit: fix suffixed '/' filename matching"), I'll add a
'Fixes:' and a stable tag.

I'm building a test kernel right now to test things, but did you
verify that the path matching fixed in e92eebb0d611 still works
correctly?

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index e3f42018ed46..f7708fe2c457 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1326,7 +1326,7 @@ int audit_compare_dname_path(const struct qstr *dna=
me, const char *path, int par
>
>         /* handle trailing slashes */
>         pathlen -=3D parentlen;
> -       while (p[pathlen - 1] =3D=3D '/')
> +       while (pathlen > 0 && p[pathlen - 1] =3D=3D '/')
>                 pathlen--;
>
>         if (pathlen !=3D dlen)
> --
> 2.39.3 (Apple Git-146)

--=20
paul-moore.com

