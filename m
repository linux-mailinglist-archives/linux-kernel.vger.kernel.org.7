Return-Path: <linux-kernel+bounces-766211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDE1B243D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77D41A2057E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36CD2ED171;
	Wed, 13 Aug 2025 08:13:30 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220C2D540B;
	Wed, 13 Aug 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072810; cv=none; b=GNdcE+XCV5mtItOH9OFLNr2/U94ivExkwiS2fBja5CsY7flpYqIZDVksbJwll1QjDVEIhqdiBRaad8Ga29dDsk4t3sVZee+CCOv/2zMGoyZwwm+IiRGHLc8ZXLc/hx9/zPmvCdVqBI+CLY6aNBfYomP+B7VTsP59GwPdSEFWCX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072810; c=relaxed/simple;
	bh=6+7jJZ3HhTmLYJo9sruLtdjHZVI54SZ6HNZmAF5DWM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzirCO7vem7X1T6+rVCskG8XaPX28mo8yJOshqnSQc5Agm2/2AvtFZFncUXB5H6YiOKHwDbtlpOlYVxzoPg65fzLWCF85fu0yjgGQ3fHr4zWpuB7mVVR1cuscrii3rfUZROdnz+m0UYbl6Nz9tLCKlNvoonnr3Ogmglasg3GZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz4t1755072724t6817de95
X-QQ-Originating-IP: +icP6DoFFNymN8R74c7afLzyc/7lvOHbSeRS8oPVEgw=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 16:12:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1664480856713457679
Date: Wed, 13 Aug 2025 16:12:02 +0800
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
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <211A876E5960B039+20250813081202.GB965498@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
 <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N3l5ASPewLWqYR3azMlZEiI6nfFXBz1FR6v3zkKFwZJOmkNMYtY5MC05
	w5AJs/OXVEnt0MolHUVxnXj4HukzRudKq2eH7LdEPPDyareSStT191dBTH4kOxOcglEja9v
	PhI7/dR40k/W4wVcp+tlCh8p+LYQCJTbfdH9rradN1DQTj79mWlFT1nK3U6jX70sqoDFkkW
	WNFAH5RMrBXRwTEwEvRg9Lka3hfn+2YQosoidoaN8SXIowV3fMxxvzuaalWRYbi7MC9nUqW
	UVXLqcXL0efhmAnW1Tl85oASi6KX6NMnwzQUGggp0G57bWx9Nun8Nwk6wLqlciPQrJHlaVv
	J+iNWzMSiecoNrWsmqRMoSEjM7pK/sajt9XMpKQIXTQcTNQ++GJyVKOCrRDsCeOPpioWcI3
	15tOEXTnMQBzqbKjK9TRKHODGXd08x3U/kaoXj2mzIDCaKWdfcttxoeuyOrl/H7BiNx3bR6
	gwqlVpqVjEgsO2kSBgtrmpETSvQsNnrfRR5+bpr8aMKm6104G6DjsQK08suOogJ5TzrTW85
	GLGjlmzbvRyMScgfzDK7JMyCrMgDoU1UtmUAp4y9cKKcpBO0uhM9C2Ay5Mb4emn/XB1HLs/
	yW5zQsBLhsprGC1LfdwZnbdD7sd2fXy6wvUzlj5fapImXZWhbMuMS+vhzVlN0FnLWEwk+7y
	PNuijB4HOkKkQ9ZHXMq1OVUA+sYsiPdmSo1E6mzCQdXnhOkdb5Z+lDeOqcm/vBtRKnnJzgO
	Ojtb/wyJvaAN+x27JsuuNATH9n3zRuviY/OATzaoiW+m/BbrBl3gKGVXfm76C2+txmUtTm7
	ony1Akxdqflo1Nnm07FFq8hq6o1/0FkGYbuen8DRhrJlJUGrw7R+/aoMXDnD3jAEqggc1C+
	Gf0kuyiYyNzBu1QpzdwQj8LbYAQQKr1FdzegbtVYzcg1Y9rW5j+tipduD8/fx/sQQdjV9Ib
	mRaGpHCnbkPNyBJpgp8fxd8+8ScQB6KoR0hsRzxWV8egCQl08VYQOOMLNOL1iLb3YynpNLR
	Sc5AV+Xkf3V7XlgEcrJUS62+d9FeuU05/TEvHk7Q==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Tue, Aug 12, 2025 at 05:14:15PM +0100, Vadim Fedorenko wrote:
> On 12/08/2025 10:39, Dong Yibo wrote:
> > Initialize basic mbx_fw ops, such as get_capability, reset phy
> > and so on.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > +				  struct mbx_fw_cmd_req *req,
> > +				  struct mbx_fw_cmd_reply *reply)
> > +{
> > +	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> > +	int retry_cnt = 3;
> > +	int err;
> > +
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +	err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> > +					L_WD(len));
> > +	if (err) {> +		mutex_unlock(&hw->mbx.lock);
> > +		return err;
> > +	}
> 
> it might look a bit cleaner if you add error label and have unlock code
> once in the end of the function...
> 

Ok, I will try to update this.

> > +	do {
> > +		err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
> > +					       L_WD(sizeof(*reply)));
> > +		if (err) {
> > +			mutex_unlock(&hw->mbx.lock);
> > +			return err;
> > +		}
> > +	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> > +	mutex_unlock(&hw->mbx.lock);
> > +	if (retry_cnt < 0 || reply->error_code)
> > +		return -EIO;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * mucse_fw_get_capability - Get hw abilities from fw
> > + * @hw: pointer to the HW structure
> > + * @abil: pointer to the hw_abilities structure
> > + *
> > + * mucse_fw_get_capability tries to get hw abilities from
> > + * hw.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +static int mucse_fw_get_capability(struct mucse_hw *hw,
> > +				   struct hw_abilities *abil)
> > +{
> > +	struct mbx_fw_cmd_reply reply;
> > +	struct mbx_fw_cmd_req req;
> > +	int err;
> > +
> > +	memset(&req, 0, sizeof(req));
> > +	memset(&reply, 0, sizeof(reply));
> 
> probably
> 
> 	struct mbx_fw_cmd_reply reply = {};
> 	struct mbx_fw_cmd_req req = {};
> 
> will look better. in the other functions as well..
> 
> 
> 

Got it, I will update it.

Thanks for your feedback.


