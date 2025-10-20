Return-Path: <linux-kernel+bounces-860120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E785BEF579
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478D63B94B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375192820A4;
	Mon, 20 Oct 2025 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT3IsDld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320518C26
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936594; cv=none; b=EZW8ks7UfLKJUKH/Xuc1D5cJVem2kJ9Vd75wQZ8Vf1f6wz7GHa+FXvc31u6DE/Fsw5WHf3r+zav3UHjpEnuJWMuIrQcIEKjFm6OLlhFnyFpqiCfscpxhtGPe+m0Ytp+6xRhGbaeBQrnComZi/+kKKspWgL/7PY5EjzfkFSl51FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936594; c=relaxed/simple;
	bh=etxCApgdgnBijPI1T0DibfTrBg+nQeKaoI9q1FeiBrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjMEsz4nXxLPVW/62z7y9C7P47uImCpGoka7XVTSpLRuKL5MqZlMbkX54mt1wU9xUQsezAI+LiGvtMbRkGtWczpCF7yvw2vKiINp7Izf+gQk8klEHdG7ARQgrdG19sJY9lug00CFOj22/dPBhtAr6RSpTG/RqM9eVrbuWuwxnFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT3IsDld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7377CC4CEFE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936594;
	bh=etxCApgdgnBijPI1T0DibfTrBg+nQeKaoI9q1FeiBrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bT3IsDldZ+dzs0SKlb68Axv/OITgz37S+13So+mN0V24dm8/b2ZxF96GrnBxP7fG5
	 V5zwgcRZfw6wO2L8NoTLGxJ44L97YhZyxSr7Y8IhC0XdCtyQTsY5UoVJ54G4JTD6yj
	 lmiuChqH/BGmQyVlo+BALZqnrs4UQFNW0X87gEQDAa0DUWwwMIUfgCbVF3AMKHSvaN
	 6XGP/6gxS8Hjslm41y5Uu6T7YPFQNbQy4N47NGXsPEghJl9QLJRT6KFN00p72vyMRn
	 2Vw9+C1cfI377S/+Lgt/H+MyEWLQ1Sve5G1sJY27aCDnGPlkGFviKms+jh2o3K7/Lk
	 2YNlZx/LJjPTA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c49539cf7so2963380a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 22:03:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkygaf7sOPnB6fToYlxXl62q6k+ilTlrIBuTkNrKjbqxppIp3T0wfiEWfTHUZ1ZbUwth5MhfDOa1Ct/oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GFK10vGODy0p9Ol/kmZGcdIbk1IBgimmFKkF2JGJ5ofnR0lO
	6SYd1/Mq9ZVb55wMJ4cMoftF23loktcNXW3mC9Vq706/WEN9nQ7qpFacytooFs90s2QJvZHVqq3
	u2pdtZ1vNvnmhLiDGaw8Z+zPTuPaxY4w=
X-Google-Smtp-Source: AGHT+IFx+F2BT09NtY957zTEzJFrrLdKDfb/4t9mK+mq3XyOhaPDmlUqvbNnye4qaRJB5iC9dHHISj0/zR9BxV+CINg=
X-Received: by 2002:a05:6402:848:b0:639:c94f:93b9 with SMTP id
 4fb4d7f45d1cf-63c1f6d4691mr10433481a12.33.1760936593075; Sun, 19 Oct 2025
 22:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014071917.3004573-1-chenxiaosong.chenxiaosong@linux.dev> <20251014071917.3004573-10-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251014071917.3004573-10-chenxiaosong.chenxiaosong@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 20 Oct 2025 14:03:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-zUyxsrevM9huWDeyOb3Y7XbT3ngqq1Xax0um-dXTwqg@mail.gmail.com>
X-Gm-Features: AS18NWAH1NWKTf5iWkVIYaCb0sEEOhlcF6TaOw0NJJrXIjjP-x3O0tyby-A7Yig
Message-ID: <CAKYAXd-zUyxsrevM9huWDeyOb3Y7XbT3ngqq1Xax0um-dXTwqg@mail.gmail.com>
Subject: Re: [PATCH v3 09/22] smb: move copychunk definitions to common/smb2pdu.h
To: chenxiaosong.chenxiaosong@linux.dev
Cc: stfrench@microsoft.com, metze@samba.org, pali@kernel.org, 
	smfrench@gmail.com, sfrench@samba.org, senozhatsky@chromium.org, 
	tom@talpey.com, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, bharathsm@microsoft.com, christophe.jaillet@wanadoo.fr, 
	zhangguodong@kylinos.cn, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
> index 0be63c00f848..9b5880e60a4e 100644
> --- a/fs/smb/client/smb2pdu.h
> +++ b/fs/smb/client/smb2pdu.h
> @@ -191,36 +191,12 @@ struct crt_sd_ctxt {
>         struct smb3_sd sd;
>  } __packed;
>
> -
> -#define COPY_CHUNK_RES_KEY_SIZE        24
>  struct resume_key_req {
>         char ResumeKey[COPY_CHUNK_RES_KEY_SIZE];
>         __le32  ContextLength;  /* MBZ */
>         char    Context[];      /* ignored, Windows sets to 4 bytes of zero */
>  } __packed;
This can also be moved along with copychunk structures.
Thanks.

