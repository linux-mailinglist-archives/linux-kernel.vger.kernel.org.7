Return-Path: <linux-kernel+bounces-735507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3F6B09043
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A3518920B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C32F8C5E;
	Thu, 17 Jul 2025 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M44gxxI6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E922F85F2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765114; cv=none; b=H0ey1lyl77A/4dtsNgzmuQ8aWRG62IVBigw35mDcK5UiSn6z155kbDOlLVV0iHfGpr3S8hQsRAaIgCDy/2t5MTzMYCbAeWeEfZMIdbVk5RGVvLzHbW18uog+0sp6MxKcBHo5k9jcDaGj1fjCX/E55rXuD3ZKQSt8EgifEPD4n/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765114; c=relaxed/simple;
	bh=F85tYXY6VV6nTjJyZOX8HjAMj77RP6ilys53ORMr8BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p49qmyuJ5Gumvi5jaQSH5G+R+PkSIJE6eA0/VWlrr7UPwITTJSKnnvzeCmWrNFkOYgNW8CagIHqvviZWs1Nvk17VfocsyI6KII9Wf9Xt79nUAQtz0hOOfnKeqGQfvvWtqvPnK8kCUx36RaS3T0oLz9br9jjwYn9bFvolkl5vSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M44gxxI6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752765111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37glsxypXkn1C3d6CO3iVbC1wX6loiRVfTLNayBy9I8=;
	b=M44gxxI6VbqI421m8kl88B8YWWQUBmCdDUN8Bu6iM8lxIuvfiDto52NHnWXqDxMr3/Eu/B
	KjlQkTMMrU+e9YfazM2jEB0rGcyuceEIPiIZXOsUhyvsp9vjkD6j2j/Ylc+XN6k09N1bNi
	lBdgjtv8qOAHowQf0g9bUcx4Pmcy8sQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-TM0MSdqnM6iYiPR9uEfsqw-1; Thu, 17 Jul 2025 11:11:49 -0400
X-MC-Unique: TM0MSdqnM6iYiPR9uEfsqw-1
X-Mimecast-MFC-AGG-ID: TM0MSdqnM6iYiPR9uEfsqw_1752765108
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so5862725e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765108; x=1753369908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37glsxypXkn1C3d6CO3iVbC1wX6loiRVfTLNayBy9I8=;
        b=l2VpXW5aGpGVI4ILIQuwznF02NzVcA9mWQyvBlHYH7jAnCs3zpHD/QJGoPITF/9VJP
         WUmnukiV3F/z9FOUzANw0p9DSaD4eEv/bWY48DbBsSXxvgYbVHa+fshxPZ428pjI6rGF
         MHrz2l7Mo2E3hgvQPbXFTRo8YAdo455GenJq7wCkwHyXGSxd94YgD3O4TrGRD0d8CtVU
         5NkfUHo8dRN2R1ZxYMo3SZGI1LkL+CnG0FOtzsRCpF6qxcyviAaqwBirmU/HS321yRZk
         SJ+6qGqpVvNfear40/ZszYXlhw8oR6/qhzKvW8x79/61QQmACmcYfWR5uqHKOTcTcwct
         5zaQ==
X-Gm-Message-State: AOJu0Yys8O2D4CQIx6B1FqLBnDKL14VPN06xG5rEGDbJJvI1csuc/V0e
	wMlArP1j+DQCEBt9AhW2PZ7Z+UyiDc3egt6/LAefqtD/xGrlyVsyvUtZ8JVlBbSNe7xbXJKbWeL
	GoyudLd1Ao5S06FD3VJEP1k55Tm1hQX+RtbFYyP6SWCc+y5Z65UFxoXr9Z3WvmzFuEQ==
X-Gm-Gg: ASbGncv7RvEnlxzYyjXapclKQS4MBRrux5+ivz1HQ0BHh1xhbEalDPx4DgOJEO6zFaQ
	aLdA7++2EusJ8EXlRLvmT/NKD5zrwUHBcjLxq5y0RCb/NOHwvHot/OvrdYKgiC3QQ/ob9vCAUTD
	JLH0++EMFB2Xyg/216Jq1bmHdOaijTvvq/0FiOyG4HKYKAfY/9BvwyPetjhQARUsOQU1UVV+cc3
	dA9f9oFvFH9ZCSRaqGBSeuznWR52cbwXnSZqPS/lvv4QmZ3KifhxrGznIMOWtWO6US6m8yJ8Is7
	DmcytaDzy+m5hanyv/D4Cb7xLLlA+M2x
X-Received: by 2002:a05:600c:a088:b0:456:43d:118d with SMTP id 5b1f17b1804b1-4562e38afacmr77016785e9.17.1752765108166;
        Thu, 17 Jul 2025 08:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB07BVIwzcHvYAUkNSqmK1BkSLoQgRTplE4Zrs0SicJiAMmS6QZSUUkIaNPKwNmV0oVrmn1A==
X-Received: by 2002:a05:600c:a088:b0:456:43d:118d with SMTP id 5b1f17b1804b1-4562e38afacmr77016505e9.17.1752765107748;
        Thu, 17 Jul 2025 08:11:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e1a5sm20649298f8f.74.2025.07.17.08.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:11:47 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:11:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250717091025-mutt-send-email-mst@kernel.org>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHSfeNhpocI4nmQk@wunner.de>

On Mon, Jul 14, 2025 at 08:11:04AM +0200, Lukas Wunner wrote:
> On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > At the moment, in case of a surprise removal, the regular remove
> > callback is invoked, exclusively.  This works well, because mostly, the
> > cleanup would be the same.
> > 
> > However, there's a race: imagine device removal was initiated by a user
> > action, such as driver unbind, and it in turn initiated some cleanup and
> > is now waiting for an interrupt from the device. If the device is now
> > surprise-removed, that never arrives and the remove callback hangs
> > forever.
> 
> For PCI devices in a hotplug slot, user space can initiate "safe removal"
> by writing "0" to the hotplug slot's "power" file in sysfs.
> 
> If the PCI device is yanked from the slot while safe removal is ongoing,
> there is likewise no way for the driver to know that the device is
> suddenly gone.  That's because pciehp_unconfigure_device() only calls
> pci_dev_set_disconnected() in the surprise removal case, not for
> safe removal.
> 
> The solution proposed here is thus not a complete one:  It may work
> if user space initiated *driver* removal, but not if it initiated *safe*
> removal of the entire device.  For virtio, that may be sufficient.

So just as an idea, something like this can work I guess?  I'm yet to
test this - wrote this on the go - and also I'll need to implement for
other hotplug drivers, I need it at least for ACPI additonally.
WDYT?



diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index bcc938d4420f..46468a1f0244 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -231,6 +231,15 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	int present, link_active;
+	/*
+	 * Always mark downstream devices disconnected on Presence Detect Change.
+	 * Covers device yanked during safe removal.
+	 */
+	if (events & PCI_EXP_SLTSTA_PDC) {
+		struct pci_bus *parent = ctrl->pcie->port->subordinate;
+		if (parent)
+			pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+	}
 
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.


