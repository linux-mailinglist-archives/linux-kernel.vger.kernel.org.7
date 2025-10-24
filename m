Return-Path: <linux-kernel+bounces-868115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF2C04678
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536B63B241D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5D2242D67;
	Fri, 24 Oct 2025 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="NJoC/nRd"
Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043277083C;
	Fri, 24 Oct 2025 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284221; cv=pass; b=ZFO2JA4BcWkuq61vpA1Bc3Yhe/o158HuQd86beTh4viCRa2JaQQW7/8ia4Plkw/WRDtyEfcF0yG7z5CIQExIYRqhbUeqGSGwWa6Co5mI35irBG3bN7i7lpA0irpaoMVwISz3DbJPkY0YkUbmChj/CuKnAFKWq1cgvzf52SLmYxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284221; c=relaxed/simple;
	bh=6q7jFBo+mpAQago+1ZKfiqs+nTvq7lT3w9JQdd/OtJY=;
	h=Message-ID:MIME-Version:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=U5wqhlOw4/vToq24rgz/vpQVPOrz+ToExiLPkT5pXFZL3jDXwuXhQg2nyKMd4wwmKLtn+pCwE8D+1fecXfkqvefANVY74EzbF7kcDzKu7G2cLdfsWmEZ8IqRlb419VIp+nkWKh0USO+yV7eGjVJVtlYTR9DUkWF4AQq+78ykFuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=NJoC/nRd; arc=pass smtp.client-ip=23.83.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9D5977011DA;
	Fri, 24 Oct 2025 05:36:52 +0000 (UTC)
Received: from fr-int-smtpout16.hostinger.io (100-120-36-240.trex-nlb.outbound.svc.cluster.local [100.120.36.240])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id B38B37013E2;
	Fri, 24 Oct 2025 05:36:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761284212; a=rsa-sha256;
	cv=none;
	b=b/WzV4gfay+Pe9swLXwg1BAeMIWgPdjKg/i/Z86jbeFKZ9ikGMiv2/A5F0I/RGoUSWbaUn
	fmrh69M9kymfHXuL+gMJqyo4K1xPNZK1ktu9BNNM8mI348HX08ZcTzJZ5Sv7Y+1NBiI+2n
	hgoSdL1y/GP90iDz26uRhvOk8oAg55TxQPCjVlcI0Q7c26N/zWZ1Sr2NqHNwWvdpCOG5C5
	dmLGDvCk4cCc+FuFuJmQsbc8EvoFVs9R/YcgrPgG1OUf5Xgj17T/od04pXhAATGEIzjA+1
	IT0TtskMwRUdPA9cVB/w2FhZvYOdsEdTGY3gPrgJqx5q2sOwWuu6UIcfGT/xTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761284212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=m+jmNyQWZBcblKYPZ3ycDCnnIPIWB9tc/exRDbXcZRo=;
	b=vDL2UXdDo9utHFjl85WxPe1uTCS19sNvdUZCH5a7ziNXa6jDiceN37dc/yCxu+ftaqKJW+
	Bt1qmfFB0O8XhHiAiuR8F67sJK3lcnNaMDoLaiz5irTxOSYeIsAlXZVZBeA0JVfnEQBvMM
	7mxaHaEFMbSJNVyLx5dziFnJO4+wj+tG08HiLu0Xy1zsGTnWBjDPJQ0GmY4bFleRplVwt/
	r0QRtDpQc2iAkSg0uFiLftNEfLykukWYaeGqiW+1Aq9W35a2MtLSawNjYUkkUwZ6Mc06Ex
	GHWcOLRWJaY5Q55HaGE3/Y/ETsuDLohO7wOr+YnYVYVw4rvuMOq3sV3vV/xAhA==
ARC-Authentication-Results: i=1;
	rspamd-9799b5d46-qbw44;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Wide-Eyed-Tangy: 4cde82cd0636ecea_1761284212448_955200319
X-MC-Loop-Signature: 1761284212448:4195139562
X-MC-Ingress-Time: 1761284212448
Received: from fr-int-smtpout16.hostinger.io (fr-int-smtpout16.hostinger.io
 [148.222.54.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.36.240 (trex/7.1.3);
	Fri, 24 Oct 2025 05:36:52 +0000
Received: from [IPV6:2001:861:4450:d360:d885:d256:90f4:37e9] (unknown [IPv6:2001:861:4450:d360:d885:d256:90f4:37e9])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4ctBV70kGsz1xqt;
	Fri, 24 Oct 2025 05:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1761284208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+jmNyQWZBcblKYPZ3ycDCnnIPIWB9tc/exRDbXcZRo=;
	b=NJoC/nRdeOXSohiI2Wm/8SE37/h+g51k2R7uUj9rzyCdlDAmCMIChCgyzFmW7bj81vcYeB
	xwSsjkXnF2rteunVYMoSpon+Nq1j/Q5Tl2m2Yvn856jfMr5SDZ06slPxF3E4uuDf04mhNK
	aQCsTbaYq5Ul6+JKDMoyUn19UoViiFzJ1Je56U+BhLH1FEiEquxQw1iup6bmS1mrRSdVsA
	zr6yE/QfPrsJCULqUMQGz1s22NUhUZKmvWVfKMiY7yZqVsRgJekkDRfX8c5Cfw2n6K4/vR
	QlcMurkM2YoN3vXt5dJSo47tl1wFc07fmU7kGW7tWmtLpD0JtJpg2hTWtHAoSw==
Message-ID: <5fbb09f4-22e6-4073-a4e5-95165d3dabbb@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Emil Renner Berthing <emil.renner.berthing@gmail.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] riscv: dts: spacemit: add Ethernet and PDMA to
 OrangePi RV2
To: Conor Dooley <conor@kernel.org>, Vivian Wang <wangruikang@iscas.ac.cn>
References: <20251022201807.1474789-1-michael.opdenacker@rootcommit.com>
 <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>
 <f8a55f89-2612-49e3-88c6-acb523ac74d3@iscas.ac.cn>
 <20251023-lizard-sharpie-70f2a000327f@spud>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <20251023-lizard-sharpie-70f2a000327f@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 24 Oct 2025 05:36:47 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Lflu6Sfi c=1 sm=1 tr=0 ts=68fb1070 a=ionIEas4mvD8rQvtymOzTQ==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=pGLkceISAAAA:8 a=7mOBRU54AAAA:8 a=5cO6JjuxQmC9w7LMcdkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22 a=wa9RWnbW_A1YIeRBVszw:22
X-CM-Envelope: MS4xfNe+tets3r1BS4pYBmVh6c0twctKSh2zgiakf4nsiN6CqS9OYk6XR0kKjCma2OVyrySVoBx/PLD2Rr+z9wy9LG+U+Bm8+ETzOGcqvzAImfWJ+PyLqT7J QYMBtEEVxeN67cehomKRfQw9QODJGJp3D8FBM83Y58hmW5MhzN8wG2SgKSofzMhdBS19xEuWllYF2JtNOKAb/Wld1v4brM5nV3KQpPpwXKWz6xv3WlyGdjOY mK4SU/Ba+P7PLWvJ/r2UgGRiB2UIuJn9H10QqevjxXGHA7MtpcEVq1kzjNHIKWjZOQs6R3U9Gs856AVcmLjkcLiuhsy1JyTbsOBJ+Ks0fKZJ0TGtt+ra+/RQ iLEQlPc7mSeOKqPnx2kGx7E8fWnt2vNasRt1VcbY4GLURtXMLLNOZnf3XSWGBTegwCBRoldMJl94zsAW9FCz0gPcuPDMcQ352rPu9hGrtEq833sEzOdvf+Qo D6UtkG9fcFiXfMQ6/gEyMbbm9Ve4WQaKTRRJObQE1kieXtVtz5JUbP6kpBrSFGu0uNHpliotLQTwtJ9QI4Ew8Bnv+uNdSv853SSudd2vTsncMbh0BrkHwvqH W2YbH6Nd4cXwkp4M6Es3wKiZAb3DR+xyhZmCzwCO2Cp+pp6fep5xLQ6Ox0/cN37NEOp5skb8HtZxrkUEqnlKIK9XsD2DseUUuloB3xtme69mL6vvE19CIWGG k0iqYRHjCglexxSxaEFIby4Ze9IkZS8Uy4lRJ4xdhu8B1EgZFGFVg4rqX6hEyNC0LTmmjSzt7AGqfn7VQbZ+SMMW8BILNlgjKWYTfewMVQ0CCajSI7SnFw==
X-AuthUser: michael.opdenacker@rootcommit.com

Hi Conor

Thanks for the review!

On 10/23/25 20:30, Conor Dooley wrote:
> On Thu, Oct 23, 2025 at 01:58:22PM +0800, Vivian Wang wrote:
>> Thank you so much for the patch and testing results. Only some nitpicks
>> follow.
>>
>> On 10/23/25 04:18, michael.opdenacker@rootcommit.com wrote:
>>> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>>>
>>> The OrangePi RV2 board ships two RGMII ethernet ports.
>>> Each has an external Motorcomm YT8531C PHY attached, the PHY uses GPIO
>>> for reset pin control.
>>>
>>> Enable PDMA for the SpacemiT K1-based SoC in the OrangePi RV2 board.
>>>
>>> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>>> CC: Emil Renner Berthing <emil.renner.berthing@gmail.com>
>>> CC: Yixun Lan <dlan@gentoo.org>
>>> CC: Vivian Wang <wangruikang@iscas.ac.cn>
>> Firstly, it is usually spelt "Cc:", with one upper-case C and one
>> lower-case c.
> I don't think this matters at all, the git tooling at least doesn't
> care.
>
>> Secondly, "Cc:" should not be necessary in the patch/commit message.
>>  From Documentation/process/submitting-patches.rst:
>>
>>      If a person has had the opportunity to comment on a patch, but has not
>>      provided such comments, you may optionally add a ``Cc:`` tag to the patch.
>>      This tag documents that potentially interested parties have been included in
>>      the discussion.
>>
>> If you look through the git logs of Linux, Cc tags are really not a
>> regular occurrence except those marking patches as suitable for
>> backporting to stable.
> If people want to handle CC lists by putting it in the patches (it's
> what I do when I have no cover letter) just put them after the --- line
> and git send-email will still pick the CCs up but they won't end up in
> the history.

Oh yes, that was my mistake. The CCs were never intended to make it to 
the final commits.
Thanks!
Michael.

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


