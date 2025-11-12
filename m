Return-Path: <linux-kernel+bounces-898260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E1C54B45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EC83B2A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5921C2F532C;
	Wed, 12 Nov 2025 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="h21Y62F3"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C857F2E717C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985995; cv=none; b=plEEgnZPrVz2Ml+jJ973LCpUaPzYvz4Y2Iv9DTgfNALUtjdmzukaJjjD9FvzTEZZvcPXk28FTwZk2MGZhB+VCPWw010Kl6girgWqkGj83b+rLQ4yqJb2zHfEOqY46FuOJ5+Cpj+HRSBRaLfiLGwwMl5EDB+f2NeIg1JLIeYABJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985995; c=relaxed/simple;
	bh=unLPp2rzYuoxWbtv89S5pYlQJKMZKA9scZeJBdGlmIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmGJrdU1BRfTYdUwtN9L4qLyHN7MzkereguYACNWy66yjG3Xiuf+j48Dzq6qAiWyxnOE+C3QCwrSDANv3dog6Kw/ihMwz/CdsjSRMgtN4hjfS7f0/At48wNoAkvhUJ/q6uxVGBjcaNRBjQCilHFhgH489aKz77REgf6jBGN918c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=h21Y62F3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b75e366866so72699b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1762985993; x=1763590793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4g6kCT4s+7bhT0JH0DcrOQKdbv70N4aP0FSpxYAN3OU=;
        b=h21Y62F3TnPoT/SDuFCnWTWTVK5Uu/nh99+qyYrQ2kunM8H3u509FyAKpj73lkndQH
         tcD1D5yGnsUcoaT6BWyoiT1P7BZg4j8nN7K8fdTEQo1lH39K24JREqRXeGjDNa3L7kf+
         S8RftXpP6jMMUCNqY+2mPAE3ox3W7tASFudljD8jy849myNUfVE7SjDLx8VkTwdif+JH
         hVG+Rf6l6YOpu77Gts5RgKvK61aqspAOSSfU1GpO2h2i9vTcDxgzu/iF6s2y5chQ9kkK
         3JxczHuJL4+5nTJC+zhlkj50x1ZxiTZ2Gnng3MYlHCx8dwVEeBJmU53K7KHGLz3/UU64
         Kl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762985993; x=1763590793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4g6kCT4s+7bhT0JH0DcrOQKdbv70N4aP0FSpxYAN3OU=;
        b=PQSrw3O4i49aEA57GAvdVYSfentuirmDsXuey31Tylo7s963+HcoP12jJUKAuBeP+5
         PDz/wPd2brg7kDOiC4u6WPXln84Sos0zRCFhiHjf6D7qkg36t1bow1iv1uqdjceTVLhq
         eDwubyjpawasPYZd9OaD37d+1sNBuffM6nA8nprYXe6Jah9zPBrKlACwbpcVrf4jL8xI
         FRJiV2LFpedLzV8Wsls55TpWCEU9/9dX2OyxBFK9rYXiDniUn64ri+62mu3FHCdOD/4Z
         6dRwOXbZVQnI6ELHV14FnpV7e3yrriq3zk7siThOMIUZ8l5ZuyEFkoKsdpELcDAH0jNp
         OasQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFb/pNnwVyu1VQrDoAX/6yoMnB/C+b23u1L59xrXRiuU4owTNy8toEIo5EzU+DFUBK0EAvnEo0XBHvsl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAsAaNOAXUajnyz3WyCLMQvkljLPD67ZZl6vfg3RkTU4/DTyr
	nLBfGXI+QWVajlUnuO/uPXO9/O8iay2OfIbcnX8n8Yn+Yp410DjzugOXSGBQQfjZeDs=
X-Gm-Gg: ASbGncupadjABVw+M9TnJ6iWYnxAbLWD65Qwhze7ALFx2kV4wNdY/W8z1FN5HBLUi7r
	o4O6MOdmUhP5qzJDR1nMcQcEFrExwfZKOzypCXKdcqK0RYIsdtWa1CEzF+V/a8LGYTQOfnm//J+
	2/Ueb+s32Fnq/GoNemo4ynyW4T7ZZmKEnr/gbYIC+NB4NIs5jhjW0knuIF7EmB0ZSxWsyH3nTAa
	b1snX3bw53VJs/ePLmIJOTVCphdfQau+PiMloDqoMxVamlLwS5vXurto5dIJaFmS0Y9FSNkKlY9
	AaaFlPwo4mellPfsE5wPi/Wiquh/3IAhY6dZfNwC9VqqJHrTTGvg2OTjPs+84349H6Cc5aFUh9a
	PpofOQoO9AjoB3TCyZZwu4F9alID+CIqvKojPAkm8OPYr5VXdgF9w+ffyHcD+7RP8HkITHtaKjP
	a6fCnRCrRw4/t53syc71dpsOTY5Vy4L4M/sCz7NnoJWwCCR3Kf4DE=
X-Google-Smtp-Source: AGHT+IHAa8tCyfwo4LnzmXlglXEr2HrToLcPw7JFbhkznGZRRLapV1K3KjrEoN6EGIup6pNwE09Bkg==
X-Received: by 2002:a05:6a00:992:b0:7ab:2fd6:5d42 with SMTP id d2e1a72fcca58-7b7a48f6387mr5692995b3a.16.1762985992953;
        Wed, 12 Nov 2025 14:19:52 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aea005sm80341b3a.3.2025.11.12.14.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:19:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vJJBu-00000009zUN-0VHA;
	Thu, 13 Nov 2025 09:19:50 +1100
Date: Thu, 13 Nov 2025 09:19:50 +1100
From: Dave Chinner <david@fromorbit.com>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: cem@kernel.org, djwong@kernel.org, chandanbabu@kernel.org,
	bfoster@redhat.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfs: ensure log recovery buffer is resized to avoid OOB
Message-ID: <aRUIBj3ntHM1rcfo@dread.disaster.area>
References: <20251112141032.2000891-3-rpthibeault@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112141032.2000891-3-rpthibeault@gmail.com>

On Wed, Nov 12, 2025 at 09:10:34AM -0500, Raphael Pinsonneault-Thibeault wrote:
> In xlog_do_recovery_pass(),
> commit 45cf976008dd ("xfs: fix log recovery buffer allocation for the legacy h_size fixup")
> added a fix to take the corrected h_size (from the xfsprogs bug
> workaround) into consideration for the log recovery buffer calculation.
> Without it, we would still allocate the buffer based on the incorrect
> on-disk size.
> 
> However, in a scenario similar to 45cf976008dd, syzbot creates a fuzzed
> record where xfs_has_logv2() but the xlog_rec_header h_version !=
> XLOG_VERSION_2.

We should abort journal recovery at that point because the record
header is corrupt and we can't trust it.

i.e. A filesytem with a version 2 log will only ever set XLOG_VERSION_2
in it's headers (and v1 will only ever set V_1), so if there is a
mismatch something has gone wrong and we should stop processing the
journal immediately.

Otherwise, stuff taht assumes the version flags are coherenti like
this...

> Meaning, we skip the log recover buffer calculation
> fix and allocate the buffer based on the incorrect on-disk size. Hence,
> a KASAN: slab-out-of-bounds read in xlog_do_recovery_pass() ->
> xlog_recover_process() -> xlog_cksum().

... goes wrong.

....

> Can xfs_has_logv2() and xlog_rec_header h_version ever disagree?

No. As per above, if they differ, either the journal or the
superblock has been corrupted and we need to abort processing with a
-EFSCORRUPTED error immediately.

That's the change that needs to be made here - xlog_valid_rec_header()
should validate that the header and sb log versions match, not just
that the record header only has "known" version bits set.

If we validate this up front, then the rest of the code can then
safely assume that xfs_has_logv2() and xlog_rec_header h_version are
coherent and correct and so won't be exposed to bugs related to an
undetected mismatch of various version fields...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

