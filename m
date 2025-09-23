Return-Path: <linux-kernel+bounces-829276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F50DB96ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25402E22A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345D267AF6;
	Tue, 23 Sep 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="emwFha8+"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497826057A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642953; cv=none; b=KWn5777Fk7Rk9pZLMlAl/eo0I20/ejgJ8Ur1fNhNJezSHkt5whAPZRfyVQUtWtDTqV9Akuxqv+oKjqI6aRML8myEnmTa8YFkUfO3HlsQrYvZ8lJ9jPhXd7qRGDuqo9PnG0tN2Mj9n4AKrsKeLeNZ2Emgj+OT4afY/uCj6VsjZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642953; c=relaxed/simple;
	bh=q60l6JkIwsADmqyQGpYtx9sLrvphoYRJZLMv49gW458=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akydPffNjjfp2yWboKj6/Ajw+rpWT01fB9+HG02U2sTJlyf8SZ6hwoeEqSPPdKsyWAqo5W9BBR0o8aE+mCYtITsLJ5FLCBlTqyRSafU+aevHJ9Zaqe+7vJ7up46UA1mbbP+YtBN0iPSE9N1P+jdcw/FrqbyOqw8y2iaaxxHN0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=emwFha8+; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54aa4b86b09so1333171e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1758642951; x=1759247751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q60l6JkIwsADmqyQGpYtx9sLrvphoYRJZLMv49gW458=;
        b=emwFha8+lIkyJjuQicmKIWCTlcDyZdd6pviWUvzD/h/qVt9O9CID3W1Vdk90XfMQjy
         rfek5IJbWL5tDBZTKX+fXdvfuS+salDerQAGGU1PboVRyxtCWeZhz9rihXE7cfZ7FaxU
         2mLIv5kSlEaEE0RXPQWSfH/GP7ZVIcDW5zfiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642951; x=1759247751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q60l6JkIwsADmqyQGpYtx9sLrvphoYRJZLMv49gW458=;
        b=wrm4AYmieWu8ka10UrrMC0l+2BzEd/RCY7Un5vnK/EMaEw3kP/50oUjfKDe7V1vC//
         hszMly3yPESIukrMYFxWo2M3QtPFqffb1tDyGZMy+CUOwaYiHk4Wv+OyYwI9KLYHorX2
         V0UdoHNAp2tkzRDRbXZ02c5Ha3IxPHjv223FfHJoF9bXkSw7B7Y3MF/RqsYDN1zrGYMz
         S8PUOoJhmBr/mWm/qQ6poc6LhONWbH+F5/lnGy8BUQX7QGkpyE6dW2C+uybCL00RpkNY
         qJzBgxn9/uuA66GXRCcs0jIb13bHVe/94wlg6xLxrEhECYUBdGy6SH6DIaNRS6/kRyTJ
         CVxw==
X-Forwarded-Encrypted: i=1; AJvYcCWFFd175v6p/MjOJAkdEVZMLVqoUdrbt4VsjcUEmJZbdDz2NgkB6SKij3VPYHYjo7kCGdacoBJY49b9k/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQyyMK6mE6KxSTMxDLiIFTAYm0TMn9+LhEIMtenrVsLcjPoKS
	K+RP19qweY7wyXdF5BJUIijOIDZbXOy6cPJb9HywMHqflJe+HwZUFVlDesxl0xv0pGzMh5nDR4l
	GFJH4ARDmVe+crMfna5y4BHDZDewSuhphqDY7asddOA==
X-Gm-Gg: ASbGncun6af4qmVRc06jAO5sFbAYe7tYfAGe9NwtJhV9fkf1lIPeBF4qqjsRJTBTPmQ
	jpVYaT9vQEL2J03ZyV9xrb/NY/nBe+MMfjiwsFXvDKkXJ1XP97hEao/sQ/2vY74J4LbONhNNVVT
	71IVdQ8nv5RgccKFHch+w9T/1MUBeg8FvZ/Fp9svR7868GCYX6JMSNQ6R8bLyJ/W3NFC4qW2jly
	v6vSlrR
X-Google-Smtp-Source: AGHT+IE8ZvWiTiGqXTWcpfVsTbk//TxRzsy5cpmA75sT4dqaycKQ5AGoujI4y1Wxl+s9LkZCTdJ/lchQSDdcK3BT5l4=
X-Received: by 2002:a05:6122:3d04:b0:544:75d1:15ba with SMTP id
 71dfb90a1353d-54bcae9778amr849180e0c.8.1758642950707; Tue, 23 Sep 2025
 08:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0cc81bcf-b830-4ec3-8d5e-67afbc2e7c47@allelesecurity.com>
 <20250909224520.GC5333@twin.jikos.cz> <CAPhRvkzgR+8L93VF8XtZDG9P_q7O0+BSBxnHtesLY5oj6uhwmg@mail.gmail.com>
 <20250923151110.GV5333@suse.cz>
In-Reply-To: <20250923151110.GV5333@suse.cz>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Tue, 23 Sep 2025 12:55:39 -0300
X-Gm-Features: AS18NWAXLSWsrK9SrcbyQoYBYwXUR7GXLiaQTIy3LWlL1HCKbnJYgWqOj7HIa0g
Message-ID: <CAPhRvkwLg=5mKv3XKvfLUOPUcbNCAYW2reNub60s5pkLXP=xSQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Avoid potential out-of-bounds in btrfs_encode_fh()
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 12:11=E2=80=AFPM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Tue, Sep 23, 2025 at 11:37:33AM -0300, Anderson Nascimento wrote:
> > On Tue, Sep 9, 2025 at 7:45=E2=80=AFPM David Sterba <dsterba@suse.cz> w=
rote:
> > >
> > > On Mon, Sep 08, 2025 at 09:49:02AM -0300, Anderson Nascimento wrote:
> > > > Hello all,
> > > >
> > > > The function btrfs_encode_fh() does not properly account for the th=
ree
> > > > cases it handles.
> > > >
> > > > Before writing to the file handle (fh), the function only returns t=
o the
> > > > user BTRFS_FID_SIZE_NON_CONNECTABLE (5 dwords, 20 bytes) or
> > > > BTRFS_FID_SIZE_CONNECTABLE (8 dwords, 32 bytes).
> > > >
> > > > However, when a parent exists and the root ID of the parent and the
> > > > inode are different, the function writes BTRFS_FID_SIZE_CONNECTABLE=
_ROOT
> > > > (10 dwords, 40 bytes).
> > > >
> > > > If *max_len is not large enough, this write goes out of bounds beca=
use
> > > > BTRFS_FID_SIZE_CONNECTABLE_ROOT is greater than
> > > > BTRFS_FID_SIZE_CONNECTABLE originally returned.
> > > >
> > > > This results in an 8-byte out-of-bounds write at
> > > > fid->parent_root_objectid =3D parent_root_id.
> > > >
> > > > A previous attempt to fix this issue was made but was lost.
> > > >
> > > > https://lore.kernel.org/all/4CADAEEC020000780001B32C@vpn.id2.novell=
.com/
> > > >
> > > > Although this issue does not seem to be easily triggerable, it is a
> > > > potential memory corruption bug that should be fixed. This patch
> > > > resolves the issue by ensuring the function returns the appropriate=
 size
> > > > for all three cases and validates that *max_len is large enough bef=
ore
> > > > writing any data.
> > > >
> > > > Tested on v6.17-rc4.
> > > >
> > > > Fixes: be6e8dc0ba84 ("NFS support for btrfs - v3")
> > > > Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> > >
> > > Thanks for finding the problem and the fix. It's 17 years old though =
the
> > > other patch was sent about 2 years after btrfs merge to linux kernel.
> > > I'll add it to for-next, with the minor whitespace issues fixed.
> >
> > David, has it been queued somewhere? I don't see it in any of your bran=
ches.
>
> That's strange, I thought I'd applied it the same day but the patch is
> nowhere to be found. I'll add it to for-next again, sorry.

No worries, thank you very much.

--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

