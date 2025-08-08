Return-Path: <linux-kernel+bounces-759611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448ECB1E015
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291FA18C424B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A72199BC;
	Fri,  8 Aug 2025 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnl57YMr"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C72E36E0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754615280; cv=none; b=EdTd+EOyHxvCmh4ptcEKCxEc9cgP/2D5a6/TNi9sOMHpsy6FVG8EbhZwL5ux8Gu56wROf0u+05czwyvZYWUB0opoxGYsZMYDQLVwyY1erC7ubDq11mnZ4yKYb20jJQRx1gaqwkSvwGXin7RyqP9LEFTGJF3km2HHsLIXoH1aO3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754615280; c=relaxed/simple;
	bh=2aVBDYbfIZLYlSENnlX5p/F6TejocqQIUWwQpE0tFUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEpUpKS50BzfW+iQtLRYvL5zuf5pgfrULzzDdwqzaEVpIK49mCej/UdyJBMfGxTs6jFYQBfHIIAQzw9IcM9Q4HGEvPVcw+2yEgCYETwHBp/oXRspK1uDMB0SW3Jy7RSqiwX40+jR3ROinYalPVhAZtgLeevmzEUhmnseS0VpdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnl57YMr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459ea4f40afso3035645e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 18:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754615277; x=1755220077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3eQ7rVkDjHljPJGyTGwqVmjvof0apAgtM+Mb2oIdIs=;
        b=gnl57YMr2fTdU1QrDNxBdAKgZ5ridFG/GS3TKGdS4mUfbUxiSS8ZXHYO6O3k01/rtl
         +DW9S3qyykkn0ck/Tg5LmQzi6P53CKIMd/wT+yM+h7Wsu8P42afOxffrBRqaeEDL+ZUH
         PwydDVryRJrnXJIYvx/vB4MUtPviMCxQ+1KOEbn2CC6uW2YiJ722YhMmXa36FEqYoBlV
         RoG+0EjUrT4gbEyFAaUbzJBVlrZ53UdLKPf0ucAkp8fyMrv4CljEw3vIZBYHBcvdFPgl
         E8U4xtY9wznRM3yDcDThdYTfCnW7TcqM8uITWecOF460/v4YCs3yyCNYTwXm54bfAKpt
         WsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754615277; x=1755220077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3eQ7rVkDjHljPJGyTGwqVmjvof0apAgtM+Mb2oIdIs=;
        b=S63CnhlAqZVOCBjuO3u7YYKAHg+s9ItX2Nqks8LJRLfFP5PiB0wOPzu9eCervQ/4qI
         qnjp2utfJcAbk0TdPB6lTSI4K9VGXZMCtyjfPe+G4PFkDl+fVM1DjsHf9Am6tLAZZaAe
         75VyaaELu1kX/e/1EUtrg6vz+JbxeVSYt/rSpJk+VL0PpMkiN7yxBW38ZiYZ6nh9A14s
         /Rfa9NnweAX6K8ChShrSZBTy3iNorqije7yKMef25L/oSrpBtPCP62UlXByFrqSyQd9q
         KKK9FjmIFGObhIhRz2Uh0ASRG1TS2WMfEkrMhLswJi/2LvmUIMEVBR6RBvUxl0vAiHbb
         ZOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQXO5xrnGmG7GbtsKBj7UslJw+lW8u81Qnky1YgfbLyc2AbP3RfXnIO4oNOWVAbioxN9d79BfX8FPgbfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSYqMxd0QPFAAyb3p0lKj+iWlC3wagw8Y4XEXR/MjXkeHsqXE
	o05fTepITXMdQw2heM90xs5lIYCcuMOrVKzc5YU/Msbk+afw1RbdeUu+dfVQs3ABqJAqZ6G8C6z
	im+3thwSMKQBIe1zg4IeQu/i93++Dy5c=
X-Gm-Gg: ASbGncukIAKm9Nte/4VDgGLXUUEv28CtZ8bmJ+GLK1QPjm3YKvlyyIpTkLM+m7Z8prR
	p6PmAn0X5BeyVy/i3MeLiXKaUBlPFbdk8GRhL7/AQJ8I/6V7XQ8W5nOtKvrGr6acW9tEmvDl8mq
	MCNtZCXFwPc80EsEYD48fvlVesThcBdJUAjpnzTRhrj85SC/cumoron1ddkjydkRaGQ5nVg6oYk
	aEqALBf
X-Google-Smtp-Source: AGHT+IEZocG28lsVdx4WmXyb8tMnkkxxVJIR13Bp4wAasTNkMfgb79wuAfbCl8kCP05s9O0uN7IxhvfR8GcWLKSyR0I=
X-Received: by 2002:a05:600c:358a:b0:459:d7c4:9e28 with SMTP id
 5b1f17b1804b1-459f4c50c3amr2943505e9.0.1754615276953; Thu, 07 Aug 2025
 18:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014836.3780988-1-chao@kernel.org>
In-Reply-To: <20250807014836.3780988-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 8 Aug 2025 09:07:44 +0800
X-Gm-Features: Ac12FXwzxFsdSooevGSbA__Aw8caF8T_m6NgFpnzo_IiqTmxx2FEXioaWPMDkfA
Message-ID: <CAHJ8P3Krr4pCdOmnSJ6mp5bfGLLH4TJqd0FC7Qiw2V3iEL5VEw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to clear unusable_cap for checkpoint=enable
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B48=E6=9C=887=E6=97=A5=E5=91=A8=E5=9B=9B 09:52=E5=86=99=
=E9=81=93=EF=BC=9A
>
> mount -t f2fs -o checkpoint=3Ddisable:10% /dev/vdb /mnt/f2fs/
> mount -t f2fs -o remount,checkpoint=3Denable /dev/vdb /mnt/f2fs/
>
> kernel log:
> F2FS-fs (vdb): Adjust unusable cap for checkpoint=3Ddisable =3D 204440 / =
10%
>
> If we has assigned checkpoint=3Denable mount option, unusable_cap{,_perc}
> parameters of checkpoint=3Ddisable should be reset, then calculation and
> log print could be avoid in adjust_unusable_cap_perc().
>
> Fixes: 1ae18f71cb52 ("f2fs: fix checkpoint=3Ddisable:%u%%")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/super.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f37004780ce0..c1f45df9efec 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1014,6 +1014,10 @@ static int f2fs_parse_param(struct fs_context *fc,=
 struct fs_parameter *param)
>                         ctx_set_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT);
>                         break;
>                 case Opt_checkpoint_enable:
> +                       F2FS_CTX_INFO(ctx).unusable_cap_perc =3D 0;
> +                       ctx->spec_mask |=3D F2FS_SPEC_checkpoint_disable_=
cap_perc;
> +                       F2FS_CTX_INFO(ctx).unusable_cap =3D 0;
> +                       ctx->spec_mask |=3D F2FS_SPEC_checkpoint_disable_=
cap;
Hi Chao,
when enable checkpoint, shoud it be:
ctx->spec_mask &=3D ~F2FS_SPEC_checkpoint_disable_cap_perc;
ctx->spec_mask &=3D ~F2FS_SPEC_checkpoint_disable_cap;
please correct me if I misunderstanding.
thanks!
>                         ctx_clear_opt(ctx, F2FS_MOUNT_DISABLE_CHECKPOINT)=
;
>                         break;
>                 default:
> --
> 2.49.0
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

