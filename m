Return-Path: <linux-kernel+bounces-583630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026DDA77DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 16:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690DF1891002
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4157E204C1E;
	Tue,  1 Apr 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSgojhG+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892D204C24
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517536; cv=none; b=ABmXj5kA0h9yhbFWcvGtLl6fQCNEYijEGz9mP8xDtcO/78phjjaXIMDcU0QQpKyy3K4coQrayYIVpowCNANrQ0Nn1kATF0I7cWT91E/Ss/BdwBFRFRSPvPIZB1men9c5Sw29ndzefANIupiwVEzSJGzbeW036P1jH+hRepbR3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517536; c=relaxed/simple;
	bh=1/AAu4ml4MViQ+FpwPBEj6HozYXlOVT2sbaEwqNFQ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWmbK00fn03vfGIKyO1jL438Cs5Z2wmElmcgTv1h7Zq8wQWbhmi70EblhCT+rhlJzpYgzYadZbHaJDn/dwtOAQ/bZTipSFsSvlkYbfrZnm0OuenCkVyW9x6ZgR6uBp2C+RStcy3cXOmSnIWJPCXWoTXfnna5cHJt9kcHkBcwMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSgojhG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743517532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pdWXSeKX0PhjDWr9770PlQZO6x2YyeElurh57OPstnA=;
	b=bSgojhG+KeJvYRCIQ7kkCSF1bDIzDaG0iucx39LC3oLv9wKKQZjO58pBuEgxlABGJk2jl1
	wnM1nsAG2fvnOwU6zryBRUWj0QFWd6hDQO7zcqyYSn8vrhHhS/scPaQ8Ta23l/sPUA75s2
	8IcWVJ+yFmm0aDTIfRErCOciGe+/9r8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-R3U1Q6zGOcmXxmy9eBN0PA-1; Tue,
 01 Apr 2025 10:25:28 -0400
X-MC-Unique: R3U1Q6zGOcmXxmy9eBN0PA-1
X-Mimecast-MFC-AGG-ID: R3U1Q6zGOcmXxmy9eBN0PA_1743517527
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59079195608B;
	Tue,  1 Apr 2025 14:25:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.107])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5E9A1955BEF;
	Tue,  1 Apr 2025 14:25:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6A25018000A4; Tue, 01 Apr 2025 16:25:24 +0200 (CEST)
Date: Tue, 1 Apr 2025 16:25:24 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1] MAINTAINERS: Add Dmitry Osipenko as drm/virtio
 co-maintainer
Message-ID: <l2ndn2jo2swv4unuc5r7fm3of6w3teyytpqfpgcvkdwnp3fubc@ect2rh2ikmhn>
References: <20250401130151.2238772-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130151.2238772-1-dmitry.osipenko@collabora.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Apr 01, 2025 at 04:01:51PM +0300, Dmitry Osipenko wrote:
> I was helping to co-maintain VirtIO-GPU driver in drm-misc with
> permission from Gerd Hoffmann for past 2 years and would like to
> receive new patches directly into my inbox. Add myself as co-maintainer.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


