Return-Path: <linux-kernel+bounces-844250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55840BC1608
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE713BAEF6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397652DECDD;
	Tue,  7 Oct 2025 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRzJCkLn"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343DA2DC322
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840690; cv=none; b=NXO4u/Lur7hOlfZNow/7XY8KyJNa6lIygl4umsdpHTuwMEuiK6XnB6T1oiV70KJFeYuix0dVWlZiEYvsoR2a5LBVuDlXScqWPAZBGWKkr8IKJd2VKnQ5IsTZhTFsDulHWLm8g9Z+Qd99kwWe2z3aQZbyArCl/nUr7B3rbv3tXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840690; c=relaxed/simple;
	bh=FqGy43gfGpC0dhZqZbKkR3fkuGz53QLElVJZ7JhkiUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAFs7t+DohfobxwSMbc2wxx0YFVjaZfhW/97QwDWE7E1CLQJfdshB8dY6BGAxmK0zE66w1zAMC+VJSJMO46LER5dEF9gR/xvOh9MxGdyTUBItDUeQXfZydzG1RlDlR9jMY+CowV7XBuvkORqYP8ypHNHjaLrFCcpeUIoGIoN9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRzJCkLn; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7827025e548so2573911a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759840686; x=1760445486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqGy43gfGpC0dhZqZbKkR3fkuGz53QLElVJZ7JhkiUU=;
        b=iRzJCkLnhUyniN2I/eLUEOUE2I9wysSf0Tn9Bb2TQEJa9b0v6mZsQ8k9G8xqhgdeV0
         Rvd48vtpzE2GmOIeE1FDaOgyrhNwcG7wJDAz3Y8p4JOTZcnXxkwaAAk/VG3N7VZwI2kh
         WGTmoJk8YicGgftmQtiHaF1m+ZanNKN7DNBBedHqj61m7l+0O9iqsOd3rlAczzpGh+qE
         J34ZUJKkHpG67xbsjTdwXqOotJGpr4kBnsxYO8lcecg8s6QnIVCHCotyGqmdpLTatkRK
         jZO/cidf451OnrIOGmqE+bHqjTOMYN4QRODZ/ALWc5q4FmtauGlTkUbodhPM+lQPvSBj
         DSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759840686; x=1760445486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqGy43gfGpC0dhZqZbKkR3fkuGz53QLElVJZ7JhkiUU=;
        b=eF4J0dQy/AYq838liCiILpfsvvsZ6myHdKZFOFGCXsQn9eOG5+OJqQKAwTlCPds2QB
         VsZdIkjFHHMy/032+nGATkLmh2qpLxKODW4KTBOvcQ4GcmyZdyCsUuSgP0COM8mkE2ZR
         XVLHkxCmlP5sd2rgmZLprmnKct8PGH85e8mTQ/QUMwFw0wTOoDUUZxSU2+cXpDLy+SJh
         rOX5XakMScIBgjDI3cXZujmAeZa88bD+JnMvMUe47AuIS9rfgcMGZH9xHZhb5yh2pd6x
         IG5VOd6CINRiQf3AcjOsCfrUMXhszEQhix2AB58LxaWU1aLcfV4LdYp6HvyK072HqlJC
         F2bw==
X-Forwarded-Encrypted: i=1; AJvYcCVnGh+jG8aGcTvNexQrSkWVPOAfD7WjZB+K4DPtc7F+goWrYY46SWcqnnIijL2uhXFPixVBkfDGL0ZXGn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cSfAmJsBFd1W+UE98JcRCJ78qMkhOuNS9x1hjgwR5eOw9Kd1
	NRU5rAFvVlNu16HP+BHqQksdETRbLRRflXqA5UCGZvMQd9FXp4poHDMK9lzOSIIVDu1uCu2xxUH
	KF1D34p/tca8nHZ9bRYM2ZN9wJBwDnZQ=
X-Gm-Gg: ASbGncvAe+dLMB46fJbwK2vmoPUkxY4WG96Jfxck+1DBG2gxQSdR0JZaqknkzFre1Ol
	Mnzj0xvRKzh0FGJ4oXdU7yl25dZKpF3CMOUdeE/2IObz9h0w77ZYh+QuqJvIc6bODQgTBVTrWwP
	/XOQvSRAjIk/cfNWSowrop0oNeZ57L+WwPW3LtGUy44H2pQF9XRJ0t8/s0M8ig4H8F2RC1+RoVt
	irqjVfbND08fNWtVGtclnp06jn/5QU=
X-Google-Smtp-Source: AGHT+IHZ4Q1KsuEJ1pqR5+8vtFxL7pJjjIBfDRaQBDyKPZ6VG8AUArxYvBKzVwGtoMC3aCwKA9pzveZXk8T5KqF5SJI=
X-Received: by 2002:a05:6830:498c:b0:74a:1f03:db5a with SMTP id
 46e09a7af769-7bf77207494mr9265727a34.3.1759840686185; Tue, 07 Oct 2025
 05:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003091304.3686-1-briansune@gmail.com> <aOTrsYllMst3oR03@opensource.cirrus.com>
 <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com>
 <aOUDbF/i4+9PXc1j@opensource.cirrus.com> <e507ace6-90af-4763-a1e9-08e02f9e63f1@sirena.org.uk>
 <aOUHDJW5aJzD7Ku7@opensource.cirrus.com> <a8d1438d-02b7-4e08-ad4c-17467562a753@sirena.org.uk>
In-Reply-To: <a8d1438d-02b7-4e08-ad4c-17467562a753@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 7 Oct 2025 20:37:55 +0800
X-Gm-Features: AS18NWABs5AF8rfR_3Gk60qIc3MD6zuHTwIjZu8GC4D6Bfwd_ZzLHsR1fhkjW2E
Message-ID: <CAN7C2SAQ0rCZ=qPfh_MfQg_z0u7sWyFpFHUa2-Wwh_iTnNJGLQ@mail.gmail.com>
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Sune Brian <briansune@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 07, 2025 at 01:26:52PM +0100, Charles Keepax wrote:
>
> > I don't see any current users for the manual divider configuration
> > at least in mainline, so we could probably just drop the manual
> > stuff. I don't think I have a strong opinion between that
> > and blocking the automatic configuration if it was previously
> > set manually, but we should do one of them to keep things clear.
>
> Yes, definitely.

if you read that code more clearly. It is a case that is select between
WM8978_OPCLKRATE and WM8978_BCLKDIV.
With the latest test on the dts file.
When running such codec on master mode the bclk had never set to correct
bclk rate. As such even you see that codes exist. It never run as expected.
I am not sure any adjust is required on dts but with proper lrclk and
mclk output.
The bclk is wrong on that version.

This is why I propose the patch of the bclk.

