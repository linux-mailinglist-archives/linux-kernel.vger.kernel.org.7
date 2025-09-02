Return-Path: <linux-kernel+bounces-795803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B1B3F801
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D20E16A844
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D812E7F27;
	Tue,  2 Sep 2025 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiIr34RQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82326E6E4;
	Tue,  2 Sep 2025 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800906; cv=none; b=fAxoxXZy8S/l8y7Zlr6fAh/pPM9KVRkU23FyJ0k5bu2D/bWwdx40/nUeTZmMkzkFek803bK15UTgJeR9GKjtQTRRjnJWFjkJwpgsh7Yza3W1TDE+rorZKntU6xgSteCURxMx6bBAWvJi2TyjXo3Qki9NA6V29HwNhXnuyaGIe54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800906; c=relaxed/simple;
	bh=eNj80VaVIJ6I8gAp2y6ustAHm15ycxpRRerpSvOHzWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RDxYiS1gW+dmnt5oeRznLkJNeWI2q+ZVXmLh3WRz4qOEk43sKtIMR0i3M981tglKbwP/vWbsgqkA8zia/Gvo9JNv9ahEFrQI4MSR0TsIAPkCqDrQdO6yDLBtj1+ALcmzNIbXMuhOVdKxvbjTbMYuLBd2YpPmz+jgSSUiKDdZNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiIr34RQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B63C4CEED;
	Tue,  2 Sep 2025 08:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756800905;
	bh=eNj80VaVIJ6I8gAp2y6ustAHm15ycxpRRerpSvOHzWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TiIr34RQZOcIAK/nZ/xiaMhqOWUpfNIVuBJmfeyn75dn9Nl/mDyG+tRLYsgTFyCqV
	 y7fcmayzoEuhI9Ll2Ws3wdilsFsexXFta55sT0y8yKkzp8U/dYcPaDr1t1ub4XKJtp
	 gBBGEc54w129rNDawqIudYF8cV7ekTvad0Qv/Or52IXq7cq7uj7OwMu3WJhKzZVdHL
	 HU2RuXeanG74qsBCGvhzOKJt418ibx0vmRXbj5C+YgYCqkKEPnbj3PYZNrJPbUKlXg
	 w2qB3Psbc+0WlMs+V2GMPdJV/4asE5LlkksCeSzpCQpO6hHZ929e7kiyDBeJ2OgAGC
	 OLY2f8igTh21Q==
From: Lee Jones <lee@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20250807071932.4085458-1-arnd@kernel.org>
References: <20250807071932.4085458-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH] mfd: madera: work around false-positive
 -Wininitialized warning
Message-Id: <175680090336.2185785.11760207261424041452.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 09:15:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 07 Aug 2025 09:19:28 +0200, Arnd Bergmann wrote:
> clang-21 warns about one uninitialized variable getting dereferenced
> in madera_dev_init:
> 
> drivers/mfd/madera-core.c:739:10: error: variable 'mfd_devs' is uninitialized when used here [-Werror,-Wuninitialized]
>   739 |                               mfd_devs, n_devs,
>       |                               ^~~~~~~~
> drivers/mfd/madera-core.c:459:33: note: initialize the variable 'mfd_devs' to silence this warning
>   459 |         const struct mfd_cell *mfd_devs;
>       |                                        ^
>       |                                         = NULL
> 
> [...]

Applied, thanks!

[1/1] mfd: madera: work around false-positive -Wininitialized warning
      commit: 3105933c2cf5e2e1908d31500fff72e28e0d94bf

--
Lee Jones [李琼斯]


