Return-Path: <linux-kernel+bounces-776793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DFB2D18A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A07622415
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760832773D1;
	Wed, 20 Aug 2025 01:45:23 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD4274661;
	Wed, 20 Aug 2025 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654323; cv=none; b=qPDiOHgLSLyZ0xEiwc07rh+GYVmnisBDZIy50tmOCBBnwwwLnmhphxL/Z+xOD1Uy4GN7AdBQfCvMPkDQojt9wosrnrwfdqq+qlvKTDp/RB1kYhlNTMVMD6p+WX0fKem5Bi2I0o4lZ2HWNTpZbOUc+RA9sukp/L9jxRxWMs9Ypag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654323; c=relaxed/simple;
	bh=wuaetC6HYS8jrlxmZDyqgB/sWl2EQU24EWs61R7V8CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC4BTDDpSn0McFNCgGP+ZbY36kN0myRCY+Z9Bf0t7IcWxZ0SwQMhijoiiUnqOpbNb/+IxhfJGSLZFYGB2nJBDDfsIF9Z1R6T3+5zcwcst9DSXpCSUrS7rmY+wv6qRrl/z0eUp+nxlYnc/zR6gAUwc8N02iRnkOVIDjVqiMpkpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz19t1755654224td6a0dcb8
X-QQ-Originating-IP: HTig/urfuy1c10xTqU33eaHLWL43Nj039I3rn71CoV0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Aug 2025 09:43:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8384300150430436104
Date: Wed, 20 Aug 2025 09:43:41 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <78DD9702C797EEA1+20250820014341.GA1580474@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-3-dong100@mucse.com>
 <d4a84d76-8982-4a9d-a383-2e2d4d66550a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4a84d76-8982-4a9d-a383-2e2d4d66550a@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OBDSLDo3By90FrPc21Vfk7dBBPSf0XMltTOezz3bfOb9pKkyW3kXRur7
	4cXO1IYYJc+FKN00cURPj7hPrhYgBv7gf7NNRdmKnpqzAQEDorMWUOHF6janB7UxmpXGAYm
	WxynZj9qqo1ci3cY7t8fc/rXERfc8TChXCyeRkngkIyam8gTzoysd0DcZSNnJqOsDwwI1FK
	zlOq5I42McGuN8ZT9gX1aZFHzMXNuom9JFI0/ykCu4++CnjEK20xKU+q1BMz4v+BicEqQU1
	hJn6e34U9yQ0ohpy2sVU7MOUUFuWmLE4DKLcwi9kMrotZ97ofhltzE9j4iXSQah2aweyNZF
	vc9m/zQrFuvUjyzqXECOKLWZ7sQWOo8AAmxz6GDmZOl7IRDBtry2Dk7Q8hk+0fQs229NF+Q
	Dchg9hsMMKIxYcP0Wdk/nssuXmbuEbtmzchosLxV23lrsZ445wZweFoAQ8OWHaD0VvcHDY/
	0V1rJTdnZVE+Liz2FDsFeX//iLUiSZehwloez/VHwa0FeMIZLOYPxAnoEWzZBDwZAisQcop
	bcieYS/pgosjsRpD1qmsUooNvtSv1tBhOfZm0JcWd139ZYBTDxc4MqhNAqv8O93zU2iRgUr
	VoH+62QkFlseC9Jzkr29uqcYJdcgidTb1sMhJG8EmBLLlr/z6XCYy8OJ35xG2oYdOeNuPUl
	fWLfPdMhti4igL+CL4ZhIqa3c1i23fWS+RK/3+oENvN0QGZIjEDtCkSXFoN7rp+OZfKx4Au
	4ysVVFU2Q/7kDjmY3wF8GkIfbBmlZImg0gXucjozTZ+EDReg6IETIU+OGcdCGAZItF368IZ
	DAqRQ+8TxOjzzWt7bzvxHPQ1DPSPV+tvkuRo9rT5AZgSE/eEDzH6fku0x3JHACgkPY6V218
	LBRvlCeEudvZ862Bh4ttemEPdsxjoyQwPzmOKavKLD1jZqGC2SpEWKDAD1FWXt6mXyzjXur
	C1GgKo6RrgoE6Ri/BJAoU4uaUUbuR3b5hQGHEdDeE+AVKVKRcEuA/RPOfrIZ5uTYEPCg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Tue, Aug 19, 2025 at 02:59:09PM +0100, Vadim Fedorenko wrote:
> On 18/08/2025 12:28, Dong Yibo wrote:
> > Initialize n500/n210 chip bar resource map and
> > dma, eth, mbx ... info for future use.
> > 
> [...]
> 
> > +struct mucse_hw {
> > +	void __iomem *hw_addr;
> > +	void __iomem *ring_msix_base;
> > +	struct pci_dev *pdev;
> > +	enum rnpgbe_hw_type hw_type;
> > +	struct mucse_dma_info dma;
> > +	struct mucse_eth_info eth;
> > +	struct mucse_mac_info mac;
> > +	struct mucse_mbx_info mbx;
> > +	u32 usecstocount;
> 
> What is this field for? You don't use it anywhere in the patchset apart
> from initialization. Maybe it's better to introduce it once it's used?
> Together with the defines of values for this field...
> 

It is used to store chip frequency which is used to calculate values
related to 'delay register' in the future. I will improve this.

Thanks for your feedback.


