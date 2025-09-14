Return-Path: <linux-kernel+bounces-815886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD265B56C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736FB3BF454
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090302DF139;
	Sun, 14 Sep 2025 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OvTMYaCU"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941A1F3BA9
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757883219; cv=none; b=RN1Q0Xhsi8En75op+2aK5SDy5xzpjOz1dwYQKCt5qE0degqnTey/rRF+PnPqWyJW3iJe+4kurt7K75mVqb6GdjrfI8kUYiCdaUTbT8h2spOvbPrwQ79zqGi28gy53pED27fMW5sMKqXB+jtH+EiSr/lCGpHdVAaE1maXCz3Tvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757883219; c=relaxed/simple;
	bh=ZY4Mm/BP3aJRJMxeHI3KlaRUTso3RRxwyd/vaq6/zM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG/M+r/E4aPedWkrsFnZFzabOcITN9m+WjAZF6y3RbKFMcAyvpSl/HnihIiRkfs5otGF/YX0JKGLxqxbOfeEWNnrpRkUZBdJ7GJXvvc98R8Thhy1ad1UFM/R03SGnqMY/9UP5OdcgaDa1jLWAAD0c4E9wJdnXHsyzp8nTnV5qkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OvTMYaCU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 016E21A0DE4;
	Sun, 14 Sep 2025 20:53:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C89AE6063F;
	Sun, 14 Sep 2025 20:53:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79765102F2A78;
	Sun, 14 Sep 2025 22:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757883214; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HQ8T6B+ejU/9vBjSV6TLHtN/dHQwDrZIyXpYbfx8+7U=;
	b=OvTMYaCU4uOgzwZQUCoMBIDkK8d+4DjCL7bI2dSxVoy4N3hO5XgB+rmZVwJBwSnpDk0KJ+
	qQ7l0eiF9flOJuoNoO2Yk7rwxJgqzNAVkVKhbIbUXujsjLyqBR0L50zszoq+U61iC7sVI7
	OYt7aWxYwE4YWzEh9hDM1gpqs92grfmY8hXI347nfEI05WeyS5UWTFps7sTIC91jh6o/Fh
	e4KN1pUJ5c3E3OYiaDC6DAjrLGrmlgN7Zm6VhvY1RQYFQAxo5HavHPHVNzRr4qLTMSlhce
	2AiSposyRXSMtqH+agrQct8HnXQBDK4rEypSIuXlKRyohT0ezjZIvj+vlxjEUA==
Date: Sun, 14 Sep 2025 22:53:30 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: git@amd.com, Frank.Li@nxp.com, wsa+renesas@sang-engineering.com,
	quic_msavaliy@quicinc.com, Shyam-sundar.S-k@amd.com,
	xiaopei01@kylinos.cn, billy_tsai@aspeedtech.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: michal.simek@amd.com, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com
Subject: Re: [PATCH V2] i3c: dw: Add shutdown support to dw_i3c_master driver
Message-ID: <175788312847.382502.8673903984944138470.b4-ty@bootlin.com>
References: <20250730151207.4113708-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730151207.4113708-1-manikanta.guntupalli@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 30 Jul 2025 20:42:07 +0530, Manikanta Guntupalli wrote:
> Add shutdown handler to the Synopsys DesignWare I3C master driver,
> ensuring the device is gracefully disabled during system shutdown.
> 
> The shutdown handler cancels any pending hot-join work and disables
> interrupts.
> 
> 
> [...]

Applied, thanks!

[1/1] i3c: dw: Add shutdown support to dw_i3c_master driver
      https://git.kernel.org/i3c/c/0b1493337935

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

