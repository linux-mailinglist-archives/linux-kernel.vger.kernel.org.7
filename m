Return-Path: <linux-kernel+bounces-894621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C6C4B6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 311074F2E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E034BA31;
	Tue, 11 Nov 2025 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5OTgzid"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6A22068A;
	Tue, 11 Nov 2025 04:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762834026; cv=none; b=fMkskcyGH671hBwLd47in4EfKYCt7KitnIy7PWyzOY5XwU57Nq+K4c3hv2pVwnKjYoTF6398D+Xv22DEpgD3TAV/oiNkUmoP68ACYoKqUL8vfYod8neIluOqleajXweCgOqojhnFEpwnLWSty55p+jctoPiRqZv4vVLGkfyH5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762834026; c=relaxed/simple;
	bh=yepJq6pBbrUIaDa5jOa7m8LzHkVWiuNbxbYKVprKyWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js1GmMtogBZXXOjbjTKPwCjSuPtpYGeoyJa4WCA+f8pjrd8Jtr8Mjccs0ZxAcBd2XmhycmJ7lSK7A4BJD38QrHS+kd0sHpvqUatEQg68Jn7LxZc+21kaZOdhNnQSlIk0N7PgOKhvgk5WT0XCwOsDueuouSH491dY8Jhuiy8oEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5OTgzid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABE6C113D0;
	Tue, 11 Nov 2025 04:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762834023;
	bh=yepJq6pBbrUIaDa5jOa7m8LzHkVWiuNbxbYKVprKyWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5OTgzidqKa4ZfUhv8MoGc9Fk3nNg7JtVejpgTrCv5HjZzu1hy/JHSwck58WAvDq+
	 iS3zpyKymCID7S+G2ilTFrdJuDUubu1a/MCKvZu+7uOVpjc7lFY6XvPE8gi/6EB+/+
	 owFxLXCpw6tP5qChZkl998+D73NMsy8eikVGpnk4fI7kAhSKbYQMfmtHckEbQflZRA
	 ymXk9l/tzcCv9tKz37T2eQjnvPHvyB8l7wXh2Z8c86pO5jrrpmFwWzj5BCgLaI9Njk
	 VZDYA5A+LpRSoJcBWWeWPqBDouQ5B1GV5/dUYshn4CSRuOb8j44pqpYcznWdItZn+P
	 7WRDqSTWOas5g==
Date: Mon, 10 Nov 2025 22:11:12 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ettore Chimenti <ettore.chimenti@linaro.org>, Srinivas Kandagatla <srini@kernel.org>, 
	stefan.schmidt@linaro.org, wse@tuxedocomputers.com, cs@tuxedo.de
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add device tree for TUXEDO
 Elite 14 Gen1
Message-ID: <r76wptwknylaxlkwmdkd4pinrzufnjiujrutj2q32lgt75x7ti@zibmax5uhwp5>
References: <20251105154107.148187-1-ggo@tuxedocomputers.com>
 <20251105154107.148187-7-ggo@tuxedocomputers.com>
 <aRHre28Nbyv6ShbU@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHre28Nbyv6ShbU@linaro.org>

On Mon, Nov 10, 2025 at 02:41:15PM +0100, Stephan Gerhold wrote:
> On Wed, Nov 05, 2025 at 04:41:06PM +0100, Georg Gottleuber wrote:
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
[..]
> > +x1e80100-tuxedo-elite-14-gen1-el2-dtbs	:=  x1e80100-tuxedo-elite-14-gen1.dtb x1-el2.dtbo
> > +dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-tuxedo-elite-14-gen1.dtb
> 
> Please also add x1e80100-tuxedo-elite-14-gen1-el2.dtb here (similar to
> the other lines), so that the EL2/KVM-specific DTB is automatically
> built and included in the installed DTBs.
> 

Please confirm that this works before adding it.

Regards,
Bjorn

