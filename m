Return-Path: <linux-kernel+bounces-817641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D237B584D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A531A27D60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0151E1A3D;
	Mon, 15 Sep 2025 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQh6+HDj"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BA280327
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961701; cv=none; b=FhrR/146oAiiGbz7/JoUYHUU/vci+u7V+YjqFZ0MoAEgRV9IDW+ZBr9hYtIiKRAig7D2BlLkTUp+Hg9g2V7YYxGpkUTpXHOQ51/AJ1Nfs0eYvwpCDHM9azw0H5LDh8fWj7LkvqRZ4cBLwAQ6Biwl9+LoUsUyLw//49wUWkPIl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961701; c=relaxed/simple;
	bh=oPccXBrUqI8/MvE8k9QrGmavp+NZUnAV7TpP14XIh1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8qlAO5SWukn5e1ycucqn4v/WJY0X1i/Tv4Rpeq+gc19Ve4JDZz/dYSBqTDX7Wg0L6BkIP77OYy1yGhPehggWsQQ3mwOSIGI48YSDZ4eXyRCWjx0KcTdhPDmcH9zZb7JGzYx9LLqKASDUi4xuP7aOyS8cdHgg3ENAS8lN3H9ZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RQh6+HDj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77716518125so1223788b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757961699; x=1758566499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvNrOR4ellqZqvuE2ABZzj31gMsgVuW0rC+wrpkvP4k=;
        b=RQh6+HDjWB8BIpncYrlpe38iW5hNnBqKNpT/1uDM85K/0//qGxzY3Ck5WLFTqOCUGO
         MXAKljODka1QYTxPJV2v6OWBdyvXryogLe2JPPvRr44yB5bqVfBtY9qQ0IQ+cyMJ6xT6
         rEqgVVmjJq9SgXkW2XcEaYLZ4c7zfckcqqnus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961699; x=1758566499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvNrOR4ellqZqvuE2ABZzj31gMsgVuW0rC+wrpkvP4k=;
        b=YFpKF4Cz444x3INhHa5XZ9QMM5A2RqcX1Lh13JhEU+MzsvRZIPjsGnoBaGxvQv4f9U
         PMe/QO5zYm6Z+cSnHCJb0vLFgQajFQe2LAvpzGWqLa8MlnqESnwLRPQ8qYth4afLFr2T
         AyZiruy530XbsG0XeCK97yaq36Y/CIndmmZ8xzJf6JFKl/i/6kACDUnj/797JAskXGm4
         T0mvO9cJ9Df/3rZv3bcj8HiZrvjL7COZ4YS9SUc6oTfGT9T1InfyqcGC6/L53Jgv7z83
         ErgKhYUjD2Ua3wQu1U03LMa62cwsEm0rN1nIKpM+xil5qyXc1f9/pfbF1ErvkVuFRllm
         IjMw==
X-Forwarded-Encrypted: i=1; AJvYcCWDGOOP0MCJvRlNyhmlAeQ+tJXAfn0XlyOYM60shikhXcNS8uLxmIMZB0rS05/tEEMYj2VAqaIk9qyNHO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIu356NKivtfCzyO7drF3MzxWVwb9CSPFPyEwAW2iF5S+LO8E
	ehJACEbSnOwPKyGD3KiUx32KSTYeCCYTbiMRAuhaNxacqYOIuAoZeUiIHwxdxwItFA==
X-Gm-Gg: ASbGncuwYr+r2xsIp48vINQzr4L5yxbnxUTq+9MYkRLADIRt5t5z+fBS9Kdei/XffWI
	pACx4WRzkAglb8e7rif0VGt1bLsbPILxBo8PNSrDRo+Y5Yac1SfBwrdF0TpO6RZXGFCIsFqvHDx
	xUxNcmogvYsO2EvwjJlUXugkCc+t5oN3OO/QvIXDveg+0VRgpVQ3Ud7YFWMPikDkrBYHJEoYu9t
	EeUy3mWiSLSo/TAvXJZUWS/sWV2niqgs1zPpd+eKn06dMX80u7cqgpY/8U0joi2PocJW28WFrnX
	x3tzRvHDlgDyUZ2yF3l3ULBHzcRYQchi+kjzQjfjIEQcMBBTYgqjuNzAFDwT23GYbCB95lgfOku
	bs8MDaiwOkztEzEax/rFGEEN2jWO8eP/Ocs2wT+N3SYkzDKY+GmvCPE6LJ20l8NVcEw1ZqDU=
X-Google-Smtp-Source: AGHT+IGlRm1d0pxmlp5QnmWl5T2hIZtYHRH5ZefBsxntjPmY3kpOuBh7Py9dWQ+bly9aiTvcXCvOzw==
X-Received: by 2002:a05:6a00:9289:b0:772:4759:e433 with SMTP id d2e1a72fcca58-7761209bdeemr15688778b3a.2.1757961699464;
        Mon, 15 Sep 2025 11:41:39 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:fd49:49b1:16e7:2c97])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607b33c45sm13983580b3a.71.2025.09.15.11.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:41:38 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:41:37 -0700
From: Brian Norris <briannorris@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <aMhd4REssOE-AlYw@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMgZJgU7p57KC0DL@infradead.org>

Hi Christoph,

On Mon, Sep 15, 2025 at 06:48:22AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 12, 2025 at 03:59:31PM -0700, Brian Norris wrote:
> > This series primarily adds support for DECLARE_PCI_FIXUP_*() in modules.
> > There are a few drivers that already use this, and so they are
> > presumably broken when built as modules.
> 
> That's a reall bad idea, because it allows random code to insert quirks
> not even bound to the hardware they support.

I see fixups in controller drivers here:

drivers/pci/controller/dwc/pci-imx6.c
drivers/pci/controller/dwc/pci-keystone.c
drivers/pci/controller/dwc/pcie-qcom.c
drivers/pci/controller/pci-loongson.c
drivers/pci/controller/pci-tegra.c
drivers/pci/controller/pcie-iproc-bcma.c
drivers/pci/controller/pcie-iproc.c

Are any of those somehow wrong?

And if they are not wrong, then is this a good reason to disallow making
these drivers modular? (Yes, few of them are currently modular; but I
don't see why that *must* be the case.)

I agree, as with many kernel features, there are plenty of ways to use
them incorrectly. But I'm just trying to patch over one rough edge about
how to use them incorrectly, and I don't really see why it's such a bad
idea.

> So no, modules should not allow quirks, but the kernel should probably
> be nice enough to fail compilation when someone is attemping that
> instead of silently ignoring the quirks.

Sure, if consensus says we should not support this, I'd definitely like
to make this failure mode more obvious -- likely a build error.

Thanks for your thoughts,
Brian

