Return-Path: <linux-kernel+bounces-767806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19090B2594F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A600727549
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC57237713;
	Thu, 14 Aug 2025 01:54:41 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455D14A4F0;
	Thu, 14 Aug 2025 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755136481; cv=none; b=U4RLME6ba4xM3bKsUlFJ4iwANlNUrfunY5wAJEvmUwGCsvcmowWyZVVsWPjKkFRhQRbudvfVCKOFEsLcZTwRgafxMHy5C/q1aR7/9hS1GJyu3NTX6StW/9FTu8BBCq/Wg/TE1CDF5BQWMHyEgAXypXkQg6NA8hXe5Lhc9zoE6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755136481; c=relaxed/simple;
	bh=Ac3maCaIZzqWgg+Pzfw4v81Zk72IU43wq9/V06+1a0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8vmRMEcmanqcdQP3Duz/x5puIHe7Z/pTDpHso+UkgZVdmlSrW3wLIRCtkwoMpkQmav181FqFlAXgltXSsp6zrZ9Y/i5vHTw1PIKnufKJTxtLm7xIyjrS6d24gu61OLy7e4LTdZ1ucPKcLvvhaDZyBF0IE8ZjugPmALhZ5f/huQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1755136417t11072677
X-QQ-Originating-IP: m/6wtrsB7RUkOkSTUYXbZsMfDHOmwTUKxwgLbPBVHBI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 09:53:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12872293914549841660
Date: Thu, 14 Aug 2025 09:53:35 +0800
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
Message-ID: <3B3BFEBA13D607F2+20250814015335.GB1031326@nic-Precision-5820-Tower>
References: <20250812093937.882045-1-dong100@mucse.com>
 <20250812093937.882045-5-dong100@mucse.com>
 <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
 <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
 <2ef60880-f85d-4a1a-b50c-9ea73fee70b0@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ef60880-f85d-4a1a-b50c-9ea73fee70b0@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MIEbEOayU4LolvXP1In3pbish+h1dk16IWye5SafhIHhT2J+ADgvwF20
	oFQR5rmIENmn3U3pkpeXEd120gltLulhAnMtiXrEPYsPIQ9aiNFn0cK5uXP10zjsz3MicqM
	Bm786NKpYpTsV3cP8QoXTQiAvm1E8PXAw6mzX3Zz6MkoQ6nwinJbIsf34cnA0VLFT4ob5Rn
	L5DDmU7mbQtxvuID866k1ujsihjPDb+QEnNjZJtUdi2djJt/vi8+SS6w8l2ks/+8CX8veZw
	1axie63URi7E+cjXRJUfyQm4FBn0UaorHx843ISgtnXn549LvyS+YljfgrJYZj/4XsbBc6K
	ag5aIQoZXXRQaVCo5HopTN8IehPlWE46P8iapCY100k3vQeDphcvq01tTkhzS+boIuj9d33
	nwC77B9dv50OFeD8cwk3MYdj7ob0wD0FrVpZQ2u8CrkfvnbjRIxH7fybas1tbuVYZpUvEgZ
	0ZIntOwGi0rDV/DA2Fdbuzy1OmhBGWIqX9t6Gd8L15F07BplNr/4+sSWolNSG6geoXKWOwl
	CzHuxftf52TRB8ykjgJjcOgRSISCXuc0bg5yNnqRbJQig34Hpp0griEkCI3KivOX9JDrR8s
	BDJCJ+zWNyt/BXi5sahah0hweE1tIRP25Am9Bmujk017FKDT7yaG667nQTQ4SHI/XCrBbyq
	Tbmfvmf0ClTgQMdLQs2ENkdXNMRO1DLKE/EWXlMlA2lr5m0H+G7wx738dl3vOOEs1LtoACa
	mYF52y0OH7oObiqTvfcGQxllcdTBWU0QiHOyUrK/V0ADbDF59zi5TgGqI2v2IQYJtoLpxlJ
	yO8fbQvcTj3kNeadhW04DTrlQFeyF7zR0UVFncVJVEm9+Gkt+5mrgIIs4mtdTyopvWhMAF5
	Wt51qExzPLqtLIxClPjVntz+MqNrBOfk7K65tqKKTzaNrysb9dJbHJ/46a1Au+SV+1wJtCf
	O0J8wc4jm0hqB0jSoTdvu9X+511EmXCt6CTEo+SlE6f09QIUh1BMtXdHZSJkESMfH6GKH+D
	qzZgjgVQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Wed, Aug 13, 2025 at 02:33:39PM +0100, Vadim Fedorenko wrote:
> On 13/08/2025 10:52, Yibo Dong wrote:
> > On Tue, Aug 12, 2025 at 05:14:15PM +0100, Vadim Fedorenko wrote:
> > > On 12/08/2025 10:39, Dong Yibo wrote:
> > > > Initialize basic mbx_fw ops, such as get_capability, reset phy
> > > > and so on.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > > > +				  struct mbx_fw_cmd_req *req,
> > > > +				  struct mbx_fw_cmd_reply *reply)
> > > > +{
> > > > +	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> > > > +	int retry_cnt = 3;
> > > > +	int err;
> > > > +
> > > > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > > > +	if (err)
> > > > +		return err;
> > > > +	err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> > > > +					L_WD(len));
> > > > +	if (err) {> +		mutex_unlock(&hw->mbx.lock);
> > > > +		return err;
> > > > +	}
> > > 
> > > it might look a bit cleaner if you add error label and have unlock code
> > > once in the end of the function...
> > > 
> > 
> > If it is more cleaner bellow?
> > 
> > static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> >                                    struct mbx_fw_cmd_req *req,
> >                                    struct mbx_fw_cmd_reply *reply)
> > {
> >          int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> >          int retry_cnt = 3;
> >          int err;
> > 
> >          err = mutex_lock_interruptible(&hw->mbx.lock);
> >          if (err)
> >                  return err;
> >          err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> >                                          L_WD(len));
> >          if (err)
> >                  goto quit;
> >          do {
> >                  err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
> >                                                 L_WD(sizeof(*reply)));
> >                  if (err)
> >                          goto quit;
> >          } while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> > 
> >          mutex_unlock(&hw->mbx.lock);
> >          if (retry_cnt < 0)
> >                  return -ETIMEDOUT;
> >          if (reply->error_code)
> >                  return -EIO;
> >          return 0;
> > quit:
> >          mutex_unlock(&hw->mbx.lock);
> >          return err;
> > }
> > 
> 
> Maybe:
> 
>           } while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> 
>  quit:
>           mutex_unlock(&hw->mbx.lock);
>           if (!err && retry_cnt < 0)
>                   return -ETIMEDOUT;
>           if (!err && reply->error_code)
>                   return -EIO;
>           return err;
> 
> 
> looks cleaner
> 
> 

Got it, I will update this, thanks. 


