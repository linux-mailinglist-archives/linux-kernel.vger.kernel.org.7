Return-Path: <linux-kernel+bounces-886155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BC5C34DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7DD620901
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668662FE050;
	Wed,  5 Nov 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPeFV/4f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA02FBDE6;
	Wed,  5 Nov 2025 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334812; cv=none; b=f1A/KCqjF29ZObioSoGtqOx2BTPyCtr2EF4/WENFVUcG281VI1tgdRGxcrZyD+qFXQk1mPi5pz1mxY/AgprK+F4br3Shz6ZlgVSb1VTL0HlRnQThAtC33v8+hSLmNzoJK9RdZEpIRfTX+ulh6SzDRZf2gZRNr4tMIAW5OldLifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334812; c=relaxed/simple;
	bh=yS3/spj169nqrhYgZjQmzmt4wBYRtGrvvhWVZw7mvME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMfMpGBymqVybTNRGdGqXEgIEOXmot7yaWoIDXXPb691rHILNC9XV7yAoZdwaXFyFVzDEmdMo48VA/bvkQQDrSd9mlTNBF83kCXPcSyLDen/0UDjJtrlndnfMK0FlWcN3b8cpmYGz+K4lqAyy5SSbKFTz4OT5DobCGq0RxK0bFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPeFV/4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DBCC4CEF8;
	Wed,  5 Nov 2025 09:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334812;
	bh=yS3/spj169nqrhYgZjQmzmt4wBYRtGrvvhWVZw7mvME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPeFV/4fFm0VD9F/0GCPAgoQ6gelH1dZYtsBqsd0P1AKXbEUlurYdRxPnNi2swzbv
	 rFDuK15ft8YwTuxQLjsi2pRn8RlINHfLvlzoudAoS6ufkW/3AI5vg3t30S40GugUpc
	 aCwaabz0r/+PeplsJakUrPPHikZ/zBDMnKNgeDwRNuTIBvLAxGkvPU8T6wc+gsWqHR
	 a0uzShTVdmHIuf2TxBfJyMsp+cJrhh5h+Fh8srPk+xP4628xuJKmYMYoW1781dCI4a
	 1VCe+l+LSoiYalH+T+sAyGHCop4nBVgDg5WSI4e/DXoLMW4M/LSzU1pXcCKL4d6Bac
	 pGDAProGWd95A==
Date: Wed, 5 Nov 2025 10:26:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: devicetree@vger.kernel.org, Christian Eggers <ceggers@arri.de>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Markus Heidelberg <m.heidelberg@cab.de>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: eeprom: at25: Add Anvo ANV32C81W
Message-ID: <20251105-omniscient-deer-of-glory-ddd1fe@kuoka>
References: <20251105023138.68340-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105023138.68340-1-marek.vasut@mailbox.org>

On Wed, Nov 05, 2025 at 03:31:17AM +0100, Marek Vasut wrote:
> Document the compatible for ANV32C81W 256kb Serial SPI non-volatile SRAM.
> Although it is a SRAM device, it can be accessed through EEPROM interface.
> At least until there is no proper SRAM driver support for it.

There is no user of this binding, so no need to document it. If there
is, but somehow hiding from my sight, please use the changelog part to
explain such less usually details.

Best regards,
Krzysztof


