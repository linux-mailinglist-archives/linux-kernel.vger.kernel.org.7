Return-Path: <linux-kernel+bounces-740683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD259B0D7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC9816CD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D9128B7E0;
	Tue, 22 Jul 2025 11:07:29 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298D23814C;
	Tue, 22 Jul 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182449; cv=none; b=X5xA1WYrvPzlwByscQMjKdu889JeUPoQkzDXSIssS8n0rPX/Gn2NDjYHq7i6bKHUSiGvkwhiZOlmhHLqHoVg9eApqfZZpwUOIKoqQnFfB6FvrtamepquYbi49bwHQASohfMXU58wCMfvMzOa9KyD2Obo9qljPZk9QNNkvteKTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182449; c=relaxed/simple;
	bh=osaPJphBkG3Oc5IjP9rPY0C6ox0p0oIZq0W6NW8vKys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1EdRA83yFbFjkkHsBV+7hjSDnruAKhq7jvp0h/KQw7+iZgZX0ulQi9WUo8gUoEbHzRlUzVjzTzZh8X99UplwLos/BSoEE4YO2RNrEubOTU81p0WPr1pPyG7NCSdxv4bpMoHgMq7jJaqnYpsd8CoO0zk6xZz6UCY00fBSTeSQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz15t1753182360tf29cfbad
X-QQ-Originating-IP: FXuqZDVo/GZ6z9v0ge1P2MCwsAK4t9NGsisCs29wpck=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 19:05:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1745295540662431408
Date: Tue, 22 Jul 2025 19:05:58 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <6D29CA59CCFC37A8+20250722110558.GA125862@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <32fc367c-46a4-4c76-b8a8-494bf79a6409@linux.dev>
 <D6DDF24A13236761+20250722030245.GA96891@nic-Precision-5820-Tower>
 <60ac707f-b57b-4f31-8c54-b59e75200181@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ac707f-b57b-4f31-8c54-b59e75200181@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MjQ00mYXMHtup6/6E8WvkwJ5Hdu+nkGsDuIEICcNbJCVR537BlIfEl5K
	ThecBWR/YSY6Rr6bzUIQiE0VUjZEE4vq7yygvu+C5j4X2nkZ1hxsdCuaVyV44qnW6HHF3AF
	gKB5SCnHLvjlhauaAND0HwBp34Pe3OocUORZseJcAhMU4raE2qjR9fOOyNElCo7vRxdYgmA
	xmqbu4UVYgqvBtZZddIMfEudR0FKfkwg5AXgi4hsOv2nFrkzJy1PURphHSp0Z9XWvvhLmgb
	cW9k8qaPek5rDpEctTGZ814WDoJFmfedCMbx8ix0+zVpopmDU2U4vq8NqqsQ1wOEmiV5M0l
	QeiQhgByM5irfBSunTFg4ahlzurxyGUmPsjjVF6q+CPhWoA25GEQ6PZZ9LOfLmMvjz4aXAd
	I+Bv7fmhQ55MKcuuksgZxKR63OQ3V8cRSzWBByM1PZIDFwYVSExscLgiKDKKfDPVp6z2f1y
	kok4y4t6Mnj57/d2X76Fr1aMOUWa2g5Il3DXbCofxKxsJAcvKGp4Ufi8vPMTHKKPk3+aiNK
	Qqbafd/VCwxjd55YchzhHW1NKzV2Y/5Hql+pteDhiC7wyHi8GZiEJJOmuVPOfMX64yqBBZj
	DfAEWdfOlRA5nvpO58ZoLOmaMivf4LnTbHfuZc8UO9s1rFrbwQuf7cWJt4Y4f9n4baTOQc4
	h+A8GSO08EhWLaO+H24ZY3qiHyscTpEOkpWfrnzy8W08do1gPkfoQ7vB+qrK+tfiWfzzcLD
	nmW9vhkazUxyE7rFkCTx8Ysw5IPvTfN6u7nnNMylp33fVkTKKBbnlod1oEUUgIVZMW02ZnA
	yPiuQSD4rFhlozQ04A0vnrW7YLr4uOVZB/3F3Bs7xtE6GRcAaB5Hmk0GM7s/qVELdqG7op+
	zA/bMoRevmsm32NcNPx81GFVAuN5pR/1t+E7xwFuBnACzznO7B4W5omHaxSHkJJa9eHnk1T
	hLs1pTwOTjtUKQlE7J7U1pbdI6BZWvn1L0iletr41Xzm15gCL333UTvluQ3tdDSDHEQG0aU
	PjzejaAg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 11:17:03AM +0100, Vadim Fedorenko wrote:
> On 22/07/2025 04:02, Yibo Dong wrote:
> > On Mon, Jul 21, 2025 at 02:30:40PM +0100, Vadim Fedorenko wrote:
> > > On 21/07/2025 12:32, Dong Yibo wrote:
> > > > Add build options and doc for mucse.
> > > > Initialize pci device access for MUCSE devices.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > > ---
> 
> [...]
> 
> > > > +
> > > > +struct mucse {
> > > > +	struct net_device *netdev;
> > > > +	struct pci_dev *pdev;
> > > > +	/* board number */
> > > > +	u16 bd_number;
> > > > +
> > > > +	char name[60];
> > > > +};
> > > > +
> > > > +/* Device IDs */
> > > > +#ifndef PCI_VENDOR_ID_MUCSE
> > > > +#define PCI_VENDOR_ID_MUCSE 0x8848
> > > > +#endif /* PCI_VENDOR_ID_MUCSE */
> > > 
> > > this should go to include/linux/pci_ids.h without any ifdefs
> > > 
> > 
> > Got it, I will update this.
> 
> As Andrew said, my suggestion is not fully correct, if you are not going
> to implement more drivers, keep PCI_VENDOR_ID_MUCSE in rnpgbe.h but
> without #ifdef
> 
> 
Ok, Got it.
> > > > +
> > > > +#define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
> > > > +#define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> > > > +#define PCI_DEVICE_ID_N500_VF 0x8309
> > > > +#define PCI_DEVICE_ID_N210 0x8208
> > > > +#define PCI_DEVICE_ID_N210L 0x820a
> > > > +
> > > > +#endif /* _RNPGBE_H */
> > > 
> > > [...]
> > > 
> 
> 

