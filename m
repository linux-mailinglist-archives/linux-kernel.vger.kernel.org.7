Return-Path: <linux-kernel+bounces-766067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96533B241D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E531F621C22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554B2D0C6C;
	Wed, 13 Aug 2025 06:45:50 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543B2C3240;
	Wed, 13 Aug 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067550; cv=none; b=JWHd2z6U17DVPbDEH/2u65j/TqsBAjqsYelHHFBuGccGybWQgW72zSwLDTNnvypUd45qN3nRdT82q01yihMqdb6Mo6N2Xz23ZP8obIkSJuuA67QSBtb6Bl2eweMOX6ukRDwIDNq7S8fC94ED4khgT0UxZ74xx7Sy7rWjkfN4BoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067550; c=relaxed/simple;
	bh=X1iAxCzkC0UTn04Af07aTWJbu6jdxrV+7YWDNaiy9Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHE9ZB9qDYrF6iE3+PIpDaq4ouZ6ZhTiQS7A5Ij9h/ZXnSLWYJoX/MtzIyA7TEYuGZ8mzsjuBngGgaYJKhYPmWOmb6rp8qrrTQNB7U89AEivQtepz5zBGsESMYW3kmrm7PYCuva6LWu1byNghiG0oRP4djX+2zj0j0Me62QTZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1755067483t4b22c6e6
X-QQ-Originating-IP: atNYv484Sc0LnNQn6B0BdZHBN2Wh7P8+LL0ZD0kuURs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 14:44:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1883357001402126137
Date: Wed, 13 Aug 2025 14:44:41 +0800
From: Yibo Dong <dong100@mucse.com>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <F9D5358C994A229C+20250813064441.GB944516@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-2-dong100@mucse.com>
 <5528c38b-0405-4d3b-924a-2bed769f314d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5528c38b-0405-4d3b-924a-2bed769f314d@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NKfj2Wq2UxkCMsCw1IBd6tlCIxUPVXwDv1tSRFqaAx+AuSu4aeRiHTLO
	J37q4RFSY3pW8o0D9ZD3VgwRafPrmSGTZJ2ZY75mJ/QY7JGdglOICIBEbtdW1ZfJdv0tE9P
	9O1meq9FBi7nPc8Uu5jSJwZ6XvDic7tCXK+Fu4pCBadEF51xQzaTA2ttT/tdYabkaAtKanV
	Wwfs8Cw7XBYEYi/X7L3j/gmFOA3JYMbF8cHtUZInOT4DkM0ddAvaoJjFT0+oR3S7WH/tZd5
	OvbkCXcEx7TrRCVBkEMJnDZtIYYHCB6SWIPSjnkbTGgHfs97GfEutV+T1RJHDPJNUa4PSq4
	l2bSCure1YnhNkOxBGDJLm+EeMskP0A7fzxR8P/jpDMpsaJ+LwG5q4x977DR0HHsv7uUPh4
	3MNBgaozP3fux7eciJVbSfy71fitFbYRe6MTLsiNc2NChpzoFcA5CxSHz+Qp0tPT8J6r3kQ
	zsjEIQLzzA81DVMlsi4MADumrjrkXo3RtnULmmyQKmusPb5JnqpASwtbRDknOZIyKwm3joQ
	7h56u5R5C6dXsEXYTUtcIELz0MrXufiXHnRJcr4hCNCHBkJvI5uOqf/OBrOzszFwy3h+BOF
	91HYrvh9+AH94rpJ816Tzse67cRaE2SQYX+fbL84FmwRaSTyWSw7zQw9qwKWHTTuYvSgXUl
	i8nqjzUhZCxZGCRtMRxFQr0TNXIwMQDHD/oYLdK0gqh5kkzb/yzJoxasdWJ+H3lCvS+JN7k
	tsP3kwOGAvjXvu9EjFDXoeduAEGK0Gc44ykCsckq+gpJAg8N+hMJczhSyGsRK5+OUa4xm9E
	M8oVbHuvyTn9pgZS2k9j5LG6Xt7OUhQrRBb1ndmpzyqhTpeLNMrNX5kcBJ5LOngu4BHJEap
	tSBBFCHkpVwR4pXMPV0YefqXmDvK/mtXh/sLOOD7dFsj9zb3qv5o6XWpxhssV9/AWrhsS1a
	QQDuQQn7B449tiiczyMYvPETsItYSyk4n6Utb5jwGZINmSvnbFo+FcuLPejMgpbXYxmdvnC
	s2NmQL8w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 09:48:07PM +0530, Anwar, Md Danish wrote:
> On 8/12/2025 3:09 PM, Dong Yibo wrote:
> > Add build options and doc for mucse.
> > Initialize pci device access for MUCSE devices.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  .../device_drivers/ethernet/index.rst         |   1 +
> >  .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +++
> >  MAINTAINERS                                   |   8 +
> >  drivers/net/ethernet/Kconfig                  |   1 +
> >  drivers/net/ethernet/Makefile                 |   1 +
> >  drivers/net/ethernet/mucse/Kconfig            |  34 ++++
> >  drivers/net/ethernet/mucse/Makefile           |   7 +
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   8 +
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 +++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 161 ++++++++++++++++++
> >  10 files changed, 267 insertions(+)
> >  create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> >  create mode 100644 drivers/net/ethernet/mucse/Kconfig
> >  create mode 100644 drivers/net/ethernet/mucse/Makefile
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> 
> [ ... ]
> 
> > + **/
> > +static int __init rnpgbe_init_module(void)
> > +{
> > +	int ret;
> > +
> > +	ret = pci_register_driver(&rnpgbe_driver);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> Unnecessary code - can be simplified to just `return
> pci_register_driver(&rnpgbe_driver);`
> 

Yes, but if I add some new codes which need some free after
pci_register_driver failed, the new patch will be like this:

-return pci_register_driver(&rnpgbe_driver);
+int ret:
+wq = create_singlethread_workqueue(rnpgbe_driver_name);
+ret = pci_register_driver(&rnpgbe_driver);
+if (ret) {
+	destroy_workqueue(wq);
+	return ret;
+}
+return 0;

Is this ok? Maybe not good to delete code for adding new feature?
This is what Andrew suggested not to do.

> > +
> > +module_init(rnpgbe_init_module);
> > +
> > +/**
> > + * rnpgbe_exit_module - Driver remove routine
> > + *
> > + * rnpgbe_exit_module is called when driver is removed
> > + **/
> > +static void __exit rnpgbe_exit_module(void)
> > +{
> > +	pci_unregister_driver(&rnpgbe_driver);
> > +}
> > +
> > +module_exit(rnpgbe_exit_module);
> > +
> > +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> > +MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
> > +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> > +MODULE_LICENSE("GPL");
> 
> -- 
> Thanks and Regards,
> Md Danish Anwar
> 
> 

Thanks for your feedback.

