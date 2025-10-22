Return-Path: <linux-kernel+bounces-865533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF62BFD66E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87ACC406B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080EC29BD85;
	Wed, 22 Oct 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPRAYTj5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qbLYTF8r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4515272E51;
	Wed, 22 Oct 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151068; cv=none; b=Sc7tWtcjQYXCraR6eQcKh7qflCMR6YeeoGzxr26h+vXZon3RtbAzuPE0MA9VBgI2L4cBXvh5S5Qfg1UfN1GmDtsqWW+U8IRRqUzNrgLa9tubhglSCqX1j6YvE2q2QMgV2bdV8VYpv/mrhHXPVoQeSD/dl7DH0P3A7hazjULuL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151068; c=relaxed/simple;
	bh=flOsHkObuD3KNIIhAEZNg7T3MWjodq9zvwfHOxTck1g=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWAfDIvH60dxmvER5tXzk+9F5Ecly0rYx4oLp+UW5hP2ihrJ4tglaPGAr5ROQ0SrTsChHjMV0jE3o5/Jc0kvMB2NGed1/P0R/FisiRA9QE9MJHyaLttUI061BusMJlkMG4U8er2DZWjlitoZFezCyb5trE+Dgqmg625A6XlDqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPRAYTj5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qbLYTF8r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761151065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V87oGT85aTQasUZiMJWRE9RqxAPo4aSgAPSUdDURqZQ=;
	b=mPRAYTj5Dh5mX2LmMKeKOiWNLWNbqx80YIoWu0l7EoQ32Kfq6IKfmOFNuVWEl4sUCCQSI6
	FfPLpQEkRP1itkSSSCc5OevgONypSd9l+dPPIxDdtquwcPyu7AHvo0L1MAmnBDG7ZbP/vy
	9FRUyHeip4vpfBxyIdPWpbdi4PENYp/lX5rFO0I1YGs4/F1CE4C0pmYxCQJDzv3oxksXLa
	gAAKGHSv1HGEgJSWWMcwNL6fRGTdpmvY9CChW36CMDmmsjN6TbID3MXK9vFwAcOwhULNGF
	L4Hzaxig6uU6knf55KonxnE0Tmcazzn3/WufCXusTrNB4DDwCdPcifNb/GJN0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761151065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V87oGT85aTQasUZiMJWRE9RqxAPo4aSgAPSUdDURqZQ=;
	b=qbLYTF8r3Oq/U+GMSjoIWBCyfCVvQ4zGZBagssYSDLcjHGUUgAQJRgfPHtENijbJuGqtRp
	7gjIWKyrtQEo6qDw==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 jk@codeconstruct.com.au, Kevin Chen <kevin_chen@aspeedtech.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v5 2/3] Irqchip/ast2700-intc: add debugfs support for
 routing/protection display
In-Reply-To: <20251022065507.1152071-3-ryan_chen@aspeedtech.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-3-ryan_chen@aspeedtech.com>
Date: Wed, 22 Oct 2025 18:37:44 +0200
Message-ID: <87h5vqyjs7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 22 2025 at 14:55, Ryan Chen wrote:

The prefix is: irqchip/ast....:

> AST2700 INTC0/INTC1 nodes ("aspeed,ast2700-intc0/1") not only
> include the interrupt controller child node ("aspeed,ast2700-intc-ic"),
> but also provide interrupt routing and register protection features.

Lacks a new line to open a new paragraph.

> Adds debugfs entries for interrupt routing and protection status for

Add

> AST2700 INTC0/INTC1.

But what you are failing to explain is why this is required and
useful. Just adding code because we can is not a real good reason.

Thanks,

        tglx

