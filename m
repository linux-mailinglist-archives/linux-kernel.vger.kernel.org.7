Return-Path: <linux-kernel+bounces-889991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D9C3F04F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5676E34A7D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB92D6E66;
	Fri,  7 Nov 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RNVk9hII"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB78270ED2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505253; cv=none; b=qrSKS/yEiGt+auwTi5/FaK2km270gJOkQ6PA/tOdQXvIjj8kOaQ/wgaPN1ubefuxct6eeNC6Ap0pEexjQ80Fuknukv0kDzggFdaAQMFF1xzEk1yNG3qblluuzin0KN7OdvowJo52aRmTP2vDyqoz/h23C8vob2aBOXB8QGF5aVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505253; c=relaxed/simple;
	bh=ublKY7ieyOw41ofqwSkgdz7bMYK56Ys0iSJ2bpALiV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1HFoEdjGb0adwZd0yQ9aupFvm4/JyKseOaG3ilB5wajEcs4gk9hhan7cjJEIkPrJuJPyOLMegzDVASKJqer7Re/z7gIinz8JKydRG5vaGKgLwRn5eM9NwxfBkH9mETs+BFjWNTnaunyMr1XIfxRLJZF4LW9JID5SEJJAyVkIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RNVk9hII; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5943b7bdc37so471313e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762505250; x=1763110050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7vrmwe4LSTSS8GlaryaFh4epBJZEr6110KU+wNfXpU=;
        b=RNVk9hIIimV2G7neK5BHU/2xr9KigcpHOA616k1wImAQdyyyde0eZOmrvFgLzZlyPL
         FtNnQEJGvolKU0K122Z2+zGje8OZqQlZvGXlewKOrj+Tt5lQ5kkao17gjJ/YgJ3qlXQv
         p5LsIPGQKj+HUlCY/0RoehICsnl7aY8+RgWX5kcBUzNEmm5hp06STS55NUuHE5aUnfYV
         etIHWjQ4i4vvAVvcKkVeO1cYDLeSH7sWOSKu5PxX7cBqIFlgiEj35/TwJNDxxSMfFKD8
         N5I6DmepjgssRS/HcqEQmw2dwSftDN7339FxB/2Y3VsaHWTNiJq2OwJXFu/DApQw4kGt
         aBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762505250; x=1763110050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7vrmwe4LSTSS8GlaryaFh4epBJZEr6110KU+wNfXpU=;
        b=WRPFew+RNXTI80R5C6M2xDaQCSkMf/ObNBKGlXhq8zAWQt3rWZmw9N98NCzF0YyJWo
         NOIxUPk9fxPpUDTMCsIKxnVqDfp5cNvlrTZhvXsFcRXICkJ7J07WeHEstfHVU/wg63Ga
         7D+cozz3lGb+YzczOyWfMD5b9yudHLgPShQ27nPvK1LwzlErnQJLYxkCxxCVKJ5vCCb9
         O03lhNXZYlzrLnZVGmgJDBUWK5kIvS9f1dl3iyUZTRa1Ag42qLqSrQkDpJ6bAW1xwTeM
         rcuHDvefRcR7W+0e7ynfkq0vC+GVy7LPj+ds88D7XdAyaNE/kshFL2pYaPz0Syn+i9Xm
         ybkQ==
X-Gm-Message-State: AOJu0YyBPl5e2thR2LeUnLbD/Yi2FpvQfIsbWbLKbN9+wqHDUbwgJe73
	e7lVdybXZ8Zipssvuh6T5SbE53djydigHFAyvGSmeZIp08s22UPzmVyWCYw6DZeNX+toahpstMB
	BvPb0EELoyoZ1YExVVvjxkZH+hxbl++c+yFfI4vfRjw==
X-Gm-Gg: ASbGnctUi7ZXloIKpRITgj8UGQmSmwwxh3FEAj+1wYwqyoVnhURud6kc4jkgz/GuXyO
	sJwKB77UVUoAhGFP7m1KfEqWREpwCauVBCRvBh7RAEmCt2YsTUHjObkeg+LEbm+tPuczoD9q2ez
	DA34nakF3PajTQ6JDpMc87xGFzT4fMIjPlqI2YPtrFAPX7WYmpU9dMcE/pU4T7bExpRavIaLFx1
	20YLchFWSv/9onfq4YJaS0/98r4sTnHTa7C2utYF2PFwDTK5XUKZvcUBwhlvemGXokRQvioymYX
	4Km+bvJylDFF7Qh32w==
X-Google-Smtp-Source: AGHT+IGHcW6D12RuQkvVlZ93mZKEL74Ac/7abeDYsY20QsLXLzM0cSDomTyS9S7QNoeKgyYaLzMREB159O5aLkokPbA=
X-Received: by 2002:a05:6512:a8e:b0:594:524d:d966 with SMTP id
 2adb3069b0e04-594599dd8d7mr322059e87.21.1762505249622; Fri, 07 Nov 2025
 00:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106160813.314932-1-marco.crivellari@suse.com> <176250512811.632228.18184423075799177449.b4-ty@kernel.org>
In-Reply-To: <176250512811.632228.18184423075799177449.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 7 Nov 2025 09:47:18 +0100
X-Gm-Features: AWmQ_bnPlBAxmTBQR01L88565Agut7H1xshN4PnnoPQNpt7aCKHFwxk5YJksC90
Message-ID: <CAAofZF5FWCgWmC+B+Z-1CbRchn1LS3evP880O8AYEF2L4_P9xw@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-sff: add WQ_PERCPU to alloc_workqueue users
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 9:45=E2=80=AFAM Niklas Cassel <cassel@kernel.org> wr=
ote:
>[...]
> Applied to libata/linux.git (for-6.19), thanks!
>
> [1/1] ata: libata-sff: add WQ_PERCPU to alloc_workqueue users
>       https://git.kernel.org/libata/linux/c/13f4d995
>
> Kind regards,
> Niklas
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

