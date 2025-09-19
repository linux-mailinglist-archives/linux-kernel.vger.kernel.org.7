Return-Path: <linux-kernel+bounces-823979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0319DB87D93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3271523422
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387F242D84;
	Fri, 19 Sep 2025 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iX/15VGS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F41C862F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758254665; cv=none; b=k+SjJ4V69VIQAITjpHgzKIR7/RcKZBgTiYCiblCJ8Vzz19mYGoYL0MguLFfbzithJVFyoT+7gzWzNdYgsckQIPqJYK4H27AVrajf6SkA4cScXOVYbFpHkIlo4oG4zfNnizOnizQBfNya5sweQcsOLBDAF8wkB1sGOZbqYNFyuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758254665; c=relaxed/simple;
	bh=NqkZnCizAbX+o9YIAhQw0thbKtUrquiDNFODHQ1hcyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCsUVAYHd4Ny+WQen98B47jrHN6LBRJQi3a7wrvp2rdg3+5+KjuzoH3klXJ5Z6EKiKMJqT/9F4MhTMU8Sqr6BA3aeGSVvdOeRkYyORn2kaGOBWZrjlie1kxK5e5kQUv1pDxTzcPg1kvATglZmVEBjQ4SpN6zVTX1HS3/2eW0QTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iX/15VGS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758254662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJFVTJYb2/ev/ctsj3imyOHvTHcYX61/HGTQGEX5Mzw=;
	b=iX/15VGSdbfdcw7LqyIbeJCTbqnuS0cTNUzIMiWthf0jDrkjU8+LTaowk4qJ+Ud2/b2MqK
	OTzNP5/QRu0Z8AgnKTgBI68zO5y0xzG7ndWmi65LPy7eCWShPqKlx9lzdDZMeoSCCih8NB
	is6EMKIne8QRqcSYjSIjrIyhgSx9WoY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-lpOjRzIAOV-ZhHf9oUdMcQ-1; Fri,
 19 Sep 2025 00:04:21 -0400
X-MC-Unique: lpOjRzIAOV-ZhHf9oUdMcQ-1
X-Mimecast-MFC-AGG-ID: lpOjRzIAOV-ZhHf9oUdMcQ_1758254660
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 879681800576;
	Fri, 19 Sep 2025 04:04:19 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA9571955F21;
	Fri, 19 Sep 2025 04:04:15 +0000 (UTC)
Date: Fri, 19 Sep 2025 12:04:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] ublk: don't pass q_id to ublk_queue_cmd_buf_size()
Message-ID: <aMzWOWxelzLme6ZV@fedora>
References: <20250918014953.297897-1-csander@purestorage.com>
 <20250918014953.297897-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918014953.297897-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Sep 17, 2025 at 07:49:38PM -0600, Caleb Sander Mateos wrote:
> ublk_queue_cmd_buf_size() only needs the queue depth, which is the same
> for all queues. Get the queue depth from the ublk_device instead so the
> q_id parameter can be dropped.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


