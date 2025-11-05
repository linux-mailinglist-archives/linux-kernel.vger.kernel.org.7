Return-Path: <linux-kernel+bounces-886225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC7DC35084
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9AE564593
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82392EFDA4;
	Wed,  5 Nov 2025 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1NWNOyy"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78A2BE658
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337063; cv=none; b=JYFNLBCo8xfbC5oD9kXAnqKRx/lsuODIy6KIZmaSzSYZkzXbPreBHyVMJrZG0Re5sS7XeGCRq0zH9mpFKST27qMvz8NC5mHdP175FaCWFu7bOQkq7zDtmsqC43EIvsRzxVOaM5PykQ11uJ1x01MHuxhBObVnEMIJRyjeZzMJIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337063; c=relaxed/simple;
	bh=Le/pDoysJRWk7yuxVty2Hd5PN/rbL/2GKhj/ehO3stk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCCiUWmvZM87vZWnMyAKGK27+SqSe9C+UfOpsK5Ra7y9O1NMfYjDA70MUoEsNO4NIwOYSlzsIM8ZT8+49dwmR8IKUT6SiurfPRn7H2dg+96pMZgYglY5CqvkhMry0kiYm0dDV85giqbf1pwriJPNxh/quIK/sfIGl4+onOmsuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1NWNOyy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295351ad2f5so4791125ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762337061; x=1762941861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOm7tfsMbQ9gn+1rZ1WTdngWRmcpDgQVp1lJAR4kXBM=;
        b=S1NWNOyy/pkMr7O4ReQ/g6oKcN1mZB0VWht2RAaMqes9nezv3aPSk9H6myph6X2nxv
         L80FCwhidpbZCbtTYecy/QDbuT77xnmnr92gnMYGcaBRnxFGheRr+1a2KL4+BC/einqw
         nWwQqLVEo4YZK1+9RoaJXGue4yVlqFzZxP8CoZlBVzpCeSH3OlkuAZnH8Wo+hbOHsVI7
         OmucSrtTdlQzrJHu5axsyjX0s909Mux5xPfIy/tDFgyAGEOpSX4wmeNzApx1MpeYM3Vi
         ojHR6wS8/Bq7fjxGEJ+kWn6QHA2X/+Tzzzz69gdlCWxV9A6YZpWOWbiLnvCC3EuZ7wyy
         GCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337061; x=1762941861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOm7tfsMbQ9gn+1rZ1WTdngWRmcpDgQVp1lJAR4kXBM=;
        b=aVmOdXluj3xD3ilbgM5K6JArnXCapH1XMib0PA96oOaes0ZOGijQScedoEbAGMLn1N
         0AuwlKXvqJ1qqLgkCjIbhQFyge06PqdkmfS435PAERVzRR5DdxYP6f6ZCE/TtEN2J2yL
         GS/CyQmbsKFde0y19hvzsSaSTMT0ucoHmTLCDXqh3jmvSEmD4u+43mVfgHLDlrMSTbQX
         TtRRsA02VEmHoPFK4O+BqzQGLmE51qcR36rcuZCBBuC+gJ1l7SS9SJfTZhwvopD0D4MB
         gWgeF6CP5+0d4q/htiYOxkSjaZpUQH971P2N/Q9mZVy8O3CKkoDrzS5fVyZxHp5eNIAn
         KZZg==
X-Forwarded-Encrypted: i=1; AJvYcCW7vkvHxuPySpHRIsAH4bnB5wqe8b9jdjZr6GXh8QUoMAl4QpRuksHRy5OLxRrWIQmvwOcBwedtAn3LDIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IT5a2sr7l+fqDyvqboNuJnOyis9JtIzjwRxfFOtSJqXRrXwm
	g5uSNGH8sJFm5WWsVvLUxRWP2SE3n/yZZIVtVnCmA7qW/CglxKZ9wsyP
X-Gm-Gg: ASbGncuZCQBqsDLKRdD8hptn3Vf+Ej0US7oURsYsq/LKQ48Gxz80RhSPTev9owoJ/k6
	d7ehe6ChPa2JveOZ/lQlqa1lngZVpIQ/szro5HkN6ibqaCXsayLvPgewQfJi8Xh6chPMgLCY11m
	VAg7R68/V8iiCD6l910TTYINyKIxoD/PAy71XLO8gxg6qek0yhnfwUwFOyH7UvBPe+xMnJAALN0
	O/hFPdGT84TMbD+ejlVCy7IL6hl0NfOLQHe5B0SGKBl18FW7uhHxkSr2FW6DoSEBI7TuCrvw8jn
	5ep5cix3fCq5UyCM3ZMhXt0wa62zGF6QXxH3+ne1s62I1Uu5P8cBcrHdGXI/pi1XmEMV8rY3epX
	oeslVcx9Gv4SelvK8EoxlfF5KyvmYYHPWsssdR8Ed6guIUysd1xJ+rtidkmusSVYRtn66EHcI7n
	ziUm3G+ozf6fQSQKZs41JQmSHRvEUzqxBwVfKiPrF/8pCYGtYcVVRn
X-Google-Smtp-Source: AGHT+IGk5DBNlN3hTIt/OU+KnoTcYwEyDT5lGKLbg7D04mmqvIMyiOIVgDNc3sz+2O4XNKqDHIVh+w==
X-Received: by 2002:a17:902:d4c9:b0:295:290d:4af9 with SMTP id d9443c01a7336-2962ae976d3mr23428015ad.11.1762337060800;
        Wed, 05 Nov 2025 02:04:20 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:ab47:f43a:acda:ee47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f1a19cdbsm5027590a12.2.2025.11.05.02.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:04:20 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 0/2] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
Date: Wed,  5 Nov 2025 15:33:58 +0530
Message-ID: <20251105100403.17786-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aQoIygv-7h4m21SG@horms.kernel.org>
References: <aQoIygv-7h4m21SG@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/25 19:38, Simon Horman wrote:
> On Sat, Nov 01, 2025 at 06:04:46PM +0530, Ranganath V N wrote:
>> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>>
>> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>>
>> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
>> designatied initializer. While the padding bytes are reamined
>> uninitialized. nla_put() copies the entire structure into a
>> netlink message, these uninitialized bytes leaked to userspace.
>>
>> Initialize the structure with memset before assigning its fields
>> to ensure all members and padding are cleared prior to beign copied.
>
> Perhaps not important, but this seems to only describe patch 1/2.
>
>>
>> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
>
> Sorry for not looking more carefully at v1.
>
> The presence of this padding seems pretty subtle to me.
> And while I agree that your change fixes the problem described.
> I wonder if it would be better to make things more obvious
> by adding a 2-byte pad member to the structures involved.

Thanks for the input.

One question — even though adding a 2-byte `pad` field silences KMSAN,
would that approach be reliable across all architectures?
Since the actual amount and placement of padding can vary depending on
structure alignment and compiler behavior, I’m wondering if this would only
silence the report on certain builds rather than fixing the root cause.

The current memset-based initialization explicitly clears all bytes in the
structure (including any compiler-inserted padding), which seems safer and
more consistent across architectures.

Also, adding a new member — even a padding field — could potentially alter
the structure size or layout as seen from user space. That might 
unintentionally affect existing user-space expectations.

Do you think relying on a manual pad field is good enough?

regards,  
--Ranganath


