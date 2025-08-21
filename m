Return-Path: <linux-kernel+bounces-778792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD1B2EB11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9A1A23470
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEBA2D5423;
	Thu, 21 Aug 2025 02:05:18 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA8230BCE;
	Thu, 21 Aug 2025 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741917; cv=none; b=ZfgpzNMsmwbt7QisdrjoM2VTOIf6YfZhzt15cSWDywSZ8SdoQDizFGX/ww202d9fotehpeCd1WsAO4dOlezRGlCRlB1Ia1U1J7oFpIlkyV/zFq1w9WKp2+jLP7ttbQQFSAOlAeCYHsPlqSz2SB4xgSOlCuuTW1/D8vlCOmllbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741917; c=relaxed/simple;
	bh=FNLBdWhtXd2m9yHwmeI8KFlYBcHkijGv9Sr7nDG2Uyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNpLi9fyNVxQePIgfs/P5TcndLjoPxFHsyvpKw/OCyAtCJvkUg8kW0ogxTp4tpN1Rp2oU9rtL1lJUSPywfIlT7WJAAqODcq/YsCC55DrEbWy3F7IX+1qOmVDOjPd0MGC0J6U7jriH7OCjznL8WAQjH5dLThoYmHSBSB7vl0S2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz12t1755741849tfda9277f
X-QQ-Originating-IP: CBo+yViVKO1fMalkEw0THj+HBznWJv82D9hIYlQUVFM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 10:04:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4256339024035975856
Date: Thu, 21 Aug 2025 10:04:08 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <9BFA6532A427F621+20250821020408.GE1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <399be32e-5e11-479d-bd2a-bd75de0c2ff5@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399be32e-5e11-479d-bd2a-bd75de0c2ff5@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NY3HYYTs4gYSjrhh3m4f0J0Kvtdb/NldPTYVgytLe5LaYOwshZEv00FW
	vk75Ova3HY7YABMvLPcTpJ0x2t7juGYgsk6GdypMPmazhtZNY+UBwUEmHna+w81AfgIlvMx
	tiSW5We2O9FJuhlbG3cOpAEpVe+eDDlhsOzu0LuhdTKLZtMcP/TCnZGRBQwkfm09LpxJeiZ
	m9wnEDEEwCXbcuq+MDLzvZPItSRnkpRLYvKMNa+UvxM/eG2v6b5pXMnx6DYHwGBpdcJ+BJG
	5Z28k4rMbHU2C+Emcwy1HYH5HRw1eTLXO+ihWyw3J+4g/wnD1S3J746RRpXm5QLvG7vz2qq
	MMog3g/ZQSUFMAb7K+YfNhc8MknPO4agjHByGRrpr6deXMJqmBonxzViW8M8OJHJDn+eNNl
	pg/SWlo63yPH+yShLAKY/PinkhO8ijnpW9Enm72zCmbzG6zdHq82VGgz5iZLJUcNGIbUZxP
	HulYLTG6fkwtt7ShPxgqNslqYpuqtPcH1+5usAFPDbxwBXO5kAzlQZDRDPg/9eP6C0ztkFl
	KuM0fwGrJTwUA8QtjmbmV2s0J8luxGr2T0wpoDgb9kAGssRcFiNXNUo9IqzPLpnvYmpPHgr
	C7c+KTjeWgnM6x8SPRuWSBTu2TffvkSslkm3d+NaY4LCtZ+Hq7sIaSWxWrPegQo/3WAh8vo
	wie/phgYRHBvBg6HXmLVe2RgEr/3pGPeZlfETywdmAkeRwmJzkrcNf45YWfQW8+zxkZ6HAl
	W9gOX5PzDy5fsYxCJq3j9IdLiv4poXKRruc7emxMcqu4Pf7SXxDD552xWss6H2RZdKJDrc1
	WqCH2TY72RVSTE6XSvSZZqttRF9sUOGfk480KMh0s0zoi+UgcewQnV5cPR5/H/tw/1FHWMP
	nT8jFyyb29FisGEujhLptRT0dFoFSzwGD5Er8rHuZaWlNShAXPjQNZUtyNpEM6RGvrpnVMx
	kWF98bEC+aaK4rC9ju9W+MNR9rQJtI4A1QJZFPpb1oBnvN2civXjeqUsv1lawWs0I6bfq0J
	RxupG4DZzxPafjWwNVpZ6DgfKsCsOi5XJ9mvG9l+XnEa86ccIB
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:30:17PM +0200, Andrew Lunn wrote:
> > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > +{
> > +	struct hw_abilities ability = {};
> > +	int try_cnt = 3;
> > +	int err = -EIO;
> > +
> > +	while (try_cnt--) {
> > +		err = mucse_fw_get_capability(hw, &ability);
> > +		if (err)
> > +			continue;
> > +		hw->pfvfnum = le16_to_cpu(ability.pfnum);
> > +		hw->fw_version = le32_to_cpu(ability.fw_version);
> > +		hw->usecstocount = le32_to_cpu(ability.axi_mhz);
> 
> If you can get it from the hardware, why do you need to initialise it
> in the earlier patch?
> 
> I guess you have a bootstrap problem, you need it to get it. But
> cannot you just initialise it to a single pessimistic value which will
> work well enough for all hardware variants until you can actually ask
> the hardware?
> 
>     Andrew
> 

It is a problem related with fw version. Older fw may return with axi_mhz
0, So I init a no-zero default value first. Also, I missed to check the axi_mhz
here. The 'usecstocount' is removed in v6, I will update here like this in
the patch which truely use 'usecstocount':

if (le32_to_cpu(ability.axi_mhz))
	hw->usecstocount = le32_to_cpu(ability.axi_mhz);
/* else keep use the default value */

Thanks for your feedback.

