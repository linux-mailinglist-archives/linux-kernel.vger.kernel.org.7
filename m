Return-Path: <linux-kernel+bounces-880114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAFC24E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C293B6653
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA633BBDE;
	Fri, 31 Oct 2025 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhbg9TV2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F623E334;
	Fri, 31 Oct 2025 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912252; cv=none; b=ekM71rgHaobiW5bGYRW17RlrgLInVkjvhGEYOs9oHwI/ISZMfJTkoAReD1cz/UOGEQrBkACBxZkGYzGxtg8rLSX3acNr/DpYtSDzLYcKLJEWD1q35M3Z/xZWhsWUHevmjPwA0+90bb8wW2+VmGU27/JhIs8cKiJ7NufUec1kkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912252; c=relaxed/simple;
	bh=8zCjVeKpH22/iMdhS+gCJh70U5G2r7IyxZtm+8auBr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwpDvOh2leppsv1eSYZoWZkD3ys8M9Nh0ykmvdL3NjkAvK+5//pEQFMm5dSdvOjShciqC5Q6lJnxHs1LSMFB8dcOaj+xC1PiJ6reWnAbY+UuX0y1nMzf+ord7IghH+6oodPFiBPbSuqtM3XGp7lzgNNJmWMhFUO8ZUB8S6sDTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhbg9TV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D1C4CEF8;
	Fri, 31 Oct 2025 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761912252;
	bh=8zCjVeKpH22/iMdhS+gCJh70U5G2r7IyxZtm+8auBr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bhbg9TV2TDtZlqTz3eWJfEi98rZab9xTK/Cdu2UO71DdKqGrjKC4S+COdynbSZaMK
	 skG/lBDm0VpmrxiByvv7hCSfJ36F+2xc7qSewKkO2XRJA43GJOUq74UMEwFlKpYsEe
	 r3EI/by/TOLRh0P17/giNTmj5DWz6cp4G/7mFUUW+7O6z4FUE4dqmTLuUn6HWJG6Om
	 d17uRTcGH7fC+GpdvGnDvngSxMLcRsVwPO8K0PjIV++g5LWu6kMnOgyR++rTJOey1c
	 f22k0E2fnZA9XTc665jpss8tCF+95gz0a4xcMUF7terERUF/d3JgyiElsBkIyBwUXl
	 2X+xwdPRWuKGA==
Message-ID: <72e96399-e580-4545-9084-55ea26db7c4c@kernel.org>
Date: Fri, 31 Oct 2025 07:04:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: socfpga: agilex5: add support for Agilex5
 013b board
To: niravkumarlaxmidas.rabara@altera.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251031103117.910187-1-niravkumarlaxmidas.rabara@altera.com>
 <20251031103117.910187-3-niravkumarlaxmidas.rabara@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251031103117.910187-3-niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Drop the "Agilex5" for you commit header, your prefix already has
"agilex5".

On 10/31/25 05:31, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> Add device tree support for the Agilex5 SoCFPGA 013b board, a small
> form factor variant compared to other Agilex5 development kits.

Try not to repeat the commit header in the message. Anything else about 
the 013b board here?


Dinh

