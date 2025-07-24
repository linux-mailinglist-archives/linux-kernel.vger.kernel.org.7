Return-Path: <linux-kernel+bounces-743712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1DFB1023F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E7E5A08F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6149726D4D9;
	Thu, 24 Jul 2025 07:49:17 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506DB1C6FF5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343357; cv=none; b=IzZg0IuLlsrOK0X/g519T453ZY9my9eg9DAnB1T8DeSlYVYNS9NSbyNqr01KpqHhYOU61dacrM0gG6zGT/2JULrPmpiluvA/ERtljneSvzxCsDhio1Mg+96gNeUjFbZQEtfXt2CuJf1upX6y810nVrykcKhj2Idk0vRMbvjAsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343357; c=relaxed/simple;
	bh=jcjaQYTMTRrx+WghJX3jlueR/iLAJpHiv6lfByqp1NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ezq3chUUw5NdUelDUh6nqHUKtptCPmW1L8xtmzYQjaFRPW9iKzeqUmPm6gunCAjgBM9WxV9ikEhpaFAz/l0Cgm8d0VL+ujviinqZLgJ3jVKtmzwB+8AzettiHvW78G3crHtr9/quyvQhdRNIyDhw2rmcURgyRMX9Ytgdm5W9XYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1753342245-1eb14e1c3a854d0001-xx1T2L
Received: from ZXBJMBX03.zhaoxin.com (ZXBJMBX03.zhaoxin.com [10.29.252.7]) by mx2.zhaoxin.com with ESMTP id CZNMqECXxPG4FN1y (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 24 Jul 2025 15:30:45 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 24 Jul
 2025 15:30:44 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f]) by
 ZXSHMBX1.zhaoxin.com ([fe80::cd37:5202:5b71:926f%7]) with mapi id
 15.01.2507.044; Thu, 24 Jul 2025 15:30:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 24 Jul
 2025 15:30:06 +0800
Message-ID: <67fdd776-4329-04d8-6b4f-b5f11ee2105f@zhaoxin.com>
Date: Thu, 24 Jul 2025 23:30:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] usb:xhci:Fix slot_id resource race conflict
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] usb:xhci:Fix slot_id resource race conflict
To: Greg KH <gregkh@linuxfoundation.org>
CC: <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <WeitaoWang@zhaoxin.com>, <wwt8723@163.com>,
	<CobeChen@zhaoxin.com>
References: <20250724124012.296934-1-WeitaoWang-oc@zhaoxin.com>
 <2025072457-quaking-each-ea25@gregkh>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <2025072457-quaking-each-ea25@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 7/24/2025 3:30:42 PM
X-Barracuda-Connect: ZXBJMBX03.zhaoxin.com[10.29.252.7]
X-Barracuda-Start-Time: 1753342245
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1428
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.144739
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

On 2025/7/24 14:35, Greg KH wrote:
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>    older released kernel, yet you do not have a cc: stable line in the
>    signed-off-by area at all, which means that the patch will not be
>    applied to any older kernel releases.  To properly fix this, please
>    follow the documented rules in the
>    Documentation/process/stable-kernel-rules.rst file for how to resolve
>    this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers. 
OK, I'll cc to stable line on the next patch version.

Best Regards,
weitao

> thanks,
> 
> greg k-h's patch email bot
> .

