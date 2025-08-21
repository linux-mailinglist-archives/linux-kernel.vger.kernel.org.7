Return-Path: <linux-kernel+bounces-780469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C085B3023E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D55E7BF10A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189E3451DE;
	Thu, 21 Aug 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WQRbTMyV"
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B783431EC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801868; cv=none; b=lG2GeOeUAQ2JguellDd9JjAt4IatGpiULxslboR0Jbk7JXyRLnDDIlzhEaHBPFkQcGjlaAO9GxjhS2Mpwj1jZLheinbrqtM3gcKYevTpAC53nPn260BtRkC6vtq3JVAgA7mL6zorZX+ztyLr9ux7KqJbI1p7eXOOSpLad9b24FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801868; c=relaxed/simple;
	bh=KQ79PtgU+urHOW0anVaHifb3uHHkNRuVJRuMkIiem5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rt4pdNVUNeeAdFFGClSg71/43tRjPLu+2n/OrUdbgDrm9Z7C6yLyYXf5615o0xU1MrEIUZq4Rw8UkETv3psGFShrOIqvx0KrzI+1X2N9auUwSIhySeVMKb4vZJs8AdqNrNp0u3vfGhb/SNxm5Je88JZUwc/3g97uEko59+/LbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WQRbTMyV; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4b109c58e29so21280651cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755801866; x=1756406666;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3Vdinbv+yzCiaF+6xaTYU4lTVi63vniwlAs0d8gpeI=;
        b=Wr8k1ji6sxDtsETKyAS2vAEFaFQj5FRFRW70bL8nTKIJXHSk8lldohw2fNQvBDbxlH
         X3ih77D2skKM1409IsPWHiqqvMKxYQh2JTDOe8yzLQKgUskXtps4KgszANz07Mk4/s1y
         pOT6XKGbyPFMlsXi8ZrGX/J6HhEGXNO2olfwAGHeQnJ896l1gwH8pJXCEKEIX2KH1iCu
         Fx47T/WZpLTgorXlp6HOep5Uh/j4xL+xu2PYnGVhcjD4LRX40FhH99bI3RavGOg9SGqa
         dxzJpUeJeLCGN0/Jp8wG0PNHt3ylGxyuzpPW8DpyzKG5FPpijs0fiJJAcTnSl2skcIW3
         LD4g==
X-Forwarded-Encrypted: i=1; AJvYcCUuHLyp4jwvU6cWF85dYeLxQk4qgYHp/t73H+fDIUM4uKvFwqRXe2wxki6JKnI1zbvjlBRUZ/khk6mv1YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7pBZ3XmFFS7h9zJSX2R44xgH9LMI33g8yPoZZeWI1L0K1ZXoK
	sHj7D3UN2TTGvBOE+rDBn5FkOFsluUXuuNiKkIFvPyYVN2co/H+BOcDKD3vvwaoq80Iyz/CtXbG
	s4wm7p8nEvXctAKLXqvHVIbBNOLraWWODNZZ/IxBG+PHow/5oBsh5s3tbDQbcg2MXuIlwj2ErpW
	IOjIGs/ManVndM0pe88DvNRCN9yO6TZnJwbYm41ngoNhs56vcpGevUHkuw60a6mDDTdXcqCJKh+
	N8rBt3foCVN6EeyVCPZXQM+MQ==
X-Gm-Gg: ASbGncsFhMA6eC2vl8iygpW/Z1JqAz5NrPMxvC0wxvcO3EqgpV7kwJ1e+sqCyGMD4v2
	gH5BHlneO9YzmcyqgsAqf0xJOpB5tMevzWcpuLg2y3uqgiGGaSG2L30mjTKGK4dz0xcrY4TneJr
	oxF2ZQvWZQ3SZYnsWhAq0Lt672iQPP+QAu2czUlJdp5GM0qsaWybczokUJhRpPHm6oBPjffOXwy
	5vZoyJdFWztIWVs+8qc8Tr2k2q+hdxuuTsLq72s/VUzHrzHJkW480v/qORrzasZc4tK0lK5Gts8
	wKpTI5K0ej4cV2FS4JljNV+XD+I52+C6p668Yf68NT51nnbPT/vsy9zdk3FCvB3TieKQqzoRHD0
	AxHPsFi0Ea7yegIU+dLW05X9Hx/2Eooo0Lj11iDG1qjwUUygN9YvLnpWN1QlpzFyKxp7BsGi1Y5
	KBq0idEw==
X-Google-Smtp-Source: AGHT+IHuN5eJezHSLZzauqMRBZ9u59jhSAhOJeBlQdlztrueRLSKC8O3QRtVBD8HGxRxCqKnKYVAOL9Ya771
X-Received: by 2002:ac8:7f4d:0:b0:4b2:8ac4:f078 with SMTP id d75a77b69052e-4b2aab8a7e6mr3954281cf.74.1755801865426;
        Thu, 21 Aug 2025 11:44:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4b11da027easm6948941cf.1.2025.08.21.11.44.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 11:44:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61a8a9ea4d5so1164817a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755801863; x=1756406663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h3Vdinbv+yzCiaF+6xaTYU4lTVi63vniwlAs0d8gpeI=;
        b=WQRbTMyVWLF7PGhw9fFzVkdcoCjZhlmqpexp9d6JiFneFh9nD49Zyt91xieDApXM/h
         vrhK0HvRrP37KqfgAsq0Yu2fAb2ZK8+fHT2t2pkUZBk7AlELXQK1c2AX0CX38IZnOfsw
         qg5+c0VuKhE9ACrzKhm8sIRSBeFYXzxBkM4Mg=
X-Forwarded-Encrypted: i=1; AJvYcCVSDHbIyYmtlnMMtvit/lYKck2ZSPzvUlp1ETfwLkShc8ZeQfbFHmSPRcXF0zIT6/IOWKPwtPxSQdrSRCk=@vger.kernel.org
X-Received: by 2002:a05:6402:40cd:b0:61a:2fc5:debc with SMTP id 4fb4d7f45d1cf-61c1b6e8a93mr97469a12.32.1755801863501;
        Thu, 21 Aug 2025 11:44:23 -0700 (PDT)
X-Received: by 2002:a05:6402:40cd:b0:61a:2fc5:debc with SMTP id 4fb4d7f45d1cf-61c1b6e8a93mr97444a12.32.1755801863068;
        Thu, 21 Aug 2025 11:44:23 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9b37sm5634601a12.7.2025.08.21.11.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 11:44:22 -0700 (PDT)
Message-ID: <d071faf8-e800-4169-a670-8971d57b6997@broadcom.com>
Date: Thu, 21 Aug 2025 20:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: btcoex: Fix use-after-free when rescheduling
 brcmf_btcoex_info work
To: Duoming Zhou <duoming@zju.edu.cn>, brcm80211@lists.linux.dev
Cc: brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
References: <20250821043202.21263-1-duoming@zju.edu.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250821043202.21263-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/21/2025 6:32 AM, Duoming Zhou wrote:
> The brcmf_btcoex_detach() only shuts down the btcoex timer, if the
> flag timer_on is false. However, the brcmf_btcoex_timerfunc(), which
> runs as timer handler, sets timer_on to false. This creates a critical
> race condition:
> 
> 1.If brcmf_btcoex_detach() is called while brcmf_btcoex_timerfunc()
> is executing, it may observe timer_on as false and skip the call to
> timer_shutdown_sync().
> 
> 2.The brcmf_btcoex_timerfunc() may then reschedule the brcmf_btcoex_info
> worker after the cancel_work_sync() has been executed.
> 
> 3.Subsequently, the brcmf_btcoex_info structure is freed.
> 
> 4.Finally, the rescheduled worker attempts to execute, leading to
> use-after-free bugs by accessing the freed brcmf_btcoex_info object.

Thanks for the patch. Being a nit picker just wanted to day that the 
use-after-free happens a bit earlier as the worker itself is contained 
in struct brcmf_btcoex_info. Also the diagram below does not add much 
more than the textual description above.

> The following diagram illustrates this sequence of events:
> 
> cpu0                            cpu1
> brcmf_btcoex_detach          |  brcmf_btcoex_timerfunc
>                               |    bt_local->timer_on = false;
>    if (cfg->btcoex->timer_on) |
>      ...                      |
>    cancel_work_sync();        |
>    ...                        |    schedule_work() //reschedule
>    kfree(cfg->btcoex);//free  |
>                               |    brcmf_btcoex_handler() //worker
>                               |    btci-> //use
> 
> To resolve this race condition, drop the conditional check and call
> timer_shutdown_sync() directly. It can deactivate the timer reliably,
> regardless of its current state. Once stopped, the timer_on state is
> then set to false.

However, no reason to stop this patch from going in so...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Fixes: 61730d4dfffc ("brcmfmac: support critical protocol API for DHCP")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

