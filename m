Return-Path: <linux-kernel+bounces-729445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B3B036C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E261717DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC31221268;
	Mon, 14 Jul 2025 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhCyYDKb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E881F4701
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473864; cv=none; b=naZB0xIquJO64EEVt80dp7LFgB7pbIT5aZmCkZCnpkzyBMHGqSQ+0YcSu/3/Cy25430SOHwQFyOMIP9AuT8U76HMJvStB5MhP7id1DaPLU26z7U3wQ6Dn9fy1AnO6qAkURVNkltKY/hGIAYPHrQ7GeCUeJDsDb0UZesOM05rsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473864; c=relaxed/simple;
	bh=VBy6PDnHPih2lBK2ZZwSq9hR6E2HRl5WrI7AEF/MP7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5W7CK9uonxrRV3u8jIr+/RhTJ2AUe5coqkiPrm8PI8byKWprBqO6HzjXcIo6Kx5VQsgJbJbgSPktl4EQ8Tf06Xt2QIu3LkNXeCZgniS+c6sMLxEkKiZvC3G7avdFKHzYgGg6wMryaEdiW84Ht6S4oTx8h5fXi0hFU2TZVZx4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhCyYDKb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752473860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw7vr1HISEyMElnJL1/B0+9vBI9ECMEq3eIFOntmoI0=;
	b=UhCyYDKbIUMUFQ7AzuzUXEcxpcwFYBPETN3p8dLafarA8oWFLroPPSlVELWm9/t2mgGQU5
	d9VK6vP0mwnriHLVbQeFSfL+yKyD7k0oycx8ibh08QB9VudQE2Jys+eXdcNA9yio69lWNa
	qRF/965Rjf3E5wcJEYDJyoKkMnsjMio=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-mua_s_LDPayf9yPuhbAl8g-1; Mon, 14 Jul 2025 02:17:36 -0400
X-MC-Unique: mua_s_LDPayf9yPuhbAl8g-1
X-Mimecast-MFC-AGG-ID: mua_s_LDPayf9yPuhbAl8g_1752473855
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so24989745e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473855; x=1753078655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw7vr1HISEyMElnJL1/B0+9vBI9ECMEq3eIFOntmoI0=;
        b=Khrf9aFnHQHfKhG/wEurXsa1DpFIdNKZKVs0OOPArc9LnqiGfOtq6v7e4o8qdamJCD
         bznlAdjQRmapj1pV/gMYWUf07BylWeecPki9KM0LF8XloMSSwJibfg3PexBm3xqMDrdt
         Kc56xkyY/qxCu3hbakbSMRC/OCQr9HS0Y6LSqYPFktd1kO3t5XApZTyQPAkkduarGKsj
         lvnWMaaaZrgFyb/2pkVny0InS4GdwWUuTKST0AIeoHYLWiEfHXojkwC71rQGI+hETXaF
         sUuuvGik0aND4C6lWZMY73XlGAiDfbl3aM7rrLGWEJ2kVp0MqZDPnGjGiiEWRJdcFR5i
         uEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVHfqjiXATAoGS3LFWsYW4YS7dasxzuLQAPu2+23y9CYwzuHvGQox5DHMAaHpdDIiapu906m8PAd0tgRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nsmdKY1RIevkNaZlU1cl/Fcm63SIuGaK93s1qDJcBgWIYmuA
	SyVpzvZO5RclPHbrPsZoa8LGIHknnDY3RX8urwB+ckcBF4hlY3vWT6P8VVYhSwcc5sGBNelCHbb
	IMC4rG9icd4H6Vxl2GUfaIWx+xHVnIP3nhAp9BMXtBZ/4q0Zv/M3b/3i1IW530Kw8OQ==
X-Gm-Gg: ASbGncsmamFnkXL00edV7ViMPLG7k5xERxT6wmWlCqkAE1dzO5ATaDPXH+7yKjUZl6U
	9n+UJmuQH0ebd6gLoBJSEd87/Epw6IPyUPIC/f/9N2KyeeHTZ8f31rvcjTbeqBwvAA9xJriUyMJ
	4f2fVmhlw25W9ppuygP1sL2TouW2t8OOnE4KeisGo/9WoJ8DQ2itt+2n3wHAu9eWG1MlGzgyYrG
	6nKAYCmxcubLXgaWd4esiLhjWtY3SvrUfieJqttukf1V8rMEzazg+wN36fR9p5CYF88k3w0uLBJ
	vY6DSxUDmitNnjhCFi6KPneYjUI2meJp
X-Received: by 2002:a05:600c:3513:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4560f854858mr44020595e9.25.1752473854998;
        Sun, 13 Jul 2025 23:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQCJSWHskQAdK6/40s2GNLhe1adxKFpy3e1bkD6X5SdYIshLCkbO2SV3+P2shMcWDz9uD6pg==
X-Received: by 2002:a05:600c:3513:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4560f854858mr44020205e9.25.1752473854492;
        Sun, 13 Jul 2025 23:17:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fcbsm162665575e9.6.2025.07.13.23.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:17:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:17:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714021713-mutt-send-email-mst@kernel.org>
References: <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <20250709233820.GA2212185@bhelgaas>
 <aG8BZcQZlbNsnrzt@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG8BZcQZlbNsnrzt@kbusch-mbp>

On Wed, Jul 09, 2025 at 05:55:17PM -0600, Keith Busch wrote:
> On Wed, Jul 09, 2025 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> > This relies on somebody (typically pciehp, I guess) calling
> > pci_dev_set_disconnected() when a surprise remove happens.
> > 
> > Do you think it would be practical for the driver's .remove() method
> > to recognize that the device may stop responding at any point, even if
> > no hotplug driver is present to call pci_dev_set_disconnected()?
> > 
> > Waiting forever for an interrupt seems kind of vulnerable in general.
> > Maybe "artificially adding timeouts" is alluding to *not* waiting
> > forever for interrupts?  That doesn't seem artificial to me because
> > it's just a fact of life that devices can disappear at arbitrary
> > times.
> 
> I totally agree here. Every driver's .remove() should be able to
> guarantee forward progress some way. I put some work in blk-mq and nvme
> to ensure that happens for those devices at least.
> 
> That "forward progress" can come slow though, maybe minutes, so we do
> have opprotunisitic short cuts sprinkled about the driver. There are
> still gaps when waiting for interrupt driven IO that need the longer
> timeouts to trigger. It'd be cool if there was a mechansim to kick in
> quicker, but this is still an uncommon exceptional condition, right?

It's uncommon, yes.

-- 
MST


