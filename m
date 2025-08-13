Return-Path: <linux-kernel+bounces-766200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62545B243A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E05E166445
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A702E36E8;
	Wed, 13 Aug 2025 08:02:03 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A33283FE4;
	Wed, 13 Aug 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072123; cv=none; b=hZ2t4A9b5ji5QPlpe999V6wepftHW4VJqRc7Bz8d1QCFd7Y3KLBUpA1R5IJjaHltmj2bFCURFIBuzptiwgSULBBcem4Vf9UpLlOdff3VznqhQreOLD+XvFm0KsG5PEbNoNKW8KFMW9SmpLnGPblXsF3s7zB9zIWuK7ODnvzV1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072123; c=relaxed/simple;
	bh=ARWZeV5AIKpwWGWYFjzn8mwFl1iehx3wMvcM+mthYB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKlq6DO78YS+rDIPssIOiccSuoomy6rGyhKOViN+iKJ8FQoyAanmCSgL6nBVQUaQlpICCthHKYuHKlX8MuP+Nuj73TK11Z/Age1NbKR6sNzdPT8taISOtd99zRcrmb5Ydjqy+Ab6z/qZFIspeDdqn/3VZ7fBHkiok5+70jwWNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1755072056ta162e254
X-QQ-Originating-IP: ktDmJ8wFfoS0U7omIKUwwKWalGUVF+AwW9KX5f9UOSs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 16:00:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15826050987606234436
Date: Wed, 13 Aug 2025 16:00:54 +0800
From: Yibo Dong <dong100@mucse.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "Anwar, Md Danish" <a0501179@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <71381A4EED369AF0+20250813080054.GA965498@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-2-dong100@mucse.com>
 <5528c38b-0405-4d3b-924a-2bed769f314d@ti.com>
 <F9D5358C994A229C+20250813064441.GB944516@nic-Precision-5820-Tower>
 <d0c2fcb1-578d-443c-949f-860c94824ac9@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c2fcb1-578d-443c-949f-860c94824ac9@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nt+z/y60tPnUaUj6SZMYDnHvirVA2nluJOMhraiY86wLNT7/zDo2eT3X
	xQkazoUVBV/kg9muNcBWhl8XLU1pvAd7coiSnNk1BX+dvMI4nHoU+47WfGN/3e3j0vQ6Xfy
	eDyGzKZOhanMoIDKodzMEpSeSuIeHOzbkNbc/HPnlQM9xGMs75vaJeIVyIgDGbLRSD/zwru
	V4V7P8ntmwaqaKu+0DBADjKN68/eanAY2KJ6ju7l9UBrhak4JyUjL09LATJqoqN+ZE4zDG7
	OCg7zNStt10tZAzF6cZHMAirZZqxL4oqOvtEjVnyVGHjKovpYdMFXNr3ntZhVTzTDVIJNcp
	3v4FucnGSpBVHQRUQTQWHsiHxPW402cWDTtvJI22LFeLI3l9pdDrqmDZDtQnPUMxdW3LoXR
	ILAmD/SZyYRwxUaTs4r/124qgSs4a/MGalexPz2p4G3asmtCpkecrXei7M7rkM/BR8NeXGk
	PbBJdw70i2yZiwd5BL+OV1ZJ904G9t5YQKWAbTX2fhYh4lAXSPhQtRjQB9z4alpWFCbAyTJ
	6wMCZwvdjzlD2poCpZmcEzranT8+CgTNxBk/f4C79N6YNCh4pjrSHYknxj7g72e9QXZfauj
	D7n8WJWRd84mPnojM9aiLoslCw9nk7YWIDFxznGBf9G5F3qrENoVXc3lEVedQk0smqIYhSq
	cYrQ3cBZS694zA237Y2ZdtL1JCfm7BhNNOXHYZHZ3yOCR8B464Bvr8vOgqyTzi5YrG0o0ZE
	0U/ggAyhlWzJOK9V7JoFbijMbafBMHrEjtwr2fzcprxcRsYO8pXBori4IL7Te0t1cTw6fGQ
	jIzt2CqFQoBbT8BkbOEhZDBf0qbsM7kD0bOx4qRgoBr3FzM5wuAbY0DMUdYXXM/ZLaeLtaI
	uAjEyPS0nN22i+gSII/S2kL1TKK4Qb4K5Bpriwe4lTX83+lmrgb0ZXlnuxNf7W8HQTL8T5D
	YXc6o8rcntZX6xKECL1GXVyq0mLJsvvHnJxbp7oHWBBwHYH8mF0HLCbC9fm3YS9saNF+LgP
	fmDjZ1grkff1Y4SjHZZqpZeKIOl1s=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Aug 13, 2025 at 01:21:26PM +0530, MD Danish Anwar wrote:
> On 13/08/25 12:14 pm, Yibo Dong wrote:
> > On Tue, Aug 12, 2025 at 09:48:07PM +0530, Anwar, Md Danish wrote:
> >> On 8/12/2025 3:09 PM, Dong Yibo wrote:
> >>> Add build options and doc for mucse.
> >>> Initialize pci device access for MUCSE devices.
> >>>
> >>> Signed-off-by: Dong Yibo <dong100@mucse.com>
> >>> ---
> >>>  .../device_drivers/ethernet/index.rst         |   1 +
> >>>  .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +++
> >>>  MAINTAINERS                                   |   8 +
> >>>  drivers/net/ethernet/Kconfig                  |   1 +
> >>>  drivers/net/ethernet/Makefile                 |   1 +
> >>>  drivers/net/ethernet/mucse/Kconfig            |  34 ++++
> >>>  drivers/net/ethernet/mucse/Makefile           |   7 +
> >>>  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   8 +
> >>>  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 +++
> >>>  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 161 ++++++++++++++++++
> >>>  10 files changed, 267 insertions(+)
> >>>  create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> >>>  create mode 100644 drivers/net/ethernet/mucse/Kconfig
> >>>  create mode 100644 drivers/net/ethernet/mucse/Makefile
> >>>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
> >>>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> >>>  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> >>
> >> [ ... ]
> >>
> >>> + **/
> >>> +static int __init rnpgbe_init_module(void)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	ret = pci_register_driver(&rnpgbe_driver);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	return 0;
> >>> +}
> >>
> >> Unnecessary code - can be simplified to just `return
> >> pci_register_driver(&rnpgbe_driver);`
> >>
> > 
> > Yes, but if I add some new codes which need some free after
> > pci_register_driver failed, the new patch will be like this:
> > 
> > -return pci_register_driver(&rnpgbe_driver);
> > +int ret:
> > +wq = create_singlethread_workqueue(rnpgbe_driver_name);
> > +ret = pci_register_driver(&rnpgbe_driver);
> > +if (ret) {
> > +	destroy_workqueue(wq);
> > +	return ret;
> > +}
> > +return 0;
> > 
> > Is this ok? Maybe not good to delete code for adding new feature?
> > This is what Andrew suggested not to do.
> > 
> 
> In this patch series you are not modifying rnpgbe_init_module() again.
> If you define a function as something in one patch and in later patches
> you change it to something else - That is not encouraged, you should not
> remove the code that you added in previous patches.
> 
> However here throughout your series you are not modifying this function.
> Now the diff that you are showing, I don't know when you plan to post
> that but as far as this series is concerned this diff is not part of the
> series.
> 
> static int __init rnpgbe_init_module(void)
> {
> 	int ret;
> 
> 	ret = pci_register_driver(&rnpgbe_driver);
> 	if (ret)
> 		return ret;
> 
> 	return 0;
> }
> 
> This to me just seems unnecessary. You can just return
> pci_register_driver() now and in future whenever you add other code you
> can modify the function.
> 
> It would have  made sense for you to keep it as it is if some later
> patch in your series would have modified it.
> 

Ok, I got it, thanks. I will just return pci_register_driver().

> >>> +
> >>> +module_init(rnpgbe_init_module);
> >>> +
> >>> +/**
> >>> + * rnpgbe_exit_module - Driver remove routine
> >>> + *
> >>> + * rnpgbe_exit_module is called when driver is removed
> >>> + **/
> >>> +static void __exit rnpgbe_exit_module(void)
> >>> +{
> >>> +	pci_unregister_driver(&rnpgbe_driver);
> >>> +}
> >>> +
> >>> +module_exit(rnpgbe_exit_module);
> >>> +
> >>> +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> >>> +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
> >>> +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> >>> +MODULE_LICENSE("GPL");
> >>
> >> -- 
> >> Thanks and Regards,
> >> Md Danish Anwar
> >>
> >>
> > 
> > Thanks for your feedback.
> 
> -- 
> Thanks and Regards,
> Danish
> 
> 

Thanks for your feedback.


