Return-Path: <linux-kernel+bounces-836529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20768BA9EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B763C6ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FAC30DEC1;
	Mon, 29 Sep 2025 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xQ740c/6"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4330DD05
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161800; cv=none; b=bQshFjfDrdbwW05QJOIr4u3E6CaM4bgQg1Pfb8GAUhfFp3M63+TPxgy/PJQpObjgg6IYAsIrhYVRcIsLV7kUHZwLioizcXxXcQlya96NrT54w+CTNfqMMaZNWRl+IE5RhcCpLdj8qfvXZvpYZ/CCBW1+TUPEjmaffivEWxU7ZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161800; c=relaxed/simple;
	bh=1C8ybsyb9yQ1UmO5cXiz1kvHuhwCzJqJDcXcWDZOKp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P5LislxjWQ8m/TEgnsWCeS3fijKgWadjEyZIMVHH3W1+BHmCR+fKaOUmxsuZRaQpzEeKPemQrBzVftyQ6f8CGsSza0ue6jYNRLt1Ls0+3XQFD3hWOYGAn08apPxA3tg3GvHnlEovzOE4K5yKwn8rbCSEc7XIv47k1PYlTN8rqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xQ740c/6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E87824E40DE2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:03:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0A5E606AE;
	Mon, 29 Sep 2025 16:03:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10995102F1892;
	Mon, 29 Sep 2025 18:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759161796; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=96HEK4UvGCOo8Woo1oy+a2odFHzZgoRuFfoU8CA6IEw=;
	b=xQ740c/6iaZTnCc/giPM9R+u8rp4EOQWA0FFEej9Sh4ewD6Y10jYcCo4LlEmBO2aW6BPSs
	EIdoYs12ibW1QZHTwoyxIjfYBPKm3RJjQ2MkiPcSmdofc90GfmTtAHDQh0Rnu0mvwjo8JT
	L2T+zQgCuYD9EvdO2Kg8ftKpJuRO3ZEbT7RFp0HDB5YVLDB8M6S0sP4PlW6hMEwAWbSdJO
	jL6b6OO8Dq1051tvgrc8m4UX1jDxdqDurfkDuz3dKFwkCiysUUtIY1whDZzMX7ixkK4dUN
	l9cY3E9Ul2+CGNM2321atV6aWatEwzjFtfOAiYTAOYO6fWZ7dYQmfqfDF3pYwg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, Rahul Kumar <rk0006818@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
In-Reply-To: <20250922071137.900508-1-rk0006818@gmail.com>
References: <20250922071137.900508-1-rk0006818@gmail.com>
Subject: Re: [PATCH] mtd: jedec_probe: use struct_size() helper for cfiq
 allocation
Message-Id: <175916179288.52129.13789986252755392222.b4-ty@bootlin.com>
Date: Mon, 29 Sep 2025 18:03:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 22 Sep 2025 12:41:37 +0530, Rahul Kumar wrote:
> Documentation/process/deprecated.rst recommends against performing
> dynamic size calculations in the arguments of memory allocator
> functions due to the risk of overflow. Such calculations can wrap
> around and result in a smaller allocation than expected.
> 
> Replace the size calculation in cfiq allocation with struct_size()
> helper to make the code clearer and handle overflows correctly.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: jedec_probe: use struct_size() helper for cfiq allocation
      commit: 527668868862e0db65efc88fe82040f1e48d4ab3

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


