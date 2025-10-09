Return-Path: <linux-kernel+bounces-847071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD60BC9CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848F33A16F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902331FFC46;
	Thu,  9 Oct 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lihEbgME"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FFC1E9B3D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023812; cv=none; b=hdph+a0hYqjdHPmqDRV7VAZnUysPpKW9PNgJjDwerIhBUUeszFSUfE081EW08PXbfiWN6r45yxcAUQSaas7BhMDUe3j6veIqf6ZdyRZX8xp3icKx5Eu2p2MFQ7OvkdVtFvI+rbtCwGjV4jCvY/EJkn1oeVRdDT7jXcgEY4SQGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023812; c=relaxed/simple;
	bh=xKdHY98uifDCA/ZQ54Qd29uwoqQwdPCP6AZELTJbBvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9QN+vOPSncngdA7eJP8cCr+w/qlBJ2i2zlDsHdotsTdKxa3WBODA+PpqDgSEPtJ/EdczS831cPJkcn/5m4Btnha6YNYInImVBia/rxFN5tmLfFKrS7DKkctm4dqqQmg376nRbTYAaB8Gi2MFV7i9rCfoIA2OEsgbHjsnNip3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lihEbgME; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-799572d92b0so10736476d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760023810; x=1760628610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K/OkTfxaQVQjtAI923mEKQkdyC4/Ch4flZGg5G+nto=;
        b=lihEbgMEpSlA5LSNoA9Qp9VepM65F3cxM6NZN/eNaRMWaYFu7pQlUnnNl6K5bw/0EX
         trWDdJ6Ke3Mv/19+6xR1t5SDsu8TFJgaUdkFHyCly7Cif7zgmjUdVf6x2XWS6A621If1
         BmU4PoYpgxl0BhbALg0FqpIdWpRV5L4l/QNAGjFOu5kjyhrY3OnB3Tej+z8in8B3xrdH
         dE93j/mteX93Ud8/ily/c5XJXe1wqj2fxiEV4bmflkX3+oI6jFB/s3P5dj/h52X+VxQ0
         FeqX1w3/BJYvM9fepsETt32d+dyVIo099qaKTkrB0uzC+yZy/GoJwCPrxgl4obz25q0s
         10uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023810; x=1760628610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3K/OkTfxaQVQjtAI923mEKQkdyC4/Ch4flZGg5G+nto=;
        b=Yp90T6fkYNvZcV3aBamKEyVruy07fTS4s66CDZhmLDmaStQCen5qcqoHe9oOQFSG6v
         JBtUt37rkQ7AFo2LswcWFbmpASKgmjl60iks4CKZqumlhNkrpWI34bF3iWY5X5mwANV2
         Sy0/P9cBt5ncQ1IwNzFNTBVPaJvx4feKU93RZwS04xHPMXQLqWJLA2/gaO+7e0qrJsju
         TfUGy36j4jXFO1ltXTCxNUJ0v1MjQvZYeOdG2LkZhLHV9Fej6agm9vlcm6S8MoS8f1l/
         PrJgjYY/IYLIr74rx3KFlJpCh6nfwtDIUVDPBIIhANwuVf3hrVb6gtC+wxT6nP49FfSU
         Er0g==
X-Forwarded-Encrypted: i=1; AJvYcCU5nPF1Hq17OwCEt0P6LDrmqAB6XXYL/JdLvueHca82N/LrPWcmsQyza1gWHRYZf0rlcB3h111TOyb2Df0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0YEdZKoOWzPNfyuOece7oY1Has7KgcA6COn/R0jQU/fM7WhP
	qNpdpSRy57icoGViLMPz7sxN1OCb8BeNoqgst2PgU1KAamERHTVEEtcU25pt3pHgfpYQNzq7HdZ
	voRk3wsiNmP8STrBe0/wJ/5COk+r4unRr9w==
X-Gm-Gg: ASbGncuSmb/neBJNvKwtluZDOusDwvFkgzNZwZxKqhPYq0M2Iw7u+Nr3FfMnjne5c5X
	LwmewcoNrvsOgCtddc01ENzkoxCej8320qUDFPteaRsikE3IEP5q3yQQiFbp4lgfM528hALkIQ9
	xigXw7McUCtA7AGG1Bo5NOzLSs1FlgoHulEFwj5eWPBdb5uQDddJ24QbXibgp/8Lw0G/hdwZpy5
	eWmdIrojZjDzz8UUqIBHGPrilIJmPpoGnGs4tvwNYz6qyHtCbuU64Z4IKSGS+IePfsw3DFFSOH5
	RtZDHRqBgPrkxv4Lb1BHdn7RvD2d2BUcvrF1YTNlbxkIMWBTX+j1XoQrKKJbWZMdu7josT6JETz
	K5jqhGR8DejpznmfYH70yJ4jx6iMzmErKyeRGqpsYdhvvLabpz2Yxzn86
X-Google-Smtp-Source: AGHT+IGJdcJchywsY80gAXJqF2Dh5hkmMc+nT1QmiKbYTO/FxvtFxR8ICSKzlj+TOaws0AV2aAY8SzOBjdCxSsbgzqY=
X-Received: by 2002:a05:6214:484:b0:7cd:91ff:6215 with SMTP id
 6a1803df08f44-87b2efc2c6dmr99245676d6.61.1760023809944; Thu, 09 Oct 2025
 08:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5b95806a-e72e-4d05-9db8-104be645e6e5@web.de>
In-Reply-To: <5b95806a-e72e-4d05-9db8-104be645e6e5@web.de>
From: Steve French <smfrench@gmail.com>
Date: Thu, 9 Oct 2025 10:29:57 -0500
X-Gm-Features: AS18NWC3ORxIiPJ-wdFN48myFn8Rs2UbLqRS_MIq9LzeT2xWYlDBUeIINdVmdKk
Message-ID: <CAH2r5mvg=kqPyA2nYF=Nhjr3vkt4dT1R4p-Bk_MBQtddjx_EhA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Simplify a return statement in get_smb2_acl_by_path()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Bharath SM <bharathsm@microsoft.com>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Steve French <sfrench@samba.org>, Tom Talpey <tom@talpey.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As pointed out by the kernel test robot a few minutes ago, this patch
would introduce a regression (uninitialized rc variable in free_xid
macro), so will remove this patch from for-next.


On Wed, Oct 8, 2025 at 3:02=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 8 Oct 2025 21:56:34 +0200
>
> Return an error pointer without referencing another local variable
> in an if branch of this function implementation.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/smb/client/smb2ops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 7c3e96260fd4..bb5eda032aa4 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -3216,9 +3216,8 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
>
>         utf16_path =3D cifs_convert_path_to_utf16(path, cifs_sb);
>         if (!utf16_path) {
> -               rc =3D -ENOMEM;
>                 free_xid(xid);
> -               return ERR_PTR(rc);
> +               return ERR_PTR(-ENOMEM);
>         }
>
>         oparms =3D (struct cifs_open_parms) {
> --
> 2.51.0
>
>


--=20
Thanks,

Steve

