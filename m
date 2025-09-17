Return-Path: <linux-kernel+bounces-821031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31098B8026D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD131889469
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0923E2F4A07;
	Wed, 17 Sep 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJlr4ay0"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF22F3C39
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120027; cv=none; b=metHyt0HeWdeqt3Avyr7yrmdQOb83VpGv4XBBxsngQoAU2Ep2FVGC/0SyGTnvMSAo/rEercWhr/v+8AcxbudtkmrgYQGvQUijp7rv4bIaNYxCF3IlqTJOl7z+f2dO2O4glKrIENkR4NFgOlta7Pp6jp5+Oa+wq+iopGSvSz0hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120027; c=relaxed/simple;
	bh=eK5I0FXdGi22EZiC1nWona0mCu3fJMZ3aNkjHWYqN8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IhmDa50FGeUHh79kh99keGJc37W9tqjI+Eetl7UblkFF0vjppOoHrysjzwXlMK9E6TWqqqCf5blbYxPR8UsITuu4H/b1no8T+VBL5AFWYgiFYrfRA5bamimHvQY7GrQSEHYmxy1wra7kaiEMM7dejiw2djqxXTnItrdHnPefxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJlr4ay0; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74572fb94b3so5113698a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758120025; x=1758724825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eK5I0FXdGi22EZiC1nWona0mCu3fJMZ3aNkjHWYqN8A=;
        b=LJlr4ay06ECm4nkSjq0+SOjLx9vUQyeWZZUHO6ImtRMcYYp1y6H43siDFuOg0gktRE
         MPe3y+oHofr8zuWrjoFjxkBAldLY10K6Yzc4HLdJgLOxQnXzd61zm62miGuZQDzV5cL/
         9etQxKlMKcGXgSAo80kHFWxNkG3QaFndZhxkCNoYl0KSnHD1LfEBwdsPZwxp7J8QUL2m
         2xpiOvywuoOYy+NnPhvItHgaGlbN/mKtEw0UL3EvxAx3AzFMT+0wnDeYLVJIPAgi/KDC
         IPwSx50u676ACe36OuQdTZMtI0HfMMtVYqZnWKYcyie5RLrCrFxZX6Asf5PQ9oqzuvMY
         DmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120025; x=1758724825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eK5I0FXdGi22EZiC1nWona0mCu3fJMZ3aNkjHWYqN8A=;
        b=uRkjPJdqnREkHWFAUS+hJyDUWWsu+gkdxx+3PPJwdeGUsmJVno1izhTGVaCGVqtuUD
         uHD5jAvajRrT/Gc1jgJSJpIfy7eV8wqdAQOBK6mhPYVsmdGq/NIZEReWEeJtqUj73IPH
         xt4lmOWt/M7t3uNdYAIQJPsCxrLJTbQfQ/rHl5/4CQj3RZTLX5cHZFolMw8rDnwK9clz
         v4gCF+aiUT782njBIfmF1fcJpAqFD9uCVrmwVeOlkOcKHNdeZ1RzH0WLm3xicyePfBHm
         dLrfPtGa2j0y6XpAcAa2yRoTLXSCsELOKX4epNFUJeKqK6iAp3Mu9X3PevNs2F2tUELq
         i1ag==
X-Forwarded-Encrypted: i=1; AJvYcCXFQyhD9tTu9b7gCPYcj36hHszkpZGYT8o6Ig/sxOp/UawfzrQ5OB5StIOpIZuaNrVS5Xc6jaVcuhvx7Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6m1Eni3cAIcHzW73gyfP1hq6GrYvygA9agiCUlpY6DSQ/WLW
	xXuiRAIQs2qcRFIp4t5kNQa+6VOY1L713NIEAV3NB9djQUT6iM31uj/juHudKejxmVs0yw==
X-Gm-Gg: ASbGnctyEDd7XeAD4yv83XQltRybj0SA0LVEVDsWUWIqmwtObz/hXCeYXNaYdv88oV1
	z3j62nVmS3nHGr7s4RNMyHub6k+kRkrm5PISgsQEklCbZV/zLuPNfsrOe2UTO0Eq5XxglewBZbr
	YvPp1Dbkd5JPaLsgwBZDLXTkqH7aHGo29BC5ycFLFsjDee77rhObwOpCOqgar7gJn0ud6KtSzse
	mEFBj5Cz8FmS6mO4o4m4BFLP/yhn5WaWV9LjofdVQUBj1Lo9tYzbFo8ZJU4Fdj3KvjodCyX0ykA
	hs/QkyV7kYBhEiq7JWNlFeJvNJCpl1poMOB6L/CWHFolrwpeQ70JUUMC+X+MWqzi0vJlZ5P+O08
	roxOBy5+erE+5PCi1S2Rz1uBhJGFbzOQ5xaNMYnEZCtoIPrurZsOExPynvpYb+JkNGiZ7CSBclq
	odxAzXhMBnax5g5+sPWwk8+FL8kXn8FpZczkQ=
X-Google-Smtp-Source: AGHT+IFuoZQvqnwPXo5d6wnHV1ZaiWFbmg5Q2lv6uwuvzfmGXwFkkmE+hWJ3iTKF8TqLazP+Spi/Ig==
X-Received: by 2002:a05:6830:6f4c:b0:745:49ef:d74a with SMTP id 46e09a7af769-7632644afc4mr1151794a34.26.1758120024839;
        Wed, 17 Sep 2025 07:40:24 -0700 (PDT)
Received: from [10.0.11.20] (57-132-132-155.dyn.grandenetworks.net. [57.132.132.155])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524c260735sm5317009a34.39.2025.09.17.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:40:24 -0700 (PDT)
Message-ID: <d994dd8855c3977190b23acbe643c536deb3af71.camel@gmail.com>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
From: brian.scott.sampson@gmail.com
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: christian@heusel.eu, davem@davemloft.net, difrost.kernel@gmail.com, 
	dnaim@cachyos.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com, 	netdev@vger.kernel.org, pabeni@redhat.com,
 regressions@lists.linux.dev
Date: Wed, 17 Sep 2025 09:40:22 -0500
In-Reply-To: <20250917013352.722151-1-kuniyu@google.com>
References: <c36676c1640cefad7f8066a98be9b9e99d233bef.camel@gmail.com>
	 <20250917013352.722151-1-kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Could you test it with this diff and see if 2 or 3 splats are logged
> in dmesg ?=C2=A0 and in that case, please share the stack traces.
>=20
> I expect this won't trigger the black screen and you can check dmesg
> after resume.
>=20
> Thanks!
>=20
>=20
Good morning/afternoon. Applied this patch to the latest mainline, but
still see the black screen upon trying to resume after suspend. The
keyboard looks to be unresponsive, as trying to switch to a tty
terminal or back doesn't result in anything happening(as well as
numlock/caps not being responsive either). I also tried using the power
button, as well as closing/reopening the laptop lid to see if I could
trigger resume.=C2=A0

Checked the systemd journal just in case, but no splats or anything
else is recorded after the suspend. Finally, attempted following dmesg
with -Wh to a text file before suspending, but that also doesn't record
any new input after the suspend.

