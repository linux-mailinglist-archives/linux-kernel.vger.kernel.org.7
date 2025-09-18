Return-Path: <linux-kernel+bounces-823193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E7EB85C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1443A171263
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E162312814;
	Thu, 18 Sep 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmQWrFwa"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA73148CB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210311; cv=none; b=kyBjv5fcI7JkNasjRt7iqg0X3giO5DuRv+CUCs7jNdr0tCMx5kI8gaC9jd+IEWIVw5SoZwZqJGftnfUCZnBvhTeOl9WITrH4UqQ6e49VSRdc1kpssE9Vi8j9XtFxbEZ+0LZyzxJihkOH15jEUObVF989Q490TT3DzaHhu6Zut7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210311; c=relaxed/simple;
	bh=fmWHKTD0HEp3v4jAbafgMjtiPh74qcGGX1DEtLNknfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5/2YpjhZM+CRG+aoG26o9MNvuc/d5U/h9lXxLnzAizLxoC2QhriLIEqO17d/wHgvScpAqc/SK8YmzPAEFsnRMX9zYgl+bawghDnNlE0I9E6+A5InQ+sSFFfkVv+tdlio/NQ7cSLC1Uvpu+aAGIycWgYYAmyvWflCaUVp8ZlsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmQWrFwa; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b07dac96d1eso333601966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758210307; x=1758815107; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmWHKTD0HEp3v4jAbafgMjtiPh74qcGGX1DEtLNknfs=;
        b=SmQWrFwa7DOmbmqdCLwoO5gF1gy5JJLlvihxkgUtQ+WbtQUm6wT31dBa4WNgM8o31G
         yKLyDm2QHBWbGND5VdcLRj02hz/ufyWiz1RZJKJW8NJuZ2RXT8JNXtNBN9ikacxd4ibR
         UIKeQOxaTZwTcKPSK8+m6Bx2XIvTsmNyZHfo6RwTSFgcFGALgUCxYpbWX9BkVJaRUmCK
         4iwxzIKZRm73JLY414z2WlQ8w7KPj7+z8ZVF+g1t5VcIr5XnxkWaJEKmkks1+dATaOX3
         ouV+R6c/ZHJj94WjUnqi+HZToKHAIVf+Nwq7yZZhZxpIFxIfZWr8vh3O1ajVMCqR479I
         jXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210307; x=1758815107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmWHKTD0HEp3v4jAbafgMjtiPh74qcGGX1DEtLNknfs=;
        b=ukMkySlJzx1xZuIkHgwY9xm1cqZuKmQVRdT+y+G67oTM0Iw2HRZRRtdXljFAIscKHd
         dYqm7+FqW3XXesWrD99Xj4EyXEJK5oMafQQ5AfXli6kSR3ep9nxl4DJ0I0eg/EOOx8oE
         bg+ttn6+KMKmNUnuj1i/yX9TqVpxdb+l7MDIwbalbJPMZ80KCzgU2KC7sBebE8C7lXFk
         j2MLMXU2EZaQ5aCupLSy8TefzJswyaZVycgwARdM3Wdx+kTdHI7Hd9FjSm2HDgv/HYkP
         iIPiNcjR6dIMkcQF8i+A0hFDfMHopuDjfbkqjkhnlLcFjpZDNE2+BR2d6sqYc9hcVQUT
         malA==
X-Forwarded-Encrypted: i=1; AJvYcCVOAQLH0ZobGqcprioQHUXBq+RhTaot2ATTxxb6fpXM+tRjocfDoJpb6YredCFHuuhdZ/7a43eLEUU1Ggs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxErTome0tLMJq+u9Fj7mHQG+juRddei1ubujMnsnh0LVNfT4fv
	LioStptsE2C92quRongsSQSvEWCX6NFTrpv2y9fqfb1+Lro7JXrae4QH
X-Gm-Gg: ASbGncsBGsuriEptlmrzYXLvyI/V/NTgZ8JxG1NbHK4pvsETlskzse2bxFVgZekuhMl
	/cFfTj3p0w3/aTx+M/oNtTBLls99aI6YsNCqvyvg+txpJlY4UwO6Ks+SpQPjAgao666pOF6e3tl
	7NDjAOV4cUgkZ+VlJh7Jg1QCKo2F/OXmPZvKLPRZulbETd6tcnbTBTHf2ipEA9CbDwvxhXlA/lS
	/wTU0F8BqbZqS0Xz7uizDQmj+kLQsXVP2TYbnkCNj4IUfFEiMeN3OwZ+HNWMaW2kqttLugt4Tad
	LEAddFnAKjzycyDXjBbHMkhiF96r3lCJMZphGaTkYACRTO/mKJSbv2UahiRFFgm1+TZf+X6ig16
	1BW2MoNdT6SlyceQp95BP4hcqAVEFJTaiasN40E1TkOXNo0y9t7oE40bVUMumok8w0evQ
X-Google-Smtp-Source: AGHT+IHhJpUJxm0JBqQPK1WWHMUOmGprTfN1qsQTFyUzj1uozoUmCz9sEIlUOLodf6VL0JxH0gPMWA==
X-Received: by 2002:a17:906:c150:b0:b04:3402:391c with SMTP id a640c23a62f3a-b1fac8c89d8mr401452366b.24.1758210306797;
        Thu, 18 Sep 2025 08:45:06 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc890cc98sm218393066b.49.2025.09.18.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:45:06 -0700 (PDT)
Message-ID: <869d0cd1576c2ea95a87d40e6ce49b97d62237c9.camel@gmail.com>
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alok.a.tiwari@oracle.com, 	ashwini@wisig.com, hi@alyssa.is,
 maxbr@linux.ibm.com, 	zhangjiao2@cmss.chinamobile.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Thu, 18 Sep 2025 17:45:05 +0200
In-Reply-To: <20250918110946-mutt-send-email-mst@kernel.org>
References: <20250918110946-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 11:09 -0400, Michael S. Tsirkin wrote:
> Most notably this reverts a virtio console
> change since we made it without considering compatibility
> sufficiently.

It seems that we are not in agreement about whether it should be
reverted or not. I think it should depend on whether the virtio spec
maintainers are willing to change it to agree with the Linux
implementation. I was under the impression that they aren't.

I will quote some conversation from the patch thread.

Maximilian Immanuel Brandtner wrote:
> On a related note, during the initial discussion of this changing the
> virtio spec was proposed as well (as can be read from the commit mgs),
> however at the time on the viritio mailing list people were resistent
> to the idea of changing the virtio spec to conform to the kernel
> implementation.
> I don't really care if this discrepancy is fixed one way or the other,
> but it should most definitely be fixed.

I wrote:
> I'm of the same opinion, but if it is fixed on the kernel side, then
> (assuming no device implementation with the wrong order exists) I think
> maybe the fix should be backported to all widely used kernels. It seems
> that the patch hasn't been backported to the longterm kernels [1],
> which I think Debian kernels are based on.
>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log=
/drivers/char/virtio_console.c?h=3Dv6.12.47

Maximilian Immanuel Brandtner wrote:
> Then I guess the patch-set should be backported

After that, I sent a backport request to stable@. Maybe I should have
waited some more time before doing that.

Anyway, I don't care which way this dilemma will be resolved, but the
discussion is currently scattered among too many places and it's hard
to determine what the consensus is.

Best regards,
Filip Hejsek

