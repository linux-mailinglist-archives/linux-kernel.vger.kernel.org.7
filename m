Return-Path: <linux-kernel+bounces-886068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9EC34A15
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B56E1892E80
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3092ED848;
	Wed,  5 Nov 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f3ZrX8ms"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481A2EBDE5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332988; cv=none; b=odzuXVtrz+yI/ANVtyXS40Eq1Zhacfn6LYojyBzN0G82WpMsjJrKLcNWiu/MkGU1D2gwG8ls8pb9HHboRISRwR7t0U5Sj60L4fmlA9IKiMstKsd8TIaWp/psglxhv69kWq/ZSogr07ZpTQUyxKipz7AN2G/ZR8ps13NBppVb4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332988; c=relaxed/simple;
	bh=y89yY7gWpcJMa11VuVNSbSETivlz9DMa4tLK5//0vTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBGO38jqHwjozi/XhmbBtccZHClZfDOEL9gbbytB++WWURc+nMKAMCwG2mnHDl9ubbsAOXGGh86HTKCL75i1nSrJV5FXwH9tPaufKW1czmVq+bBy1rzGqGzbzrW9Fb96z6fAkDkE4X/8Rozru1L1LPAD50gvcEoLA2Vn60YAfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f3ZrX8ms; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59445ee9738so122003e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762332985; x=1762937785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y89yY7gWpcJMa11VuVNSbSETivlz9DMa4tLK5//0vTE=;
        b=f3ZrX8msGAJUbjc5/jb15ATXgeA2BZiefhv+rf0QkdM4RTWtLwg+NbTWDOzpc9d81M
         L3zH1qEsmZsZxnXV4t4c5sbEy9DGEmj5OAZeghVvpdHkhDe3nYdyxbjRfziw4MoRNiWg
         y736heSNc5BYsEG9PhowAG/5n33Syn1X7z+58hJzNzqJzB3EC7kshG2/+gHCH3bac8RE
         VFH132psvactkc4/zc37+2XkY/DsskrpbIZrLpSYswCivyyMjTu7bjP8IiR2NtletPY+
         8wYNtrDjVamfv2IN3x0221lD0OT21G4qU4Vbu7bI6LyX+EZUArKDGSB/fvnarkynPCO8
         ME/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332985; x=1762937785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y89yY7gWpcJMa11VuVNSbSETivlz9DMa4tLK5//0vTE=;
        b=xR7ai4fd/oQojjbBHOokazoxaWUdQLoq8nf71m13QNQnIrtmiz0ztB2z9OO9SFa9K7
         zHXGb/tCj3X97rEORlzwWDA/jtJSfYVMj+70Q8v+KFkClBpFp8AlfPPSiHUI/z6r4VcB
         Jfv+d6Khaa4xXjVyZxggNmhewdEwuoBPLsi6Wc8LhMVzHxwAdbEPw3Hm/wXhNxgOjpka
         4tUPfQHyERYDsITdLY0Ci25W9GbF8+xVQ6PQXgTuln4M0XOouGLvGkWV6Lw3fonn9zPm
         Rza+fE8k+oF6q+IiuIoczmHUY2qZsXpPw+Q32/3EBwoGXrfvte1/lS705EgUfvoI6d0S
         XnnQ==
X-Gm-Message-State: AOJu0YwaNIKtw0aI9toMbKEQJN2xrhQGk0zG1UQaJqJdGCtkb1Ln/5Hc
	s9vrxkcFCCNFb+cRbw9/PSR+/MAcWfzyV9bvOeWJs90uufXJTL1w9Kuvi9K6RUhglaPBPg6hOT3
	G6ayJMzU35v+JN1Npxwk547Onulr2qP4GmikAwl4YkA==
X-Gm-Gg: ASbGncvJUNC7qsfc3+ar9u/m6wNRpHY3QEdO05iITiu1OcwpzfGvyG84JIG9lu28gTb
	1Nc/WiIMLmNNrW+EmiVBwRXZVTi8rxQ13x61VsEX2wqzeLxUzMNpPfT5HZn+gxVtM35d5tCORn1
	Y+4mWl4dp03bcXQd0p4z5BUJhIKnGj7hlURjotXE85De3XLH+f5Zz0XL56EDDuzDSPGqhHYCuq6
	9+kFBtZYZNEyYbmV7KcQb9m0/SRZEKN5Dmj34tTZr4WEeKyH7OJn2hsIFz1XLraRTpo0V4mT2VI
	PTUwR+jy6sDdm+Mr3Q==
X-Google-Smtp-Source: AGHT+IH2rjJIpsbxE62mqch4SVAuW2LvIiNka9F2ObXZuE+K57palr/b0nf28uVcx1pSTOxZ7IFHRr6etH2UfGtiiGM=
X-Received: by 2002:a05:6512:4014:b0:594:31ef:daa1 with SMTP id
 2adb3069b0e04-5943d7cd5e6mr658796e87.39.1762332984967; Wed, 05 Nov 2025
 00:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104100032.61525-1-marco.crivellari@suse.com> <34ozsv3e6ujs4rn6c2r4nrjcjifgazddy5jecwur6atfcop6vp@bunf3uyofmb4>
In-Reply-To: <34ozsv3e6ujs4rn6c2r4nrjcjifgazddy5jecwur6atfcop6vp@bunf3uyofmb4>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 5 Nov 2025 09:56:12 +0100
X-Gm-Features: AWmQ_blYxiJXoPM8ooqtIknwlby_KtGtLFK0wfQXFZtlNGpi-o6VVHAvM6Wyl48
Message-ID: <CAAofZF7zQUgF3xjxJr-Og4YcJLiaPopZANi37mC7qVgkvYYp_g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] replace old wq(s), add WQ_PERCPU to alloc_workqueue
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:42=E2=80=AFAM Krzysztof Karas
<krzysztof.karas@intel.com> wrote:
> thanks for addressing my comments!
>
> Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
> on the whole series.

Hi Krzysztof,

Many thanks!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

