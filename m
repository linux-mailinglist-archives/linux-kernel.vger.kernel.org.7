Return-Path: <linux-kernel+bounces-817802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD9AB586BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F96B7B3711
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB782C21E2;
	Mon, 15 Sep 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrTjPJgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76BF2C178D;
	Mon, 15 Sep 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971614; cv=none; b=T1I6EAbbOR+wYKiHRikOMs/54ielwxUqrvMKDJ46wCk9y7Uhx5ytwRNzqRonB+lSvQTDK98X0k/EodqwiWqv+ICf1JUamUa67Hbnu25mnovaoCG5BS8rUQSQxwjioGi+m0fraqVO8Zvqy2QfEe0a0C54NGZx3nztRw96vrr7qDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971614; c=relaxed/simple;
	bh=YWwGJapMijdSxjawguNUHcO/wG66MwCsJ6E+xycDnKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe4rJ7G/mZ2uSUBNswuK8KHdU5kITxCyOYXqjT/5L6hGyCSRqtGepKdDk9Pouks1MhG5fFdcS7RcpLnbLmCzQnmaZWYfu2yaUnBiM34TAUx7ZUmhxG/yNHhDslrobcw8K/ZbD0kncmGwKJGMGOPY9MneXjoWDB1fkwn9oR6Wkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrTjPJgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30434C4CEF1;
	Mon, 15 Sep 2025 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757971614;
	bh=YWwGJapMijdSxjawguNUHcO/wG66MwCsJ6E+xycDnKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrTjPJgTkvHYVpb/GkL3QPOmbi7i0q2OkJq1dmpKs1sP1/wKQvmtyDTvKlAO2NFqG
	 FPRnKrx6LtA5rPsmQsd/xIjaXOgXI0Ali7Vf421kWGSJb+OYxhBUB0MD8SeWU1oFcT
	 /j8d5V5ky+M41y9WQkz2rdSqXU7umz22BpszAONw8M53rfUtcUBWE0G2lyeSSwTrZ3
	 n2x3bovtXuR+EM01vtSjDRtasB1IIAeuzLOgU4upx26+MN1/KXLSDwKI/9hfR42E4f
	 Ca7GBU9Em+P7O8Z3PlOrqVb1ANHuvEtVYSb/jr6q3Z/zp95mPuajgkHwRV1679eZWb
	 3ku2bYp3yKaCg==
Date: Mon, 15 Sep 2025 16:26:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: devicetree@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-media@vger.kernel.org, linux-clk@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: media: remove support of
 stih407-c8sectpfe
Message-ID: <175797160740.3536653.13149146984626222778.robh@kernel.org>
References: <20250912-master-v2-0-2c0b1b891c20@gmail.com>
 <20250912-master-v2-3-2c0b1b891c20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-master-v2-3-2c0b1b891c20@gmail.com>


On Fri, 12 Sep 2025 13:36:10 +0200, Raphael Gallais-Pou wrote:
> Remove files documentation from stih407-c8sectpfe driver.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  .../admin-guide/media/platform-cardlist.rst        |  2 -
>  .../bindings/media/stih407-c8sectpfe.txt           | 88 ----------------------
>  2 files changed, 90 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


