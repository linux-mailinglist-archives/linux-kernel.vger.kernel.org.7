Return-Path: <linux-kernel+bounces-850502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6BBD2FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E27524F1656
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479B2ED16C;
	Mon, 13 Oct 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euqYofQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DB2ECD1D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358815; cv=none; b=Gk7vTVR4QUWhVo6cVv/N9SBebDM6s889ne+GtR1OD+DhC6czoXeixNZwza538BE0mDcnbGF6BZkBzfr1jESKs5oT40spi22kjwQ7nPUVANr/OBIhE0J4ko9AmjXhwW6LIHzuxSNxzaBvM9GWXyXLHkdho7+WsauvuCJ3dLDbRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358815; c=relaxed/simple;
	bh=UXyddBs4ytxDPJbE9peuebwTcmJSnUGRs2cRI9jQQiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfxEMdp6x46JZvEDhtP05S356F4vooPChX4OJZBMZzBxt8JHgt9k8zMDWvpls6Bp2eQzcunOTqkhUEke9kcyxxtAqIRQ+k/rYjabchZsMbVGSBE1xnHRklCoseg9WMWQP9Dq69CAqbLjaHmU1csNh9PXqsY6pnSTf4mkBFfzDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euqYofQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141DBC4CEE7;
	Mon, 13 Oct 2025 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760358814;
	bh=UXyddBs4ytxDPJbE9peuebwTcmJSnUGRs2cRI9jQQiw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=euqYofQSQ8B/uO9l8Eajy/2U3c4IthNFcQBsn/7SQWltmfQrS+4FQw9AgnyoZxfQp
	 ivrfRVfSatB9BPvZkUfOAVv1qflnixV/LL0R2/PQsi4i+FNm5zYShn9hm0gaf5U3YQ
	 wh8fO4KxrYL78icgE3pxZecLjeY+G78jXgB0tmh8Itu2p3FNvV32b3tsYAPboYDsrF
	 /53s91/0ltf9SYbElwpx3mtd+qYpjHDwvNvdEjHlNdAfFx0nZXWpdSHcRN2Um4JU+F
	 JrFlx4Pv9jqnhfgnMWjxe5e4kRjqMG1jF+5/VLMsEtpqF+cmGjblyuAGP9CYK/M+NB
	 WMF7fBr7a4glg==
Message-ID: <a0bf7228-6ae3-4ef7-a72f-dbcbf5007398@kernel.org>
Date: Mon, 13 Oct 2025 13:33:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: layouts: fix nvmem_layout_bus_uevent
To: Wentao Guan <guanwentao@uniontech.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: "miquel.raynal" <miquel.raynal@bootlin.com>, mwalle <mwalle@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?5Y2g5L+K?=
 <zhanjun@uniontech.com>, =?UTF-8?B?6IGC6K+a?= <niecheng1@uniontech.com>,
 WangYuli <wangyl5933@chinaunicom.cn>
References: <20251013115910.702784-1-guanwentao@uniontech.com>
 <f9274080-9a2f-4e10-ad5f-fa84d7615c15@kernel.org>
 <tencent_65227CF727A9DD23421005DB@qq.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <tencent_65227CF727A9DD23421005DB@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/25 1:31 PM, Wentao Guan wrote:
> Hi,
> 
> Thanks for your reply.
> How to add the CC stable now?
> Send v2 or add email CC or ...?

v2 please
--srini
> 
> BRs
> Wentao Guan


