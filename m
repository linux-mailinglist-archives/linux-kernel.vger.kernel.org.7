Return-Path: <linux-kernel+bounces-681976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE8CAD59D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 17:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9BC7A1391
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041471A23B7;
	Wed, 11 Jun 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JScsLV/K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B891AAA11
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654658; cv=none; b=ZaUXGqd6tS5nM9+E1b1f44Ite8vDeq+Gy31TRj8qfJYj2BXSKN9NTkz3w8nnH30lrG3N7UknwwMBlXe0+JQstlWzcvC7P8PxR+YtGyluF/BrByUGcfDMpm0f3c8i614vlLl59c16RukwMMfWeCDePUqPhN+c3rPX8a9pSFG8JYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654658; c=relaxed/simple;
	bh=J+Cb82L7O/BiPrcKvhRJcV6B/aNRdSmFiESgx/lMDDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAtVp4G2w6cI4e6/lHCLRwC6J9QARLFcOSe8taxI8Qlq3PSzW2CDHUu0L7M6brQljTMzQ9pyE9fG3aLgmsv86fVYu2SiiQ0udN3d6pdCkGuP5Fwsegn0O4X+7++O6KylYLkHn6pMyy24/IHXar4CPknp9fcshiRUu+nwKoOFmM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JScsLV/K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749654656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWkNewhRJ4wpEDm7PPC52E6cJKu2Um4iV+x8uvVQe/M=;
	b=JScsLV/KtUrpiA0pnXR2BkEBSFZT7NmWqy+BJGT26Zg17L2fv8Tx3Rz/yLMwcgOQ+fOAeE
	Zh5FGxkct/lSc1+7Jlisow85HN8IhPP3RkrnuYXNm6FpyU00lLIXNHT2cPRSWxk6rKBxhr
	7bsPNkpxczW91F0VWBUaGTkouZI3PXU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-zveqg8ABN8KQBI07Ze_SoA-1; Wed,
 11 Jun 2025 11:10:49 -0400
X-MC-Unique: zveqg8ABN8KQBI07Ze_SoA-1
X-Mimecast-MFC-AGG-ID: zveqg8ABN8KQBI07Ze_SoA_1749654647
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69F09195604F;
	Wed, 11 Jun 2025 15:10:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AFD11956087;
	Wed, 11 Jun 2025 15:10:33 +0000 (UTC)
Date: Wed, 11 Jun 2025 23:10:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
	Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
	Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
Message-ID: <aEmcZLGtQFWMDDXZ@fedora>
References: <20250611121626.7252-1-abuehaze@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jun 11, 2025 at 12:14:54PM +0000, Hazem Mohamed Abuelfotoh wrote:
> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
> 
> Commit <e70c301faece> ("block: don't reorder requests in
> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
> list, this had significant impact on bio merging with requests exist on
> the plug list. This impact has been reported in [1] and could easily be
> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
> having any filesystem on the disk.
> 
> My benchmark is:
> 
>     fio --time_based --name=benchmark --size=50G --rw=randwrite \
> 	--runtime=60 --filename="/dev/nvme1n1" --ioengine=psync \
> 	--randrepeat=0 --iodepth=1 --fsync=64 --invalidate=1 \
> 	--verify=0 --verify_fatal=0 --blocksize=4k --numjobs=4 \
> 	--group_reporting
> 
> On 1.9TiB SSD(180K Max IOPS) attached to i3.16xlarge AWS EC2 instance.
> 
> Kernel        |  fio (B.W MiB/sec)  | I/O size (iostat)
> --------------+---------------------+--------------------
> 6.15.1        |   362               |  2KiB
> 6.15.1+revert |   660 (+82%)        |  4KiB
> --------------+---------------------+--------------------

I just run one quick test in my test VM, but can't reproduce it.

Also be curious, why does writeback produce so many 2KiB bios?


Thanks,
Ming


