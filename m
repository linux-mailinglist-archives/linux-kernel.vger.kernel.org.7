Return-Path: <linux-kernel+bounces-897227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B42C524E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F5A189EC07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F39335549;
	Wed, 12 Nov 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHJKEsSE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0F1A23A4;
	Wed, 12 Nov 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951563; cv=none; b=iCEhqR3oW95zcFL+brlm9PwCYVYLtysuxbHJw1d2AM+lejC8NFHEM2TeyqL6KIarsl/T0uqnmtBju339XFHpK0GsAIrS0slPMEgLDrphHu6IJjhcJIjfuYH8F9Ch7Ji7s5uhXjpMxndKL+3bgS/X7I/2G7XIyMV1S9bwTEH0yFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951563; c=relaxed/simple;
	bh=0hKH3FMrW+IWleNyZJhWbY0xEZ5GOgi9jZtxigelKJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLKeFb1Layml6yVVRFTfsNC6s+pYQxrfvvX9m76R532XHALyxKeapCBqYSfBFA+M1w70QuPKEfnBxo3Ozu7IhYX44zqP5kEEO3XrrLBqKotLkQuju5+4LPhLJd1JuRJVqDCm33VkK+X3l3Q4bF/WoeKnfqBd3/Qjl99MVHlniew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHJKEsSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270BEC16AAE;
	Wed, 12 Nov 2025 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762951562;
	bh=0hKH3FMrW+IWleNyZJhWbY0xEZ5GOgi9jZtxigelKJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHJKEsSE4E1Igzj/DDX/mJGoaWxn5zQajagApzzLIClv1ezghNgmxdXkdA4+TK7/h
	 PQqMhvPumvxAJ8kJEkuIK2En+K37MBCAOpcmCaKB1Z2LOBxP601F5nAIMQONUZdwki
	 Yz7sekrCDkXLJCE9zfPxP7BufgNw+/f1Y+X7w3aCaWtcBXKZV0omFI7n/X0SvMewQY
	 QpQDhE/5sv6vaeQlKxQoZXxLoBYvAqK2SLefgGtxmhuB/qJRbu59qOcrpJkaGxvnG9
	 +QEr8RzKm0GOpNUDaCMwOTxUIpGXf7otx/NOUQVYhsNY+aNplzypamnrcjuQoqO7V3
	 WkgZ5AMg7ca/w==
Date: Wed, 12 Nov 2025 06:46:00 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: caohang@eswincomputing.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	pinkesh.vaghela@einfochips.com, krzk+dt@kernel.org,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	p.zabel@pengutronix.de, Thinh.Nguyen@synopsys.com,
	ningyu@eswincomputing.com, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, conor+dt@kernel.org,
	linmin@eswincomputing.com
Subject: Re: [PATCH v8 1/2] dt-bindings: usb: Add ESWIN EIC7700 USB controller
Message-ID: <176295155954.1318743.2696263456910762047.robh@kernel.org>
References: <20251112055230.1609-1-caohang@eswincomputing.com>
 <20251112055321.1638-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112055321.1638-1-caohang@eswincomputing.com>


On Wed, 12 Nov 2025 13:53:21 +0800, caohang@eswincomputing.com wrote:
> From: Hang Cao <caohang@eswincomputing.com>
> 
> Add Device Tree binding documentation for the ESWIN EIC7700
> usb controller module.
> 
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> Signed-off-by: Hang Cao <caohang@eswincomputing.com>
> ---
>  .../bindings/usb/eswin,eic7700-usb.yaml       | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


