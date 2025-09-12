Return-Path: <linux-kernel+bounces-813993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CA1B54E09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C2A17E150
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96D27281D;
	Fri, 12 Sep 2025 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGmGcjUh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB12E8DFC;
	Fri, 12 Sep 2025 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680204; cv=none; b=eP7maaUr+TOdukYiWNExMKs0psT3+HBBSEaIFJuVwuOr01xqONvJWr4xatWotpmZ3lsPv4Veo+NuHWaVb5AQ4Ttp6o0uhTRaEc1ZFYuSUtSkS2T7AWGvseAAVNjAU0/AJjJTcjNgvxdYjra2bSIoKTcAirKwCLTjZtRhk0xefDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680204; c=relaxed/simple;
	bh=7eNMZX2Lm0slU221FzEZQ9V0apcm/Namcks+0f3kse0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sKQzsrdlJNg5HziuD11fjKfZ7Ora/pvSQRDujayh8qVd3WvThppUWZ9Lb84Mr7MQNEQSI5wyCR+Rpd4kev5JJ1MxPXOl/P9uNdm3jtguAjaseJbHcKhoqPBZi5CPbzpCKlipJhwd+o6KgVUCN2qG0pB8/KbLIwzYMngqy1x01M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGmGcjUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F4CC4CEF1;
	Fri, 12 Sep 2025 12:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757680203;
	bh=7eNMZX2Lm0slU221FzEZQ9V0apcm/Namcks+0f3kse0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=kGmGcjUhO4zStYoHWmbu5GdpqrVuJVPZLtXY+mg2ycVEPNOJAahCjMGu4cDoVgVGL
	 LHO9RQMmmSf3qi15vYcd5AJKulQhT93abOUFhQaxhUu7h/09QsK3zwaX4Z9fiJbn9w
	 wGLltj5Xquu/9h2qa/JtnS2JduCw0hRJClOVE4l0+2rZq4m42fEvceJwx+iu+H217v
	 vBByf8CT3uj7tprFOilc8LN1Y4uDVV8/1lsIuDp6aWWGhYRUAQ4XZf+DSYi0AyN0Gi
	 wRIR8siJThz1LIbILNkEDwuG/2xxsKnoIYcjr8ICSMmifU0TFDLDypTqSgqOdiPDLC
	 O8gD6B1qMMkOg==
Message-ID: <6bc074b1-6257-4571-a137-f569203c5df5@kernel.org>
Date: Fri, 12 Sep 2025 07:30:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add 4-bit SPI bus width on target devices
To: "Fong, Yan Kei" <yan.kei.fong@altera.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>
References: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/10/25 21:21, Fong, Yan Kei wrote:
> Add SPI bus width properties to correctly describe the hardware on the
> following devices:
> - Stratix10
> - Agilex
> - Agilex5
> - N5X
> 
> Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
> Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> changes in v3:
> 	- remove the unalign email shown in the commit message body
> changes in v2:
> 	- rewrite the commit message body to align with 80 characters.
> 	- add additional reviewer
>

You have a series of v2 and v3 patches in the same thread. Which ones 
should I look at?



