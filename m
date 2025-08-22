Return-Path: <linux-kernel+bounces-781144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F602B30DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565CE7BBFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16D27F006;
	Fri, 22 Aug 2025 05:26:48 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D49198A11
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840407; cv=none; b=lWngw61IivXdsftPObMos9jShCr5iL7Q/SewVINEG1ydUD7NoPEuO6HLy75e1LzsI056hYxKeFYgxBnAE9Rq4gffUH5FWZojGNALBnsa7WLGZasoLR7KAZD4k1E2fY8rHS8mJbpcIgzz1abBDjvHJv5g/W4KzHCaC+7/akJMZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840407; c=relaxed/simple;
	bh=EwC/a0KV2I8YGxKhs/nPZvHT6OBRurivwO19o5f5pV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPiBopYIGIp7Z7Z7qDLDDYGw/OMnEz69x1R9kk48TOEQiz5/mHt8Ewg7NniAOj0VX3//tm6hrq8zLSfVUDvSPuzRfUx+ouiZDRhNreQZ95UzURVhu5cTpEFANuHSaF4e+uhuu0kM4SIhKkeK/WcNKf/FUi91McqYUp4FvG/9+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1755840313t1968e2c3
X-QQ-Originating-IP: ay1n1e7+jnTaE0tAKeASRzidqi+sbKOyFZfmoekBSgE=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 13:25:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6492650603905792360
Date: Fri, 22 Aug 2025 13:25:11 +0800
From: Yibo Dong <dong100@mucse.com>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <91803970CBBEA502+20250822052511.GB1931582@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-4-dong100@mucse.com>
 <b5f36260-8615-4b81-9905-a44d05e919a3@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f36260-8615-4b81-9905-a44d05e919a3@microchip.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MhUtCUWJSosqugGjMJxwwMxlMCsnDXl1pbxdZEM2u9Eg18AzRUCAYgNJ
	Tmw+J+1g1+ZT/sVEIH6FynarCbmr58vDHQMRadUcsKJCMbeJn51MzUx1eWxPmfarPuK83Nj
	pM/SjsTQTMA3KK6k1sUrCtf8N7HO3xu6r9MI3reg9YfV9BQY69o8Rkp7J9/PU5uRE3GU7yI
	d5HNV+Ls3vLeOpbT4pqMtAl2d9sXEPTQxweuPA/6u46r6SMvWemcJasxfmbWjReFmifHwV9
	UHedw/vnkdD1ZIB940i/edPj5QUb78BKqzskXJz6eDH20F0gCVCzzPife5f6rVS+3MPixAA
	OxHlNQfMd/jzacb+sQcOdKpamEKQ7Xgd6PDuR5ScF374IiUxNZPK7d7NSxPzW+NkhSqX86Z
	Dv9EM/mKWGqFncfkI2hPw+ICQPPTDwGSUwB6HPzluvwI6Wa/qUaGDKSCmbhEMdTnDp2j6oZ
	B07zyozgVmjwLqIMWZwlPmvXSwbdhG7XMtDGrB8q+YHkWnbzN6XgyJkvVvnqWQ4t5IEonOA
	EDgazyzcr2DfasAFGbSjmL04Q4+LcVAGHQpSgsTEt9NBEJJjrrRZiDMcGEgYL2d7ZxT/nNv
	BXu71daOENiZf/ChR++0UNW3UWO10NG0uejmVJcHWHKiTOhTpfsi94+vBu1oL6woF1qc8Va
	RqDhoudIgIS4HSeE3zI00d2AZHal3eJWbjYkERdKf6u9w1uubReiof+YPaT3riuUAd7KKjE
	j4NHPzeUvo41bmomLCFwJCCeiOJ5gmGHfhpkLo0kVjz8Sl14Orf1bq3zpRgiYST6EJL90n/
	UFWElkoOgykfxdWowQTDtIluKkbStw+WOdW2+5dw6RQs6/bYAaaHrKcWsVEG4DmRSSiO4VB
	UHjZVxoMpLbx+5joVcwlStBaqeHqA6G8WrTHyBgFkgtvTHkBlgYwarWZNLPk0sRQmvKMwca
	XXqfPZLYBttjyZkU4RGXOi3tZy69Gsfw6PU2LgDLtDh3bReu3qDcZ9ngMlI8uP1s8ydhHFQ
	iGRYSRBC1T8ajQSWntVAWDQemC4SrAem8/PG6Y6A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 04:41:48AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> > +
> > +/**
> > + * mucse_check_for_msg_pf - Check to see if the fw has sent mail
> > + * @hw: pointer to the HW structure
> > + *
> > + * @return: 0 if the fw has set the Status bit or else
> > + * -EIO
> > + **/
> > +static int mucse_check_for_msg_pf(struct mucse_hw *hw)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       u16 hw_req_count = 0;
> I don't think you need to assign 0 here as this variable is updated in 
> the next line.
> 
> Best regards,
> Parthiban V

Got it, I will update this.

> > +
> > +       hw_req_count = mucse_mbx_get_fwreq(mbx);
> > +       /* chip's register is reset to 0 when rc send reset
> > +        * mbx command. This causes 'hw_req_count != hw->mbx.fw_req'
> > +        * be TRUE before fw really reply. Driver must wait fw reset
> > +        * done reply before using chip, we must check no-zero.
> > +        **/
> > +       if (hw_req_count != 0 && hw_req_count != hw->mbx.fw_req) {
> > +               hw->mbx.stats.reqs++;
> > +               return 0;
> > +       }
> > +
> > +       return -EIO;
> > +}
> > +

Thanks for your feedback.


