Return-Path: <linux-kernel+bounces-835476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE90BA73F2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395123A5BDE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ADA226D0C;
	Sun, 28 Sep 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4paY36t"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB9225397
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759073118; cv=none; b=D73dyJ3NYcNJdV9+im6wnyUqBw4K8YW8ofFl97RqSig3vpvhyXxciz/CwTcYO2kgv2bAChSZbFE1QTTkLG6i2CTzgRMZkX6QXOl36J7k15dYh+pX8IDNAQ5Nu+DzRa/LcdRnaoOY+YO8bke2sz1Rvc6SF3hOY2/bD4jc6CUEPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759073118; c=relaxed/simple;
	bh=H+x7xeTP5Rlop6u846HTPlz3WDGleJxQQfSnJGaS35k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYa4hnABxNQ5T3n9fhGdYeI5asi33XzVhE2IqIvIY7q4uuX8df8DjJ5n4I5Y6Kdr7jDIkv7vbiQOlbR0zCYzOX8c4rsMveYgSpBRaQDls7TpiEvmRp/j5DG8k8eqb4FUKAq9S7yHxDmxTRId2E2s1ewKd3KufAbvXagQxw8VQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4paY36t; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so2694106e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759073116; x=1759677916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGMYPzC49G0yAoq8KWoK1e/5gHShl7sG5H8YAVVDIFQ=;
        b=B4paY36tr6R+o2lRDTPszERSOttQNQVXuUeg7GMitALNc0DJp87ywjzu8yb8xya5e2
         IKM2PGF1QyFMq7TbBZ8CwCogxuXS2QQSM6w/cgooGcLIe/P6XVZOaA8yl8QJZY1R90Bd
         SWMDJr+XO//g6S0iRjUp+RvinGcX+ZYTILd9QuoCREK50q0c8gdGlOIREoXcjX+sI9X8
         kQ19IwbNUIURJTBtHxdddQKdvNMoxBaEyBLC84YzlKbk1nqbkYRNiRM+ZTZu47uHsJMB
         TeBbhF+4OcUudrbzQUAqEC3GqZkds6YyoykvcdMma8HFZUl0PhbCMWwAeS9po1LfglY1
         tVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759073116; x=1759677916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGMYPzC49G0yAoq8KWoK1e/5gHShl7sG5H8YAVVDIFQ=;
        b=egDywS36SQtoPTtxS3+PmxcVqY9fuNtUIebEr0SQsTZtMPM/0tvxRt8v+Xu0wBB3ws
         YOTj6WdWRDMi6LE40yjf/8oG45jAvgP8ZDJR9nHaJ1EdURNIQsXlBOq+va5F1z9ef/7O
         UpixvM8Pk2P9g3KtVLetPGf/kmwRtssKyUdM3cVOL8w2YLKciMg2cOdoysup/RneeRsx
         y5HeqaKtcfZctaZxcDrXA5sETFdQtlKXCiNmZWM9QUhHE0NE1s6ZsnaTmoZ1V1japW5p
         VwyXxJamEABESl30SN2isJDiACZ5tbFcRp3HWTrjDgDSUvhBNBZN8AvPfqDctNOMfciZ
         P7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXK2vC2tLH3ehgoTiGrDwql8O9kVWkE6KLaTXFTBdExu1RddCRQ4BELBhbxLTzfAjT3ZQmGWDbiMPAu3cI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PcZPbUwYSoi4WdBFjLqFPYKOVoHCeSH7pyf0ivO1CkpdSnBO
	zQpqDy32rK7IBG571DgAAOYKKRXK9qcDBOyqmfEdxm0FA8ti+Gf3Tt8i+LthRg==
X-Gm-Gg: ASbGncu2Pc6p6ca/m7iU0WfWGH1hoz4IDRb7FIsEPCgOArQ0STrzQtSWiXhsnQ3sHR0
	hBxgQHgV2dI5SQToBBoPEdWZj7yOz/HKguWahqHKlF++PT4Myr+LnrQ1MnUlhRvbNVP1mBfn9i1
	XyY7u7OiMf9fQ30hnL9b130s1C4AVhojJGl/PM/iJ++TKKjcTDV2wIz5WttCtpRi9yLbbm/vEmx
	9DYCanHly84jLcmDoHbTZthmlmY4rjLuJjjJnYyU7xvMgF0DPrI+Nxo1skJoI9Hfeilu3V2tNKl
	Zfd4TO1i7XtdR8PyuGWvJqLG0RBdL44YgCh3RujFnwHW4qxPWR39w+u0z2R29zn/C8TSU9QDDbG
	nKdGTiXN4NxV7C6/VhOmIk4tqTXxbXKkUnJzXZ6zvZ4HWo8qmOw==
X-Google-Smtp-Source: AGHT+IF0xKF2bAVGZX6YLQnQJa6tiSFhgbcg/WEeQVm87W/X2LXfvblZ0Iq7cceCpPfrNrfPlWaS5A==
X-Received: by 2002:a05:6122:1e0b:b0:54a:a30e:188a with SMTP id 71dfb90a1353d-54e5f0fabe2mr319487e0c.14.1759073115611;
        Sun, 28 Sep 2025 08:25:15 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bedca058bsm1819366e0c.18.2025.09.28.08.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 08:25:15 -0700 (PDT)
Message-ID: <c5194ece-e402-49ba-8b15-674c782b1a6c@gmail.com>
Date: Sun, 28 Sep 2025 11:25:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: fix uninit memory after failed mi_read in
 mi_format_new
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
 almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
References: <20250925203701.223744-2-rpthibeault@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20250925203701.223744-2-rpthibeault@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 16:36, Raphael Pinsonneault-Thibeault wrote:

> -	} else if (mi_read(mi, is_mft)) {
> -		;
> -	} else if (rec->rhdr.sign == NTFS_FILE_SIGNATURE) {
> -		/* Record is reused. Update its sequence number. */
> -		seq = le16_to_cpu(rec->seq) + 1;
> -		if (!seq)
> -			seq = 1;
> +	} else {
> +		err = mi_read(mi, is_mft);
> +		if (err) {
> +			return err;
> +		}
> +
> +		if (rec->rhdr.sign == NTFS_FILE_SIGNATURE) {
> +			/* Record is reused. Update its sequence number. */
> +			seq = le16_to_cpu(rec->seq) + 1;
> +			if (!seq)
> +				seq = 1;
> +		}

How was this tested?


