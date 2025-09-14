Return-Path: <linux-kernel+bounces-815888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5684B56C4F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF5617B844
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C371F3BA9;
	Sun, 14 Sep 2025 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1fRRNe2Q"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577982D9EE0
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757883250; cv=none; b=mCUSecyT7wZV75Pv8lsx/JihRp2Si9bjaHjk/z8k4alqJrtxzyvsI6/6xk90VxXEb9dTgqEJFxeyEnPwtb4K4glzZgyzdDW9/WQem0uR4tn5v1KzLtB7az8CjMar8GW/7Yr+oqKq/qWi+U7f6Q75fwV7GceyAepzI3+YWMFsRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757883250; c=relaxed/simple;
	bh=jk1KMcoRRu/GRUiXpC64ogHKwYMkkfihzLTj7W7dnPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teflciK2QRJdzInW8CEqNB3ANbr8CaYaiGwKr8yHDMU3aRrHh8oGpecNlajT5o5nbdWOniXyv0zpg7w2jJQ+ixQOx4K6M4kbgrgpOk9Cl9GAt0rwQbM2E24z+v6bDgufnhycGGOZXlTIJgmEhtXVKTl8b2PgJcgCEWCEOluQtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1fRRNe2Q; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C6EE44E40BD1;
	Sun, 14 Sep 2025 20:54:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CC546063F;
	Sun, 14 Sep 2025 20:54:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51B56102F2A80;
	Sun, 14 Sep 2025 22:54:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757883246; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=365rKbEk4F7OGQkHpZDwYWQUHqCJNim/0g4ZKb2td2Y=;
	b=1fRRNe2Q43C8PtasUssv8DhRBvddFMPIaE5ckixtWrfYE+bIHl3dF0wb7B6mMy3Fc34xyG
	ePT40SQehgVvBrusgQ67/PX6BmXrSxENnrQtJzvDCj2CvIIYVTN9mh/Q1t9TtHt21Bi4tp
	o5o3MpVBDI/avS3LNqKMs2jq1p4B7KykhJcnNgMXCqu0eAcFjupVgo57ia99BVmqMEc/Ds
	b5zwkhy04gZ/NI7owHB8q9wyX8Op1LNUVyCAZq27Wgr+9QVd9pUbjJKKxcoq33AAfUBYAM
	xDKQthXlqzLQPG0okHUtlX1lPGW1DgQCT88j9LoklzNsvfZWq/K6sQmNBUYTgQ==
Date: Sun, 14 Sep 2025 22:54:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: frank.li@nxp.com, miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org,
	Stanley Chu <stanley.chuys@gmail.com>
Cc: linux-kernel@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2 0/2] i3c: master: svc: improve IBI handling
Message-ID: <175788312843.382502.3655155684242628027.b4-ty@bootlin.com>
References: <20250829012309.3562585-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829012309.3562585-1-yschu@nuvoton.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 29 Aug 2025 09:23:07 +0800, Stanley Chu wrote:
> Improve IBI handling to prevent certain error conditions.
> 
> Stanley Chu (2):
>   i3c: master: svc: Use manual response for IBI events
>   i3c: master: svc: Recycle unused IBI slot
> 
> drivers/i3c/master/svc-i3c-master.c | 31 ++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] i3c: master: svc: Use manual response for IBI events
      https://git.kernel.org/i3c/c/a0b61a0b7a59
[2/2] i3c: master: svc: Recycle unused IBI slot
      https://git.kernel.org/i3c/c/c514db2b47a0

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

