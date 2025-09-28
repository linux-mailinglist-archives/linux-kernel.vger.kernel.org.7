Return-Path: <linux-kernel+bounces-835477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A7BA73F8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD19189667E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC3417597;
	Sun, 28 Sep 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4VmBkvu"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCF21FF26
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759073178; cv=none; b=IlgQgV81v/yvgXNsfoOUfbCyupiiNiuvrxNKQb31bdj1KwXrLZbtKGWfdARk4hGRRU7l1jqRYXhIQM7sJkhdZKfR1DdNwMEkKI9Bowga9N76WcQS0nmPI4XLhWhteZ192UwbtOcFK88yxd8tWRVQEjJpgjS9rj++M1nhLYfoqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759073178; c=relaxed/simple;
	bh=1ERQlFtiwev+93nGlX8WZAk0e2Z6jhL93QCIb0AGxZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gw6c4Qatek+3AFKSVMweVcJlxg1On8EjWZPzQTeikq1SmlwcwNEA1jDztOT884nMEPAbvKkfmWfVvllRZegqVDWe/oYU+x04FkyJaL73EU//gW0vBJeTcb3ZtiJdcjau56nEEPW4/Bml1qHoHOgpEg0E7/epw4NvccLmnarSwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4VmBkvu; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5a6743cdaa0so1824736137.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759073175; x=1759677975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5Alc4NB13gwKBoLXrQZ51wQV0kYW03eZU88Bc/twqo=;
        b=R4VmBkvuKK6VI/c9tGoDe7zFR1GMnYW6wjVO1CF4PYhUIeL67qj70mgu+kiRrwn6hL
         B8H5ToL1Yn6/61fEnV3kbsDC5YyxPQf6wR8ooUretCPS72w/B9WY8pnNm2vBoJrgQl+L
         cM1QCkfHpcAQoKoi9qeW3GzouywUyRXLWjkDfB2UK69Oe8wp9YSLPO+/LFubzbVd2gvT
         VvA2qJdRRmwsNzwkbQ3JtFdFccIWRR684d3/+UsYm/0Gcxk/eYqCTcgpwDEwiU4d7Kyr
         hjg6lM2/AkgW6XL7E/E6y6lTbmjZubzoWgTFl88or5UMv1gSOHtxtmwtD2s6OxlGFCrN
         00WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759073175; x=1759677975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5Alc4NB13gwKBoLXrQZ51wQV0kYW03eZU88Bc/twqo=;
        b=RZ5vzPSNV5L2EfLou7FF5JNGip7aMqpJ/io8C8eP6h3yJJHnqLspKfJ14mzxq7G6/+
         V0F2zKD0GELbTQ3x+G31lNH0c6h1xDS9yNjl1YaVdernus02FwRPC5GbGKszfN4oBeDZ
         ShBXn1SqCSZUQIN6TpoHeXh+hKH2JkLakZ4LqWv3o/T/Li6Ir9EMz+0YHgN4bdqR04WR
         9eAsM0dDf8KtPYGcWQFkY3cOWre7VxPbeeGkmrLRrlc98Jlrv4Hh8lvX8GDh7JxGB20U
         +NVkLo8BfG8Y13mJPqIM9iyZenBom37H7VyGA8LVLdbWX2CWsifOPh7FQh/iBW1VVxua
         TNmg==
X-Forwarded-Encrypted: i=1; AJvYcCX7dJ35cBscLQToFbgZKCLyPtnDxrGVnmBEU+7FU/R2p1wj2UcuJ+MulYMQGHsf4GzFLejmSCZ2kZCx97U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyZduo/y03LtwkG5yCqQuvNGj6UdAP9hUkhGA268D5qKGyHMA
	pEsdMyVKQlCeewC/oo5GA/XXMTYJ49Rm0xHwaDAzfYIdwR3kMgoKeA4u
X-Gm-Gg: ASbGncuQzAHRcP4JPlApTrJp9ey57wXZNVUgw4eRA06dR/Kn7h5Bw1N58O1B1R6s2p+
	acSTfChsRG0Y7a4MP49SMKT6ULurpCPY4sZuwMwUJlMMyQqEw5IzPmz3qDPEZYvj/TghU3NMh+u
	eTfWJ4QdoEroZPyL/nBQX1pvYCdn8nVtXtn7T719j76+KWbxrGBIxItjmZDar3T5LWcHMdiZsrv
	Z7TTLjEmMGR3F3b6sUytGavmd2lzx2kIvj0Y4H2bNFz3qb3HvV3UhV0axL/ucXzJXSSeH2Svq3f
	AnyekvnmKFsCwS3/WFjVZT8Xfmvr1uO1dqiFsgJdnLNVm64iKN0YUF+dzs3q6HYLsGX/7EpL7cC
	lhkHOnbv1Xsk501bkRfD7Gnhk8a30VuavzkSqGY7KJ7sSz6mu/g==
X-Google-Smtp-Source: AGHT+IGjMAamUm1kSVRaAVKwnIW0mikD0OoWVZOWVPr5K6MrIi8U/5ZZFDgThH3u0kobgv3zD5x7Mg==
X-Received: by 2002:a05:6102:94f:b0:523:4360:2b86 with SMTP id ada2fe7eead31-5acd046d79bmr5906381137.31.1759073175125;
        Sun, 28 Sep 2025 08:26:15 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54beddbb84bsm2008261e0c.21.2025.09.28.08.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 08:26:14 -0700 (PDT)
Message-ID: <03cfb82c-5502-4c0f-aaa9-05c4d1a4ae80@gmail.com>
Date: Sun, 28 Sep 2025 11:26:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
To: Deepak Sharma <deepak.sharma.472935@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 pwn9uin@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
 syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
References: <20250925204028.232320-1-deepak.sharma.472935@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20250925204028.232320-1-deepak.sharma.472935@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 16:40, Deepak Sharma wrote:

> 
> Do a `timer_delete` before returning from the `alloc_mpc` failure
> 

Was this code tested?


