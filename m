Return-Path: <linux-kernel+bounces-837212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BD8BABB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326A418958BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8322BCF4A;
	Tue, 30 Sep 2025 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH/nK5kk"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3F279DAE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215066; cv=none; b=BXxwRqH3exBabn5+1S502UxRiwsGDLD5Qi7KBMy4X9lGWeMvmU46LOkBJ5GkZPoFcpZtX29I7Xgs1dNZwT5dBwZkYvqflxz4xTk3S6scK+lkAWnOJDjLqvjumKiRaJ8TVRYCw41fFNMaX9GPONSeOoqQUl3CfSMpjfGzXZL2daQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215066; c=relaxed/simple;
	bh=QuKU6InmvBPlK5tmaJn1Vy4p1SVmh7nLnic7bLw69X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sftSwDzaWoMyi0MuG/65qKLZbjpi+0oiGBRit4bczk05v6i23lq8fDDNAOHsZ13i4qZ4auFQciLtt99NJFjOPKLUO/y5c+MJ31KifGmV8xlw/TG18WrwXw6Wxx0JvgxKp8LUEVgemN72/vumkQFaEl2MkkCEy1UHzJ88RrZAQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH/nK5kk; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so11043022a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759215063; x=1759819863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVNXZw775c2Js71zktA/SBezJeedYDwOHGneKmoyTVk=;
        b=BH/nK5kkJl0fLQTSpQndmHR2M9aafs1ahoTaYjaK+cxWwY2+PYr9EFAPxV7XXGySZw
         akhcTATTguDkBB0bdB1PgB4ymDp93MDNM843Qe1C2/A7hSFXXMdzZmP3EMWJhMIBLdHy
         ofUC6+QuKZb/dKvF6J+zre3xAz8gYJkrrkiAK6tAXZD5th0SkTCD9V68JHZilV9QSAnp
         0c1H4oB4mGBshJUbZpiB3ZwTMW9s3Gau+/Ijis7Swq0ihztvL9t/4AYieG2aSKMofXZe
         ClG4qg1+jpEfan+YaEb/X3szRLL7nkKMfTUu2Mrl1/XiA5TmwGGtwsOc1r3KPwZPo8Pe
         RaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215063; x=1759819863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVNXZw775c2Js71zktA/SBezJeedYDwOHGneKmoyTVk=;
        b=OTY/RcNPenqOrBOTC/7U3OiLzA1/WvlEJ9eDxXRh7oj43pcgXrOIHYmZII5FfKC2Vj
         Nz/07SzEWiGm7tfJgsU4XI/UJTiApk2YqRvj1j00cubnSd03Bn5cSD9GaSmjo8PBheeB
         UKiwVaY1+yYKKg0jh+7wtPoZSVOgEPDAtrKQpHSy+glr4qX2zWcPk9tTcThWXnRFe0eX
         wPYylaAxeWU6XZbSH94ddue/d1to3r0l+PDnsWIcJDjulxleqPphPT5qngxwSSTbJapR
         yxoCUW9cVmFc7gcqt62dPM48Gy0vx5bKhIvCQ8xbe05fe1aUncpQfEAkxqqc/lz/Qgly
         7O0A==
X-Forwarded-Encrypted: i=1; AJvYcCXOZLoiUl3wW6mh9rq4zq2JGKnsw5vEkETkUIApYfnaq0H6ZTOIJ/sUg/T54+AYnHtue/mUfiBHwmsQyJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5wYE7zYPzjdjwuwYqMMDdpECI5ljf9jbrEyLNoZ35XXNcPtJ
	+Zgk4uedauHRTlWP2OzAwIqEwNPGmFsBRa1m83QUjdCxJTcjuMHN/zd8k6rD850zlTF+IyPJgZm
	A54UaZN/qxvt+lH8xtMnh360iqdeu4w==
X-Gm-Gg: ASbGnct67I8JtfJeSCbP42mJHhRQ0oHHL8lCu8zTDayMAxRbD4GooTBQu7iZKw5qujl
	7cESQ0Nqbe9/g43B+iTJP0Oa4nS8zoXjWCdIGfRRy4/Ta9ouENcQNiHf0Fh0aqpWdbrgsr17O1X
	QNIY7vinpVaxZuWLeys2ILF4iCeQ4qVAC1FwKQa3JwR8s8gS7GTTA8eMAbJkOoh3Xk849wOw7Qe
	sCH9bNE+9goe3V8TLsdErMDQaUtvg==
X-Google-Smtp-Source: AGHT+IEXSWGf6sD3vo7rf9EQ6i9O9UJK5AOiX0IqobrI8JkX5Gc6scxof3vXuUDm37WJvIfDO2cxBPjjf6V2BYq4PYs=
X-Received: by 2002:a17:907:971b:b0:b3c:a161:684c with SMTP id
 a640c23a62f3a-b3ca1617ce7mr943624266b.2.1759215063208; Mon, 29 Sep 2025
 23:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
In-Reply-To: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
From: yuanli fu <fuyuanli0722@gmail.com>
Date: Tue, 30 Sep 2025 14:50:52 +0800
X-Gm-Features: AS18NWA0IfkM4D9WprNelBpW7fL-eSZ2hdWPleHyjbG7Hx95fmcgy3a8WlR9DDU
Message-ID: <CABbqxmfMLAFT8vMeCz4dXY5RfgZ-65VYXZm+P1-sO_pqKR-sPw@mail.gmail.com>
Subject: Re: [PATCH v2] ntb: Add mutex to make link_event_callback executed linearly.
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon

just a gentle ping on patch, Is there anything else needed from my side?
Thank you!

Best regards,
Yuanli Fu

fuyuanli <fuyuanli0722@gmail.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=80 17:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Since the CPU selected by schedule_work is uncertain, multiple link_event
> callbacks may be executed at same time. For example, after peer's link is
> up, it is down quickly before local link_work completed. If link_cleanup
> is added to the workqueue of another CPU, then link_work and link_cleanup
> may be executed at the same time. So add a mutex to prevent them from bei=
ng
> executed concurrently.
>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> ---
> v2:
> 1) use guard() instead of lock & unlock functions.
>
> v1:
> Link: https://lore.kernel.org/all/aKiBi4ZDlbgzed%2Fz@didi-ThinkCentre-M93=
0t-N000/
> ---
>  drivers/ntb/ntb_transport.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4f775c3e218f..eb875e3db2e3 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -59,6 +59,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> +#include <linux/mutex.h>
>  #include "linux/ntb.h"
>  #include "linux/ntb_transport.h"
>
> @@ -241,6 +242,9 @@ struct ntb_transport_ctx {
>         struct work_struct link_cleanup;
>
>         struct dentry *debugfs_node_dir;
> +
> +       /* Make sure workq of link event be executed serially */
> +       struct mutex link_event_lock;
>  };
>
>  enum {
> @@ -1024,6 +1028,7 @@ static void ntb_transport_link_cleanup_work(struct =
work_struct *work)
>         struct ntb_transport_ctx *nt =3D
>                 container_of(work, struct ntb_transport_ctx, link_cleanup=
);
>
> +       guard(mutex)(&nt->link_event_lock);
>         ntb_transport_link_cleanup(nt);
>  }
>
> @@ -1047,6 +1052,8 @@ static void ntb_transport_link_work(struct work_str=
uct *work)
>         u32 val;
>         int rc =3D 0, i, spad;
>
> +       guard(mutex)(&nt->link_event_lock);
> +
>         /* send the local info, in the opposite order of the way we read =
it */
>
>         if (nt->use_msi) {
> --
> 2.34.1
>

