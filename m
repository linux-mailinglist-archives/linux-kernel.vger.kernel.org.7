Return-Path: <linux-kernel+bounces-768281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60696B25F45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DABE5C4235
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA362EAB75;
	Thu, 14 Aug 2025 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0XXzwtg"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF42DE709
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160860; cv=none; b=OuExcn4uZWZegrn8VrM2J/SCdkW+4ZPwVm1L3epnOpIBEbw0Kx5Fe3SddqqjJCVPIuv7abIOxOzuXExTvzXN2UTxnY5puXVJchFGafwm4LPFSd4PLDFPKMKgLOTTT7xtMYjEcsHQ5Z1gD92Q+VvqE3m7UQlaZk6wwOf6yvQucBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160860; c=relaxed/simple;
	bh=Il/U4eiIvjz9tsKhNGMfHkx+2RjUv+CVTnBQlCiCA4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aDTokndDszYwPsfhz6AxB17G9WjXrrl9+m0FxKPuvQvFRdKy5cu+oEGy85xvlldXKHW6IJrsEgNEew3kyPXYzoUkBPypCkBRzHPWovhMUwEHWdK/Z0BZY/Gj0llpa+gUZWqepJE8awNpH09qPkfGGHjD1TNgYifaGSvv7DK7GZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0XXzwtg; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afcb78e674eso57947066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755160857; x=1755765657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Il/U4eiIvjz9tsKhNGMfHkx+2RjUv+CVTnBQlCiCA4s=;
        b=R0XXzwtgtRqPM/X5X1LOW5SYL4LorFzrRoy1X3xryzMNZgXeUVrQ3/TAEgviWySv2h
         uXSejoJ+cwhvnqTBsbxOcNzAFNpwMSlODiejkh182g1LFNBXL0p1TgGORrwb11+sSmMM
         zdlQ739v9ElSRQBE59qs5E2DR4/o87rhdIGCjQR5ZGQvP2CM2nO8LpPYAzKUi7JeVlgT
         YWS5IiD1jahvHiRBNxOZetkGH0ofEKYJlKmFrZA3CsituhCo4xgM7B+xZFvBH8opYpOt
         GEDVCPxv3eWRDRi9zgOwinEWA4dRPfOSVXzuAA+xoclR5ez9mT20nN1I0nczXo8lReg8
         foUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160857; x=1755765657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Il/U4eiIvjz9tsKhNGMfHkx+2RjUv+CVTnBQlCiCA4s=;
        b=Rw52Nhw/1MOQ11KtIqz8Cesu+5yU0IvKNiLbxM+FZgAjQBk5HD6/GFxemlqqHg1VS6
         h9ILYxhvuQ+KJqO26YAIJDULvjQJTYsLQK/PQniHNHjQ2n8iFaGviHtTx8Zt4ASPY24s
         bhNiIsEz68gO/ibNSDRFugXGc/QuXeInZmjKEYp0RAvxubDNEPRbg35hTwTgOmc9Js+G
         vUaScQHlRZEfE6Ad9cCZi132A5TMeg1OoqnyL8Dhrq4HB5yjByP5k08K/Mhw3ZyhR2NA
         hTIbZ/Etls0jk/BLx4UKE0TeAH5Y/T7vrIP+5UVe/Gg4S8K7VNeU/cyAWYBYVGu6Vja4
         PYVw==
X-Forwarded-Encrypted: i=1; AJvYcCXwzk4vQ8Ca8Wpd4kRorS4nhAg/Txlef+v7SQe+vhfar4wtU/WLrP4IQbelF6RutBLJQ6UGJcXGnOrj5Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2DVZGxv4ELSOqHuDiamuSxVKpAsvJfNu1kFLgWItlCN+8LFgF
	bfg3GrMzE3d1qSqRd6k9Ijp8Vfi6YPfzpV//tOLwM2LdLiJmkG1Z79M4IPpKRQnY3QqLLZNhqx9
	zwnPV3nuqrrymng==
X-Google-Smtp-Source: AGHT+IGBO/FVtv5Fz5TwK+7kMge1vcO6cPjAknpyeSrJy+CEUQA6/lPkatqZKsJon7bRCNXwfEJF+OhHwNl96w==
X-Received: from ejcxh21.prod.google.com ([2002:a17:907:d715:b0:af9:8135:75bc])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c89:b0:af9:d863:5ce4 with SMTP id a640c23a62f3a-afcbe075846mr174843966b.15.1755160856865;
 Thu, 14 Aug 2025 01:40:56 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:40:55 +0000
In-Reply-To: <20250814071828.12036-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250814071828.12036-1-ye.liu@linux.dev>
X-Mailer: aerc 0.20.1
Message-ID: <DC20LHZMD7MQ.23X87A0C9M3TO@google.com>
Subject: Re: [PATCH] mm/page_alloc: Remove redundant pcp->free_count
 initialization in per_cpu_pages_init()
From: Brendan Jackman <jackmanb@google.com>
To: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>
Cc: Ye Liu <liuye@kylinos.cn>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Aug 14, 2025 at 7:18 AM UTC, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
>
> In per_cpu_pages_init(), pcp->free_count is explicitly initialized to 0,
> but this is redundant because the entire struct is already zeroed by
> memset(pcp, 0, sizeof(*pcp)).
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

[heroically,]

Reviewed-By: Brendan Jackman <jackmanb@google.com>

