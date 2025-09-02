Return-Path: <linux-kernel+bounces-795893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71362B3F909
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7AF1B226BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFD2E8DF2;
	Tue,  2 Sep 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvVla+EI"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B562E36F4;
	Tue,  2 Sep 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802801; cv=none; b=NrMtj9hCgK3IVIN2nQF/u+DwITWQ4gFHyHQ5RazGaJ36qLUr+B6WNZ7dAoXoaxfQtjRUiEGHpQgQw/XoZ8IgtxfwjhIg+IsJ4L1iNjeJeCuR7c2Nzr6zlpAqUztTygAZktKlq7y/ulTRGT0fKhw0h8zjuQuETyCt7N5AfiEsDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802801; c=relaxed/simple;
	bh=s4eky6q9u1BXZxYko75UYJ/WUeBzhtybjaqD82y3H98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZLjpD1VwuLSM+EaacDESuThrptlR6PIADdADRaYHryhaWq7lqOJ0AAJC+r+JrP2fZtHS9c5i7mn6HgJY6MDukb4xmfGCIq8F24aD/2k3Fl9rJnrtx+xNQprF/hKqTldtDhGGIjQCTXxjFRrAMxSi6tXTopRYhQLZpwUuk1bkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvVla+EI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336e44ca0e4so14015461fa.0;
        Tue, 02 Sep 2025 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756802797; x=1757407597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4eky6q9u1BXZxYko75UYJ/WUeBzhtybjaqD82y3H98=;
        b=BvVla+EIyeQY4+Prane/Q36k7LBA6CWXY14kGj1CZa8vsADSlkDMLEfHXQmA9fD+if
         +s3wHrSx1vW4gTO/HW7ZI23b8YjLCJWxqbdwfMzMaKL7BxflKJV0NFO2iLdQ+dzblh8t
         R5hMumBHNZLObFYWyFyjVrn0JU73tboYYJNrsPsQY4KGU2syj9iaADHvfbKceskxmCiC
         UguqeEswLutM58ax+XlpTK37QiotzH0X3SFWysDtaIZSeFszNz9QZ3h14Ut0sMV2/YQ/
         uV5HAs4TpnLM6wbnyjYnhqfDcoQF8YDxUzGrApb4xNZb4Ps6AzGMwcGOGewc3jNMWro5
         6Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802797; x=1757407597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4eky6q9u1BXZxYko75UYJ/WUeBzhtybjaqD82y3H98=;
        b=eZRxVfYkR5qiI4figU7T7b6Lwbkc1RUi+NHfZMj9wQln0xAgVrdiyzcrVq/GE8D4ti
         upNGxp0i/4YIIgD40cCkiFya6BW7qniV7kCn3dBXqpFfXRWUGSu+vpaimXn71HuBQ9K3
         4T5AKPQMhT7V5DRSUcazRMJwkj5HbPzg8MFm/EMNl2FKX9h3hbBaa57KG6mKI1gpe+A4
         TPB9e27gtOxwjvWmoasnm7a8HYjyHMC4FR8f5S6lLABBHBnLltcRHlsMNNHpjZVk5EO4
         GHybvzbKbncdB0paoUrK3eHkxRScg51nMT2RwGbkkaJAlBlZolxlI3+WI5HGl0iIy+3Q
         7GFg==
X-Forwarded-Encrypted: i=1; AJvYcCU6bmZCLN7WaUB0Iw95Uxs+0T/ucDdT38paukOte5qgFP1ltscjG6pkRM/H1wU7ZD70ZjHtoU9RyvNE+YQ=@vger.kernel.org, AJvYcCVqbgFP3DBwBVVPz3fA4Zq499s0hfo0KEVsTPNNoYk2SnkAfOxcQVH5trexPdHytr1/h+i8PgKM2UEo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28R8KgKXuPpcwzv9cDACRscFAGocG7L7YZTzNudbYI3uKxV8b
	I1QkDeEBSLr57tgOihO4gNw52On43th9FgB8dojUWIoGUhAcAxqzRmO3
X-Gm-Gg: ASbGncshJZt2R1kLCty1AqdMrESCcPPPYYQ5Ml6MiPkIDftoZmCde4OZN0v2EeVntOW
	1cuP0eWk35jyYQnOdehgzthNtwkwL6SdXco15WBob0I9V/NSvKJT25AMRwVI6I9b0bMAYJxhz8k
	Ubt1AXEX9Y+3JxCKoywwUz/fkzpDY8yGep8hyO/b6r0nfCSpyT2HqRzmbx692JF1D1ecVp/lh4d
	ZlJia+8+pYu1qmMLVTdgE9ox5NgBTnt7q3iLl4xpmrgXf9XhuX8DhyzUkjOhNxCJEywByAgO43P
	jynPPNPN83lfx+u/LupnpM7trxcNvMDp9yeiMoc8zRlynqKgYC1s/4AdzmXKcCyWYpXyXEb66T3
	koZ1jSPTcwvl9GpNEPnDsE6LpoRXr8QOCAPSGbsaQBGdf9A==
X-Google-Smtp-Source: AGHT+IEWkjCf0Z51FrqQEW46iV1npHMsR7joGaes/VW9LCMYKAgJpzyD7fQSexSvMByintFTLgo7xg==
X-Received: by 2002:a2e:bea4:0:b0:336:b941:4ab1 with SMTP id 38308e7fff4ca-336ca964751mr30846691fa.17.1756802796338;
        Tue, 02 Sep 2025 01:46:36 -0700 (PDT)
Received: from foxbook (bey208.neoplus.adsl.tpnet.pl. [83.28.36.208])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5032c9fsm3267431fa.32.2025.09.02.01.46.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Sep 2025 01:46:36 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:46:30 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: "David Wang" <00107082@163.com>
Cc: "Mathias Nyman" <mathias.nyman@linux.intel.com>,
 WeitaoWang-oc@zhaoxin.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, surenb@google.com, kent.overstreet@linux.dev
Subject: Re: [PATCH] usb: xhci: Fix xhci_free_virt_devices_depth_first()
Message-ID: <20250902104630.6a9f088a.michal.pecio@gmail.com>
In-Reply-To: <446082a4.7dbe.199098cd654.Coremail.00107082@163.com>
References: <20250829181354.4450-1-00107082@163.com>
	<20250830114828.3dd8ed56.michal.pecio@gmail.com>
	<5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
	<f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
	<20250902093017.13d6c666.michal.pecio@gmail.com>
	<446082a4.7dbe.199098cd654.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 16:30:48 +0800 (CST), David Wang wrote:
> About the change from "<" to "<=", I did not observe any difference on my system. Is it because my system does not use up all slots?

This too, you would need to fiddle with devices (or connect enough
of them) to reach Slot ID 255 (probably the highest on most systems),
depending on the xHCI controller and its ID allocation policy.

But also as explained, this bug doesn't make things go boom just yet.

Except if combined with your bug in an obscure edge case:

1. A high speed hub has slot ID HCS_MAX_SLOTS-1 and some TT children.
2. Another high speed hub has slot ID HCS_MAX_SLOTS.
3. We start with freeing the second hub.
4. The loop is entered and leaves vdev pointing at the first hub.
5. The first hub is freed instead of the second one.
6. Then its children are freed and UAF its tt_info.

