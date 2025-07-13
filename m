Return-Path: <linux-kernel+bounces-729181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97F2B032DE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DF43B0A54
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F581F9F70;
	Sun, 13 Jul 2025 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h6bKbWXn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tX286yD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D151C5A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752437815; cv=none; b=BLert3pm98plMLGs+LqD0EuhdyD00Tku6XGyChbqq0JyTFhabjgK/M+Cx89Se6fgVd6k2M4wMXkbzOY/bL4ibT/rBjh/JZtTSqwsCgoio5OlP8+0fJ8LnaJt8RUdrTeOkBHbAs1N3r9biYxymr8OspJMsPEkF9wi99Gwxlcxotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752437815; c=relaxed/simple;
	bh=4Ate6Iaqw0pAtrScpzyIp0y2DFqThjFgxFwN3l+JIYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WRfsTF4I7V7pjVnRUiRPOmkSdkIXME9Nlh9HBp+Fi7WnhShD0XfObHjPqKKqtQxvyujYcezSQ3DfqXnn2Qn4AeE/3KjTsu8WMUpR71kUGJ7h32oy0ErpRK0HZT1119vJjQVZS22H0xbJnUp+lnObxgLEFycNp84WiWCpRFo30A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h6bKbWXn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tX286yD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752437806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ate6Iaqw0pAtrScpzyIp0y2DFqThjFgxFwN3l+JIYI=;
	b=h6bKbWXnyr77glvl9ECtESpg6QcrE4KJ5GkIv1dSRedZ68Za+RK5nnuSPnyIhW53OusWVx
	UNl3O5Q3NOurKW4OSJRPieriMFOiDgC0fPBTgoRjDQQIdDUqCpLOvbuvOp0q0AYvGh8Onw
	FWQ8O5wOjB743j0g6fO+FRL5aqiRcPlbDG4O4glP+6vhekAo4KSX+MiDmY10eAYxxY3zdG
	8uMPHr4s8vECIJg3th46LolYtKX5SmHtpwWnWZNA3+joJNd+ybsIJxhffpeK955j9u+thD
	bXhHI5Gq0Obn5hBMEJjmNoWXCN7FmC7/pSOb0B4Bn/JV9AC/pU+l6VBITL/1UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752437806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ate6Iaqw0pAtrScpzyIp0y2DFqThjFgxFwN3l+JIYI=;
	b=2tX286yDJw+xbE+CcML+gTJIlbG6qab9hkNcXmDHNmdKL8n3uYYEEWMW1iNxwlUg++/kNO
	dcv3xuiokrak8QAg==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 1/2] printk: nbcon: Export console_is_usage and other
 nbcon symbols
In-Reply-To: <20250713-nbcon-kgdboc-v1-1-51eccd9247a8@suse.com>
References: <20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com>
 <20250713-nbcon-kgdboc-v1-1-51eccd9247a8@suse.com>
Date: Sun, 13 Jul 2025 22:22:45 +0206
Message-ID: <84o6tnx2vm.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-07-13, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> Function nbcon_context_try_acquire, nbcon_context_relase and
> console_is_usable are going to be used in the next patch.

The nbcon_context is supposed is not meant to be exposed like this. I
would prefer creating a proper interface rather than having kdb code
directly modifying internal structures. I will provide more details in
the response to the 2nd patch of this series.

John Ogness

