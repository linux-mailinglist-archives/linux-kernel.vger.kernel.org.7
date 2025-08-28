Return-Path: <linux-kernel+bounces-790235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77EDB3A315
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A67179BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E80314B80;
	Thu, 28 Aug 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SiieUIGg"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D46314A85;
	Thu, 28 Aug 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392908; cv=none; b=JB+TM5lNgM5dQ7z2G2sASRhTgiwFL0vsJF67qngHFK/eoHGlyAcdvb9Ung6VLCUmwCY0EB24MhLzSyArG6/Z+aayAV4qVHbBxxS4BDAp4k0NLn1+og5wACgl9It18zMUjI42tGmkMd31qLYNcH56oFegc6gbTroHd2q1AGOM9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392908; c=relaxed/simple;
	bh=BPkdl9j9D1N90XZ6qmK5CEv9tLIbbm/tl8OiHdkyUhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFLhoTCs/N6W5akc7z/sWMWfr7+TOaaMQpPmUtQFRcirUVGCTaVgsB3kVHPhclu88qVa6zphoPUOUTg1pcBOKP3iijIK2ROUjmkGAtrOyI1dfgbRgBt6NaN/M0t+WfzdDTB1ZYmts8uU00u90KY4frYXdNKoCoKzZDecqjcsn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SiieUIGg; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f215be4c-b157-4b31-a6f2-ecf5017eb32a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756392892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwasJTl+J8ScGiEt5lcNBkxwdcyLk9n6hR9skE1FDLI=;
	b=SiieUIGgwMXLiI/LnmPyzMZWrDZae7TeoTvJEZgrh7ylpcsKDeSmNApxqppY2E7pMzT5J3
	HkP0WgQAhbvRChTA92lHshX5yaybJ1jSFa01W2xnC0pisZtbw4EkEhTuhPexPsl+9aoh8A
	4UaTxyyTvJhXwHHQINcraY8otU9qt/c=
Date: Thu, 28 Aug 2025 15:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v02 07/14] hinic3: Queue pair endianness
 improvements
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756378721.git.zhuyikai1@h-partners.com>
 <c612c77032db14657b9622c342ab7cc208c4b4d8.1756378721.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <c612c77032db14657b9622c342ab7cc208c4b4d8.1756378721.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 13:10, Fan Gong wrote:
> Explicitly use little-endian & big-endian to enhance code readability.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

