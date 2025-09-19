Return-Path: <linux-kernel+bounces-823975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC11B87D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8F256489D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA89246793;
	Fri, 19 Sep 2025 03:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+1ViPK2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842BA21FF45
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758254016; cv=none; b=Fr3Np/ePRgqA55y3DaAd6t6kPkWWu5ivGeTAmZgrCduLdOPSExmGjZnHO1Ck5Ql34HqVWrmV7fSIhq/8heLBlEeXykUb7KWepbLoULdLU2OkTS24Jk69rdKQrgkXG0/ZBtdUy5iE2hg7L7ghyH40pOSFsaSecjsMUw96wZUz5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758254016; c=relaxed/simple;
	bh=r7u+fIYunh1tQjSKJ4gx+/XeyyhWsam1c6dx2oNcQVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLEPUtXBaZ+Tm3uDaWFpfWZGNIaI37D5U9rWzcPAaXZ3ayLyDEUqHgL3KpjDQEUT/H3pxYlqOIiwIzzyTqLwe+vHT0QnwoIhPOfMWpIY4NZ3CG0JNudfKG/epsyJeAA/z8vFXUsXHhaodittTovc37FhBKPxUWFM7OyDln+o79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+1ViPK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758254013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQrwM23HsGfKWdvsFTuBJVXHncfoNOQVfb470fO9tiU=;
	b=F+1ViPK2NTPTLbxEkbUZog29BuEwHTFHnUqTuXdX/qSwbDvICOlCi+vKO/BWrCcDvR941Y
	z5HH63y8E6AWFCm+vfgnS6UF6JR1L8nGZEEIBsjg8RluAzdbJKLQfoRdl8TlwcaBoMHP5n
	5YCoDGkugEX9nzYF1tcFMnnxokq635E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-nEh6cxuiPwyutF-Z5CILuQ-1; Thu,
 18 Sep 2025 23:53:31 -0400
X-MC-Unique: nEh6cxuiPwyutF-Z5CILuQ-1
X-Mimecast-MFC-AGG-ID: nEh6cxuiPwyutF-Z5CILuQ_1758254010
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 239FE180035C;
	Fri, 19 Sep 2025 03:53:30 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ADD818004A3;
	Fri, 19 Sep 2025 03:53:22 +0000 (UTC)
Date: Fri, 19 Sep 2025 11:53:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] ublk: remove ubq check in ublk_check_and_get_req()
Message-ID: <aMzTrazYYfN0eTfM@fedora>
References: <20250918014953.297897-1-csander@purestorage.com>
 <20250918014953.297897-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918014953.297897-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Sep 17, 2025 at 07:49:37PM -0600, Caleb Sander Mateos wrote:
> ublk_get_queue() never returns a NULL pointer, so there's no need to
> check its return value in ublk_check_and_get_req(). Drop the check.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


