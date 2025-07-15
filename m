Return-Path: <linux-kernel+bounces-732599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA22B06958
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22294A4251
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04902C325F;
	Tue, 15 Jul 2025 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftvChQR/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911225E834
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619100; cv=none; b=Mafe4msly85BD45nrjbdVjRLX4qA2oUovUWvM6oLVT4pDHxkaV0mBS/WkQGGB45Ns/PAKXKXbK3jNS4Qm3eSZ9GGV1pyBeTcINMl63X4HJ6I9wvB4oC5+kagnoz/B14Bp782iOhrgvQfEEIEnHI9mIBVdJL41voukQVEYdfmkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619100; c=relaxed/simple;
	bh=m0EXv/giwwP0LsGLNE2kAtNFVh4aq00jvuG7BH6iKhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRWId60H+oeySoBtkSBrmDu4Ta8NinQTC1aNF+MusRgUph2SjV6zUjq7Y3zMqTxgF+jsOJ8+j8ZN8uE0V3jBmREg7xjZQAmLljcOn7t08tT7MuW1cOMyRwiY2PSjuS60NzepFczjNaKtNw/cOumt3b2y694PwOyfL8C0qatfYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftvChQR/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752619097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWauv4FuNsiIruk4vJlAJ3hxfktkhyn2XBOo/YagwlQ=;
	b=ftvChQR/oI8AK3CGhtPd9P/2/V4ukwKF1jpauJ7ZA40u0gUGv4z6FqVTtZZP0476YFDPQZ
	pgX8r3fa8k/6D1nJqK+j67ZVtq9LJbxoJUhkzA0O5tNXs2HbnnDQj018Q7q9meNcZKRTeV
	qxWhiHVe94TXcbtyY7EGGXd9oEYlPbY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-4DzBAuIhPbqeWUggQAPjSw-1; Tue,
 15 Jul 2025 18:38:14 -0400
X-MC-Unique: 4DzBAuIhPbqeWUggQAPjSw-1
X-Mimecast-MFC-AGG-ID: 4DzBAuIhPbqeWUggQAPjSw_1752619093
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB2391956096;
	Tue, 15 Jul 2025 22:38:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91D07180045B;
	Tue, 15 Jul 2025 22:38:09 +0000 (UTC)
Date: Wed, 16 Jul 2025 06:38:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: remove unused req argument from ublk_sub_req_ref()
Message-ID: <aHbYTI2g7RTmqBSO@fedora>
References: <20250715154244.1626810-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715154244.1626810-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Jul 15, 2025 at 09:42:43AM -0600, Caleb Sander Mateos wrote:
> Since commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()"),
> ublk_sub_req_ref() no longer uses its struct request *req argument.
> So drop the argument from ublk_sub_req_ref(), and from
> ublk_need_complete_req(), which only passes it to ublk_sub_req_ref().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming


