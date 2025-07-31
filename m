Return-Path: <linux-kernel+bounces-751688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C506B16C51
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3D57B6A79
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338B22F76F;
	Thu, 31 Jul 2025 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgEZiWD9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACBC323D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945326; cv=none; b=GemRm4u2TO/2keYOIOaQI9MjPNI1mD1O83ZkLadzz3i0mcC+4mB4todJxnQl2vroAUddiInGkEXIm1JnAKquJQ/RLgjkaGeU4ThTPadI4ukD6ocBCGnZYjB7X2ggn1/FmO80Tfo+a6bVXKA/+0n6b/W9bSgNHTVe/9N1IibUBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945326; c=relaxed/simple;
	bh=1WAz6DC5AEqeUVyogjNAdDOJcnStZz/oROOCSc7xzDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qmmic/3pYUXprM05xkc2TdFfyDZCGXnuVOMR43VY8GA2Mr35/lQGyB9eJd3IROTlpWM77Qob3QLoET+QIxJp2bnA7KkSoyvpQMTDy1RFoo//jMNIdUFd5b2vU+5c26RPmyCqv51eB746Fk5S8N1NX8ifZO8FkVBY9lINoGlB2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgEZiWD9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753945323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1WAz6DC5AEqeUVyogjNAdDOJcnStZz/oROOCSc7xzDc=;
	b=JgEZiWD9BWz+QAY5SiK4Pg3MKjKLEGe5qtOrdkzgC6tJvyqFXfIAcwS/OIAYBDMWyixGmQ
	LU32e4mqmt1ZuQr9cmnIL+jjCp2jrsdUiNLYy+VqGcN2TNNzi7t0eUwhneBHefCxt4RKGd
	IsMjKuDmDXjdN0ROX3x3+cT4wWw8kYI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-HUn65GvuMBuhtrZCzFHh6w-1; Thu, 31 Jul 2025 03:01:56 -0400
X-MC-Unique: HUn65GvuMBuhtrZCzFHh6w-1
X-Mimecast-MFC-AGG-ID: HUn65GvuMBuhtrZCzFHh6w_1753945315
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7825a2ca5so806098f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753945315; x=1754550115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WAz6DC5AEqeUVyogjNAdDOJcnStZz/oROOCSc7xzDc=;
        b=gED8u2J5Fe6qUHyuFSnU7hlpCPd0BkCqYNsY0lVKLLNgh18tL989fYAAPIx17CZDrt
         4DOiZIeIlfVWszwAzXSjblAw452H8tXOQ3wrSQkL8vZvd/5Ke3dbMIZc1xAg7tuZ1OZP
         X+lhSnwDxZKg9pIZbnWBF3wPuA2pwS84TyWn2iOOeib0WDgbCoYkYAmVUTVnmef4oRrT
         NirjjCKsauetP19udw592RQV33IFbsBK+nvSfpL1qtqoYcabkzNSHliO8g9ab5fdPR1a
         Sf/pxaIzpuWTIyJK2WXzMTVBc84+7+QLZZjyCLZFJ4eaCLIq341UIHUeMWC/CP2tc0AF
         zcPw==
X-Gm-Message-State: AOJu0Yz9nhp4oqOM/J1hOGkgxNS/APGrHJZ74Tyi+E4hPNBukxQ1Mn/M
	77Eq+ne4eSgnGfIG/1W7WWEy1+ZjIfuLFSlEjVUETu3By22COXQL4M6GuuoyiOZ9p8CqHJr1FT8
	qLA6OCljfpUt/DIF/Ih8F0oYLo/VPhgaeoio8euSKRXfbTFT7hiCj7sSaeduDttmZsA==
X-Gm-Gg: ASbGncsgzUzh9AFJDRUoLLQbN+u6+ZQ1n5RCRxyXgdhzpboKDLyeSC3Zc9lFLIgQs+b
	j56M5s33u5vL0dDYr9n969oOK4Ahl9XMlrKxUC2RexpKDv+p6fqZpFWBAob2uD53rZxCBvxuZnb
	I+mKCXlPsm1yReqHTNomHBn9y4TS+E3MPNhqmrr69BCcqWW48JZHm1+dnLAqzlPNPVyBWn3tay2
	MTgm9zTEI1dP1YxaKP7VOKONcZYo1CF8RtVo4svCdiHvyYeRk9ngznTj05fHi5ZIf3ZPrm7HGJi
	nafNkTgayGIky2v/HrwcuqrX9SNckGJcOzRgg27AvBwTUYloHLSBLzZPng+N+Ld23WL1
X-Received: by 2002:a05:6000:430b:b0:3b4:9ade:4e8a with SMTP id ffacd0b85a97d-3b79d4e0b4bmr706098f8f.21.1753945315424;
        Thu, 31 Jul 2025 00:01:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Nf3k6F37Mrq3YoJxogERWli6tP0u7To4PZTrfP7eJEm+0ri9H5Ynf4uVNuH5XKqRPejdDg==
X-Received: by 2002:a05:6000:430b:b0:3b4:9ade:4e8a with SMTP id ffacd0b85a97d-3b79d4e0b4bmr706055f8f.21.1753945314919;
        Thu, 31 Jul 2025 00:01:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.5.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac574sm1334218f8f.5.2025.07.31.00.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 00:01:54 -0700 (PDT)
Date: Thu, 31 Jul 2025 09:01:21 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: David Haufe <dhaufe@simplextrading.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
 Interrupts on isolcpu/nohz_full cores, performance regression
Message-ID: <aIsUwT1Ai0zcMRpT@jlelli-thinkpadt14gen4.remote.csb>
References: <CAKJHwtOw_G67edzuHVtL1xC5Vyt6StcZzihtDd0yaKudW=rwVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKJHwtOw_G67edzuHVtL1xC5Vyt6StcZzihtDd0yaKudW=rwVw@mail.gmail.com>

Hello,

Thanks for the report.

On 30/07/25 11:51, David Haufe wrote:
> [1.] Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
> Interrupts on isolcpu/nohz_full cores, performance regression
> [2.] The code for dl_server_timer is causing new IPI/Function Call
> Interrupts to fire on isolcpu/nohz_full cores which previously had no
> interrupts. When there is a single, SCHED_OTHER process running on an
> isolcpu/nohz_full core, dl_server_timer executes on a housekeeping
> core. This ultimately invokes add_nr_running() and
> sched_update_tick_dependency() and finally tick_nohz_dep_set_cpu().
> Setting the single process running on an isolcpu/nohz_full core to
> FIFO (rt priority) prevents this new interrupt, as it is not seen as a
> fair schedule process anymore. Having to use rt priority is
> unnecessary and a regression to prior kernels. Kernel function_graph
> trace below showing core 0 (housekeeping) sending the IPI to core 19
> (nohz_full, isolcpu, rcu_nocb_poll) which is running a single
> SCHED_OTHER process. I believe this has been observed by others.
> https://community.clearlinux.org/t/sysjitter-worse-in-kernel-6-12-than-6-6/10206

Would you be able to check if the following branch, containing multiple
fixes for dl-server, is still affected by the regression?

Thanks,
Juri


