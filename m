Return-Path: <linux-kernel+bounces-806550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D47B49850
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3B1B26AA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC484314B6E;
	Mon,  8 Sep 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="xtdIxK5w"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21AC17A31C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356276; cv=none; b=Njkv5UoDYlyXQPlX8MAiqBg9sn5rU1dGQuB7VgkuZpQdO/w5GN2oFARrd/U8Pqe+pdRE3zuyPRvjw5Y3qs0+1R3RPygL9hKYrnT/6LZaB0M6RV+tXv56A9etOhHDutGUikqLkO5wofhW0TkVplJSwRszvCRf/TamootLw3T5sSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356276; c=relaxed/simple;
	bh=wX9+IS0vJCWpzgflmJfrK2PcQPvegoFGe02wuEOQJSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBHqpk4mjCMLDx1rvIr5gJpbAZvBgV3/gz9y7oys2y4KKA5KElIzGKCPcR4RES4kTZVSAyUVGU3nJtL4XSGgjf2v7BRBmGVMlPz6NRO1uIFju48EjEBQmkUO6fXAzIJS5V5bjEOMoaKVWN3iNe3a4NdNph6cWjfczSuS3EO3WfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=xtdIxK5w; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id vcPbuhqTGjzfwvgdwu1B5X; Mon, 08 Sep 2025 18:31:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id vgdvu0iPJWIZzvgdvuxbr6; Mon, 08 Sep 2025 18:31:07 +0000
X-Authority-Analysis: v=2.4 cv=M7JNKzws c=1 sm=1 tr=0 ts=68bf20eb
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=3MMl4rzW2iVmjiC4vQKzZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=DahiFt0k3YZEWpF1MlMA:9 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SYa6hIJu3DY3TfnACEOnPdfbIxpdF/KfJFBTzkY9dx8=; b=xtdIxK5wsVqVSyqv6rAfYyyZ5v
	tHcMo9tds+hMG5WI2blz/uL2oX1M6sb0tfnn0TOUeZmlb6KUAuc5FsNE3L8Mk+0beC87Dr5Y00amO
	JIqruWo5s3dHw4Yep5g6K7FE3biTCW65VQIOpRcvFt21yqP9Wom+DrsOExDjziN+gItNVF2gX5WhU
	laH0LXoigohmw8h/T9VLpIEMz23GBzp36rMzTbDoGch+fQM7DJzhmMLAlX0tiDDigQGDwXi52ghWF
	79bNQOYkmvYFM6uipNgUhT+pDdIMeuGyAeLgfRxapBjiYgiCkYE3hsrjXCAdByOf7ajcmAMIGMffh
	jxKueYDg==;
Received: from 250-136.dsl.iskon.hr ([89.164.250.136]:49258 helo=[172.30.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uvgdu-00000001s8F-1vKZ;
	Mon, 08 Sep 2025 13:31:06 -0500
Message-ID: <bcbbdc13-9b04-45b3-a1fc-20a4bf589850@embeddedor.com>
Date: Mon, 8 Sep 2025 20:30:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] scsi: pm80xx: Avoid
 -Wflex-array-member-not-at-end warnings
To: John Garry <john.g.garry@oracle.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aLmoE8CznVPres5r@kspp>
 <47624b76-3b19-4805-b48a-040e943c7f2a@oracle.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <47624b76-3b19-4805-b48a-040e943c7f2a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 89.164.250.136
X-Source-L: No
X-Exim-ID: 1uvgdu-00000001s8F-1vKZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 250-136.dsl.iskon.hr ([172.30.86.44]) [89.164.250.136]:49258
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP3m703l3v38jZ67WQv7xM5qZiyrbnfMb6tPv0d6abeSVZujqnccWbPCc4vNYZy/Ej5yc/j6bAwSamtzdj3SFEulO6AttT5NLKeHAgTAFOyCltzjwV4b
 broqDjSbvX9undhegS6L6fUrYT12qhrMO/bN2SY9pKCiYonOiTpmhemEmK5lf+ogi/WGvSiKRnyhs4TNs7hbH/y/mFN9yX4d22EKbFGXFWFrejmG5tbSLChx



On 9/5/25 09:05, John Garry wrote:
> On 04/09/2025 15:54, Gustavo A. R. Silva wrote:
>> Remove unused field residual_count in a couple of structures,
>> and with this, fix the following -Wflex-array-member-not-at-end
>> warnings:
>>
>> drivers/scsi/pm8001/pm8001_hwi.h:342:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member- 
>> not-at-end]
>> drivers/scsi/pm8001/pm80xx_hwi.h:561:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member- 
>> not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Personally I think that it would be better to comment-out the residual_count member, so that future developers can know about this field and why it is not there.

I agree. I'll send v3.

> 
> Anyway,
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks!
-Gustavo


