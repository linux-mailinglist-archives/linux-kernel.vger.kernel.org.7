Return-Path: <linux-kernel+bounces-882680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409DDC2B1B5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5A13B1ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1473002A6;
	Mon,  3 Nov 2025 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YzZwQ52W"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881642FF158;
	Mon,  3 Nov 2025 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166361; cv=none; b=CAhKFr/FE5zEqetAzCno6YKWTqBGveMYuFXMx+mjfQfn0HuCMzXa6HPiRBqGWE1KpVWG5S1hlLKek8/FaTBV3EiE/ALyOc+Ej2my1+8DCobNe6wqCm0/z8r39IuKJ6O8nX5Gx5EgBLsj3CG6O8ne7N7PToqTEqNvoPtHiD9IxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166361; c=relaxed/simple;
	bh=smcGT1qUHh6wbxjS4q0raxEjI5EqYgotAbw2Il7gBlY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GvwLlqh0TqJwNcHfkPQCoYpzim+xCBOc8UqDLhX3GWlocLciTwXC9BWyrq+5bk3FyCKzR5QkOqJbLOlUviPlubSlcMsx44p3Rh/zctYwGpHN/vine2E3YoGpuoWc4r4JrregR2WFFAySzf7AUAK4KZiSzwUBdj6bENJX2F2lPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YzZwQ52W; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 72F061A183B;
	Mon,  3 Nov 2025 10:39:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48CA760628;
	Mon,  3 Nov 2025 10:39:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6397810B50048;
	Mon,  3 Nov 2025 11:39:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762166355; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pjoQF6Z2Piwu1ua0g1e4fPfIoIQtxuXgSgmVey2wobA=;
	b=YzZwQ52WqCYjNNhztDGM5T4EnlHiA+K+R8X14AH6mEmPBUquJ+rWAKG6qKlEjhNjtfsB3D
	x+13KkKneAw7DVPV0Qx4SY8bmtwicvsmJ+HVSjV+0hPiyCKSe4tHgqmmqt3hcV8UfM9Lqa
	h7lw3DzWEVmcSs+KufpwQhXzUCCHDNIgykKeKw2/sAm08gDvgTjbxwVIinsja/JcTU2oNx
	/5fw6NVFTW4XEy9+Vu7OFrgpLqpoKuHQfUYihN+k3KOO5QYC/WoEEtn6SqxFckzm93hpgs
	OVmXQQOnbelZvbVTbD1uAnS69X8XrgF3dugX7iwuL2VhHZN0+Mt8IRLt3Mt30w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kyungmin Park <kyungmin.park@samsung.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 David Woodhouse <David.Woodhouse@intel.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aQYKXGSoLqCLNqKg@stanley.mountain>
References: <aQYKXGSoLqCLNqKg@stanley.mountain>
Subject: Re: [PATCH] mtd: onenand: Pass correct pointer to IRQ handler
Message-Id: <176216635321.908445.5469559454267528784.b4-ty@bootlin.com>
Date: Mon, 03 Nov 2025 11:39:13 +0100
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

On Sat, 01 Nov 2025 16:25:48 +0300, Dan Carpenter wrote:
> This was supposed to pass "onenand" instead of "&onenand" with the
> ampersand.  Passing a random stack address which will be gone when the
> function ends makes no sense.  However the good thing is that the pointer
> is never used, so this doesn't cause a problem at run time.
> 
> 

Applied to mtd/fixes, thanks!

[1/1] mtd: onenand: Pass correct pointer to IRQ handler
      commit: 97315e7c901a1de60e8ca9b11e0e96d0f9253e18

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


