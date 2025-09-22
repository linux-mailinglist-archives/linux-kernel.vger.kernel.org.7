Return-Path: <linux-kernel+bounces-827423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 258ECB91B96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B03A9FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EA222425E;
	Mon, 22 Sep 2025 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D/dME9wQ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4181D63D3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551436; cv=none; b=QjbSElgbTKLn4iZzdDu9DdfQfHlLnYYDAQ/YJNSeRVSMMa4xYc7A1Prn+P1cjePfRJZKB+jmhJTif/nQy0zVMWzmdGm5h4V47QCqg1RSuUtXrGrOxvcpLKz4ZIeDIdjAOhbiYtU7cFcfpHfdEPEWf+dTLmWCgnOjruNpE0AeZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551436; c=relaxed/simple;
	bh=eiNsGceEGVlgJiEkBCDzw9gODtxe4yqUjFX20CRK3r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lldnFm9GIoWf5nQAVPK48mmnNjMHMtjMLMMCD0se/miJgYkEwoaLTqulLVN3PbRjqQ976mb9Z/9vu+GpRHhsupLrwlKcJ7SpbCKXapL6OLSD4f3ud+3/jhuVRyqCfJv39cPEPFrRI2xMOzG+FNtO5nIr5zhEavXq1Q3O1kG1fVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D/dME9wQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso1582536e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758551432; x=1759156232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiNsGceEGVlgJiEkBCDzw9gODtxe4yqUjFX20CRK3r0=;
        b=D/dME9wQbi7L9KFtGxo5qFhFE6pqH7pi9/i5EudwtbFZ8DnGxXZhv2Y96zAZbCe55R
         qgHHHerWXNO3Jw2daUcsYsDrqPvj5Ghn795yPlsHlKM1ylQvDLFd0RUsocn0CR9TQA0e
         PHgCGwmZ0lVSca8eti8Fmq/vOAnKF6D8jujMUVnSk0BdPzwG75yStZ8ndqDmdVH/DrLr
         ZRw5Ja/XXF0RBbjcsBZItXWgIPp2gDFoJZWHzbFh7ifsZS+oV3mZ5qeO9hb2rIe3cVil
         yiO08ktGCH3eUeHL/mgfBwO9Jvv5VW1+mLHxIYbK/66JTCrA8y/qM33mgC3DKnNhf/Fu
         3M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551432; x=1759156232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiNsGceEGVlgJiEkBCDzw9gODtxe4yqUjFX20CRK3r0=;
        b=EsDYdzNhJhiYCfmwe101DGA1AuGAhl1mvy591Va02jW+jDIqjZ+U+gWb8aujG5g2MF
         yrDlWVfIpbsd1i54TEKdTllrco0m1UJ6moij5lZPWT7WRjwhinkk1spHMm58vBX18SEt
         MOREbmfGPXR2JDVC3e9ljri0sF3mzeqLNHEJpek3xTFeGE3XMy9xX0jvidlq+dX4bnJH
         SxfhSoSEWxavDpcqb5/Sxae9nyrmpNzReMGnI8y5Svj5j0xltB257gWeiRVE8yyicvf+
         oG49wMSeMa0HETOe6G2SjIw+QGt8DzlZq/PIOpWUYX3Aft6yUJAk9Kh+0/QInrPT4DMg
         K6kA==
X-Forwarded-Encrypted: i=1; AJvYcCUbzsEWgxir7L0meKRmbRYJgQaq/Csz2VQVCgy+qXznRVsFvK9nfOfU8ofZDalc+HoqixY36MXVZpbFRBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMig1/lKOSQGf3CfGnO1kJeYTzyAFryj1u6LKmtkYR8w1K87a
	Qv7INJL+Sfe73LdIN2kR9d43GAx5wSF2Y2Os5cl5pDMW8DL8mE4La8DfNc+1WJ4NkyZn1tlBJhP
	RAf0OPgurXhQ+f43GQk7J02mYoUDK5Ztw3HHqzlzNd6V7hR40UlSlypQ=
X-Gm-Gg: ASbGncsr2OGLqAhJsiQTAO8yHAKxI0ASmonbiBBCVCAx1X6E7c2MDXvz09R0QnT9CD/
	H9h/sAJDFVnkUPpKBkCseHgqMvjC0njqurvrcxlJ6TWLxc5b60cgRgwfPXWRo08pFOdCy+PHPVc
	9LCVa5KSYfqm5nSMfhBxECZfGvngGuWwAofB6v4zfiqFoE4nWV5BaGccnG/UtRVDsc48yVf/LAX
	vQKB3UGARfkDayG9dyKGLscOrg3FLM+Dpr4Kk0S
X-Google-Smtp-Source: AGHT+IHnljy6MP1njBU2u6c+KrnvxWSTFUDgkOJM540hMZjQHZVDbhSTXqE4U0kGHkmVjewhciQ3zOA1yfPO/vG96Fo=
X-Received: by 2002:a05:6512:12c6:b0:572:f47:d10e with SMTP id
 2adb3069b0e04-579df8cede4mr4364273e87.3.1758551432236; Mon, 22 Sep 2025
 07:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145040.290214-1-marco.crivellari@suse.com>
 <20250919145040.290214-4-marco.crivellari@suse.com> <aNFZ1huhgmMkaIWH@2a01cb069018a81087c6c9b3bf9471d3.ipv6.abo.wanadoo.fr>
 <a2b31164-2175-4fa5-b003-c0be8301bc9a@paulmck-laptop>
In-Reply-To: <a2b31164-2175-4fa5-b003-c0be8301bc9a@paulmck-laptop>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 22 Sep 2025 16:30:21 +0200
X-Gm-Features: AS18NWBzdelpp73CqEkT85EM-0gvDu1qtbxRp7JXunoUtqCYIa9fidb3-H7hIxs
Message-ID: <CAAofZF7DURjSwN3sRMDd44eq2d7zgDBSHtnY-UdXaG7pQac06g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rcu: WQ_UNBOUND added to sync_wq workqueue
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:27=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> Applied, thank you both!
>
> I will push these out on my next rebase.

Many thanks, Paul!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

