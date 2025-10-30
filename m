Return-Path: <linux-kernel+bounces-878425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43063C2090B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D026F423296
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D813D258EC3;
	Thu, 30 Oct 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EncVGbEk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B37258EE0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834087; cv=none; b=gBjSav5cmCUTTlM5X7FG/UjWWQ2IzUfdZljDKb6RhajQagKCkk2AIdWyDlpwm3rgr8xdcm9Ucl/CRoaO+fWTo6rw735Q9eSAFigPWhL1SNmhfEIpwgFvcSCNnG1rEOy6k2GU87Eh9llReL7k06+t8xvFb+8cj4gZheVFBoSNM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834087; c=relaxed/simple;
	bh=G4M6X4ukwDdtK0M3gElM3SpfrsZYB877fp7JPIwFac0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhQsIQ/7nuUpJICwtaxw1LLjDYNdpwC+LK/1B2dqLK5yR+Hkx7AXA4Yoo8soWumqvbbhLWP/XmnE8Wpd7+UGp2p1ysHhAp0/i+OBwYb3KH+QHqm7OL24OSHl8Kbfp1QD6URDZgt+NGQx21K9RrpxirbB1uL8K6H4AJkjA+vj2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EncVGbEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ECCC4CEF1;
	Thu, 30 Oct 2025 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761834086;
	bh=G4M6X4ukwDdtK0M3gElM3SpfrsZYB877fp7JPIwFac0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EncVGbEkQp4nEz26sLKz19YEkza5kL/+obnQL00M6bZAmLviFtplJihyHuPaWc7/1
	 xbHh9bYuj2ycGagq353dm2l2u9sifvEr88rRUykBDEBky9JHgvptwXXB3xLWkXps1I
	 mRU8/XHNiUKJIKcD1x4MIcKktwk2AKX7Dmbi15OCJFDq3D8KN7VprnmCRAgUSq2Fio
	 1pCjz5FaT/uXRVj6kpS0ilZlffdjgAArGcB3/aflFa16MC4yXlWmgLGiRVbv0h6o4S
	 nXVynQ/Z/QaDiOdoVaNMasxUdIazgT20cL5p9ZnPa3/ya3xd0t38WgfHY9fL/RTJl0
	 ZOhsue35I2A+g==
Date: Thu, 30 Oct 2025 14:21:21 +0000
From: Will Deacon <will@kernel.org>
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Cc: catalin.marinas@arm.com, guohanjun@huawei.com, chenl311@chinatelecom.cn,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: acpi: Fix incorrect check for default console
 message
Message-ID: <aQN0YWUYaPYWpgJM@willie-the-truck>
References: <20251027141941.3089914-1-punit.agrawal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027141941.3089914-1-punit.agrawal@oss.qualcomm.com>

On Mon, Oct 27, 2025 at 02:19:41PM +0000, Punit Agrawal wrote:
> bad3fa2fb920 ("ACPI: Suppress misleading SPCR console message when
> SPCR table is absent") mistakenly assumes acpi_parse_spcr() returning
> 0 to indicate a failure to parse SPCR and prints a message to the
> kernel logs accordingly. In reality acpi_parse_spcr() returns 0 on
> success and -ERRNO on failure.
> 
> Fix the faulty check to output the correct logging message.
> 
> Fixes: bad3fa2fb920 ("ACPI: Suppress misleading SPCR console message when SPCR table is absent")
> Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
> ---
> Hi,
> 
> After sending a patch to fix incorrect parsing of SPCR[0], I was still
> seeing inconsistent logging on arm64. The result is this nugget.
> 
> Considering the pointless churn - I wondered if it isn't better to
> drop the message? If others agree, I can send a patch (and revert
> bad3fa2fb920 while at it).

I'd be happy dropping the message as it looks pretty useless to me,
especially given that the current logic is broken.

Will

