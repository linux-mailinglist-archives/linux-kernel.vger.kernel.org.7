Return-Path: <linux-kernel+bounces-728691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8314BB02BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B69AA46084
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8589A28A1DF;
	Sat, 12 Jul 2025 16:27:44 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53C289817;
	Sat, 12 Jul 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752337664; cv=none; b=SOCGlZ42FBi5eJUMS6tj/kc19t0k6bS3XCYXqooi4VawBTeFxE2iDY1xogwz+uE6GDOX9mnAbwzcHZPWkzI84k3bQPGF4aZWhuduBbfXF/OzeZ+x+iC2fKQ5k1LsNd1zN498E3cmEsiYaOHxR3Cw2PASm+06ESEQMcyBMqX/qmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752337664; c=relaxed/simple;
	bh=Nnt37dI/JlltrwT6kQWCW24E3SAEtajEsHbqJYoUqGc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=skumNPnyr79JCPwJSfleUzR3tsqshkrGhClI1WsXVoD0pKmk20QBlZd1XLc9NNpSGPay7+9Tqu0YLNgPwwFyMECNmeY2GKk6XZyBPv++yKL2ZPqxyv3mGiOWs3fk2DV/QMXcbGHGw9dHxgVKAki2ny0xpmtQaBgZjE1u1JJVjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bfYhZ0XSVzKjY;
	Sun, 13 Jul 2025 00:20:14 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4bfYhT06xRz4xBTt;
	Sun, 13 Jul 2025 00:20:09 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bfYhH6ddwz5F2ln;
	Sun, 13 Jul 2025 00:19:59 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 56CGJcFu086543;
	Sun, 13 Jul 2025 00:19:38 +0800 (+08)
	(envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid14;
	Sun, 13 Jul 2025 00:19:42 +0800 (CST)
Date: Sun, 13 Jul 2025 00:19:42 +0800 (CST)
X-Zmail-TransId: 2b0368728b1effffffffb7f-2b1a9
X-Mailer: Zmail v1.0
Message-ID: <20250713001942027bne2UhpkDuiSVPMxA3LZj@zte.com.cn>
In-Reply-To: <20250710135451340_5pOgpIFi0M5AE7H44W1D@zte.com.cn>
References: 20250710135451340_5pOgpIFi0M5AE7H44W1D@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
To: <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>
Cc: <bsingharora@gmail.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <wang.yong12@zte.com.cn>,
        <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eCBuZXh0XSBkZWxheXRvcDogYWRkIHBzaSBpbmZvIHRvIHNob3cgc3lzdGVtIGRlbGF5?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56CGJcFu086543
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68728B3C.001/4bfYhZ0XSVzKjY

> bash# ./delaytop
> System Pressure Information: (avg10/avg60/avg300/total)
> CPU: full: 0.0%/ 0.0%/ 0.0%/0 some: 0.1%/ 0.0%/ 0.0%/14216596
> Memory: full: 0.0%/ 0.0%/ 0.0%/34010659 some: 0.0%/ 0.0%/ 0.0%/35406492
> IO: full: 0.1%/ 0.0%/ 0.0%/51029453 some: 0.1%/ 0.0%/ 0.0%/55330465
> IRQ: full: 0.0%/ 0.0%/ 0.0%/0
I see the unit of PSI and task delay are different, they are microseconds
and milliseconds. We'd better keep the units aligned for better user
understanding.

And what about split the output of each delay into different lines just as
PSI, this help us to better compare the results of some and full.
bash# cat /proc/pressure/cpu 
some avg10=0.00 avg60=0.00 avg300=0.00 total=682581546
full avg10=0.00 avg60=0.00 avg300=0.00 total=0

For example:
bash# ./delaytop
System Pressure Information: (avg10/avg60/avg300/total)
CPU some: 0.1%/ 0.0%/ 0.0%/14216596
CPU full: 0.0%/ 0.0%/ 0.0%/0
Memory some: 0.0%/ 0.0%/ 0.0%/35406492
Memory full: 0.0%/ 0.0%/ 0.0%/34010659

