Return-Path: <linux-kernel+bounces-878604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6CC21153
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBD184ED91C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41F2BD5A8;
	Thu, 30 Oct 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/mD0GaQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253802264A9;
	Thu, 30 Oct 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840088; cv=none; b=ICBKtGL4w35xY6CUJ16SLihWGn9lm/a8nARGeZaRoOJhhDVL3pIQZmRIkGY5zXotUpz9Ivr5v2QBfJpC0wfZSi8YiKXyE3+ysMIYNyHZdVH9KhoR/aZMEr3adB2OkXxM9WTq2C1JwRMKfcKXNTgqIgenXYCpwbCttWg9+AnXv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840088; c=relaxed/simple;
	bh=GGejZF2V9kY3VeWWMxex6v4n4SmBXMRxD77JbL1Lup0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTYZfUI0f1Yhi8bf0uAis4/qWK37AZGNEyi8z5KsL7/M20AHzH9Ve02J8EfpuJS7bC0rawgobDwOOd+3/9WVdoU0IgkJ5jzP8irvMR6NI1wkR4h/HGbVHTyW0BoEcR5dZ7E6PknEk0tjizVT4sse/nS2q2Gg9LcOps6fefCj2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/mD0GaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1231BC4CEF1;
	Thu, 30 Oct 2025 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761840087;
	bh=GGejZF2V9kY3VeWWMxex6v4n4SmBXMRxD77JbL1Lup0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/mD0GaQYfS+g00J1sgAMaEzBidrWsI8dsN0WOA9RYsI8kD0SSfn2FysEsV9D8vXq
	 m1ow4PneLpQusXmLl3L6po1TH1c0yprzBZj/bnM+DWDaCeklkPlVRWqc2gop7M75b1
	 KxqxcRtkg26Ku5qAsiOdNB2C573pZ3RtCW6OQHztRTkiNhM3eJ+Fy8wKNwWN0N2AHz
	 SfWLfqMuuI3t1MQkPWs9Qb8OhmsGykF+7YVZIgTDQR3Q1ZqrorY3QZf51ob3Vmt+0N
	 WUOMn/r91IuRUaoHfou/wc1+2WBpL8I/za1sJmix1To7onIUCmEdHRauTy48dpd4ZG
	 JoKyGNHI8o3nA==
Date: Thu, 30 Oct 2025 11:01:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
Message-ID: <176183999397.4111264.15472275625847253456.robh@kernel.org>
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
 <20251027072741.1050177-2-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027072741.1050177-2-krishna.kurapati@oss.qualcomm.com>


On Mon, 27 Oct 2025 12:57:40 +0530, Krishna Kurapati wrote:
> Update the bindings to support reading ID state and VBUS, as per the
> HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and
> asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement that
> VBUS must be at VSafe0V before re-enabling VBUS.
> 
> Add id-gpios property to describe the input gpio for USB ID pin.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


