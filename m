Return-Path: <linux-kernel+bounces-734967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C57B088DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EE87B7346
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F61B2609C4;
	Thu, 17 Jul 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxqJqfO0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93A2C18A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743124; cv=none; b=nE1+z+HYG9Cq95ymk7kAMKDuu0vwZqyHAr+Ug20TPFn9pYxfJoEHAhm3zbUGHTWTqYiJrbrHMSTqUKEelUVDX5fU+FNtLKH6XSKe4AohLydsyxvRI4QxkEX15xNI/Nv0B+AMa/Xvw83p5AFsYnUfQX6edtjyQt8dJFsOyarTGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743124; c=relaxed/simple;
	bh=L7D1/2iVd2q9/Qzi6dZxYB6QDmXWfVtaavTQItjdlc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyGNSlq4Wmvj6oQT0W5xoahkhAIGQI1wSxHqkRP5wSwCslWYliWNGTT5quugkYbCKu10ImRtoCbRdNZbOneA+nJRiTGt9HpzInypAT3Z6C5Z280QCTuCPzdCkb3OdFtLGM84zjFj+4Kdsd+oec9P8l5Jl7NFE1/95eyu0STMznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxqJqfO0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752743121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8kjfLVrcex8JYqNMnwGJygjdeik87ELTJ84FS/KOeg=;
	b=WxqJqfO0avuMMsxJ0cu8Xztp4u4ebfFUdOEvy6R0T+Lmyj9C7DdAD7Y/Ifhyi6T9KgYanK
	clvbveAXq6HrIoz4aLrctGo4nUrf4yUCDH6Glk/rsF0+waotPMpZZwR0A+PAnTCwNxb19v
	bvE7n1tUufxTgGMELcX3T/vyO8chaMs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-jIQWuXsgMxmuP_9btmx8zA-1; Thu, 17 Jul 2025 05:05:20 -0400
X-MC-Unique: jIQWuXsgMxmuP_9btmx8zA-1
X-Mimecast-MFC-AGG-ID: jIQWuXsgMxmuP_9btmx8zA_1752743119
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so4211165e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752743119; x=1753347919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8kjfLVrcex8JYqNMnwGJygjdeik87ELTJ84FS/KOeg=;
        b=GmIWU5ujJvTJdNLyr7JGniiRuza9G84v5vLaYdZALcr5QhQ6PCDNdPwC7Q/Uw15Aux
         Gdvg194x4z0VVUstMCsteqY3sXKMCOZ+7/i+PeY55PNSFQ6qGenQ+wjfVvoP1MqaPGA0
         vNoDHDV8TP5FYXIeM1mlhhC5svnCxZ14u3TnGEWQh/FP/AK1uRHuJdz8QWtBq7sN5S8h
         1e6NIXe/xsiWbOM7y4GkIVqOwO8l00421rLEaweKsTBD64cukguhkY29N2NmR5Uf/oHC
         BO/K6tH9KU7tT8fzdfNv2n0X2YVNA5MertREtmvu4mgRo0Pn1DI6auBXG1UaLBo3npNd
         /upw==
X-Forwarded-Encrypted: i=1; AJvYcCXy2+Tug3K8fcH0kRH7MRFDWIcExTslyWpa7k46l+XvUccryzfayeHUKevKrOjK09RVKlCiEVHOIRzVUss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4yFG+VWvhkp7fMibojrHkYSXF+J+8bF+GOxsfPZbUkqHFPE3
	E0f9oN2ANC+N+VB8s/1K9oBUGu4Y7jiJQtaGOblvM92UDv+sK5ZHLrL5sCc1KEjV7+l+jRGfvC9
	np9nccRHMx6HEyM1JIBwQIzfBdaa+rVGPzHtTGIT5L9mE7TD95rC7ja+002LlMdkkrg==
X-Gm-Gg: ASbGncs+1/bFVrKO8+E51Jl60OnEbYVjdnwaF4f6Hr3dNHWFUV9bJfNENVUQhSobY/1
	RNoiKGWO+VbUrENhXQ916gKyvQy1+rygKYVbhQTcVB7STMIySV+w33Gt44I0QkuhRorVQZCzNaT
	NCjBo9Z2EIUf4pYmz3tKGSTxxAKEyWHmH1ppYhhj4aReF/qLDR3J7vgHFsr4tPML7BfXXV1vdDz
	fukkX1+13QrrwmJDX+B+OKHBX3IBie2EVuwzk3oF5lbiyo0RDdGs1D+ClNizUNBYK7j7Kvh/WLG
	fGo9IJXE4CQa5WhV1xHEbWPMeT8lQCmxx8zlguatc1+/p7IeqU0MCmBnxixN0uO9m37isw==
X-Received: by 2002:a05:6000:4719:b0:3b5:dbd8:ad5f with SMTP id ffacd0b85a97d-3b60dd91d5amr4584092f8f.58.1752743118648;
        Thu, 17 Jul 2025 02:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKzBA+nIDslTzLBOt+Y6PtFpV+b9Z3/qQFQH4pOsV0FRQTn4v1SAc/e4McY4He/aMxKQlALw==
X-Received: by 2002:a05:6000:4719:b0:3b5:dbd8:ad5f with SMTP id ffacd0b85a97d-3b60dd91d5amr4584054f8f.58.1752743118149;
        Thu, 17 Jul 2025 02:05:18 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.43.229.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1647sm20068276f8f.1.2025.07.17.02.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:05:17 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:05:14 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: markus.stockhausen@gmx.de
Cc: peterz@infradead.org,
	'Chris Packham' <Chris.Packham@alliedtelesis.co.nz>, bjorn@mork.no,
	mingo@redhat.com, vincent.guittot@linaro.org,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: task_non_contending() for fair_server leads to timer retries
Message-ID: <aHi8yk8wlVJBFzSR@jlelli-thinkpadt14gen4.remote.csb>
References: <085d01dbf596$44286880$cc793980$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085d01dbf596$44286880$cc793980$@gmx.de>

Hi,

On 15/07/25 16:39, markus.stockhausen@gmx.de wrote:
> Hi Peter,
> 
> I'm currently investigating issues with the timer-rtl-otto driver in 
> 6.12 longterm on the Realtek MIPS switch platform (Chris is working
> hard to upstream this). While doing so I observed that timer retries 
> continually increase (~6/second) according to /proc/timer_list. The 
> system is otherwise totally idle. 6.6 longterm does not show that issue.
> I'm unsure if this is related but documentation reads like "that's bad". 
> 
> To be sure about this one I nailed it down to the fair server.

Apologies for interjecting before Peter had a chance to reply, but I had
a first look and I wonder if this recent patch from Peter (on
tip/sched/core atm) can already help with the issue, as it should
reduce the number of dl-server dequeues:

cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")

Can you please check what you see with it?

Thanks!
Juri


