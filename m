Return-Path: <linux-kernel+bounces-776163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E3DB2C965
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66AC18991FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEB524A07C;
	Tue, 19 Aug 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWZRvnEI"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925738F80;
	Tue, 19 Aug 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620531; cv=none; b=doomODHWrHh3O1zFiquYi0szy8Ln2r0T+XhrBDBntsw1iB1sCIT14N224OyRFN922XZzIVeBzvmV/nfhr6f93zJngeTt8giDpMroWqX45IGv6Ma4wzv7IeNRzs+cXEsCaqBwd2p1vk9grYYnY450l9CqgWcIDvJ0asrM7gE6rfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620531; c=relaxed/simple;
	bh=FiIphYldsHeBQ3UwTcbZaKPuigkn3+v3w+WuFBn5DUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUIdOyWn3ntVjwdug3MQBM81NI5WF2A1jGDs6hpw3xBV6HJS50GVd+2DMDCvFeHYVT394DKG271tBfXaDdII9Zhufy/T808vEuoLx2JDeQe71nSxc3K/cySBbfMGaAhiEBO31SFQQxv5nuKjd3jzWCjXqjUy4a8g4knhAR/GEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWZRvnEI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso787980a12.3;
        Tue, 19 Aug 2025 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755620529; x=1756225329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PIjZ+DdmvuLwnrpTYlLbFeMpxoFxo/PTXBFZfTSGBg=;
        b=RWZRvnEIpA5RGL0lSBdc2TidNFktoB7D1mHTwh/yCFAzfeTT221dz63okaQOkEm6zR
         XkVLsDsXhcNz6e/1uLNpLVqjF4UWP0eXToHutBLTFse1LBz3bWqNjl3j5YJSsjPsK2Qo
         MFIJlJVsz5x8t0jT1xAncuymhlyuMUveVwIv9mRyIyIHRk5ZiKKYvXbFNqqgqRLven7b
         gGdomd717ha9FYZpb9xBAI4AYCpGHLbnPPHE7AULJmTDeucML6+RavU/E2dZPuwDejwF
         gm3T7KFxrFRecJxuIdMrRayA8ONrw4Htfuqi6AB/Jg0V6Lm9qVe+ncdcuOTg6pXCW41v
         eFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755620529; x=1756225329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PIjZ+DdmvuLwnrpTYlLbFeMpxoFxo/PTXBFZfTSGBg=;
        b=WyHLn+bVYN5KHdDqUoT7Jz8SuyFxijrYpUDrqYTDfLHwXox2AIlOGIifwt1r3Vt/or
         H+xd6bU/istdsQlWgF7KJvHhdMx4G71jgcIIqO7YSAet3zVoh4yUezQGGpFhStVknu3e
         due+3wanLqu4JjYQs/1aEtaNlgo082kuDA72Xk9SkXijs2z1dgDXdXaWmMnZpTAZ2Kt2
         2SwppVRO/Jbc1hAio++8cpp97AkuXQ+mnHhp0AqvzOoL/3+IXS2cwtO2DGnRTGm43DiX
         SXw2peLYptpncNadiCTZNNUJP5xoH5Ajvt6Dumxu2jps/BIdxUfXDaKyEnGrVhVxMFTX
         66gA==
X-Forwarded-Encrypted: i=1; AJvYcCUVZPB0/QolhlbcDC97COdKVuGWeScqYfxCiBCNzL3YkY3FE4tcDF10x1lTjuw/pFONH+yXdBncRtin@vger.kernel.org, AJvYcCW3cEzQdJ5bP4B/iqXoqHY7Z42DuviqWDfu5ddRlhEdI8ZWn4JJkYgbT0c6dEhet2h22MAffKnQjsUc5s0w@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6pwm+DT3v95TLi11vKKXcI4OgB5/GBEOjUnqRy4egkxUKd5k
	hBEpo/4F6ODjefKM24eV7Re+52vr3n192B9eCrQOE2D6952qawJ4Sfea
X-Gm-Gg: ASbGnctCsl1wXVZ+189x7bLkPtcSamVmdEee/piGIOQjDjIaGTOv+eiaa46mgvEWl6K
	sBzt12WSzJ5/zZoOtPg+PuOQA39t2L/+DNxjiEoDfxiP5iQbVd2zNEqKMo2lndbqb/DebAIPSJy
	ybQKsAcJ0HHTTp0hrMp1EFwsI+advf5L8NPAhvJ2fsPY+eGbF86YRgzoX+55m9mwUX7608dN4k3
	zJNC4AbPcAEfm5SP8nJSRgvOJzz7iZl8r5+qBOJuH+s1Ihsl/VenxYaeAMne2ojHA/mJ7Jkv8k1
	G6HE7dZkTNBw9+DUPEpjBgDVTpF81AWC4Z5ZAn5ccq/dIKU2J2nL6RKr5KQs+EFhV+CM149rjlr
	1JKOiRP+z2cYWZ9U+Y7B1PspyEU1I5KbdHDYOma1ozBz4N7ywOPm9t9CuHyWbyZI=
X-Google-Smtp-Source: AGHT+IE1/3he44rcwmPwhGdP/2lEsUGbA2b74tOIcgVsabuA/J7rKhxfaf9z31Cj2VPPRLhP8RZaew==
X-Received: by 2002:a17:903:3804:b0:244:55b5:7cfc with SMTP id d9443c01a7336-245e047bc13mr43207695ad.37.1755620528713;
        Tue, 19 Aug 2025 09:22:08 -0700 (PDT)
Received: from [192.168.0.124] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4cc807sm1323105ad.82.2025.08.19.09.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:22:08 -0700 (PDT)
Message-ID: <66ec7bd7-6b14-4766-97a1-3928d9129880@gmail.com>
Date: Wed, 20 Aug 2025 00:22:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] nvme: apple: Add Apple A11 support
To: Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-7-65648cd189e0@gmail.com>
 <20250819083038.GA1901@lst.de>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250819083038.GA1901@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/8/2025 16:30, Christoph Hellwig wrote:
> On Mon, Aug 18, 2025 at 04:43:00PM +0800, Nick Chan wrote:
>>  };
>>  
>> +struct apple_nvme_hw {
>> +	bool has_lsq_nvmmu;
>> +	u32 max_queue_depth;
>> +	void (*submit_cmd)(struct apple_nvme_queue *q, struct nvme_command *cmd);
> 
> Please stick to 80 character lines for the NVMe code.
> 
> Also I don't think an indirect call here is a good idea.  This is right
> in the command submission fast path.  A simple branch will be a lot
> faster.

Ack for both of these points will check the other codes that got more
indented as well.
> 
>> +
>> +	if (q->is_adminq)
>> +		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
>> +	else
>> +		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));
> 
> This could use a helper and / or comment to make the calculation
> more obvious.

This part of the code could be further simplified and after that
it is similar to nvme_sq_copy_cmd() in pci.c:

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index f3999b8ef7ab..ff4c2f87770c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -295,20 +295,17 @@ static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
 				  struct nvme_command *cmd)
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
-	u32 tag;
 
 	spin_lock_irq(&anv->lock);
 
-	tag = q->sq_tail;
-	q->sq_tail += 1;
-
-	if (q->sq_tail == anv->hw->max_queue_depth)
-		q->sq_tail = 0;
-
 	if (q->is_adminq)
-		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
+		memcpy(&q->sqes[q->sq_tail], cmd, sizeof(*cmd));
 	else
-		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));
+		memcpy((void *)q->sqes + (q->sq_tail << APPLE_NVME_IOSQES),
+			cmd, sizeof(*cmd));
+
+	if (++q->sq_tail == anv->hw->max_queue_depth)
+		q->sq_tail = 0;
 
 	writel(q->sq_tail, q->sq_db);
 	spin_unlock_irq(&anv->lock);

And this seems obvious enough on its own, and should not need comments.

> 
>> +	anv->hw = (const struct apple_nvme_hw *)of_device_get_match_data(&pdev->dev);
> 
> Do we even need this cast?

Don't think so, will remove.

Best regards,
Nick Chan


