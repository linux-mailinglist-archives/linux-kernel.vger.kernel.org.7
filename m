Return-Path: <linux-kernel+bounces-883049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2625C2C5A6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5191899441
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB680305056;
	Mon,  3 Nov 2025 14:12:54 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059B2765C0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179174; cv=none; b=RmsUzuFXEDdFZWuKgkRzzUYYHnEIJH7HyKMsEYQX6lNwYaFLzxhjuLgeK49C5dq2vTCpj2dCkWLEdp8UrT++kEx6aIvbNJ9wN8Qlfe50pQG4RmV9vUfRzMPF8T8K467s7r9sKfQVpMpOt17rLv6xgU3p2qmTdxWmvBMpBbP2BXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179174; c=relaxed/simple;
	bh=258lH97XXGC28+Dowc301BofiuoERGUxThhiNcWo3Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQF//zw3Wn+MIPcLfzNFNNjrG5x3OWnsG6E5rnLeo8B/hh8wKZ2E42UWr+CI7d5lHKqB/POAIRizMj8tWh3TbMBtPigaXSlkRE193YlhxLrgi97REsuaVoP0u3vonTG0zLH94j3S19T3sqH7+LpG3FN9wi0Zr/ImZMBc+LboTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so2442558a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179170; x=1762783970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV+XrmcKqNPHxmqSNaEdiGohivcDhtAS62RzzygEyEI=;
        b=lKB32+EQl56V+oVmzbopJ8LDvN3eUgYxNy+qhJsPGHgIUsltimX6mxzJAsU6e3j5lr
         FTbr3oHIGzkmqn68No7GDG/vhGFNXHqIzkI//YPkwqaZmUMwnIs7d/DhDeQWHuxxtKOV
         GN0MXlWudS7Pv5drcJR3/blZzABdKvseAlsjl/SlgjlMTt2U+G1J6KcLCk5cuUWjrjr4
         7Jqo0Hl0GOu5a7VSzIDo52pIk9xXQjszwf595vCqkHbzI2TTLZeKTh7hmRN9NP5+8cBM
         7XWlkavwCQ+xlBNNK21tkM5mWMoGi7f3w1keyU/f0bClTsXwBe/Q3wSgD92Z9X+Ld6n7
         alLA==
X-Forwarded-Encrypted: i=1; AJvYcCXXbNW/yAL9DXTaPcbEbGLW1xIa26ZMx7figvTe9HYGhdkmvB1dnOGaet/vPvcuViLLcDaOQxoVQa8osLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QX68oY8fol+edYhyz0s6jb2y/FVb/DRGI0nsrO91+663f2XT
	QKgKCGf8v7KWcBb9VIJd84r9drE7r1qg/eNil9yAdS9Z3dzlG7tpaU0K
X-Gm-Gg: ASbGncsTBvV2xt+bPVw3H8++oM72RwYC8qvfJyqPRgbtyKL8qhIFTY7SZnatizqNZjF
	ZG3gIUpe4v4w4An2mkjI876A1cujUxcw5Js4x1iVy0ox1zDRf1BCL5MUoqg13Tzt9ESpvfq8a6D
	SNYirGT8o35a3LqeU8eNao7a4CtIKR/fwgqRgzUbQd/XjsQi3lTJHzu6iM/3ZY0/rieNCUEfIHE
	LEvxQ4icgzt+ol9X/MQwnLLwHwEvDBeExuG7A+wGj/jGmFfkmT2YqJ/RQ+jc6qGVuxaxaPuiOJz
	/aiuG7toD2mg0s4ToWrzrUfmNgtmPUZ/M8nLgDSoJCtNyS5V67XGR2dbwviecNd7KBkot1VFqLW
	cEhe/yV80YfQIm0wg1XdIN+GhES7aeVYSy7DrHnypMac5DJixP90X5gcKQnxHnwUtHPQ=
X-Google-Smtp-Source: AGHT+IFWQEa+DoidWBa5kIJMKwLnZxsoTwKivdYX0YUChjS3vOZrQe3uWz6GQ2+eSv3jDr2kvuo3fg==
X-Received: by 2002:a05:6402:1ec5:b0:640:93b2:fd1e with SMTP id 4fb4d7f45d1cf-64093b2fe28mr7493506a12.17.1762179170035;
        Mon, 03 Nov 2025 06:12:50 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:46::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b42821bsm9761512a12.22.2025.11.03.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:12:49 -0800 (PST)
Date: Mon, 3 Nov 2025 06:12:46 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net v3] netpoll: Fix deadlock in memory allocation under
 spinlock
Message-ID: <vrb6p4usfynhdlyf2u5frg57ppoc6umvg5we25cshlvudpvl5c@slq27s6cohbx>
References: <20251014-fix_netpoll_aa-v3-1-bff72762294e@debian.org>
 <20251016162323.176561bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016162323.176561bd@kernel.org>

On Thu, Oct 16, 2025 at 04:23:23PM -0700, Jakub Kicinski wrote:
> On Tue, 14 Oct 2025 09:37:50 -0700 Breno Leitao wrote:
> > +	while (1) {
> > +		spin_lock_irqsave(&skb_pool->lock, flags);
> > +		if (skb_pool->qlen >= MAX_SKBS)
> > +			goto unlock;
> > +		spin_unlock_irqrestore(&skb_pool->lock, flags);
> 
> No need for the lock here:
> 
> 	if (READ_ONCE(..) >= MAX_SKBS)
> 
> >  		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
> >  		if (!skb)
> > -			break;
> > +			return;
> >  
> > +		spin_lock_irqsave(&skb_pool->lock, flags);
> > +		if (skb_pool->qlen >= MAX_SKBS)
> > +			/* Discard if len got increased (TOCTOU) */
> > +			goto discard;
> 
> Not sure this is strictly needed, the number 32 (MAX_SKBS) was not
> chosen super scientifically anyway, doesn't matter if we go over a
> little. 

Agree. I will take this approach them, since it is not going to hurt at
all.

Thanks for the review,
--breno

