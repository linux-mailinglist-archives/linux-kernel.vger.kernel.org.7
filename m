Return-Path: <linux-kernel+bounces-898830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B6C561B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8142A348D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6801532ED36;
	Thu, 13 Nov 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VZoAvvSk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBZGaYtA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B0242D90;
	Thu, 13 Nov 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019987; cv=none; b=Oo8A0ZMsVvWW2Yai/OxXqiMeDRdlXIgycKke7c0frbb9CY+LMN8xTdVb0HVNo52oZQro9qky7mJhYeukm1iKTohowCoHUIUJpoPQXj0qdXi4n4lI98Ow5YlAUpelUQpPAOcKKByeMhfxFmRnGw8QmdPxOaQ7ND910RYukM7nYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019987; c=relaxed/simple;
	bh=+H2VQhdLCKG1W3bQcDuESQVRuX/aoZoMN9lPjBBdSFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bQGS+QHpdxuIx04N9cDhTRsBgwQm3dTpQl3KZGe7kngE349U+toGHCpbZCaaRovOtOfIHLSvZPIcxxhWjhTD7IDztXAheCS3LK3v1NQ+4faj1JGthL9jawR+F6oDnHCmK8Ou/4wzpgPhAFUlW4p7qpixztmaoYIODvT9v0FTWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VZoAvvSk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBZGaYtA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763019984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+H2VQhdLCKG1W3bQcDuESQVRuX/aoZoMN9lPjBBdSFA=;
	b=VZoAvvSkv1Lgoiy/m+G1/GHonFZgX0Iz4wmO948G0FIhCHq9CG79LUHkuqevvHSV82bc0M
	ePMSO7hDWIPY1YxHxDX2c3y+XeR00CNxxntZRPQU/dvCOo2T4DOHQsxtXC7XO9B2jsQo8j
	zc6bZQTK4XbEY4kVKq2sQaIyv5osLqoaI79eeig0FYmBjjcID8H87JU7oqXVy1+KcfLAHU
	0WkpUb5JtP83N/Gc09VhWpUxbBDDpokWCuDrHunat5tyWkYR/CA1nfsj+Ksk48iNztb/P2
	0uF7WAyySUAK8rK6Qjtbb0lk77pGv5vfNpv9qO3PCW8wOUKy4Dr8a0CGdImA/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763019984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+H2VQhdLCKG1W3bQcDuESQVRuX/aoZoMN9lPjBBdSFA=;
	b=aBZGaYtAC5mREDIqUBF41ia1hcsmuzb94Lfxrdbvy7ofi386IJAaogeALW7ZRcmXInGBIx
	ugVQHp+oImr6EGCA==
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Tobias
 Schumacher <ts@linux.ibm.com>
Subject: Re: [PATCH 1/2] genirq: Change hwirq parameter to irq_hw_number_t
In-Reply-To: <20251112-implement-msi-domain-v1-1-103dd123de14@linux.ibm.com>
References: <20251112-implement-msi-domain-v1-0-103dd123de14@linux.ibm.com>
 <20251112-implement-msi-domain-v1-1-103dd123de14@linux.ibm.com>
Date: Thu, 13 Nov 2025 08:46:23 +0100
Message-ID: <878qgae5o0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 16:40, Tobias Schumacher wrote:
> The irqdomain implementation internally represents hardware IRQs as
> irq_hw_number_t, which is defined as unsigned long int. When providing
> an irq_hw_number_t to the generic_handle_domain() functions that expect
> and unsigned int hwirq, this can lead to a loss of information. Change
> the hwirq parameter to irq_hw_number_t to support the full range of
> hwirqs.
>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Assuming this goes through the s390 tree:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

