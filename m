Return-Path: <linux-kernel+bounces-888077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 576D3C39C83
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EDB44F393A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7376F30BF52;
	Thu,  6 Nov 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VMlOIfI6"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FAC2F362A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420728; cv=none; b=Z5N7zr7zEHbVTEszeQPcns0faGajHJF9e8/UDDIWjEHVFJb+RpIN0ffNH3ewr8ualRih58lDgqoWrG9kYJ6+vcvOsTQHKdvqszuNNdemW2So4oesJSwQ6YInjVSEMwmjmN8MqHTSo8YGzmTJ4HbtODelC53XsWeX5A+exLPYit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420728; c=relaxed/simple;
	bh=/sxIfI5DRQ3SPvpnSNNK53/FGYWQ1QcBp8l75KlMgVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UR3fpulB2wnLJpx667gRf0Rbl+SJSr1DxnY+se4anzjJt7eNNmll7jNoRl3Qz8t4n3LnwsQahy5+Q0hHaI2zLDc8MAp+eX2Jd3KAEZz0nvB+wUGyYXZij2N1BW6v8cUlwTTq904V//z3q0JDK9tx9PC4uikhwXIN4ieVCY221Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VMlOIfI6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59390875930so1070741e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762420725; x=1763025525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sxIfI5DRQ3SPvpnSNNK53/FGYWQ1QcBp8l75KlMgVQ=;
        b=VMlOIfI6o0NyirBlLHwdFYckkiD19kZl0HYGX15vu5OktmUbVYdFwyXEcYVHjeLEHq
         dyPwiE6YH0EL64BfsA7gfc7Fy1D0VdrFYGjF2au42AwjucJ95Z+PTuqi0WOKAN847gcn
         eBjCRwO0EIx17qrg1L5GPi+kSg/WncKRpgvZCOFL9GXxbLPbUf1u4nLC/KwAFG5XT+o9
         ibF3xf4I7f+vuUdGccjZMt6yWzxkdYRSiLR6WTwM7QCVpMKbu0Pm+O8wROjJ4QW8ZR2t
         qaFTBiskNpGec0lVNqtNOzf8Po4GluSlm3RuVQeWoPfgBXL2TDPm8gn/3VVfamiu4BCW
         8rwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420725; x=1763025525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sxIfI5DRQ3SPvpnSNNK53/FGYWQ1QcBp8l75KlMgVQ=;
        b=WUF16Bwd5RlUDxBv+To5bOvmoIt+nbQ8rDFo1Qw1gFdRkb5Y8wxX5tS2plgdn+R+87
         zk6CU/qHF8D1m3hof4Zwf3li7vCXoiM0uqHo+/hvqDqX1g+Va68xfSZKX4oPoiJ+n0NC
         6oWlLDogOr3tKa4GfqyU8NaHzrzHnzOFAm9vVGx0fzVZfJpSnM8Q4f9G+SDd196t2qpQ
         TFz+MmWyWPfBoE6iuZCsloJ+jHTpcjxk6s5wjhOm/k33pS5WnXVCw+0OGrn5FMF1MbOo
         hIQP408V+dmYhSnRvuj9cOFOSr4aUeebjQKdYMh1247jmX+ikv64t+i2wwu3WJPpLw1y
         n7fA==
X-Gm-Message-State: AOJu0YzT69usqekL+SYe95Ef3lqPrEDqUErGCtrWSCy/nJnKRFdwlIjh
	l3jikYCtaL2n60O34rtw5I8FVdafWTmYqDRrEUkeHRJe+vdInB49rT8cWWZLL+SyXftqhrvAsq5
	rSpo30BmMmsU+zmsJ/UV9t033sIkIAalWGuHpSaqlPA==
X-Gm-Gg: ASbGncs2YFK559nySd8VCELA0omjPGqlTRFZ1kl1We0a5KLbBlstSG+5ic7ioJ1dCio
	GFodLS51+zaJBlXwCvdZ66RytyGbM1GZdFxFpM9JjVI2lxFVtrL8jiMK5DyFFAsH8ahXVe5GZ7U
	vT6c6vMVE3TD2QggwzViVLjPRAs1r3617x2GarKjvx14mg2S78MHttu9T9/JnuyxvQvz2xN034o
	F0YV9LCcL8vy/ogxER8GDgP92X1cDyThS5NOr4EX+mQ/hHqo/IGy9D/apXufOjjUA6jMO197IRH
	RG2gn2cjPzaZ+yZfXA==
X-Google-Smtp-Source: AGHT+IHEizlSd4nxQm5RdcjEYi1pREPn6ZYPXoOm+TkllwMNOV+I7Fyvp7fz51MZh2P0YAJpb8THxFnzKnpuHxcM3i8=
X-Received: by 2002:a05:6512:61b3:b0:594:2d3a:ac3a with SMTP id
 2adb3069b0e04-5943d7da333mr2076747e87.50.1762420725115; Thu, 06 Nov 2025
 01:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105150826.248673-1-marco.crivellari@suse.com> <690bc653488eb_28747c10011@iweiny-mobl.notmuch>
In-Reply-To: <690bc653488eb_28747c10011@iweiny-mobl.notmuch>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 6 Nov 2025 10:18:34 +0100
X-Gm-Features: AWmQ_bkTsYB8TUxbg33EC0EwBhhsRH-lYV4tVnAUtypIfwsfinVpHZBzBTedho4
Message-ID: <CAAofZF5uVBUJ9gpMc-SKzQ0WDeDPeq8dDFm=8HNZaCsNH4rsSg@mail.gmail.com>
Subject: Re: [PATCH] nvdimm: replace use of system_wq with system_percpu_wq
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:46=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>[...]
> Queued Thanks,
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

