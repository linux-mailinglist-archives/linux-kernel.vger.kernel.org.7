Return-Path: <linux-kernel+bounces-773241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E43CBB29D18
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A74618A1B57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9B308F35;
	Mon, 18 Aug 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pElY1WMd"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5430C34E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507841; cv=none; b=FQvVONbNtnbmT9iu4x4vrjjIzm5Ds2WNhg6z96EwngENGTxvmG2mW6lZFd2fDnzAYhUNxT2nk8YUYvZPtV8hVPxFAyV4pVIbPT2EQjti1roioduZjOPa2azoVN/dBoXw1+vMdiJUZBvsujx6FL1VwvFHPxoH62WCz/M43WV+t6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507841; c=relaxed/simple;
	bh=m7oOCkrHmV3m6RPZPr4H1kZpkhVJDtpouU7lgw2AWTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3qTNn4txadqijVWV44fSBxq6Hj/7YBss7i+gDyqVXsvD2Mkq555im0xgOq286A/bImGEZSEHbOGxRF8imHSgcsRh4xGlJUSJsjVSgoW9+zEaEXa9wPcjVhVswVVXr1djOlIcOIQFi+QZDOKTxq6fYcXmILq8kQ2GUXLe7bz27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pElY1WMd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f92b4072so29140931fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755507836; x=1756112636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUwutcLP2TU0uZmoKGbkLCKDIFQshb+hzWxBL6xH0Wo=;
        b=pElY1WMdiB++dh7NcmzagwkoI7mcFzY1I5dMWBqyA74scurUnPnVCBpWlge9xN7r2Y
         GbCmLLf59Qbq9KYtbJfDwfURG2UQtdmlnKRNDPiLyQm2aB4lwdkga2Y7ZxWfgWZbkq0D
         jYrmFaHxLjC0U+4S8za1xhieRKgwsMsUhucn5UO8YTLH0eNGt1JokHvnwirDp4FQ1+BA
         PVUywFNWm1iL538hLXH1fH7CceBAWlZLYTOAKCQ/0NtjSFzZ7qOGIqS/2UDgHXzDspqU
         itPJPX47k8tgj061buRoHYP8QejjKWsTUsix4cqmen9M7CiC7NOfm6hjzE7r2teVT7eo
         YAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507836; x=1756112636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUwutcLP2TU0uZmoKGbkLCKDIFQshb+hzWxBL6xH0Wo=;
        b=da8Z9JYmpL35BAn2KJGT3dKFcQ4TwgiyJ1hBfQjPjhg8ME+7/+Dgwip04Un3CpWCVS
         qe3jlxnabHk4ErEtoihS/OdueX60PiA0NhnW8JXBMv/TeY76/XjFkC+0vziBptXSDMux
         BaMk6fRfBjesNS2HLH8VSyGTihzXkpmCNVTvQJry4XYpI4BZoUxOiv9M9xc7y0jXMiHi
         ay7/YL3VUJd0X6xKW8WJqcU8y+VQ3uOW3oXdJMcvbt0pdHKg3IpSJSEOY3HTcdG5bpI0
         HBsdFhLAFzz4SEQdGXwmd9FBWJMbUFgYZzetRO1peHejqBeiMrPSlq+pgzKcM4xGSwUc
         9kYg==
X-Forwarded-Encrypted: i=1; AJvYcCWlsoSFwCLOL2kSQECrg//I1reMY+0vd1a14i4EHsr05WObxO3Y/03sl2tTGVJKKmAobyMQm1qTs1UHEa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINXRFlPosHcFKhqHj/PNEBTgHHei71GLILEmX44/Y02a0+Izz
	lDgtfI6zidawypD58tIwAkE4NrPU5pHZEzWChia7QXQnqn7dqLXzwbc/mUki6mcQim4l6WhtEW5
	Lo2PF7UomNjz4bnVXTqr1xm0vy+XojZwvORttS7iQTg==
X-Gm-Gg: ASbGnctzjh7xX/4jn1aautohxiXU5DngNmVt9HnS+tzlxqt/81pj3gd5aVRJgPHq3PC
	hrWlbo5FzqycNmMbMMKTnI10ZF50Ck3EBDOAh2YSHmIjjb6qZPyjU8h+SHSc1W6FbMi0alPQHKj
	pkdT8S07ruJcqjTUfoKLelWdgiEiDBqAGmXiLGHrysrBwaCiGThCqc7f456C0NkJO+TbYeZKftY
	K+hSlSn3NyUYkhZKQ==
X-Google-Smtp-Source: AGHT+IE9kamzF6h6Mj0Uthfqb51rMDCl6ApaA6r9yCxNefG5kg1EpxapoTSKZbjphVliY5NG5jt71S1DTJFc+QzXeWM=
X-Received: by 2002:a2e:be21:0:b0:333:bf9e:d75a with SMTP id
 38308e7fff4ca-33409809840mr30484411fa.6.1755507835692; Mon, 18 Aug 2025
 02:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753039612.git.dan.carpenter@linaro.org>
In-Reply-To: <cover.1753039612.git.dan.carpenter@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 11:03:43 +0200
X-Gm-Features: Ac12FXwmdSMJ2XrjVzm-k9jfEa6zy3nIx6AoVfYXMCJMow6Cz5Q3z1FJ4deDBS0
Message-ID: <CACRpkdapzTTJhAvY1BL8GnUpCc_iHESbY9bFsNTE4Z6FjusiJw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/7] pinctrl-scmi: Add GPIO support
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Michal Simek <michal.simek@amd.com>, 
	arm-scmi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 9:38=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> This is version 2 of the RFC.  The main reason I'm sending this is becaus=
e
> there was a bug in the first version where it didn't calculate the offset
> correctly so pins and groups weren't linked correctly.

I'm thinking of applying patches 4, 5 and 7 of this patch set to get
some movement in the code upstream and make less work for you
to rebase the thing, would this be OK?

Yours,
Linus Walleij

