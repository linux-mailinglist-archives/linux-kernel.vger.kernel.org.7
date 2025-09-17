Return-Path: <linux-kernel+bounces-821113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3753BB80748
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 070314E1C34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9F330D20;
	Wed, 17 Sep 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="Jr3RJMxq"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A460309EF4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122090; cv=none; b=gdTtwxr7R5rNv1pVis3lEeDzHayboVGmk5KbW2xqDRZ3AiXmHqjbxkjb7JgQUOlmvbY6hut0CdMga1jN8dS+F5slXyj3OKMCZxGmq1QyQH1I4Pf/hZqoO2o32E9sjLx0OPAi/3LfIE3wnbd7Jus30kI67fl/f/BIIHXufde3h9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122090; c=relaxed/simple;
	bh=BJGW2dTrJ5vL37y1VD5hJsGeiolH7Qgx6xvbYYe2VoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReSy4pk59XSIQVzDOBFGjdDzX5kNRspRkwMrUjPF2PxlH9P1VdCGGYhgKYv4kJx9qpyRE99dS+2KBID8mlbmEIEiCx6IIAkXGUBgkzDhAjKZIvbEvAW0QzAY1JeKiFiRPqrAqoUyjUVD2zNBz/yQVwq/tnAWupxd8NcLSXBsKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=Jr3RJMxq; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-78f15d58576so5204806d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1758122088; x=1758726888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6NrCcDiMgz4BfT37/6MfLkoGQSFwd3bQQCaY08TYjM=;
        b=Jr3RJMxqr8A1MbkPS9ZoIPOFuGreY4uY6Fm/UhOyJyUwEzzJyufmCl7LU/XU6iO6iX
         r85EZ0HmonvXhwWiVRV7DL7FLFJFugPxaaekd2qm1+3kFhw3dDhrS+4moqKNcMqzsBGW
         mgLYwPKhN4rvHkiN7YX6YyNJ0NE2VrDQEtuVo7MizcLi6hwQ5O8O9c8SxkuoJ8V4ylDT
         bi3/rNVU/pnBpAD5/HxRsgDKoKqNMeMNje9dB49nN7dls8FNPFamaBhrFpObjl66Tt+J
         zHLdigkXNEzyDXfui8fCjnao46shpTOAS60J1tyR9XTf+xGHyoreVl2zutNMvGRDn7E8
         U8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122088; x=1758726888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6NrCcDiMgz4BfT37/6MfLkoGQSFwd3bQQCaY08TYjM=;
        b=Uqn4zo9ykDRNF+xykHOyz1dBP3DuQ7B4LZXTShp+DjoKukWHSwrWRVWKgyfX7Mu9Ue
         5Dj60b8uzkH669oLjxTnoc9657q0E9krUUiYNfcAJzIfp9Tva1avTbUlbC9IGpJXECS9
         GJGMZT36EDF5mgvhSvlF1CPAnypZpZ1TWVxmkzG2mFRQuPe9I7x0QRQtlLuIvV7wV8wb
         hq44//pzOg8m1Rq+8JIeRnFgQoeZSf/BVOqWUoNUo0/9Ob5rLqhJMeFChWe/r4YfAejA
         a473AqUSC5ag1LNkH3W/i7GTANlSFlm1uJPpG0PBBhHE8a+N9l2MZtQTAVVlekSsU2t4
         Rb+A==
X-Forwarded-Encrypted: i=1; AJvYcCU+hjtLAsfGrSaXD0m/jBbjp+ED56QndpuneKo/IHgl0dpwvqdTelRLBq0hfrYElc8aFzre9jPwfgeJs3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZybkuDBBNr4mlxE5FJAn44OAZsmyZg08dwDSimSv9/solqvP
	hsQT7gjJ3vrQwVX7pk91qQut40TzszH0rfN6lgOOmfaMhfyxtCr+ol4uXJ/JQ8m5IAwJ9jWA4sL
	dK27X
X-Gm-Gg: ASbGncsf+2QNoH3bCxEqvA/s9/y2RkFbJPJPE0KC+D8lhg9qW4HQNOpacXfCwHcWuy8
	RVR+jkK2hs/iM8XTl4dQ/i7W/k5/VKKCKC8pzzhU11eYvCR+3eUettQtsGavbW2gztT/EqHWtV4
	FMxp/a6UQEiHnuoEiwBDUBJYqCj5zJ1+n5ljexYZq+Q9mPVYZ8GlgXu3SIXnBZfJ01zncAQOF0Z
	JBVQwmW7MKFnsYh3cjgnmvlQXaeAeZI0Isnz59lgbGhkhHVpJIbmHqt04Ii3Ngxs6u7/6Wd+YgO
	x7/RO8dPDEW3dRSowdkrlrkOhhV96+iDZArIk5Adbn6Cc8mXw2QJesmwrE/0dVPOOAvCUa1/B8y
	34Uc423p+WtyBdyAXEuYqmpc9wWbrDX6K0Iu4IqI9NZzBx/MUkPQ=
X-Google-Smtp-Source: AGHT+IGd/ABHMF4f3Hvae/ZzKRbwMwLDu0yyj04cHbrYciDrdwe6HnEu0vohHTaXLEoMoD8R1qEw/Q==
X-Received: by 2002:ad4:5b84:0:b0:77e:8d71:c335 with SMTP id 6a1803df08f44-78ec6177b6bmr28182516d6.19.1758122087595;
        Wed, 17 Sep 2025 08:14:47 -0700 (PDT)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-77cb4cf2a35sm65042936d6.51.2025.09.17.08.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:14:46 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:14:45 -0400
From: Nick Bowler <nbowler@draconx.ca>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: AST2500 BMC video output disabled by reboot (regression)
Message-ID: <xeipdyk2i2lpkg4rrvz4cl2l3ch62sl4zoa73qvlms3ek3zkci@y7xqbgjulaet>
References: <wpwd7rit6t4mnu6kdqbtsnk5bhftgslio6e2jgkz6kgw6cuvvr@xbfswsczfqsi>
 <CAD=FV=Xp7zOQ2iEVf896P074RW911F-e2Qa36deD0e8fWksFBA@mail.gmail.com>
 <u7ek3ccya4c3c4rteliskjjfczpmrt4vmqo5c6kjdotxdgitn7@ko24dpb35pq4>
 <ef6558a9-c44a-4c66-967c-187f260f73e1@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6558a9-c44a-4c66-967c-187f260f73e1@suse.de>

On Fri, Aug 29, 2025 at 03:07:14PM +0200, Thomas Zimmermann wrote:
> it's been a while since you sent this report. I assume, the problem is this
> there?

Sorry, I haven't had much time to try the latest versions, the most
recent version tested is 6.15-rc7 and the problem occurs there.

I have just patched out the shutdown call in the ast driver and
everything is fine.

> Am 30.04.25 um 15:28 schrieb Nick Bowler:
> > On Mon, Apr 28, 2025 at 01:40:25PM -0700, Doug Anderson wrote:
[...]
> > > 2. Could you give more details about what panel you're using?
> > According to the documentation I have for the machine, the video output
> > of the AST2500 BMC is connected to an IT66121 HDMI transmitter.
> 
> That dmesg refers to a SIL164. I always thought these where only for DVI.
> With the IT66121, I'd expect the warning from [1] in the dmesg.

It's not impossible that there is an error in the documentation.

Although the comment in the driver right above the linked code suggests
that it might just report SIL164 even for other kinds of transmitter
chips?

> [1] https://elixir.bootlin.com/linux/v6.16.3/source/drivers/gpu/drm/ast/ast_main.c#L196
> 
> 
> The ast driver doesn't do much during shutdown. Could you please out-comment
> the lines at either [2] xor [3] and report on either effect? These calls
> turn of the video chip's memory access and sync pulses. Not doing that might
> resolve the problem.
> 
> [2] https://elixir.bootlin.com/linux/v6.16.3/source/drivers/gpu/drm/ast/ast_mode.c#L835
> [3] https://elixir.bootlin.com/linux/v6.16.3/source/drivers/gpu/drm/ast/ast_mode.c#L839

I can try this.

Thanks,
  Nick

