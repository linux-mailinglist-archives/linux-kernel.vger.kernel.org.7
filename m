Return-Path: <linux-kernel+bounces-878189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A83C1FFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014774E6946
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59881F4631;
	Thu, 30 Oct 2025 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUd4Tq2Z"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631A2BEC20
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827002; cv=none; b=LZxQFnhaElsgwNQ8AaEz8LAuWt0/alv0AtjRRDUpolCiVqUCFsCIESCO42bU6NqttiiW19wTYLYlLu5/EcVX1AfRvcxrRN4u0oxudyTJIUoiY0SfiecC81MQY/OXQjJ41r5L/4c22Z8ZDXhyU0GxiylSHRc9i+5gwgM6dJo+dK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827002; c=relaxed/simple;
	bh=bqOlW2oWI7RdtQm/N15Vuwk/lchf4mj5RPORlezgpKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ5rr+RvJRwLrW+cZ/YYOTI9XyaqBUTOqbNf21m2xMt80agbiLxXfqtWokFURNdyXeMr8oYsUTOgkuw7sWNvRh57vkgoP9GM0QEiXEkIXSHrDjojbJRfKiAx2hUj6bLgDz+zJ1OgSYrmrA5jXwzRsdU5Rs7QDxtwAucS4I3Azz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUd4Tq2Z; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-785d3a5f641so11232477b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761826999; x=1762431799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWFtfYb05SOq83bboDg32uBQSLrzGUIx7jAl5366nJ4=;
        b=iUd4Tq2ZQPLsCOdMp69QAEfdDY+jL6pzAmOiBIHXBAXtz5z/vHVGGb+GMciV3h8lT9
         1xvJo5S1qnqHl21/0CaxGaxxvhJCnmzZnBuRUnmhoQuwJxw4tXiyTT6HW2ip2nWZd8kT
         6gk1N7xtHcJJvwDXabrtnehDpm74IO6GvDQ+CNnM/O+3sfiTIQL4A0EjoTpsB5BuDt3Q
         z7gpQ3N1ueYa8QefJghd790hHXLJLaxt0rwxuJaynXF0bKSQvEZRoWVj/nszy0ACwM44
         tJLsuhyC5D8n3eLkw40dmvEyyrKtGhuYp6b5JXNFhz/rTdbFCeHFM8YqdeRvwo2ES5Kr
         swpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761826999; x=1762431799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWFtfYb05SOq83bboDg32uBQSLrzGUIx7jAl5366nJ4=;
        b=TD+AkDe16N4Vej2UzQp+z0tQ6PHcY6TT4FdbNanIXE+iUVf9h+kk8xVPY9VFupeGbN
         LdBMhOxe9+xT8o3RHztFsmM18m8ktyhO6R0mhKLK3rsdJOiT+EuLJQfQGmzxSdz0ynzA
         6pDw5Oa5u1d688mNDs42BUI9JBQFwWuoaSZF53JK2iA4Pl98JO1wNBUjycz4/7D6rL94
         9vpvnz6LemgoITdhuysO8RlBoXiu+NK2jxQOdWBMCMPKwiUZkteKxOL939GsUhiAAwo2
         Dn0Zm6sGlTgYVeddaKpaJ0fZTxoiKHdFOhmP7mwMpHmdGdSoEwCH7LambcMPyNPnZvVN
         hJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCXxMREY7jnvdCm8meA2zR/4uYZh/iwuKWBJ9jbX286/cLuBFc+ZeLmqqpnFZB/OjByNfVJCfB1LZ4Ahk2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9HQBEjACYAqgN5MGvrTG1JIBz4lRzcJbcmhb9eXuCaiNe0P68
	qcwoW6pTvqXt9kbmQDEQoVtHyF1kvfIaFfVSbdLX9A/9DdgmZPQI2pfv4pSZ3Cm2XphS5v5DrAD
	c7FQfdBybzABiSjKqjtg5OEgFwpeW43tGSOWMVW/qiQ==
X-Gm-Gg: ASbGncsnlqtWlrCCAt41SsmFxSLuW4wWVyBisRDtvf+xlrJJ7IHe5i39nkkG8SgaVsX
	8aFwxg+WwXkJEl127KkE5RS845FrX9CN/Kdjizx7PvojP7W1s3qJHc9wKXZpDmGJFhmfEZRjUyp
	WDCeacb+v5oPyhulcuLHapwAk84anjrjCsIdbfCZp8FjGtDyEt+WegKkf64AdlqcdCL0WcBpOy0
	NW722omzOwXLKBdH3TIYtxhL7QCNuyZySD1VcqRk22A5gBe9AoQ5dCWUq8OCrT7JQBoTJWW
X-Google-Smtp-Source: AGHT+IHT9zocseeovUel6KQS/8tgyAhacJN5zXZoo2RiIByIVZXze4S+TL+MF8zrXEeVGop1sApCJVnU5MEid9zjmZA=
X-Received: by 2002:a05:690c:610b:b0:786:4459:cb5a with SMTP id
 00721157ae682-7864459cff1mr5156577b3.65.1761826999581; Thu, 30 Oct 2025
 05:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org> <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 13:22:43 +0100
X-Gm-Features: AWmQ_bmZlYP-vMQKR-I5oY2UwXbMGNHaD98nubyYKhsx7HdNG9dPpE2bV5NB1-4
Message-ID: <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > Changes in v2:
> >         - Limit the new QoS to CPUs  and make some corresponding renami=
ng of the
> >         functions along with name of the device node for user space.
> >         - Make sure we deal with the failure/error path correctly when =
there are
> >         no state available for s2idle.
> >         - Add documentation.
> >
> > Some platforms supports multiple low-power states for CPUs that can be =
used
> > when entering system-wide suspend and s2idle in particular. Currently w=
e are
> > always selecting the deepest possible state for the CPUs, which can bre=
ak the
> > system-wakeup latency constraint that may be required for some use-case=
s.
> >
> > Therefore, this series suggests to introduce a new interface for user-s=
pace,
> > allowing us to specify the CPU system-wakeup QoS limit. The QoS limit i=
s then
> > taken into account when selecting a suitable low-power state for s2idle=
.
>
> Last time we discussed this I said I would like the new limit to be
> taken into account by regular "runtime" cpuidle because the "s2idle"
> limit should not be less that the "runtime" limit (or at least it
> would be illogical if that happened).

Yes, we discussed this, but that was also before we concluded to add a
new file for user-space to operate on after all.

To me, it looks unnecessarily limiting to not allow them to be
orthogonal, but I am not insisting that it needs to be like this. I
was just thinking that we do not necessarily have to care about the
same use-case in runtime as in the system-suspend state. Moreover,
nothing would prevent user-space from applying the same constraint to
both of them, if that is needed.

>
> It looks like that could be implemented by making
> cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_limit()
> into account, couldn't it?

Right, but I am not sure we want that. See above.

Kind regards
Uffe

