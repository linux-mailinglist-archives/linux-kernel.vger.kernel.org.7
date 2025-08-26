Return-Path: <linux-kernel+bounces-787068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A639B370F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A718E40CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3607E2D73A2;
	Tue, 26 Aug 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VhKLsoxy"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046D19B5B1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228011; cv=none; b=jB1rWVwLrv1/4VaaWkCUVEZbpWepezEJYJ0/5bQNGBKeFtNJFE4aqgMtxgZsPJtb3ek6KwK6Hk3QtWlXl6l5TOcLod3UhqF6iSHD+7iE7w4oFTJrBdGAliUMD31dE79Lk+hoYani15PAZMYKbbUg6OK55nyjfdfSh0+9cZFeyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228011; c=relaxed/simple;
	bh=GvSTxOPtUE53lmjPHKq/RKUZcYoiENdRBWDD5/B3goo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzPU7RbVZtX9qU04P+p85J1ggQqKFNeA0VSZKO3QDojkme4oXIN0Bkq6RLXRwh2eOtvMj8xc9XJKdJLk7AN49DqZt2BWAE4Gh7wNanKalkThZAdhmcZH3e7bdNzJ67GL6+wU0lVXNoRTCb8oFKK2WKF30LvkL/IrSVnfiHrTHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VhKLsoxy; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53206f29-7da8-4145-aef0-7bdacef3bb55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756228006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUSGVh5t0eKmU5xZTYGVizH4JYXHlSf3+YcRJVZFWyI=;
	b=VhKLsoxyO8361/XLlLzAej6W3Csm1Jsf54qsyRxP8Ju0DojLEXeTAMTX/H20GOI2/EEpQV
	lFSY3Q/DG2Ja+WT2121VswyveUsnt561XxnfRBl4aJ0iKwijXqVYw2gcvawgr5Aitlwb+U
	HQ4mYATwAL22bGt/+Il5Hd0X6+HtNAc=
Date: Tue, 26 Aug 2025 18:06:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v01 10/12] hinic3: Add Rss function
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
 <13ffd1d836eb7aa6563ad93bf5fa5196afdf0053.1756195078.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <13ffd1d836eb7aa6563ad93bf5fa5196afdf0053.1756195078.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/08/2025 10:05, Fan Gong wrote:
> Initialize rss functions. Configure rss hash data and HW resources.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
>   .../net/ethernet/huawei/hinic3/hinic3_main.c  |   9 +-
>   .../huawei/hinic3/hinic3_mgmt_interface.h     |  55 +++
>   .../huawei/hinic3/hinic3_netdev_ops.c         |  18 +
>   .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   5 +
>   .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 359 ++++++++++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  14 +
>   7 files changed, 460 insertions(+), 1 deletion(-)
[...]

> +static int alloc_rss_resource(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	static const u8 default_rss_key[L2NIC_RSS_KEY_SIZE] = {
> +		0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
> +		0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
> +		0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
> +		0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
> +		0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa};
> +
> +	nic_dev->rss_hkey = kzalloc(L2NIC_RSS_KEY_SIZE, GFP_KERNEL);

no need to request zero'ed allocation if you are going to overwrite it
completely on the very next line.

> +	if (!nic_dev->rss_hkey)
> +		return -ENOMEM;
> +
> +	memcpy(nic_dev->rss_hkey, default_rss_key, L2NIC_RSS_KEY_SIZE);

I would better move this line after both allocations when the code flow
has no way to fail.

> +	nic_dev->rss_indir = kcalloc(L2NIC_RSS_INDIR_SIZE, sizeof(u32),
> +				     GFP_KERNEL);

why do you allocate L2NIC_RSS_INDIR_SIZE of u32 when the HW table has
le16 type for the entry?

> +	if (!nic_dev->rss_indir) {
> +		kfree(nic_dev->rss_hkey);
> +		nic_dev->rss_hkey = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev,
> +				    const u32 *indir_table)
> +{
> +	struct l2nic_cmd_rss_set_indir_tbl *indir_tbl;
> +	struct hinic3_cmd_buf *cmd_buf;
> +	__le64 out_param;
> +	int err;
> +	u32 i;
> +
> +	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
> +	if (!cmd_buf) {
> +		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
> +		return -ENOMEM;
> +	}
> +
> +	cmd_buf->size = cpu_to_le16(sizeof(struct l2nic_cmd_rss_set_indir_tbl));
> +	indir_tbl = cmd_buf->buf;
> +	memset(indir_tbl, 0, sizeof(*indir_tbl));
> +
> +	for (i = 0; i < L2NIC_RSS_INDIR_SIZE; i++)
> +		indir_tbl->entry[i] = cpu_to_le16((u16)indir_table[i]);
> +
> +	hinic3_cmdq_buf_swab32(indir_tbl, sizeof(*indir_tbl));
> +
> +	err = hinic3_cmdq_direct_resp(hwdev, MGMT_MOD_L2NIC,
> +				      L2NIC_UCODE_CMD_SET_RSS_INDIR_TBL,
> +				      cmd_buf, &out_param);
> +	if (err || out_param != 0) {

no need for "!= 0"

> +		dev_err(hwdev->dev, "Failed to set rss indir table\n");
> +		err = -EFAULT;
> +	}
> +
> +	hinic3_free_cmd_buf(hwdev, cmd_buf);
> +
> +	return err;
> +}

[...]

> +static int hinic3_rss_cfg_hash_key(struct hinic3_hwdev *hwdev, u8 opcode,
> +				   u8 *key)
> +{
> +	struct l2nic_cmd_cfg_rss_hash_key hash_key = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	hash_key.func_id = hinic3_global_func_id(hwdev);
> +	hash_key.opcode = opcode;
> +
> +	if (opcode == MGMT_MSG_CMD_OP_SET)
> +		memcpy(hash_key.key, key, L2NIC_RSS_KEY_SIZE);

here you copy hash key to a stack allocated structure ...

> +
> +	mgmt_msg_params_init_default(&msg_params, &hash_key, sizeof(hash_key));


... which is copied to another stack allocated structure ...

> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
> +				       L2NIC_CMD_CFG_RSS_HASH_KEY, &msg_params);
> +	if (err || hash_key.msg_head.status) {
> +		dev_err(hwdev->dev, "Failed to %s hash key, err: %d, status: 0x%x\n",
> +			opcode == MGMT_MSG_CMD_OP_SET ? "set" : "get",
> +			err, hash_key.msg_head.status);
> +		return -EINVAL;
> +	}
> +
> +	if (opcode == MGMT_MSG_CMD_OP_GET)
> +		memcpy(key, hash_key.key, L2NIC_RSS_KEY_SIZE);
> +
> +	return 0;
> +}
> +
> +static int hinic3_rss_set_hash_key(struct hinic3_hwdev *hwdev, const u8 *key)
> +{
> +	u8 hash_key[L2NIC_RSS_KEY_SIZE];
> +
> +	memcpy(hash_key, key, L2NIC_RSS_KEY_SIZE);

... but it was already copied to stack allocated buffer ...

> +
> +	return hinic3_rss_cfg_hash_key(hwdev, MGMT_MSG_CMD_OP_SET, hash_key);
> +}
> +
> +static int hinic3_set_hw_rss_parameters(struct net_device *netdev, u8 rss_en)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	int err;
> +
> +	err = hinic3_rss_set_hash_key(nic_dev->hwdev, nic_dev->rss_hkey);

... which is previously copied from static array.

It's 4 copies in total to configure one simple thing. Looks like too
much of copying with no good reason


> +	if (err)
> +		return err;
> +

