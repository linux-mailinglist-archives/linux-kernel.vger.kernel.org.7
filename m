Return-Path: <linux-kernel+bounces-840046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051DFBB3676
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A74716D686
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763772FD1CE;
	Thu,  2 Oct 2025 09:11:03 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605262F998D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396263; cv=none; b=SYnGWKRJChnPxwuZLB2YAFqdu0MrLIpBDzhxOOT2+XRBjhGxAeifFZXDHalTKVSVZQw+sEJdFsxEKJpfkExbrA3/2wH4mluLHUBZBZoXEXRzod/nkWP7/gTNT2S2sBkF18rpB36+CfxvSPqXQwkb+cnFWlg01WsuRcIScHUapDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396263; c=relaxed/simple;
	bh=0x4mni42h3u3+Yk8psdRxeM5zzr4vUX2feS9t68m2O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd8IMUNJ4HUW6vDo4xakvkjYfjWcg/iNSZgFViPhK5YpQr0D6MHOlfHhLn5/Q21a3QoZ2QmR1ztPFiG4pG/2yLrzvbR95d2pm4OoTrQgKk2JqU9/at+Yrdff5tyUpLC+d500JJ7nZt0Pk6bm4WSgQuTskUc5jb8xdqI+UIuesBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-634b774f135so1452995a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396260; x=1760001060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRDmlXYbuy08sNt5xF8Zckv3BDEt/TW4zDdfvpxaR3k=;
        b=peJUR5BV20+2uFrE7scapBz1AzeIkV+rsY5ba7dhmi/9/zGKCuETp8TIQWA+VzVSq5
         yvpHh3/VwkOFilzvWCBpkaKHghEJB4pe+/OvI6lL7+lh5bw/k7eKbuo/awiyWn/AAl6s
         rulkRjZLgemxWOoh4WJls7uakhPf19glUGQ/IzQJGtg5y85zUBJKR2Q2zPMm3bDoCjlP
         hkrJtw/FR16v0nmR+L8y/1q29VHsmRQmp5FyE+IjQHAgY2kcfIYH73xP4QdblJrtlqAu
         b/56aZWPoo2Xfo+fbDWu1ve+z67QhcrWppAwNZ6+VJaCVqJtVEp8No4g62SKDJXMUfY/
         mRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3rT63Vv6upmG3AdxCFQbTpu1CDvEKApIaugiqFajAOaOtriUanehJUeS3o6iveNU8k2OXQwBYk8JVW7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRax5vNIpxUag0z8SjFWov3oit6vxonj6DIvolyjTk/fNYu6lZ
	44zNGWFsw+mFt0zRtPl5SyBCDjuGPJpEOUIiYhBXpejARxLWYsxKn5Cv
X-Gm-Gg: ASbGncttjsaU8tKcSWkoUjG1ivWaiWe8tbOqlznlKn8Ob57V3f5cSab2551oMjYImvb
	k8YS4kAVgvsi+rM6a/v9Z2Ko12WH5JoPEZdoZWPLHZFzVmxJXfNzSQ08GBmuqivMHRKW5VJzt9o
	0bb0hYLJe5vLxS4jXdr8d6OAkc8e2xitKvMR5uMLpLxB8CDCPH+b46WUzYie07rAMgiEcXefX7n
	dspONMbJOHqwE49gRbjAHCLyjN2t5T5JWdsKFZDZNvpbvOnxxLpyrG2SR/0ZdaKF8J+RjSpgecY
	5lPZ0ipGvUXmD1ZlNeW2Wi7IqgB7go0bK5ibn82oIh9UlI0iPJQy5l+Py41ExVGov5doeNnyZFf
	+FxO4LbB7oW+fOYWSWPaJAjgHdkhFWc8qcT3Cnw==
X-Google-Smtp-Source: AGHT+IGI0lLEvsbF1QPCvI8L4Q/FaURN2Mex33lSpcN9SL3uUzSJV82rsbQoChB7SREpyehAucnnhQ==
X-Received: by 2002:a05:6402:d08:b0:61c:8efa:9c24 with SMTP id 4fb4d7f45d1cf-63678c9f53cmr6776854a12.37.1759396259611;
        Thu, 02 Oct 2025 02:10:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637880ffa4dsm1428844a12.29.2025.10.02.02.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:10:59 -0700 (PDT)
Date: Thu, 2 Oct 2025 02:10:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
Message-ID: <z5thnuj2nwzuk7wp7kentekm7zx6v6fh5f6zknerdbld665guo@6uxxl7emi3be>
References: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
 <20251001213657.GA241794@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001213657.GA241794@bhelgaas>

On Wed, Oct 01, 2025 at 04:36:57PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 29, 2025 at 02:15:47AM -0700, Breno Leitao wrote:
> > Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> > when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> > calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> > does not rate limit, given this is fatal.
> > 
> > This prevents a kernel crash triggered by dereferencing a NULL pointer
> > in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> > AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> > which already performs this NULL check.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Thanks, Breno, I applied this to pci/aer for v6.18.  I added a little
> more detail to the commit log because the path where we hit this is a
> bit obscure.  Please take a look and see if it makes sense:

Thanks! That’s exactly what I would have written if I actually knew what
I was doing. :-)

