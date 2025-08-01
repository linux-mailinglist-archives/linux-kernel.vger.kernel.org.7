Return-Path: <linux-kernel+bounces-753813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B8B1885D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 22:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1F33A669F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A4228D8DF;
	Fri,  1 Aug 2025 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN5ebZH8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4D1DE4DC;
	Fri,  1 Aug 2025 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081593; cv=none; b=Bdvgp7ZePaS9t+vZF8wQn0Zmz6sd2D5YMzztpmDzuTnkGcH+GGr180APKXcJi242oN7ehpHmcKUia2iUoHIT07d8kVwRis55DaQTO0wJs+gmDOWE5mun6ccWOkrwIjaDzZfK9o1nMXrbmIxNFQGUNbMCMrt04UechkO6LWQZlKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081593; c=relaxed/simple;
	bh=oihJCDhiMYArha1HuDM+3dprH0F7BEj3HiUnLGSllR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBnWmRHDWTqd0hShMdB9+GFD9ml4lmhR6ML03OzLh2zXuix1s37RlCV3GB8tGsN6rBBAHbgCbeB2I4HQtHCFkSIwNmmDf15G3bjppF9fyCJ8ZHAgbyLMAfROAgD0MgfaekKemqas1uZGJydbSnOc0K0r+dIMBeRNFVHQgqt4yXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN5ebZH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D942AC4CEE7;
	Fri,  1 Aug 2025 20:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754081592;
	bh=oihJCDhiMYArha1HuDM+3dprH0F7BEj3HiUnLGSllR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sN5ebZH8pOGJJJZDFzkeLgh/zFwMUMgeoBmNK55SP3mZPXrftNpneYtABU0G7nNx7
	 Y6n5u4F/9p8JLwQZZY3yC7zRksne8Mmp8IrivBSdhnxaMjD3PZSNSyeUSxTjAxYzMY
	 8NilJjpZ8fGsJi+xsQnz+tcLn/xSuOqGtqo/Aawe+p3uvFAB/JLD7EIBwP+ho4HPLe
	 GLjikDO+WjB6NvUjsZ9HlkYggbhvXTUaaBJro6OR+5JHBUxGFPYnSOvQzFvQq64MYH
	 q1AnKIyITC7NKzcLcuhheu8Y1Sus/KSEeWH+fHFF/DkPYBhKfpfbRLAnlhdZo0mGVV
	 Hxo+6qvkvaPfg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af90fd52147so262855066b.3;
        Fri, 01 Aug 2025 13:53:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUH9OXJJUDMnSfLzt+NbOEGcQJtf/ngB/gYyjCLxjQ4PvArfavQ6WYde11GAnAKBQLzBRt0opTLAq8=@vger.kernel.org, AJvYcCVIMAhL7Ok441+z4Rguf+LUd+avHlWP3bplIUAN3dtqBTMYBYecv7KevTs4+CsOHqM/G3gv2wdCgArl@vger.kernel.org, AJvYcCVngf3qmb/5Y+86fsFeEmOHiIQHV0kDzpISmMlk6GQnTSiieaXt7v0M+tWKv+T4i4A/q9jYk4q+AHvd1D1v@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+x1dYjdjHBIEFFR1scglh1tFzaPcD39kP8KRallp6wRlHkDz
	augDptdc/mvj9gnPunbv2J2W9G2iaF1iNM60tJ5KHdkl4GogM+SOuys1x9M9O1gMdnwRLXQOee2
	ESEs/81J6ocLibcX3vb588C0i57FMww==
X-Google-Smtp-Source: AGHT+IFoHdZJnI812DHI3wywjHxToLcKIXhzuWimx/pqRfZbXCU+XcVwtk86KcJs6Y1R0LMocw8Dd82evjzlOVxLU0s=
X-Received: by 2002:a17:907:9721:b0:af8:fb0a:45b7 with SMTP id
 a640c23a62f3a-af94001e703mr123565866b.21.1754081591472; Fri, 01 Aug 2025
 13:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727195802.2222764-1-sashal@kernel.org> <20250727195802.2222764-2-sashal@kernel.org>
 <7h1ppxcp0d.fsf@baylibre.com>
In-Reply-To: <7h1ppxcp0d.fsf@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 1 Aug 2025 15:53:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJW206w1OiOZ+4nMg7XyHQq7QnOyTWM0W+DyMmu-gpAjw@mail.gmail.com>
X-Gm-Features: Ac12FXz7Tmb3jZO7n5uJAYVaOhcu2_MFeSgTQMaSw2vCzvgO1R8xoIekd-sPcac
Message-ID: <CAL_JsqJW206w1OiOZ+4nMg7XyHQq7QnOyTWM0W+DyMmu-gpAjw@mail.gmail.com>
Subject: Re: [PATCH 1/4] agents: add unified agent coding assistant configuration
To: Kevin Hilman <khilman@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org, 
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 5:06=E2=80=AFPM Kevin Hilman <khilman@kernel.org> w=
rote:
>
> Sasha Levin <sashal@kernel.org> writes:
>
> > Create a single source of truth for agent instructions in
> > Documentation/AI/main.md with symlinks for all major coding
> > agents:
> > - CLAUDE.md (Claude Code)
> > - .github/copilot-instructions.md (GitHub Copilot)
> > - .cursorrules (Cursor)
> > - .codeium/instructions.md (Codeium)
> > - .continue/context.md (Continue)
> > - .windsurfrules (Windsurf)
> > - .aider.conf.yml (Aider)
>
> This doesn't work for aider, probably because the .md it links to is not
> YAML.  When I start aider with this, I get:
>
>   aider: error: Couldn't parse config file: while scanning a simple key
>     in "/work/kernel/linux/.aider.conf.yml", line 3, column 1
>   could not find expected ':'
>     in "/work/kernel/linux/.aider.conf.yml", line 4, column 1
>
> Not related to this series, but related to aider... I'm curious if
> anyone has got aider to work with the kernel repo.  It seems to have
> problems with large repos.  When starting in the kernel, I get:
>
>   Unable to list files in git repo: cannot close exported pointers exist
>   Is your git repo corrupted?
>   Unable to read git repository, it may be corrupt?
>   cannot close exported pointers exist
>
> but neither claude nor gemini-cli have any problems with the same repo.
>
> The aider FAQ[1] mentions using .aiderignore to ignore parts of the
> repo, but even with an "ignore everything" rule, I get the same error,
> so something seems wrong with aider and large repos.

It worked for a bit for me, but then aider fell over after a while and
refused to run with errors accessing git. Some suggestions to repack
the repo didn't help. In the end, I just ran it without any git
awareness.

Rob

