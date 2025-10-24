Return-Path: <linux-kernel+bounces-869556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CFCC0827B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DF874F7A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C732FF65C;
	Fri, 24 Oct 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUpoJA+Y"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F32FF155
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340220; cv=none; b=V15nXJUTqjsDdb3AH/+14MYHXaeolDVPIdxnzVX2eutP6OJWw5dke72xxcMQnZR+9xc2hp3O4US7UlrDxybbisGCSs0WndyuQzZl+P9kcwI6xhaP6oeonvmkZ4e2NZDxMXK6frNlouW6Ud+Vb4+OoNP7M8CWLVDPesM6cK986+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340220; c=relaxed/simple;
	bh=vNar2fObJ/YjclckziN2OKibpLwZUVWKiZQDjIp4Y28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gi5umBEGa66hdwHGEg/aO/IxUng7OcgTfLr+0y5plWCpPbecGWWtTjRrW+iinl7fm50U27J/s21q9IJsIe0AFMfkQ9fOVJlamn0K137UeQzGECO0GR6o3ZWUPxZHMiQwcUOEcY3k/0sN6QwJ2VqO5v6tDIFSkjtMn3hrWO/AGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUpoJA+Y; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63cdbb02faaso513982d50.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761340218; x=1761945018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNar2fObJ/YjclckziN2OKibpLwZUVWKiZQDjIp4Y28=;
        b=gUpoJA+YjW2jYVo3Sr77vRSCQww0A1qCCfVJlCZb3Yd0jt/d/ml29d7FDlrg4Q3lB7
         uAuI0OoyZmMIbOyR+epp8LFfS1YqCMrh5tIjq0/RuiQ3/+KRUooZpsJET0w+SHnacyZ3
         srKb9nb1gbkAYoxTTfnv8YAFJaLU/bSVlYnsdT12vscN7/bnpwjQaINR52P7B7JmtcSS
         +j+Eus64t7D7AWnCzLoeB/0vWFnTzfcMVOTS5dfmm7VahD+phncbf4OqX3yhgkqertvB
         uF0xuaiwOmx7k4qXnb7XWmdVRt+GpchF/eLw/MAt/cL7XyPJTWBwIpppF6AyYPjUEw2G
         h4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761340218; x=1761945018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNar2fObJ/YjclckziN2OKibpLwZUVWKiZQDjIp4Y28=;
        b=vgxY5ctHC+5uxJ3xyfLwKCqbCC5nUCUmE0KpIq38VQUU2mcf/opiMGsNgEb9rQABD9
         qZiqRgsk1lWJdRdr1GQ/zkT0OIBMxjGTf/sfqYu7D+Ki/EMEzTTisyOqzfEm+i1SXm7d
         jmupNaL8U+JDd//35Ehabf9/l0jRxv23cKMeuunew0GVE42/fEuj71ZFa+EwwAWlTwEh
         +nz/h/a8sqOXLJeOI+3UYTChgXDGvQdQ3FucCVtQp3fIvMxc5KG5IALZNRX4EEzPbC4/
         ydFbjKCQ5q5H9K9Np5zquZ02AAqb9kWvFKR/YtwgS/im+u768i48xYpBkrs14GojT00E
         YsNw==
X-Forwarded-Encrypted: i=1; AJvYcCUxDs/SGcn8LNQCuPJn6FTsu7azNXriYN4HEMowwiMk8LaBy1vV0Lfll3m6CX/F0BEzEmzJqDLISogFV9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6Ww43NtGQ4Wxmcinh9ThLMQjSNKSI6b0Q2wAqhMKpiUA8MgC
	5RHH5nSYm+yDu6Fpbkkx8h4XFSTJ7oAVxTtkHnCojKRqUHFzPnpJLHcOy0aXuJ2C4vgP1yFaBCR
	RHsa+7nsb0n6IsYrNDhwXdSAZJV4d/aI=
X-Gm-Gg: ASbGncuU/TLV8Lkxuu0DjVK8kGUTIrrfLxxJ3EObwa9eeK7unzPL84ka8dnTGXLKMC5
	pSwabz3R2z+F/ZM89ZksuMez7yaIijRCrL74UU1+H6gFqXMU90JJtjFsTK9o0AW0PejcJYqPAuL
	Bh3bIGpXII2BaYSKykyhvcAR6BPfXeclea99kCldzDaSH6fwGtmmJFnGfgkhfL9mIYO9QZGllaV
	WbpjbcAsPKaGybBQMhiusgV4DnuJleT51SzW472KPwTHT5d3iCer5sOBJp4onoDfVieYbmudkuL
	rIZRFy57D8eGK0R4Vf5XIJdsTafNfU6PndFjO3M=
X-Google-Smtp-Source: AGHT+IGPfQPQsWVBJditk8ZLoKodY2GSVcK/cYaKXa1sORKnZqTOEGqPHHErVJ7mIOsgE88o0wuqUj1jCIXLb4sNG1w=
X-Received: by 2002:a05:690e:1182:b0:63e:3099:df3f with SMTP id
 956f58d0204a3-63e9e043cccmr7400103d50.3.1761340217776; Fri, 24 Oct 2025
 14:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com> <20251022180107.3a7d1198@kernel.org>
In-Reply-To: <20251022180107.3a7d1198@kernel.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 24 Oct 2025 18:10:06 -0300
X-Gm-Features: AS18NWDmyMF1rpsmyMWLaRl5q-bbLa3mCtN8Q3yda1FTKFDczsqf2piTCo-OGII
Message-ID: <CAGSyskWm=jDOSPAh3LWEQQzjAxvc-Od7DkQyP7W9EynoMdDnMg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] netconsole: Fix userdata race condition
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Matthew Wood <thepacketgeek@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 22 Oct 2025 10:39:56 -0700 Gustavo Luiz Duarte wrote:
> > This series fixes a race condition in netconsole's userdata handling
> > where concurrent message transmission could read partially updated
> > userdata fields, resulting in corrupted netconsole output.
> >
> > The first patch adds a selftest that reproduces the race condition by
> > continuously sending messages while rapidly changing userdata values,
> > detecting any torn reads in the output.
> >
> > The second patch fixes the issue by ensuring update_userdata() holds
> > the target_list_lock while updating both extradata_complete and
> > userdata_length, preventing readers from seeing inconsistent state.
> >
> > This targets net tree as it fixes a bug introduced in commit df03f830d0=
99
> > ("net: netconsole: cache userdata formatted string in netconsole_target=
").
>
> This test is skipping on debug kernel builds in netdev CI.
>
> TAP version 13
> 1..1
> # overriding timeout to 360
> # selftests: drivers/net: netcons_race_userdata.sh
> # socat died before we could check 10000 messages. Skipping test.
> ok 1 selftests: drivers/net: netcons_race_userdata.sh # SKIP
>
> We can't have skips for SW tests.
>
> I think Breno was fighting with a similar problem in the past.
> Not sure what he ended up doing. Maybe just leave it at the print?
> Don't actually mark the test as skipped?
>
> Slightly more advanced option is to only do that if KSFT_MACHINE_SLOW
> per:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-=
style#dealing-with-slow-runners-in-performancelatency-tests

There are two reasons for hitting this skip.
1. The hardcoded 2s timeout in listen_port_and_save_to() expired
2. socat died or failed to start for mysterious reasons

#1 should probably be a success (we ran the test for this long and no
corruption found), and for #2 we can try to return whatever exit code
socat give us.
Retrieving socat return code is a bit tricky because we are running it
in a subshell, but we can save it in a temp file.

I can also send a follow up patch to use a longer timeout in
listen_port_and_save_to() if KSFT_MACHINE_SLOW


> --
> pw-bot: cr

