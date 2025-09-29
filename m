Return-Path: <linux-kernel+bounces-836527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABEDBA9EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE8C1631A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D0630DD13;
	Mon, 29 Sep 2025 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B0xSdimB"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314AF30CD82
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161798; cv=none; b=IU8f/pDJKu173p9/XlQei4Rbx+OYrq1VMwBkBSbUqeU5KTF0NjtA+C0Qylrs5L94UZA7tghGlO/gEpcXaDYbIwVvJFLgYQ77KwWlAy3X3AskZV+bgqozdhOigqbJnaLvhGNU+TISfa0lg93cyyDqgUkgrB446q7N7xjPrWhwAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161798; c=relaxed/simple;
	bh=jVXr4AKnZ9tRYCRE5NnK8FcxuJH0gJDr7VmgwMzBeJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GMVnhQs5OwR55nq/4kp394INYl0rvuVN66VF1tOdkddXZoC+VZnea4BaU8g5vu2Ha++EK1SqP/t55ah2lI+aq1fErxsmmnPITxLwgPOvriaRix71LaSY85CCQIPBQfqQdqnDuk66elf74cc0EwY8632EkTrwR8z/tbZjFfOyi64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B0xSdimB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5BAF74E40DE1;
	Mon, 29 Sep 2025 16:03:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22860606AE;
	Mon, 29 Sep 2025 16:03:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7E9D102F198F;
	Mon, 29 Sep 2025 18:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759161792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sQfl2NHN0WXhah4rCT/bpWcrE66H3N6ruqjxAFkBiiM=;
	b=B0xSdimB4aS63FiBHbCdqTuzpFs+u082wH0WE3X/z8bURTWNDzgv/lhDWnkOs8dr5BfFSo
	xnPsTiBfUJxavTckGLzv6rXPqtSPIFvnPVaM2QLZnj0x3knweqOBQRCtgAL16/a1nJe3j4
	7aMS+woaXmRGv42J/JRvznFDXAxPm0Z0S7T1y/lu21kLzprjiwQjVn+4pd62aQPOUdzac8
	YTSQDUxDgkVR8nnRNpdvE0F4EbbCjziB0GjfHA9Cn4kYQAKHHePLpO6nCfPDQ1fMM48tfS
	9mIzganwJLr2Y8WiCmdO6Sz1yAOAaGAmQU9Xly3v0VQJbNrwJUkSuQJspwN+1w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, 
 Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 linux-kernel-mentees@lists.linux.dev
In-Reply-To: <20250918184420.76047-1-krishnagopi487@gmail.com>
References: <20250918184420.76047-1-krishnagopi487@gmail.com>
Subject: Re: [PATCH] mtd: cfi: use struct_size() helper for cfiq allocation
Message-Id: <175916178765.52129.18095278414992754665.b4-ty@bootlin.com>
Date: Mon, 29 Sep 2025 18:03:07 +0200
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

On Fri, 19 Sep 2025 00:14:14 +0530, Gopi Krishna Menon wrote:
> Documentation/process/deprecated.rst recommends against performing
> dynamic size calculations in the arguments of memory allocator
> function due to the risk of overflow. Such calculations can
> wrap around and result in a smaller allocation than what the caller
> was expecting.
> 
> Replace the size calculation in cfiq allocation with struct_size()
> helper to make the code clearer and handle the overflows correctly.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: cfi: use struct_size() helper for cfiq allocation
      commit: d496b6f42eb0455caf5d8cb30cf1f01b7fc2a747

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


