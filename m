Return-Path: <linux-kernel+bounces-867641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 370C9C032CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 114654E957E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8434CFD1;
	Thu, 23 Oct 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="D+qluMMK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D426FDB2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247566; cv=none; b=lx4lWXAef/EeRB9rAlgLYO53p682VMWCVBPQalN6FCKxW8QnTL24XZm0R8xqxa2klbmMDiJlLXdmgf2bXacftFOUL5ysAl9qndQvDv1XyRlFokVFIsouGv4d20SLr0VNn9vuIbLjyDfFKeXrsIyRFIfO3Oi6Ufc0mg86807QXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247566; c=relaxed/simple;
	bh=gsdXdphU+pd3mO185vE3wFHRLU1KQJKNhspN4mK5pYY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=l0F60DGdxQg9G9N9DFHT6Hglr5Hpx97/KlQcW1vG3o+fbLI/S6NWIMDEtU5JTMtCYf274dnGZ85aNxNq+nT/vo41PF41IRrMBaWNmLtK6fiQFc9qXAx5OerVxtqEAjRHp48TEpPXzEVeXB4kVgbp9SoJvIAKNQ4n6guJD2PmqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=D+qluMMK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47103b6058fso8894055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1761247563; x=1761852363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gsdXdphU+pd3mO185vE3wFHRLU1KQJKNhspN4mK5pYY=;
        b=D+qluMMKR04UxAtQF5fbjKH4hQbujEV0fBmH8dxtYyt99chpeZN6ZggU2cYrEVc9s4
         E+WDWitl58YvZ0zgQtKjAc94BaV0aHajo+sc3gc+K3E0K+q1eOlWN2spPg9GOMvPbsS4
         tIaLSvw6+FDQ3qnDwZ0yXhLEZLa4Sdyj77HZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247563; x=1761852363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsdXdphU+pd3mO185vE3wFHRLU1KQJKNhspN4mK5pYY=;
        b=R0y33ciuNxZiYIvX0KV+YYFrnUmmqmT1jBAL0Thxb4mIDMbvSIhzO0DeIk8QsrW7yI
         cQ39Rqsl7WRzYuQyWcF6DA4HpX4jnv3xbvlk0XrhtD1pwF6GwghjmaxpVjk80cTV+vjB
         +gbaPtLmflvJFJ+hDGIK3PIbXgNf1BQ+yPjb5i38nq58lxbRBWD5BB9yAkeUbewFGOq+
         dlws3KHsU7h7Xhk6uw4r5eP+goR97TS2+G5tSrlOWqjMUPAjjk62plZuLYCWAhkCrwK1
         i2u4xqIkphrYRsn3MMx7K61LZUXGh5AE7b5o0ddFQy5eXbJ41MQ1LwSikxyDOrPKq5qy
         XPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCNPCSaZsYVRPSxQ/kH6faDr0A1GtsiT0CKpVE7piZGsXOluMHomLpr80hU7xFC/KPG7SzMhhQfv5VFLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym+cMlty8nwBMk/9Oh3Ht35RjHrsmPaKvxYxRvFBMVcd3r9nsR
	5jOUrkqOZsvzvoj8HiqrKHIXHUNNAYUX60Hgr/OKt4cZNWGjh5Yg8LkSTJFn/KJU0gs=
X-Gm-Gg: ASbGncv1gsmayYVqUZYgWEOmoxfu8TH6wBn6HVhXFkPstW5l7F9O2RdebdhC6qBO7Qc
	jGo9/u1nlIqPuaD4ieyfdSPfgKJ6RdZte2/dKIbav1xWP/FwlZlf7nQ0VEmrKNxJzuv9V1DR3Xq
	z0i+B6bn9T2yXcZPI3rptf8O5npMWSQTDPviZN7pbCr+g5uBWFVurmKfbcCWT5F9btxeAJ7U4zl
	rx3+hqjC4lPpHAsshVY3FCJPVmy86Qj3dQMtmomF05CWUcTV/JH5AjFgPA5ITZt+4zyC606eVWh
	BISQ+dJ46n4HtTNZ2+h1nF7ghpnDlaVlMdxqg+tbMKUIXw5LePPjufy7++0eSBfazEGfXOLV2aw
	sPZFQYgZEfkMoviOl4P3QhNibgWz9IsJuFBE9dfWl1WNfKmmfXW8c3K35xatmq8ifQRniQjZZJg
	guOjBjnIasRS0Fcnu6gpEb9zxb7g3tUeICgk6NPy3nCw1vx1Bth6RG
X-Google-Smtp-Source: AGHT+IHA0gPZ+rfJjAnoRvkUeU+omIN/lB4hMnbBwFxbdv3dHrLCcxj7vrdhqpF3RCgXH5E6DSHZ3w==
X-Received: by 2002:a05:600c:c0d0:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-475d241a080mr154125e9.9.1761247563123;
        Thu, 23 Oct 2025 12:26:03 -0700 (PDT)
Received: from [192.168.1.32] (host-78-149-11-196.as13285.net. [78.149.11.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adc81sm5460505f8f.26.2025.10.23.12.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:26:02 -0700 (PDT)
Message-ID: <4214c886-6d2b-4e05-9201-11b4e9c88932@citrix.com>
Date: Thu, 23 Oct 2025 20:26:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: peterz@infradead.org
Cc: David.Kaplan@amd.com, boris.ostrovsky@oracle.com, bp@alien8.de,
 dave.hansen@linux.intel.com, graf@amazon.com, hpa@zytor.com,
 jpoimboe@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 pawan.kumar.gupta@linux.intel.com, tglx@linutronix.de, x86@kernel.org
References: <20251020150133.GK3245006@noisy.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20251020150133.GK3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> + /* + * For all other processors, there are quite a few ways to do
> this. + * IRET-to-self is nice because it works on every CPU, at any
> CPL + * (so it's compatible with paravirtualization), and it never
> exits + * to a hypervisor.

"Never" isn't correct.  "Typically doesn't" is better in this context.

On Intel, there's the NMI_WINDOW vmexit which generally occurs after the
IRET is complete.

On AMD, prior to current generation CPUs, there was no NMI virt support,
and intercepting IRET is how the hypervisor is forced to cope.  (The
intercept is Fault-like so happens before the IRET executes, and there
are a variety of increasingly terrible ways of trying to account for this.)

~Andrew

