Return-Path: <linux-kernel+bounces-733314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE53B0731C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6271C255F1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ADD2F3C2C;
	Wed, 16 Jul 2025 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnKajPBD"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC62F2C6D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661023; cv=none; b=iSPx32kX8o8QDOyJboskXnYrq3Ol6EgJgUPfvURMhtp6G0lNStMDDgT9zK7LL6h3GC7eb1ElgZi6jTi79AdrKkFKoAh+/K4Dhn6aalpVcctL91gPy1kVz52vOBsVvu3Yd1sQcYOdDFfZG/FDra4mtY/k++YUmFvx1nXz2m25veY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661023; c=relaxed/simple;
	bh=GwY+ydg7QNO8ffgOhspbvFzuLK5V0VJeLu7G3qLFQ9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nA+7kCxmuyTsTJpmU0JEmZy1akWGafNc7ZQS9xjwzz6N+X5cwTj9hWdwT0sEZPCLTbNaN3da6zPbJBNQokrzh1TI+GL6UY6ZPMfEmvkYgxOO0VWFuHTPRRymi3ISVFyCHP5k0jgGufZVFRZhAPNbA8neJuk1pDBX6oRz7eMIlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vnKajPBD; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6120049f09fso3080214eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752661020; x=1753265820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GwY+ydg7QNO8ffgOhspbvFzuLK5V0VJeLu7G3qLFQ9o=;
        b=vnKajPBDLQoJuBu1wcoh4+9baoAfoU5a+icFk2HgcdAex4DqZ9wDHfdX+9M36A1kiW
         SzKTA/rZxtjh2QTarg7+OnKAE9QI8tLwAxlNs1pxxf6WX7MiwN/2KbVJzcNDfaaDrlMD
         KXy5fxIr25qFFDMjYmowwwazpUkLadav/fkNKIS4lsB6sRp+cnOVOt57e8rAmFNDNTN2
         60nGYg0+S4FGRZm/Q5bpSpQOwlkimsVoZ2WPAiW3KbVKylmEqIG6A/9kqftOcuXhE+xt
         BKnHsj4F85pQBDLzPvG4sJdIWqNGKBO2ed3TRdfGxj8GuBxTcIzXfZdowU4Xv16/VW9X
         mukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661020; x=1753265820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwY+ydg7QNO8ffgOhspbvFzuLK5V0VJeLu7G3qLFQ9o=;
        b=Gz0Aye+3+t+MYeyZQAZs6jm4pmW4nJE0pRj5AK3JQp3bD3Ru22HTaMlrqXVK6BBz2W
         dujnXV629dqU8VLa8a1LvJvcuTUJuHp/VJtJmI7Xemdo5RNvWm5RrTRpDuU6bvlpdbds
         wu4IF5hFoPZYw76ja68WRrgd8hedf65yT7kNqVBSehiV8kSZafedpf1OWcNdFc1O9VIu
         VdGJDJcp+Un/Okl6B/wm+DWQAnWF0Sf43GqTM79hyYQxxUlWTe+2O8h0uh2pJ2U2SNFl
         3npUh8HWDTNfMpWXNbk6GS8al/jntz+cWBZaGtbOpCOwcGV9Bm1+Afhl1lnosb3euqRT
         JRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh1ofcDDDDs/mzWO/Wig0P8LACQNGf65TYBbryFyWvVLJ4Vs5kRhbm2fKy3lTvRRsCtWpYnbPIIAnul6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXAQZljmAon3EJbGMJAuAB9BKipcVQDjmoemr83l7TSKjAZWj
	SQqXcWFrLo+s/pjvGStA26K9HP/4jXsva7M+PMhbLIsiZCnjRNH09toFp8iO9EoMnOY+9el0nNa
	o7m6nmGjD7E4EY3zjXN4idQGLR89Evil55EYhW8btbA==
X-Gm-Gg: ASbGncv5tyj9SlEJyNtk78fAPbMwTCPnxRo7cQHnWBckKN8NLqhPodCtWvnxrhzysrD
	Z5y2l3ok8gJj83ZPyl4qakIkMno3tAfZhBKzL+FiEd7BpFyr8FJk+5ZXnyCWRJ+FK0rOioWavZ7
	HlBMrbMI0M/PE11qOaNkUzftpsChKl3EOiedUfv05hf4PnAHOmsV/VIGeb36xv7tNM2A1943+dr
	fSW1cIM
X-Google-Smtp-Source: AGHT+IFBJVxKAXo/cKR2ndkM9X7Bsz8i7y0trbE2KS4VktpXvhySzwMgUoWrnTeCkvYzPODvF62WRFigY53HbadClC8=
X-Received: by 2002:a05:6871:71f:b0:2eb:a8fb:8622 with SMTP id
 586e51a60fabf-2ffb229c270mr1371804fac.15.1752661020506; Wed, 16 Jul 2025
 03:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703-ufs-exynos-phy_notify_pmstate-v1-1-49446d7852d1@linaro.org>
 <yq11pqiaedd.fsf@ca-mkp.ca.oracle.com> <yq1a556776b.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1a556776b.fsf@ca-mkp.ca.oracle.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 16 Jul 2025 11:16:49 +0100
X-Gm-Features: Ac12FXyVvVETCy_fvebhSLHtpuQY_pd3_d6Vt5LZcabX59ifAwOETZg6eR50R8Q
Message-ID: <CADrjBPrCBG4ZatLwYyH07f5EQrbO876M7WqXX7UfgD9Cg8w9Uw@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: exynos: call phy_notify_pmstate() from hibern8 callbacks
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Vinod Koul <vkoul@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-scsi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

+ Vinod (phy maintainer)

On Mon, 14 Jul 2025 at 23:15, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> >> Notify the ufs phy of the hibern8 link state so that it can program the
> >> appropriate values.
> >
> > Applied to 6.17/scsi-staging, thanks!
>
> This appears to have a dependency on a patch series aimed at the phy
> tree.

Thanks for your email. Yes you're correct, as mentioned after the ---
in the patch this has a dependency on the new API proposed in [1] so
can't be queued currently.

Thanks,

Peter

[1] https://lore.kernel.org/lkml/20250703-phy-notify-pmstate-v2-0-fc1690439117@linaro.org/

