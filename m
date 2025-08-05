Return-Path: <linux-kernel+bounces-756981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B1B1BBBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C201F1899E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2446924DCEC;
	Tue,  5 Aug 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XXw3OkBW"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924C221FBF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429165; cv=none; b=PiuuRZ+dfXT0tm38n/BgKiA1UWj51xuUCed3zbtJR1fNfqzmtdI2xjp5sDbklje5we1VvHfWjsuXXFyKtIHDDKG47nohYqsWyBKmL5885BC2CVyPcBPWQWXwHECFmAAqfeCwJA+S7TF+uv7AN5v7PWQFbcm3SwMhMpUgJplbuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429165; c=relaxed/simple;
	bh=YB+2P5AcS1SI/00X55KGRmvhjeXiZYqMsJERFTl1NKY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RuRwMVxqfnhoAMAiVDmCIjCWm+MEyOWhBGULzzjaMgpAt1U5Oq1fHIWuKA5RjQ8yvG7Rcis0Q7RwzE9vvqJRKQMrzyYUktfQ2niDXv+cdOr1Lzk+PQDqOMkmrc4H8wlWKmINE5GreFo2VFiTAn668Q+RSRwi3iDvOTNo5Je9KQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XXw3OkBW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e346ab52e9so731199385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754429163; x=1755033963; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvbhiDyr0vZog6UZjo4g7YPHdrZhoNzEXy2ckC2C0/4=;
        b=XXw3OkBWa9OH7j3/5MXXP+2m1tGf1HRjJzy94vAPJfJbyLUkJUEBpx4eP4RsMB0jnG
         /9/POXF+UrwkVrlTLOi6JsqShXf/Eu03PlKfZtFrJIbwyUfJrMacSNtvM1AM/PeIcW+7
         0BF+uWHeUd9JorBZpbuPoIJaV93mg5dHP17ghqti1hSuzy5WSM6b+l1Ru4Xi9bTrtlSo
         hXtFCzI7EGOUJO3wOQ5UefJzLk/DzPWElbTFlrXYCAr6ifyc+g2ZgmnFmGUnhdnifokD
         wjBbdLyUrj6+IfLuDoZN0phO0J1NoSaBQ7j6QKdnZBa0nP4sU3GY0oB1Q2mnhpt7bdjC
         G9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754429163; x=1755033963;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qvbhiDyr0vZog6UZjo4g7YPHdrZhoNzEXy2ckC2C0/4=;
        b=Pe1MEJiIX3jgz8B7SgOt7zIGfH4g+IHJhXsPyAd87021t6UdOQRYiEvEt+Wrw1Veq2
         ObPgv5wup9wvf8yIpJtrBG66EU7ZH2igrmzQG2OPiA8xw9qvC2mRDJ7qdZ1xNchRvXDQ
         Ivc8SWqmgq1etf7yMeP5h6rZB9XrDdcXGEjROUMCIUEl5KEAHvU41GWVVDVoERYIecCA
         xwXjfsbkLuPD/gsLkYJMYY4ZbvH+HctsDJz3jyRHf2qtV2n1sJI6BZ1/UVbgm7Bv8xWp
         A70sCR/fUTP99JqJACTuptT8LCdtv1HDZwoY+7D7F+feRJtipj2q4Kyr1XKDH76pN/rF
         NRgg==
X-Forwarded-Encrypted: i=1; AJvYcCUcGHD4A/Iq65R1xBXFLmubFSE0gqJOOzRccNLh4XWs9zWOrKC96JHbk2GwVo1mswlh5mpgGA40p8GZ/VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQd6VLOa80ffQSoBF9Qud/ealhHfaV7IkOh2oHs8CGXUm/2nJ7
	9QpENg1F4egWQOM7ibZk1peFCYvaEESRpxq0WYUAiRfQC+JHVlIx2OKOQTR8n1Gqqw==
X-Gm-Gg: ASbGncuPzfipsgdtiBQbJM5VcNjA8PrYMXZKlrl8ZmX5mDxIXQu5sI/piDFdPatb785
	e+Lrm+hh+eEZ3t86BRMnm/jA9d/hSLQRIWa1tElqXpnL9HJdKQ+hhE87m9v/OJFrr6zm8CLF5iJ
	ym2q52Kl+60g5UMGq5gnwKPDu7kCKk8QkqYQfkIHV99u8i5Pd0ru+0iou/MQsf5Wl3pyenMnIsi
	q1bITeVhjt0VV4rAcHiTlHEpM8vHCMT/PtcgbQxeiIkfvl45cNmL3AlmYWLKk+H4jlAWuH7d/hw
	W8GSULY5zRxDGKCt0J7l24VwqQbQKSjkFE94opbgrbTHLeCpaAXawRQOuAEtvMGUmmj89c3dHTK
	c3goSwoQL8RmYgLKyDZKz/rOVPyLfsYzEwere9zPWheas1t2NLkehG83z+vNgNv0T744=
X-Google-Smtp-Source: AGHT+IFOIToWsJNGaGahUbxiQZZEXvXgB0PL58qiQxs52JuvL3CY5dR7fiVz32RjfQYdXWbtvYoPsg==
X-Received: by 2002:a05:620a:440c:b0:7e3:16b7:bf26 with SMTP id af79cd13be357-7e814d067cfmr123967085a.4.1754429162986;
        Tue, 05 Aug 2025 14:26:02 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f72f75asm729478885a.59.2025.08.05.14.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:26:02 -0700 (PDT)
Date: Tue, 05 Aug 2025 17:26:01 -0400
Message-ID: <f68d69329455b0cd7e69233547a78a8a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250805_1541/pstg-lib:20250804_1752/pstg-pwork:20250805_1541
From: Paul Moore <paul@paul-moore.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH] selinux: use a consistent method to get full socket from  skb
References: <20250729091044.95411-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20250729091044.95411-1-tianjia.zhang@linux.alibaba.com>

On Jul 29, 2025 Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
> 
> In order to maintain code consistency and readability,
> skb_to_full_sk() is used to get full socket from skb.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/dev-staging with plans to move it to selinux/dev
once the merge window closes.

--
paul-moore.com

