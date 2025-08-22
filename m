Return-Path: <linux-kernel+bounces-781236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E5AB30FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76379723230
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5596D2E5B01;
	Fri, 22 Aug 2025 06:53:11 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391DC4A1A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845590; cv=none; b=ixPndCaiqWBdtb9Ksu2kHhRedox+UxFZz6cGEljcRDApOJui/7WI5RCtGUzJEuldyVCcs4ga9yTV6JcfdoA4jOAF40Kjd39SlhMSkxKVrTcQDrlDQrEplgZxfN65MIVqS84Enmhr25PPKI0JZnfdJ1QutlDUnYfZ0DXO4xTwm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845590; c=relaxed/simple;
	bh=vplvL1nmG6kTSq3roTyiGVMH4b1Ixr3GFIczpAYrtsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOzWTEwZwSL0nbNuIGtGmGCctsCep+6Pr0LBqauLhYuiKea3sZgedAp+/apJVewqbUEMhvZK07Yjkvkbqa2tboMgMwxElliOn191SXuiq9GRliJiJ5SlX5iEafubNtcUbozqBfJvEkt1m1syos0mGgl/Gcqsm691QhFJ3kg2X2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz16t1755845493t933f16a6
X-QQ-Originating-IP: KhLwTna69ThfucotKL1WpEwMlyB+8j0yekyAFUzHemw=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 14:51:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17939985140440540817
Date: Fri, 22 Aug 2025 14:51:32 +0800
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
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <A1F3F9E0764A4308+20250822065132.GA1942990@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
 <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
 <8fc334ac-cef8-447b-8a5b-9aa899e0d457@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fc334ac-cef8-447b-8a5b-9aa899e0d457@microchip.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NOVhbBM8HVHMeUAwbWl553TcdPLZWYT4icYq/vE+HYX8s0krT8IDPDcx
	tEf1TZ6XCC5hxB63N56xcvMMsOjFReeKqi9VXxBU+HtKdFiia0dR9QOir/0sq8OcC0OYo9F
	gJgLpnmUZ7/h0Sz25MrV7HPTJ7GdCmc67vYEYBkOM3UrlC1gpnxtV4UgepybOM+SjzIXUZk
	+6N8Oe1b+qO/fqxuFuLw8UAK63KE1d9ty/LOf6w0MI2Nvbea/vDjlW5xvJj7EtNLMbBREGr
	0c6XZYd9924kAeyBhkABPi55YFcMvvU7OBnPkifq0w77mue6+GfcGbJokf2zDZRRreQ5atH
	+zWDc8pU94Is75QOgUmKNWkN4x9ILavHKcV8FHVua78OQ8T1tQsoFi6pz4DHIGbMOqs8QrP
	NPozAXDxmUA+au85xDG0sH6Eh0GwUJXKerkpSZVU3cYBzQoi8hPP1wdD08es0u76KsLIMds
	m3LyQFfYjYDSFBqWoCH79U9CMKT4YxfdhWzIgtcD8gDA9+gQ+qf+O/GZh8vRGHI8z1Gqvu4
	nyIePorhqlWGQS6XMbLJixJ9LWlI2h9EBI6JW6Qmz/GbzHNNLVAzB9iMcug2J4gT8B9Oujp
	xbbh0LUUggIqWgnsBRpGb6LqgubyOJcf7WUi+4bHG2eJNszgyLHtXBZFoG7ddrEJM/WGnAx
	tYHlU2SWnSWwqoDsnFtf8XH3Ci/m6PEbGnbr+6CHvTo2GK7qm6SP5JJD1xhOEB/U0JOExYJ
	X1AVOJLi9XjJWSmF40i6YDq9cxicS0oAFlgHwEj2/zM4cdMmsIM0Huj+ruFQlQmcVDsqZ15
	kvsMleSXpS5406UE3zJO9Ze61i/O0TihZFfVdf99rczfEk5CBpooCQhfEPWlMb6Ep/gFcNq
	R7jtfLtYraS3bB+LT1LIzBUU9lLwO2raM5s0wrbeKVzTJqA3dkGZaBI5qLpH+NqI5dmQnHf
	mj244/5zJjUcc+w1XC1Pi2HW0L55s+KBtElpzbgnvfhZIlA9+WfAQUcSbBd14mi3n/jK5Lh
	tdnCi7sO6hfZSzC25HlFjgLakepoomtmRIaKoCQA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 06:07:51AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> On 22/08/25 11:07 am, Yibo Dong wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, Aug 22, 2025 at 04:49:44AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> >> On 22/08/25 8:04 am, Dong Yibo wrote:
> >>> +/**
> >>> + * mucse_mbx_get_capability - Get hw abilities from fw
> >>> + * @hw: pointer to the HW structure
> >>> + *
> >>> + * mucse_mbx_get_capability tries to get capabities from
> >>> + * hw. Many retrys will do if it is failed.
> >>> + *
> >>> + * @return: 0 on success, negative on failure
> >>> + **/
> >>> +int mucse_mbx_get_capability(struct mucse_hw *hw)
> >>> +{
> >>> +       struct hw_abilities ability = {};
> >>> +       int try_cnt = 3;
> >>> +       int err = -EIO;
> >> Here too you no need to assign -EIO as it is updated in the while.
> >>
> >> Best regards,
> >> Parthiban V
> >>> +
> >>> +       while (try_cnt--) {
> >>> +               err = mucse_fw_get_capability(hw, &ability);
> >>> +               if (err)
> >>> +                       continue;
> >>> +               hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> >>> +               return 0;
> >>> +       }
> >>> +       return err;
> >>> +}
> >>> +
> > 
> > err is updated because 'try_cnt = 3'. But to the code logic itself, it should
> > not leave err uninitialized since no guarantee that codes 'whthin while'
> > run at least once. Right?
> Yes, but 'try_cnt' is hard coded as 3, so the 'while loop' will always 
> execute and err will definitely be updated.
> 
> So in this case, the check isn’t needed unless try_cnt is being modified 
> externally with unknown values, which doesn’t seem to be happening here.
> 
> Best regards,
> Parthiban V
> > 
> > Thanks for your feedback.
> > 
> > 
> 

Is it fine if I add some comment like this?
.....
/* Initialized as a defensive measure to handle edge cases
 * where try_cnt might be modified
 */
 int err = -EIO;
.....

Additionally, keeping this initialization ensures we’ll no need to consider
its impact every time 'try_cnt' is modified (Although this situation is
almost impossible). 

Thanks for your feedback.


