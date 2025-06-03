Return-Path: <linux-kernel+bounces-671654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8F1ACC441
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 12:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2122B3A3DB0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10A1DE4C2;
	Tue,  3 Jun 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="bqzhCygI"
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF871A9B39
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946242; cv=none; b=tVzKByaijt+dmu9nHUoXHNou5iGcV3z9fGCvLdvaKjaDzUnIPxLttSP9R4iA59qMnMUTPWkp5SOMLe4oSRpeNvLg5hj1ax03bmn/1jcwNuWUMzba1XS4VbjI6vq95pY2c2qHJZ5NhtMe3539uKLojxgz0XKal04yK7QKqAu7H2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946242; c=relaxed/simple;
	bh=0R4MkUmFKrDH2antCfLvZrX66TftMrWH9M8K8rA6o5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grgHozHd5hf40uu5iq0O9kExEdH555ZCdOvr2O9YuIyTJ9KNamWilioQc0ObUTgLl6zP4tGl2Q6ygftzD4DdZf6/an9SHWV3AQiIBFs516Z6Y02NkkCZfmZFK6KeGk1ej3YeUlNS373tPriDrqjOewmjpMO+02L8Mlq1Bp0Bmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=bqzhCygI; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250603094330d88e7bfeaf71d96e71
        for <linux-kernel@vger.kernel.org>;
        Tue, 03 Jun 2025 11:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0R4MkUmFKrDH2antCfLvZrX66TftMrWH9M8K8rA6o5Y=;
 b=bqzhCygI4qgp8DoC+myJcuL101rc5DuOgJoq6iFW2q8vvI7jK2Ygxpgu8ZAt9Gm/8cIMFq
 OIEmUIl0R3WP2mY0tFwPC0ycMmM8GB572XckOzHTT6IZjHTBH+pGqoDqNUhMx9uFh7fZoQK1
 GCssimINyG9j2p61Ke/pp3ZEmrP8NAvIZYf2TVRGmpII9ICnNg1g7wJ/4WZ0cc13CtfOhiaZ
 Ptu+6z0/QxQ1ZTMBUrT5Ja0AjHTH3S4O+lBU7IITpwHqViTdwX4g6TuOPyNQJdsz57jhJWZA
 d5Cyu72qni3qqonWl4yz1+cg/mviDGLM7w4puymIhwIo2509ge4rK5cg==;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: andy.shevchenko@gmail.com
Cc: benedikt.niedermayr@siemens.com,
	diogo.ivo@siemens.com,
	jan.kiszka@siemens.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mika.westerberg@linux.intel.com,
	rafael@kernel.org,
	wim@linux-watchdog.org
Subject: Re: Re: [PATCH v3 0/2] Add driver for Intel Over-Clocking Watchdog
Date: Tue,  3 Jun 2025 10:43:29 +0100
Message-ID: <20250603094329.125537-1-diogo.ivo@siemens.com>
In-Reply-To: <aDy09SFPkzr2AJnr@surfacebook.localdomain>
References: <aDy09SFPkzr2AJnr@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Hi Andy,

> This doesn't describe why we need the driver. We have established ACPI WDAT
> table. Can't you utilise it by providing in the firmware?

You are right, I did not make that clear.

When you say we have established WDAT table do you mean that this should be the
mechanism that we use going forward to control watchdogs in ACPI platforms
generally or that you know that the WDAT for this specific watchdog is present
in the firmware?

I wrote the driver because on the two platforms I have access to (a fairly
recent LG Gram with an i7 1260p and a Siemens BX51A) by delving into the
BIOS options I was not able to find a toggle for them to provide a WDAT table
for this watchdog. In fact, on the LG Gram by searching we can get it to pass
us a WDAT table but for the iTCO watchdog (at least that is what I gathered
from my testing).

This means that to the best of my knowledge there are platforms that do not
provide a WDAT table for the Over-Clocking Watchdog which then makes this
driver necessary.

However I am not an expert on this topic so if there are things that I am
missing I would be happy to work on a better approach.

Thanks,
Diogo

