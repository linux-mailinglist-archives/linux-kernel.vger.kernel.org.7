Return-Path: <linux-kernel+bounces-750058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626B7B156C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6B543682
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE751632DF;
	Wed, 30 Jul 2025 00:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DbsWvAkt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1876034
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753836730; cv=none; b=DoSou8liBL5S8ksabr5bk5+fRpeW/rW0bgKvungmape96tUpFtICjfrSMUX0KGZzyy0AurJrXAkeNrsx0G9D97gE48SiTB/GBKwDEPmTLbzdSonYzTCtSj1muZf7+sbr4B+m/oHCwlAvu2u5Bn47KA6kvFNmQRRPbceGS7zcCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753836730; c=relaxed/simple;
	bh=K55yfrmOAgZyuht6by9RhaCl9tnqxjffX2Sf34/XSXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXdmE7AhEPosmNp/A4koqk+lUBYQm3/0ChNR10/hqrQBTgiyLvPVQz+ORoukfiUuAxDISCe5ygPaXT1zVtHl7i7nDRAfcfi+ephKNkCUb2f6fuvKI2JTzNStKf3R33TQ6b0CSa8NkPNqmLVsPmMeDedMZI0jsihxxhC88zjc94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DbsWvAkt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236377f00a1so54871965ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1753836728; x=1754441528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3+0fPD4oAPKgGx3/6LlKQLIWFdF50ERDWtVLnGX0c4=;
        b=DbsWvAktSLQ1q9fV8KALw0+r98lpxiPmqf/2V1w4xB+PJREVmlF/M3lUOj3vb7id46
         MsXaONMIE2c814J8VQzYO9/8W30oHV1GNYDnUsSQ4mIpdrcSDN9W9bsEccKAiBL2LmHl
         41aubhn+Yqr6zsx9DcGCWkF1slzbkIFrFRr7vGXSFHuY6CGqfIe63Ljcn2dptkHBwvpp
         ItcV2cE1PpeaSj6Yq8T7X7/gf7lSV98OY+Xx9fVX9l6SgJPpQbwwpHAOp18Zv6es3X2v
         mVUw41y16xgZsT06zLEmkH12O0JZUpZVgy/+V7LKJv5rab1CLCrqilPq4FJN6cvq8qQL
         xQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753836728; x=1754441528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3+0fPD4oAPKgGx3/6LlKQLIWFdF50ERDWtVLnGX0c4=;
        b=pRHpWt+CkC0TQX1REyhX4JGF1bnXnHgLlAlVWLGk4iekatCoSKvb598tjYi21gfZTK
         y+7EWUKo0dutyzGlEYk2Abvz6OsRKTjKffl90rHOPq8TtRXdVVyDB6BaV7ZNMGHxxUyK
         OGSDL96AIReqiLn8lfcjhQOvHB0b1qYLIzkct5dWKPaxLmVbargYKIfYEYoaSotIMEe0
         W7zu6rniwed5P+zvvOiZSxaElDJmdv/AIaLgdoRRh6jypQyQLW0O0M1MD3VcAqgRY33G
         Bp46fLQ0niHYkc+AiH3/ywaFsUjA02QToUJyzK7nb2nuBpnTTyVgVJ/WgYaOjBbYW2ZL
         CYwA==
X-Forwarded-Encrypted: i=1; AJvYcCVQWFZ6KmUnNZdVz6Y1aV1bIiLvA3mUFQMZBs5g6eECmMmerMCToii4SOrok2WlRl+gwwS4LX9vswWDyF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DQJmt6oX6wKtDHCvPZA+Wi/5qhcJNZ4b5VqAClfVAt1tnjV9
	pwMztXn4JDdg4BpJt3dFXu93XhtKiKEutUyCRm4x2WtqPFr/URuDWLAvPJN4Ovw3+Hw=
X-Gm-Gg: ASbGncu75zd0q9ZqvMSYwAca/PbvwC4kmXcrG8deDGSSONtVF31kDOTCISdVEC/UkpY
	q9nAgE0BgP0CM38RRhgcX0Kvq7m2Ns3CMObli1+CSa1/u4tAWfEQmonfxOja7ULg1zLtOFTZEwi
	MF0NVAsVSe/UjSl8Wx+Cu4JX6ihYGQsJNCAGJ+03zOayEHCUSSPlScfoHk7b8V53jbofo8pCOpI
	ZJQt1KHz979Se0kayblJBNno6ozaPCbdGOpRw9YYtS4Kmn3H4S3LlrG4wwDF/H062qoQHtqG76N
	KdwSrMirVM0WLzIjl/tOD0QAukKpV140TV49e8HwZ5RjzP6GYslvXOnBdfftpC9LHXLNWvbq3P/
	Y3zPvwlMEzZcMnF7Y67Fhaj8Ds4ik+w69wnuCiUtnZwj1I2kuZhHSKuvtBvNiPxO/dlzNOBaCxn
	oM6CbALnOX
X-Google-Smtp-Source: AGHT+IHkORekrsc1P7gAq4NM+SMvbGxBMz8RFSwmBgPVjXtpoGecdqjtTizgxax0+6dsRPmU0LGDIQ==
X-Received: by 2002:a17:902:d482:b0:234:986c:66bf with SMTP id d9443c01a7336-24096a4f534mr17428045ad.11.1753836727661;
        Tue, 29 Jul 2025 17:52:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-64-170.pa.nsw.optusnet.com.au. [49.181.64.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fe648707asm76888805ad.135.2025.07.29.17.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 17:52:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1ugv36-0000000HNDV-0H38;
	Wed, 30 Jul 2025 10:52:04 +1000
Date: Wed, 30 Jul 2025 10:52:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-raid@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
Message-ID: <aIlstOWckYGw34rM@dread.disaster.area>
References: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>

On Tue, Jul 29, 2025 at 12:13:42PM -0400, Tony Battersby wrote:
> Improve writeback performance to RAID-4/5/6 by aligning writes to stripe
> boundaries.  This relies on io_opt being set to the stripe size (or
> a multiple) when BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE is set.

This is the wrong layer to be pulling filesystem write alignments
from.

Filesystems already have alignment information in their on-disk
formats. XFS has stripe unit and stripe width information in the
filesysetm superblock that is set by mkfs.xfs.

This information comes from the block device io-opt/io-min values
exposed to userspace at mkfs time, so the filesystem already knows
what the optimal IO alignment parameters are for the storage stack
underneath it.

Indeed, we already align extent allocations to these parameters, so
aligning filesystem writeback to the same configured alignment makes
a lot more sense than pulling random stuff from block devices during
IO submission...

> @@ -1685,81 +1685,118 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  		struct inode *inode, loff_t pos, loff_t end_pos,
>  		unsigned len)
>  {
> -	struct iomap_folio_state *ifs = folio->private;
> -	size_t poff = offset_in_folio(folio, pos);
> -	unsigned int ioend_flags = 0;
> -	int error;
> -
> -	if (wpc->iomap.type == IOMAP_UNWRITTEN)
> -		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
> -	if (wpc->iomap.flags & IOMAP_F_SHARED)
> -		ioend_flags |= IOMAP_IOEND_SHARED;
> -	if (folio_test_dropbehind(folio))
> -		ioend_flags |= IOMAP_IOEND_DONTCACHE;
> -	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
> -		ioend_flags |= IOMAP_IOEND_BOUNDARY;
> +	struct queue_limits *lim = bdev_limits(wpc->iomap.bdev);
> +	unsigned int io_align =
> +		(lim->features & BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE) ?
> +		lim->io_opt >> SECTOR_SHIFT : 0;

i.e. this alignment should come from the filesystem, not the block
device.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

