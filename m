Return-Path: <linux-kernel+bounces-769511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A0B26F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2265E7E53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA2C23D7CF;
	Thu, 14 Aug 2025 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Sk+EMZw3"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7C22A4F8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199169; cv=none; b=bCk6KDWFdFL0gi2u76uL1/EbpUGDEec+BhFqUN1LnZjxP59df26plC6Tai5snWs6CtnZjxi2Uu3aIFaeYmCOKx2DDKZbJLwMaeYMTk4f8weFdpcr+XZ42MvpcE7FU+7nev96zYYnnLJmam/GXBi7gGDaQfAch9oIEqnXzx9WGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199169; c=relaxed/simple;
	bh=GZrMOqecm9CAXjRBdYJgjbJgjQE37LwuoMcleOFOzN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cD8LGi/C8mZxZEVaMBjvuIzXj04MkWyn1d1zTcJXTUprcR1GcMsnKO12uA/2oSa+qNLfsIqIvIQ/XzWLDU7saxMfurjUfCa9hhfvX/vNqrqDPAY9UxcNDV7zziXgHqPsFg2QH7IMUHDL3N4P8KSQZAVtNk55iNpTUEfZcPnuobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Sk+EMZw3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109bbea05so18907681cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755199167; x=1755803967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GZrMOqecm9CAXjRBdYJgjbJgjQE37LwuoMcleOFOzN0=;
        b=Sk+EMZw3gtt1Kc+KQUk0IjMhmiwSweTjX3U0sQuDlp01ImsScESjG7DfPaSp7gQ0xB
         jnSDNwCcV+5rVjAkep/QGQNNXtX619jD9ntUjcq3Vgq3o/gwXuciuUtwSTUJ+yCGU+d+
         650qXU+NziDKW25fY+3FsI4l3NEXHsD6y8rtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755199167; x=1755803967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZrMOqecm9CAXjRBdYJgjbJgjQE37LwuoMcleOFOzN0=;
        b=DAob99PLR2CFVPwxNOkxr4gSNeLelMLKBhhkMMo76HJIGjKjUNphMNW1WlPJjY3Q+V
         5ONfjpLFUOEH1go4kTqzYM+BmRPciR6rdLpPVJVwgbFjmPbtuL/4kSuexFWjOoGpUdw/
         7apuV0UvubcykuogMS+8QXA38EDRpmRATtteftBZzCF7rt3YL4qkynwTpZpHiPMhQRkG
         Vcyn0DxRvxn4hEDWzs7q/IBNJ1OmEOrj8+hT4p1xG4DcbjhXFK7dnPCga5XrheK+WUZx
         MGEEgOtHl5eA38c6MvXJkk3t1caSxUaMjIcV7Qwt6HMbPLFuUbUy9zN1O7ng7m8VnvKz
         owVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV62m+APvOvLBiT6lYba55rqBdT94lq7sLDhiwk7KDVg7Tz4b8lg/mNd9GtATdW9ECoBMpCihwgyU0sawg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoS4DbddUX9BqcRiPr2IpFSvG3x9jkwnQSlFlM9tVqDVYlO0rt
	DczYofCscqHGLmMYkcQ0buQOwji9IFtvmLypeaJ4JOfxn+WiD6ve50nKaHoE04q1Tx3E4aORUor
	aLxMrN7VxlUEwV78J2kIWiFZbV2PbSvvk9QCJPdC0LA==
X-Gm-Gg: ASbGncu9EKDKDzuNvMORqGLODrWP5+OPtuvINIvPYnICa4hqLEbuX1vP5C6fRvZkVM7
	jG0+mnwu82fWywqCgfJ4kgobllkwcZeQ67gdsWDbKaJ5tpHJDPAIGR6OIUrTFVYwyMm5jeG43Hi
	kev6vD9fv/9EISFFJ+aLFTbSRewB9Q9CxeVw7QbovUdebJj/3vAdyz40Eoptvi3VFObkUCdsINa
	KkoMkI2if0+WsU=
X-Google-Smtp-Source: AGHT+IFYsASkbgj8LKOURL/sQT2BfijqH2fGAl8jogtfvvYUVEiGcWyswxRpTwKUf9rW7ApmSBhJ6Ltm7fsi8IzNXrY=
X-Received: by 2002:ac8:7d43:0:b0:4af:157e:3823 with SMTP id
 d75a77b69052e-4b10ab61354mr68262251cf.42.1755199166768; Thu, 14 Aug 2025
 12:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
 <20250814171941.GU7942@frogsfrogsfrogs> <CAJfpegv8Ta+w4CTb7gvYUTx3kka1-pxcWX_ik=17wteU9XBT1g@mail.gmail.com>
 <20250814185503.GZ7942@frogsfrogsfrogs>
In-Reply-To: <20250814185503.GZ7942@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 21:19:15 +0200
X-Gm-Features: Ac12FXwFvJoOQXfTVyVQkORoWxApgAqsvX9WIX8VNMR4nJ4kVqHzj7yLc5euRJ4
Message-ID: <CAJfpeguxZVVddGQsMtM35tVo0dD118hKBf9KJcuhSBznzqUzSg@mail.gmail.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 20:55, Darrick J. Wong <djwong@kernel.org> wrote:

> Or do we move the backing_files_map out of CONFIG_FUSE_PASSTHROUGH and
> then let fuse-iomap/famfs extract the block/dax device from that?
> Then the backing_id/device cookie would be the same across a fuse mount.

Yes.

Thanks,
Miklos

