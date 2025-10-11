Return-Path: <linux-kernel+bounces-849307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7DEBCFC7E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 22:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243873BD36F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57278224B04;
	Sat, 11 Oct 2025 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmbcgNwt"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29C200C2
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760212866; cv=none; b=srSxSPWNQz9BB9Uc3PZAIrtPgIKNxkhcj+q3PYwtw5fYufJM9zP/0qZZHvOAxG2xd7eCddCpbi34vgv1MseOfKRUcEIdZ6jMCCnk6IvqdN0eeV1qXTLD0oVPob3yfW/jQ29jL0SBqjDZoztBBb9hWJbOWrBUuL38zRkTtLS/yb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760212866; c=relaxed/simple;
	bh=1Ps4bs+k5Q12zq1sC/XXxaSLC6nK6BiT6V7wRXyLi8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4KlgPyHnlQf0TP9vFKVWeRRSU01fEulxa8vMSV5GkHRoJ2fv6xxgnsZAU2BxJ7GzRKHAm8PpAo9x5BMIPhIphfn2T01g65xnRZNCCWyHm7ItufpQeQXUA8sqUpV0dRyvuPtcMHRFkmSu9KxuggTBSzm5qkIRG8XFnnoVQoNVUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmbcgNwt; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7970e8d1cfeso51235566d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760212864; x=1760817664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfL+PrpKvMN9jJeKubgjHEY0rwUSNs6+/9bmODOXmYo=;
        b=WmbcgNwt6p9W2WjOcsJkJwTnWA2KdH2NLaAbIUz8xqe3km/hseaEOgf3w5tQcnvVIe
         HpnUYWRUqj5kCvn9L8alRy/CzqKxUSxUDFELTISHi9Mm1OGtMQFL4qbRjUEIPfhLAI9o
         VdbVz1owvZ38v3+E6Cg3OF7c19JjfSZjgmPFdKJmRNVGnWMYqaRo/ZkSRnK5JjP3JPL9
         svta4AMS1IBa18cayA3v5FZdA050J5VZZWvGiyfbuI86gq52zJK3FTYfbG3ZPzk4LiAl
         qO6Y8Z85oEePTmf9Y3GGbybo4cwYrdoQGch+qgiUzEvuaunvo2Im6vYRG54ud32YUNn6
         GtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760212864; x=1760817664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfL+PrpKvMN9jJeKubgjHEY0rwUSNs6+/9bmODOXmYo=;
        b=YNdULu910A33+sK3gsuNKOnlKe1SmMXS0mjJn13WQG/JCt4JhPAxGyqJxtjY8iXSxQ
         OKrgdE8/SDzVpa/pPQiPBlkP9/B5RqPv51pc//XYE6QurC8nfgbW30HUT7fFPqVvDcAb
         Z9hE3fEVzoQoB5LEa9elNXmJEPJnyFNznewKVzO8JJQx6Flr4F2nGyM5yHtfkDYgvCcj
         1sP680Tj07r1nylsXc4Vtd0vbU9+qccmCk6WYl9oKnv+zHHAeuwx1Wfw/5+oUEZjR2Wi
         62KP+g2TV0cCllbaO3shEGAitt7xFN+eO+oDlwBUaROViC7tz9vX/DfeQSQ3OH5iZcQY
         OsqA==
X-Forwarded-Encrypted: i=1; AJvYcCUN0aweHqMQJ0XC+mB4Jxp9op0UD0natLh5fqIpeMA3BzPbccFXzW2Pza158gJPEfnIdlfFcsbIQvCm/OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0tR0Hb4F+gI1NygvoChO9n+4oay+eS25AK/XOV3DiS8/ZpEQ
	7z1w9fIqhouoRpTy5dFOtGTNQhZpQmiz1xtQ+kKaHTrUrOF1ekCaBDb80RB9clorGVRUzrkjH8H
	fpDJGJfrXttTLudFLz/AKVH2fo4mAeV4=
X-Gm-Gg: ASbGnct+SN8YOtwbW06pXqmsXV0YJO6jjKPy15e8uvNGLLqaZR+WztcKivQvn9Hrbid
	Xct/EbV+aOhxEW79ibObrslbiPvoDH7WVcIHQXFpKBGH8V3gUrlqzcFbL6yGUpiNYFdkIygt9Ur
	fZIkUvdDQUfcpVxw34xtg4Nw0UlNN0XKkx4lIIOR2uCDqT46nDdEDZtoOE7lTES4MaBCsHBsJG7
	y4peOdRF+3XBVWGmf3TqxpUf1OZOHG4NLw4Mb3KGk9AVmlOUuhBhF2tTCMugRPkAVGeO63JoBhx
	np0l1PDvhHrVbdJFQ+A/yhjtKJrafVxeZjb42+/7+qxmsretSkhV/tDmTGQd7w/Vp7MUkxJeAZT
	S9mQxdMjgW2BzKX+tEjGRKzL/o5RNz41HgArekZv5
X-Google-Smtp-Source: AGHT+IGPQgsa9k2a1Up8+w6cXCZMeV+WWQ7neAnv2u8rNwSSNXa4/xhGZLri+COAL8htLz8tCf0DrbfdaqC7StUYs9Q=
X-Received: by 2002:a05:6214:f23:b0:809:c3a1:27c8 with SMTP id
 6a1803df08f44-87b2efc2d9amr249718956d6.38.1760212864032; Sat, 11 Oct 2025
 13:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f61abf77-4f12-4dc8-8b42-4bfe19aef174@web.de>
In-Reply-To: <f61abf77-4f12-4dc8-8b42-4bfe19aef174@web.de>
From: Steve French <smfrench@gmail.com>
Date: Sat, 11 Oct 2025 15:00:52 -0500
X-Gm-Features: AS18NWCM0YwVW2bZ6DwJJ1L4nOwS-cEpGPRUjdlffaDFbiwcZQD4uBoAC9uA7ws
Message-ID: <CAH2r5mt7LOFRahepvnPyLb_f6-SsWXRkWZ=B+TB3bB-dLmZUcA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Return a status code only as a constant in sid_to_id()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Bharath SM <bharathsm@microsoft.com>, Paulo Alcantara <pc@manguebit.org>, 
	Qiujun Huang <hqjagain@gmail.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Steve French <sfrench@samba.org>, Tom Talpey <tom@talpey.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Fri, Oct 10, 2025 at 2:24=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 10 Oct 2025 21:04:16 +0200
>
> Return a status code without storing it in an intermediate variable.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/smb/client/cifsacl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
> index 63b3b1290bed..ce2ebc213a1d 100644
> --- a/fs/smb/client/cifsacl.c
> +++ b/fs/smb/client/cifsacl.c
> @@ -339,7 +339,6 @@ int
>  sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
>                 struct cifs_fattr *fattr, uint sidtype)
>  {
> -       int rc =3D 0;
>         struct key *sidkey;
>         char *sidstr;
>         const struct cred *saved_cred;
> @@ -446,12 +445,12 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_=
sid *psid,
>          * fails then we just fall back to using the ctx->linux_uid/linux=
_gid.
>          */
>  got_valid_id:
> -       rc =3D 0;
>         if (sidtype =3D=3D SIDOWNER)
>                 fattr->cf_uid =3D fuid;
>         else
>                 fattr->cf_gid =3D fgid;
> -       return rc;
> +
> +       return 0;
>  }
>
>  int
> --
> 2.51.0
>
>


--=20
Thanks,

Steve

