Return-Path: <linux-kernel+bounces-757446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66100B1C238
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACECB7B1064
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA72877FD;
	Wed,  6 Aug 2025 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tQaQj+Q5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vsFKCc4D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060F22156C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469231; cv=none; b=V/Epugtop7DAKWnhF5lwAlYzX1QrtV6BwfGLEK3ryQSjK7KngkwAXuuwQ5gyIZ9tNLaYwvudoGUcAiggw5OmSsXWJAMx5w0FOqrFH2wQVW3L5qjc75MOsKgNiYZJNw7jt0EsB32a9sucPC4cSRqlSuKuEVb3ljBd8oRKUozGjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469231; c=relaxed/simple;
	bh=OgYcTf4I6oabMqaPeygCTpgWdxcsRPlNU74OnQgeVKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSuuAtKkgpqUl+B/aEJw52ZoNvOnT4fJ/g1hiQOD+AyOFwAZw6eVke6RIzPxJFC461vbJSZRCMp6ZKEQajlMJ8UShIgu6GO6kL75/TevwmMHJnUFYp8tvXMHb7HDBZQcPJxqQZKIqegXmnb6eOI18ix8BmvTWONhoQB6ZU9IzhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tQaQj+Q5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vsFKCc4D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754469227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgYcTf4I6oabMqaPeygCTpgWdxcsRPlNU74OnQgeVKU=;
	b=tQaQj+Q55ovrWmB4JiekR1R0MZ7oREBBUYa1o8UQKeDZLmkL7hrxyB8QNxMR8jj2jGkoJD
	L7jJXV/yEU6gXnf/T6iQ5/4pfhlce/Fix8ypO8L05VKhHsVwZxe3Zvswk0K7of8D7sbm2Q
	Ei1EsSsZJVO7o/dsO4GvxX4KLoVySJEqA6eGToVht/CX+Soo7OsXKZvxvJ8begD+blAH9V
	UVTMDzU6ESfuo0XpSsw1rQbEf+ypq/4kax9piGMezDuPWRO6Maq6ghRhRpBI8naoa0RpEt
	rmhPugk/JW/+6PcOOhEShDGh/KI2RcOiMw7vFjz7fW7OtBZBvyp0TgpqqDb26Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754469227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgYcTf4I6oabMqaPeygCTpgWdxcsRPlNU74OnQgeVKU=;
	b=vsFKCc4Dwriv0iW8nolgQBOsbhqP0Pmu6dXgmzgJSVfO4SRGmcQAZZXLq2j66P/uX4dKIm
	gyb3UTztDnVoJvDw==
To: Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>, Frank Li
 <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nam Cao <namcao@linutronix.de>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Nicolas Frayer <nfrayer@baylibre.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Stanimir Varbanov
 <svarbanov@suse.de>, Inochi Amaoto <inochiama@gmail.com>, Chen Wang
 <unicorn_wang@outlook.com>, Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Peter Robinson
 <pbrobinson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] irqchip: build IMX_MU_MSI only on ARM
In-Reply-To: <20250805160952.4006075-1-arnd@kernel.org>
References: <20250805160952.4006075-1-arnd@kernel.org>
Date: Wed, 06 Aug 2025 10:33:47 +0200
Message-ID: <87o6ssetn8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 05 2025 at 18:09, Arnd Bergmann wrote:
> It seems to be a recurring problem wiht x86 not using CONFIG_GENERIC_MSI_IRQ,
> while all other architectures do. I wonder if that is something that
> should be changed by changing the x86 irqchip implementation so that
> CONFIG_GENERIC_MSI_IRQ can become the only way to do MSI.

Ideally yes. That needs quite some surgery and I didn't have the time,
urge and stomach to tackle it yet. Let me have a look again.

