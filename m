Return-Path: <linux-kernel+bounces-820798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD3B7F3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B4F482C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF3A275B1F;
	Wed, 17 Sep 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="afT0B43C"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F161AA1F4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115409; cv=none; b=VjPg2v2STdvqzH648hNGY3fYDsx0scYr7nfbOMMi3PzWeTzV402ykDS2Cvm57/2VEZMRJjjkd8lvUatwoL+LSnysLbQPBOvTN6IjVDvDk70fZ/qGA92RxEKUoDI8X1oRBdv8D/VrKuizyesLv1QF1eXBA9YjvSEZrvsuQMsiTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115409; c=relaxed/simple;
	bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUPq9I9BtOQY0/JvJB/XVyun3WLIsbryQY3y15fxK0RRxVQOUKakFo3qUt77P3+6OZhSG4ZBr66A2UsRRIsV/jV5H3k9a1RAqRGH0okT11CVvprNqxlxCIlO6sdKKRUKuglW6Eoyman3A0CiUoDzXkXYkbYU3oTl8KnDyVcKpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=afT0B43C; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so9608455a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758115406; x=1758720206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
        b=afT0B43CvjU8mP41nVb7aQ4/cWPF8eoH5vQ2co/TkR8VIt5m2LJr1KcxXLc7y9A9lz
         xULcQEjfwW/IE0p0nE+FooBcuWtKoWqw11cUtfZHGQf8MZbui4Vm0lRNoKzMRHEdC8Md
         IgBTPi0tXqSkSEcoHy4nBWDHhesEk3SdvZg015+EFZyn/ErE4lkQYlet0E/ACXdyiZse
         82uKO3P88/Yvk6DX4UCScmcZIZpQEZdMhTlXtxUNHE+Hw7+s4upz6v/KPzgfq0AgG85C
         Dnq1aywf5AJy9ZxA7CcPFJT+egOYj5ZAzKB8AC71bO6CjeDQdVgMOKvXbs6mSpHY/3tg
         JQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115406; x=1758720206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8hEEtaxcoIdOX6D0RxrN9/EkrrMmofUHUb4qqWKI7E=;
        b=Lu0w1bJeKhWOZQFC1Skyzki+0RGyxAAioWnd+5NpMZiu9Kbc2hn51vP/Mqiv2DXkUf
         R46HR/dHw36tyQzTUJcYZQx4qg1zjiwdnVvnXT1AoBlxLHZHXph+E2bhQhSqZyiDc7ID
         9fGIXJ/FNtLZDoiFOLoBsOhTtPqIrcloSHx0ScjStO+7ZODoO39QAt4a54EH3wiwPNQ5
         GjQdQvslD95gCt1QUcnGKQZ/GPxYLbzPeImn0VDEdP5MMGsOf7MpNPuPHz9FfxX0ZbSc
         VocOzT88qp1Tkn165fM8/R6FpAgPwZ4ssB3IpkxPC1z5CxYHpFX4GKfwWpfYvZzdLSK9
         gKjA==
X-Forwarded-Encrypted: i=1; AJvYcCVvUyrkEnJMGCFHZ+XKfVJKOZGXZepFGS0//FaV8lPB3Q38gO5SXM0F8MSvHxfHI4gEq1z3uCq1QqDvN+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZndRZMZGYHwZWc+rZoqYOXxdIVRmMeggrF+L2Sw/Baypst92T
	9Iw94IH9oAi8xI2OzjwjUaRcl1bCzutiPpa4q8tBVJbx61DeqD6Qx7Jw62h9bqXX8eeYsO2aC7f
	3eowuZSQSJSDmGJfFAzx2W35pNLeNZMdBAZN2QJKMNtRjTCl9QEQ1+H8=
X-Gm-Gg: ASbGncu53mKld8ySodv5aThYb9fLBMKckP20U0U0HA5yadPcKY02qtYJfmDK97sDSlj
	W/qlhIOjq5NHvk0yLPUUzWbd8sV4PTbnh3VeH/6EATxZuRz9S2JnO4LRhglMKWFIT3iWpVn3hfz
	hlmp1J1LJ7LyZlPX3teiMKXSCfksQCfbFSXIOpWqmRFXyfBueF0UzxbFH4ZWXkNHdVrJU9wPzaK
	JkA7IYl8guIdF9Xw4INlz8NkBPhVtFEZOMvyLKXCpkdc+k=
X-Google-Smtp-Source: AGHT+IEgewShkTB3IO6iy5D1trv7nKdXbV9WtwtBpgyTEh9TZKuca5Qb4ed3HJ87AvQ3ZW2yo7J0WCyjmW8j05mLxIk=
X-Received: by 2002:a17:906:7309:b0:b04:5200:5ebe with SMTP id
 a640c23a62f3a-b1bc1ed67femr266992466b.54.1758115405633; Wed, 17 Sep 2025
 06:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 15:23:14 +0200
X-Gm-Features: AS18NWBL5l4pIlkCFqkI5FbYZctT10PlbPlrGgAIhMPZCsLLpTd8MK5AI9j4JqQ
Message-ID: <CAKPOu+_EMyw-90fvNXXRHFpbi8FDc=fd1kGs21iE9+M4ZZSWeQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> Given that this is a reliability fix I would forego optimizations of the =
sort.

Thanks, good catch - I guess I was trying to be too clever. I'll
remove the "n" parameter and just do atomic_add_unless(), like btrfs
does. That makes sure 0 is never hit by my own code.

