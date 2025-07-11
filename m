Return-Path: <linux-kernel+bounces-728173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D72B0242D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B16A47989
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075C2D12F6;
	Fri, 11 Jul 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="akjxkGsS"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7B1DE2CC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260076; cv=none; b=JGhMBHu2vBh1riJRXD/YBGGKy3+9rS9g1U0Qkpa9zOnUteRChuHPI1Y3Vz3W9FXRRyaVQUPoScTO1KMfGfivCl4w7AHKo8M/G/L8THScYyKQ3mQbu9R1KjoZND61/v5ihFow8YsHtAuZGxn0tfVN5IVUC3KUIcR8aJt9Zy0r9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260076; c=relaxed/simple;
	bh=NK5BNgE/WS+Rnbr3Oglk6axm+5znEKQ09/LeulVtaY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFmpSYVzySMbqbk3itRYm61NAa9K8HKqwRV+fLgQZCGlTaYo4PujwJKCy5DKjG1GBw95CaxedRjM6mQ6qI0NErSJq+Mij4SCgvo7STLVohcwm5T1cQ4rtc43patl4xpwi7lhJz6pkSZQNytcwPv4YJzdP0zPTiAU9p4yMdxaV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=akjxkGsS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so4016754a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752260072; x=1752864872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h8DF3TN4LDXw2ml6xO8e2jD+Euu91yv1fKkxI9RSJ/c=;
        b=akjxkGsSmHAdd61yv4oP1c5FcdD8W0gyvkoQUR7mJUgz7Qmx4pULHpfRnAaQdnTVbe
         7W6ZqFn8U+zRYidl+t/F2hPuNdEF1c0S6qa0S9mxWO8xQ5sPi9dtTfXHsx/qcJU7Os6q
         n8MbsHF9h2yOsd0zmQr4zaS29EytveAp1pOM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752260072; x=1752864872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8DF3TN4LDXw2ml6xO8e2jD+Euu91yv1fKkxI9RSJ/c=;
        b=npIeNgofo4rnr/uY0uxRlRFXQOlXrZzQRJb+2s+pXCuLs1z/nFuUFX1H5AracnyyqO
         wsuqF7IuUftJ3iO7Z9fXJVkLj81O2cxHxNlPPv94XfIc7cqaWnNAsvA+79Iw750PqG+3
         pqR3biw2tW36srX88E/3TPpTFYGozooD0C3tSYZDO+AQx9acNmWi4+NR93EohSHlvC5F
         UeyEF5Vpb7fbQGBJVxjh+l2HPzcI//efWLqZb/MbG4X2Lmr14W8Bd0F7xjUGWTK8aGyU
         9VxznUEU4bNwxWnFbUVZRlenaao+H3O+kzXnsbeQNF/rKA3WJsG4C0Uu9qP7ZtC3neYk
         OwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJhUTv5ETEDWtNa8RIQLqABhDOXjHSuD5/qqj+/ST0HZKE1XrXV9By0nwEK+m3snCBLTpCbGyqDg+SeGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKcLg4z5y4IswO0iXTkq8ObrlNs9h+aE5GTYbEl5oj3JZXZFN
	mehND2jnFv4Dt5oj5M/TPUx/daRnEL+/FnTRyc+JDTAAmrGUdxE1UnMDFKsOS8CcwU7PSQmHuYa
	/n/s0lvrtyQ==
X-Gm-Gg: ASbGnctIq7ERpA6iHqQ7zLpcSj/MVu3iFNOFp/FgoUZV5piXP4pvg3CBiB1yLHNWIeZ
	VnMwjmjgawHKPyMH6yTsoFYF1PTqA03VLvmlASoHjEMH/8HlSXf3ChacMqVuH90FKCceXH8+/A/
	ErBBP0Y3T5dwrl6XsXCWpw6KB2OmMN+SEUO29ZabmvVeRsk9BbRG4+MQbJqEQltzpCfZ55ExuNf
	1zMAJFcsmUFUNrhkQVfDnuh46ug3iyg5eo+ZtWbag+u9sdTftS0VrGfC/igXr//5hMYkY4ts4u9
	WW3VUuFUHMgYYzQFKjnpG5fd0gNvPa39p/T0hAmJSZOk5/vFtHYWq93rN2G0eAY3hfQtCCJ89+q
	vR8qtPGe07fHJAn1iT792R+W3pbg9gRFraO11BXLnGVFvES9taecWUK+L5n7aV5BoG80PInBI
X-Google-Smtp-Source: AGHT+IHFxRrBmgO4e/XN0dedLInfG66Nrvqa183IwApEngvPvlVCdCSWVTsWnroRQEdaIp/yAN8IEA==
X-Received: by 2002:a05:6402:5187:b0:607:35d8:4cf8 with SMTP id 4fb4d7f45d1cf-611e76383a7mr3880474a12.11.1752260072026;
        Fri, 11 Jul 2025 11:54:32 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c95256d0sm2545019a12.24.2025.07.11.11.54.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 11:54:31 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so3979563a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:54:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0Pn2TuI/XI731q0/9AgsZ/SVytNRoS2/tzhakQZwDIg95s2wQXtkNuCLy/4HSJ4nqwadtPLs6AGFm3y4=@vger.kernel.org
X-Received: by 2002:a05:6402:909:b0:609:9115:60f8 with SMTP id
 4fb4d7f45d1cf-611e847f9e0mr3480426a12.21.1752260070618; Fri, 11 Jul 2025
 11:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711151002.3228710-1-kuba@kernel.org> <CAHk-=wj1Y3LfREoHvT4baucVJ5jvy0cMydcPVQNXhprdhuE2AA@mail.gmail.com>
 <20250711114642.2664f28a@kernel.org>
In-Reply-To: <20250711114642.2664f28a@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 11:54:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
X-Gm-Features: Ac12FXz6F4j9YIJKyGAUwYcgpVBje1DHMNB65HFrbPl9F9fpay_RiZxgMldk13w
Message-ID: <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 11:46, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hm. I'm definitely okay with reverting. So if you revert these three:
>
> a3c4a125ec72 ("netlink: Fix rmem check in netlink_broadcast_deliver().")
> a3c4a125ec72 ("netlink: Fix rmem check in netlink_broadcast_deliver().")
> ae8f160e7eb2 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")
>
> everything is just fine?

I'm assuming you mean

  a215b5723922 netlink: make sure we allow at least one dump skb
  a3c4a125ec72 netlink: Fix rmem check in netlink_broadcast_deliver().
  ae8f160e7eb2 netlink: Fix wraparounds of sk->sk_rmem_alloc.

Will do more testing.

             Linus

