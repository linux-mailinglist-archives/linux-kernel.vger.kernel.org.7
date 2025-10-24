Return-Path: <linux-kernel+bounces-868827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8E2C06400
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9E03A9C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C423161B0;
	Fri, 24 Oct 2025 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GggrFq0m"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382233081BC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308860; cv=none; b=fV5ce2jOpPa7dQdxLuO/yjjVRu7nDcw734CGvr/Ssdjp/J13mz2b0zzVgnV2mfstTuJKF2yBzERShHWBV5mZ6CJn7rJBuLeUSsoeEcI8y3wq0yZhtv4eRKo1LK77KlkPwlcIjJq8mhfY+nBdnTwyZ2qJshvhpZmwH0baCWCS+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308860; c=relaxed/simple;
	bh=rtW/YqFCqYJXVFaIiFBjTLeSQF5soc3Ni2CI2QxvdGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tg4AWVLgjzqRSyqQN1hSkQUK7+3pOz2UqJmxCMfkvTxzlVcFaBdplP8ADZJ1+19IiK2TxkKM5gYRH6/Bh5D79uuJ5ILWyC5UAgApAUbUulziHkxnq385BfJuiVAOj6kLxOSz6oD9dRowqszz24U2tcyYzTK7iaU9Hq7olokicU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GggrFq0m; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711b95226dso22610925e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761308856; x=1761913656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVJZKuBfELCA0EBJRpQJOIs3VEwlVrGgyjUYP50xHHM=;
        b=GggrFq0mqz1MI18H1HkiIjQpCef5uKEBA5guIvjBtI8v+sCd2tdes0wvwdHqqtw1/j
         6sWR/+CwnV6ugH1prSxkF2c36C4QtF+7Szxd+HF9ztLHmyAWj4eDb6R3a4ilPYvd3etc
         tWh+xwpLXRQv3LRH59k+aTMz43emg4N997yT/+WaZNnp6asAoUBfJ5cT1ziFIiK7I9EI
         afMw23+bDeE829qtvl2hl+EvKZFdL/q55Wc9f9GPkeoqWVSkygK1Y9bHfty6b10NCGzK
         fgSchtI1F9rjv9l3oArs2Em6kb6KvPtc0wTzEr3sLbjinEnEgsqCDeIPtI5sW2dQsiQ1
         reng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761308856; x=1761913656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVJZKuBfELCA0EBJRpQJOIs3VEwlVrGgyjUYP50xHHM=;
        b=Mjm4gr+BE72NDBcdGtNlTnDsICaceY+V4SKOeCw5HNIU6xlzRN0tvYAToD6VTmnpfE
         6rwjUCcyZaurLo82cfhyrlcAVz6NgsvRj9f8uX+/o6oiZGWUSe2/J1xUHPgWY7dgVldK
         rRUBgc88Jh8CjrQenah1HwAHbTQVKN7ZY+659tdJysPzOrTshjA28dD/fG2WKBjQL4ER
         bW/bXQmV4g9xiJUA+5C4gXkCwcdl8Dazi0kn2Ye65htjExNEF7Zdq6UwpuOfYE0UbDfR
         dJ25z9SXoLPbttfakBkH5tMfoe9iKfKHOOPFdB4RNIr1tFTCOeCIJuwZXMo8uEvOW8Uu
         8SoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4V7cfIunlE3sAzgZjY1wV0/aJ+9z8VNs2pagsL7Q0ETDxoanvFY67oRKusjx0SdnnKwC43zFwd6IIwc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzaQYxVmTsRsmZmTZLZ526fTkuGqo8hKha/Tq07v7bQos2CyP
	bxuW/oMZjOUWN/f6ixo3FYJLyUh+K+y9qoIfqHrZARb5Q/BxuSPrnlpC
X-Gm-Gg: ASbGncudA/ZHZM1nG8x4SeJWCovCtdvwdxs882si8WgGJ3mgbDIj+Y1RLl7NME7M6ot
	5EA384HZgIDKAw4OzfyWr2+DmNq8vRW1v82M6n+HPqRZ5NdvXBcnWS2HRqcdjqraXIhGQFQ0MVs
	2H1up5kXVltVFFc9GCE6AxUDwZM9gjLLWYlJcQlT5Z2gWawfVNH07xLNW3RciLwd1v1BNxIORD6
	T95bSmA8z1Jc/k0LD1CrYvrNnvkmRWKxtpyf8TQvriyl+2TnoaQXeDPJybPQCdOUJBZimVgW7+P
	PmRYu/vRrWFdx+wewmh9BqFGbJJw9wg2y4fVQzB1Uewzpe/S1q4g6tmUuqFsKNfaMQGBH8Pr1WE
	BOhSf7Mt1OBbH802XsoyvLFPmLsiDB89lDLSsAod92bRy0KGYXvafMspX+mVwLBIBrtMaJN2+Sv
	X0HaaSo6mCixiDII9e/hT3K27yxaQjYikMu7XF73X09w==
X-Google-Smtp-Source: AGHT+IFj/VgichxhZcMpBsWjjQH/fXnJZmoFWuiBqRRCb03I3TatyNrwMXvJOel8ntBV7kxrb19iHg==
X-Received: by 2002:a05:600c:3b22:b0:46e:4704:b01e with SMTP id 5b1f17b1804b1-471178767f4mr217338495e9.8.1761308856144;
        Fri, 24 Oct 2025 05:27:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298d4a49ffsm5239325f8f.13.2025.10.24.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:27:35 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:27:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steffen Jaeckel <sjaeckel@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org, Greg Kroah-Hartman <gregkh@kernel.org>,
 anthony.l.nguyen@intel.com, Vitaly Lifshits <vitaly.lifshits@intel.com>,
 dima.ruinskiy@intel.com, Mikael Wessel <post@mikaelkw.online>, Mor
 Bar-Gabay <morx.bar.gabay@intel.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch
Subject: Re: CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
Message-ID: <20251024132734.30522c31@pumpkin>
In-Reply-To: <db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>
References: <2025100116-CVE-2025-39898-d844@gregkh>
	<db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 12:53:44 +0200
Steffen Jaeckel <sjaeckel@suse.de> wrote:

> Hi Greg,
> 
> On 2025-10-01 09:43, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > 
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > e1000e: fix heap overflow in e1000_set_eeprom
> > 
> > Fix a possible heap overflow in e1000_set_eeprom function by adding
> > input validation for the requested length of the change in the EEPROM.
> > In addition, change the variable type from int to size_t for better
> > code practices and rearrange declarations to RCT.
> > 
> > The Linux kernel CVE team has assigned CVE-2025-39898 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.4.299 with commit ea832ec0583e2398ea0c5ed8d902c923e16f53c4
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.10.243 with commit ce8829d3d44b8622741bccca9f4408bc3da30b2b
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.15.192 with commit 99a8772611e2d7ec318be7f0f072037914a1f509
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.1.151 with commit b48adcacc34fbbc49046a7ee8a97839bef369c85
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.6.105 with commit 50a84d5c814039ad2abe2748aec3e89324a548a7
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.12.46 with commit b370f7b1f470a8d5485cc1e40e8ff663bb55d712
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.16.6 with commit 0aec3211283482cfcdd606d1345e1f9acbcabd31
> > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.17 with commit 90fb7db49c6dbac961c6b8ebfd741141ffbc8545
> > 
> > [...]  
> 
> we believe that this CVE is invalid since the sole caller is 
> `net/ethtool/ioctl.c:ethtool_set_eeprom()`, which already does all the 
> necessary checks before invoking a driver specific implementation.

Nothing stops an attacker-written program doing the ioctl.

	David

> 
> 
> Cheers
> Steffen


