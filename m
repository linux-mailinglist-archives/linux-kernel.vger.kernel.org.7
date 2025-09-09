Return-Path: <linux-kernel+bounces-807879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FDB4AAB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE6416D3A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494A131A547;
	Tue,  9 Sep 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDKoU0tM"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B12264A3;
	Tue,  9 Sep 2025 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413828; cv=none; b=YBWvOB8Jk2jPn4LZmYn3MsenJT8oNgattJItOzAU6G0NDzP+iLtffju0mRPcZy4zVTEMxQ+uQMsrmrjd23/qzODzfZM5zwWLn6RHJfgjhVYN6HWyhWN/AaOBa0e63BsrM3x/MzNY0q89OAytO7YqtK5jUQ3nEH4INDrVO1I63sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413828; c=relaxed/simple;
	bh=BMhENPL1jxD1KN082klCCWEOig/QPZ0hZmqTzJVjyjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+O9afsRTezxMJaDQrMNwvX+ZD/WX9GsUucRvEb+MxfbkK9X3uzqzvZyysjFsHhbBVpFE/VsTr48cb0Jc7s23powlBioERZTsIiiUHm+qC8n2RGDynmu7qBuaBYUOXSNHC+5riA9CirKTCR9YoiDnvvkl9wAadLyOPbCDFV8WKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDKoU0tM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7741991159bso4840879b3a.0;
        Tue, 09 Sep 2025 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757413826; x=1758018626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLB/cJ3kKLYD3vHSpK6Et5rrL3DyKrjgi7YgZ1Qd/2w=;
        b=BDKoU0tMx1Z29mFfQnt9EJWQj9y0a7cJ9KOvbqhZ9rq8Q2EXCCHLyHBxAYw55otBQd
         mC23eem3CtLl9JHHnOwoSVerN47X7wOxjR33+YYoMFqvDa4ZxuRfUElCVqr6Xz1pT+pY
         37S7UdgVdhE4iv8XKhbbQm1Du79mE4RbBJBm84syWKC4NN4srMASChQ5jBJ0CQNMAd+e
         f0B3NVAjM4ceKcGdIUfSmaC7MOPoeJpKd8h8KO+1jCLqGIducfynJ4An8Uo80t4+P64v
         gVdRTB+HqJ9Jv/WC5UDLyco7QlIN+FaPJyjItBnDBqBOPpUeNyiBbtZb31VOuYXy9woM
         Y8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413826; x=1758018626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLB/cJ3kKLYD3vHSpK6Et5rrL3DyKrjgi7YgZ1Qd/2w=;
        b=IbruuwBFnMhLla9k4PKU5AO1Ywj4CgCJOVLwus0yVUuyIboQ0gBs/F4lI/d8wVB+Hi
         wQ2hU4QaQn0BAHHWykWXk3mNeSvxBitHNy5LyzJdHLwDSRJpg6BZLwlUxryubzZBH8I+
         pYA6gNu+yoVTWNcQviMOxw4RnmLFxmmOXA8Mm8zp9hGU2Ma8FFMRkrv0TT7SPus4rHIN
         9HN+1kA4oqP2OEDSi7jEWxEvRcqUPEJNENV8LPDDuuBdoIo5fS8n/pOwEW4QPQfVFcMI
         DFTO/FWuR2nn9oCK9xLOUi3OswnzqZCsP0Kh5pUSalQbFQrtfWXG67sn3WU3XTUIlRur
         JKOg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5lwUP9m/j8EY8hHvUy2InhUqVezZeqmV67oJeiJUnEGZpYTvDy9qIN9X3hkbQZ/gnPySOa5PJHzbcPIq@vger.kernel.org, AJvYcCWlxK/o7/aCPfpDKmk3dV7zZ2qHgPDig6scGh6GOcqWi9D06+oBdtT91LzF1mEfbWVImt1t5aZ5+XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6rRyZ4iWXLGP6Yb4KI4Sj5HB4YWP9hcMLiRNtd/zRwn5RaM0
	JLkhtjA/gqA8y7IBbmwnyzK69yHvuOXvotgJpNnz/y1LYu3GU/WjXE7f
X-Gm-Gg: ASbGncuiwPcQWjzdj4RNzrxgNEIupcXtsV2ytD12ruUUGwFtJp71U5I+K4ZXbo+/kMF
	4DWbkAPhKqY9DsDF6bgGWWuKZ0fbcUx6boq+17tLK/+IcmdV+zJCwVVJNLkC+HwmR+KBMYaguUP
	SEsmvlB4moElfmbr1RAPliAFrh3v6iVb6NEsG0N1jt8v0OzfuXysjf9WQkmqe27m9/3fMjwtEnd
	uKLrIZobQHTzWusen7ZEmgPwtV9/WgMSB3bniFSmO14j8l6+hRlDQk/JT+l1NYnIiey4YXBhYQv
	AJ9RePee5GI3nhLCSYbqoJJUzbDnqhEXbPXVMeQTkFkrltCIKfDRKYeEBdpRM18CoHeVZAvkA6L
	hBXKZcGFYFj4nLHxCCAzqhZYskxV2EDZQFgilJraNBlkBaX9R9vrwpDDTM0aX6bgHZW/IEg3CKI
	dDFYE=
X-Google-Smtp-Source: AGHT+IGI7uCKWs3EfQcckiznMoygIcQL4xLzIZOcoI5BfpZKOvOUX6YYCZGorVaaKRBIATjv0pb7TA==
X-Received: by 2002:a05:6a00:9283:b0:772:63ba:138 with SMTP id d2e1a72fcca58-7742dea5457mr14991621b3a.21.1757413826212;
        Tue, 09 Sep 2025 03:30:26 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628fb5bsm1672759b3a.48.2025.09.09.03.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:30:25 -0700 (PDT)
Message-ID: <3af7a4d0-3587-4374-8087-4ad037e8c5f1@gmail.com>
Date: Tue, 9 Sep 2025 19:30:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] docs: ja_JP: SubmittingPatches: describe the 'Fixes:'
 tag (12-char SHA-1 + pretty example)
To: Akiyoshi Kurita <weibu@redadmin.org>, linux-doc@vger.kernel.org
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org
References: <20250909022502.119560-1-weibu@redadmin.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250909022502.119560-1-weibu@redadmin.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue,  9 Sep 2025 11:25:02 +0900, Akiyoshi Kurita wrote:
> Add a Japanese section describing the Fixes: tag, use a consistent
> 12-character SHA-1 in the example, and include the pretty-format
> snippet to generate a Fixes: line with git log/show.
> No functional changes.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> 
> ---
> v4:
>   - Fix unnatural Japanese wording in the new Fixes: section for clarity.
>   - No content change, only Japanese expression improved.
>   - v4 fully replaces v3 (not incremental).

Sorry, but this is wrong. I needed to apply v4 on top of v3.

It is contributor's responsibility to make reviewers life easier,
Please be careful.

I think you need to understand Linux kernel's patch submission
conventions before starting sending patches.

Of course, submitting-patches.rst (or ja_JP's SubmittingPatches) should
be a good starting point for learning the process.  

Probably, it would be better for you to send your WIP patches privately
(meaning without CCs) to me.  Not necessarily in English.

Regards,
Akira


