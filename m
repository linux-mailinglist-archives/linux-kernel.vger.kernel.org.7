Return-Path: <linux-kernel+bounces-891844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6F9C43A45
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 09:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68E7F4E2279
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 08:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D865263F5F;
	Sun,  9 Nov 2025 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAJN+FFw"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6013E41A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762677901; cv=none; b=koj5jRkbRXJ7D1bDmUROsVV5/3uwm2plG7nLALeWcKq5moRDc7GPhfgiByC7hYP2vM83JSp6lsbWceSBxefx2croosruIfQ+PE9UfE5+sVHKIz32LGGwk4ut2p8086XcAQFt6gXemD7PUnrUfHHJuajtuqeDWp4W5oF5IQ/+/jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762677901; c=relaxed/simple;
	bh=HXrwwoVC//E0UvQ+RFUnyKxTxBHKV/pNmqkF20wMo5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZ1DjHhxnfkWlKv+fyIMjbgdcNwtNQZc4ot4yTnT1HG2Sa+KTC46shan3g+OEC+zvKhQ7iaIVpAmk6RchtvIdhbO7BI9MOlVB9WHqWYOyZJ5Hz3L+IBPSnE2m+mWd0k5fqM3g3Ld3ZezSzymj9igNaucThpXGig2jxzguyhg+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAJN+FFw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7833765433cso2411561b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762677899; x=1763282699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXrwwoVC//E0UvQ+RFUnyKxTxBHKV/pNmqkF20wMo5o=;
        b=DAJN+FFwqqBE0bhJSHFE0K0mMfw/LnO3qrRMXsVTcgpORp9BxrIW6JIQuYT1ZLFItT
         JtGDF+Z2S1dlN8Gyxu1PxFXxKsXPD75i0Q3nqnxeOC/OmaP1sWkqIg7UYaHZZ/Jg0M4G
         KYrH0XhQDBMAns85X4RDrnfxSbcCTaleADOajtR2slBi3n+ib5J+ntO1tNbXnI9RpK6O
         t2ClpPoBw/Hmdzpmycc8Xa0gmJg5nV3LoF6FKS2AAuTwhg/Zn/MGbRsvai6MG6kObJVv
         8HecQXhT4XE1vXTue7zJq6eG2Qd6Tyj8bor1LwmNXliRdU1aH7vxu94RrTU7WE+eKE/z
         vcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762677899; x=1763282699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HXrwwoVC//E0UvQ+RFUnyKxTxBHKV/pNmqkF20wMo5o=;
        b=A+UqwWBhlzAwQ8vOcBEcUR/U5ynSDJGyLuJ71vimz7B0+y0xobEtazjGgXuGwoFqdW
         uju32IM6BgQ7T/sADviAw+XFJ6vp5x0Co8fLtJ02DPCijg8r9k1a8dUVgzOzoMhacfc4
         fHQ3r4Agn/xOVBbODFWZC/GklginJA8h4E9tqJDRXJmYmECY3CaI6Cc4IwMMt9FAhegV
         45JgKJHwkNK924CQJQPko795asc3ue3kuZ8oNSngZday1zZ23uDLFSuLAj3itULqSZpA
         32NfBB7JCN7w17TsFkulst7zgimpNMxiQW6+Vi+tFsMGsUtZP8XMxK310Peqojr0YKRL
         r6rA==
X-Forwarded-Encrypted: i=1; AJvYcCU5xsYybzNwtYNRl8LpxcO9LefdzLTRQj2F+Dr7kBcRB54Ipshg3FyV7KX9/YfSynE/Fxv1v5sRBBKi20s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYRdsyYw48XusYQraZs8DY+vZOvYliwQZH8oPCmBdfp4C7H9+K
	kunZC3EvZYa5/iiUqcKu5oMiRKMq5BGBwAKA9W/PAHoQGjYwmbHygh/S
X-Gm-Gg: ASbGncsj5/YOX4uVRL1wQDsIxNQS1TZwNom4XOceI0Tedji7rqW1KtSRW8dtxnrmotH
	P7r2HVpBu6r6ti5yf/rA2XvRBgaAUFhSrm5NnZRxbX3xEhm2jEwbZQrLhGGHxJW5s11dB5/ESON
	NGBtEAYOn9hQkf47E4cihurIdopTeFjGIxl7R/vK4MVBD3QQXB8vTOJOh6qcyyzyOOanZcW75iV
	pn4SpUjAUOYp+B7eKs03lwPkpq4S+JC9Zpu72PigrjQYyZS1VJSSz8qE5maAHoLaSRCJlC326Xd
	Ex2YIS6dZwBOBkTJKASphj/OvXWhjgp05O7EMcgbplmlxwCMmkthrj/tJozw2DiPjLYeHq0Aq5h
	L9tQ6FgcwYkNPVjhsKJyA9i495jLhnMQjWm4IryPWYEU1ptscfwr1j9/pvBKtu4OBOXike//gFE
	/nGe0Znidory0Blh9vl7A=
X-Google-Smtp-Source: AGHT+IGnp7pQv0Zxk4SgmB3b2rk34RXmsJWJfqb7o4EKPC0JwCRCGTVvM5tpZ3lAu6qeBHhvuniQMQ==
X-Received: by 2002:a05:6a00:138b:b0:7ab:a41:2874 with SMTP id d2e1a72fcca58-7b225b6e947mr5446010b3a.10.1762677899397;
        Sun, 09 Nov 2025 00:44:59 -0800 (PST)
Received: from LilGuy ([2409:40c2:1042:913d:b798:80c3:5bd2:24ee])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7b0cc863a09sm7917183b3a.53.2025.11.09.00.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 00:44:58 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: dev.jain@arm.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	swarajgaikwad1925@gmail.com
Subject: Re: Guidance on contributing to MM subsystem
Date: Sun,  9 Nov 2025 14:14:50 +0000
Message-ID: <20251109141452.7097-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cb17f29e-b45a-4275-ab2b-1443d909d944@arm.com>
References: <cb17f29e-b45a-4275-ab2b-1443d909d944@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dev,
Thank you so much for your reply and for sharing your experience.
I do have some basic understanding of how parts of the MM subsystem work,
but I’m still struggling with how to find meaningful issues or tasks to work
on. For example, I’ve been trying to explore various parts of the code and
read through documentation to get a better grasp of how things fit together.

In other open-source projects, like on GitHub, there’s usually an “Issues”
section where contributors can easily find bugs or tasks to work on. In the
kernel, should I mainly focus on exploring TODOs, adding selftests, or
improving documentation (especially for new or less-documented parts)? I
also believe branches like mm-unstable and mm-new might have ongoing issues
or regressions, but how do developers usually find or detect them? Would
simply building these branches expose such problems through compiler errors,
or should I try building with different configurations (for example, using
defconfig and other configs) to uncover potential issues?

Even though I’m beginning to understand how different parts of the subsystem
interact, I’m not sure how developers usually identify new bugs or feature
ideas to work on. Once I understand the code flow better, how can I
effectively find such issues or areas where help is actually needed?

Thanks again for your time and guidance!

Best regards,
Swaraj Gaikwad

