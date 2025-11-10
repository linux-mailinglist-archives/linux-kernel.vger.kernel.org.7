Return-Path: <linux-kernel+bounces-892896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D208C46109
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C3A3B90F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1D4305E27;
	Mon, 10 Nov 2025 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cU5KlekL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD69211A14
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771898; cv=none; b=OPVzmWVOIq8P3GXzhmAcuwgpCf8sxgp7Xb1UZgpA1HEQ9SfxR61KkXKvHv0w4kBmjei7yLJIyRzUV/BaMjzqatw/NUUwBDYKHjY8doxtFvgvaSz1y9CS2PFBLa5hsQhpw5NW3tv4WacVJ7XwQidikabYg8wkbJ2Dofz2KhflLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771898; c=relaxed/simple;
	bh=sV8cROs3dFOC6pjCX5PL2NJwZ3NP1xrJN8UDmNflI8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV8rwhc1uVtHvolNSz3T793FPypWNfwq1cq0kmti/byaY7N+AjYObg7ULtuHPe//Nh8KbiLr08xh2jkq51dJa1Yrtk0FzVoQYH31SDMNtyigyrEmZkX0IrJYImUSWlYfVRZDB4hieKbL9toa1+uWvaiEGO0OgQ6AVkCKNvAW08I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cU5KlekL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-586883eb9fbso2808787e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762771894; x=1763376694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3nSyx7sHEHeDeu7LgYEFiB0vbj1RV28VjEOVhrx7z8=;
        b=cU5KlekLQWeHbHVY5EazKftYRjhWKrax0JxwTsgySCGeAjJnnfy/a9EDXZme86RWsS
         DDZSMcONgBLMOrSk2U9bPqKfsUxULIKY+2LTpcelxaYuOYHr8kpoXHs4qyV3gojqeEwj
         /k25nHseOfm1yYPEXJBPDob4WwxgnCPPP0HxHLWzNJYBnoNuc9ckeK/xmVQ0/TdmDU97
         kRssIahkUIZvJCxGPBKnKL75NX2qKZ8eNGVnS5gEsCOO3OmBPOdkqId5y2TAYOSyAgDD
         QMjShlVhlC4apb+5wSMejViUdiIcBG8s4khdjOrPExKQdAAubQdeXKz0S4t5x7v5vJED
         EF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771894; x=1763376694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3nSyx7sHEHeDeu7LgYEFiB0vbj1RV28VjEOVhrx7z8=;
        b=NYICpTno038QoBYk/rRUSo5KN4G6ksJCu20hCcbmGSf6CXrVyl5BL9b+HRFa4TyqaH
         2kFx48Lx+l6bVvMeoQOPweUD82XDavGSd7ktyEJWCr9EJMUkjnKZIpQOqAy5U4AO4T6C
         UBGiQ8FGK/bME1DADfRgYN7ghnKQ9HqDvZxrY91F3q0HUstsGIZG4/Vfc0wPkCp0CfSN
         lLOgykkBIt+UdcMmFhEVopqXemkE/s3eZIgAnFqQy/1nFGRzHYrZ4dTIoMaAyQudQc8B
         S1hCjUf0w6dL+vpbFUBJTNkdAHyRb5SBnQ0osQMirXuZrHplwqdKMzgUKhrcTdconJr1
         HsOw==
X-Gm-Message-State: AOJu0YwHb5MC5R2WeWNrslSYicaEjCpsTIDucDrWNZSWcV/gLtTUr4aC
	YGHjQj24Aso66vZp/Um5AnIBsBSLWekU2p2/OPGOxAI55StP6uuMjvJXytbaHAJhO9BnYzYZZ30
	WjCBdf/2hxus+E0kfAXOkBeYygYQdPos8Vu7MCY+TDQ==
X-Gm-Gg: ASbGncvhtvDCYCq2DIKuxWcw0yE+TD2GZFzXAfkvXscnzpFEUexz/VIZvrDLo1Noroa
	owHwEhh58K4bApHmX1NzSOCc3phHoz6J/bKqz9iNSHO4iq5MFOqpCV56RNd9s+Rm1VAFl78aQXm
	ssCmizMJisTe3BnpO3tt5gBmOyWIPtY3sbn2hD/8wIOvzQ+37gCT/AWhOi35S1e4ukexM+YGO46
	9pUUbAcV+jm7vBsXS99Hb9yCINXyBe2mJe/ddwGS+k8WrrXdA9swj+zidQHQRQbG6bnoBbAP9LQ
	t2jwceWQdkFoXjUXWD00she4GyML
X-Google-Smtp-Source: AGHT+IHVTxNZg9Iea46RFVb+GORMLRps5peJQgiMFx4r9xzzIy/O3W2vJG4Z14WApk/wO+ZVzi5LspbnzJr6l7WI5dI=
X-Received: by 2002:a05:6512:108d:b0:578:f613:ed9c with SMTP id
 2adb3069b0e04-5945f1cb2f9mr1931017e87.43.1762771894136; Mon, 10 Nov 2025
 02:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106163341.336989-1-marco.crivellari@suse.com> <atnzuecdwp77svypw76e5z5occyh4tkswfc7rg4yqh4joeh7fn@ayygwyjdpe7x>
In-Reply-To: <atnzuecdwp77svypw76e5z5occyh4tkswfc7rg4yqh4joeh7fn@ayygwyjdpe7x>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 11:51:23 +0100
X-Gm-Features: AWmQ_bkcdXSQHUYUpXYWbrqofEomSBTPQr7krtEx6F2AVUGd0pGtyz4_3n0RhQg
Message-ID: <CAAofZF4gSgeY7_qkHG4n375eqHhpkoZTmJu9=p2_k=qwUR3vEg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: add WQ_PERCPU to alloc_workqueue users
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:49=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
> [...]
> Updated subject to:
>
>     cpufreq: tegra194: add WQ_PERCPU to alloc_workqueue users
>
> Applied. Thanks.

Many thanks, Viresh!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

