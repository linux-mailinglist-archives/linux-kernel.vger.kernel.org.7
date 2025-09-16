Return-Path: <linux-kernel+bounces-818399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50645B59140
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86501BC3E15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABEF280A56;
	Tue, 16 Sep 2025 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWSVhcmW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB82192F2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012519; cv=none; b=sjlhmQqQOcvj0JaDL21UAyXaMRgnEETaRHBnzUY80kCHocHFJBq7g5QYgf5lfoDZuUNiNgS59hqiHn/ToU51a0EG4eJIKGtGcpGlrjc34oaj9GLkh6PMm+ez+/9pG4XYQ9yG0Y/uQXzmeLyQbTCnoR56zLA6hNfrV3FeYk4SITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012519; c=relaxed/simple;
	bh=OTx1CX18N3834rVvwPY9O7+tKZ/kymmSB63p4JEscVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxXGvAEAv8ipopGhWXAgLrYEl/xVrd+/ZzvMriJxR5F3zQoUOyImCAgDKjY0ePN3Gp/PGd5ieg79seEXT7BE24LnX+eoTtUcVEWQG0rsBbUaqinMI1bXU6N4raiDKbJzxU6v1Vag9GKVXWxfohSDI6CLyUq0xZnPGgcBVw8BuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWSVhcmW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758012516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmN1zVAHoxMBQ4g/7XFyoJDJue0wyL96gZwCleosapQ=;
	b=fWSVhcmWJLGlXlLSSPuKY01paG+CEGOLTrTGsx/o8xhrTHqd+yhEwrVOZzxXTYcFFaMETh
	1mEtiRrgLSLnv0EYHbskOpDEFpxJ5/rTMJQkDn67SexMc2I0GaRqF2aBRdlJbMi654UT9c
	hEfDx+5WpvCbl12FGA2aobcqLLzSd/g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-xNaph20_NK6sM51AcWUBLg-1; Tue, 16 Sep 2025 04:48:35 -0400
X-MC-Unique: xNaph20_NK6sM51AcWUBLg-1
X-Mimecast-MFC-AGG-ID: xNaph20_NK6sM51AcWUBLg_1758012514
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2c1556aeso9018395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758012514; x=1758617314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmN1zVAHoxMBQ4g/7XFyoJDJue0wyL96gZwCleosapQ=;
        b=CF5pway7PipNg0CDDWPLAHDCgUWxaJHLXBW+xzbIix0ekegAASwZHSPjY6QvYmS88c
         27TKIRc87ZVfubDVs1uwT92MM26JHmIKrZNpGoLgSVZsx7B8VypWOrO1vBf9SPZsOfTR
         J8Ce7IxwAhVNCrE1QDLpsmmZiYgIuJWjegrikwsc1/qBlia1z6/Xfoz14lWwr9UBjfc2
         YRKXMN0ENB4V8ZOgmt6FJtbt6gadnyOZ5zT5uBmTax/+ybdKEdqr9miVkaK6b0w5SnPd
         TVZfWhUlMdd8LlBiLRGKfW9baGeOni2Jwxb9OtvrkgJel1w7kyApOv0KxP7vM3eeSyox
         xd1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO0jIDuEty8aHPrTLjC3xnocwx32cJZrAQt4MfN5yw96s4XtSvMlGcvOp4ao657feVwRqIRWcj6Lss4J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrdOUA05ltTBh8sKj8/kLDY+Yjh2XHHpcINCXTRKeaP5R080nO
	PF3bpatHuQI2na3xXgSQsik5TUX6HNNxFzXF0dyoez+65msa++/Na5GG7ATlCEF8ODSHZkzI92N
	PdxYyAvTE9HrLmB5dcnt4C+GwUduwTIA1s7wgKMazU6uSGrtYZNolEKz4nynG5Wh5CNjIakt9CA
	==
X-Gm-Gg: ASbGnctSaP3gcPG86ZbdFwHloQ7M+Xi3k/ucQNVFmtgX98zb3nHynpjucY90HlD1GOZ
	+Zu7RWqUApVRn6Ucq7MfHvwsvnqgx6VqDrcJAyl7HH9UPtoE5fybCixg2QhgGoApkrBpvDCNSHh
	OZ18CTxJQCJaS66Ik2uEwMxSmhufQ1tLV4g5AKWII+c4wkyXLj9qoJmPi3e43XTULAZj2PSqRnT
	8qO6rZoizkqEV11/Vt8yxuRYVpgjB09TdZiXDwkuqAk3tIN6XVqdHec3QXaEbpibdenyEwzqLIu
	uzVe+S98joB07P4dIkVF0nHJQU5WCP0NDeCen4RZBRfgGyrTXESTqHTgO97Svcl2OzYOyrxjzfO
	Q/cUpLdRkUXzB
X-Received: by 2002:a05:600c:8a0c:20b0:45d:d944:e763 with SMTP id 5b1f17b1804b1-45f2120600amr120929515e9.33.1758012514030;
        Tue, 16 Sep 2025 01:48:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMOKpkiTHjhH8V1CoxbkwPtQS09nDDz3Z1SOX4Anr7W9Jju1W3xt7/QkqndQiKwCF6Tcwikw==
X-Received: by 2002:a05:600c:8a0c:20b0:45d:d944:e763 with SMTP id 5b1f17b1804b1-45f2120600amr120929185e9.33.1758012513639;
        Tue, 16 Sep 2025 01:48:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157619fsm215833385e9.7.2025.09.16.01.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:48:33 -0700 (PDT)
Message-ID: <a52f9dfc-cfb8-40ec-b5e5-102b99803b1f@redhat.com>
Date: Tue, 16 Sep 2025 10:48:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v06 00/14] net: hinic3: Add a driver for Huawei
 3rd gen NIC - sw and hw initialization
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
 Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1757653621.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cover.1757653621.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 8:28 AM, Fan Gong wrote:
> This is [3/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 becomes a functional Ethernet driver.
> 
> The driver parts contained in this patch:
> Memory allocation and initialization of the driver structures.
> Management interfaces initialization.
> HW capabilities probing, initialization and setup using management
> interfaces.
> Net device open/stop implementation and data queues initialization.
> Register VID:DID in PCI id_table.
> Fix netif_queue_set_napi usage.

Side note: You lost/did not add a few Reviewed-by tags from Simon. For
future memory it's usually safe/better to retain such tags in presence
of minor editing.

Thanks,

Paolo


