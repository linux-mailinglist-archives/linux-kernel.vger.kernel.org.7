Return-Path: <linux-kernel+bounces-889577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469CFC3DF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00173A6B9A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428AD1E0E08;
	Fri,  7 Nov 2025 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Akz8KBo0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A491DE4E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474258; cv=none; b=KohNYlIcSfz4EN6VQGsk6T9ZEvkLj1y9WF2PzVwHalNatBxYFaGCE7jBQi6OYyVQXA7apQBXFNZFi3pepvLOJWrVAm3ZeKLTFVr438JUiWWlWJ55ZMBt0LcVu+1ualxyCzDHC7tIHZnhNag9q1q23o6xs3NGYowcGjvH+9w7PSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474258; c=relaxed/simple;
	bh=YwGnfZV13ZP8Ogk95cKBeclXjRlSTKAjTiLl25kTRFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQnBP9vYl3Kc2q6O5HdhQ0haiiZ+s7H4Wd4NscRlNjlpj94v4/hoDC9g4um2hM8mwE4FfOZm7svCOy+c6IVcdURNGwUJ6HoKLx16V+3rAWlQPurVxTM2+PNljdKPsEVA5I566HK4HGigu9M/Plg5xYDNM2pBbAHOTi643sStFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Akz8KBo0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762474255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmkS/EwwmVv+zOfOfidDYpacGfbtN7LhsV4QegBVAFw=;
	b=Akz8KBo0cUStYjmlIX1G3T/OtOjgXfkMGmWNA+yVZsOM+z7652uBuLDIRCzSPPZX2IEDYh
	4NEuDEpP+v/12hiEJbjO3/uQYBLgzFQd8J3O9JPkBawT9T0TmIaseybxfiOAmkUCMhSg91
	08U/n4hYBDNriD/z03nQ44naWjg4k9M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-wFoTcsUIPsu0t6itzAX8GQ-1; Thu,
 06 Nov 2025 19:10:52 -0500
X-MC-Unique: wFoTcsUIPsu0t6itzAX8GQ-1
X-Mimecast-MFC-AGG-ID: wFoTcsUIPsu0t6itzAX8GQ_1762474251
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C56718007F2;
	Fri,  7 Nov 2025 00:10:51 +0000 (UTC)
Received: from fedora (unknown [10.72.120.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64D8519560A7;
	Fri,  7 Nov 2025 00:10:46 +0000 (UTC)
Date: Fri, 7 Nov 2025 08:10:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ublk: use rq_for_each_segment() for user copy
Message-ID: <aQ05AQOlm4pDnELt@fedora>
References: <20251106171647.2590074-1-csander@purestorage.com>
 <20251106171647.2590074-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106171647.2590074-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Nov 06, 2025 at 10:16:47AM -0700, Caleb Sander Mateos wrote:
> ublk_advance_io_iter() and ublk_copy_io_pages() currently open-code the
> iteration over the request's bvecs. Switch to the rq_for_each_segment()
> macro provided by blk-mq to avoid reaching into the bio internals and
> simplify the code.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Nice cleanup:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


