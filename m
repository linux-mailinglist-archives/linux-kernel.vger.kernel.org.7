Return-Path: <linux-kernel+bounces-878414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE34C20868
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F00ED34EA85
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D21324337B;
	Thu, 30 Oct 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Xbtalnor"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E8126C17;
	Thu, 30 Oct 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833693; cv=none; b=J/mQEzeohxlXvvvr7ghSNlLuf4fEGpf3+amqCpqSMzNSQvnXGuNB1AArhnkiJHtQ3i+0fPJGMWh798JdRapbg6gTIDSsyWCYm/5IEBy6LYH49MDZYRJLtiCYWlsc8ZPyjDwEH8MQ73Tk37odIySojX1hcswoZVDVavDTMcM05S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833693; c=relaxed/simple;
	bh=nMZET58Y7NBUZVeZR3GyqcHOW1IKxGjW38kdD5hp3Bs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lb+LSGHY2D6kR0v1pVVRSOkeBTr3Y6Prfnt/H+dWoBc8yvRDRvZqISmN/tpWc3OhI+F+tIQ2TE7JEL0vvFRXpfsJhXgjiOVTRNk9PGoRQuDP8zQ7lWj+2xJ4dTGGgMcL3JBLL+xQ7ItWWKb68fOqMTXDOIMexYgw4ClKhQ7r9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Xbtalnor; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1hSLunIdVaWodU2Ae6w+modt4yUQMQwIFDiQ1F6doSo=;
  b=XbtalnorQy10MHy2dT2gwTC2oTrAMtq3sUedxdroKUxOMMgDQsYSUzaK
   Kp4JbmqmnxOVQZXNn3LDbFZfgM4mq+/we9fo3kPMphJLmoP3ZpFKvu59D
   E/yHg8jSZjWqNrFHLd3xsJQlDioh1y/LZ9droHbyA1Tw10eAjRRYaH362
   8=;
X-CSE-ConnectionGUID: XwEYnejbS3GPWiGBT7GnRg==
X-CSE-MsgGUID: 8kwN92JYRf2mG1xE2KFMzA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246872493"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 15:14:49 +0100
Date: Thu, 30 Oct 2025 15:14:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
In-Reply-To: <d67f27c1-973d-470f-8903-7e5aaf93777a@web.de>
Message-ID: <2ce668b8-7042-ceab-1ac2-4afd86b6c6a@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <d67f27c1-973d-470f-8903-7e5aaf93777a@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 30 Oct 2025, Markus Elfring wrote:

> > If you have a concern, you have to say what it is.  It doesn't seem it is
> > about the running time, so why do you include that information?
>
> How will the chances evolve to integrate another coccicheck script for
> the discussed source code transformation approach?

No chance, given Dan's negative feedback.

julia

