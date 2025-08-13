Return-Path: <linux-kernel+bounces-766019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61903B24157
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C8C18923B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936062D1F61;
	Wed, 13 Aug 2025 06:19:54 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23042BEFFF;
	Wed, 13 Aug 2025 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065994; cv=none; b=LRpb7pTPUA1NBJLjIWKh1TSqrzNn/uFylE53EP4m6jA6Fhomyqoe3sCgQfihlZlYlFwzupvV/rfll3ujiODKWX7fzDMmvuwEqJFltz2nCthniiJ/9khPW3CBBfvE25UFDSP4invVHw38+nv1yWRgDo0g+YuY7PcVBN60qC5Gb6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065994; c=relaxed/simple;
	bh=3ZJkq7la5lVnwtTK2Th9D7Fhureaazu4IPy8mN/iHxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3S/BH2AI5ixePTH4Pp5G35JLqhfUxL9h/A+Z/M2rwysk0vhFn4+QsXfZlVnYuqGxkEJ5oF9fBZi1FwqRVoGiyZroMlyR7SH0uDdA+oFMUc2ffMMf/YwnwQj/2LSBoMC43w0Zm2RYg5c5nKulDgbr8CRiPzWImRIEshjVnTbPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1755065920t41ae54d8
X-QQ-Originating-IP: AdfvCmkw1jzKNuoTwujDV1j2Kvo/2VMby9S87bMpcEk=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 14:18:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3343729203366408891
Date: Wed, 13 Aug 2025 14:18:38 +0800
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
Subject: Re: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <2D407F75EE3286AE+20250813061838.GA944516@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-2-dong100@mucse.com>
 <590a44a2-20a2-4a3f-b57f-5bf194712bf2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590a44a2-20a2-4a3f-b57f-5bf194712bf2@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M4K5nIxZYv59CfgmVe/eOhZiq7R3ongsl62uC6asbDuy6yEFyIhQ/9ga
	N3w/2m1DpR8efL4fVv5yHR2M2x4hnUx+7bw/dmFLYkKKydLlSj5B+7BN5CmArM37qxV0jb1
	L0E/NGzD7ttp2cViM3wRKnm7sqWIzqSwhjYnSh1fsMTDOE4pUMzE0VmHW8lL/q03oS0MhsL
	NBhjZgsCRuXMKYFc458iCHTH97dwaN6iyjvQVQkFeNFHYjgK4wXAje4RD4IEteyVRVMM0de
	Jx5MzDXYvAIoHpHCJh1cz0c6eTFVD1jR+MUTj7sL6yZrgu/9tGfrDpzy5UEvl/k7e5EgVQe
	nQA2ZcXJ66boo18+jpO4pp0Ofwn3l3E6JZtmxWK2eA8uAfz7+pl93y/8yNiZpvkpJr6+c4u
	TPfdHaKP1ajFRrgCpRwW42/IPRpiJzjsj09Qi6lrZzW1eo+7+CfDJgcwkcZ+8hFoTFCCeIV
	GAQFY1GvBU2qopFC7eR4t2BXr1gNFU0UTQL1s2Wn8VpWrTIz/qAX2FKjHFbq33KMxpzzHyQ
	bjQpBznYaiJFxByhsdqP1iv6xR1mWnd2GLJl88rqJNiQbhNE9Lq5FZ6j3wF0AsF7TzuvIzg
	piTnYEM4bkQ/OIso9PdZNPQE4iU7psJkaKws9sUiZ3uixFBF3Zpx3P1Npy0k6CK6zOZKOxO
	al59aRfmyDlR1b2+9IVUwO6OwJnJvOhTxPQ41hwcl4ZcVJeKM4cXc1dlCe1TcoMQN7ZHHVp
	xOGAJhzxl8OTkwH3Lzts7bCUdK0liWhXQyTBGs3z24zwPmA6/TlxtSrhsPB2TF1rgVC6q1i
	Wmezfjx/2onNpXYUFh7TNdaK/RMZ6NznUCvRW82KguTILdU+3Jh8srvYlTpFlCFrCduudsw
	06T4YnYokUUv5kreMvpu7zZLsXSy5+srkeDcJbh1kkkBoVgnaEB+u61Cy4PwkxovOLNlpBh
	MJS8EOGCvn6ne+FFeToAc0d5/tWEJm0Wmaqx5Rc2zxDTYwejqLUlWofMj8TupOycX4t4=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 04:37:52PM +0100, Vadim Fedorenko wrote:
> On 12/08/2025 10:39, Dong Yibo wrote:
> > Add build options and doc for mucse.
> > Initialize pci device access for MUCSE devices.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> 
> [...]
> 
> > +/**
> > + * rnpgbe_probe - Device initialization routine
> > + * @pdev: PCI device information struct
> > + * @id: entry in rnpgbe_pci_tbl
> > + *
> > + * rnpgbe_probe initializes a PF adapter identified by a pci_dev
> > + * structure.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +	int err;
> > +
> > +	err = pci_enable_device_mem(pdev);
> > +	if (err)
> > +		return err;
> > +
> > +	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> > +	if (err) {
> > +		dev_err(&pdev->dev,
> > +			"No usable DMA configuration, aborting %d\n", err);
> > +		goto err_dma;
> > +	}
> > +
> > +	err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
> > +	if (err) {
> > +		dev_err(&pdev->dev,
> > +			"pci_request_selected_regions failed 0x%x\n", err);
> > +		goto err_pci_req;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +	pci_save_state(pdev);
> > +
> > +	return 0;
> > +err_dma:
> > +err_pci_req:
> > +	pci_disable_device(pdev);
> > +	return err;
> > +}
> 
> Why do you need 2 different labels pointing to the very same line? The
> code is not changed through patchset, I see no reasons to have it like
> this
> 
> 
> 
You are right, I should only 1 label here.

Thanks for your feedback.

