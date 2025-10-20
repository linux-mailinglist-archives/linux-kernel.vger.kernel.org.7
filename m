Return-Path: <linux-kernel+bounces-861835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DFBF3C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377E13AD60F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111762DFF28;
	Mon, 20 Oct 2025 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E86mJ40O"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AFE134AB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760996017; cv=none; b=DVEBsABxDAJzmlZcd0LR0ysJLVI9COmBSun+/cpT2zYtbbC3PqKQcciKo5cwu7CwZ6UnFVOQsH5k5hvAdf/zSQoigaovaaIBZBYmFaKkDRELFpGKC7Z3VcfsADxzC/X0g3yqUsjbb58bKcl2am/rcc9Su0fII7G1e9ppdr+2+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760996017; c=relaxed/simple;
	bh=YrGlth5fvXPzZeAmBmyPZPRYd5dwsROMF4koS4KTwi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAW6Bz8W3P1wuMz6ZEFaPaqLxhDhfzq9VLHXS3eYtTIPqawOvgatWqoGZ3d96cvoi15d8gy/DRiMqKq7AltABQtX5Z0ocBTPjCZnIieWH4gLA3XzFvg3UV3iWg9VgQwRs61g98psNj6C0ibsC75v3yzuaLGoBu0Z97SP9+CR0JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E86mJ40O; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78488cdc20aso30144997b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760996015; x=1761600815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrGlth5fvXPzZeAmBmyPZPRYd5dwsROMF4koS4KTwi8=;
        b=E86mJ40OvCSR8ntDIfW649tLJ3wA7fiz3uKUgMSOyJ9DZi+nQQwGOqK08FRAv48nMP
         d4EZISYUjzAQ71gtqtDL9uvu8yZqO3WES3b7L8fFqnr8JcSxV4av+x3iW2c1Twp7cWFZ
         XqtiwPqsoUUItd5AGt4ifPohAmmWvCA+VjTpHl4MnKC/4iAU+K1YtT2aS9PkjhK+IBOo
         LfHPtBpjQYk04TObgLLk18+WwBetmrP6r7/Dog3zLmgsQoB5XVvXxjdrU+teHpViHQYG
         8xhYcwfRHlfmp/9u9BB/gedTapeadLnLHjqkTOhiq5/zyNXFBiGAU6sYTQOm6Bd4g1rh
         +beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760996015; x=1761600815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrGlth5fvXPzZeAmBmyPZPRYd5dwsROMF4koS4KTwi8=;
        b=KdX9cVe+Z74e5KhpghxwhW+B/Jumhu0h/ApSQaMQlDrsush2F0pojEdDHFP+IzxCpJ
         8BDw51zqdun8Syaqc/36Bh2+azvBAp2MjLJwwwmtref8nkuPhyQh5JUCoriZ1j+Yms++
         aqadJG2YppEg5tnayVDJO2SVYdIBgWvEqxImZ1BJOuqsyY5fkbTzGAUcC7yWi9ScRx6S
         IKuEiSOA0ONUUNkyEXG9xez1bTTrdnZ9cTxkhDEbjgQXWZdlkvM708wtca7F3nZsuIge
         XjtcQ1dw6gb3WtB1IAk4U+nZHP7hJWmYJI5bHUQnGt9gvjTTO8M0gmX3hYlg2XQwNPYV
         Xx7g==
X-Forwarded-Encrypted: i=1; AJvYcCVKqEO8GzLOMXQZfaXUdYJmjQfd/q7+pTBQifolD3GKKGfYPUQxC9zHbl0QXMRT8M5h+daniXO+70JVFow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DvL9MEw2f0WpUl+11gF/DiobJwu76QzE9Vby8G5sPj/xdFpo
	QNFWV/yFBzjj9k5JdESLYKqMlm9wcjQxe5YH6CPeR6hUMrDsc53PISno2e7WI0yZ2IhUz7LenhQ
	QeivKQw+xTt7hsl5vcu6VbehW2G5V3+6mkKM0IwQ525NYl5ylXv9bX/4=
X-Gm-Gg: ASbGnctLjHYtnvz1j5kT/5gL9ASruAkn0PhDJKBF27Lp/oIDz9uezT8ss65nu3q/4uv
	y8t+cxdIHlI1fCCTJYo/9yN/7uf3Ybl3zeq70ino5fsomUsx3kV9CPyOBl4ZmoYiFu0S7mdLVMg
	cON2qRNO0zZu/3oq67ae50+lU3ft+xAd3LcogRFzoDGP6lc0g/K9O+wSbCcMlp3WBuDQDnhtbWI
	2OhEJjjN1RIFI2pTnhNfLQy1cO0ac+j51QmzMxLtK7RakOZV/y59VcaUsCig/3W9jHIPS4=
X-Google-Smtp-Source: AGHT+IGnAj+PvLwk6sz8k8VBBs+rDQFENAxd89cmxP0Cskfc+qbx8RLj0mUzmzdGLHOstur2GpIPaCgQ2XYuSy6QrTw=
X-Received: by 2002:a05:690e:1558:10b0:63e:1531:b3dd with SMTP id
 956f58d0204a3-63e160e3c4amr9861710d50.7.1760996014901; Mon, 20 Oct 2025
 14:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017074646.3344924-1-gary.yang@cixtech.com>
In-Reply-To: <20251017074646.3344924-1-gary.yang@cixtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 23:33:19 +0200
X-Gm-Features: AS18NWCltDS_N4NaY0c3A83FgC_-lfyfiL8AVRFFfvMHb2dlUjXD7k7Kzg6VMk0
Message-ID: <CACRpkdbcSkKnwODw_utWEUcwg+Q=_h=psM6ZKphGUr4iPqK4XQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add pinctrl support for Sky1
To: Gary Yang <gary.yang@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	cix-kernel-upstream@cixtech.com
Content-Type: text/plain; charset="UTF-8"

Hi Gary,

overall this version is starting to look really nice!

Please address Conors comments, then see about the
compile error on the driver itself. The code looks good
otherwise.

Looking forward to v5!

Yours,
Linus Walleij

