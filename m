Return-Path: <linux-kernel+bounces-846822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7F0BC921B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F0304FB444
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C351D2E6CAC;
	Thu,  9 Oct 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qll61XUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5A26FA5E;
	Thu,  9 Oct 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014392; cv=none; b=Dy0zc5LfM5o0ok/xdS3J6Ho1aRt/US4ysEycPdi77bDZYc8j3a1pxCBoI/rBD1DWS5cJ9sqRdvUnYWvEr58uiSrw8A2jGubKfySYTQTGIcn7XAv0+GU52wfqU+up7k/SAx0+R+CeQ6qIbu+GGLhb04ErQF8MXBB3O1Bl7dLykGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014392; c=relaxed/simple;
	bh=oP89RclmYbvwO09DKcvLM8F3nO0qIiOHSOiirvT/f9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYVDxNgsoOK0fbCzIIDDxoV7JTAms9nJSSU+bBmlU8Jb5jg4+G4hCCswpTkHGLhZ/DvOkwYVUYqlXJp2VTb5DQghZufW2Em5EGEVJb1ozMIegG4EWMeKGzq/JGFvIcksU02DLdNWvNZRGbr30S4EktD9rxVno1g3SMX7sKoFMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qll61XUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E300C4CEE7;
	Thu,  9 Oct 2025 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760014390;
	bh=oP89RclmYbvwO09DKcvLM8F3nO0qIiOHSOiirvT/f9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qll61XUMB/xpxCYm0iVmRL4eNM/ayAKnWtx3Hkgw+MkYprxfDAlADy6onkiFay7/P
	 qAX0AUT5Lyv2P6zVQwgjK6shuEkZH6MSuFJt3tahNOnXlI4IBu4un1VCPv5iYHZAJI
	 DYojKZSnqfPcHYeegomkLPaJTEtwGnmMgPOxIv+ns797jGw2H+2W1z/74oBU/vJ/vl
	 5oj32mOSooarqlAQd1LBM5n6d+dzqLJITP6l3KOfvcm6tiRUVNARFIqqHtT52ToXJR
	 ZCe3m486NjaXxSn32EN8xVzvcR3pZC5PliDdejMGBFxzduzimxL3RPxHYFljSN9Moy
	 MHl89FMzBe0og==
Date: Thu, 9 Oct 2025 13:53:05 +0100
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 3/3] dt-bindings: max77705: add interrupt-controller
 property
Message-ID: <20251009125305.GF2796410@google.com>
References: <20250926-starqltechn-correct_max77705_nodes-v5-0-c6ab35165534@gmail.com>
 <20250926-starqltechn-correct_max77705_nodes-v5-3-c6ab35165534@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926-starqltechn-correct_max77705_nodes-v5-3-c6ab35165534@gmail.com>

On Fri, 26 Sep 2025, Dzmitry Sankouski wrote:

> Add interrupt-controller property, because max77705 has dedicated interrupt
> source register to determine which sub device triggered an interrupt.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes for v5:
> - group interrupt properties together, including #interrupt-cells
> 
> Changes in v4:
> - fix commit message: node -> property
> - fix commit message: minor reword and punctuation
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]

