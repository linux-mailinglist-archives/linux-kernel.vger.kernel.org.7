Return-Path: <linux-kernel+bounces-892250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDC9C44B52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24393B0AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81902205E02;
	Mon, 10 Nov 2025 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqMx8119";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bU+kZhfJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF0286A4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736776; cv=none; b=qLu3QI2N22S5EOIima9fkBYr5nFOquAguhXdev0z9OO4cpP6r8j5p+xmLuiCzmUoRz3tXCCnLk2Nr0HJbbWKKiPI5kpfj208O3Mjj8oS8M2KhwA2pY/09j+OU1/cg7ln4CqaVVnDH9Ec+p5ABZpd9kjN+wEgWDSN51It/vA+e90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736776; c=relaxed/simple;
	bh=aOlrI3w1cNPvUYCImrIb2JafRvNQMyXUFJFDnijJcxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bd4S86Afy4meq7H7ZZDaEw9EhMmiyu4gXaUD1wLNQRT0N4XHWlfsbXeNkPBZA/6MA45HYL5s4OrMdEZsuAdXczW4xJ+V3CXfAL663a/d0v0xZkg5MLttneq6g0HU8c94y6fqaLeuOqrIv0sAbdtn2fwtf7cBnh9l6gwRbUvDSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqMx8119; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bU+kZhfJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762736774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYWyKNlYaxtpet7IUj4DYu+DKPKVpLXZerwfq1sZgQw=;
	b=eqMx8119D2qUt4tv8vc39CvTiCok6SK77Tnzk45Xqnb6TjT+M5oQnwOpDNg9ZBk5DoHqAr
	2HlkX0fbsaEchOqArBaro+J1ZY0h5O5xCsjtvNCNDLk0sX/TG4/RajPW50ujr2JfHmJF3t
	LwYb9U/zy+4m4bQNYTrbLQ7PvsnIBMk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-6EBLSxm2MLaNGKvCYgb_OQ-1; Sun, 09 Nov 2025 20:06:12 -0500
X-MC-Unique: 6EBLSxm2MLaNGKvCYgb_OQ-1
X-Mimecast-MFC-AGG-ID: 6EBLSxm2MLaNGKvCYgb_OQ_1762736772
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-295595cd102so65336015ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 17:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762736772; x=1763341572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYWyKNlYaxtpet7IUj4DYu+DKPKVpLXZerwfq1sZgQw=;
        b=bU+kZhfJTNx6C9Zkndf+tWk6trT3xDFUwEa/1SK4IxG+Kj6RLHeo19xHZ2QDjkWona
         s89u4Ue/eGPCOn7emg/tS6/pqC4ImsBKzuQO0tmG2RGZLEkX8fm21j3Rookiur0oE1Xd
         XaaOf7pzPC6mcb+WEH5t9aLXgGiiMHNL2C2nV2RrqAxitKO+vnCFJI6nIzMr7hr07cVS
         u2m/DJu/CTz9meFBQszcYOeXgp+dK0646xz09QZ5D/ufoeu+9kqcPD/RXHAPkPpdTRn9
         hPuPNAJyB0pO2MecniY6gNteAESgZemiaKKTb4XXOOJt1tqA9WjtaI4OdqOHB6gjMhnW
         kFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762736772; x=1763341572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYWyKNlYaxtpet7IUj4DYu+DKPKVpLXZerwfq1sZgQw=;
        b=CTKkPTdVCYkVkRPsdmX7lMKqNgbz5yD39o63PH/CveNW19Z/+2tUYWdTKY2OFd82yS
         tRJpRUx+Y/Gir73d61ktT1R99ahV6XjZmfcdRo0AaeBcvODHNa3BCSvSeXdeIiLTBwCN
         rNO9Rfrdp4gcdidNufC5Ae+aNPgXKy/Rd5eAl8RNTXSn1Xktp55HqXL4tuosg78uMqEv
         5JINIw+o8pzccdfAo+Hj7Q9ki4AZDk9vPQe9fMt0k5ZtUaEonoluREQs676FrvLZp02W
         g2MIIltdm0E4bzwP/cwAPkUkCL3s2UzPe0Rs/Oydi4ZpjYP/M5+OhgyrPN1kr9ncd3qJ
         /1rw==
X-Forwarded-Encrypted: i=1; AJvYcCXI+7qpUM2U5Jh4wmVMlIitWVzuTpft9aHkt48rehVKa6V4xyro5aK6i8jQdPpF+KJBUPS/TUB6n4UTFGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzagCNNY6UrEX6Y5M4GwBkAJU65r5HxNjQIHtLfgWwyNokP6zEz
	5t6DyYLR02RsxGl98PahcmuPDJ3HdZWbKHtiucqwFbZWT0ULdGGW2mEBUtmIw2f6EvU1KPwUUWB
	6yUG8374RxkhtbHX34SnwKzjoQm1ODlvZZQKaSi/eGKc+DFClkw9cQJo2JSlZwwRQ4g==
X-Gm-Gg: ASbGncsiNTW2t5uwWiwYneo/T5sc7f03UXq79/SiTr7fyo1OWwjCj80nWxHTUC0naac
	mhtga5GBMKDSg/lu5QV/P5ofBX+Tl3QGMmnNvap3JSItV1v20uYciAEx84AQTS7DEuVq2/tTBcU
	/T/ECZPGmbhsTDEAIURa/LOfqAucOVsMlH6Vz++qB/td5njVvINCUGQobU0QfEZpF9dpqt/VQ55
	gMVoDatFrnsTwyZKvKkXIHqwC+zg5FIbWQDl9OrGJt1zDpQoxE+Cw0v9hUBpjosm5XRQq33aFtb
	hsUrsISmcqwnb+I7O3ZbUE1xZzAxzQQGBCLXtkMkzNM5cUvsEUzL5zstQ6XODbBET/6zQXDQ4pW
	UebroHYwioR3SeVcY2QlPnZw7Sh1XcHWuhM1QlXo=
X-Received: by 2002:a17:903:1b10:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2982e7a3d03mr3138365ad.42.1762736771831;
        Sun, 09 Nov 2025 17:06:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF0CFiEoJ6ONU17kU1QFkRvQ5VxAZyJkrEh15FlCVoOKf8DubdfC/6/KNrhSF5I5E8PZmNrQ==
X-Received: by 2002:a17:903:1b10:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-2982e7a3d03mr3138115ad.42.1762736771483;
        Sun, 09 Nov 2025 17:06:11 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d6859a92sm75549945ad.88.2025.11.09.17.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 17:06:10 -0800 (PST)
Message-ID: <37725bd8-768e-4b7a-b202-9068f5e14257@redhat.com>
Date: Mon, 10 Nov 2025 11:05:57 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
[...]

> 
> This series is based on v6.18-rc4, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v4
> 

Run booting and kunit test on NVidia's grace-hopper machine. The result looks good.

Tested-by: Gavin Shan <gshan@redhat.com>

Thanks,
Gavin


