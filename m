Return-Path: <linux-kernel+bounces-767891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F15D3B25A26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9E984E2067
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2602919B5A7;
	Thu, 14 Aug 2025 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="BTh9N81B"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109315624B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143795; cv=none; b=P+MuWkUPQ4hYvvk2ZIoPta4MHzy/DSrJvUgEbpI/QGoY/bPdFfrAkRuaznwulXtJRwx7ZHmwL4I7LkyAstTPw66v5h6BKuOi1r5rWQHJTGTSdQIikEhUfastKnSEhTe6mys5zmbDbnKE6uPdAkfiDuPuc4hzCiECm/OTJKTM0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143795; c=relaxed/simple;
	bh=sYvTUhn+98XihTDP31SzYmddVdxZwaJtzy0vGCN/OrQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ColJpd9I4V/rfnZF9oDpw7ZJhp03T8/zZDfndifsZvK4RFVVIfZcA8Sm7kDH+3AKAWFnW1qbzbsCEG/YVVn7INvQ5Y6++vtqFsPMW+JyRBO4PTi0TAkAG9OikXfPz3YgwUEPEtJ3j+lD1XfNIIyeCS4Qi1ehgsi8II6cElPk1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=BTh9N81B; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b471aaa085aso78869a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1755143793; x=1755748593; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYvTUhn+98XihTDP31SzYmddVdxZwaJtzy0vGCN/OrQ=;
        b=BTh9N81Bq3n+yrRKiyNSN0H+vMpLU0vKar/7raU3UZyB0joiGAlzFWdlL2d2b3qJTj
         7TS7Bf1b8372AtkQouxvvPLJOBAZCI47iu8vuhy7suKORhX+NQlbzpP9Ufqc02W8Y35O
         qbYVQL4wJotodSVzvjeZ6gYrn9M18JP35AcvEenCliL02IqbUE53XDXKUuJLf72GBtG9
         y7Y1IXLgtFoCwZskuQJh36sbiBFjOpgsDLIhDcBr2c2/ksXPrqbJ9OdE7jtHOnYJAzFR
         cpNkTxHrSCrrgsCk7GBQk8YJmnaTO0kj+L2uubAJT2PQZwA2m9mxyg2OoFV7DmjhAhwc
         U0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143793; x=1755748593;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYvTUhn+98XihTDP31SzYmddVdxZwaJtzy0vGCN/OrQ=;
        b=RO1W3UmKn8TGckBpw2RLOEGXgJi2wBE2bnHdgb2QJh98PGdVbCDaU//muE4QhN0is2
         9XBx51iwgESjY3QRjkoqbuHtobaEj5jQEyucUmPdor+6IsidJOrhe+mxXQhUmwOgRudw
         O+3JYV9VE5K1IDIdEPKBoZfz6hx197xV1OCI9aTUp8sGHmGTiyIKfb0uAjd+/uT9wLFg
         lKIBGX/cq2dUlmSnbcIuLVTVyq6SPvAqDRnS0IGC0TTUnBV51OHUM8/qTVH/1qthdT2t
         dXpALXUdP8ndetKIxjoVJ6x2s/crPe+0MCE2BS2uiymsExiZ0wD6V5DCUIgwsXnxH3BZ
         v3PA==
X-Gm-Message-State: AOJu0Yx/iDRVtNtUNC8ZCM728XYpq6b34+VrWQf4uEp0lYCGEToeicar
	rV1uQBA8HSyQ4Y+mVko6kP0hGfCP1A9vWghmyPJLcSpHgRuEGE/PWp852jM03AsD13w=
X-Gm-Gg: ASbGncvPLbauiM8hAI4kyVQEZNLB6KHGiZShlT8P63yyMeAplLvz4Uqtd/8LRCOtS/2
	FsgdFrOpeUEnxEo7AuXypv4vrhCMIWvIF7YZ0r/8Wg+IYTjx1cJBDFUpmV5ntIOZYuoNe0PeSUk
	jG3kVRfow7t5L0m+yxcjJIpzB/A+2JPWHnpM67Vq7NWmj4twJz4z1UZGZBCJhTpd/6Fi9IH+yVh
	YJ/W/GqouZWglrWnnmrUvuDYy1E5i274sOcU2a7bII/K+N5BAf+fp8vAfjeCWfC2kIZ5opuCGpn
	JeofwoSsX28wkQ6KcQxdp9SFMm0VV+jFmBuMibhA6CSeNDdm+NKvNVJXoelTsm++BJnLeMoCqXC
	xCwJGu+nWsz0T+nzaY/yQj8Q=
X-Google-Smtp-Source: AGHT+IEiwhj6AlTJP0zjelqjRFQKsbDuEXwt1c17YxK/9VQTXmFU6azYy0s6xYMjgeJygYuCHmugIQ==
X-Received: by 2002:a17:903:3b88:b0:240:417d:8166 with SMTP id d9443c01a7336-2445c54c606mr11647155ad.19.1755143793182;
        Wed, 13 Aug 2025 20:56:33 -0700 (PDT)
Received: from localhost ([2605:fb40:0:c09:323a:5679:3782:80b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242fea29f1fsm58678255ad.99.2025.08.13.20.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 20:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 21:56:31 -0600
Message-Id: <DC1UJQKMO63Z.1ZLS5VS0OXZAE@brighamcampbell.com>
Subject: Re: [PATCH] accel/rocket: Fix usages of kfree() and sizeof()
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Markus Elfring" <Markus.Elfring@web.de>,
 <dri-devel@lists.freedesktop.org>, <lkp@intel.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>, "Julia Lawall"
 <julia.lawall@inria.fr>, "Oded Gabbay" <ogabbay@kernel.org>, "Tomeu Vizoso"
 <tomeu@tomeuvizoso.net>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250813-rocket-free-fix-v1-1-51f00a7a1271@brighamcampbell.com>
 <65769f0a-af9f-4e96-93d4-8594e76d8e73@web.de>
In-Reply-To: <65769f0a-af9f-4e96-93d4-8594e76d8e73@web.de>

On Wed Aug 13, 2025 at 11:56 AM MDT, Markus Elfring wrote:
>> Replace usages of kfree() with kvfree() for pointers which were
>> allocated using kvmalloc(), as required by the kernel memory management
>> API.
>
> How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.17-rc1#n145

All issues addressed by this patch were introduced by the following
commit:

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")

>> Use sizeof() on the type that a pointer references instead of =E2=80=A6
>
> Would it be helpful to offer desirable changes by separate update steps?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.17-rc1#n81

Tomeu? Oded? Would either of you prefer that I split this patch into two
patches (one to fix kfree()->kvfree() and another to fix sizeof())?

I had considered splitting it into two patches, but the changes were so
minor that I figured it wasn't worth it. Please let me know if you
prefer separate patches and I'll gladly prep another revision.

Thanks,
Brigham


