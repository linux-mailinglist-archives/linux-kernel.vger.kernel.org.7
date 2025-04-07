Return-Path: <linux-kernel+bounces-591650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46328A7E31B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 17:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01F616DDB7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E7D1F4E30;
	Mon,  7 Apr 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xzMy6iR2"
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2471F419D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037648; cv=none; b=F9nrLRAySfv0PaFvJtXpVlmFZ0JGmCRjoLVS0T47QWGnWPvQCyTg9qTx9hKgPKq1ixnO2wHanAa2lXqtctv/hEpvWoeeRBs0ilGQj7/uTceAPV5+U7webV0fQ9mWdiXpwB+hGaB78vvpFQqsuuDnzqlnBp0+18OUbrKZeWtkWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037648; c=relaxed/simple;
	bh=QAesDj3v6u3ehenwoAk9hWCfcO8KmBnO5zo1Q3bIMTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcCvOFKRCBCC69y33kGAKVkGhCiE92Ke1cZ4QWUy2tPsqMVOH8ZQ5QttToWUkknZi+U0xn/zjxaPLblmiA83em9k38Egrss+rU/JevvXQe5WzR10z9I7saJMvNqdk+vNDahQ87GtNFgVNKk6tYXjzvCu8ItCoJjHGHKATEwWhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xzMy6iR2; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=QAesDj3v6u3ehenwoAk9hWCfcO8KmBnO5zo1Q3bIMTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=xzMy6iR2tD8igtfsxMQcaeAXMLF4IDNY3G92y+FGCA8IUa45JILxxB6Lo8XvDuGpE
	 neER+E0PSnEwDWnW6qEI8j6LDZSv0ie+qVLSaLcDjgX6Uz4AFXPR9rMJs7dAD+xiFH
	 3onYMNfWWwWcT5IFZ1fvNbquiupWYaF4HBfW4+lPkMbKuO9kcdCALkmYhOGFAKHnj7
	 lhFnwCZwKsmfRXwiZQah3Yw1lGEsb3cXyt85TlRngr4oifyZW8jDEPLJAjthuAzQSv
	 XtqVTJTkMQ49SHx5NR9oRLpQVcZDqQ8eZomUzVgUfH+IikDaYmIKKhUHUmbHvX4j6p
	 M2xCLfv/u6zQQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 7F56B8E0512;
	Mon,  7 Apr 2025 14:54:02 +0000 (UTC)
Message-ID: <1bdaad61-5267-4cba-bd6b-373d0fee57f4@icloud.com>
Date: Mon, 7 Apr 2025 22:53:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/string: Improve strstarts() performance
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, "Rob Herring (Arm)" <robh@kernel.org>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
 <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
 <Z_PYdARMy0_iW4wD@smile.fi.intel.com>
 <0e603b02-b272-4bcc-8b86-1a3dca9477d7@icloud.com>
 <Z_PjksaIc0B2AQhs@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z_PjksaIc0B2AQhs@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: u6PUHjcpmtzM8hmBFZLN8BYDdB-XFIXK
X-Proofpoint-GUID: u6PUHjcpmtzM8hmBFZLN8BYDdB-XFIXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=441 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070104

On 2025/4/7 22:39, Andy Shevchenko wrote:
>> for strstarts(s, "prefix"), strlen("prefix") should *NOT* be compile
>> time constant. it is a loop and unavoidable to have strlen("prefix")
>> iterations.
> What do you mean by that? Compiler uses __builtin_strlen() and it *IS*
> a compile-time constant. Just check it.

thank you Andy for this hints. let me do more investigation about
strlen() within strstarts(s, "prefix").


