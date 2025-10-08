Return-Path: <linux-kernel+bounces-845866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783B3BC65D4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450423B9E57
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B291B2C0F8C;
	Wed,  8 Oct 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHHaSAan"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548829B8DD
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949637; cv=none; b=BLS1bTfOpFCuMB5ZvOw6OJHVFjh0Yn01vvo+66apk0dTHsqxM9LVubaoVoCfQKrpZEdQhwRdZlZkGQumTHlh5DI6UvzoTbgTIpKY/yUvP24VAQU/pZKoXNIwxsPJ4HZ7gfC8s1mpicB6+2layrmfcSnU5yTdY+SWQKfJsUvF/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949637; c=relaxed/simple;
	bh=WxAKfTixsn+BqAVr3MpIjhaqLr3uVQKt3BNwOE4a/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlrOxXlMCC1wwsWfQ7kVjFHz6ja5fwriH2YtJMh1RhEVRRyGcPPkI+QsmEibP61+/84TGlFmBmizH77isE3biP7fxhdeNY79ZlnniSczs72xtWd9tuN17MQSLFBMXA+J23f2tOC/XUa4Om+bKiS08v96QkqiI7Bfz6XDziMNwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHHaSAan; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7835321bc98so145949b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759949635; x=1760554435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=spsxrT/6ofM3m1hLC9sTXRVhnYqgt2GIu66M9po4jj8=;
        b=FHHaSAanN7jKymPuhj3A95reTXCxeHFYFoaF+EsVghXBjZS1rbVrtQblmfbFmNujII
         /OT1XRYqBvxZrnG4irp83wVJrB0E5blcOK+YY8y4ZbTENxjiNOS/rZC+Pc6muK5igrnE
         3ovByNQbVexIgJqer9/iNVfPKJpIlbOuCIijRFOjnGkl9/jQ1LbUzSrk1OUDudyYdHHJ
         siAM9Kwd5PAq1+VEsbOfznAGSrnnm8k16jAkoeeeF8QPZmml86zMRnQefUUZ9CWIu70c
         u66XRitQSZ2QtxTIGw9HXSTPytExVS4MXatmDVetUsiv1/WHcA1ST74n+3wy+f+XOozL
         /MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949635; x=1760554435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spsxrT/6ofM3m1hLC9sTXRVhnYqgt2GIu66M9po4jj8=;
        b=tWriKhj+SiHftua/Wz3+kdMPiodLnkquyB9S4SIp6DqRGj2Siw/PDVRguuYg3W0a3W
         nEhDX/uXs+IV89wECyKyXUDLsHxyOYBmj43SZAg3Ky5DxzWrBjwoxPBO4wKmHd8E80HC
         giNPuof5RMZOMX99hLy6nREVm6tndBKmTKjORntMiS4xpZDcYs4OxJvUfvi5A3ZB4gZT
         tfwyVAKja5RH8Azqfr82FsjCk5t3PuG76RtzDgc5IoNt8qU4XVcI0LNzsqXHWPsjzF7k
         MZ7YQ3Yy/vPG9zoek+TQ0tbj1Y4rjTXUzIgTAy9ZUNbB9t+ou3Ztf+EPGfqkmzVWfJzw
         jbhA==
X-Forwarded-Encrypted: i=1; AJvYcCVmsmHrS0vMtTXPJmuAPnva4zzVR+CnlN83pMULlLUujpxe/IwU8rld1HMi3CkXKSYp9s0wW1gXJ4d+pJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqLdO0CJqaIGsFiXWy7hBSh0PeykFLmnrRq+t6jQb5ONF9kE3
	w0GSRQXnr+HzxbI+N2GXGErhB7tBRRiFQ3+I6UK61wZwzZ3kj+r3HbM=
X-Gm-Gg: ASbGncuj2hx5rjorsTlSFjGWscmEyMeADlsk7mtLBaUn7yLfZJgp6M677UgWHsavxyF
	0D+gpckjHm2dEhf5ytwMySJ33MMo4Bgb0HJMeIPklSYB6BsQYpGRjuT1zc+Dv9nZt4ye4iBmOFG
	Vq1tfL4dHI+46EBDeOJdd+e1/9/W+h3u/NlvpO+SIlbhBL/rrrLk2JNTvBwsHJWjtbwWIXvkyT3
	z5aayQSvCbr6wvrAvJ0+cH322pH0Zabc1a3RO4UCTLg7Co3uEsiBsNnEcLpELuLXAAsuOACkLFb
	tPGfESWkIJJ+WTh5XbqQJCpiLtinW9BQuo8zPIoio04aKIEfBrx7aHGqXkXPdaRkZ2L3wJmGpus
	EtSyen7EPgBNgysImV8AtiLzAnZsju3YxtzNEsHU3f6XV69iVVTd91Qneu2TbAia7TK2NrN9ja8
	gmNGmuaV3EtL4o+ZzOj0k2Da0qMlhV+8xAnzFNLncuXPm3sgHzeChK7KjVrA/G3nKhbEO/6hHam
	/T5bhg6aBfSCudRHa784bDzB2AdXbPaYOOKgRos
X-Google-Smtp-Source: AGHT+IFsu3BRMvR5OSTmCabfJ1KT16oy9gz+NE3KsW+Be2SzvD8UD2NK+R2Uskc4xVQWQI8YNuuIvQ==
X-Received: by 2002:a17:903:286:b0:276:842a:f9a7 with SMTP id d9443c01a7336-290273a1725mr58419015ad.57.1759949634609;
        Wed, 08 Oct 2025 11:53:54 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034dea083sm4734965ad.24.2025.10.08.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:53:54 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:53:53 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	willemb@google.com, daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: drv-net: update remaining Python init
 files
Message-ID: <aOazQf0BBEJh5O8o@mini-arch>
References: <20251008162503.1403966-1-sdf@fomichev.me>
 <20251008183245.GS3060232@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008183245.GS3060232@horms.kernel.org>

On 10/08, Simon Horman wrote:
> On Wed, Oct 08, 2025 at 09:25:03AM -0700, Stanislav Fomichev wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > 
> > Convert remaining __init__ files similar to what we did in
> > commit b615879dbfea ("selftests: drv-net: make linters happy with our imports")
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Hi Stan,
> 
> Sorry to be the bearer of such news.
> But your SoB line needs to go here as you posted the patch.
> 
> -- 
> pw-bot: changes-requested

Oops :-( No worries, will repost tomorrow!

