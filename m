Return-Path: <linux-kernel+bounces-759733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD8B1E1C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1CA7232AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744F1E2823;
	Fri,  8 Aug 2025 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNl6mHim"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9D10A3E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631472; cv=none; b=oKfwH3uqVSIYD5JHIy1UIwLRPNxOLxZtg3ab/ZKXXAQ3nYFyWAfR4hW1h4RJQ2tUUXT3bsWFJvGWnwDsNrwea8TJ2U1+Qq44kTnZjftDJxMO4X0P7gElqmt010q9QKDechUwy1My4H4sW5ex8l4Bcua+sy/SOvTlYYJHEMaHLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631472; c=relaxed/simple;
	bh=MTG/yXquvpUMTpSFYjEebXeUnb1zsi7nkFuTCHPVJSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkBSMNCzYrNL6husqZBdpvXBvSGESBG1JcOkcoxyvOGnjODqu6ds0uZwPVK47Xb+GtGRy2bw64ZEde5cqiCYfXNdP2P6aQoYuCi2yPlRasiykPmghr6W4ngxkRmGaqyZfUz9LeUqI5MbziRmWw/ltJtDOedfEnvUrZS0lAhllLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNl6mHim; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b77dece52eso36840f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 22:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754631469; x=1755236269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzN4MoggtOmzsOzNgRPBqPhMD4mrevOZONgYLvGdZVw=;
        b=KNl6mHimkR00kDd/0/gPp/NCA/GBfElGEEX7qqybuqF159wvA6LG2dcwlq92KGiu/X
         v4u5ECNHMkgTr64RbIgOFuToR8sGE7uZPv+UzcPWaRRkm6bwDGO69D342DRk8YEXU6Dn
         5I6VRQDYzQgj95E+JQzSWFdkX0cLiwA85Anl6hk9wRrB9QSRzkJ0n74HU9BjVPuIFNjE
         uAUGPXlFU2HZGeVmaTJMBqnzYVAbVXTv6dtruFmxrbobricfaUBILn2DFfhps2C6WH5+
         lH8LL8WlmVuk26jq5rCAS7hMaTyrIYZB3uNAbYOFtdCNNJ3PimCC3UMiNAnZzgxJNXoE
         CjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631469; x=1755236269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzN4MoggtOmzsOzNgRPBqPhMD4mrevOZONgYLvGdZVw=;
        b=KwAOwWZJcH7aWENsFftbVcumpIGJ0zPCiH8gwea8MtINebYD6gmS0TEUnrXrie5xKG
         v+4jLh6cEprd7WYWnFI4kP9rZxHZZcNKGeNEBfjHk48vkIq7Mu+4C6L9gS3wZnCpPGHR
         BIOet9dQQjRpnv0vDb8ELmxd5Okz/eGcjNNIE79jfThNBYm0jvKsqCFpch4Qo4PsxSo2
         13DwBtcsf/pQ675dzRamJboEpncvwBGByqJ2XG7cT/Z0/P8nRg/IGLKGB6Hbzb38qTVs
         R6sbaE0O4ysfO1ThZdXETvI82JhT5CEHjwLpv7xj4/UJf5TBvdCZzqp15TCs0UzpXFda
         goQg==
X-Forwarded-Encrypted: i=1; AJvYcCWXE+VRxUjC4m6yyZOwPC+p5NnV9Zxru0nQZ4mBjDtnUtz1V9yI4j1vWQQAqKaz78kRY46S1qh4mzut1pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4/0WhBYX2NjHLyrUBDxe8TdVs0MYfYrLHQpxybgtytZbq0H2
	zdE5hW45Fe5TGKr80mfHW5Aplkjh6HnHuwJI7WmKqje1TX8/5DS2+tqugFO7O8gGx95NF3jzfXB
	m8QhCtVK38MmPSbLiz/45s4LHp3pOf53e0AwS
X-Gm-Gg: ASbGncvvp2aczvj2CfgeTzadqVYaTzIczUNQXIZXvfeZSxQsU/wdq3WT0VhUzEHyCst
	UfNycu/gv4/cR6wzrLDUtVbMIEgo1gLl3rjyjA9JRbSrQvoMti6KyLoa7+8JD1QtWoNfCLiDwMV
	DwHilc6uCv6KyDW7P4+B3Ib6CCeR3BeIK/bEQ66SgfVabWmhoPWbXENvXETeJVg3Mi3O4CLRlVj
	ZRy/tWN
X-Google-Smtp-Source: AGHT+IFNjZl3lvP80wU26/7c7t5y/zunPh8F4UzbGKLRT2BnYPfyXNLnEyEVJMX2eO1B9GMhJRNCt5QybfrqFLqUwro=
X-Received: by 2002:a05:6000:2313:b0:3b8:d7c8:ad88 with SMTP id
 ffacd0b85a97d-3b900b355afmr517174f8f.7.1754631468871; Thu, 07 Aug 2025
 22:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014836.3780988-1-chao@kernel.org> <CAHJ8P3Krr4pCdOmnSJ6mp5bfGLLH4TJqd0FC7Qiw2V3iEL5VEw@mail.gmail.com>
 <b8470c47-4fc2-48da-b93d-cb469638fb43@kernel.org>
In-Reply-To: <b8470c47-4fc2-48da-b93d-cb469638fb43@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 8 Aug 2025 13:37:37 +0800
X-Gm-Features: Ac12FXyO1t35YLRLfg-zoCYVRhywM-dIpKaua5hGLDGX21JmQ7uEm96uhdsbhck
Message-ID: <CAHJ8P3KPzV9bcu4aYBrgxO-5=5p9xg-KwbYQw9o6SzSe4Za1iw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to clear unusable_cap for checkpoint=enable
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=888=E6=97=A5=E5=91=
=A8=E4=BA=94 12:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On 8/8/2025 9:07 AM, Zhiguo Niu wrote:
> > Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> > =E4=BA=8E2025=E5=B9=B48=E6=9C=887=E6=97=A5=E5=91=A8=E5=9B=9B 09:52=E5=
=86=99=E9=81=93=EF=BC=9A
> >>
> >> mount -t f2fs -o checkpoint=3Ddisable:10% /dev/vdb /mnt/f2fs/
> >> mount -t f2fs -o remount,checkpoint=3Denable /dev/vdb /mnt/f2fs/
> >>
> >> kernel log:
> >> F2FS-fs (vdb): Adjust unusable cap for checkpoint=3Ddisable =3D 204440=
 / 10%
> >>
> >> If we has assigned checkpoint=3Denable mount option, unusable_cap{,_pe=
rc}
> >> parameters of checkpoint=3Ddisable should be reset, then calculation a=
nd
> >> log print could be avoid in adjust_unusable_cap_perc().
> >>
> >> Fixes: 1ae18f71cb52 ("f2fs: fix checkpoint=3Ddisable:%u%%")
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>   fs/f2fs/super.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index f37004780ce0..c1f45df9efec 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -1014,6 +1014,10 @@ static int f2fs_parse_param(struct fs_context *=
fc, struct fs_parameter *param)
> >>                          ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOIN=
T);
> >>                          break;
> >>                  case Opt_checkpoint_enable:
> >> +                       F2FS_CTX_INFO(ctx).unusable_cap_perc =3D 0;
> >> +                       ctx->spec_mask |=3D F2FS_SPEC_checkpoint_disab=
le_cap_perc;
> >> +                       F2FS_CTX_INFO(ctx).unusable_cap =3D 0;
> >> +                       ctx->spec_mask |=3D F2FS_SPEC_checkpoint_disab=
le_cap;
> > Hi Chao,
> > when enable checkpoint, shoud it be:
> > ctx->spec_mask &=3D ~F2FS_SPEC_checkpoint_disable_cap_perc;
> > ctx->spec_mask &=3D ~F2FS_SPEC_checkpoint_disable_cap;
> > please correct me if I misunderstanding.
>
> Zhiguo,
>
> IMO, F2FS_SPEC_checkpoint_disable_cap_perc or F2FS_SPEC_checkpoint_disabl=
e_cap
> flags can be added to ctx->spec_mask to indicate ctx.unusable_cap_perc or
> ctx.unusable_cap has been updated, then we can store last parameter value=
 from
> ctx to sbi in f2fs_apply_options() as below:
>
>         if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap)
>                 F2FS_OPTION(sbi).unusable_cap =3D F2FS_CTX_INFO(ctx).unus=
able_cap;
>         if (ctx->spec_mask & F2FS_SPEC_checkpoint_disable_cap_perc)
>                 F2FS_OPTION(sbi).unusable_cap_perc =3D
>                                         F2FS_CTX_INFO(ctx).unusable_cap_p=
erc;
>
> Or am I missing something here?
Hi Chao,

Ah,  yes you are right=EF=BC=81
There's something wrong with my thinking.
thank you for your explanation, sorry for the disturbance.
thanks!
>
> Thanks,
>
> > thanks!
> >>                          ctx_clear_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPO=
INT);
> >>                          break;
> >>                  default:
> >> --
> >> 2.49.0
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>

