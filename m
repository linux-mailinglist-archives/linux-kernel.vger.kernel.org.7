Return-Path: <linux-kernel+bounces-825575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D36B8C421
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2813622373
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DBF27B357;
	Sat, 20 Sep 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHiIvHSM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3750A1E9B1C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758358369; cv=none; b=J6g+WSty0fFFb/PhPZh8NDh8Xc0PVZf6KDSvXeeukn8HiJykIiuKmq+Eb8PSTx+DhJ/Z+DzsGb+Y8tfjUR5QJjukun6YOlAzLvaZBJNkpbR05THfXYMmy4ufDMxiuA3fTeWFaNoN4xCv5qPKvp4K8CHGI5Ysjxev5JPq43o7dms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758358369; c=relaxed/simple;
	bh=jl4nXCkeF/y/rnhr5/CSMV+KLdXpRTvFcE+ZNU0fuJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th972f7700J/WQ0wVBroOM344ZsZZk+Cb3+c5k5z1mZiJXvPdhxLIAVdlMBRs4jkG8MdiJ9ojFVPAAxFz+7tgGvIxKfTcElK7oOL24/FjbUonuISRx1+NzinqCJvmI537wL7g0TotEmT7yw29QPh7b15Zrku3lq2FwCPwjgRjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHiIvHSM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758358365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h//h5J7OveIUfIalXM927ElnUVTXbmggL7PCGVQuOtI=;
	b=jHiIvHSMb4a5hgnG5xy2qAmyc8iuuDkG4lqJGzYygJ1UwAxcTlRdbVEiyl4wAJfFD9u9tt
	fQeCguvf36VZv7a5ptKWpG52KLcH7u34rnKuP1WEoYiS/fH/NTtTKMsjTQQ5p37ceOgbMD
	7Of2eFwnzR2UGZOkHAqMq2ryLr48/8E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-CwGroWpzPG-oObkBfCY9Ww-1; Sat,
 20 Sep 2025 04:52:44 -0400
X-MC-Unique: CwGroWpzPG-oObkBfCY9Ww-1
X-Mimecast-MFC-AGG-ID: CwGroWpzPG-oObkBfCY9Ww_1758358363
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B93991800357;
	Sat, 20 Sep 2025 08:52:42 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3F5130002C5;
	Sat, 20 Sep 2025 08:52:38 +0000 (UTC)
Date: Sat, 20 Sep 2025 16:52:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] ublk: don't pass ublk_queue to __ublk_fail_req()
Message-ID: <aM5rUaapDsaXiEK1@fedora>
References: <20250918014953.297897-1-csander@purestorage.com>
 <20250918014953.297897-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918014953.297897-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Sep 17, 2025 at 07:49:39PM -0600, Caleb Sander Mateos wrote:
> __ublk_fail_req() only uses the ublk_queue to get the ublk_device, which
> its caller already has. So just pass the ublk_device directly.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


