Return-Path: <linux-kernel+bounces-895491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607FC4E17C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F048F3AC9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F4E33AD82;
	Tue, 11 Nov 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIviOlqP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvuaIeMO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38475328240
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867406; cv=none; b=sTIu6A1rDND0eZV+jVA/1X9ob4BB1/KpP21b8QEckerkvwN25R15snhzYc6bDNMgOzHbWIH+LiAI3h4uM6OexmhgA5gKlcKM588ICUhdBk0qveJZOIyOu+SylblQEblD1V460sWcGfugzpLyadXQyhr1gK3DYLKf3TJPLRfkhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867406; c=relaxed/simple;
	bh=8ZXbcITm8LML12/K3zdJ64O5jO1a0DI3vUtyK7n5qz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0XvOrWb1YDP7cxFTFTcdJ1tYc0H8cO/pGM5/hNfbo2PY89O3iz1QWVgO1d5msLo6l/1EdF0INZIjNXAUPIaEkeizblPmyN7rH1kd2OapCPJv7HzvrkOJLqSTL7oeDL5Gp4xdcujWTdfE8uJxqjMdTZxMLzLARvt69sFVjOuPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIviOlqP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvuaIeMO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762867403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWxqafNjNHr5+FTVy2qLjBaEO2UnHLJm5Gzubpq7ask=;
	b=gIviOlqPNBsQujzleeipD1EhlVrBWoxvr7f3LPRz/AOsVjEEvinoQ7/eadBRQe27XSsVQy
	9y45FE4y3/grpEY425J7W55hjs1NP+yzatFK4Js6hjDX0msLDN2gme5tq+QGxqLcLpTMZ0
	Tpt0xvocrsfyis0d8Z/QpFaMCaUpQcE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-Nmwa-7G6OqGPvSOZVDEaGQ-1; Tue, 11 Nov 2025 08:23:22 -0500
X-MC-Unique: Nmwa-7G6OqGPvSOZVDEaGQ-1
X-Mimecast-MFC-AGG-ID: Nmwa-7G6OqGPvSOZVDEaGQ_1762867401
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429cdb0706aso2650930f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762867401; x=1763472201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWxqafNjNHr5+FTVy2qLjBaEO2UnHLJm5Gzubpq7ask=;
        b=QvuaIeMOsPqXG1kmvOLRRYXYa7vYE3/vFG06C/KdgKQtZ+W3DvWDCieRXKk4KgoWld
         jOS1UveRC0TTHu1H5pPBFR+nvzlsugcpX5uLWj4DfzGdFZ5Om38gPUVgbAN5CRGNrLG/
         hjtY9ir9Rax0ye4f1OyFWVy1bwdJ9sO3fuq0tFTlMsPKnjRMRE+17B2OofdCDW3soBhw
         QD9GjseyUqyz/dTcziZk1M7YfQyzX19Pm6Bklf7zHmZq/+x8TmiN/Ti6pPQw6Uk4YwM8
         OrtRxt9qwzc+dPHdf7lmYKlQazakcXJsfIHJF4CZAMD4PeBEJFYq0fwBlNHn2+uSnA17
         rPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867401; x=1763472201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWxqafNjNHr5+FTVy2qLjBaEO2UnHLJm5Gzubpq7ask=;
        b=av7fG2PprYcGhrO5qBTMiAW1Wzd+AVs3LMLsmU++r7by7xvEVKdvm/HoM9YDA02TAX
         lEtxOk4CZXmIwUkWclsl47Z6OzgHpAZD567vSpC48KxEwy26Be8hEW53r3aqWFCECp9t
         RVcC3EGSyl2t8snG6/PQYXhDZlhiyJV9pFCPf5nuJ4hnfrgWdYFZZJPyI/up8x3vdCI8
         3QnLpEznMxSbzha+lfJDU7ldNCAB7VorLLa/x38jtLjYuPWEKzrZq0eMuqZ2ARnK0xm6
         vmDPXEsuh8Ecrulk5I8aGjlrib1On7NGDrO166cN4l2UoA538A0HLeIylkNz9kH5i1+N
         S1/w==
X-Gm-Message-State: AOJu0YxJ5Oy8Of141HBo6YRfb47NC3ROUnhzpOgwIOVtDDDySF4WDwwa
	t+C69OaB2XS7FH046XoPgTnj3kkzBgBPila4J6JYdADPhj0ukmwGjO0gd/cCMY161Z+j5odXCjI
	rCSaxSRjrxTVxHhuLWL2vcLvD8AlyZS8B8ZeVcnvC8cwUTtcVAK9kWOR85S/eFQntPw==
X-Gm-Gg: ASbGncvU4nnRkVcnlUqiu9wtKgnem09J1kVOdYB2c2k3LT6DoboeeWupPWZO9/MZa+H
	Z4lEh4iKPeOju/VMsOpK8DTcRwwsLK9ACNUK2sBBjimk9Krqw+e9LTmIYrcYK/OAZlFFAyIGy1H
	T5pqRIFsGp3D7iaQcyxJslGtQLRPqx+UZ9LzmUcs0OzYgE5Jr8FGjHwsuvvlRZHmiV/3Bf1jtdw
	I17wd3v85XPi9vCa175Cx0CbG3JefmJJzdVUBBeovAnHnA638lOE6nT+IdwaZ4CPrcOM+yhN+NE
	BQ4k3js11QnlcqvgCIaFZNJK1qLIU9jdk/uc1daZL8YeygQs+Krpq0aYjpkbTa+fF2c7DWh0NMa
	Zg8gRDIEH5YTFPD3uiqZp9Mozbx6fyQ==
X-Received: by 2002:a05:6000:430b:b0:42b:3302:f7d0 with SMTP id ffacd0b85a97d-42b3302fd03mr7861882f8f.22.1762867400623;
        Tue, 11 Nov 2025 05:23:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe1fKVQI0AQKeaP66S8xfEpPORcNRZK/N21beU9RAcDdbI5LvO+jNso89AWWHaGKhwDZJIqw==
X-Received: by 2002:a05:6000:430b:b0:42b:3302:f7d0 with SMTP id ffacd0b85a97d-42b3302fd03mr7861849f8f.22.1762867400204;
        Tue, 11 Nov 2025 05:23:20 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2c6d3f67sm22048989f8f.37.2025.11.11.05.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:23:19 -0800 (PST)
Date: Tue, 11 Nov 2025 14:23:17 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv5] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aRM4xZxf1X7wJhkB@jlelli-thinkpadt14gen4.remote.csb>
References: <20251110014706.8118-1-piliu@redhat.com>
 <aRHJHxfEI-tnotRe@jlelli-thinkpadt14gen4.remote.csb>
 <aRMgrQRqpwvBSPC6@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMgrQRqpwvBSPC6@fedora>

On 11/11/25 19:40, Pingfan Liu wrote:
> Hi Juri,
> 
> Thanks for your review. Please see the comments below.

...

> Since there's no way to handle memory allocation failures, could it be
> done by using alloc_cpumask_var() in init_sched_dl_class() to reserve
> the memory for this purpose?

Maybe something similar to local_cpu_mask_dl (or use local_cpu_mask_dl
directly?), I'm thinking.


