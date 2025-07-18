Return-Path: <linux-kernel+bounces-736225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7ADB09A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDB01C43108
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75DD1C8632;
	Fri, 18 Jul 2025 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SCU5+M4o"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593913AD38
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810416; cv=none; b=V7FfyWtv69j0GjYgskARVO8Hdc9Enq4Jawx6viqiuol7ej98VgQQIqXgbgppgU/xR9blsdxD8uzJLIdPfzM85jaGv4xvN8g5k5MPWtLRpDANguO1EAZN+qUbqvgaq8Z1jCESNoOMCubXQe4vhLq+wdlxsgWkCHK8SFbUaPBAW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810416; c=relaxed/simple;
	bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d03BkPn4weQvUge75Pmq9oYichXAB8Q3p6wZa9V4GJa/2ScDg7cHK8H7q9YONmh2lw844S8qb5MhvP98Emw7Ba0ziqnOjRc+S+qe4PjiRGzBXMxAHD1SOQUz4wbuxC7ctZsWY/CWGGmjapGt75O4lrfpFOIRA4GIEcmB1nkaG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SCU5+M4o; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490cb9a892so1155839b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752810413; x=1753415213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
        b=SCU5+M4owUAq67eGL2xlpSBkeKyUhA8Kq6XFmjO1BLZfka8BYKq+K2rc3Bo9ToKIwY
         rXa23Ds4JToursaj7bEhWeibslzDKQNPDMK9HM55mwP52A+LNWvPuhu52cS+KJm7pnCw
         Y+pN3TUF31U/sgTLEBooIErRvCdG6EXB1KlyT3JZZkBwIyXw0y/HkjBkUlRDj48MFEjZ
         g9hJxDdDlA695w7GTsRlviDeMJzVfasC4u48WhwQ/I1JCI4ZkvuV8ozlFgJh8fl1j2NA
         Ku2F66+xxyXEupdjqYNtkdqa3JMYqYPyA38a5sEuX32XOVMl5ZJi01rjj8Bo3ruXNfbA
         6s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752810413; x=1753415213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf9215EGCTrmzHCEhlJE5KvEgKqe2O87UjIpxFAjudo=;
        b=CIa2tm4yKoZG4ZBHbK42MOTbYWoIQLvYEz41e3v55a1P/lb7N9fMCoTjd1hHfNu6yj
         aWY0LPxJNSx7Xtl+9CwiE7uVf66NewjycN5gnscdmWUXn4lq5c3cwfh3k/jvqBWq4oWT
         MiQw7B8QTeniJcEk0h+wQU4no0G5IpbDHP7weA+6UbwO/pjSxojHCdncBgr/WoMqEL8H
         4hPjFbCuQxU7c1mM/oDYxLmSxxJR9dS4+6Mqi7/Afm4XvtBqPjP2MOKpljieZP8wwV9B
         ONzFvc+7HxKss9mw6uAJgVs1cjmO6k09CH+NbbR13kRqNjtCmoaAdi3gQsFr+1tQGB0Z
         hL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUoXoWLY26VvJ45YO+EqYSYMdwduszA1mTOPxZ08DJgD8s/CjXyC83Hlu6En/VwkmwqEBnJYtxCWYRG+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+EQrkZGu1PyhOYUAoMThpTAStHOWyB0OS4harFamDgDI0zcxL
	qsUfXReTngT9zq2Fn6pHnvRbDzNEYsthPuY5pkJbpJVLKGBcpguxkqhTGgU91jIOKn0=
X-Gm-Gg: ASbGnctps/xMSsV9omEuPsUzQwkMSTK+HkGWLpxVO8buqtQyotNa2T1ogoQXJ1ovIK5
	3hsk1WKtetbYsqfXIncqfyoVKU9jG3bvaoYEAbbTg2J3eTYPxAHKvuknz5CPYrgF2XClG8gWbjp
	O9ck1ME47FOx6Oqx/MJ6O3rRaSnKkK9/qkIFmzn+zEk/OZjI0pbhAhEychyZ8tojARovq7Mb+B9
	2A6VOPvljLk7OBUhz43yb77yibYvA8Y7npFUfFSRgWKr+PfY8PUZxWqbrSQzIdp7l9H51nD6Kxk
	vqLqavLtIE3/cNvAcSuvDeedeK2hNBM9/CceUiEqOKJN+K6nbbxd/wBc+ukFUwm9hxCeNHGLXr0
	aFNPgJqK+5KWNS9ZCan4w3fNx59Ql/THjQ/TsF9dRJaFRievU
X-Google-Smtp-Source: AGHT+IFNa+EcH83FNXnjEm3C0F6TihGjOc1OMxlRUqkqp/V85onlhfwD3tW3WOOTiHm6RK2tC/cZPA==
X-Received: by 2002:a05:6a00:2189:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-759ad4002fdmr1963419b3a.11.1752810412983;
        Thu, 17 Jul 2025 20:46:52 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-759cb678d8dsm310811b3a.110.2025.07.17.20.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:46:33 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: anil.s.keshavamurthy@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	davem@davemloft.net,
	ilpo.jarvinen@linux.intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lukas@wunner.de,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mattc@purestorage.com,
	mhiramat@kernel.org,
	naveen@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tianruidong@linux.alibaba.com,
	tony.luck@intel.com,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Thu, 17 Jul 2025 21:46:16 -0600
Message-ID: <20250718034616.26250-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250717235055.GA2664149@bhelgaas>
References: <20250717235055.GA2664149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 17, 2025 Bjorn Helgaas wrote
> So I think your idea of adding current link speed/width to the "Link
> Up" event is still on the table, and that does sound useful to me.

We're already reading the link status register here to check DLLA so
it would be nice. I guess if everything is healthy we're probably already
at the maximum speed by this point.

> In the future we might add another tracepoint when we enumerate the
> device and know the Vendor/Device ID.

I think we might have someone who would be interested in doing it.

