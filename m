Return-Path: <linux-kernel+bounces-884690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3852C30CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18D1188E0F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882A2EA17D;
	Tue,  4 Nov 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGVWbZMR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DEA2DECCB;
	Tue,  4 Nov 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256505; cv=none; b=A9rRBmgR+upZ6PLShv9A071bcaA3EnSE/DepM25E+6GO70smzDbKQTXDlKmPRECt1WyyHxl1TTSZjpEKZ6gYlXVPZZwm0qBL1fJbhc3iiBmK51IdEr4J7AMrpz+dbhu6wGg41UltWPYErD8yzHrwvbhkM5qa4RU+c4MAlVMBGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256505; c=relaxed/simple;
	bh=44m6mwml3Tdv2Z1Hfg8uDRMA/9cnRllsm0wLpVSTekU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NigO9fi69K9UKveHRd630fV7inburOcdawy/IUArvdkjzlBwG+gX0Gr45IyCtqhHiawCinhcajF38PDpFc+DaC8qWWyHwtUgRzAd4lcWn7SJIntAMXNN63rfLaPbOUbtniTQnDnM6ILb7bkmDn2AlROiymfC1WUFxbz10foDkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGVWbZMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD3BC116D0;
	Tue,  4 Nov 2025 11:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762256504;
	bh=44m6mwml3Tdv2Z1Hfg8uDRMA/9cnRllsm0wLpVSTekU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGVWbZMRVhKbxMB6G4ldOVIKdQb+xvgfMlgVNNTICSgYT6/kevGWUxUSc3Hwd7TrZ
	 ou83Ft1s5ib/sbgWaUal7Y5+lCV226SKo214TprAe/bONqHIbXDLMyIi4QsD03Joem
	 mgBX1+TwX8/KZM+M/gsXW672CCjMVY/G05gSk86Vs51Zd8HED4VZ8ypgD6TO0NCGK0
	 q3C325AGFru5HEkJCIks1lYsJ9WVr7ufYmEv3o92hZlgElhKgfCaAwDat5CCvmQP3v
	 2g4R6CAI6jFOwhY9m8QdluWLUcT8BLX3wnzTVpgWZE0YQfbtBr7uYlDDXzzW1j+y6H
	 HJkfhnzai1/cg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vGFQ4-000000007mh-0SGd;
	Tue, 04 Nov 2025 12:41:48 +0100
Date: Tue, 4 Nov 2025 12:41:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: greybus-dev@lists.linaro.org, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Mark Greer <mgreer@animalcreek.com>,
	Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] greybus: es2: Use pointer from memcpy() call for
 assignment in output_async()
Message-ID: <aQnmfCKoB3FJ5Jz8@hovoldconsulting.com>
References: <b542b028-4f9b-44cd-aca7-5d4977c2faa4@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b542b028-4f9b-44cd-aca7-5d4977c2faa4@web.de>

On Fri, Oct 31, 2025 at 07:57:47PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 31 Oct 2025 19:50:39 +0100
> 
> A pointer was assigned to a variable. The same pointer was used for
> the destination parameter of a memcpy() call.
> This function is documented in the way that the same value is returned.
> Thus convert two separate statements into a direct variable assignment for
> the return value from a memory copy action.

Markus, stop sending these kind of crap patches that just wastes other
people's time. You've had a number of maintainers reviewing the latest
batch (including patches which apparently does not even compile) all
telling you the same thing.

> The source code was transformed by using the Coccinelle software.

Since you know how to work with Coccinelle, at least try to come up with
something that fixes actual bugs.

Johan

