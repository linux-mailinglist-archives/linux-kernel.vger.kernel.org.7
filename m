Return-Path: <linux-kernel+bounces-820243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7513B7CC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B79A1C03361
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465732165EA;
	Wed, 17 Sep 2025 08:34:27 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D506219A79
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098066; cv=none; b=Fdlr5FDPQbjsyrSOj9TfJ7T/OFH48QG/skMO1jH6F90iecVJLJUtHgO9cinnE7PMmnvvynMj+i5hqpNM8BetMQdFwA/Rp4DcV/d4bAHUoDl4PPa+bV/qJKtmZhK4pDcdPB6fjEbKV8MC/9eQAQ+TJU6Lt9gEuPf7dLNcxaUcK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098066; c=relaxed/simple;
	bh=DySHDv2m6S2R7jAWa8eq/N59wBkeju6vKhFZnmHXvXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDpX+0sG9sFEMBIqb4by0qWMp3CoBu9y6BOQJCvN83ElYUDbsAkxEIGCwqKPe1Z1sRjnPFQenitt+qg7uaQqoXM2bGcV9pa6fLlfhzaeNBVhUcJHq5RKa5rxo/lSzBKPPTheyffAkwjzK8/5mFSlx7bh2acpqlMMKhBo6OPBpWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26488308cf5so27415555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098065; x=1758702865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iELKTE0E+GlB2VJTAUrkTTPFqh84WW08eU+U9S+bUek=;
        b=GD9Hyj3jf3KYC6RreBMfOZmCuQSPLzFyqLIUBMgsYN2Asqqgt5pl9wPxV241/q5dRM
         /6wOh/0XvdM0mVYD2BjiYq4w1WxDoppi5KIkMTPU7mSVLKSRQQfZnszHMHA2ozMiczen
         btxAHXyUT3hwMlRrpncaJJYmhLU4hQ78Tblo8KWXArQv12w0tfshDFeADlLdQr43dw5g
         UzhOoaB93mScxFN/2tIyYKNEh2StmLqulU3nmz7fSP68Cw2RT49fqVBrr/Uh71USk74/
         uw9mCB4l1PIHc2PtkLblexfxLqq9UZ67Ieb5jo9Ylrj2SPFG2K5sciO5SPJfckgrYJSJ
         Zj9A==
X-Forwarded-Encrypted: i=1; AJvYcCXSNn4jry/VrDjHTYNLWxNttTk0eodN7BtNC0JoIUciFDI9zoSSHriMEeIcYvjzb78OkpmaEwPmWwE/YAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUw4TehZnoXUBYx7G26PM92AUE10WvogNZFnNIiQmO21lkOSCC
	W7Ap2zkgqCbfTLqc8Nyy1KGONf21ZP1jsBkQR53N8lw5D2w3RnhgJ7CB
X-Gm-Gg: ASbGnctLSY+ZJF34V9TaIU/Z6Zd2IgeLre94bjS+UpzE0hSjKyRITuueiXWFFnylzy7
	+/tpUXNvzxQp0OUcjoGP2Mk6vLvLwUa6aC472mz/cuaggad29XjT2Aoga9PsgjqquhPU54D2FPg
	Gs2eZVg5Na3up9i9V7bV9FkYfUxeqpZ0QGOmgFH4CZHO/YDoWWb5zYO87Xa1ek87wSaE4ugzqY9
	Mw/2sk4C1WdMvy33Fz9yT1K7zZNE1F0f0pKqNGUMFBXxsU9BPK8AEbBfeFHTI1yemUQ3C0LPhWH
	1LZjOnZkvwv1/A8/egkNbFglySraWqq7xckzZFNIPoSZijHtPL4uJxCdKr1m3DbHWMusd+QyEBE
	ZApGTw24SJoS4ugfcjSRLPsY1NAZ6LU5VllfSDP2y6isxD3Tjzh5c1/WcNA==
X-Google-Smtp-Source: AGHT+IEWZmuIT2HUy7KiXjjGo+jbGdy/oTHmqpbzleaSozDxJFqtOyIV47jaKlzA5JOPuqt5mZVuhA==
X-Received: by 2002:a17:902:f603:b0:24c:ea1c:1176 with SMTP id d9443c01a7336-268138fdac7mr15260585ad.38.1758098064706;
        Wed, 17 Sep 2025 01:34:24 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2631ee2ceb2sm111221445ad.141.2025.09.17.01.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:34:23 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:34:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250917083422.GA1467593@rocinante>
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas>
 <aMnmTMsUWwTwnlWV@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMnmTMsUWwTwnlWV@kbusch-mbp>

Hello,

> > I can see that the PCI r3.0 (conventional PCI) spec doesn't include
> > the Device Serial Number Capability and the PCIe spec does include it,
> > but this seems like it would fit better in the pci_dev_dev_attrs[],
> > and the visibility check would be parallel to the
> > dev_attr_boot_vga.attr check there.
> 
> I'm not sure I agree. The pci_dev_dev_attrs apply to all pci devices,
> but DSN only exists in PCIe Extended Capability space. Conventional pci
> config requests couldn't even describe it, so seems okay to fence it off
> using the PCI-Express attribute group that already has that visibility
> barrier.

PCI-X 2.0 added Extended Configuration Space[1].  Perhaps why Bjorn had
different attributes group in mind here.

> I also don't like Krzysztof's suggestion to make it visible even if we
> know you can't read it.

I simply wanted to keep this new attribute and its behaviour aligned with
the existing ones.  Which we keep visible for historic reasons.

I don't like the special case it becomes within pcie_dev_attrs_are_visible(),
but it can't be helped without introducing an entirely new group for this
alone which would be an overkill, indeed. 

That said, no strong feelings about it.  I wish we could clean the existing
ones up a bit, though.

> The exisiting attributes that behave that way shouldn't do that, IMO.

A lot of then, as Jonathan also reminded us, predate kernfs' visibility
feature, sadly.  We probably won't change the existing ones, indeed, to
avoid potentially breaking something for some users.

This is why I was curious why do we need such an attribute to be added,
as when these new objects for PCI are added and gain users, then there
are often here to stay, with broken behaviour or not, sadly.  We don't
have any sensible way of properly deprecating things in this area.

> It's a waste of resources to provide a handle just to say the capability
> doesn't exist when the handle could just not exist instead.

I haven't checked how the kernfs side looks like, admittedly, but I think
whether an attribute is visible or not, it does not unload and/or de-allocate
any space for the accompanying kernfs object...  So, the resources saving
here might not be in any way significant.

1. https://en.m.wikipedia.org/wiki/PCI_configuration_space

Thank you,

	Krzysztof

