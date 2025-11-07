Return-Path: <linux-kernel+bounces-889834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54770C3EA3A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E8D188A499
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EEB2FC037;
	Fri,  7 Nov 2025 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zYuAKSnc"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B262FBDFE;
	Fri,  7 Nov 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497718; cv=none; b=uaFA+5ep2QoM5pa4Cd4cFO/46Kzy+m3Nbd3n/mEB0VNGawTX9B7EmdYRp3H8mhr8Reu9zhtqGTBHqS8XSP+BP4aY/OwCbQy7jZ4wwj+6cVOT2iFGFdPnxc2ZZByaqMeFs+dDvLHzRIQbZAaZgApC7F0Iq9Oay74w219uzRZQRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497718; c=relaxed/simple;
	bh=xMkU6lise77F07+L4SSLLGnVhJlaos8b4vhOhX4fGXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgrFrAKN2r5LzAert4vT2w+mTVjK9Gt9Du2kErW3CHCsM9Eg1xREtEzntz40cewOdZNHI9a0SeR0ESoXlRm19bYNXnmy73apzH5zcJnmZLebsxe17Ib6xYpkavwCIKNBQ1EBaSG0HIHG8bS136nc5l24NY9q/Ti+lPFfSzUaf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zYuAKSnc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ctUBfFMWOMihIJ5Bxg5QZ83jQAfvmlzaJtuMNo0vOjE=; b=zYuAKSncUam05tJjY1i3KtR5n7
	DQSfea0nuf0pV2owXbxYjV4VIRlNnrO+AfPO/GvdvtfGtQRmVaPfa/Aiz/E+RHWG7RreH3j+bkxJ2
	dqqRxBP4FS+ygOfcv02VApaICUB9w9a1VGCsXFCfm3VZnflccVAYCkbgYiZGKATcCaHygeQOVzAOb
	efkdjj0bhDbrq3BelURquGSaU6iHiAdAcvkarbuWduhx6xGGlds4bvsfczX5XMUJRF4SFnAm+abcf
	5puHOUDHL6cKMoCO4I6oHKv0iT8SRyMcrkVZtLqvwE8AR54zyk3uQCOJl9XPlvz/nXyDhF3oF0To7
	nZ+cBLdA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHGAV-0000000GkQ1-0Jpo;
	Fri, 07 Nov 2025 06:41:55 +0000
Message-ID: <bdc3c01b-193b-467b-9534-cb94f198aa01@infradead.org>
Date: Thu, 6 Nov 2025 22:41:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] misc devices formatting devices
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Akshay Gupta <akshay.gupta@amd.com>, Srujana Challa <schalla@marvell.com>,
 Vamsi Attunuru <vattunuru@marvell.com>, Julien Panis <jpanis@baylibre.com>
References: <20251104041812.31402-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251104041812.31402-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 8:18 PM, Bagas Sanjaya wrote:
> Hi,
> 
> Here is a small docs formatting cleanup for assorted miscellaneous devices.
> Patches [2-3/3] are split from my previous macro references fixup patch [1].
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-doc/20251104022242.19224-1-bagasdotme@gmail.com/
> 
> Bagas Sanjaya (3):
>   Documentation: amd-sbi: Wrap miscdevice listing snippet in literal
>     code block
>   Documentation: mrvl-cn10k-dpi: Fix macro cross-reference syntax
>   Documentation: tps6594-pfsm: Fix macro cross-reference syntax

for all 3 patches:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

>  Documentation/misc-devices/amd-sbi.rst        |  6 ++++--
>  Documentation/misc-devices/mrvl_cn10k_dpi.rst |  4 ++--
>  Documentation/misc-devices/tps6594-pfsm.rst   | 12 ++++++------
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f

-- 
~Randy

