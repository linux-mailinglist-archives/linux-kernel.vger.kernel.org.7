Return-Path: <linux-kernel+bounces-865288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0764BFCB66
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A5BD4FB770
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800534C995;
	Wed, 22 Oct 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL/8yhpO"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824030DD32
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144843; cv=none; b=AT6JHcqXZA70L/do8HrAzG52reVk20b3qd6DIXMYZcDjOmhroJXfzlFXggSpnBWhc4Cvh2g2XtUvcXQgysC5Bqnepz3LIRQLEEyMXoOX4mg+R32NfIELd0cXm9WNxydtfXunRdS2gUDSZCBwY9DB8BfHXtekbaBFODenQplZbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144843; c=relaxed/simple;
	bh=bks8qIi7M2BOZI3y7iG2qNo8QYzUXZ0cz4QMvS9FeDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+izEFNRvMEHh77C7Am+WnYcio+LPnuECbsdV+INL9IFCB7xAXXzPFMZ7W39Mo46diYHqEyiZS8Z5QWwhHkazOZQWpWoBK/hN5V+AcLPN23tJYkAULR9znJ48kO7HM2vwWBOoapIUoaltxW5CTsW9RnBtGzlstLG3d3dm8HKI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL/8yhpO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b43a3b1ae1fso164667866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761144840; x=1761749640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bks8qIi7M2BOZI3y7iG2qNo8QYzUXZ0cz4QMvS9FeDg=;
        b=AL/8yhpOqQkpiE/+WJdMEYRlOKeqUqHddQ5y9TgWJ4mfVmJzEBxtfWI5erMBihdD2J
         XKH83fUX0x9DgFIwQ/jErQ8lKqPk/Izt8tkNpZmmKTMSqgpDCFQYDmnECOOnebnW6ZEw
         lL+0H28uPPY64BJaSpC3f7OycjeVYQ2cdbaUnJCnwy+28EXMg+Szcj3Q0LaATsekWysg
         JszZBSnJ3xWexLcrVIKDc1vQDMbmgVRqQZyi9zswePHLkRUeEkZoDPxuT1BOkrI+0vPI
         dAagkhoAf26tOkX23HDkW4jPq5TCuep+sC7zM5qWmao2+p7vzVHsgHUe8UpE2mAqn4NG
         Ddpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144840; x=1761749640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bks8qIi7M2BOZI3y7iG2qNo8QYzUXZ0cz4QMvS9FeDg=;
        b=cvbwqWOFg8lV4k2LK5REyUfXqKCJUdErzPpm6tPut/uGkxfQ6AdTPhyP7v/u2LuY98
         1MmlcUJHwHijO/6X86cdjlXBOLIFKFhfPbDCuazNOP4YzATawM6RqK9VRPjKFdfWmmHx
         DuSAtAvMms8gkGTdFXVCTxZFEUIUIldMFfOMiWE7uiDzvyAKDAnZlCfvSFgPxIFHBbCb
         MNE73w2YcTzfF7tDVnd5UqpMfvdLXf69MJOORMDiKV28yV4vR8BtZJwZ9BcMHwZWjCtb
         rqBjz50x+9WdA77rah4QVP73+WIx3j91ij0g8bc97ixYRjxxdG8SBWHN8hVFYfxq9ZMk
         p+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSxv9dSmD2bfVs+7+psgd8L4PUtHyOkrmF4m3K4ijJE0G5MoRsdKsCgzoU9QND3rgAkB/2sCKLLEzR4B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydd13b5jg1AJhN+Kgfp5DCJ3pYcWKMDWq8g6wRl29jM+jqCynz
	4Bg3XiXEjG3m4+GoX0FA6kESfBOgfnGARMC7jxPv2WRhWZ5kVMxnB0h2h78rjyWBZvRHrT+KPHa
	c7XQJxFr4Eed221f+AumlZNgyI8568QQ=
X-Gm-Gg: ASbGnctqHjbC9PzVQwvN2YS2G3mq1Z5sho7nNeB4ZD447E1pGCpBSp8vpzVc0SYb44L
	66RwA57B4oafSXXfeoD79tfy4m+TasSXnO3dWmTunuTmTGaXBVYwqNyDeS5Leuq3F8k9UPtyfdE
	ErhroGILt2NUqNvuXQsAIMG8n06qM4CqvASqV1MnM8oLMp16+F/S1CSSPY/DuxWNzBAuRFOe28b
	jk7Wm8rrBFigz5LnRToPpDCzAIrLt/Z1L5kmPZJW5U9HYaLJmpkBNvjBIUSqA==
X-Google-Smtp-Source: AGHT+IG7h7TaFxHTuDY8AWEs3DohBAFF5ntTu6CWIe9+nZpuje6ygTxavGcJ/i05b9VtLfcssN/cg/UG6AHp/Ayc0iQ=
X-Received: by 2002:a17:907:d90:b0:b6c:55b5:27a2 with SMTP id
 a640c23a62f3a-b6c76fa331cmr460806666b.6.1761144839990; Wed, 22 Oct 2025
 07:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025102125-petted-gristle-43a0@gregkh> <20251021145449.473932-1-pioooooooooip@gmail.com>
 <CAKYAXd-JFuBptqzEbgggUhaF2bEfWMRXCSK9N_spiBxvi1v0Wg@mail.gmail.com>
In-Reply-To: <CAKYAXd-JFuBptqzEbgggUhaF2bEfWMRXCSK9N_spiBxvi1v0Wg@mail.gmail.com>
From: =?UTF-8?B?44GP44GV44GC44GV?= <pioooooooooip@gmail.com>
Date: Wed, 22 Oct 2025 23:53:49 +0900
X-Gm-Features: AS18NWC4GzKd1xEuugd--eot2ZHrwZpDIUjy0AlgxBnilTm3xbX4azrPGMl_XLI
Message-ID: <CAFgAp7ixLZLXGSN6tOmtNj0f4b-z3pnMrQg4Avnb6tOvj3h3KQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: transport_ipc: validate payload size before
 reading handle
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae, Steve,

Thanks for updating the patch. I=E2=80=99ve reviewed the changes and they l=
ook
good to me.

Minor impact note: this patch prevents a 4-byte out-of-bounds read in
ksmbd's handle_response() when the declared Generic Netlink payload
size is < 4.
If a remote client can influence ksmbd.mountd to emit a truncated
payload, this could be remotely triggerable (info-leak/DoS potential).
If you consider this security-impacting, I=E2=80=99m happy to request a CVE
via the kernel.org CNA.

Thanks!!
Qianchang Zhao


On Wed, Oct 22, 2025 at 3:39=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> On Tue, Oct 21, 2025 at 11:55=E2=80=AFPM Qianchang Zhao <pioooooooooip@gm=
ail.com> wrote:
> >
> > handle_response() dereferences the payload as a 4-byte handle without
> > verifying that the declared payload size is at least 4 bytes. A malform=
ed
> > or truncated message from ksmbd.mountd can lead to a 4-byte read past t=
he
> > declared payload size. Validate the size before dereferencing.
> >
> > This is a minimal fix to guard the initial handle read.
> >
> > Fixes: 0626e6641f6b ("cifsd: add server handler for central processing =
and tranport layers")
> > Cc: stable@vger.kernel.org
> > Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
> > Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
> I have directly updated your patch. Can you check the attached patch ?
> Thanks!

