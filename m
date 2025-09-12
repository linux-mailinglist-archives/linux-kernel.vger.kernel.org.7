Return-Path: <linux-kernel+bounces-813774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE955B54A86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F427560808
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF952FE56D;
	Fri, 12 Sep 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="HbO/YMmg"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D92DC78D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674854; cv=none; b=phfIJLfa4B68C/MtRGRXlLIabJM8ENA3wR4egAJtlc8W4rIWVSYuWFCthtSP0XGmYNUi2g6x2wcV2mGTFqstoeAihP9OpNGNgGdeQPe4cTFinGLZhGzffbAi9Oy3y9g1i6OHObuQB69lHblchZBQO4q0tWYq9HLcdP3swxXh+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674854; c=relaxed/simple;
	bh=mOSiyW0/hu5drWDOmGZIPJrpgJmUuhU8jLXKY0Vb2Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UH2yJlvbW1PLQLvE5zpDF8FbB8uxzBPKOjK/EopuDtNLPkruWc4l3Wvg944e++8M5GgQVbL9pxaDeUvqCePIBTvNme2+Rw6ntGwEff3ybGAjc+gJt5E2hzNs3eJL3XfUW8PxN2M9fwl7OXe8QP+Wcbxl9PiwEBSB3Rklnc10oOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=HbO/YMmg; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id wuxAuOqlJLIlMx1WJu1CyK; Fri, 12 Sep 2025 11:00:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id x1WEuVAOiBXbMx1WEudBVp; Fri, 12 Sep 2025 11:00:42 +0000
X-Authority-Analysis: v=2.4 cv=OOAn3TaB c=1 sm=1 tr=0 ts=68c3fd5e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=SsH6CVIiC5XJadHIxOjS0Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=LkUqxtoJcTRmN4tn5QIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AMksTN3zQyILx2zZX1tUCKTImAjEImai8ZH+EOcWQio=; b=HbO/YMmgeyZ6PbzDV5g6LQmwLf
	iFe+SDZ2wLJpAhJwFVIm8PkDKTELfTSGWBhB3vYPNgum85nF3yhgO5OsF70nQQWiC6QLwykMSW+eI
	XrcrnTuWjxxJZ8drVjiDDVOGdeELXrjsM/aqFUk7EtviFg2E9lqES5a9PVOJCZcZgTh3ofxjnsMVc
	LOrgnAcsoNY7aQQPaDvEominr/YfpUEeeXOwOHXTiTw5gGlV02f8fpWwW4//6rzOLXcuobC0TcwFq
	LAUKUgBA1ldVMrWmp9LyO3oQWCzLgXiYZnl05pTjxKCmNzelXQR75HfkmMXPOeN7VrqLW7cDlIUho
	bMze91YA==;
Received: from 40-228.dsl.iskon.hr ([89.164.40.228]:53996 helo=[172.30.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1ux1WD-00000002nrD-2auo;
	Fri, 12 Sep 2025 06:00:41 -0500
Message-ID: <96ff90ff-35ed-44a9-bd3e-cf8070a8550b@embeddedor.com>
Date: Fri, 12 Sep 2025 13:00:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] stddef: Stop using FAM parameter of
 TRAILING_OVERLAP()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <cover.1757672423.git.u.kleine-koenig@baylibre.com>
 <0c66d2f3dc875664bf0eba7707044e48bb029dc6.1757672423.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <0c66d2f3dc875664bf0eba7707044e48bb029dc6.1757672423.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 89.164.40.228
X-Source-L: No
X-Exim-ID: 1ux1WD-00000002nrD-2auo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 40-228.dsl.iskon.hr ([172.30.86.44]) [89.164.40.228]:53996
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA+fZnrLSVdLhNPRNoE/cJ9NW9WxgoGJjIhDi7mC+OYG2GRKuFJ3gHnqpcQQZ2OvPXPwoYspTQ/nNKd3uqQ2Oj5LfHHumt1cdssBfI9MMKdm9cIFJwz7
 drP5zXVGl4RZsHE6mU9AD7IhqniX7pZ8bUEiu/YosDZQvFB1eEIUMAPnm2hZEWeL6Ehxk0Tdq3pHxbkX0nVodj4UUDL72d2wct340mGY91KBcdrh3y8c4Web



On 9/12/25 12:28, Uwe Kleine-König wrote:
> According to my understanding of flexible array members and the c99 docs
> ("In most situations, the flexible array member is ignored. In
> particular, the size of the structure is as if the flexible array member
> were omitted except that it may have more trailing padding than the
> omission would imply.") sizeof(TYPE) yields the same value as
> offsetof(TYPE, FAM). To make FAM unused rename the padding struct member

No, as I commented here[1]:

"Flexible structures (structs that contain a FAM) may have trailing padding.
Under that scenario sizeof(TYPE) causes the overlay between FAM and MEMBERS
to be misaligned.

On the other hand, offsetof(TYPE, FAM) precisely positions the trailing
MEMBERS where the FAM begins, which is correct and safe."

sizeof(TYPE) does not always equal to offsetof(TYPE, FAM).

See this:

  https://lore.kernel.org/linux-hardening/aLiYrQGdGmaDTtLF@kspp/

Thanks
-Gustavo

[1] https://lore.kernel.org/linux-hardening/4b9eea66-f004-4b5f-bf48-4c32205cc8ee@embeddedor.com/

