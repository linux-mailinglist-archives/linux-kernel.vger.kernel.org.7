Return-Path: <linux-kernel+bounces-820275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE29B7D5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1C84E19F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6576305E0A;
	Wed, 17 Sep 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B82kULZG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37027EFFA;
	Wed, 17 Sep 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098903; cv=none; b=kPw5VQSOYw6kBulhB0mVPiFx95dky318gPdn+GeeVrEQcXnXgU35Dvl6ssMtNKft/QDFkMUhUZjRwoyGeIu9l2aM1hKkP8KerytWMXmW0nZcBtTqFldm/dih0WMaXl6jWdGdt+y/+GdzNY/OD9xYb4PJSi4cqGL4vWMRvcISeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098903; c=relaxed/simple;
	bh=iwfyvsXvjemSs8NGZTUJivWchTPlegpRIGmh6EEMldc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyvKrbOhyclCIGkiv+NG0gVS6ijRvkqWPVoT/71jo4jvOroMekgiMSxJ/UoZ2XkmjdRAPQZIuiKPm9Y3iztlsQoB+YBMQfUpFuMZiTUNi0Qbr6YHcCYWCghESht8TXGzqHFkk7EKB+Hhjd9wgheh1exeJe9ZBri6iV+JREH4uZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B82kULZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D79C4CEF7;
	Wed, 17 Sep 2025 08:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758098903;
	bh=iwfyvsXvjemSs8NGZTUJivWchTPlegpRIGmh6EEMldc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B82kULZGMIivsbQvojRzNVID3EXweoN8jE8E/p7tNM0zV1wTYROnzd89QDB6D0Heu
	 G62wFozrAPZ5bGabQwdXANwbb39xen/voiu0sJmtHernEd38yjMYnOMDX9Hsq39Tpr
	 zsHIbwlVFXjHFFpTblrEo5SvE9sxqxJB8nrRgR0+BsNFcCFCK8Y15YRDbK+tNwsAu+
	 qyHZxhpOu2OkPkj70lHwemPBW33zpomBHUQhgOpIfW6EHBNAuGwZaqYht65pHeUDJd
	 e4gujxuHguCTss6ZObciVT5/GT2H6/ez/Kp5t4qkUxcvGAuIWaQ9oui942BE4pCgb6
	 8QLgf1YmBENCw==
Date: Wed, 17 Sep 2025 10:48:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/21] scripts: check-variable-fonts.sh: convert to
 Python
Message-ID: <20250917104818.62862b48@foz.lan>
In-Reply-To: <52932ede-eb04-4275-a051-952bc2859cf6@gmail.com>
References: <8a77212d5459eac2a98db442691930425a2cbefd.1758018030.git.mchehab+huawei@kernel.org>
	<52932ede-eb04-4275-a051-952bc2859cf6@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 17 Sep 2025 10:09:05 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Tue, 16 Sep 2025 12:22:40 +0200, Mauro Carvalho Chehab wrote:
> > This script handle errors when trying to build translations
> > with make pdfdocs.
> > 
> > As part of our cleanup work to remove hacks from docs Makefile,
> > convert this to python, preparing it to be part of a library
> > to be called by sphinx-build-wrapper.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> I could apply up to 05/21 of v6 and did some quick tests under
> Fedora (where Noto CJK VF fonts are installed).
> 
> At 3/21, "./scripts/check-variable-fonts.sh" doesn't say a word.
> 
> At 4/21, "./scripts/check-variable-fonts.py" complains:

I got a little bit confused with the above. I guess you picked the
wrong patch numbers, but yeah, there is a bisect issue, caused by
the part reorder I did moving this change to happen before adding
the script. Basically, I updated docs Makefile the wrong way.

Thanks for pointing it!

For v7 I'll ensure that all patches will properly print the suggestions
from the script.

> =============================================================================
> XeTeX is confused by "variable font" files listed below:
>     /usr/share/fonts/google-noto-sans-cjk-vf-fonts/NotoSansCJK-VF.ttc
>     /usr/share/fonts/google-noto-sans-mono-cjk-vf-fonts/NotoSansMonoCJK-VF.ttc
>     /usr/share/fonts/google-noto-serif-cjk-vf-fonts/NotoSerifCJK-VF.ttc
> 
> For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
> Or, CJK pages can be skipped by uninstalling texlive-xecjk.
> 
> For more info on denylisting, other options, and variable font, see header
> comments of scripts/check-variable-fonts.py.
> =============================================================================
> 
> Of course, I have followed the suggestions in the header comments.

I didn't try to follow the suggestions to solve the issue on Fedora yet.
It is on my todo list to test it.

The new script has an exact copy of the instructions of the previous one.

So, up to patch 09/21 from this series, there won't be any change at
doc build, except for the script conversion and some code cleanups
and reordering.

Patch 09/21 moves the env logic of FONTS_CONF_DENY_VF to the wrapper.
So, in thesis, fixing it before-after the series shouldn't have any
impact (I didn't test yet. Will do on my next respin). Btw, we should
probably document it at make help.

If the instructions from the header is wrong, we need to update it
on a separate patch series.

> So I have to NAK on 4/21.
> 
> Regards,
> Akira
> 



Thanks,
Mauro

