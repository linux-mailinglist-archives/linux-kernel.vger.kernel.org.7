Return-Path: <linux-kernel+bounces-840322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF38BB41C5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8C054E2BC2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D5311C16;
	Thu,  2 Oct 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdoIxESf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AF2D5928
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413476; cv=none; b=HQ3mqJ6xn9JPr8CgpxAB3peCHFUmu2nFOfsexSEfnMtZNIHqj/8ZRxt00i6daG5SRYVvLtC4UjjRek+Iagt1WAECMyOR8ujxiRarPATAx55E172pg8tNf8Hc5Ri9r76hHM//ltjiOyrLT67N+9LZTHT/HbhRUgCZMHN0TbcH/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413476; c=relaxed/simple;
	bh=6DM/v7zBqHZDejrXhT4fhDydMxHb7EGAC17MErEzbYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9rX6kldG//6PA9gFWsQH46NdrzCybeKw0Hp73kQ7CZg3OBtgsYVl+ik1mfoNG8eO/rCLm2RTikphTmmaiM8hwjvLa38W41JQbjMa3aEcFbvwasxaH9ENOe4KGaN/wIfsmFrGajXZmUVcpl6OwWJHUYRTmMsyjxPnGeV19g1RjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdoIxESf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DD0C4CEF4
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759413476;
	bh=6DM/v7zBqHZDejrXhT4fhDydMxHb7EGAC17MErEzbYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sdoIxESftpzFX82DkY3Q5L94hB+RvZXL9tFrq4l4yum5ZdbKQJmqksAab+t/jz8Km
	 qM0f8z5wUBRGgeFMSO+IC9K/PtuCeuVU/vHMtclmwGB0AokTXHI+YSrJhrd6tcVHR1
	 MTaXa90XWY0xHOVUvYtP+HTHs3HhVVuKX/YjlzODZXcY8eFQDWbxVXR9NOhxsGzPiA
	 DTU3DXou++lxxh/q8UfhAoIR3lCPB2xxvkAHdfUpqqxF8SECX0HR9Y9TPPiWqFqjtS
	 pqmkpP/1ZefAbEF3aLKeyJCe9c+t01qoljOyGBNMjfLz9Pum3pTmACoVZxxBL2p0Fx
	 9sMjUOEmZa17Q==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b463f986f80so239818666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:57:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOTFkKj+sm31JO2YLgYJriVztSIYAYBX4q9vc+CjHPRJ1qYk+fyhAQxBzcbdCSzuhAxODJZ2kRwhfwSgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh3pb2ZFP/LT4Z2+mHgB5U29885Jfo/TuHoK1fxGJFS3K1hL5n
	5y5fUtV/4+05hQOUyaiuSSoAXY+MYypcMbsqfMxnjiRP1KxD0PtdZDEV4s3/lBvDyb8emLSgymE
	j8Fp8RjBq4x1A7fNDCpQnJQ1n+yj90UM=
X-Google-Smtp-Source: AGHT+IFpPcu+8WPIowVSm0xtREio4oymHriCWMeEoT2/Lo1HL26FJFAcmDaESWnI90VwixvGK2ddfdFd83JZVmckog0=
X-Received: by 2002:a17:907:c0d:b0:b3a:a16e:3db8 with SMTP id
 a640c23a62f3a-b46e30ebaf3mr1023741166b.20.1759413474862; Thu, 02 Oct 2025
 06:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f956b3b-853b-4150-b2e0-ccd430adf9ac@web.de> <a9518620-29cf-4994-a9f4-a6f862d8c214@samba.org>
In-Reply-To: <a9518620-29cf-4994-a9f4-a6f862d8c214@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 2 Oct 2025 22:57:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd__1cYsi9m9J-4jbpk33Ha4xrY-amS-==SXdsOmtZ6GsQ@mail.gmail.com>
X-Gm-Features: AS18NWAGHd_o3xBMWyt0Jto5x8E-wKle9CokrbAOY8OokdFpaTquzWzjqJILkQU
Message-ID: <CAKYAXd__1cYsi9m9J-4jbpk33Ha4xrY-amS-==SXdsOmtZ6GsQ@mail.gmail.com>
Subject: Re: [PATCH] smb: server: Use common error handling code in smb_direct_rdma_xmit()
To: Stefan Metzmacher <metze@samba.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-cifs@vger.kernel.org, 
	Hyunchul Lee <hyc.lee@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 9:31=E2=80=AFPM Stefan Metzmacher <metze@samba.org> =
wrote:
>
> Hi Markus,
>
> > Add two jump targets so that a bit of exception handling can be better
> > reused at the end of this function implementation.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>
> Reviewed-by: Stefan Metzmacher <metze@samba.org>
>
> I'll add this to my for-6.19/fs-smb branch and rebase on top
> of it as this function will move to another file there.
>
> Namjae, Steve: this can also be pushed to 6.18 if you want.
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Steve, Please add this patch to #ksmbd-for-next.
Thanks.
>
> Thanks!
> metze
>

