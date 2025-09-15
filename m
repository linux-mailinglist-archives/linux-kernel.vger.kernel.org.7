Return-Path: <linux-kernel+bounces-817380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A319DB58178
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6549320461B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D923D297;
	Mon, 15 Sep 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KW4X8gtz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB81D5CC7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952208; cv=none; b=XDWH/O7mp0X2XebAsBlmvbL8Z1oUY0PCfUmamiaNHB60rR/4+weRrkfLo7iIiNsBkvj/gspenMx0puR51cTfw/i/6OpXWdpkyoB1OpJlvcudtfvCmTud8YUNE845+xMqEg7HA8qmVe2hHozLZvSa7LrlFHYMVudb5hWHJ7iJvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952208; c=relaxed/simple;
	bh=jZv2I+hQgy7h1flHxtjAdMVXtLJV6Xkt1tQmvJyMaYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J3ARXdUcgRrP6sjmbH8b8GJk7ghWze+Voqx3+yOrmUiMtODfpCbfvM0gN9JkilKU29iB17UbZHaUodK0e7yzsp1E5+xv+JdsurAVpXPHgZ95/bqnqBWJnlGV8vVGF8wFYSZhxb2SgVn7/c8TZQ2N1NjoM83vRrXkROmF4Rwqh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KW4X8gtz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=l8M1HLgoXiLY5BzoOeoK/zpN6LMaZFeM6/poF/2GC8o=;
	b=KW4X8gtzK/Ah21Pmcw8/GGGggTesFQ/u2Hh1zsGdJgX0qyEjL+b7TDJpioQOifUCwxH9mg
	wlfz/JnBip2lP+LGTYtwXguLgjtXbjBeRA4Hpfr6vSeUSiYW24oZkI3jnGHVLM6H9ThSKk
	EzBV5oFw8wqpyPSy6gh5sNZW086u8f0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-IeqUPwKJMwm1iG4VfKeLXg-1; Mon, 15 Sep 2025 12:03:24 -0400
X-MC-Unique: IeqUPwKJMwm1iG4VfKeLXg-1
X-Mimecast-MFC-AGG-ID: IeqUPwKJMwm1iG4VfKeLXg_1757952203
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afcb78d5c35so515680866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952203; x=1758557003;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8M1HLgoXiLY5BzoOeoK/zpN6LMaZFeM6/poF/2GC8o=;
        b=ifp+yZlxN+gsI3VZ4l1eyAY56aqge5YzWTd5mZL/xJdt1+ap1eETAL1f0gg0cdeP08
         IgLSdcZifxYr5AxRsoPnC9hfavk7R+7SIC64me7zC4wIZHZaaD+/yND7NG8UUaTvKUCF
         1xMt6kfnMrfbtpqlW2gsMTPvqZS4z8hhVC94y1JkcASzG96jujZ6EUSWOVi0yK6qyWiN
         BJP6zAUjEl20Bai+OGUiputCZ7HMOABrUl7susIKRVvkrENahcyMufVLDcYjlP0S+g2h
         qKCqcXFQCA2sGqd3PfWz6infS07nTiCw1MfAoBinK7LNYiWoWkf3mswycTYCrV80zTCz
         +gog==
X-Gm-Message-State: AOJu0YyumrlPy4Tnmwut6gPt78E90dsqDaVkMae27rhtWC77ddx3wyL7
	nFgVZ1n0b3mB/bEsgTUWJCOOvJu4og2lwgRAp5Tc0ddBn/ZfhZeK9C+kwnTpJXZgOnAduOSL45z
	ehmdfradgHcQVFwzmY0jV6oM2gLeDOFF8wfGyA8/yv4xzm8T09V5BWFwZzeoLvrsyJzes8WXPxG
	CXLPA81CsUaXe3hjMzPJoGyDaKmXUUo75CPgxfmeiy4Mo=
X-Gm-Gg: ASbGncv3qaDaEWjHWbGFlTQBCjvIuQy2of4JwWFnakrY2w9EXmSVPLvEMwK3gJYvCoG
	KHiI6/fJCZ4EOf0LhXoxSrnarm2h8guHxxYMFLhAuNuD62Wh+rrTdFKpFbwbRdHEvX1fsuZmsAg
	LtEvdEz8GwfhYf6XQPEKm2zAybq1OxbKI0/I4N/Iw7uqhyFCCNUc7cua+fc0yCPUKJp/SaWNtHn
	P2eEzSayupuxEdROoiIOLZ0P2/dBAljDLbNj1JXjXiktKoUdeYc8H/CrRgy9ICvJpIOeC3auvFw
	/F9jCmOP+vdB/Soy+Nj4oJkQKDgr
X-Received: by 2002:a17:907:1c1d:b0:b04:a1a4:4bec with SMTP id a640c23a62f3a-b07c3a67aa8mr1299527666b.58.1757952202647;
        Mon, 15 Sep 2025 09:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwwIB4rLfw0BfbhWfF9Fcdmo+wyMaaAb5Z+Vosd8vM4TIyjSy30sdafKcHylRnmXkyEaGRuQ==
X-Received: by 2002:a17:907:1c1d:b0:b04:a1a4:4bec with SMTP id a640c23a62f3a-b07c3a67aa8mr1299522466b.58.1757952202060;
        Mon, 15 Sep 2025 09:03:22 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3128a1esm947877266b.29.2025.09.15.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:20 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org
Subject: [PATCH v3 0/3] vhost-net regression fixes
Message-ID: <cover.1757951612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent


Two regressions were reported in vhost-net.
This is based on a patchset by Jason, but with
patch 2 from his series split up and made simpler.

Lightly tested.
Jason, Jon could you pls test this as well, and report?


Jason Wang (2):
  vhost-net: unbreak busy polling

Michael S. Tsirkin (1):
  Revert "vhost/net: Defer TX queue re-enable until after sendmsg"
  vhost-net: flush batched before enabling notifications

 drivers/vhost/net.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

-- 
MST


