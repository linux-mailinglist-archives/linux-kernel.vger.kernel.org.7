Return-Path: <linux-kernel+bounces-861377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8BDBF2943
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B5D44E79CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3B33033F;
	Mon, 20 Oct 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIW234R9"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C85330B2C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979611; cv=none; b=EdNah7hSYq74kp+E8lwQMxuctNJjtRnnHUl5ITpmggkceAOXgCR89hrtRS0IDPY0siO32Qu2XRk99heO7l7T4hYL2U76jwJya2D35+Zne5c4XX9+Lj435wuXyLqtY6dVJwMA2OmuVGwIJTmlDInXh2wggfR1AXIxFibzqS+wt4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979611; c=relaxed/simple;
	bh=EXc0jOYLRmr/3jRYSk2fLCR4EdRJhtPN83IRY/bFlt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo59KmH6SGisLljwhfWM9F4Gis+1CoRqKXDAnk0Sk/UAjWj8XC+pHuNsRsqEYMoyzbEvtnGHSFwHkwsMgtQ1ojPAWto3a3AvnXKZaPpd9sQEy6LxvcUKIGGyms+p5Qy3UYnZHZKW3B8OhVBdfPatS10PKM+qCtFq8K3ATMgyYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIW234R9; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-81efcad9c90so84393516d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760979607; x=1761584407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RSN4YFTB3br2+B3ySD6exiSoPsxEwCTC80by1DxrCk=;
        b=QIW234R9WrrlKJk2HVXisGbrYjBI/eH9cDZ6nuGqUJb351Dw9HZMBHEWsS0MhTrkRk
         yl87JgGgm6rlD/1yygbS30JSKHQ/6z07pgw/4HxYa4TfOwXcgSS4qqVZO7F33j3IFG9b
         b0p22vkt/1RGvQt4WwxJI80tKU9I0tQhTUVyAsvc5IazWbvRl4LqkJZCyeakz5DwLzg0
         j8RncyqIdyh5eUWp04kAy1pV71aDeGRTVHw5gZxfXeWNAuk+GsL0OhCu4gylJtZfXNlI
         ty4l/DrsXepycl2SgRP8hC2kIqc86eYHioc79PuPoy5csO+El7od88krnQtlRk+lc3Ba
         bqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979607; x=1761584407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RSN4YFTB3br2+B3ySD6exiSoPsxEwCTC80by1DxrCk=;
        b=PUc7SuPS69zEQPhWDM2gwmvErEq29jcNvHjvg+9zzZ7o3fipCm3Gebb5iARF8iFTXj
         x9VyW9/hAn7/g6hs11RdIqaKUNfpPjb55a9pqWCNEK1gzYCxPPFFpU9xDsYweQmxm7C6
         EXlMlSbXj8zIpICiEHPUtz+UvOQIYGRKNgl8PtR492//MyJvGo4NHvGhrRTfAl4+R+E/
         yxKv+7xu8NAl3QXdYnxJPaBUTSyp3QDNmzY97yPCMtRt/8tZt1/Vc/J56Tm72/gUsgK+
         Cy9aW8XdDY+UNYUfb+PrAC5gnGPUDtbfuNPZEjeyRBAXZ1DTD81/ZlFO4dmz9YpNCAoQ
         9oJw==
X-Forwarded-Encrypted: i=1; AJvYcCW7cBOFJQzPvXJq8SUloAKyp0XA2vBTPVLS0c1i9HakvTmlKrD3Kw2y1es8mtJJOav0zrEHKm7b1AXpQM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgaWpNnJXcJcXG7FLTboQhL88kB+6ow7CtGfZVpMiMvpOYSgqL
	tcPkVO0qTbf/Y97KN8w5PxjwX6yHZattXxyZn19COwfqlhxi/y/KQx25uCI1fkqnWRFTCR5Km2c
	kLKHmHSYKjBoJ1LwRy+bzuTalzeoQqUkHeRDE
X-Gm-Gg: ASbGncvobmDY8P+wPR/Wa/gh2XkFZ0FPq00bLB23sN8SG61VLflnP8Z8E8LJ0O/rJ9j
	g26NY/h2+5MZc2HAVhwfsiR+Cgxwi785DANLxxOV8fMO1T1nZL+QjZ6YFDXCJ9gH8Akc7OtJZKI
	pnDfXcW3IXgh0rwVDp41EjeTx1ArHCj4VsP2gZTutM66tu1aFk+jSa9aM1TjDLxHV8sQ9VzS9g/
	ICINsho7W0WPxBxDYGAC+OLNwo7y7E5RCWhCVpYipJWTUwP5v6J+XhyvvRvuDpNxmIZWAYHn50t
	T3Gr/dy4uFpzbaFqGbS9s/bi+xcK734LJbB5aFi4UfCvnPEmFMeFHHhulOqdRlZlfDL/MYjn6ZK
	HtKoVUvEmsWY/in4B3Mcfx0OrCQwsx2BX64eSar+1zABwiXYqbx0DovhZ5ptjIrdf3CC55Soo31
	g=
X-Google-Smtp-Source: AGHT+IFHQ5iz8/Saro2LRp+bwSIlhkAJVCK9/l8+MswododraUp4Qz/LXmzQtrn4f2pjW8VxdwrV1XzKCjcqyAUk8lg=
X-Received: by 2002:ad4:5cea:0:b0:86b:4ffa:a8b2 with SMTP id
 6a1803df08f44-87c20576935mr170951986d6.22.1760979607465; Mon, 20 Oct 2025
 10:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1039410.1760951767@warthog.procyon.org.uk>
In-Reply-To: <1039410.1760951767@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 20 Oct 2025 11:59:56 -0500
X-Gm-Features: AS18NWB_wm78_JKAnPCw2RD98jnwlVQ7_i0H__VeQ2TBjimWfb0DUiLikj1O_Qg
Message-ID: <CAH2r5mtLDTExHRhbr3yyK1Jm1Azq8PyN_TkWsf3gyEWVhybrnw@mail.gmail.com>
Subject: Re: [PATCH] cifs: #include cifsglob.h before trace.h to allow structs
 in tracepoints
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do you have patches in process that will depend on this?

On Mon, Oct 20, 2025 at 4:16=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
>
> Make cifs #include cifsglob.h in advance of #including trace.h so that th=
e
> structures defined in cifsglob.h can be accessed directly by the cifs
> tracepoints rather than the callers having to manually pass in the bits a=
nd
> pieces.
>
> This should allow the tracepoints to be made more efficient to use as wel=
l
> as easier to read in the code.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/cifsproto.h |    1 +
>  fs/smb/client/trace.c     |    1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index 07dc4d766192..4ef6459de564 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -9,6 +9,7 @@
>  #define _CIFSPROTO_H
>  #include <linux/nls.h>
>  #include <linux/ctype.h>
> +#include "cifsglob.h"
>  #include "trace.h"
>  #ifdef CONFIG_CIFS_DFS_UPCALL
>  #include "dfs_cache.h"
> diff --git a/fs/smb/client/trace.c b/fs/smb/client/trace.c
> index 465483787193..16b0e719731f 100644
> --- a/fs/smb/client/trace.c
> +++ b/fs/smb/client/trace.c
> @@ -4,5 +4,6 @@
>   *
>   *   Author(s): Steve French <stfrench@microsoft.com>
>   */
> +#include "cifsglob.h"
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
>
>


--=20
Thanks,

Steve

