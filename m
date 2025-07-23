Return-Path: <linux-kernel+bounces-742952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3956B0F8A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D9417D7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D585120E717;
	Wed, 23 Jul 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQvik5Ze";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s3FwFLi6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97782F5B;
	Wed, 23 Jul 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290515; cv=none; b=u5dyps28RXnlFi7FRu2kvCyNSbH+yaJq6T+zJUgfDboGxcNo3pItuFA+ctEXmVeJgZwTpolIHR8ouRtgI7MCFwQ8tyHlTXGMZcDpntyqI0csDOysISCT4bAngrjsbM6Id0LQtbjQ7DMX4Cu3JfFTsGVthwSNqTlrMFwKgfg8hZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290515; c=relaxed/simple;
	bh=ayW+70j1SKRNbxmtM6BEN8MtsgzWyaR3bkTkLp5gqbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o/qe+/7BqllpIyVZWMuc+yu4a1m1LrnkMpd19RUZYCJxD/tjv/67Ud30dlB8oU5nL27ONIq8lHW9FQoeNexESABxq/IHvUyaqiMtaq6IaYafRbzWsqCxndi3e1LWvnaLPjF+s2AU/4Dopl37j1VpsQjOaokY5N4hbrH6kTFsNQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQvik5Ze; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s3FwFLi6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753290511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayW+70j1SKRNbxmtM6BEN8MtsgzWyaR3bkTkLp5gqbs=;
	b=oQvik5Zeb9uwcQOxRMeNjmc2wDRcZcz+cf3UjqGE6WAmAlQuUifSLs07JIuqvXMksgBVOx
	ZE9osLolL9paY+17UrpsRUsBGu5j9XvTf19cBjgNlRz6ro9asyiJwsOvrDculRauNIUwo+
	0s3EJkRdKkqUrukyoezwX6LoXT3WqKUDbBQ/TEFxC1ry0/tLenQrVdWLx9yb/6LXUdDnee
	5p6vRzTP+COZbrJDCpfo375Rxkn6CVMo/M+wxvKbCLGBwMqMVnbKCjgvWWKF++kwn4UkFT
	19MXHzs5FexCmL5FEe8q2VBnJX+5Pa/8O/low1PBPR+D5wNaULOdS6ET61yWrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753290511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ayW+70j1SKRNbxmtM6BEN8MtsgzWyaR3bkTkLp5gqbs=;
	b=s3FwFLi6bNx8dgZz5uc8FZXzRsO0Xw4jPLZYgxlv3yvSCD/wJx+wxZG27451eNXqfMIspb
	yy62gFqs5T+7+ECw==
To: Andrew Donnellan <ajd@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Mark Rutland
 <mark.rutland@arm.com>
Subject: Re: [PATCH] Documentation: core-api: entry: Replace deprecated KVM
 entry/exit functions
In-Reply-To: <20250723075134.105132-1-ajd@linux.ibm.com>
References: <20250723075134.105132-1-ajd@linux.ibm.com>
Date: Wed, 23 Jul 2025 19:08:30 +0200
Message-ID: <87cy9qsult.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 23 2025 at 17:51, Andrew Donnellan wrote:

> The x86-specific functions kvm_guest_{enter,exit}_irqoff() were removed
> and replaced by the generic guest_state_{enter,exit}_irqoff() in commit
> ef9989afda73 ("kvm: add guest_state_{enter,exit}_irqoff()") and commit
> b2d2af7e5df3 ("kvm/x86: rework guest entry logic").
>
> Update the references in the entry/exit handling documentation.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

