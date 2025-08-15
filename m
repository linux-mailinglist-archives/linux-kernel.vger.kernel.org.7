Return-Path: <linux-kernel+bounces-770366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805FB27A04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617591CC1C20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86C24A066;
	Fri, 15 Aug 2025 07:22:38 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219CE824A3;
	Fri, 15 Aug 2025 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242558; cv=none; b=StaxDewdKHU2k04Ycga11NeXORr8dNqzO8RIROROTXaWDsAvuM0zsOYC9ZDiW6fK6RQUCBOK2XJ+WeVdNEiyDmSv8G/AFwzdRQx8APCJ9guAYq9FeqJWB608bSUEOPwPDi579qhe3DeLhngtomUFy6Mx2lc6xFDMltY4hOyIzs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242558; c=relaxed/simple;
	bh=Zr9P2ndnhX3SK5UWWH9OdT0pfil/s2pLoN+1J1CRKnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmPb7q01o+FsXxnNXQrDgHqzcne0D5N9jMB8OcTB18SVkAlOSWF0Yd1gM3osRvSPpV6YJV1Ks9L/8Un0pcwW1ImWgaihOaoUFxdsoFA30dZ+IVXwarN+hWXjfULO7OAbCOrAJOfhiYp7sleeGzqRpU8Wt4Q6ZL6opC7M7OJZ+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz13t1755242466td134eb93
X-QQ-Originating-IP: P8B29TxqAIjtw9rcUWdGPOj/UlpMvPoKRSUDmw0C7LM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 15:21:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5156444352730471506
Date: Fri, 15 Aug 2025 15:21:03 +0800
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
Message-ID: <67844B7C9238FBFB+20250815072103.GC1148411@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
 <F74E98A5E4BF5DA4+20250815023836.GB1137415@nic-Precision-5820-Tower>
 <63af9ff7-0008-4795-a78b-9bed84d75ae0@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63af9ff7-0008-4795-a78b-9bed84d75ae0@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NyID+twfxCOjBl5qGI5kvatijftQftb6jgAw36eIBtExXbZEhO08dH0M
	6jdA1imzV9Di15d94kRKAonCByyy1f0qefbskuz5dksMWrdSqrtboqJRxqaTWLccQTCHNNc
	7ouMJSRqL6tz2mhabbs8cTBmiVyjXbcW5fgtmo/5d6EmuVb9ZeDzIOp9NKhm+ConLHzit4H
	KuQvTZDFhnjCM7ahO4K/bGva+bom/N1byNZPn+pXrhN+6wtAMye0zKG56icvduee6xNHY6W
	AFFbPRKM0GvIpBULixJhs9zM3ZKFQHMrTwZsY4CtKYT7eLt7gqcGKZM4RWJNY6bPVtcdcB+
	p0DJ31yfDL8uNfuOdjkACsvasI+A6plm5MPZ57RFcnGdN+pSqpunKyjaj8/P+CAR/2CZPhv
	Tqw+Spdpi/iiZ/BYifjBPCMDlqMCBniLxsrHfflmCiHZLeJrd9SWn6yQbIXPJcX6hf+s8w3
	jtihLB/2lpE/neHcWjDSnSz+/6nSsvrrsbbZgjlD4vgQVGW82Q0cohvjt3UDMn1dXSsfeOa
	Xd68iKsKymGXa726/vMAOXc/Vfgv1QKjtVKwo1kJubjbeLqAdLHgPg4xNJX/LVvlu7g96YC
	PA1CrcXBvNPt4jVRj1ATauHR/2lXjHixiRH2OkthqnDCnWkP0HN4LHHkXttGm4Q11eC0oJK
	tWRJ/RJ5HfplDoOQgFTvNultLOweyIEqvTtHDvvMajWDF8JJu9rltrX11Exgn1tgRLmn7Cp
	gBKHn51o9Wm6QM5fNqLjOUWKNU/cDwF44Va9XLu1DTH7IvYPIV9rhqaUvebcRdAnTfpEaqX
	5tzU99QJXEzEKiuwq2M2/R77qQQXtBhNtVVPBboSas385Uv6kwhiOuDqW/U2OhFjujmJ1GO
	iG/dJn4gEpjfyZIUJxYW6EypNI5/xEVkYZMdki8qOlvkk0FzgAksDjjNZpIJrn/PnzKe56z
	QHK7MZzVz/NcPCTXet86xe+LIg8KVLgyjC57axqz7fX1EbZqIUTIDrGgtEsWqE2+vTsmIGE
	Kn9PHb6TuanjYkScFHkIBQ/23rpUe8UWAicSOQjlpPgOOlYG2hb+PWWqwje5bxd3i+hFlO2
	buYS4ubOeTP4tbjiR2bJtY=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 05:56:30AM +0200, Andrew Lunn wrote:
> > It means driver version 0.2.4.16.
> 
> And what does that mean?
> 
> > I used it in 'mucse_mbx_ifinsmod'(patch4, I will move this to that patch),
> > to echo 'driver version' to FW. FW reply different command for different driver.
> 
> There only is one driver. This driver.
> 
> This all sounds backwards around. Normally the driver asks the
> firmware what version it is. From that, it knows what operations the
> firmware supports, and hence what it can offer to user space.
> 
> So what is your long terms plan? How do you keep backwards
> compatibility between the driver and the firmware?
> 
> 	Andrew
> 

To the driver, it is the only driver. It get the fw version and do
interactive with fw, this is ok.
But to the fw, I think it is not interactive with only 'this driver'?
Chips has been provided to various customers with different driver
version......

More specific, our FW can report link state with 2 version:
a: without pause status (to driver < 0.2.1.0)
b: with pause status (driver >= 0.2.1.0)

Then the driver update the status to reg to confirm info to fw.
fw check reg status to decide whether report state again or not.

'Driver < 0.2.1.0' only support 'version a', it will not update
pause status to reg. Then, fw will report status again, again...

So, I add 'echo driver version to fw in driver 0.2.1.0' to solve
this condition. fw consider it an old driver if driver not 'echo
version to it'.

1. Old driver with old fw, it works fine.
2. Old driver with new fw, fw knows the driver is old, it works fine with
version a.
3. New driver with new fw, fw knows the driver is new, it works fine with
version b.
4. New driver with old fw, fw echo state without pause, and it never check
it in reg, it also works fine.

And I think it is a way to make compatibility more easy. Driver know fw
version, and fw also know driver version. Fw can easy edit existing cmd,
not only add new ones since it can support old cmd for old driver,
'edited cmd' to new driver.

Also, hw->driver_version is not useful to driver. I can use a macro in
mucse_mbx_ifinsmod.

Thanks for your feedback.


