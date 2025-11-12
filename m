Return-Path: <linux-kernel+bounces-897972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A4C540E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 627404E5F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936AF34B1B6;
	Wed, 12 Nov 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlCqCvFn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BC2D662F;
	Wed, 12 Nov 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973991; cv=none; b=g/v5irYgaNrhXQ758UbiI17YFPNFeBCWxJ3ZMASi9H7S7EdlYzr0Q4/LUnS2k/2770anwSNulG78rf2DcTuqYnWvhCspG8lVM+WBQw5uErRjw2i4/gDLHgvLxjMOlt25b9sOaz7cv7YX+vaHv8qw0mNRb8quRIHtHpyIYMNroUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973991; c=relaxed/simple;
	bh=s70+dEijLJu02bLEgTDFzYjbtJ3yISumbYjuEFikp1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U3YX4POKtEA12IPEwkgBCuEtjf2KdoMGubRvsTPfZJszPsZnTwivrIrgiCs/Nb8Fy9uGHOsIHGF/arTpsErF4n8NvZXzo2/xHbAJKztLEl5Qge6TaWeOM6CFMGblUARHmsGR3jKVv12/GwWlntGb+CoyEG/KAXXpVR5pZOx1RDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlCqCvFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DE8C113D0;
	Wed, 12 Nov 2025 18:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762973990;
	bh=s70+dEijLJu02bLEgTDFzYjbtJ3yISumbYjuEFikp1U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NlCqCvFnIdpo3ZYt44/2IUvfqAcmNstFQ0sVeXIZqhGd1ELQQmaorLAK20SiRWebw
	 njk2wPLnJ9AyjVxan6FZDaqDkYh9bt9Ob+ziA37Po8j+gg7xXqANp1y0MFvCa7eYZ+
	 JSeVY3NV4lXuWCIj6I9b2hQrXMela9M5J85Eio5yG9WTIva8IP43/pcC/1dODyuJcy
	 rBkY7UbhoFR55dtiYcQJc1noG/i4mZk63EtC/bKPUTOsDKM9H5AQ4P3w2AvPVw1oAA
	 9Uvou1fmuqLPva/ATG8I2yboLfGKKF7MZWQ3jB8TNTtYERti95otrJ9QcB8TL3JIpc
	 mwtiH2RxgZrJg==
Message-ID: <81ad7e01-d826-4dbc-a029-fdfdd06f6a88@kernel.org>
Date: Wed, 12 Nov 2025 12:59:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: intel: agilex5: Add Altera compatible
 for I3C controllers
To: adrianhoyin.ng@altera.com, alexandre.belloni@bootlin.com,
 Frank.Li@nxp.com, wsa+renesas@sang-engineering.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-i3c@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1762237922.git.adrianhoyin.ng@altera.com>
 <ac9eb45581525f1f3aaffa46a73927038ea8a9ae.1762237922.git.adrianhoyin.ng@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <ac9eb45581525f1f3aaffa46a73927038ea8a9ae.1762237922.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/4/25 01:29, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> 
> Add the "altr,agilex5-dw-i3c-master" compatible string to the
> I3C controller nodes on the Agilex5 SoCFPGA platform.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 04e99cd7e74b..5c8ad5e9b248 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi

Applied!



