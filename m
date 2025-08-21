Return-Path: <linux-kernel+bounces-778850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65AB2EC02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D97DA27E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF3021D3F5;
	Thu, 21 Aug 2025 03:34:00 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56612236FA;
	Thu, 21 Aug 2025 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747240; cv=none; b=L5diK9NMXclvnljB42kjDOueRCJWRn+mgKwQGwjviLimp7DIdCEkmedWEY+6tJhS1p5USWpm/vogvcXHNpsepNchTESviAjsSyTrlhgLTN496ns6uGmFTqRvLFqOqUfgL3Y1JGD9huYs5JQhkBWnUWxPkjXdHDaT8D8RdJhmm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747240; c=relaxed/simple;
	bh=4LFcMDfo/zbUYfGKlorYccLY9PwrEh1kqHEyrvJizI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqUpxfzAkxEbwtHZTHpRv0ibH8TqoZn8Dzuo8qXOVRH3IWiUi/mpJlc3CCSUzqQhKpZo/j+8hXbtb+8Xn4lJfSK/1LUxy5b7CgyaNjhVV8IYcbQj4RweJcJeoGquKI/olcL1NmL0PN7V3RmFEwUShSbZ7xxJLF/yeqC5wYPZ3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1755747174t1aeda2f3
X-QQ-Originating-IP: B3BZVKqW3jX07jw0veN9lGFzHwGmjdz36KID2sMYiu0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 11:32:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9983899224186391793
Date: Thu, 21 Aug 2025 11:32:53 +0800
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
Message-ID: <7FCBCC1F18AFE0F3+20250821033253.GA1754449@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
 <458C8E59A94CE79B+20250821024916.GF1742451@nic-Precision-5820-Tower>
 <47aa140e-552b-4650-9031-8931475f0719@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47aa140e-552b-4650-9031-8931475f0719@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQNQM5UP8StMDdmKQ4cRpMLnC0k46CBi0zEzzNyRSLR/BE1SaKY5q1S5
	K2ciQrHPMZWVMGLWSPv2RPzvZUoHtkmM727bE3FIvzcaj640sji/YkyObHfR/zTYTvTTXrM
	WajR/GvMSxvFWai706RlPJsdQVovluBoUnPXZrYljKLIHaSviX/OIxI51dYZu7jvGwxlpWm
	GN1ZzGpEyZ39BBeu/zObz28Pt8y9MpOzsx5A683DPj158Tv9z2JL78WUqOKyC/PYQRjWT4F
	T8Ja1q3KQ65zTmvV5p0YA0TkGazHHWk7nWxpup69emVymgV3SvKfKejewonNLCoGdyrrlEL
	y9Gq10EFBAKY1KrFXLobEGSG/ZUg0vev0B6Rkfb0szg4CxI/JN506iqbE9mWb5Vzyo7d9EX
	3iZvTR5XIDtejL7NbCVQcrwG9oK0kREzXGANpnpddUUj8j1chaaGUEIeTLvZV1MggEEjSiu
	z2txRmyqTJlb1LhXOb2riTM6/gJx+0CqorB0Py/wxf5VHvMcCH3LLpcp5/ebqb5nGUyfNiN
	Q0BkHu0vUjb8z1hCbJTPnSFHFhaFUmCXkhdDvqHBEz2J+xm+QPFeLju0vU/SA+w6VZGPQBw
	geDL4hVZc8v0agMLuW2QHgp49ahWMX30g9kC8Q91shRIjSTzJLJCldyPWbqv44zV7lafl6V
	dgDx/+7KVF8XpSZqqxGabMzbnJDNYG7SLnt5oTLSk5F22t5VtoN5zi1Yy4QmmeO5g/Mwcpf
	IHhPgVOZm6D6nwAGVa83/EqJJq67LVFcwIiR966M3T0Xnj5mxSzgHWg87zYANAnV7ivgk9O
	/OZ7MJjfcPgHLYpNWhWT4binXdpge6dh+MR1GRgqtjdgUcgNr+nPZfdIfr5hUztsbplykJ6
	YYivsi+QkLtqQvWK1wLiKO2mRFYPzJ9AIb8e3idBV6DyUrrV5yTgt22hsoD7iRlIoEARGVp
	slTz8m/AwIX3akMbtGTnQ6dU5vye6hk8xqagUAxxXf3LnUojoUhLPA+/2fgpcyKl25RI4vE
	NJdMh0L7xuUxQmerNO8t7OKi4NCqRTpy4/KGcSRQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Thu, Aug 21, 2025 at 05:13:27AM +0200, Andrew Lunn wrote:
> > 'mucse_mbx_fw_post_req' is designed can be called by 'cat /sys/xxx',
> 
> It is pretty unusual for ethernet drivers to export data in /sys,
> except via standard APIs, like statistics, carrier, address, opstate
> etc.  I don't know how well the core will handle EINTR. It is not
> something most drivers do. -ETIMEDOUT is more likely when the firmware
> has crashed and does not respond in time.
> 
> Do you have any operations which take a long time when things are
> working correctly?
> 
> 	Andrew
> 

'Update firmware operation' will take long time, maybe more than
10s. If user use 'ethtool -f' to update firmware, and ^C before done?
If ^C before mucse_write_mbx, return as soon as possible. If after mucse_write_mbx,
wait until fw true response.


