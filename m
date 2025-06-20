Return-Path: <linux-kernel+bounces-696251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C532AE23DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 23:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740547B1185
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 21:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C57223DCE;
	Fri, 20 Jun 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnzQo4/p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T7010yF/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CA30E859
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750454168; cv=none; b=o6Kp9IpEWqYQT3Rn3E/8L4y4PAGS5vbDaQOQtL3J9rVC7CAeDIkgIird0b+0IYh6ZQODjlUK6lez4MR64Nh88mkqRwkrM96yo/Wf7J5Zasrv35UPWRfNKP8tSdvfLytHjaoJSiRCYrhPLmSGemg4VQqb9wZR9iggCTHpQssIxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750454168; c=relaxed/simple;
	bh=jijlFal6xwSOfzbLcgwwla4J5YBsHh9FflVLfcDjLbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mRxBq/TOTK/5kXLniqdbwLqUN5wGV7WdXB8m6J4K6I5142vlJVjFoZyE9wimW0mcCUoYSZyPf7TTtliPSbjc325tv62OHkdUMyt1xfiUX2eC3/rAnG/m/39moZwBOPP9SnfzSj3RAmRH2WYPBTiqxmMGyzov6KqdOQlS5ZHpM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tnzQo4/p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T7010yF/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750454163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ns+sIVP0XB+nAtBYdm5LyeXXCcG2+mTtSxAIt39kHo=;
	b=tnzQo4/p5r0A1S5+ZhjCIopa6mbBYeEO0Qjz0KHDdzMR4cYUJD8kA9yyW3juT00zzRjdoD
	+DdjpH1Eb1Ajv/yZKhxqJfm11gXATpBSh0yIqxkmeFcBF6ELGFZWCTHBMFo1D0V+oXsOSG
	r9cg/nQuMN306/mL203/tfydgB1DiyzHaVnzJeb5sHZjObLsl5ujn0dHCEqwqH0nMNjZJ3
	KYpUvJv35JO2esQSahAxF1chgFQfoDMUnpLf0cH4y362M/ssfaVu7No4LR/T3oygZSYfU5
	8lMxTLy/KCeTeILYoQRbGNecDlOAwywlClws8dIT+15THw8Yj905BYmImbuegw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750454163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ns+sIVP0XB+nAtBYdm5LyeXXCcG2+mTtSxAIt39kHo=;
	b=T7010yF/dECybSkNel5z4FMx70cDgVwrQqfV5dxiOsyNIHUNj4W83a4BOVcxsbqw3JQlfL
	T3Eu+/7f9nyrvcBw==
To: Khalid Ali <khaliidcaliy@gmail.com>, peterz@infradead.org, luto@kernel.org
Cc: linux-kernel@vger.kernel.org, Khalid Ali <khaliidcaliy@gmail.com>
Subject: Re: [PATCH] kernel/entry: Remove duplicate function documentation
In-Reply-To: <20250615120429.1496-1-khaliidcaliy@gmail.com>
References: <20250615120429.1496-1-khaliidcaliy@gmail.com>
Date: Fri, 20 Jun 2025 23:16:01 +0200
Message-ID: <87msa2p10u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 15 2025 at 12:04, Khalid Ali wrote:

"kernel/entry:" is still not the proper subsystem prefix.

Thanks,

        tglx

