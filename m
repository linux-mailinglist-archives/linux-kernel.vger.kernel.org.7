Return-Path: <linux-kernel+bounces-877009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F14C1CFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 087344E117B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8992FE587;
	Wed, 29 Oct 2025 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8UiKNIY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C31F3BA4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765337; cv=none; b=Ry/xBn8dali5BtN+dh6NG0MdcIY0e15GE8I1Il9ZkhE8jIyp0Y6xaesyqMHCeKyaKv8i7hjfxJ5Bh//A965EKR3lA3HhyIqBF+IEfkMYseQ8mGR/3qr36ls/Hc4NgoW3G+fIz+aQwU6tLqu1jf39Pxep9+6FB5o61cWawTbfPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765337; c=relaxed/simple;
	bh=1kEhprzux2CR6jnRo9FrhSHRGvFEkHIlQHH+2l14UWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTLIo3q7f1lmlRc0kz6hARdiC/PfTHQc5C2kV9onsEosgcfvBt0YegJ1xSRycfY5DPbCjBrh0lBfOE7Yhj/v060qWX6fKzLGaJ2VQ9hBqu24gs/tXsoiEOOF/aPcrnofcWHa+0VDDd7KijKQgk1uQYpG8uwRzdU2TGF9uxX9wBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8UiKNIY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761765335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xslLBng/2EFdELNnyRvec4wM+aBiIYwV8tPOplXJTds=;
	b=h8UiKNIYbm/XhyhgWUb3F/IEi9HTj88Wujh1wuU2GcKL52f9jTF1vtwRdoOCqgUi5Po6uw
	NSnWQrDfioEHBBpx17N2gNwkSJL9lJwfk06dflBamHiToDMHSBZE5X8Bzyr5CM84vbWJo4
	WpOLPyJ4uMNaSnUMq5k7UBsgxooaNW0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-oZ8_7lveONK96Sj51vFIPg-1; Wed,
 29 Oct 2025 15:15:32 -0400
X-MC-Unique: oZ8_7lveONK96Sj51vFIPg-1
X-Mimecast-MFC-AGG-ID: oZ8_7lveONK96Sj51vFIPg_1761765330
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AABDB19560AD;
	Wed, 29 Oct 2025 19:15:29 +0000 (UTC)
Received: from desnesn-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.139])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9298519540E9;
	Wed, 29 Oct 2025 19:15:27 +0000 (UTC)
From: Desnes Nunes <desnesn@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	Desnes Nunes <desnesn@redhat.com>
Subject: [PATCH 0/2] usb: storage: Fix memory leak in USB bulk transport
Date: Wed, 29 Oct 2025 16:14:12 -0300
Message-ID: <20251029191414.410442-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This series mainly fixes an usb storage memory leak that was identified by
the LTP ioctl_sg01 test. In short, a big enough SG_IO request can trick a
device into sending a CSW status during the data phase, which will in turn
leak USB protocol data to user-space. Differently from the big leak that
also started with the US_BULK_CS_SIGN from CVE-2018-1000204, this only
happens after the allocation of sg pages for the srb transfer-buffer.

Desnes Nunes (2):
  usb: storage: Fix memory leak in USB bulk transport
  usb: storage: rearrange triple nested CSW data phase check

 drivers/usb/storage/transport.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
2.50.1


