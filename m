Return-Path: <linux-kernel+bounces-766420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C518AB24667
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136C1884E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B872F49E2;
	Wed, 13 Aug 2025 09:53:48 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0D2F3C2B;
	Wed, 13 Aug 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078828; cv=none; b=TgasvbHpzFSocHicJM8MwtmqaoJSWLK+66p2BIccAuPFc9kdRlKInsB2jQE92GtLZaA8NZFPYxAaFd9Yvft+KpJXtEU7xL/W7JKTBojXEXeibW2st6Iqp5fxVGXmn1pFqRMh4eq+3R7fwSDjXooZ3bBbt2GYzFWOZ2anAPp6FjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078828; c=relaxed/simple;
	bh=+WZMCb2th4q4S3QCII5BAqLwjZKqas5JP8nnZISgNUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA5hdETvJMbY+8riaQaOED+vMBOCMDJNEJ7QBKkl3dHBgZ0TgNikuHQ+Ix+N84p2XKjjv3XGXRu9vJLXyKskDQgAtmrlLHP8pm4L3bj5PDXBk3jZaX6TRv+ONbcgy1Y95a8vOMEG6VYT++hTcKStEf3EGWDHsG7OAAq2GGAg+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz5t1755078736t6188a4b4
X-QQ-Originating-IP: Fzg1HaXRH1kgNyX7pYbXPr6PlV+6nK7OiSq/8/Z95Fc=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Aug 2025 17:52:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 535063988125251016
Date: Wed, 13 Aug 2025 17:52:14 +0800
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
Message-ID: <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
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
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MP9Cvol/R4C0d9vWA8xRaCafhl2zr34fFURZKEm7v/dCHF6Xzv5zZ+Vo
	JVNrX25ngPsr6pSmkJfDsi2TxYR0kt234iB7nbEdivNX6w9Asai7jC9qXWHtcGL5ipWfzTz
	MQYdov4pmHZXPBTewkv/XYb90AynolD8rLd4ZfL9253bKBiCWSpri8fjt484K45T7ajyKLb
	swIvxyzBGI1yucccECKq9IdhdD6KB1Sr66WL4CCKL6RDVnI0hJXSZAQ4v7aUdkJPbzWsL07
	0yabWbBNy66ale3z0uqyOiMxJFUHDXTFYDmh6TuzcWr+3CphaoScsKPabiWkqkt1T4qEVcI
	JXfb0x1fx83TOYlEAAFLcBVfE5bQn1ldgWMmhHum3unLqpA/nDtP0ZoLHYK8zi81DaZrSot
	dVvFoLru5m5EuBlcQnc7pTewgMGJbm1d5DTC/QnajFE8I2ngydE892N2UID9BlCCFlx0w/L
	/84Qq+LhJ0pU59fTNgaG4IeR6gMn3JKEMOTjzDSCy0CXgbkO7dCGKP2K1QHnvGpVf3cYejA
	jrYBP8sLcEJYaV/ewvjf70EpPq5YRLrBf0JsEx9t929AmBjYHYT74voJ40VZBU8eR1RMp73
	I9MHYxlvTovYwusivPSizoFqt+8fT387TicXRPUJ7vvobs5bhu5t5CTIEmDkHIpYAR5enw7
	u0+gYhDoW/tTsoy47kvR/Lf7ccKVQebVqu04a9Vzh1OX791pc/Iny1fcVvSqz6me5i8LUKw
	ph7ENv6knyQ5UoNMmpH5BGzfEvf5R32jfE1cePlWfuEqiv/w96epcA9AFEb2U9mac5wq8nA
	mT6bJOeN16A0kytrQ60lMmnqyndk7x8j1wg13/ftD8cjhjbvL7WMFHXjLS1asX2b9Kq0h7O
	jB47kGcKAGwLw8s/eW5tP7vYhJhBwcX+za0jOXtSuB3h9r2RpLWmq0dOpXgwRczROqHg4EX
	Cxdyvj0VD1ysYyclNj7ZLt7Yt/0Zmawzu5N5rJLYXf86RwodK0SisGGiWucbnepPahkzxoq
	MPNkc51LAJh+cutfxd
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

If it is more cleaner bellow?

static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
                                  struct mbx_fw_cmd_req *req,
                                  struct mbx_fw_cmd_reply *reply)
{
        int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
        int retry_cnt = 3;
        int err;

        err = mutex_lock_interruptible(&hw->mbx.lock);
        if (err)
                return err;
        err = hw->mbx.ops->write_posted(hw, (u32 *)req,
                                        L_WD(len));
        if (err)
                goto quit;
        do {
                err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
                                               L_WD(sizeof(*reply)));
                if (err)
                        goto quit;
        } while (--retry_cnt >= 0 && reply->opcode != req->opcode);

        mutex_unlock(&hw->mbx.lock);
        if (retry_cnt < 0)
                return -ETIMEDOUT;
        if (reply->error_code)
                return -EIO;
        return 0;
quit:
        mutex_unlock(&hw->mbx.lock);
        return err;
}


