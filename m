Return-Path: <linux-kernel+bounces-741357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C4B0E32A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956EC1C85D66
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15280280335;
	Tue, 22 Jul 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ7KKXF0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532928031C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207170; cv=none; b=CvIfnOeRUiHzV4QoM0ATm87lGFiOguBEwGjRDCxQdwubjbsAiLePGEUHyaucQb50fY7JmNefWw8wBvTJ4/2bOHtg/DPu1Xs/NPg6HBVYLHbNyFejtdA53gziLfd/OHLgmoqZuLbfsWVBRYrQAQCVfFTTuBo/MNKmU1A8iycORUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207170; c=relaxed/simple;
	bh=JiX+WUAcLJXpo4QerqRjpVTvbXXolkhGNQpOPlELs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQAc71RAKzx2CyXYoXnhpnc/Kj90Tvfp8YzKc4Ww2P9KEtkY0IUJj0Kmmjd8e+SxMqvy6+UK8zemPzKg5VYdcimURpKUNaX4/ztlU1DJf+umurKfOJ1by8OmW5nrB0y9I5DuTfWnO7bssUt2vm630qPh3TNEn4mIqgMec2/lSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZ7KKXF0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753207167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nh3RxMWKI0vx/8E9XE0zit4VRevVC1NeFnlkYll0kJM=;
	b=KZ7KKXF0VMDMalqNX6d35DJc6lhuj125uDWy6KT84rU9kZrd6x0FJroROqHvPsGVkdmPW1
	gLXQi+C/MeV3Uk7Ixjs8ydTJMec6CB+2lS6ui1wu0uZzQb6io1d+KWzQZCnRq4QbJVyb4g
	eTZXSp5ypaa7s+ICO1j5Gpldj+4EvHg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-by6hv_79P7qjrkMqLJD7wA-1; Tue, 22 Jul 2025 13:59:25 -0400
X-MC-Unique: by6hv_79P7qjrkMqLJD7wA-1
X-Mimecast-MFC-AGG-ID: by6hv_79P7qjrkMqLJD7wA_1753207164
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fab979413fso107810836d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753207164; x=1753811964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh3RxMWKI0vx/8E9XE0zit4VRevVC1NeFnlkYll0kJM=;
        b=YBs/X2s/hFSd0OZCl4ZNE3K52lCiGiaZ0vMlPo257u+in8h1rjA0+LTRBcXbnMXLaF
         int4KY8D3ABJf7UCT4+afUZGSPUjZScdmWY42PRmFba5nOoEvSS9Yph6wZxfkMEdMVlv
         +Uk2aVyLGFww97+ofkRLFd4UnL6zocQMJ2L0hLHgzUk3rZIJv8niqak/bOJ/VSRZgHwP
         nT+D755DRsHXtBvoQnXNBMY22KIPHN5MJvCAXr4tBI2Nx52miPEZF7yWgA8HaKJRXogE
         BdFETWXFqkB5MNtAna0b1pAtLXBr36/YvRcy2eBvtYtwqKX56WRFiqCBl7enSUmnCgcq
         8JgA==
X-Forwarded-Encrypted: i=1; AJvYcCUiIsSz673LKsCMHFBrgO9OiK16Byg0QDGX7IWESKFDUMLT+jl9rLR80FAghqOapqmIryKTV2GA5WxrfcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDqO6qVPx6GuiOz4y5B65f++T5aYWnMc9FsM06YoT1t464EVXK
	pUaHaJeiLNzmQTEvnSZbBGvlqojbdrHY05k3++mWgLNEcO+U6ZVGUpSGnSMV9vb28m2p82Kw1EQ
	o6JLSJNa1hzIhtlDLZtIBWwd0nQ85Juldl3yAzmYFyFF0g3skESZNifvw09WPC3NgPA==
X-Gm-Gg: ASbGncuTrD7TAawyt0qXnVKLgSoj3fmrVS6M0gcVYQR7YIyp7+TI4+QrxL6RzmD7kdg
	5iJPnsnRdnWM2+kiDSpro/W7gWQUJMo58P1Lt9gW3OUVr+ra2Q7YO9Q6BvUcrHttGLkc311U1Tx
	pa6/vAgeaHwtlAz6SuL9jhsPAPsn9WHWz47gfO6IGW5O/I3C3vNFuEHf5DdAo4xKOT2oW5zaxLS
	cfFCVGThdwh8kXMHkjwyK7ZziklZUmqkzR3GAlDlW23FF/nQt+P0nO4CvpX7YgGAh/2fTBkPqxj
	XmmUbnNnQbqSdUlYmA5ufIxvhTVfbw6p6vso
X-Received: by 2002:ad4:4eee:0:b0:6fb:5f97:510f with SMTP id 6a1803df08f44-7070087533bmr173316d6.44.1753207164563;
        Tue, 22 Jul 2025 10:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeND15EoY0kc7n9IteeVLBb4rW6kvwLwTt2goaOdVkAt7hhA9cKMxKBefg1R6RRXfZP7oCYA==
X-Received: by 2002:ad4:4eee:0:b0:6fb:5f97:510f with SMTP id 6a1803df08f44-7070087533bmr173036d6.44.1753207164206;
        Tue, 22 Jul 2025 10:59:24 -0700 (PDT)
Received: from thinkpad2024 ([71.217.76.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-706e09879a8sm24041736d6.72.2025.07.22.10.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:59:23 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:59:21 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Shinji Nomoto (Fujitsu)" <fj5851bi@fujitsu.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
Message-ID: <aH_RecWNuC_UqUlx@thinkpad2024>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
 <aDhJdTWzDihchywc@thinkpad2024>
 <OS9PR01MB14003E72236096AD987D2D4CED96DA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
 <0053926a-7b0a-4e49-9acf-fcb1d73134cc@linuxfoundation.org>
 <aFWZyPs4eBwGcKPu@thinkpad2024>
 <OS9PR01MB1400335E9E14CF505B8AD26DED95CA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS9PR01MB1400335E9E14CF505B8AD26DED95CA@OS9PR01MB14003.jpnprd01.prod.outlook.com>

On Tue, Jul 22, 2025 at 07:30:27AM +0000, Shinji Nomoto (Fujitsu) wrote:
> Hi, John and Shuah
> 
> Regarding the subject, I submitted patches to cpupower, but so far I haven't received confirmation that the content has been approved, nor does it appear to have been merged into the shuah/linux.git master branch.
> Could you please inform me about the current status of the patches?
> 
> Thank you for your time and consideration.

I do not see any issues with the answer Shinji gave on testing.

I am fine with it being merged.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


