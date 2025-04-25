Return-Path: <linux-kernel+bounces-620228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00BCA9C763
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 13:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BD64E11BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3F0244670;
	Fri, 25 Apr 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Lh35U0+a"
Received: from outbound.pv.icloud.com (p-west1-cluster4-host6-snip4-8.eps.apple.com [57.103.65.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679323DEB6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580085; cv=none; b=SYffG3aKJDHTlwwjiu/zg/LxnmqEhoSH5CfYxRMsMsq/++5SQJ14TTxSmhpJTpot5X5AxMlwlkWu+sjdC9iPxrQVOZtdzH1j+eif3vo25yw64szI/ASbugyjgun8FcUiYkNtQ3Y+UthDf5tfAy1y7If63TFxYGIAOpneLloGiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580085; c=relaxed/simple;
	bh=14AoEbRStqztA4Ljceq3MLOlXVn2knuUhP5ZsZEpVuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5kwfUris+08RZYa+qiMCzbFGbA9/TcTkwoFBQMJ+QeCUFnu82WrUkT1QisLlBvBr9xvqZysOt72/AJ5XadsuVt5yo6FLF12906HsV3XzTsLH7N1xhTU8SFfAZFE6fYA279Ewr7SzV4fGW7V6z9HG48oBuihKXNgfvdbii4Mkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Lh35U0+a; arc=none smtp.client-ip=57.103.65.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=WTzGg3KDeNWnZ7BGsdPuQxd44aiGvH+K5sJokIuJ8r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=Lh35U0+amnwHTl0AEcvp49zrAHy2hWbRluciOb8G3Os84LDhiwrOPSN62n+PMPFBW
	 awgj7U6jlLWheCfluhxAoXOg010cm5QFDTwehVYoD9rdh7Vaw1vmAlRSkqkUmTehUC
	 0Wj0uaww+b/yZmSj94q/eMWeC9cSi/p1aPG6CWhHoD/J9EJ+y25mA0nd23KgTrCtQy
	 6WMUkLvvAdXRpi2rWn3hbuFfcvE+UdIjeb2sLTe3F2l/wu6fKcf41kw1Ay8LoafiE9
	 5u9uVnE6pR6Izh/MUUbbTRDr3D1nd02o/VBGMcxp21vTGZ1udEBEQNUYDLVomNi8/P
	 uIcGCg7umDP1w==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 2D70818000A5;
	Fri, 25 Apr 2025 11:21:19 +0000 (UTC)
Message-ID: <6621335c-b099-43f3-8c4e-eff7dfec57ac@icloud.com>
Date: Fri, 25 Apr 2025 19:21:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/nvidiafb: Correct const string length in
 nvidiafb_setup()
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Antonino Daplas <adaplas@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250407-fix_nvidia-v1-1-843f8d031c7d@quicinc.com>
 <87o6wky613.fsf@intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <87o6wky613.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Fs3s1X-d5AZMGskkSyGQsTMDJro4jJx1
X-Proofpoint-ORIG-GUID: Fs3s1X-d5AZMGskkSyGQsTMDJro4jJx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=708 phishscore=0
 adultscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2504250082

On 2025/4/25 16:55, Jani Nikula wrote:
>>  		} else if (!strncmp(this_opt, "noscale", 7)) {
>>  			noscale = 1;
> A further cleanup could be to replace all of the strncmp's with
> str_has_prefix(this_opt, "...") to avoid this class of errors
> altogether. It also returns the length of the prefix on match, and that
> can be used to drop more magic numbers.

very agree with your point. may use strstarts().

there are many strncmp() usages with long const string and hardcoded
string length. some usages are wrong.




