Return-Path: <linux-kernel+bounces-895815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288CCC4EFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BF71889112
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B9036C5A1;
	Tue, 11 Nov 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dGEbh37L"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35CB36C59A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877993; cv=none; b=AY+mS0Vf3HwWO6rCs1ixIblTdS7LynKume95T4ZM+kjiiMks+vWJLZVMMHreO1qE1wmdb7xmj1X3iWPBbWoX6l3jZe6eFz91THRD3S6fzBLQNB7qIH7adW/hVZhZTG6bxIAarkcGmrpV0gJFY2UVreelEurKc42DYMa3Yy799Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877993; c=relaxed/simple;
	bh=Bc4SI9w8LgTzpLMjF+skEkrQD/NC/Se0GkBwuligeNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtQFP8iuHb9rdZ1QwDmTAt2EX2ekxAfxYKnRTGI5tXCrDJ7TCyEQ0yX3NUL/XUZtGGeAmt4Vf28pAmQ7XF8ph/opacNfppJLyYlwwMfId/Mu4HRZXbR/F8uMw3Pee8wCbwlFQzi6BF2NQLQ7Wqegt3eJ94Zp26PktYdFVXil1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dGEbh37L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477442b1de0so29458725e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762877989; x=1763482789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v95Lu9O+J54/kvSSdJJQyXoIt+hwqt0CDtnCjONZJ6s=;
        b=dGEbh37L4PrqMXbctH83QTLmZBRD9bYOYN+MyQ4OPvBaWCPR9eqgBCE8Dwin0CU+fj
         nHQr/1ms4cROE5d8WloGGM2PoLl7YeI5oXPSfakIbFoO+rpa9cSVzp28Qlp+gLGyJEO+
         HWyMwg3VXJ79//lrbUxLRKe9pIsAYogO34TceCTkuCNaIrQCUi8u+GcWh21dxh1sENfF
         CsNHCCbcVWJOQDIngh46AqNg3TYYTtoeoMgybD+09wdqgJeZmNZAIMybRUtpcboLdJra
         EciyUMdqfkg6TlkjyXnUnMmsmNsRfqHLNBOz2jO/U9uWdpukR8oPmdq9YGKkpbONmmfo
         618Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877989; x=1763482789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v95Lu9O+J54/kvSSdJJQyXoIt+hwqt0CDtnCjONZJ6s=;
        b=O5Qx6bNZb6QHnc1AY05cOXNQm0oHUWkLuNrveNkBOVx2TGiLWqkKVbXX5doFLlQbCp
         VGDhJmT177eRNMGVZIIo49SFCyo1zxZXHfei6ksPFj9xJEGgY//z8XAH67CxDPZe7OXl
         /g6bou/fqIFPalN+FmWMQE4/M53CmfqRKJRYuLl79pUv8DH9UZK2rGKmoK60qxOqUaLl
         A1xG81uEaM7uVbWuNlmVxCNruxwXe/jV+IzFtkZ+G3fdQkFs4fVXtXfCTTYVhPaGPJYM
         NBExFHwqWGzpYO65Fi2pUU0pEJ39U8iVmRhCih6Zb3I+97PjJKQEqTSRaXCAGTvNx/NY
         /3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVjHUKskG4Ys5lQ2harC72uhqQBnoirsGWjtj5QPW8diiTDs1O0nCo4Ni7+LMHfLW0dgyIG2kQ3j0uBILI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dqAOQdHpcdNFBs9pA6Z5c24+S0GNDNrAd9bGTV/FDIsC7NWO
	56PuX2Edo1eiQC9p01bzE6GTw9pr9HGPywlaA36raHpbInv1y9qxjGiw/DYV3cBpQoo=
X-Gm-Gg: ASbGnctkJB56pMcb3ZlGcPY5OfRY/sB9CJyPGND2WlTtChuZjkmflgsHVIShJSsWlJs
	b52b1mJxiSbYqdBgwGYD9ZMv4+k0gch1eg6fjur1jqyrUXT2/rlA8nu4lTAVoO6S6Cx69VIT/Yd
	ZO/gGkXScmMDDihYgW3BJvFoVHi08dAAVeziHDfnvqEZw3xiWvPfBnAsXgwD+6SkIYZjVCQK4CW
	eaqkM+oKuED3GniN2AAJlSQI+s5adTnAYvPpHWcNB3DcbANeUSrEz4Js2EfiRf5ikVDQSmC7Fgn
	4DztbkdRJ9md21UEPCSRLuZRu+d1rToWCgT9z66uSvRtmiGR4IzjbeiJEWS7cNtsJatsyKdWbKU
	Pr2z0dDmANCDl6o6UGRz3sQBVgfV6TTqDFGWDWOaEWrJLhp62HedXmcl/EC9cCeeWkQ0O4RCh/P
	ng0DVCRr+tT/muTV+98KVO6g==
X-Google-Smtp-Source: AGHT+IEPPEd8LCwY4ekm7MuVxGB6HrGTZQh1dtIfFSvNPwBOqBabYsVqP6nTgfnxaPkeMZhtrnoUeQ==
X-Received: by 2002:a05:6000:2dc8:b0:42b:4267:83e9 with SMTP id ffacd0b85a97d-42b4267873dmr3443167f8f.2.1762877989161;
        Tue, 11 Nov 2025 08:19:49 -0800 (PST)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e131sm29044313f8f.20.2025.11.11.08.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:19:48 -0800 (PST)
Message-ID: <947d2119-1061-4cac-9bb9-4c8b0e6e5b65@suse.com>
Date: Tue, 11 Nov 2025 17:19:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] module: replace use of system_wq with system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20251111095049.67658-1-marco.crivellari@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251111095049.67658-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 10:50 AM, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> Switch to using system_dfl_wq, the new unbound workqueue, because the
> users do not benefit from a per-cpu workqueue.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

