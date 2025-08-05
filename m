Return-Path: <linux-kernel+bounces-756681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9DEB1B7B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2A718A5650
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CCD279DAD;
	Tue,  5 Aug 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yy07/7iv"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692291DE2C2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408269; cv=none; b=prhcH9FsQn70fi8YY+TvUq7gzZ1SA5z2rmCP1DseAmjAflGXl7rkQ5MRfrr3y1kKyB9qyV+Iktrki7ZNEr10MBTPNXz25rOWhDE0+4SFw3emMLYFPuPVOi8o/1RvbVcefbLpmRV03vk2abTso2qX3gT6w0BE6RFaLgCItrG8F00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408269; c=relaxed/simple;
	bh=8b3r82mCrVkXVOkxHyvPWTaQtOq7d/lEZRMHoIM7T5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STKTQEc66B903ykrcA4lcd6Rs2t5+zGnoUpuXBPgtaGIabhO1g2tAQflo/GT73ws9JD/n2ur3isb6mh8ToGKDoewmrjZA1zIojP7mNFtYf0aFSIqQEcvTIERLMmOvApMCIuSdztLqoIW/ilEKg2d9DMPnNDJYAOFLfv6E/I2DBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yy07/7iv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b427f4a9652so140882a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754408266; x=1755013066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47A3S9FnGtkQV47KZ1o1yY1stYF6mjY7RIPXGnIszns=;
        b=yy07/7iv9ZOOjqnlqKd/RUP9qexNGKlsWpAVphKrj+Dy82uQnt3yJeqq4pTxsHzA59
         eXmorgSIPc49coVurZkw5QWsxN8m4DStxzfmV3bkDlUnBRXLyuG1r87VJ1tlibCwUU2p
         mx6QrXn7SqVYs1tGxYB/NEzI+t4q45Mki0BM/hZY5nC99GDv+4H1lA1CQqWmggynbQZQ
         TwiKHzAbzS6npkkN6sOIKBrd6TUgqbfloNBttw+EWPWgbd8NEocLKAQ97m127V7/yiZD
         xA9/J9sdCrBoUMIZygb63vOQV5c/nqATSPNFNUvhYkcCEcv5E7uSFwYzWlD29LdY41V3
         j/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408266; x=1755013066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47A3S9FnGtkQV47KZ1o1yY1stYF6mjY7RIPXGnIszns=;
        b=vTCzZhihO+jyurDsjTnUdp9EElmfwku8JQek8L4/piujkQ6l+Oz6jNcpn12PcmWzBV
         0tRO+TcsqoGiVmYDkWqVDPqQRsN5xqcksHobwMxTXghzXbYL527OFrVBAfyadYupZXky
         Xs1jFNoV1wpBNl2DfOr7ygB+/daqzt5VWrVXcByA+t98O0YJAE1OMxqN0GRX/Md3Pw+w
         vnU7/strzwKiYd9yRyeTbGWMnQXWgG95xhtOiioocypi0xhzPqdyAuOIT0WgTfJAEsVn
         0rOsIUvcwo8SjZRlspssqMxgfbOarTrDBRYjMQHYZFLHqrJ9B17cyQM7R4Rk/66WzcHE
         0EIg==
X-Forwarded-Encrypted: i=1; AJvYcCUbbqer04eRX/BI/LMxqP3BG08uehKLzUIpywe+9Xh9yYLvjuC8NngrnCtx/qVea66XlP7nml/ileY3tHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLpDVGYo6LJDLfnK2Oo2KXryqxoYfIrjwV/xH10AnJUENLT/Vh
	A+tSK/mXy8KHKVDB2WEqYjewKB+4320a+rYiK7XSZRz56sT/zLKnd1is88yes6SgEc/i9BhGS+o
	uBL7V
X-Gm-Gg: ASbGnctMD+20zXEVuX1ir1VzVQE1gpLNveejnSFlSTkNsUMXAEPGXDqfGYj1Czftt/2
	o2/y7+kgNU6l+MaCirMemuX5w47daziTLi+H4f+LjtLkARLt3cOuEPthzTGM1yWCAn3UM3OmaR6
	vshsxwmnTSZG13mcy13ruLSoycJgcz240LvNiX1+S/zhB/8UeJwOIWdbIDwM3j0jD0exr5BjBle
	qTWszViiu7eMD/azHvSTLIUrCSwMorwKiqihbn35mQ5GmKeZkbK4NsuiXrJLbqWnxjnJ6Tb+0Is
	tLJaYlQfnkqLzAEwQ7KIb+GUBDr6+PwWuH2SYUK4aHoSXQEHogo+gbTaoQA0jAkURAICSRmSwjM
	JLhixd87Qsbd4XoOpwyAs
X-Google-Smtp-Source: AGHT+IFbGSolRCLm47b3U3xA+x+p+1MYURYNlUpeNbBwyIHwxQaPUJLM1WRayP7DldFQq37IC2UIEg==
X-Received: by 2002:a17:903:2446:b0:240:2e99:906c with SMTP id d9443c01a7336-24246f6b703mr201065385ad.15.1754408266480;
        Tue, 05 Aug 2025 08:37:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm135152195ad.69.2025.08.05.08.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:37:45 -0700 (PDT)
Message-ID: <587aaee2-8d84-4eb5-9b87-22947abd0752@kernel.dk>
Date: Tue, 5 Aug 2025 09:37:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: fix to return -EOPNOTSUPP for uncached write
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Qi Han <hanqi@vivo.com>
References: <20250805061914.3067747-1-chao@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250805061914.3067747-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 12:19 AM, Chao Yu wrote:
> f2fs doesn't support uncached write yet, for write() w/ IOCB_DONTCACHE
> flag, let's return -EOPNOTSUPP instead of ignoring IOCB_DONTCACHE flag
> and write w/o uncached IO.

Didn't we agree that write support should be pursued first before
bifurcating the read/write DONTCACHE support?

-- 
Jens Axboe

