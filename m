Return-Path: <linux-kernel+bounces-717320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F4CAF92D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 14:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8873BBDBE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 12:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC72D8DAE;
	Fri,  4 Jul 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4t25NTX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E314A4CC
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632579; cv=none; b=VN9OqIsZVzqkboeEXqUs4dIJNJu5aPPimgDnCohdviM9SCeIWw/x8x1Qk2tQzkDYh3kFx4zlaw91R39RWPatCyDClwg1jg2bTh5XMIU9PNsJ1cmu9xoRJpOyHgS6FfXYPEdVevOaZH9P/N1z+blN6E0EwviJhl8U2exz/r7yeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632579; c=relaxed/simple;
	bh=1cMEumu8x15iU8LnBS5LWQDpEzhwTBOjXKozgW8HEoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tttkeZek5uppWrszy4VndqjnLjm450EZjE+XWbctoWTFeZtRgzD/uzup5nSP+Cy1WrvUbEwLoV7zZCvrLeS5kE+nzvhTx1RjGkF8Ma/ckbc/xK4bqkK1qOtFY37uPphnkhGabBwCzhdFcDnBYNLum49sBhGl+H0KoWPeRr/4JOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4t25NTX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751632577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQEvdZVXYD4Rzfbfk/BzwhMBQ2uGxip6fuxj4Mmr9Fo=;
	b=h4t25NTXdTKYAv/cgll+RPj+YmDjxIPVyy2guAySmBFNGODTYtXkbvCBbP13trz62mcewi
	TodflnDRUwEs7WTlCRAsZx9WmnLOdzyh4TwrTWqr3/RgHtKYuEDNVsg3NxhF6VWkzuwfcQ
	cyiG1Ifd7HwYWg1k+z5COBZc9VHhqpI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-McGDwrj_PRGc61KfI6uB2g-1; Fri,
 04 Jul 2025 08:36:12 -0400
X-MC-Unique: McGDwrj_PRGc61KfI6uB2g-1
X-Mimecast-MFC-AGG-ID: McGDwrj_PRGc61KfI6uB2g_1751632571
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 684F3180028C;
	Fri,  4 Jul 2025 12:36:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 688BC195608F;
	Fri,  4 Jul 2025 12:36:05 +0000 (UTC)
Date: Fri, 4 Jul 2025 20:36:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ublk: introduce and use ublk_set_canceling helper
Message-ID: <aGfKsZgztW53svl-@fedora>
References: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
 <20250703-ublk_too_many_quiesce-v2-2-3527b5339eeb@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-ublk_too_many_quiesce-v2-2-3527b5339eeb@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jul 03, 2025 at 11:41:08PM -0600, Uday Shankar wrote:
> For performance reasons (minimizing the number of cache lines accessed
> in the hot path), we store the "canceling" state redundantly - there is
> one flag in the device, which can be considered the source of truth, and
> per-queue copies of that flag. This redundancy can cause confusion, and
> opens the door to bugs where the state is set inconsistently. Try to
> guard against these bugs by introducing a ublk_set_canceling helper
> which is the sole mutator of both the per-device and per-queue canceling
> state. This helper always sets the state consistently. Use the helper in
> all places where we need to modify the canceling state.
> 
> No functional changes are expected.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming


