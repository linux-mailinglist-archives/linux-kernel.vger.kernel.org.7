Return-Path: <linux-kernel+bounces-831984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA7B9E129
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279803A114C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FAD274FF5;
	Thu, 25 Sep 2025 08:35:01 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB30271A9D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789301; cv=none; b=KXL5XWYx30J6cbDl7ruuseVeyHtTfWcHCLuy8hvneh7b/3QEkkizihfzKwiZeLMtBZpiqLXuxqb9oOTTtmjaTPE2yBI5jxfQfAFDUbjhifR+3xsKTQqq3QPtLeFWZL5FOGJQO1J5OJfFb1x3UUU4rGUJTcHIBQz5/Oj/wX/ihBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789301; c=relaxed/simple;
	bh=DJ1q9Crp31KPzDvdOQpVBt7D29LMFTTduJ+18kfO72k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUonjrKeqwLYiefb4pqA90DjsNjaPFRXtrEJDDOv+/k7DZii5aXZ0FHlRKfgKdp8XmeN1x4jjLhEBHGfC7oWl+k2fIbXaDjUI40AdZ6B393E8X6EAoh6N+yWjVBDGGc//jK0EWLzeHEBDLeNmdyg1GhNku2twk8F3V5/qV58VJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso1241968a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758789298; x=1759394098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zDaJVs41LQUBnbqHVLMQ3tXnbakB9l6TXCCNtHO7SU=;
        b=p8zZm2ljzGjwMVDzQcPRxpBNh9XyKg8UXWXlx7+0gjiUa0qFjB0h8sWoraY8cBd79z
         5JpClftkq35HXQSlxlQNAECSMHcxBvOhzMGG8lRzsaRqVppPqPc/t6MuFFa3jKEJ9czK
         D1WgNIYghe98po9qTQzrA5mZf4tbOieLsaHLHnMH5b1/Ou0S0eaoB2IoejacwyffkRXl
         ysMBU4Dn1P1cb+YS15FNaN5KASvqRqqOSAQJNN2fW5uH3VuA1hs5KVld6Pydbrphl2An
         +NZ62alirVTkgsWvsHzE+iIAf4xGIj8/e2nGytD8DlK5DbaEVg1PzI+LLlXOV9s6vuPZ
         JhRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLUXMJiKXxNEF+VcQpLXf7EevCn3YU1Hj7e4RIvtNuFheLIssAUCwbOpS30sl4fTqNO30BTi9I/Am9Z4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRe69Wpuj0rcBsj14VKqiU0nu53WIT3yRuf1Xks4B59hW4Ozi
	qI2lmDhcWXeG0jDwBZGHBuyOxO5x3oFYLlVt44DEsnXAfHiZqx5IwXN8
X-Gm-Gg: ASbGncuJYzi6N0Dd6zM+VW0DDNnFkKf/cgJfkuSmpqKfphlSs+IfNCjX0r7+g1akPVs
	f5LAOMOUAwaC7lKyHwVEhvw5NwKABNIdYqhKp8iYflA8dGRAAiLu1X2a2mO2VF1pZSVkIpzsuMJ
	DqW2YXx12bPWASS5sGzk3aeCM51hZICkbIPCLav8fOAoHF2anmarxfMPccp6P/QAgbi+66Hb96Y
	FoVwrQxjTrFmfcQe+iFK1OyQkcGzmzOwliSjUbWVFtj9ZV53mB9kebTpz2KxxUfSbz5UtDUkru0
	g1okx4m4LDrztK0rENgIL2P8tJiA955F0RhQlbo18OsIlz81benMxFWdD3eeQ6QjSxmJ6zK3wpm
	sXZTXBUSAPXw+iDFtdqeIHbo=
X-Google-Smtp-Source: AGHT+IFW24W7o3bTWAsFoY4rllK5I1ic/HQWQVPhMEjT8+gukUVi5DmlXH9g2CZqkSx3goPwUOEnOA==
X-Received: by 2002:a17:907:7f05:b0:b2f:faf6:dfad with SMTP id a640c23a62f3a-b34bc8766d0mr287556366b.48.1758789297677;
        Thu, 25 Sep 2025 01:34:57 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35448dfee7sm116570966b.63.2025.09.25.01.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 01:34:56 -0700 (PDT)
Date: Thu, 25 Sep 2025 01:34:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <iyeqx4bkzk7pha5neslqkey55ptjcrhn7sgairdpmzlf363b7q@ai474sr27tq3>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
 <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
 <aukchuzsfvztulvy4ibpfsw7srpbqm635e24azpcvnlgpmqxjm@e4mm3xoyvnu7>
 <dafma6drqvct4wlzcujoysnvjnk6c4ptib4tdtuqt73fcuc5op@efjjn5ajqwts>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dafma6drqvct4wlzcujoysnvjnk6c4ptib4tdtuqt73fcuc5op@efjjn5ajqwts>

On Wed, Sep 24, 2025 at 11:26:58PM +0100, Andre Carvalho wrote:
> Hi Breno,
> 
> On Wed, Sep 24, 2025 at 01:26:16AM -0700, Breno Leitao wrote:
> > The other option is to always populate the mac during netpoll setup and
> > then always resume based on mac. This seems a more precise resume.
> >
> > In this case, if the device goes to DEACTIVATED, then np.dev_mac will be
> > populated, and you only compare it to check if you want to resume it.
> 
> This sounds good to me. I've done some initial testing patching __netpoll_setup
> to always set np->dev_mac, changing maybe_resume_target to simply compare the
> mac as you suggested and seems like this approach works. 

Thanks. You probably want to clean the dev_mac once the is disabled for
such case. in other words, if user configured a target to be dev_name
bound, dev_mac might be NULL once the interface got disbled.

So, if user disable the interface, it should unbound from the mac. In
case the user re-enable it later, it needs to bind by dev_name instead
of dev_mac.

