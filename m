Return-Path: <linux-kernel+bounces-770048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251DB27633
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EDE16F31F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C1A299A8C;
	Fri, 15 Aug 2025 02:40:13 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECB287246;
	Fri, 15 Aug 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225612; cv=none; b=gY/rA+lM0vKXI1gGpZ91Va2U2dxOzHdw5mJfxXqKsqg4yUo+J8LaFxu9sboj9XzrP8ex8qInTGZe1mO/+q9yEKtGQobUuZadd1m5u7ho0oB99MhB5mAOX9OYQQ3s6oU8StCrThEO2ftRMdv+f9f2shuxcWC6Iz5JA8VJYgQbFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225612; c=relaxed/simple;
	bh=u8I2X25WR4fgpDkMDlFyC0T3LW3CMF15mu1UZnKTUlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfBmJH5gE99sBLibdtk3LvpNmMIX9qN8CpidEc49xw+7PKS1zk5g3yETwjAoOysjnUZ8EEXGMrKGfdePbPZkV7ItM0CVQXVHhxGgdWsRb9kfnU0MeWADsXtqF9i2n6fNbkmrbutajHM1NsLPEh8UK5PbUSpnzl7IsPxcSbtuiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz11t1755225519t45fc5bba
X-QQ-Originating-IP: yq0E6dA0Nd3VzJJptiSQmJVFvn7q1TzIAMReu6KVsPY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 10:38:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5342344533602567481
Date: Fri, 15 Aug 2025 10:38:36 +0800
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
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <F74E98A5E4BF5DA4+20250815023836.GB1137415@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M613wnTrQKZbbJVjJPiVF5qUZkkZaUCybkZ1Rrq/LD7XscKj2g+IMy8i
	ZeVTua40pupIfse+Ejlzg4pQY71gRw8XkdHiJABJKhjKij+9IGr3vwG+i4eFpKqNqvhiMMr
	XpETE1WfYWELv+DJAfM/CIkfczlQDIOpraskMUJOPR9Hd1EpFYXxXXcamFxFJU2Z6XnNrQq
	luySaaIucWztMzbAyFajdX7MHZQ1QJCH6vzxzb8oo52A4eQBaPkb2HUjuFPDFO4vO5PDMS1
	6w/aaCLdOn7zTGfnsv0CLLlOhG/Bh9h67RVNwd9aqpWMAMY7pOnE7/91gx7OQN5ov+0lkqD
	6z4bRjaDoten8o1ptazvIns+mBRAkW5NxZFRazW+selTg43SoU1sZNJ3WhTJgqV4OaUk+1l
	T4yCnnZ8CBo8fgzLtDh8LEH5boc7/C+4HzKW4JLRl29PhD5L8h4h4AuOQU0dQH/MSga9tMW
	PjS4KO4vCwMHd3OfUU0HRu63JwjeqEA03yyfVBiDrG9x/pBZ9CGTmJTjtvb9joz8iBEKJhj
	gQrKWgHD0fu0vUgf/RgH2kq6anueZiWexHwb0qiOIY9YS9NQDgz5N9Zes2YXq1k2tYTEuKI
	wlEXSay5I3wA6evl2SELA4d3oQUNFqqaABh61/CSVJPhFoKNi+GQcX1inH53rWDiKG6seCl
	ursXmI5+HdnvLzUCoI1a1RAfV85pOucnJD5LkM/4dUlqTyCX1tZR9u8Q7MvKYReghODv2yf
	q25XPhCuOOurDAbNHpCFez33gQoGJSH4DSxnUr1WQgK0mVife83h1UeAhMkhmOXaJwWZ1M9
	3DTA2SWb6aqYZPZcOYn9puhCNAaz/2O0MSLmHQIBZrtcH+mB0W/FhoX2spIkEow0BQnZ0fn
	JkeRgYPemfzDM6DdyR3Wu+aeu9Q3WOSD3uUWkb5WqSxb6DibI0vNb7lYYpS9aNLplxd6aJp
	7sgvPTKXslxPaYZAzOBZiMzhsx242GrEGO4y5I2EtCjLYAHZV+NAh+2sS8vmaFaKlWa6Zoe
	rd4yZ/vhTT9G2TsRz1Ih7A12+BhUhr3qdhLGZ0j9yMGSZyv0ki6KIHvUBLL3SNd/AnnhcKD
	Evd/jLLbwfjm3dLsqNcmcXxOiChWw7C+w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 04:05:32AM +0200, Andrew Lunn wrote:
> > +	hw->driver_version = 0x0002040f;
> 
> What does this mean? It is not used anywhere. Such values are usually
> useless, because they never change, where as the kernel around the
> driver changes all the time, and it is the combination of the driver
> and the kernel which matters.
> 
>     Andrew
> 
> ---
> pw-bot: cr
> 

It means driver version 0.2.4.16.
I used it in 'mucse_mbx_ifinsmod'(patch4, I will move this to that patch),
to echo 'driver version' to FW. FW reply different command for different driver.

Thanks for your feedback.



