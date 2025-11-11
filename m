Return-Path: <linux-kernel+bounces-894877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E947C4C5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95FBD4EE6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AAB31196F;
	Tue, 11 Nov 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElwsPqVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249702EA756;
	Tue, 11 Nov 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848826; cv=none; b=P6aYHDKMvp8KdNN5HEG20zBc2qEJK7ymhcoYY7uTTVwSgm0Nc4WNkLG6+srz+yPFBXyPgSsmJtEtJIwvRA/r65SSDrTEo0pPxYJpY8q+/tZtDHUPNoe/ldLSwBrzbVCSxFpfKB/wECIEZC0jdrmEOJ9PTYSr4A0i4o1vFJboqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848826; c=relaxed/simple;
	bh=mq9DV7BieFWsuRbESsEpgGWCX27FGZx5gSBedKe5uXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8oLJo1U2EDSVRPOteddEnvY5zDRYOq/yNKRqebPSVutrWR5Y1w7FW/Wzgl68lbyX82Y0CPNuqPFpWyPczCGSliTukd52WdPHeJbSVSTtgbdJOd3Q8RydHyNzrN6Dd7yZ8qFWd0Dis0VznVhStYz4qMKmEmQImmU41vJh12vbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElwsPqVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC71C4CEFB;
	Tue, 11 Nov 2025 08:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762848825;
	bh=mq9DV7BieFWsuRbESsEpgGWCX27FGZx5gSBedKe5uXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElwsPqVsB/FqDoblqz25CUuRJDKjYcR3dqnE5kNTVAIABbWmSLQCLBdYL2Lh4X9S4
	 pmnRhFZ16fP7iS7SneCan4Zecs1vNqQSDFl1BR7rXD8K6uszF4ytlMQN3d47qRxIC3
	 X7t0fvYBOM2DhvtcxDpRDMrBQyeswItQNRtmZxbs+IZOA1Wta5ywrpIJ2k0oEZM06D
	 Zly8XkI/Ztmp5kpY7gX4IrXNPgyV8Hqi4FhqtuDcM+7lpWg6gW0V4n5F46QGu+s1wC
	 9zcTwoDM4R3z03qQTvO1LAf36v5iC5Q7Oa4oXHLgCvlExyLZXqRsHYsv3Whmaxux/3
	 shkeVDBYuUIhQ==
Date: Tue, 11 Nov 2025 09:13:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: adrianhoyin.ng@altera.com
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dinguyen@kernel.org, Thinh.Nguyen@synopsys.com, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: intel: agilex5: Add USB3.1 support for
 Agilex5 SoCDK
Message-ID: <20251111-elated-sage-axolotl-e7e2dc@kuoka>
References: <cover.1762839776.git.adrianhoyin.ng@altera.com>
 <7ec6e1787a677f6614f7f991a31a9ac58b539780.1762839776.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ec6e1787a677f6614f7f991a31a9ac58b539780.1762839776.git.adrianhoyin.ng@altera.com>

On Tue, Nov 11, 2025 at 02:18:46PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> Add device tree nodes for the USB3.1 controller on the Agilex5 SoC
> and enable it on the SoCDK board. The USB3.1 block consists of a
> SoC-specific wrapper around the Synopsys DWC3 core that handles clock,
> reset, and address translation configuration.
> 
> The DWC3 core is described as a child of the wrapper to reflect the
> hardware hierarchy and comply with the DWC3 binding requirements.
> 
> This commit also disables the DWC2 USB controller node, as the daughter
> card does not support simultaneous operation of both USB controllers.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>  .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 24 +++++++++++++++++++
>  .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  9 ++++++-

DTS cannot be mixed here. You are targetting USB, so you cannot mix up
other subsystems.

Best regards,
Krzysztof


