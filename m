Return-Path: <linux-kernel+bounces-728936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEDCB02F39
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6932E3BEB33
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0ED1D7E37;
	Sun, 13 Jul 2025 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0eG0vZ/"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C41C07C3
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391467; cv=none; b=WvOqeoisP3DE6jadv8LRx1SCJqSAWTMP/6NecJjCVYVaWK+YPQzQEH9Dx4rLI99rK0dTDLTfy75DwpelTySBSYptlslIKQqdcMSQH5oR1RUkB5k4j6xyRB/n6TRT39jvf9Ma3UOuova79EwQQWma3ChIoAWuZXKl+mBzXtVzAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391467; c=relaxed/simple;
	bh=NF4T7x0KqxjN1Zk8N6FsAYLGGhLudo88bi0zLj313w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgnfVcKg+fZ+pnIxQJpHn7ML2IgMz8UFxVhX66X+wCU+2maaZ535d1m7Lrq4t9al029AuTEzzVYuEhCCGch51vdr1d0vnBdzxEniv+bDExk6p9RuXNbIwmb7L64peisVZn8IKZYHaFh7NI2ZYXPLdxgN4XsXsqVcNaRcSPEzbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0eG0vZ/; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6113e68da82so1459069eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752391465; x=1752996265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NF4T7x0KqxjN1Zk8N6FsAYLGGhLudo88bi0zLj313w8=;
        b=m0eG0vZ/O8b7YuFh2ikSwwEqKxPjCo9UdAPt0TCzsFnYngOGZmiAhRCtNal69VvnXG
         LjR98MSQYB3dfGpZkvdCAg7zfsUq2tV4cO3jBZS1yEsgOgRZonslLXfvwgrEktkIl0U/
         8BTlPkIpyj8V3maCQy1bAFOavrMs1mSp1EL9yd5dEBe5Hu/z8Y+rmQsilU5yJcMHvESI
         3zVfbBY6p6RO63jeSxVyYuWkcKmI4c7nDLD0n3yRR2MpH93Z3HOrIuFT8xpE8W6/Dpoz
         eXTePah+k5tA2+qVuD2XtTWCGBbKV9VxIqjLs5qn2JR8zdLmMw9c39ASsfcWGsuzhIkW
         s51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752391465; x=1752996265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NF4T7x0KqxjN1Zk8N6FsAYLGGhLudo88bi0zLj313w8=;
        b=sn0G3u/douR9taY88ft3CgZ5gX0/iNFYHmga6IuCs3sc+P9pN4n+UU+GtMCekdQCNP
         5hIlUTIyHdGeJZWR0T4W9LWoz35s3ljA1TPecYMN91pE/pIYUACXwLge5zcfQgmLv7rk
         GiQUwzPhe7ouJmDYGwjNU00Z0xrhJH81OBHVGhqKM92qlSzeZlLFjy357TnqH1rA1Cwj
         OQpMmNQLCOu61ZV3KRfdFL2Fu6h/6cDviO+xrNnj/er894+gOrSY23kkzb/TouzYSvvT
         VNGAXX58z7X6p5vGhDWd5ER6Xo6O+hgL9WZ9TlYwl8k0EwmF2m9xc9ju5wskMEVDwq7/
         cK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOzQtlEQG+Y5Ph8RILTXa+m9omT4EJgPuz07V15lWBGm5I7gkmb1bgf9piNs1SxF8XFTtrWCfwKnzK3E0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UTUBgPGS206tP+hS3jBGmGJyzq2jvUJXevjJfjXyvfhSJPdE
	RwPnHXL+sCa7qEIyJSJv0RN4Y2mA5FTujP51hILx6mD1PqLryGYB1IIvb4BKCFyzMwKLwJRDGkh
	25UkYurQZmAaFar6FLEQi2qUX9nubFwA=
X-Gm-Gg: ASbGnctSznntcs7dHoMEY3xX/9jF3KzHbARdwwIuGe3bIbm43JfMRIWtdxbegK4KZZh
	mEu6/kIqwCJ8fElYGJP9YujiaPcKZWZTOEY2fmvNjdwcmypclyuP+1Ue6Ns1BQ5LOM7HO+Tdtl8
	oDfAaedH6DbEMdlJgD/LbItspv4icGjtxeKDOq/FtTXZ/38Q1d1f4XZhNn8BndMGnFkimO36KEW
	dXm8IGf
X-Google-Smtp-Source: AGHT+IF4MVlkH5px2xPEDZFHk6dNlX+XsNGMYba1X0b8T0K3Xbl3WyMNlX6CvaCyE1A4AgmNNGss1OBgEQJEirl7H3w=
X-Received: by 2002:a05:6870:348:b0:2e4:68ee:4f21 with SMTP id
 586e51a60fabf-2ff2691ae25mr6065869fac.20.1752391464913; Sun, 13 Jul 2025
 00:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605175634.16362-1-suchitkarunakaran@gmail.com> <4448980c-d385-45ea-b8c2-b4a0bdde39c9@oracle.com>
In-Reply-To: <4448980c-d385-45ea-b8c2-b4a0bdde39c9@oracle.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Sun, 13 Jul 2025 12:54:13 +0530
X-Gm-Features: Ac12FXztDpOAEQp2PK_JpoFMZDvk2yr5zsd19V5JVpNovPmjyPli4RSP681BYt8
Message-ID: <CAO9wTFimpNU+h4XvpRSS5ocKWzVF4G3W8G2NyOMt09VtVdgKSg@mail.gmail.com>
Subject: Re: [PATCH RESEND] jfs: jfs_xtree: replace XT_GETPAGE macro with xt_getpage()
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Jul 2025 at 01:40, Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> On 6/5/25 12:56PM, Suchit Karunakaran wrote:
> > Replace legacy XT_GETPAGE macro with an inline function that returns a
> > xtpage_t pointer and update all instances of XT_GETPAGE in jfs_xtree.c
>
> I'm picking this up, but I simplified it a bit. I dropped the size and
> rc arguments. size is always passed in as PSIZE and I have the function
> return ERR_PTR(-EIO) on error.
>

Hi Dave. Thanks for picking this up. Is there anything that I need to
do from my end?

