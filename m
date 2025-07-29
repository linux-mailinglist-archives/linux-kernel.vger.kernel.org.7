Return-Path: <linux-kernel+bounces-749126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0245CB14A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267E4168873
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E459285CAA;
	Tue, 29 Jul 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFPRWVqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81E28540F;
	Tue, 29 Jul 2025 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778934; cv=none; b=r/d52zzC2EmY6nsZJJ1P8aR3D/gVJifs+2379jzNmsSBwQDXQlRfIvhsIoWoari3G4em693bm00famUBsewTJ912dD2iU7SvFA+QfDFQkVB6OR7cv0+R41T5hGLgjNoMf4Sff1R4KEyGchDAbXeWqrnn5XPizI6l/HGJBKaMYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778934; c=relaxed/simple;
	bh=JGzmTwYYrbI59qkPeNZItYLq2tGzPcEAIKyarJo8Rlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PspTHJRBdcn2GlnL0btMagn9Yp6xPkzB66BP5UVheFkLAI41Gk86JC/RV6w0q4EyvCreaPqMTtLaqOm4HeG6FcNIlFVUmWLhqAoMyH9Zx01p20NzbynaCOWRPazBsZv0VVk4ut/VJFiC9RTd3bu5nRiSb779zut6SfeOD/wtIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFPRWVqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5106C4CEF5;
	Tue, 29 Jul 2025 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753778933;
	bh=JGzmTwYYrbI59qkPeNZItYLq2tGzPcEAIKyarJo8Rlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFPRWVqWozpr9+yoP1tCz7C0r6F52FrK7dKuDTazEJvCIQ/ZocjB72A2hvZJiKpKZ
	 ykB4j6BW7P2bMALc5s6VqnfC/y+F71CWEppBw5WD2RcjCkBOubl1mfUI9PD20KNDsV
	 gxwSpZPVMykmuy+24v513UKfNXnYnOFMZ6ge9nvp/oGZClFjKcbh75Q5OjctU5Yx31
	 7ps/MAUm0wbf9Nz8M+wD4NLziDZj2SkFUemYW2ENXoyeUtEhNv5o8LrVWwbCKz0Se4
	 NXzEM/aNINayGi/aGAiJQnIJjsoshMbJOeS0GHg4fctL6ROzZly3+CLHjXQ0nAJgad
	 kNlzKbmDBLvAQ==
Date: Tue, 29 Jul 2025 10:48:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erik Beck <xunil@tahomasoft.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Add Support for LinkStar H68K board: ARM64 and
 RK3568: dts and dt-bindings.
Message-ID: <20250729-poised-proud-ibex-5ab838@kuoka>
References: <20250728-linkstarpatch_v5-v5-0-b4ebfeaca652@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250728-linkstarpatch_v5-v5-0-b4ebfeaca652@tahomasoft.com>

On Mon, Jul 28, 2025 at 11:07:35AM -0400, Erik Beck wrote:
 v5:
>   - Responsive to comments received from  Krzysztof Kozlowski <krzk+dt@kernel.org>
>     - https://lore.kernel.org/all/20250728-dashing-discerning-roadrunner-bc8b87@kuoka/
>     - https://lore.kernel.org/all/93c39b36-07c8-4883-bd23-7d0194c50a7a@kernel.org/
>     - https://lore.kernel.org/all/642df1ee-5e92-4f0a-bcdf-7e10dbc0d59b@kernel.org/
>     - https://lore.kernel.org/all/9ebd9797-8d92-4799-bb8d-59a796e6043c@linaro.org/
>     
>   - Changes made are:
>     - Revisions to commit messages:
>         - Removed notes on base commit;
> 	- Fixed checkpatch warning;
> 	- Removed notes on device history;
> 	- Fleshed out the top-line summary of the dts patch;

You did more - also changed order of patches.

Best regards,
Krzysztof


