Return-Path: <linux-kernel+bounces-736250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5C9B09A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A842D565003
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30871CD1E4;
	Fri, 18 Jul 2025 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnJdt8bB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518310942
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752812268; cv=none; b=EcUFeHX+cTzEIGz2F0HbE7k/fM2zT1XawPACfsutkydvWm0+YENzsKhb965TL9cHCf+nxfU9b2+gk0b6baZFZmLgROAT8TyTIcL81IVa7K/FpB4hh7twhdU9FoqeaXELDyoZMxYz8gKwyu+hFfcO+L6T8Tzz/vLV3M4ukdNz1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752812268; c=relaxed/simple;
	bh=LOklqSzGHoQD0d7uT40vyIYyMJHO3OMdOsB29FK9GbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ow0jjpZFhIbuF4Ufg7M/iqKwUF2FI5MFdCqa0k1whJ3nqspFM+DCRGteU6HrT2Qb0vlzvEpTMD9/UUOWccHEWyTFvPlfdNiiyYapr5zfIVkZN2ccOT6vL6U83F8+PoSHkk/XvwZgvOAO1ypur9hPmRUp2abNRnSqBmGc0rsry14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnJdt8bB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD53C4CEED;
	Fri, 18 Jul 2025 04:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752812267;
	bh=LOklqSzGHoQD0d7uT40vyIYyMJHO3OMdOsB29FK9GbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lnJdt8bBIYjq0rWnPqDQzRXiXVd40nRloAeNETT83Tm7l4WS3RaFOtPhVv7ra4xOa
	 B/tNKa69+dvAGsT5ves1g2w2qU7QGP3b4vA4SbNBr4JMLkhSQzYjXTsdNwCsn1Qjl7
	 W+YHTyTVTaBelUMyiFkKYWYPE2mQ3RNyTkVPo/hKNjUBvoPmmKjORYB+1qnP2Ol6nJ
	 Mg7S9pBeGzqEPyg0fHQpz2JS/beMSeJarN75mQo/oqPTGY6TLhHHWeYdwlipWX1JN7
	 2wq6cwubagcA2FRr4Xas++IFqtQw+XDkhjt1+/wpD76D1b2LHgcZIdYm2RBkOiK0xU
	 Fz1Uh/UA4U8cg==
Message-ID: <f80ffee3-60aa-46d6-bd1c-7240ad171ee4@kernel.org>
Date: Fri, 18 Jul 2025 13:17:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-3-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250718001415.3774178-3-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/07/18 9:14, Kamaljit Singh wrote:
> Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
> log. LID 2 is optional for admin controllers to support.
> 
> In the future when support for LID=0 (supported log pages) is added,
> GLP accesses can be made smarter by basing such calls on response
> from LID=0 reads.
> 
> Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

