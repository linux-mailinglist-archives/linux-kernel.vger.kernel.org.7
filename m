Return-Path: <linux-kernel+bounces-621161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECFAA9D510
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 00:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912AF9A0E61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 22:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30A9227E8C;
	Fri, 25 Apr 2025 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ai5HHIQL"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039F18FDD5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618806; cv=none; b=o46BEUVlewpF74axbDm4eqgLp+k3JRpNNgeDgfGN8bv2lUG3RhlNT+R8t2WCxpgR7bK7+fIrJQdnmdfc/bbruWcgyTVD4ao/3LbLspA/O+NIM/PWMoSSKYJ2KqQdyvI6Cx2LHxdSKHF0CbRzsEj1aXj3RBsNrEawDHx51saokjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618806; c=relaxed/simple;
	bh=0h/2i4OzM19JYCfbYUcC9+9+VlKqvq7nRs+TkBqKhNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESzslv/FoTJssIh+O4hon+Dw8Ave2b8Ol6gDO2NefFN9tImjWwd5NOU0CbSpKbdIws2DNL595qX+K9TN1a8j/kH5z0Nao1TIxHMh7rlJ61hrjbanlS0OL1lyJUT617RCfRDsVR+XtiwT2jl8dyaJCSoexdpO+r2nGH0DbObP2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ai5HHIQL; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e731a56e111so924354276.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745618803; x=1746223603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3484a7HUy8+Qi6eFFzszN0/To9Anoe0IsOVqEqn88k=;
        b=ai5HHIQLLNJe7fChb+a4DJ1Qfnd3ABjMD6bLwvwIJsC1C2ibpFmK1BFK8utZpBhdiR
         w3nFU/rkJV8lbAHYVp0f8bBEW+QPUnG26pWbDSwbuaZTsT2MZv/93cfezemMwDJ4AyyW
         YAdKNhXlq6KBQm6dWzULiBm+XUr4LYZOKifTI4I27KvU/8hzfH32suAVeLc50AOQmNfJ
         XBSmbckeI/57FIwqE+o+CCDjUvGK4CyTYQxayG5Ccg0HsYMn1Jxfro+50PttG8CNcJQm
         H4Jex1d19YnpMvJo5odNAZBP9DjAnQezr3xgz8tX7SoyTwr3iyjD4lX73IF/WeV6H094
         +CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618803; x=1746223603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3484a7HUy8+Qi6eFFzszN0/To9Anoe0IsOVqEqn88k=;
        b=dWs4w6BwlohX80iykPNidy7VlBHrx3HnGyMukJ4wqpn+/vX4q1zZ3V5jU2qOc7/mzG
         bPx2zOwiZya+LY/JcZqY3HdKroJ72UTTg+Wy6t+90I2ynbTRPVVFQywL4n7ZOA1hRo7V
         xhutYRnUqvIQwYWzJZgzCF2AbsmHiI7iQD+28uBmCS8aFZzV8myw4/6lZoOi4IkQIJco
         JifU7Akwfc4m1/J76TIBBJ2gwe6jC7UTXrpo+uIeyfTjtQsSoCLdHooqbpJszopoGTHc
         neZnbqcKUWWiYiQtYaWPoIjHFiG2rHicRv+/etDe26AroH+4PIN5A97fcg6vTXkDuRQf
         aFGg==
X-Forwarded-Encrypted: i=1; AJvYcCVkoTN5BqS7Yrv286ZUukXLgiiA10kGHr2beX+kiziY9b1shGaupaek62bElday+/ruoUC3BuQWPkXNn00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFq6Zoo0FX3NWYoTS2xuax5yzFNW9Vq2553xwa3dTJ/1Z8M6jn
	KMkYU+xC4N4SrZkLA5ukBtAiAMmcItlcoFp+rwQVhKVREKJtgI1mUNLtZ2rjgfstl+Y73wFgQMw
	BiVHQKUPsFBAWbHiZx6tiIYZH5lbHXvizg031
X-Gm-Gg: ASbGnctX+2uoCp3aq+/+PlLsDo3UwwVgalO+c9CaKxr4ojTFxoODQtQ2TTAmsVZ1lKW
	OjnehaO74VQktQ2lGljzukGHhwYM8O4iBULIPEuzLTiBmYZ2BNqVOY5yMKs1o10qZENO6dPEeEK
	uFKVX75+AMV7ybchrDKgokvTPGlius+nAj
X-Google-Smtp-Source: AGHT+IH4mlwNihe4zO4T0ISKnFerJ+kqwwxfHtAwiiRO+VtTs4cZFAE2OA4qlsnuSB1fNAjF5bE4+/7auYaqQWC6UHA=
X-Received: by 2002:a05:6902:1b0c:b0:e5b:4482:a4f7 with SMTP id
 3f1490d57ef6-e73165c3ea0mr5639493276.12.1745618803254; Fri, 25 Apr 2025
 15:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425092548.6828-1-alexjlzheng@tencent.com>
In-Reply-To: <20250425092548.6828-1-alexjlzheng@tencent.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Apr 2025 18:06:32 -0400
X-Gm-Features: ATxdqUHy0h51ahu4iy47IiYhlwJHLNTHB1P-CJEUi3_yYn351KlJrCu1jR5Arcc
Message-ID: <CAHC9VhROjCvwaEJ1-Vc9SQU-x3wmZjeFknxkFGJcpPL28fGm1w@mail.gmail.com>
Subject: Re: [PATCH] securityfs: fix missing of d_delete() in securityfs_remove()
To: alexjlzheng@gmail.com
Cc: jmorris@namei.org, serge@hallyn.com, greg@kroah.com, chrisw@osdl.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Zheng <alexjlzheng@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:25=E2=80=AFAM <alexjlzheng@gmail.com> wrote:
>
> From: Jinliang Zheng <alexjlzheng@tencent.com>
>
> Consider the following module code:
>
>   static struct dentry *dentry;
>
>   static int __init securityfs_test_init(void)
>   {
>           dentry =3D securityfs_create_dir("standon", NULL);
>           return PTR_ERR(dentry);
>   }
>
>   static void __exit securityfs_test_exit(void)
>   {
>           securityfs_remove(dentry);
>   }
>
>   module_init(securityfs_test_init);
>   module_exit(securityfs_test_exit);
>
> and then:
>
>   insmod /path/to/thismodule
>   cd /sys/kernel/security/standon     <- we hold 'standon'
>   rmmod thismodule                    <- 'standon' don't go away
>   insmod /path/to/thismodule          <- Failed: File exists!

A quick procedural note, and you may have gotten an email about this
from the stable kernel folks already, you generally shouldn't add the
stable alias to your emails directly.  You may want to look at the
kernel docs on the stable kernel if you haven't already:

* https://docs.kernel.org/process/stable-kernel-rules.html

Beyond that, we don't currently support dynamically loading or
unloading LSMs so the immediate response to the reproducer above is
"don't do that, we don't support it" :)  However, if you see a similar
problem with a LSM properly registered with the running kernel please
let us know.

> Fix this by adding d_delete() in securityfs_remove().
>
> Fixes: b67dbf9d4c198 ("[PATCH] add securityfs for all LSMs to use")
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> Cc: <stable@vger.kernel.org>
> ---
>  security/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/inode.c b/security/inode.c
> index da3ab44c8e57..d99baf26350a 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
>                         simple_rmdir(dir, dentry);
>                 else
>                         simple_unlink(dir, dentry);
> +               d_delete(dentry);
>                 dput(dentry);
>         }
>         inode_unlock(dir);
> --
> 2.49.0

--=20
paul-moore.com

