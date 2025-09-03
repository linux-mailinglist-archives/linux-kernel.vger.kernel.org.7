Return-Path: <linux-kernel+bounces-799572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694ADB42DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226A31C232A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4B3115AF;
	Wed,  3 Sep 2025 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUNt+DuR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343952ED853;
	Wed,  3 Sep 2025 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943742; cv=none; b=m1T+Q4HRQgF90TdbVZOK5zR4c3QI0wU8rDGXKS/hmM+C+YKvoGx6s3DbCCXCKBdLrlB6z5DaehDgl+HJZOerDDSJJRpB5YExRdZt85xHlk9dEbbg4AWseBvBiAkLg1yjq8ogweTD6arpUvsDXeTM6eKzCjqxnaIyQ/tKfw6TsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943742; c=relaxed/simple;
	bh=8kxYmCy2W3BG7qmjwXSxbz7FDy7Ft4ohCF2gD1MejEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbWe8vmEFB5rx5uMS67UZO53Ls6QGc6BVIBwkNYERLWQjZBC5zUk+0ZKl3WKMDROQAE58KToBjuLIt5JealSbBv7wywLeWu2pa8FTsCImGSuFYMESj+UG0s7siXsDf4uxVqfXqCg1c2xVPlaGAngrFZY6QtHMi9UxeOy91MyIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUNt+DuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CC4C4CEE7;
	Wed,  3 Sep 2025 23:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756943742;
	bh=8kxYmCy2W3BG7qmjwXSxbz7FDy7Ft4ohCF2gD1MejEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUNt+DuRR+RL9lYjAOzu7Enhq/s6rWp6VIQwIf4Jb+y2x42iRsacjps3g48Mtb8NA
	 +8Ns8Xy5590gH5uzg+k3qM3ENQ5LpEfbNZlrW5okJTvGY/ErmC44aMvoN2xAxOvAZK
	 /kutcb38viDLOg4564iTKW4c8tav9u3JdNtPXylXGVD1ngSE2ADk2w5oJNfmlphsPG
	 FEG9/OFCIL5iIY5EeSt/eZvvCDTRqbuLkOQy/RN1gBdddh8zFMVX4F1aIUuq18womL
	 wmRDjpTL5N123sdrFrdYRqca46DcvW0EJBNgq1T9NGUsLewIyEIRA5aJwJEjhPl3eM
	 Uqdx7/A5n8i7A==
Date: Wed, 3 Sep 2025 18:55:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	patches@opensource.cirrus.com, matteomartelli3@gmail.com,
	broonie@kernel.org, shuah@kernel.org, zhoubinbin@loongson.cn,
	krzk+dt@kernel.org, devicetree@vger.kernel.org, KCHSU0@nuvoton.com,
	linux-sound@vger.kernel.org, katsuhiro@katsuster.net,
	lgirdwood@gmail.com, drake@endlessm.com
Subject: Re: [PATCH v2 3/3] ASoC: dt-bindings: wlf,wm8960: Document routing
 strings (pin names)
Message-ID: <175694373992.3390745.12577037587339202310.robh@kernel.org>
References: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
 <20250903160119.83625-4-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903160119.83625-4-jihed.chaibi.dev@gmail.com>


On Wed, 03 Sep 2025 18:01:19 +0200, Jihed Chaibi wrote:
> Add a list of the wm8960 pin names to the binding's description to make
> it self-contained and improve the user experience for board developers.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 
> ---
> Changes in v2:
>  - No changes, this file is already refering to device pins.
> ---
>  .../devicetree/bindings/sound/wlf,wm8960.yaml | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


