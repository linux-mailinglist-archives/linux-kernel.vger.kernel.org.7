Return-Path: <linux-kernel+bounces-625316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7AAA0FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 17:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A8A16C6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3121ABAC;
	Tue, 29 Apr 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H3QXKoWO"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598821ABA6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938774; cv=none; b=NBTQHFUQRLIlxfgw6HDT9vySg4yjqJOasgg6ubMc1WkEEnNo0CScILz/7r1iJfjqv7Om1VAm6gXydvQsA8qEyYMY2v2LyHoCnjkSPc2RwCDXzh//k1V0sub2D/bIbnqahKGr9lYfHFAVKIaZ8UT2CIdEK6akMGWQBcYrXFyqru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938774; c=relaxed/simple;
	bh=1R/UVYZsHx8uy1xeBMN3faf8LhuTSWZAK1tYdGatObc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/tgd70k0duT90juLpETaJki1q6pG6rgPBgopm4byDDcHDyxB7DfJpgqjSvQh3SdM6nw2bk36hBARGHuOAcEHJF8/Qt3BKcgnhjgqlzHfHjizAo8y7dHiU+ODu5wy+2V6pdOZ/x0wxbdU+28a368mGWbdpB8rLyhplTVpx7LGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H3QXKoWO; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCUL5XdfR4CR6h1x9Pws4FmvZdnRPkk0WtvXekKM016G7RoPL4hhzYlJ4bkEJNmQ1OTSZhACeE6C@vger.kernel.org, AJvYcCW7zf5GUKLaAie1lzwbv4xLx4cHp2NCWeisiOVrSYwatTJMAzCqbmeDhxbu1nTi7vHpT/trrpZRaPOmIIdV@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745938769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnYluQNsvwlFJXZXZj0tS+5xHhVlsh145ES7SSJ3WhI=;
	b=H3QXKoWO6FfFubQHdrSgo4pdu7CgpD7J2i1M/U4nlqoBZEf1uyEz+b0y9Ygm63B0xRYQbS
	EslfhOgBt10gQIo/W2CpDAkI7XWpDYsdB3fs55Le4MwgMoA2tFXWi0D3Dn+ATaC81Y1nn0
	ixK6vl5iFtIH6s46eGv9Ot4oWkWFrvQ=
X-Gm-Message-State: AOJu0YwCbxIvkrDVpDp4wuBFxjCWnaVA/Ci2VFkwtYdnm1tkIiY4uSBj
	fIJTWFJAIdWotJaJfP94cEq2nd2TpfVqO+KboNupFb4IwnRwoyGNdgzMWJcOua5aiExeSqyOKpg
	jAWPxzFGsQEzoYYI2SsxRiqp7fcY=
X-Google-Smtp-Source: AGHT+IGNBQScKbdOSUo8Y+Mw6oKw1PdkWWkRwZHqGviaYcint33ZBDfQezOKgc8bDBLZGCiwHYX56txfSJvKt7VyWNE=
X-Received: by 2002:a05:6102:c93:b0:4cb:5d6c:9933 with SMTP id
 ada2fe7eead31-4d6406915ccmr8292361137.8.1745938767376; Tue, 29 Apr 2025
 07:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYut=1TFvFUvkRPizj97v-JGyg0kKW7aH9XjPbss_Rwg1g@mail.gmail.com>
In-Reply-To: <CA+G9fYut=1TFvFUvkRPizj97v-JGyg0kKW7aH9XjPbss_Rwg1g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Tue, 29 Apr 2025 07:59:15 -0700
X-Gmail-Original-Message-ID: <CAGj-7pViAbqP8pNy2vbvwJEcVG_b77FxNJigdQ5ibWqJd3X8Qg@mail.gmail.com>
X-Gm-Features: ATxdqUGO8uv0C3KNe5vLyk-Im36DpLSwPCH86ZIO26AAD6a4CoByaREnphBWonE
Message-ID: <CAGj-7pViAbqP8pNy2vbvwJEcVG_b77FxNJigdQ5ibWqJd3X8Qg@mail.gmail.com>
Subject: Re: next-20250428: warning mm page_counter.c page_counter_cancel page_counter_cancel
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Hugh Dickins <hughd@google.com>
Cc: linux-mm <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Cgroups <cgroups@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 5:22=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Regression while booting the Linux next-20250428 the following kernel war=
nings
> on the arm, arm64 and x86_64.
>
> Regression Analysis:
>  - New regression? Yes
>  - Reproducibility? Yes
>
> First seen on the next-20250428.
> Good: next-20250424
> Bad:  next-20250428
>
> Boot regression: warning mm page_counter.c page_counter_cancel
> page_counter_cancel
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>

Thanks for the report. Hugh has already posted the fix.

https://lore.kernel.org/all/d542d18f-1caa-6fea-e2c3-3555c87bcf64@google.com=
/

