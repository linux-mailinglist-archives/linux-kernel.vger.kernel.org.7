Return-Path: <linux-kernel+bounces-867863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFC0C03AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D5D3B6CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CDE2BE03D;
	Thu, 23 Oct 2025 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U/iirpGJ"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F529993D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761258272; cv=none; b=aDGITqB3k10+v733m/aMMnI/4R8Vaee6Pj5n4wcqlVs/cGXC0sW6QBwuHyw7NiGF2tMQG0q9l38mNR/gcFKXZuoUNFLprGKw9okn6/5uE/rxICpxNpHGPrPqVc17uVeYARAAFsaxlm5qpc7csiq8xAsq/TgyQFUAd5K0T/qFXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761258272; c=relaxed/simple;
	bh=v/l7SPMG23kk+Ts04TGLZFyi019MvHES/jNfDQwR7TI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=l8XrEYrO+I9Ut3xiJh1tCEWJMAxJoTqi1sUAKzk+4ymeCoXJvO089jJRHs+urK/xatgplYP5DHfrJW++13mSBYtYL7V9DeAD6tEFO7sebKw2dAk7u34aCBwh1edh6bMQJ4hoTikWaSiQWMTm/TCD8nD2j7m40lYsQ4ZOD53OEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U/iirpGJ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7ea50f94045so26029476d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761258270; x=1761863070; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsVU516gxnm37ZNKMKmffKd6VUi6tTnfSbRILvG3sIk=;
        b=U/iirpGJmE6W5KsMRb4QREKaT4HAncd6L0lq2KY/57z4bg9wRZagRPizWyfIaQerW5
         fbh5mulL+k+JCJcIqbQaFEx/wdYvRmUkrYb9unZfsFVNFJZXfUi0qHR3QQzCpaejmI38
         96eEWdLDTaon37ZVW0w+WsNkgzpRBTWrnw3N2qlNoC/E6Io4hmmAsA9whMYBoNKtZpQh
         ZOEbHlJCJ6AJOXdnHLXgZYXEwS1dolnQeQeWKAI13K575se/qub4b6gvq6FzHQMOLEex
         R8uuCz1poaWmtp1SkIU9yEQ/ekyke+02E5nORY5rIM2t/6QhXCsFH07Jj2RYgBXD53/f
         c/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761258270; x=1761863070;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wsVU516gxnm37ZNKMKmffKd6VUi6tTnfSbRILvG3sIk=;
        b=WxJo3A+Z9FVf9ktsj7ajoLRlhJFX7O8y+pnYY3d/Cuj7qulEBK+wEPVdspIsZxV/xf
         rWcgAvPw/gomTxzOTExsX5pe30cogLM8mrHLJmfee9qdeigsoKHUdecJxdhjwJEGKpQs
         3VZmNaN6sZLcUesZ1v11kAeVQF9fSab0ordPTZ+YFUzTMImSWgNuP9UbWZtq+EICI3PP
         KhNKTpcYPltEr8qiZrBioCFGxUALQIOKAbbu7EaoyWr1QGqO3sVauukOs+oPCti1+ntH
         rZGmbiRmUFIyIoNRN4OTP47pRF6WL2yS1hblByftPONOW/afvpEONxHarxGlX4Tr9C6J
         JWgg==
X-Gm-Message-State: AOJu0YzHb4YG2SScO9WUxR9WOHrMAFWbiJzA8BOdL6BJHamo4pI4aIbO
	ce7qXD87GwzE6lNqSNoRfbKWSakEe3ktv6wg2VfQVjvnix2U497ycOtg5CcJz8FtqQhgXMAxKYA
	48xMSEg==
X-Gm-Gg: ASbGncuXCJ1VZkaOAIQFi2JVvKPwo6y8R+Qpk/OO/BLwlfam57FDyIj07vqGjyhmqvF
	p4E88o9eMmRSzxzP6s5nLI7tLRaHKzZMyqWsO2DD4RNwbZvsgV0D406CZNqDliHRo5labeZj/Gd
	UUKPnDWSIOyVA7etSbwxxhFm4u3Nij0DflEF+0OnzuWT/cGGA960uJrJWsRjPzhO2MR3WCMvoF9
	wLiXw6YpOc7kLQNyiugdVjK6iw8+fLbUqPhJulka5Hw0lX9KGECJ226HTh/j2btpwPHZwnJJgXm
	wo5bGFSlZ++vSsXXM+e8BTevmlOrw9MVArLklwzGJsyCbFSgVsyYnFnqETuom7Fw4DNd5EyI+9G
	ASw4NQUm6rkEHoiDEaXJaYieBH0hHPv58EAygNpLG+f6LXrrXyb2ukOE27XdnC6Ev+Urb/oC94Q
	wH8bs9JVMod2YyW/Ib4Ur17BKPICxY4QBQo8a3fmSmvL+iDsKf430/eDMM
X-Google-Smtp-Source: AGHT+IESwU+mjviQXWL75zoMQF1m617JcPvBrAhyZkS6egkpwvtfTvo8InxvAPzKXkvegNlVe4dYzg==
X-Received: by 2002:a05:6214:5298:b0:788:82e0:3a9 with SMTP id 6a1803df08f44-87fb40e8913mr5630766d6.21.1761258269638;
        Thu, 23 Oct 2025 15:24:29 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e7f52e1sm22984526d6.51.2025.10.23.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 15:24:28 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:24:27 -0400
Message-ID: <5fa2cff3acf5ae62cb76f157fb36b7a8@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251022_1923/pstg-lib:20251023_1801/pstg-pwork:20251022_1923
From: Paul Moore <paul@paul-moore.com>
To: Hongru Zhang <zhanghongru06@gmail.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Subject: Re: [PATCH v4 3/3] selinux: improve bucket distribution uniformity of  avc_hash()
References: <4bf4246da1ad44670093e006bffd3c9e07f089ea.1761217900.git.zhanghongru@xiaomi.com>
In-Reply-To: <4bf4246da1ad44670093e006bffd3c9e07f089ea.1761217900.git.zhanghongru@xiaomi.com>

On Oct 23, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> 
> Reuse the already implemented MurmurHash3 algorithm. Under heavy stress
> testing (on an 8-core system sustaining over 50,000 authentication events
> per second), sample once per second and take the mean of 1800 samples:
> 
> 1. Bucket utilization rate and length of longest chain
> +--------------------------+-----------------------------------------+
> |                          | bucket utilization rate / longest chain |
> |                          +--------------------+--------------------+
> |                          |      no-patch      |     with-patch     |
> +--------------------------+--------------------+--------------------+
> |  512 nodes,  512 buckets |      52.5%/7.5     |     60.2%/5.7      |
> +--------------------------+--------------------+--------------------+
> | 1024 nodes,  512 buckets |      68.9%/12.1    |     80.2%/9.7      |
> +--------------------------+--------------------+--------------------+
> | 2048 nodes,  512 buckets |      83.7%/19.4    |     93.4%/16.3     |
> +--------------------------+--------------------+--------------------+
> | 8192 nodes, 8192 buckets |      49.5%/11.4    |     60.3%/7.4      |
> +--------------------------+--------------------+--------------------+
> 
> 2. avc_search_node latency (total latency of hash operation and table
> lookup)
> +--------------------------+-----------------------------------------+
> |                          |   latency of function avc_search_node   |
> |                          +--------------------+--------------------+
> |                          |      no-patch      |     with-patch     |
> +--------------------------+--------------------+--------------------+
> |  512 nodes,  512 buckets |        87ns        |        84ns        |
> +--------------------------+--------------------+--------------------+
> | 1024 nodes,  512 buckets |        97ns        |        96ns        |
> +--------------------------+--------------------+--------------------+
> | 2048 nodes,  512 buckets |       118ns        |       113ns        |
> +--------------------------+--------------------+--------------------+
> | 8192 nodes, 8192 buckets |       106ns        |        99ns        |
> +--------------------------+--------------------+--------------------+
> 
> Although MurmurHash3 has higher overhead than the bitwise operations in
> the original algorithm, the data shows that the MurmurHash3 achieves
> better distribution, reducing average lookup time. Consequently, the
> total latency of hashing and table lookup is lower than before.
> 
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> ---
>  security/selinux/avc.c          |  3 ++-
>  security/selinux/include/hash.h | 11 ++++++-----
>  security/selinux/ss/avtab.c     |  6 ++++++
>  3 files changed, 14 insertions(+), 6 deletions(-)

Merged into selinux/dev, thanks!

--
paul-moore.com

