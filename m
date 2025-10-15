Return-Path: <linux-kernel+bounces-853673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6FBDC486
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B23B1882D76
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610D9274B59;
	Wed, 15 Oct 2025 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFogJ5qZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B764249659;
	Wed, 15 Oct 2025 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497836; cv=none; b=u4o9ytJJP7lJlES57Tf7LVPo89wRt/w63zdtpWjGmc4L2pjDCRbgMnQn73g7qmohWPiUq/mJCZO2CnX7wFjJZugNiqnhLeKqka3UlUuIj1ql5BXJ7ZdoHGmBbMzovOmacnra/RPCFr8oA495C0VMBb18rtS/+zlbkiU0oQQedxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497836; c=relaxed/simple;
	bh=IVXAie2hnfoSOjOfbxCPUOHOua3F2V95yiRTjqgISzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AL+yfZGEII6BJVFFIpa3zF9LqDo/ZNcbaxrEpCvRldOIwQQZXwsqNQ6Z0y0w9sXdj1tymcJfpPfB9XGRxLltLZz5m0FbUB3paGR5L5L/NNbEPZsSKCiwzgtn+iOBAlHRwDto8GE8Vu8Hqsrc5nODKDfkuLsbyhNpjWpy0TgSMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFogJ5qZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7015C4CEE7;
	Wed, 15 Oct 2025 03:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760497836;
	bh=IVXAie2hnfoSOjOfbxCPUOHOua3F2V95yiRTjqgISzE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=bFogJ5qZrQ9NaLTU1XIRMptdgb0xG12UbC4Vx8E46dK3kjdFg+d1N/0e5g5SVXjXM
	 Tb6z0djG6E3zKnHS5K1JkPvZV08CGfQb15tL2qWtAUoxvhKT/ZBEs40WMZ9pz2UWUo
	 rWRehDl09WuMM05M/0Du76BhYzs9nekeoARh/C7BbBnOl1qQFItdqk3LWMipHWt+OM
	 CTi2DGoHDxnHnJlvC5qiQgjbOHheDfRwPte7Lqzd0+huJf0xwKWpsy0bH5XEph/hq3
	 rpshtaLgQi68rqzJSemkuDl20Eer2G1vYot0SlVvHZqVjfyRzESQI7Z92tpKl+9COy
	 UGdX/03OIQPng==
Message-ID: <234415f9-8d7f-46d7-8342-ae7eabb815d0@kernel.org>
Date: Tue, 14 Oct 2025 22:10:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add 4-bit SPI bus width on target devices
To: "Fong, Yan Kei" <yan.kei.fong@altera.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>
References: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/25 01:44, Fong, Yan Kei wrote:
>>> Add SPI bus width properties to correctly describe the hardware on the
>>> following devices:
>>> - Stratix10
>>> - Agilex
>>> - Agilex5
>>> - N5X
>>>
>>> Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
>>> Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
>>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
>>> ---
>>> changes in v3:
>>> 	- remove the unalign email shown in the commit message body
>>> changes in v2:
>>> 	- rewrite the commit message body to align with 80 characters.
>>> 	- add additional reviewer
>>> ---
>>
>> You have a series of v2 and v3 patches in the same thread. Which ones
>> should I look at?
> 
> Hi Dinh, you may look at v3 patches. Thank you.

Applied!

Thanks,
Dinh

