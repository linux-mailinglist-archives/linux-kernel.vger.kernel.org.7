Return-Path: <linux-kernel+bounces-856274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6810ABE3B65
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FEA5E0337
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FE633A00F;
	Thu, 16 Oct 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J7CgA534"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F31339B3F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621411; cv=none; b=dNCTmdEPufmOdA61ML/ePUynmvqokm9GGhau+44zYElLsGV5A8mptPN2ZWMYhUZ5HDarYhu+IWmoHTonvWqp14HRfTdK+0Dq/Dv/E27LqyaegsPpaBEwPtGuZqP6h+bmY6p6iyzcsqul477wxo3dhCOQczGwvpjUaqSBs1vm0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621411; c=relaxed/simple;
	bh=Unf4UJue+qOxNotOiaiB/gYULcx7VawBCx2grHDb0iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+eVYPXJ0MmujZ0rM7kvNleXMrXp11f2bv9t3WXH1GN/n8EuWI+WqXmyI4YvOvYMhFvCFd5z5HVUfDN+2iz5mlKNpMhFjhs1ZZvxwBkWZOikK7XQYCSjeux3BDF2+ZQfbpSs1Bb4ss3FbMRZgRNq8O1hjIL3Mjo8Vo7APGsbT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=J7CgA534; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88fa5974432so92375685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1760621409; x=1761226209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdflzJnMQthLv2cazH+0O/zsQRo0ZmLpj7kbUNZvQac=;
        b=J7CgA534/qOtEhOxg341EWlJqYcd3b29vf0V+hB0LorZVopgxK6oy/+aKTP8I/HlfK
         Al7WA4YCYF41W6l7ch03ECRMmCuY3zlkGE5s8a6VctBIedYWL/34fpfF/tXE5UGC834N
         Xs+/LzmzvkONd4VeQ8YdB5n1HmQNua00Q9XP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760621409; x=1761226209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdflzJnMQthLv2cazH+0O/zsQRo0ZmLpj7kbUNZvQac=;
        b=BisRfZu6wwXqcBMut5MYg2QTZLiwoj6KjSGF5gcbwXu5M2Lp0OTwe7oxHm8SINyUQ/
         uWqaZEc5JKCkw9q+xIONj4Mnq8ntOkFB97Gg4kEQgjVfbX3hOx9gGsGNj0fcDQvNygWs
         XGaA+i2HAaJaZpF91hNJqymd3Fp59EAQUWwiKod05zFcn3c8Xom6PG4t3wTeSr3bOD0p
         zntuuyLwcUVMrew3ht4rO3CSvrRIAIPemRC0D25i7/0+dO8D8zXJHE4uMDPV2bn2NyRc
         NhoJYdOgzFWevahd+8VezKpfHuOskUSFQ9r9l+8a1HC9Mxw1G6Ejksz5gFriCisFEM7m
         Okmg==
X-Forwarded-Encrypted: i=1; AJvYcCX0bo4yyc9wYYC83Dcf0tILRm3QpUWw+5YgiSflwl1RB+VcSF+zhwBbCuKoYkYIdr8JkEfUG9WwUpuskp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHeZoBg70NINf3bm1BB7DtUM5KLTTHYWQapsmDXbhfOJbc05V
	KClxfr4CfBwU6gVVGNbyqd0wzK3SgW2s7gCkvsqk0kI/rYTsNjD/Rx+FC1gpkrxXfViWzB5MKFl
	sGG320xuL8nMZAqoxbS4gCSCltorp6HuUQlxpVBVQpA==
X-Gm-Gg: ASbGncsPbg8baPS1UTN8P2S1Vd7TNfvaracWudoEtbP1EQpMxBY877FcSeetyt1IjS0
	JZWHyMO9nneXYyIc550hLgYzeOIHZPjG8STOeee2SwPCwghM6f6kVU4ONgYvRVQfRHZgYcKmC1A
	RKgmeMtO+WE0Gjy1Y9wi79UYIfRjsgpSN5G6/mT4GxeXcOplR0H0mrOrfMrow/5FwVvsoMy3nG0
	A6TH85KoS21WimXIY4n1XHoQmKD5i+ETKSoK7OShkDhoHzruFq4OTLPUEN/y6Skwzh2X5VouG+l
	wWkSnBji7l/IpM1si2qMCKT4fb3pp+cGkPNaQMnYm1WipyppWm4DWi35QA==
X-Google-Smtp-Source: AGHT+IGnXn2OWekqEukP5vHXZxC+ehCPf6mZptuvjHzZezwxi/p2zcouk9xm0TfVXXXAeAsJj++O7TUZcBkL3bdq60Q=
X-Received: by 2002:ac8:5aca:0:b0:4b5:f7d4:39fa with SMTP id
 d75a77b69052e-4e89d1fe4f5mr2032761cf.12.1760621408367; Thu, 16 Oct 2025
 06:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-xdma-max-reg-v5-1-83efeedce19d@amarulasolutions.com> <176061935845.510550.12282030175889296984.b4-ty@kernel.org>
In-Reply-To: <176061935845.510550.12282030175889296984.b4-ty@kernel.org>
From: Anthony Brandon <anthony@amarulasolutions.com>
Date: Thu, 16 Oct 2025 15:29:57 +0200
X-Gm-Features: AS18NWA-hxbDFlI3b9UTsQcDU75GuNgix6cv9Elfy_HBgLGvJSUA3uP6hd50TSM
Message-ID: <CAAD-K8bP=cC3Tn9tqqQ74UJSq5YHnkuKNU46kEEr4K4YApqKpw@mail.gmail.com>
Subject: Re: [PATCH v5] dmaengine: xilinx: xdma: Fix regmap max_register
To: Vinod Koul <vkoul@kernel.org>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Max Zhen <max.zhen@amd.com>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:56=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrote=
:
> Applied, thanks!
>
> [1/1] dmaengine: xilinx: xdma: Fix regmap max_register
>       commit: 81935b90b6fc9cd2dbef823a1fc0a92c00f0c6ea
>
> Best regards,
> --
> ~Vinod

Thanks, and thanks everyone for the reviews.

Regards,
Anthony

