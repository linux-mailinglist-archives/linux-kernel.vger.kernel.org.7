Return-Path: <linux-kernel+bounces-782863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B99BB32625
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB1A0471C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817B19E7E2;
	Sat, 23 Aug 2025 01:13:51 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85224199FBA;
	Sat, 23 Aug 2025 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911630; cv=none; b=g0a1p8603mi5/eYXUoXEyr3MpNuMajrlI5QWN7fciNqJAtfW2L1wYTz2kPojzPUo7l8H2XRdhl/BGk9wYB7rD/szFR97Oqj+exEeVhsaqY7AOVhzyrLn2BEPpVX7LVmPBi69xh8zuz19HHYqvdtiK3e1HN/7/ix3Cy41OtuO3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911630; c=relaxed/simple;
	bh=yA6j+LdZIh8VSNBUAvoV0zZeJUNVdCboDwO3ttQ8Akc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqCDD2TMDolfwUM/JcmxfBEtzQrKhWMr67Ym0xl+K2PFjzMEd46AlE0q9Ln2CJzBjTMdL0tLhlwSqOUQmB/EQqiE1yzQq+9NCR+5ByYA+FD1I5C3bcSjfqBmqAlHHMOZPjtRQoExgjR2G9/rYLkGvS4zIbS3nfXfKvV/uCPK5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1755911541t30cf4573
X-QQ-Originating-IP: CYYpVmL7PQRqYgMsqlkdc43DVUyX20KFhx33Uzp3ols=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 23 Aug 2025 09:12:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15638722221360569384
Date: Sat, 23 Aug 2025 09:12:18 +0800
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
Message-ID: <EA6C27BA99B43454+20250823011218.GA1995939@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
 <458C8E59A94CE79B+20250821024916.GF1742451@nic-Precision-5820-Tower>
 <47aa140e-552b-4650-9031-8931475f0719@lunn.ch>
 <7FCBCC1F18AFE0F3+20250821033253.GA1754449@nic-Precision-5820-Tower>
 <d7a38afc-58c1-468a-be47-442cec6db728@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7a38afc-58c1-468a-be47-442cec6db728@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N2puXaFwQSOsJPVNGyvI0mrg9Yf6OM/n5ObKSm9ci71sdlEjeC7FJ/YT
	vL1b5iHBB/VQKpmRG0gxtZJYt0gyNlneYPynM++QJdfR4DyiHNy0D2bmakjGgK34FGk33LK
	nkpxWwv/pjhKFsdiGdEgzRVzL7aBgrPNwlbp5WaRQOmpw6HWga5aNczPjrNstk5n1p6lAjS
	522qqniIoWoBeWeFeCqv2aWYriTW4EDXJ4Rhg5bKAdAxNcq6fLW1So5WrWkz5PXRZFGY9QI
	TOOCeky+Td7ffOYkBrez3XdmvmcsTCz+eO/JrYVFVsNDF4C/reYaFZu7L6w8VBFKzFr0ai0
	Eocd3QpuCbemjXxGRo2/LxbKa3owh8njV1v9ewmphDwG2qhmrH9+M88cDz4+bLX5Y5WQM4j
	ByQZYKHxdUxj4zWNunyg8WVaN90g9O4wPyw6SRxPPXcQ56AazruZDsZkhIx8PMHqveQViFA
	zJpGcgsGIlDc7YHeI538jdpwnfTC/GvWBUh7jMufb7v0K3P6BRdZg4DWS0ZnXNlnQyYxKMn
	szxIJf3s9mt2g6MPPiKxbk6dbWWVAypWGTfxTgJsytkJBoibJL5tVTXPSFPDF6/isWexlNq
	gh9g4YJaCEg2yEMZc53mNDlotAOGK+8wl5atxRK18uBi+MHdal15jLIoaZB9n+FN6U8WOPL
	JOJJW10x2WaTF3d5acuhtDVs584zSrF/gVMytW6o00/Kpi6QncegNHKzqoyv7gIBTfnNWSI
	mbb6nsV9GkZDBip/HoQyVxPzT4aHPoyE739TcbNTPjwhxY9BMLaqJKXrk4beubBMGKtPmrN
	iZE5FakGQBVSR+XfXgN2KT+i5Mr0j8amhlBf/YVIr7gsbAreGicCcpAbm+gXbI5EGHZFk9x
	su4uMxnAf6NTlhsy6PuMZp8lzQ7TU9NqrKRxTxkmwQtuGY4biaD9u1VBCzhJmOU6w/N3aQ3
	APy90NoGNfBn0M+jLMMnaJoIX/9Rvy2+vSlGYc0DocV6StpP/QS7WohIlpR3lAuxEmmu1JI
	1yJXiC1w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 09:52:25PM +0200, Andrew Lunn wrote:
> > 'Update firmware operation' will take long time, maybe more than
> > 10s. If user use 'ethtool -f' to update firmware, and ^C before done?
> > If ^C before mucse_write_mbx, return as soon as possible. If after mucse_write_mbx,
> > wait until fw true response.
> 
> And what happens if the firmware writing is interrupted? Could you end
> up with a brick? This is actually one of the operations i would not
> expect to be able to ^C.
> 
> You might also want consider devlink flash.
> 
> https://www.kernel.org/doc/html/latest/networking/devlink/devlink-flash.html
> 
>  It replaces the older ethtool-flash mechanism, and doesn’t require
>  taking any networking locks in the kernel to perform the flash
>  update.
> 
> I assume this is meaning ethtool take RTNL, and while that is held, no
> other network configuration can be performed on any interface. devlink
> has its own lock so avoids this.
> 
>        Andrew
> 

ethtool or devlink both call mbx(mucse_mbx_fw_post_req)
to do the true update to firmware. FW not end up with a brick, it has
fault tolerance itself.
But that's not the point. The original question is
about 'wait_event_timeout', I add some comment link this in v6:
Wait fw response without interruptible.

static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
                                struct mbx_fw_cmd_req *req,
                                struct mbx_req_cookie *cookie)
{
       int len = le16_to_cpu(req->datalen);
       int err;

       cookie->errcode = 0;
       cookie->done = 0;
       init_waitqueue_head(&cookie->wait);
       err = mutex_lock_interruptible(&hw->mbx.lock);
       if (err)
               return err;
       err = mucse_write_mbx_pf(hw, (u32 *)req, len);
       if (err)
               goto out;
       /* if write succeeds, we must wait for firmware response or
        * timeout to avoid using the already freed cookie->wait
        */
       err = wait_event_timeout(cookie->wait,
                                cookie->done == 1,
                                cookie->timeout_jiffies);

       if (!err)
               err = -ETIMEDOUT;
       else
               err = 0;
       if (!err && cookie->errcode)
               err = cookie->errcode;
out:
       mutex_unlock(&hw->mbx.lock);
       return err;
}

