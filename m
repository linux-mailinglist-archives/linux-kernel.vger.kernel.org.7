Return-Path: <linux-kernel+bounces-740273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C95B0D219
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506FF1C21E78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC37628A1D0;
	Tue, 22 Jul 2025 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enbUI7IS"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B728A1CC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167126; cv=none; b=FjVqO4w/A6OL42x2o1fX9nhEJG2dHbDQQKiOYb4EKwFmBSrql+E5klb2FdLYVfvNDfZo8ifgK8Y7Hr9xm80JKE+CcpO7jiCm2Hy7cHM35gFOBFMgZ3f9zmzcVu8/eMA3/sJOU7E1iXsI8Xu6fQ7QfP3jAWqhFvcc5iu2Uy+TyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167126; c=relaxed/simple;
	bh=PeWIbC1zji8Rcv82/MombFa1BJRmw7d2fz/ARauiscU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fD1ZxJnQtqMZHIBe+Fj3vXH3H3acJiahLL1M9JAmRVZgjEqoSAujN7NAM6OIsMvZzkt/n92phOc85w48gvSYqduXdYcOHiu6+QMh7VaFtQI4Kk6GkR3z3Stg1xaK1SAmeyug9ykcGK68aOB6kBOAL6tlUOBdoOrZjCkH8BzGJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enbUI7IS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4aba1bc7f44so35447991cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167123; x=1753771923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeWIbC1zji8Rcv82/MombFa1BJRmw7d2fz/ARauiscU=;
        b=enbUI7IS3Pdgii2vPn5xqVAV9iHcIBaXnKm8rDsTZxZmYkOsObKA9Wbx9YgYU5u+uB
         QHbXRHYM4ZDkl74xsJ/ItRDA8z5Esf8vZvQYgl0hImphZxc8HGnv4dhmXOlgryRfMU8e
         Vo5xjCKhokd948J5DnZ79YsdH2hueS8+ngC4yjBoMiUQArUWCgFYmQkvHUisJFmdo9UG
         eb1MdWwcLwblChsl0TTZcC8t4vF0ONHHexnNy/zfLp0+Y5YfroN7AwqJjg2vfs7F7Swb
         ZJbpfkdk+UBXvW4qT+MIUqt7pY+sqc8tPONwm3fz8+bFrXOXSrCiLxW0BiYu6bMYOtVh
         ExUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167123; x=1753771923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeWIbC1zji8Rcv82/MombFa1BJRmw7d2fz/ARauiscU=;
        b=CV9/jpcSZPO318m5N4Bd/3SJ6g4wXKhLZOKnLT69kELTr6VSXw12spBuxGpTFTdOc7
         UI1wXsX+4jF63cueUeVlrqE0ZWSuaoD2OXAxIch/qmoahkAvsJl0ZkWrTM/CCeXwMG2Z
         73ZQDoYjNTd7k+1fzlDQ1iq+w6O65DMEgUcodEr/2w9GTgiMFVi/540RI7reZsaxPP/R
         mruRGtFaRENvjsaQGDkWqhD4vSRp3HRgnWrglwScS/RBS9dt2C6LwLhznO+JEXhynDmi
         xeesSNoH29n4g81geLR0JPhLN0RHSmcPsImbqWhUlsjdoRWiDhlfA+zSKfnCKSTfpOqK
         DQnw==
X-Forwarded-Encrypted: i=1; AJvYcCUd5J3AwD2YB2OY/2Mt2wnACSCuAAGQKL831TrFvNwKrgVk/ibWhbSndrtBWQirOdo64Jt93lpv0Qnpeok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDcPg2KjIe9woXdazVp30kRDhb99m6DIufTCRbiZF/mIA75sk
	9heYnNbrYb7d/gcwudlGjmuG1NSV05D/TYf4MCAr2FqJBX2r4cdervEJItgjNtFC7yxcWY3Q+Py
	K4wtcNWsvc1lO/Apk9pNj98Si6bWL2vGnDfMr6vBK
X-Gm-Gg: ASbGncv8XXvxBRFvkTOg1e0YDmX/wSycpz5VVRmlY56b36Cyqy+Ft4UVwdeFGeHQORM
	BowQcUgzc6HL6u57/CxUXElfm1x8fi0oycHGC7usHPqTQ6TFwV5rfo5XyoKc4wWobbSjSBGUpqp
	UeKvY95dXmWU+zHQOhjM3sWE3C/2m5o4gQmWiogGo3v8PFkR3wFQ6vmBDSJHNatHfa3vtv4gjXO
	mr5kg==
X-Google-Smtp-Source: AGHT+IHQtTROmOPjtYKNp3LrKieED28s9Ihtni6NoFl6cfc5Sc0h1mgzJXsDX15qgWH4HGDMdRBDDSThTKbNVJHA4jg=
X-Received: by 2002:a05:622a:114f:b0:49a:4fc0:56ff with SMTP id
 d75a77b69052e-4ae5b7e22bdmr37705791cf.12.1753167123226; Mon, 21 Jul 2025
 23:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 23:51:51 -0700
X-Gm-Features: Ac12FXz4iUeeGipOp3D_tB6KFKYfqAFLlbaMGXZvPSx57DSINr_rpmIyL81k98Y
Message-ID: <CANn89iJLnprFvLpRpJ7_br5EiyCF0xqcMM7seUVQNAfroc4Taw@mail.gmail.com>
Subject: Re: [PATCH net] net: core: Fix the loop in default_device_exit_net()
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, davem@davemloft.net, 
	sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, #@linux.microsoft.com, 5.4+@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:21=E2=80=AFPM Haiyang Zhang
<haiyangz@linux.microsoft.com> wrote:
>
> From: Haiyang Zhang <haiyangz@microsoft.com>
>
> The loop in default_device_exit_net() won't be able to properly detect th=
e
> head then stop, and will hit NULL pointer, when a driver, like hv_netvsc,
> automatically moves the slave device together with the master device.
>
> To fix this, add a helper function to return the first migratable netdev
> correctly, no matter one or two devices were removed from this net's list
> in the last iteration.
>
> Cc: stable@vger.kernel.org # 5.4+

We (network maintainers) prefer a Fixes: tag, so that we can look at
the blamed patch, rather than trusting your '5.4' hint.

Without a Fixes tag, you are forcing each reviewer to do the
archeology work, and possibly completely miss your point.

