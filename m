Return-Path: <linux-kernel+bounces-874759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6B1C170A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49B494FCFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A64355022;
	Tue, 28 Oct 2025 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8hOjRPf"
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1134F487
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686936; cv=none; b=b9o/N8RgLs7qJH9IteFkYCo2xnm+6te+YMbp4x8C91DLIqHDBSNMtsDnw/EYrwodoZDUd5d2YTirmBmctxPWlmu33S7ypJriPPV5EsFy1o9rNGEEnf93inOttoNGjb9syNmL/inAzqpLLjdFS3thArw5R8HgC1iRSJNgSHehVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686936; c=relaxed/simple;
	bh=FlrVwPPGan2VkiUTXCDaJl5ILUZUpZ7Y34dMi08dHpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTeElPARxRaJQGHUAOgwq0ynaKDmNG5LJTg7WQCDRe3OBNmdtcV2nNQXSE1cOMugdEeoDqmHG8Ed4Grx+/C5MnLlv6bM79mG9pz9HAAczHR1gdN4yLIqlY0E2y+X+h3B6atHZP1JZNd2z2QCncyyYP8fhKgehYAUOqNQ3mW/WZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8hOjRPf; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63e17e290bbso1017432d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761686934; x=1762291734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tyjSkBqAxzkn+CQavzu3otPqr5+9CTB8orLK+D0h8o=;
        b=m8hOjRPfbzt6KKW3tf/WkH8FzbwPczCQtdFAYQP07ZlURtOKanZWWQUFeOh2Ai2kWO
         LDwqk/UO2Q+zi99fpHAevBcx+z+UU5nP3yIV7W7Is1ts5FyEIZHfjK+RPUSGGMpEkqSu
         lPA1ZmBR0grNbkcfNATohu5prDCZEerhSKNryDlYf8LfJ9u4WxwZCT3Rnh/w98ocW9Np
         ZC1Yf7JH7AcpRSg3taP/QE/Sp1b7c/+WV8o6hVXEappnRDX9URDMdS5WWW642wjb3Y0Y
         7vathqaQw3Cyg7C3HzVNI6+7eTjgGZPMIB8TbuQ41dhggursi08h3NYSmHn1P6ljmgFm
         jtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686934; x=1762291734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tyjSkBqAxzkn+CQavzu3otPqr5+9CTB8orLK+D0h8o=;
        b=BL22FcYrHF/ssfARKFQIkmd09aWjTfXLJJ29PhVyM14xlcTLLYFNU8dqrT4zTOYe42
         JrsYapWFYTj5yyQqVtM8p3bXbb2YIDRGkLtyhKP+N6NmWS79EOM6+pJxrQZgbb9DzSzc
         bH7Uuo2JW5sZsO1ysoOlxummMAdFUFcaRLwsb89snLZQ0Vhhcb1mbemuZaz10HudKIko
         EoRgGrerqDJkofAD83nNQB4mF9vktu2pY+1Xg0KTZomOuYXklIn32oTXyK9vjEgtsqOx
         fW2f0fltOUdGJoeuicMCZJVmeLZJt40TyUIy35ia8YeSZ0rDV9JiGMF9reacJ1Da2rbq
         J5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgMyEkt3ueEdZ+LJP3h5LSgzDqQ4uh6DfmwFcmigyi7cVwGBdzinW5/vz3+PZJNDGnRKGnsZ0edqFjH8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFf5hssUV0/Uus6tPdWJalXa1CsCeU0vYpvXc3LqpdVRm8zdk
	kp3adcFXk296dS1JCTuoAUkgVYe+1XOfRlXE2EMarTl0C2cNDRES8Kk5aLxIaPBX6dy6QVSVGf1
	ACISGWpS9B9LB1IuizND4tsaALghBy9g=
X-Gm-Gg: ASbGncsLsdAbmq5GQtnvqw37ZD/tHBBORaLMd57xQjoeR0fUpH7iWysM/YWDZcKMiVV
	sN6B+HKXGSLe3VExR4rR4V+ss/KhkijnwUgf34PotkFIyRgIYftcgvLtZaFuLXx5gD5nFz7rCwU
	PfjC0UzRPCS4rvDWAJ3O/zZBr+WcEMvE1ow8ewv+ifmbp1ysTp0o7EU2FnAiQylm6Wp/PPnLNQx
	qfUpP5+mF40BoyVTiNzfIlgA3OafV84W83GSeOi+5bkh6MrQzNR5Yha+4+cFhikFWmMq9uL2wnG
	mUS9SFS6pdVmQxmD221Pxo+ekWM7Mq5rocMjkleP
X-Google-Smtp-Source: AGHT+IFy4KqRcJWjHdRCWlntoiPUdZw5jr0pom/+sLkP8yYz2Qzueg3Io+wNxP2TxEMxhJnkyPiCxyS44WeU82u+o3E=
X-Received: by 2002:a05:690e:4185:b0:63e:3994:4ae9 with SMTP id
 956f58d0204a3-63f76d93ac5mr491340d50.4.1761686933644; Tue, 28 Oct 2025
 14:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-netconsole-fix-race-v3-1-8d40a67e02d2@meta.com>
In-Reply-To: <20251027-netconsole-fix-race-v3-1-8d40a67e02d2@meta.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 28 Oct 2025 21:28:42 +0000
X-Gm-Features: AWmQ_bmUEQ35ks_l7mvvwHrQYjN5oy2VCaV6asFQr8rvXZMWDCaHNByLiQR7WjU
Message-ID: <CAGSyskVvHvK3R0SQ+yg3050E_btovVY8L2iQ1gUvJ2GigKa5iw@mail.gmail.com>
Subject: Re: [PATCH net v3] netconsole: Fix race condition in between reader
 and writer of userdata
To: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthew Wood <thepacketgeek@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:08=E2=80=AFPM Gustavo Luiz Duarte <gustavold@gmai=
l.com> wrote:
> @@ -888,6 +888,9 @@ static void update_userdata(struct netconsole_target =
*nt)
>  {
>         int complete_idx =3D 0, child_count =3D 0;
>         struct list_head *entry;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&target_list_lock, flags);

I realize that we might call WARN_ON_ONCE() while holding this
spinlock, which could deadlock trying to write to netconsole.
Let me send v4 addressing that.

