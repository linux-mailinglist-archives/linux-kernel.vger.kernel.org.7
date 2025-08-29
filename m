Return-Path: <linux-kernel+bounces-791569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A0B3B8A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD913BE0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D5304BCC;
	Fri, 29 Aug 2025 10:25:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB6D1DF256;
	Fri, 29 Aug 2025 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756463133; cv=none; b=Ga0z60xFN3edA54PmH0Rx+LJBn3V40GXR3bHpR0mWhyiw5/MGiWT02OzeXbxblVvFZchFvti/2XCyuZyBOYjjQ0Tc8V5u0zCNuZHiw+prCZtYHJOoJncmDrpZN0xfKyy7/VG8hBJyQtldJ4Cu2Iz6ct0FTmltrFT51nk+O8My2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756463133; c=relaxed/simple;
	bh=L8TiorYeRoXZrrE4r2L0C1azo6MqKn0HazpwuYin8PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmrp/4bAkc8wHz6IL9bgsb/kC2sPqW4zBKq1exPxfCjBbf+Q6Pk6MpphGhkUVnYTDlnI0R7zxFmGbdx5sqhOuSBc+2z1vxa1O1ouJlmv57vKku4UeXkTVUbW06SiWnvNw3thExATuIrStQjY1hFTB7N3IYFdGq4AInjsUfxA4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 593591758;
	Fri, 29 Aug 2025 03:25:23 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 387663F694;
	Fri, 29 Aug 2025 03:25:30 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:25:27 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: scmi: Use int type to store negative error
 codes
Message-ID: <20250829-marvellous-iguana-of-weather-4ab064@sudeepholla>
References: <20250829101411.625214-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829101411.625214-1-rongqianfeng@vivo.com>

On Fri, Aug 29, 2025 at 06:14:11PM +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from u32 to int to store negative error codes or
> zero returned by of_property_read_u32().
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly as pants. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> No effect on runtime.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Mark,

Not sure if it is worth adding:

Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")

Especially if value > 0 is not treated as error in some driver using
regulator APIs.

-- 
Regards,
Sudeep

