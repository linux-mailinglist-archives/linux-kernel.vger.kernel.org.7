Return-Path: <linux-kernel+bounces-899703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E523C58A82
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51ADE424FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5F42FFF8B;
	Thu, 13 Nov 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSdsaO9G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292542F0C63;
	Thu, 13 Nov 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049054; cv=none; b=XhA6ZaMSvYQUG6TcKjsEm66lrFLPvWqe7NB2szYEqEIY/1lX85B7CCVg/i1J6LSqXcBx973WIA2jwWTaZrWyVY1IoNgl2mIkSh0Y8kUrlPMXxSpTj07y0zwF2bZzDmb/J0rIFHwTkdPYxr6ekxeKFdEr7+/pWfrcwXiFTFfqNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049054; c=relaxed/simple;
	bh=NuvIv3BIziLrSvD6tGsq18oZc4WyYyoamFBFn3ungY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tluKL7s0S+LkrKMLKIMPEBcZ9ZB7F0qzZJXtP6/o9rrEpWuzRfM1nYj8VYYa3zbvwQkHZKSkS/hv0bhZa3uy9eEYxHOLXkFgriHQDdQVs/Q9RN0Q1/Y7lUF4m5pA06d+Vymtgc3HW9ozbg30Nl/TDpKlTPbqpN+P6WdsZvWJzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSdsaO9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7726C113D0;
	Thu, 13 Nov 2025 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763049053;
	bh=NuvIv3BIziLrSvD6tGsq18oZc4WyYyoamFBFn3ungY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nSdsaO9GnKg2pmEwldqy4fqLsoZYIkCyIQSMru/hInKQtul8r7h0aSUReBCUvUXtI
	 lzTdfq1s3+JJZtIBvyHrkTXE1G0SyuqQt/e0BMCOIbu1aR37iVdar71o02N5l2pdbn
	 O4cp3zWAG9nJrt41Nf8x6lkONutxN6TO4Yx4vfOthXFnnOSElVVPbvaZrZ+HfqxDZQ
	 DGEXYV4OsJWmUYr119Yv4eFmH7LjbEIpdYvFxSF4G4bk8qQNhaNFKJScuregxpI2e5
	 pW9fHzY6GRKwKzFCXBoHg66NLALMsIgzd0Unudd5VFgVXCCD6hc8g66xpzTz+RjiM4
	 ezb5uuMNE+YLA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, imx@lists.linux.dev, 
 Samuel Kayode <samkay014@gmail.com>, Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sean Nyekjaer <sean@geanix.com>, kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20251029104228.95498-1-lukas.bulwahn@redhat.com>
References: <20251029104228.95498-1-lukas.bulwahn@redhat.com>
Subject: Re: (subset) [PATCH] MAINTAINERS: adjust file entry in NXP PF1550
 PMIC MFD DRIVER
Message-Id: <176304905155.1551730.17046698654950057712.b4-ty@kernel.org>
Date: Thu, 13 Nov 2025 15:50:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Wed, 29 Oct 2025 11:42:28 +0100, Lukas Bulwahn wrote:
> Commit ebaec90ec0b5 ("mfd: pf1550: Add core driver for the PF1550 PMIC")
> adds the header file pf1550.h in include/linux/mfd/, and commit
> a7d6255a0bf3 ("MAINTAINERS: Add an entry for PF1550 MFD driver") adds a new
> section NXP PF1550 PMIC MFD DRIVER intending to refer to that header file.
> It however adds the entry for pfd1550.h; note the additional letter in the
> filename.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: adjust file entry in NXP PF1550 PMIC MFD DRIVER
      commit: 5c17042d6ce7490477eb11b7f90983adbcb5fa0c

--
Lee Jones [李琼斯]


