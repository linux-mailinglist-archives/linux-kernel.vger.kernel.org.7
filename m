Return-Path: <linux-kernel+bounces-851773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99795BD7377
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC53519A2140
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72B52F7AAD;
	Tue, 14 Oct 2025 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9PCf6wC"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04D16F265
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760414658; cv=none; b=EDr7o5e2jqQjJs8dgB5MFUiDh+EBdeqJtvaE10OVIQG4ZnULdTOcSZuw2TH+HzIhf/dvkSH+5GLIpjrtHNRG3S/zpll7NWil1VqFTQEFqaXx1dAE0ZeUqz+T6pOzFXgHUG2fJiHyh/IBz21PylavJyUlVemc7j/q9w6Rtkapxyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760414658; c=relaxed/simple;
	bh=ZlLsbu+bTFy8wydBgazQtZsA/9vcLNVB+6k0RNzBels=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbrXtcGGNYRmv5MGRKUTTjCJQ+ThOMqDGieOFgh9QX1Ect9CV3HpeJq1TnhIbEtRJa9pYyrNBiLcUhWCqi6dy0rxSTfMgelrCoAF2hBQLIPDylXDA1b0C57j+8yVdajQTn7nigeKDW/LRexfRD8xiZTPFTr8loZ+BxdoOp9PsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9PCf6wC; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-633b87e7b9fso4499776d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760414655; x=1761019455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlLsbu+bTFy8wydBgazQtZsA/9vcLNVB+6k0RNzBels=;
        b=Q9PCf6wCaajcYe9XDTetkkfOPyVNKFyWjcbQs5XW0S/lnfFF8N0u7wj2gxg6EKVZ6U
         lBJN9r/8znCBoiom/ZtE7vpnkUfAqxieO8l1bA1e0n15VkRrj7S/RfKVtXdpfazi1nzO
         Evx1FipQCGZU2VFkaHTmMhov9sIHC9uK3DTcy8faSk3cKFftGoyVkcdiQ18ptuIBiGrV
         iV/Ov0Hb3QicsdRN2b5cCfhBelF4XglDQ7h/ulpsv4F41p9kGa29NR8Jr43mpIkmajYA
         K4Q7tG+gdn3dLlnviwvbxAqtj5L9QCwvsHe0E/QJFIktVCfxB6Bs9s8UsIC5NYuvi+X0
         6XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760414655; x=1761019455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlLsbu+bTFy8wydBgazQtZsA/9vcLNVB+6k0RNzBels=;
        b=tDFg8w31x83IIdvSYKNJAPNRxXFUds6Rzljs9pe4WAhpAIo+FlxqbdbaKPa5v5hXUC
         TpU0am1Wx5ivXN3bq5T5odt94KPAjWILurH2AjzhUrIZNa9m0pVc8g0HqHtduBEY9CL1
         Ivn2Tx5PzWwhtLPmG5a9SNk1JZ5mMRngWqczRl5SHFy3xRhkPqs2aGhR6VS0R+mO0wFc
         b7aF5juJOX6RUxvG6kQ9SuO/pTHssZ3eItlkWoSCyT4b7kJOgSk360xOyX1dIuah51si
         ehFpfBAMmlFJa97cDSX+JN6HXAueq8kUtZzLg4aZgLirKKTWCRQjjWHtOEayc46ONfju
         bWJA==
X-Forwarded-Encrypted: i=1; AJvYcCVWI5Ulk1sZjvr+KGYso+P49yyTtmZuQljG/FIR7TyruBhE1i+eePBN2LGsJmvgR0tWqx/1P1C8VShBF/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrooE0oxkVO+JhhhYlg09OEpFFJYSx9tpRWf65YfuHCWSz38if
	gIpnAsAxmsiLvCA6Z2AFXdlXd6yoRUcZeG0OGz5E8ezFh8+vvVE2u/jUzXgRlHmbk43QJqsF7YW
	kUOlhFMpsT0dZmURjj6LiOc1DWGjsVVA=
X-Gm-Gg: ASbGnctEJgRB2Zsv7tT7gcUTqSls0bAoXyoVjTl2dEleKsUUYZNwfFWsKFDA+itacDa
	wkxdx3zdTXXMv564aOEeXWfwQQ/BOmmUTQVwTfFjU7b1DGSGRG53hwGO9UgcI/Th6XrWU9rvV00
	T799Z5ys4+Na5+aSexn64eoWrDVgYXcpabVkLnyEdMdsVJc3KB0Jj0C6SI0W4ZAmjiqUQqgJWMl
	X3mmmvgbNLgygpRZK5bW+/DILvFz3C3juIQCls5KYw++gryTBeJoQ53dJZm9psV72cZV0Qfxvnp
	FzXcsClUBzhELQlBzcQyjG/reA==
X-Google-Smtp-Source: AGHT+IEKl8GhYUzZqq5KI3es/Unb8qf1fU24yfR3Th634G+85UZwEzV3RRxo6zuR0ELnukwcBrsk0rTTyYY3GXjywm4=
X-Received: by 2002:a05:690e:18e:b0:635:4ed0:572b with SMTP id
 956f58d0204a3-63ccb92c021mr16769294d50.47.1760414655375; Mon, 13 Oct 2025
 21:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014035720.346268-1-kartikey406@gmail.com>
In-Reply-To: <20251014035720.346268-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Oct 2025 09:34:03 +0530
X-Gm-Features: AS18NWDzAynPG_VfiI4lVlnyK2Etdss_z91oHt88SHY4XTwNK7WJJ6GKSFws07U
Message-ID: <CADhLXY72yEVDjXWfxBUXfXhNfb8MWqwJmcb1daEHmDeFW+DRGw@mail.gmail.com>
Subject: Re: [PATCH v5] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
To: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com, 
	akpm@linux-foundation.org, broonie@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Please disregard v5 - it's incomplete. I'll send v6 shortly with both
required changes: removing the v4 check and moving assertions per
David's suggestion

