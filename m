Return-Path: <linux-kernel+bounces-869294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F46C078CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 715A05621A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26220344038;
	Fri, 24 Oct 2025 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNFsOql5"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DA1F63D9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327053; cv=none; b=D70rVaXyaF9JPDXvg0iXD5/RYyk+mKV69IXGgpZieYtbD7113WU7QcByKKouTDY/nrW+v34wOJg1CRSDPZuW98FSTazeRM3LYCYtldvagghmBsvmOHv8OrejK2sxAy3trMsZgFL0zrt/TDVjhs5rwXDdxdH29at4mjlYFrktzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327053; c=relaxed/simple;
	bh=nsZ3xho59rfJltmBY1VoMiVkLm14bUFIBqE2RDJ0hoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dw+IrVu8h+oxi6xashd15mt2tpWaxXjx3B1Ub40o15U7vf2lQF/GRVKvmkigE7S0uVZMw8k9c8r5eYfeGNWwsMuk5B/8gCvinG3lwZbJ5qp8gAVp/Sc2dq7QpWdqa6vErbhhHhTE95MPGMe7e+pnze03j96Ldb7tUDWW7cccgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNFsOql5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cf1a95274so1699917a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761327051; x=1761931851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsZ3xho59rfJltmBY1VoMiVkLm14bUFIBqE2RDJ0hoA=;
        b=jNFsOql5dL5bPHzWr9xYrb/OR70S8FB5UrgA7l31cx5A1Qpyt0QTKZyUKvlqSCWgNO
         xf91G20rK4ZfCVLzGCHpsgx+8CLOp+dG9oNUIccpwcH1/Pngva+EqMqkWUqA2qg6jqNF
         4NNCOWEMKKLCec6WJi/qV9yqcJs8Y3CqM3axBavT6rfPDn4U/zbr9qqTYb624eA1+aQs
         Doo4bLAINiAT2SRUTUXF7YHnodx3tv9nMcR5H8aUhEoXxCt3dHOqpNLQSWhdAmllqJFo
         fFGf1RTqg3PY04+iwnxD1Owp8k7hlgJJ2/b+alFDMIKWb6T2Gth07En8k79bXrk5Z3XL
         /Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761327051; x=1761931851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsZ3xho59rfJltmBY1VoMiVkLm14bUFIBqE2RDJ0hoA=;
        b=TloWevRDT48Qxh6JZPvx495W/GxuoBIsfYdTQfuFli2u4vjwZKltF1i1K1D5CN7k2y
         EtFcT1T5MNFcKlRQp5KoX3MdCE19SAYP3BYRcmM4MVR+oCLwBfre6S0FzlCKwiPCXENi
         OflcqbVqVueDct2Jcm+3HaPcmyhB6jdW4h0lLyPlX5WZ3empHF/zSf9uxw6qPVaLxu/Q
         4+Iu6EBjlJyEhzg2lNFtTYNpBEDgRVwwPh0N/yyfxWiJr/NegHgCKDSJSgVH7ZqWtyPW
         Ui2s/7BTdhxI0pE6m2zuYdIJtolPytaJzUcauDQT4h54GtDf4tLcWHhp8s6/T+xEhWKE
         lOew==
X-Forwarded-Encrypted: i=1; AJvYcCW7TmMpFJjYRWaCqOHUrRgZhcCMmYNL2mq4RnJsQAPUd+KAqrlcyclUbu2V5yDEpeBwySrdqOEVQ1bh4PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2ZXOtaJpqioq1iAunzxY5aF013TiBvds3thnjH+AuxVSuJO9
	Ox7TRnXVY8juJRebqHV4HBgOR7HVkj8jALM5I2ZccjLtCJMJsjribgeaQay/2iM7qvfOMybhVRD
	6uZdOsKeoMthm4ez7WSn7Ps0fSix9nDk=
X-Gm-Gg: ASbGncu1I2QRY3mkNGs3/DdCUnwCdL8wliy96VTksXdqwB7x4CTHLv9XGcSttpabbHS
	OsxcFJNr6gItLe6N30gh0w9SsVhUtV5r85sBEbVdtowU7M2nUhYrYxa1N3zw5HTSmHq1+j319V3
	Rp3JffumavFDWPj9WEYYnD3fYJBlVe3jWvJXuWUOV6WGB4toJflK7iLe/AZsjrWbdko0+r7FgAq
	ZzCBrRPDbjFM+TDnUmJ9Cf946qiwYaUPOVtk++MR1QJ+2GCbf8Fbew4aM5q3A==
X-Google-Smtp-Source: AGHT+IHQhnjzmGIGhBDoQ4ngdvtx/yYjY0WDUYmMTlcSQSZ0eDN1W/dXc1+Jq8Cx2TnQgYBz6MVBdKFjMRDBtJx3n+Q=
X-Received: by 2002:a17:902:cec7:b0:290:afe9:76ef with SMTP id
 d9443c01a7336-290caf8505bmr377100585ad.40.1761327051116; Fri, 24 Oct 2025
 10:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009150651.93618-1-jckeep.cuiguangbo@gmail.com>
 <20251010071555.u4ubYPid@linutronix.de> <CAH6oFv+SUo7B6nPPw=OgQ1AhqVfQYC1HvX=kjcHJX8W13kTwZQ@mail.gmail.com>
 <20251024131719.tJRyYGcD@linutronix.de>
In-Reply-To: <20251024131719.tJRyYGcD@linutronix.de>
From: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Date: Sat, 25 Oct 2025 01:30:40 +0800
X-Gm-Features: AS18NWDuFjVwPVmnhn7ThOaKPPOq5x-YUVnqIn4rpEZv7zoFKB8wtJ_ayD8162s
Message-ID: <CAH6oFvJ-24v2X_NrxXjYvODp_9+ZRXQQFGzWq0NcNn3Yb4-Gqw@mail.gmail.com>
Subject: Re: [PATCH v2] pci/aer_inject: switching inject_lock to raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 03:17:19PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-11 01:18:05 [+0800], Guangbo Cui wrote:
> > I will drop the lock in aer_inject_exit, and update commit msg.
>
> Was here a follow-up?

My apologies - I=E2=80=99ve been quite busy recently and it slipped my mind=
.
I will post a new version of the patch this weekend.

Best regards,
Guangbo

