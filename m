Return-Path: <linux-kernel+bounces-821801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75134B8251F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FC44A5C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1426329515;
	Wed, 17 Sep 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPEZHvck"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8513112B4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758152605; cv=none; b=KocIbY6/Vjydp5zf7hPRo7s6ctUgMQ+mx74TJgmaWxu1MOxHduc/QCxq26YgsWNyckpTVAY4T89iZIjik/CY7OdlPcRIjHmDHuEgH6opHkwpTPrX9ioyi1FIWTYcQkjyNUKrZYRlCGBcaqNX+ynh/CFnSsIfBj5K9IMGUCX8DuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758152605; c=relaxed/simple;
	bh=jSeTN6nzIsbHOgx4OEw1vk2exHEt/XFJjBSNPI8dLAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0S7wP9KJtMdfGEKOEo55J68Ssue/Ftq2fDKdPc2m6r1785OBgFx+xmaAqxQDMy92g2pKxyXAnGDmR5Xqk8jOIo6M9YvI3tKRiZVdkHpDHPr0YRb20bDtNK4yrpqczXQrvoljlbRIlT9s6yZLWqU2QIb/ND5mdvsajKezNAGtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPEZHvck; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-268107d8662so3341875ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758152603; x=1758757403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K22AcgH6usYW+3VD2+AXa1QNrSpq3eTK8kK1qqAVf7M=;
        b=JPEZHvckUWuBjK5xQUF30TCZcTMkbFIsouJL3gLtw3ihH4QOofVytEnwF7byG4Ip3b
         eI1QVWhSh8KsKGsr3ZzQEwRW/pfbo6yeySwhIFexwxAUoFw/+rqByvYvDIVQh8ZEG6Gc
         Jaw563dAbOlyXeGSk7s6qMDJCwrBvjRjbadfbyuGBbg1+LVPh6oIR/0jTCKADa0/+QQR
         mYMYOM2Z84vh9sZB74KE709MDpJB8DPC/QGxyAjWLlLZue1eX5a8d2FPdDitVO//PQ6W
         MHbj19bKvaT1Evuco2eukLhOq8KRi3dpxuZDT2+IBEfLg49j5h8lGRp16/tOAnVS9yMS
         Bk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758152603; x=1758757403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K22AcgH6usYW+3VD2+AXa1QNrSpq3eTK8kK1qqAVf7M=;
        b=AAOPJVqg/Cep/xEZCnSC6mKhQKkxCvxrQssG7MDugySCLrn3X2FFEBA7nISTNZJPqI
         Me1DDK4FR8brXO+LU0Xql2y5aLZYhOs18xZmx1+NqsF71/nW5p0Etr+nNY1H014Q79hg
         jj6KMGecEQwy5EdGXPBM+x4lf4J/CN+YC/Uf3Ab0nIPZXYfHV3YPTMhVjG0KgTHM4cai
         fCkCuQ+yLPqSTye1twxIuwnTgtXamiHdSfHXN1jP86VLZ0r3yGcTBCIq3IoJyFbdw/2J
         JS+xnOck4Wr/ZkhAD93eUCZT9fqQZqARgRZG/d0h/eek229xzx71TuwYH5BtfpXiSKic
         ViwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmyRXXwU0XQqDWLtoPFTrR5IU9+t/W44vCZawyYxkkSzn27yXO1c6WONY9W31//kNE2AM+UqQuKSAGwQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOJQNBjST3a1Nk324rdV5IFO1FXssbsaqUuJikmMWQT2flbFP
	zEO/dro1fNfnucwgMA3ui+B/A2ujsgfP6HxTYGeu3o8fdACMgf87l47w
X-Gm-Gg: ASbGncusR1DHSSPxqdVsWv9Mov6O2mY+mRMje6ko42q+IrfWOa6WAL6UO4hPSpG6l9f
	yN9BFn4cKb1mAw/ZDyJgKRhn1JWftJXb7GMmfdBHlmlc4Vw3KyLIqtaaIjKD3jIVhQnZ4pNd3bt
	Z71IIdTHdxiWj/+/kNHrzP9MNnVUJNu7Td2m9PCfLaUfwIwP7z5JgBSQddcxtSqCt0Se9aQ6KYF
	AS4jB2xuST3DcFEkluBJWSbQhakUeE3w6PHUX2k1GGxnFpn6UiulxyZAHP2uVpamQEp12VoZXRs
	Ex0eoBIeBCxZ1exz1lOEg2OLJJoyvCsW7BrPuSwWM0+gdH6WIurxKtVCZR8QMXe+WNSgF/vEfZS
	OGzxbL5XjlOQFOZyBH+Pv/oJfBEXqiqNXoz0DCMAW5YX2ZSh2/ddYn6cj/w1eSfsQ20qhqr6Vx9
	0FrY+Qf0IHoOM=
X-Google-Smtp-Source: AGHT+IHzJozMWX1UmUSatrcOmSTMgSl/UvNpJf40IXqO/pzHqyYyudqjzbklOROJsd9tAclA1s1m0A==
X-Received: by 2002:a17:902:f792:b0:264:4e4a:904a with SMTP id d9443c01a7336-26813cfeb3fmr47054915ad.53.1758152602908;
        Wed, 17 Sep 2025 16:43:22 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980310e41sm6653385ad.108.2025.09.17.16.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 16:43:22 -0700 (PDT)
Message-ID: <ed4eeee3-4e95-4bf4-b19f-cf7d38d8a1ea@gmail.com>
Date: Thu, 18 Sep 2025 08:43:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/21] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
To: Jonathan Corbet <corbet@lwn.net>, mchehab+huawei@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <4d4dc78a4e29f2478fd1c1a746378dc61a090ca3.1758018030.git.mchehab+huawei@kernel.org>
 <1d454604-288d-4185-8567-836e06b3cbea@gmail.com>
 <875xdhazcq.fsf@trenco.lwn.net>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <875xdhazcq.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jon,

Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Wait!  In the cover-letter, you said:
>>
>>     It should be noticed that it is out of the scope of this series
>>     to change the implementation. Surely the process can be improved,
>>     but first let's consolidate and document everything on a single
>>     place.
>>
>> Removing current restriction on SPHINXDIRS does look inconsistent with
>> your own words to me.
>>
>> So, I guess I have to NAK 06/21 as well.
> 
> Is there an actual problem with this change that we need to know about?
> I am not quite understanding the objection here.

As Mauro has pointed out, and as I could not apply v6 series, I failed
to look at the whole patch.

My knee jerk reaction came from the fact that, for example,

    make SPHINXDIRS=translations/zh_CN pdfdocs

won't build.  This is because I didn't know such a sub-directory is
allowed (despite what "make dochelp" says) in SPHINXDIRS.

At the time I made "improvements in CJK font configs", I embedded
hacky ".. raw:: latex     \kerneldocCJKoff" and others in:

     Documentations/index.rst
                   /*/index.rst

, assuming all of those latex macros would appear in translations.tex
in the right order.

I admit it was not ideal, but I could not, and still can not, come up
with a more robust approach.

Hopefully, this explains enough for you.

Regards,
Akira


