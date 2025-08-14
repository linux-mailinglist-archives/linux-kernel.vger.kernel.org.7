Return-Path: <linux-kernel+bounces-769447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB7B26EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A2A5E4825
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394B319855;
	Thu, 14 Aug 2025 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKY0/ydQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD2231849;
	Thu, 14 Aug 2025 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195838; cv=none; b=hdSvVQ3ugORbn6ylvA61PQAL/JsfsXRZ0S5tr5ZFYf63JUYVTb+xWSwbqA4aMoPSA4M86Lxpm0LKRBebcq3uMcm1+0na0jSiMTCOh0O7Bqv3kSv15mZivbTBA6hsucaQHfKiwz71M35Z/EWDLfk5RZWAmxZ31A7SIUPKVtqgNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195838; c=relaxed/simple;
	bh=bVicEBCo0rDZfb7TeeR0zodtOs9ylxto1FXK26SKxV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWe8L1QSDICns1/YHdEwk3v2lB/1kl1fr3emYZfLjSufQz4fKwp1ysaC28DpIPcZ4GMFoS2T8tD41io4wgzV8ykYdqKQtnarnUDbL1Y4EmL8W5zoaudKuu1SQe71gNOQZzWeFRFrWWUIFE+Pz1xK3QWIPa0r1HRcJ3SVghvoENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKY0/ydQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A911C4CEED;
	Thu, 14 Aug 2025 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755195837;
	bh=bVicEBCo0rDZfb7TeeR0zodtOs9ylxto1FXK26SKxV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKY0/ydQQ5bOCYlKMRBm4aI6iCSdnlAdx9LnRo6ETKBGUk2dEvWVM+pVgNmACeLrc
	 R+Ln6iow4Cbt1vpP4LOA6XqbxaUjXfCHUtXCWxbZcCKmUepLAfeGkDaYfsROYc7Y78
	 78U/mQzQq1skQ2gus472qQYJFsysZ/4rKFrU8ma5UUDa34jyTOvKK6dVtJM7E6NymC
	 mKx7HfJL71Fcnn5ww6LJvkPzps2/G80E02tUQAt0/O+u3jqRlWUX6nbILLXFBdlKkT
	 tkct8WQyit/uKdXd5o1ehmDaBxA4VwXxEgDUxNWuAVkUfnsqUyPWecKtRWKeUqoIuZ
	 z9swKf0Z4mN2w==
Date: Thu, 14 Aug 2025 13:23:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Wei Xu <xuwei5@hisilicon.com>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert
 hisilicon,mbigen-v2 to DT schema
Message-ID: <175519583586.3483838.3438060375809789110.robh@kernel.org>
References: <20250812203327.730393-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812203327.730393-1-robh@kernel.org>


On Tue, 12 Aug 2025 15:33:25 -0500, Rob Herring (Arm) wrote:
> Convert the HiSilicon MBIGEN binding to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../hisilicon,mbigen-v2.txt                   | 84 -------------------
>  .../hisilicon,mbigen-v2.yaml                  | 76 +++++++++++++++++
>  2 files changed, 76 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.yaml
> 

Applied, thanks!


