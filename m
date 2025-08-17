Return-Path: <linux-kernel+bounces-772501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A2B2936E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5102A1E5F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD642DC356;
	Sun, 17 Aug 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="WOddVjmw"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D21B4141
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755440837; cv=none; b=H0QlICEdaa1nd/XTK67WZgBtIWASODkO8IRzT7lBC3kkxAnCzjTWTmSfFkRr0KvwLO8mhbrrLrK4wcKr6FeeQXFdToAykDt6fxLgphgcfqIz8BUU2AeOuYYlLNTUrVPK4Nwx9BXqgMA77ctqvW5Pb+WIjJUekUOQA7+PWQBarPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755440837; c=relaxed/simple;
	bh=lDpq8I98j7ygHtJNnQA9whbnrtcvMAxLIsDOkN+5U5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA8RpnK+eaaqbnMF3BG31DvsJH2aQ+cs75OKPdjLJnlnrRTEWh8hkzljZ6gCb+WGkNabmIY5EeSPcAgFwoZ4I6GO7Oe+CX65JeRSOh22HVUUjT2kLoZGzuvYv4U5OM55ezacpIQA2289opTNtfVa4/cxgRrOdxJs9IeQtIJ4+Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=WOddVjmw; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109c63e84so36168731cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755440835; x=1756045635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=maDtJ/OnwRzl2mzIghqGwSPF8ovKhpPVT9edc4eCiH8=;
        b=WOddVjmwX1cayKg/mSl88CsPX8QnfbVX4kuBoisupimerSVu6XvtpA8bg90gE4R/QW
         M+1d89Gkhhwi75mL6bOhMtvOGIVy9ttl4pdtr3p7NL6+Km1Vz7NnEtksa124k/kPCZQg
         szKZywRJcN64r8BJnxHVK1v6WDq7U7mkj8l8WU5jKKszOzjZFaGnvRJxLe8S0l+Q0v+H
         Te0VRODB+dINAY0TNRRDYW0HLIam68oPG1VMfqwLBc7eHM2W62wXRQ5zn847phdSxkaU
         gvTdGnaN5DzuKsVgqk2qNwjEOfRwM+IJI931iVUWQLZfR6uiDm06irgg0wfuw+isyuQH
         vCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755440835; x=1756045635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maDtJ/OnwRzl2mzIghqGwSPF8ovKhpPVT9edc4eCiH8=;
        b=iGkYffMrhd8FGCbnG+cCWYyMj1TOvLi6C8y7QDatACH1mKAEdPtH5UxRoNzR9XsgEd
         HIPuYvnbdAgRe2abwne/JSpBsHsAFCRy9gGZoBLst5H12xUafFA/k7Vw72rgaXQ6bj9W
         NiEzOPcpBzXVdTSyXH34PIZSHvBL6j8KvNs+dgtej36OgD+CKzayWbwf/ULU5KHTk9C2
         yl7KwO42E+A+3OD9CB6Au8j4obU3+RW6jpm4j7E6MEGT7o+DzuK1mcAhvvgI2A98Rxwf
         xGaYQ4y130Nrifub1WajHofsjB0piONx3/Eq4f9giuf6kHvOa7KEA2WAvEubSalc2Q9D
         BJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9zHMrSULiiwLht4u10LkP+SMT0pCYom+ol0h6Gh4Uqhcmqp6iFg0SbecJewQnDu6GQEKIxOzmzMEbnEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9j2966I9Y2pIvIACfbBG8uCD4S7HV17+uSnfXJXgzNXdQhI7d
	c9cs1NF0o+cjdtcRkCXa/WiDiil9usLZwUV9vlblnvxg9UfTiibKz93JtKIk5FhNlA==
X-Gm-Gg: ASbGncvREr0pFuRloF+/MGvT8a1L0UKqcMySptP27LAZPmPhZydAIHY2C3VXFQ3GWCj
	gw7dlSdBY6G53rfdPOmGq4+u9YPR+1H3BRa6rrvMdbwWSloU17Q8zkWaMVN05GzDwdsabDSzFZo
	i5He14RxrIk81/aaKR7smjGErIFSM+uNnPE12uMiP5yV40CFfmODV4bDG4MWxCcuHiBirctywfJ
	QxGfBtfMDsBOJGm95QR9HooBCKs5tSrS0QWX7ObKEEr5pFdXYRdoF4ORS+/0GXtCD6BQPdyozBc
	hbp2SpzdKjHy6p7y1CsTWPg2Mr5h+QNaH/lvJZgKBzrUVQ42DSAv7liIZ4ZaRHHlRe9ny8a/tr6
	AtPLiVLoJGzRGN/RJjlmmdpHPP8Nh94ppu4nrdA==
X-Google-Smtp-Source: AGHT+IE7mcvpDwN6PKRambQsOmtvuGU5trnDeiipWqjRmMVW9O5h9Q9S2jd9sA9uj5EzwPmhQmqFRQ==
X-Received: by 2002:a05:622a:4c17:b0:4b0:710d:3cbd with SMTP id d75a77b69052e-4b11e060063mr103987241cf.7.1755440835014;
        Sun, 17 Aug 2025 07:27:15 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::f777])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd8727sm37627401cf.39.2025.08.17.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 07:27:14 -0700 (PDT)
Date: Sun, 17 Aug 2025 10:27:11 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [BUG] usbip: vhci: Sleeping function called from invalid context
 in vhci_urb_enqueue on PREEMPT_RT
Message-ID: <2bf33071-e05e-4b89-b149-30b90888606f@rowland.harvard.edu>
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
 <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
 <28544110-3021-43da-b32e-9785c81a42c1@kzalloc.com>
 <1088432b-b433-4bab-a927-69e55d9eb433@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088432b-b433-4bab-a927-69e55d9eb433@rowland.harvard.edu>

On Sat, Aug 16, 2025 at 10:16:34AM -0400, Alan Stern wrote:
> So it looks like we should be using a different function instead of 
> local_irq_disable().  We need something which in a non-RT build will 
> disable interrupts on the local CPU, but in an RT build will merely 
> disable preemption.  (In fact, every occurrence of local_irq_disable() 
> in the USB subsystem probably should be changed in this way.)

Or maybe what we need is something that in a non-RT build will disable 
local interrupts and in an RT build will do nothing.  (I suspect that RT 
kernels won't like it if we call spin_lock() while preemption is 
disabled.)

> Is there such a function?

Alan Stern

