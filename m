Return-Path: <linux-kernel+bounces-822395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D63B83C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258B63AA4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528152F9DB8;
	Thu, 18 Sep 2025 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZUPqNwxf"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A02FDC31
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187256; cv=none; b=qGTdKPwen/Dqb+CHq6psCNe/jVamadlIm8Ps+QsicwBnHetuYDH8d6b+b90mCinhwsebThH+eDudQkteG8/NFkSVvRBstHbUyLawt4lBiA9324wFKxRJvZcZaoFwXLYeEOHa1CRRVXVuiGcfx8xjNrGjxOiMNjoQatJBiruHWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187256; c=relaxed/simple;
	bh=TCE1d2/F9tKcuAnKIUgFTvGNx5UdIG1BrDoUsI/h1jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjLJ3wLgc3WbHYwG7Mm1pgnFx3Z164PZF1bnSMTCK0+IuOT33VNQfcPgwBRFvZn/aJ4KeJekIiSa7q1emiIRLC0jy/AHp0jhT6Ape2bBowINTOcxTSUPtBwy/OJMlNOCX/rcaIdjno6nikvKCZG1F4iymwoaefthlFS4S03lLFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZUPqNwxf; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-336d84b58edso6209421fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758187253; x=1758792053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCE1d2/F9tKcuAnKIUgFTvGNx5UdIG1BrDoUsI/h1jU=;
        b=ZUPqNwxfDc6wwdtqGTUE8x0SeZLguPWtUGFFdj0WKdU+pv0dcCHM+4TlygInyhYotF
         wpDA3wNSZBjCqVtLwpwJO8QiGyOzzEXDJ7JB7VTSMVoOhCsISnBmCUTzM24oEUu89hrm
         Ad2Ue9ICxW1erXjwIcJBePAH47OF6/REcC+P28XVPa3yhNsCuZquW0uYgMl3s+Eid6hV
         /OvHWJ0zgnRWXVSOvpVEZQ8v9iPW/K4kpbT8Wefjv1yJI0iy2YZ6CqHw3WsILAmU0NQP
         kmya2O64qlvvNyuGdbqAFNOF1t/yHF8RKziBwkTFfHbAEhkwa0OtlE/wWfD0nZaoohMq
         yhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187253; x=1758792053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCE1d2/F9tKcuAnKIUgFTvGNx5UdIG1BrDoUsI/h1jU=;
        b=imuh8ZqVXTA9o1Zdd16TPLIGoY/fngLF7jgoqvwkjBQMYNQ7Ygks6EW5U0yif3faRS
         3+WlHwQypr8bk9BXAVimQoc0r6CqikieMq1S4OtQJuQpBYZxupnoFuJPyA61G+pMQvjq
         W6VZC1F6ZaXpLfY5HXd9FXJCUiyfxt4oi/eU4pUPZqX3zmoIqoZyER04Ccp6M8Y7ge+Q
         seY4r7pTk69++l3o/LFPf9AIouj0/X6fYwleubKPJzBy2SyohiRLoaXR21Mmfv3YO+an
         fydBePL+FaaRZGM1TDK+1XjfnkmVE+keVouaOn7YAEXxnl59RJDYU8KRqdsJBEOcudTP
         hf6w==
X-Gm-Message-State: AOJu0YzSKj5qIIEocT+dPE9ALix4/cz7KOCRVBjAVwD22208B7/hW1iU
	c9JWUKvsurb6MZgJsP64UPpUWdeonqfObzB4YeUrtndc/VNHd6e0JGeHuMCb7sfqE+5pFQcVcsF
	8HsOzBS8T8urK/LrnOO3g4jP2Lj4tfHRLLdPFADpUUR4v+DEKKnkn3Dc=
X-Gm-Gg: ASbGnctm2FWU5IlvcRU3UtNCvoRH6d48daeao0fIcbXw5GZ4FaVU3qDMKdp7kM6h0wt
	GJYWDBWMU5cpWKsljincBH3Mv20QJOARyVUlNoCTK8DnueIjI9Q9KtsPay+aAUop4gd7RN/MsYP
	abnKwGXlBLVic44yAJoqZudvy5RhBh8ga2dvcwcSHqyumXhTnSm84ErHZQrZO2zSVnxsISozVcb
	mh1vCqmauSTRB+NF2loXXe1Ttd2CBF1XSfb+auEADYLnwFtnunJT7IReE2oix+DOcQbYA==
X-Google-Smtp-Source: AGHT+IG3lQwbjQoCWqhOZfFGtRxvks3XQvszM83wU/zGVXvaawKGcOSsxwDAFg5NJVNHdJ7v8aT4BhPuhrhJ6GsYH2w=
X-Received: by 2002:a05:651c:2541:10b0:337:e4a0:cd11 with SMTP id
 38308e7fff4ca-35f63aaf1b9mr15519771fa.22.1758187252841; Thu, 18 Sep 2025
 02:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914134426.43269-1-marco.crivellari@suse.com>
 <20250914134426.43269-2-marco.crivellari@suse.com> <aMnJ-7PKbo6Lf7h_@slm.duckdns.org>
In-Reply-To: <aMnJ-7PKbo6Lf7h_@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 18 Sep 2025 11:20:42 +0200
X-Gm-Features: AS18NWBhh41GmRa7CF6IyDOm7fm4HH9iqiqvryq1R-Nu87HZh8zWTMRIsLUuLS8
Message-ID: <CAAofZF6-s3fObu5ybbbUF9t2ZOmUhDcRwm+Uxen6Yp1wJZWwbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] workqueue: WQ_PERCPU added to alloc_workqueue users
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:35=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> Applied to wq/for-6.18.

Many thanks, Tejun! :-)

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

