Return-Path: <linux-kernel+bounces-886989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9C1C37045
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EB71500825
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E2335577;
	Wed,  5 Nov 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YUpK/AYB"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEB3126D6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361886; cv=none; b=dnp/iursQNLIPadXTwaH7IuletbTLVHhCI+ARWz24Sz6D5evCL2NK91pTloC69UeANuCDkSU2oQUc2yVoYJc3qe31QIfCKXZ1Ve5ZS0v35RdoOEADiIwPoEzvR6uUykaIhLUA8+mwmTEw+Yg13XjT/WHAqvL63AI5zc1wn1ZLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361886; c=relaxed/simple;
	bh=k0kswwtFFLMQwItdDI6fP/GylIm/8zXf55b1hDeZRw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOcSQve0G+v05AIOO/2EyDzm47qGWffkMyIHacHtialojtiuh+iN12ct6bzeM9pAlYlFnszDNKPwf0oxnTWVuwp2N+ccdcCjFxWcPkFhsg2KP82xafSG5csQip83Z3dQbzp0TNeWlzmctaPaa1zKVJgojHBO0ozS4GXHxx0Hh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YUpK/AYB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592ee9a16adso45639e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762361883; x=1762966683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0kswwtFFLMQwItdDI6fP/GylIm/8zXf55b1hDeZRw0=;
        b=YUpK/AYB0il/ouK2xKHy550/uhax+3jzDMZ+zf5LLeLmebtPiAqZQ9AIUv3hRt0fjO
         6tYGziJWkiOaEvXkI6rk2Jin2S+g31CLfsz9vSaHpr0JVwGicpyosJ3KU5fjKjKwJR3t
         xr4bgJKmCLpyDJfMQn27f1lF0jNgNRkuS49x/38IOvJjQfh8p/KZih4+bwctHj2AwSmM
         /I4zKTTaN2BeLZQffGhHcqpIO4HkKSTdQYYyVHB9D+g6iarlDUnX23ItMK1sioCayN61
         ePx9FqQpH5kiSwdTqDkAbRJFzFcHUn0qW4Tb9an3GmOoOhvabnQg1CA3wrblCfwsYxX3
         KA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361883; x=1762966683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0kswwtFFLMQwItdDI6fP/GylIm/8zXf55b1hDeZRw0=;
        b=VfsuvLhKHAO+EClH3QLMSShxFeZjx3D/dfRq+pezmEQ+KTWGoxIBdNJc6eU16NdkdE
         q/6IGNzGC9SJYaBPdVc5nsIFPxvtk74G7pyc1bPWQVNbgxLsWutW4jGJoUeA0H1wE0rF
         aqNgc6d4+vFoDtXxF/qrKDwqNzvuEM512Pa3oL+9BKIn5aZJQCRTyH/8Ztpv45cTzOZI
         AsPtH2gIQSCzKfAsYS8ZMwBYHByGMHjH+00cmHBSPJXJnay7JDtSGUnShqLl7WgpY7Vh
         XXQ0a2rMpDtOh0JnIVnmaxPtFRWZ3bgTqZXrivrSg9HNv8hlvu9qf3hCZhTdN85oGQVt
         E8Tg==
X-Gm-Message-State: AOJu0YwJhCvmwntfKWQMavwPEAz5WZKDeU57Tq+zcf91SofHDZ53d2R5
	aGcO2NRlrPKFG32xjx1/GbswdDfxF1pB92rrL4sOwsAp53mAs9Ai1HRNeC2eqLkj6tLzZyQ2W2Y
	hAeCY0lwlaULAenHeneE3Hr/cPGmVrJ9TqLgVB/SRDg==
X-Gm-Gg: ASbGncvNH4PLXgvA4MnAaE/AmvBOuOhDVjD7qLdKGQagqkGEQcUmyG6JFjmjQwW7tNX
	d2bfbm0u4+rLOfK8M/rOtd0dEmIV+GxypqFczAqQQO2sIxID+PsHsE1Dw+iHKpRKzvBmi0pQ8Sx
	gO4CwrqiNhqjQal2nB7QfYYf9c7Su8CgCqksaz/MQMOPyeNPdWHA9+aGgMnOcsbzurLthsYHaZy
	AvzHTCVq2a7TQQqT6J7FVmSUqwEmM05YrNkKgCRymKeHau2KH5d7Y28twLIVt0EDz4PQIijqQbn
	dLpyJ0deVgzzjsxAUg==
X-Google-Smtp-Source: AGHT+IEbajNhLyx4OclEpgveavddkCJyzDFuSKPayXUv5HrcP0Ttgpfw/5OasQjsGSJEH566J8a2l9RFS0hRmNzBmV8=
X-Received: by 2002:a05:6512:1395:b0:592:f8aa:c06 with SMTP id
 2adb3069b0e04-5943d7f3f74mr1428209e87.57.1762361882755; Wed, 05 Nov 2025
 08:58:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105162024.314040-1-marco.crivellari@suse.com> <aQt6pofw-Ub-lEbZ@finisterre.sirena.org.uk>
In-Reply-To: <aQt6pofw-Ub-lEbZ@finisterre.sirena.org.uk>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 5 Nov 2025 17:57:51 +0100
X-Gm-Features: AWmQ_bm65Nkx6JwxSMmCDSNIfHVG830zuwCEWuDMhGyKtUILD99Dho27AM5PKh4
Message-ID: <CAAofZF5S=EWc=GS5LXvw25iZBoe7p-c9o4+YvqXjJ7_wR7VjGw@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcomm-labibb: replace use of system_wq with system_percpu_wq
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Nov 5, 2025 at 5:26=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>[...]
> As with the ASoC stuff I'm really not convinced that this driver cares
> about this being per CPU so we'd be better off just using the unbound
> workqueue.

Sure, I will send the v2 changing this with system_dfl_wq, same for
the other patch.

Thank you!


--

Marco Crivellari

L3 Support Engineer, Technology & Product

