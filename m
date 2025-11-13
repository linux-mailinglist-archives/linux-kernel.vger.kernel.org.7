Return-Path: <linux-kernel+bounces-899833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C6C58D85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4530B3BBD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4930335292F;
	Thu, 13 Nov 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN24s2zn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793F2FA0DF;
	Thu, 13 Nov 2025 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051501; cv=none; b=J2re6KXr2X34U20iWI2PXngG1tiOQmX1LV1X/Pmeky7GtT6hekwWumT44q2RKhP36Tp1aBJYKqdxOEZK6AhfiRWZYITr+3ydlaL/D0xTzfr00LWSQE2LW/qjFMa7o9rG/7Z3wpai1haNzbdaQyYdU8Yxv9wGPDxzYMjd2QPgXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051501; c=relaxed/simple;
	bh=kF+kWxPyVh+z5FgM0Q2Did65oYs/q684yfo71ZgaTCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thNklratBun+CGAWHDcdma8dMB6v+XVPqYjaoqJhoO0m/OYaHp1nNV/IbpDWxXEOp1c5KFqQKQMfMnmOdCwviYy5WwZxMLuqf522LquidzARchXr6CQ317fTfXcyVrpx+F/G8k8FQ8HM4l6A8aDEoq539u0F3fgQd4O2wnxCznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN24s2zn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0B2C4CEF7;
	Thu, 13 Nov 2025 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051501;
	bh=kF+kWxPyVh+z5FgM0Q2Did65oYs/q684yfo71ZgaTCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JN24s2znNS9vkkaUXTdz1pdutkLld2c5PDgdWXBdkz2Sq7e0VfZMaGPaKYRr6g9En
	 8BwUWrJ+dgCAngShttKvv0IfksPk3gEcUk2w9LHgz68KiHXhkKtQTitBdJWhoRMOJa
	 je8OIXGsKp2GgcN/cNlB9qPqt2cs64AVkAd/LMydq41j0Mkjs7qI+GNBh/yMRJgdqg
	 ZrYPAGRNOsSDSvZOF+BO7v4WFUtdCK67Z53aQDtIpV6yyEVIr/LzeEcZUVapieylXM
	 KFGENpjL0KYOOdn9OOa4+Bv5/zbglcL75Dsd97o3pVw81bC/Uuj29t0mI0XrGoWds3
	 7vWSg/gQhbpEw==
Date: Thu, 13 Nov 2025 06:31:40 -1000
From: Tejun Heo <tj@kernel.org>
To: ying chen <yc1082463@gmail.com>
Cc: corbet@lwn.net, jiangshanlai@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Subject: Re: [PATCH] workqueue: add workqueue.mayday_initial_timeout
Message-ID: <aRYH7NwIEdC2kM8Q@slm.duckdns.org>
References: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
 <aROfRBGmglPgcPVf@slm.duckdns.org>
 <CAN2Y7hwUmdFMM=mwYq7gsBpbSEBq6n0nXzmES4_=p3fDV=S+Ag@mail.gmail.com>
 <aRSvxyoWiqzcBj-N@slm.duckdns.org>
 <CAN2Y7hzDZxt5tBPeqwKwNNwwGXgmhj_uYDMkxx5_QtoqV97v1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN2Y7hzDZxt5tBPeqwKwNNwwGXgmhj_uYDMkxx5_QtoqV97v1A@mail.gmail.com>

Hello,

On Thu, Nov 13, 2025 at 10:34:43AM +0800, ying chen wrote:
> Processing work items one-by-one is indeed an excellent solution.
> However, wouldn't it also be necessary to provide a method for
> adjusting the mayday initial timeout?

Adding an interface like that isn't difficult but I'm not sure what that
would achieve. A rescuer is there to guarantee forward progress when the
system is under memory pressure and processing work items of the workqueue
may be required to free up memory. IOW, when that workqueue not making
forward progress can lead to system deadlock.

As such, this doesn't have that much system performance implications (aside
from the serialization effect that you raised). If rescuer is needed, the
system is in tatters anyway, especially in terms of latency response, so I'm
not sure what fine-tuning rescuer response time would help with.

Thanks.

-- 
tejun

