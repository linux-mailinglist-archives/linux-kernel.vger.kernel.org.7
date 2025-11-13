Return-Path: <linux-kernel+bounces-899672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C761C58A60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B8C4A2EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37BB2FC890;
	Thu, 13 Nov 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnJecusn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BB26C384
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048107; cv=none; b=l6I4rfDc5GvmM2xEjDoL2rDhJdnUuS7JMgC2c+bcbEEqKQCDON2GPdVfKgfUgcawvcJxvH7vlHkfFQERgB18teuS4rb3ukmNaXHCzU2cjK+AGqIgnHuijfA+uaIg8qQSWD6k1eNfUol8F08xq46awG2ILj0e1xMe8OpU0+1yU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048107; c=relaxed/simple;
	bh=D8WvGXX9KYt11CApC01Q8d5gtw7/8hiqu4Qp5u8lf8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zy23KSgUiE0ftb5LThodKPHwrEmpAde93cVeZ34COZmMkPzyMyy+jvQXLGbum1ckuSSty7Ju36BsUZi/1gCG0vuNU/nggHU/Y2rj6TO5ewvEcHqSTlPu4I02T6CBKYALDFjtYfwG/fvg8VqGSbF2pScD6aIk67xPIgdAXBg6KpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnJecusn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD89C116D0;
	Thu, 13 Nov 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763048106;
	bh=D8WvGXX9KYt11CApC01Q8d5gtw7/8hiqu4Qp5u8lf8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZnJecusnHwdqsuJ9fbtwY58AijXmd8yBp2s3PG7GblTLfdAVe0BzB+hDsCeDhQxYM
	 Q6yPcbFWMbPTp5DYk6rFubx4vveHj8UFpn/BNA+ukh7ZCo1CIY/fFN7O9la+spfyl7
	 P5HrVepyV7con/tRe03jqW0qXxGI2dREqYJZVBfefH4pyhT0hDvwRoE/m3n6nyiYQx
	 B8BKt9bU5Fr18+yKOcRD2bGDsxs6YLzGfL6WqheSjoIb4U4k5v9IbDLpZNMT+2vBGn
	 QDck2fOXy+RYPESEGKClI2QzpvAYAFueHEPUcR4CWisMdNnjFQE1B4eMbTaVGVb/a1
	 ma7sxp2ysUfbQ==
Message-ID: <73552a22-c7c8-4106-949e-471b9a7bbc87@kernel.org>
Date: Thu, 13 Nov 2025 16:35:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: Remove CONFIG_CMA_SYSFS option
To: Jean Delvare <jdelvare@suse.de>, linux-mm@kvack.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251113145636.731a24e4@endymion>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251113145636.731a24e4@endymion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.25 14:56, Jean Delvare wrote:
> The sysfs interface to CMA has a marginal runtime cost and a small
> footprint, there's no reason not to include it in all kernels where
> the dependencies are satisfied.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
> As discussed with David:
>    https://lkml.org/lkml/2025/8/6/371

Thanks for the reminder, it sounded familiar but I couldn't remember 
when this was discussed.

Hoping this was properly compile-tested :)

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>


-- 
Cheers

David

