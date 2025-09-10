Return-Path: <linux-kernel+bounces-809805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD340B5123D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CE6166361
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022943101A2;
	Wed, 10 Sep 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QPRD7LY8"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB930C35B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495786; cv=none; b=OikWS7pTzjW4+xtFP2srkQTWyZM2sMQfpM7ph0UoQVqnV1Pp6BRS9/kVaoSevSe+FeXHX4CUqlAvbFNkze1IDyjKKKlu1AzttmpywxlkXPF1iuAqdX9HJvqT0UBml+XVGJ5yVjN4FB5MygEcXRNq3weTfTU3wM2mF1d1wH7tG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495786; c=relaxed/simple;
	bh=4P3CDzfEZrqo9gSbgoqfTH8V5GlI/o7Rg3C0tetFSq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfmrCgPfvRgm873OtbNYvgRg21XRw7+34JSxASFFDjFmwFuL1ec1Svb2xS5RdmL70eYoAaJUi9s2f+Szd8EIu9GPv8KDJrk5KpvpLpTxU//yeViHdGCDN/57eKKFu5sNPyAFyIFvGIw87mnPVxA5fysF2QNgn1C2RSwiJKVEUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QPRD7LY8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8BCBDC653F9;
	Wed, 10 Sep 2025 09:16:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44FF4606DB;
	Wed, 10 Sep 2025 09:16:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E7BF102F2862;
	Wed, 10 Sep 2025 11:15:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757495775; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FsOuDOZ3Q8DeS6DbUPWzqTzr4s9wvnGaAwhr1cDjmiI=;
	b=QPRD7LY8/FbujFth3EBz73yJJoZYr+cXhwz9KpuAfq4oPEJWlTIfUTw6PPuCIHEQVC8A+x
	SLyR8jijFSAcaDzYBTouNO7XxHirvR3SaBpQD47Rd1+dpaqiHlmvE7cON8OdqtglBkPapQ
	XdCp+Lq85XOZ03vWZprYpC4+tlOpk37ddj97p+UfW8TvP1D0HVGy0TuE8aUPXS2hFdbzAk
	U71R87QaFe+YVW834bnfWUjk6dsmoxE5KneOvFc21XWAX9kxGLfxbDcSpfY6ozgEMiRcU1
	BQldMIUCWs+xo7p+aOEcJuWc1UOgeA2uuRaW+0cR3vKPe+Rpxk6bo6VSeF59ow==
Date: Wed, 10 Sep 2025 11:15:54 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Carlos Llamas
 <cmllamas@google.com>, Elliot Berman <quic_eberman@quicinc.com>, Stephen
 Boyd <swboyd@chromium.org>, Breno Leitao <leitao@debian.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] scripts/decode_stacktrace.sh: symbol: avoid
 trailing whitespaces
Message-ID: <20250910111554.22ab1dc9@booty>
In-Reply-To: <20250908-decode_strace_indent-v1-1-28e5e4758080@kernel.org>
References: <20250908-decode_strace_indent-v1-0-28e5e4758080@kernel.org>
	<20250908-decode_strace_indent-v1-1-28e5e4758080@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 08 Sep 2025 17:41:57 +0200
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> Lines having a symbol to decode might not always have info after this
> symbol. It means ${info_str} might not be set, but it will always be
> printed after a space, causing trailing whitespaces.
> 
> That's a detail, but when the output is opened with an editor marking
> these trailing whitespaces, that's a bit disturbing. It is easy to
> remove them by printing this variable with a space only if it is set.
> 
> While at it, do the same with ${module} and print everything in one line.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

