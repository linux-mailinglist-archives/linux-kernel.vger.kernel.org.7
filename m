Return-Path: <linux-kernel+bounces-864788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEEFBFB8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC1C4841A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBEB322C77;
	Wed, 22 Oct 2025 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YciUx0qr"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DC30B521;
	Wed, 22 Oct 2025 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131297; cv=none; b=qqhh4HMf0kfhUy94iHDfhmEc/e3LgR3BwNJ7WF7dHMJbwcHTcwIfj+H8CrNroVSW0Cm1FgHqWlujWDA3O15lTHqTjKI/2nTY/d0VOH54vXCTPp8E3/mHYCaaUONEvMHKTgC/F30/9DRG5mSc9xDAGPzF6H+MKmE6YaN5uDGkWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131297; c=relaxed/simple;
	bh=dryTu160NAioyrV82eYEOGrU55Cf+S0NldTsVQdl8o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmqdgM8bAMn1D6OdElbnPCCpqB+t9bvkHmlZ9gExj3Cf8vhK48h1UpgYZKJ9bQZDZPS5uVxvhae4DpaKs1CwF/WlQsqKsrB0Ei6F9o6cy+ab8DsSDOAg0ncGd/4ZeBW1mpsUzgmsLdnGDNn2+VXTIjvs9eD0HymM/QvlhafnzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YciUx0qr; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d46abe01-2f1d-42ec-ab93-a0be3d431c09@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761131282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPm89C7FqdTmhO30I0w2UGstjkIjIA23l5k97iIU32g=;
	b=YciUx0qr6pTDbtWnMnWnpq4rFmRLdYv+bEXebdHsNSV47k7JpnR9nki2gS1/DLEs3v5si8
	yQ/Pw8Hi61jduYpIkz+Fz1vR7RGGo0WQyY1/cUngBmpFBCTzSsex5EBejXHngmotjT6qww
	azNl9WfT8q/S4Ng9croSmpMQJbxuA4w=
Date: Wed, 22 Oct 2025 12:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v15 4/5] net: rnpgbe: Add basic mbx_fw support
To: Dong Yibo <dong100@mucse.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, danishanwar@ti.com, geert+renesas@glider.be,
 mpe@ellerman.id.au, lorenzo@kernel.org, lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251022081351.99446-1-dong100@mucse.com>
 <20251022081351.99446-5-dong100@mucse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251022081351.99446-5-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/10/2025 09:13, Dong Yibo wrote:
> Add fundamental firmware (FW) communication operations via PF-FW
> mailbox, including:
> - FW sync (via HW info query with retries)
> - HW reset (post FW command to reset hardware)
> - MAC address retrieval (request FW for port-specific MAC)
> - Power management (powerup/powerdown notification to FW)
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |   4 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |   1 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 194 ++++++++++++++++++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  88 ++++++++
>   5 files changed, 289 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h

[...]

> +static int mucse_mbx_get_info(struct mucse_hw *hw)
> +{
> +	struct mbx_fw_cmd_req req = {
> +		.datalen = cpu_to_le16(MUCSE_MBX_REQ_HDR_LEN),
> +		.opcode  = cpu_to_le16(GET_HW_INFO),
> +	};
> +	struct mbx_fw_cmd_reply reply = {};
> +	struct mucse_hw_info info = {};
> +	int err;
> +
> +	err = mucse_fw_send_cmd_wait_resp(hw, &req, &reply);
> +	if (!err) {
> +		memcpy(&info, &reply.hw_info, sizeof(struct mucse_hw_info));
> +		hw->pfvfnum = FIELD_GET(GENMASK_U16(7, 0),
> +					le16_to_cpu(info.pfnum));

why do you need local struct mucse_hw_info info? The reply is stack
allocated, nothing else will use it afterwards. You clear out
info on allocation (40 bytes memset), then you copy whole structure from
reply to info (another round of 40 bytes reads/writes) and then use only
2 bytes out of it - it does look like an overkill, you can access
reply.hwinfo.pfnum directly.



