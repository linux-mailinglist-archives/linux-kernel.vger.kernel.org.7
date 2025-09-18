Return-Path: <linux-kernel+bounces-795954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E40B3F9EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E129916E038
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15252E8E03;
	Tue,  2 Sep 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ymtWKZn3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YCTmYPO4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ymtWKZn3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YCTmYPO4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10A1E9B3A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804425; cv=none; b=Dy6mwiPqBqZhqIngKIKF81vhNtuGctjqcsBDgp91ewd50h1VPN2IPzk8R5irFUzCJ8KT3IKH3bAkeXT0nWFvuGXdItyvqvMC64Ed2JoZh/YoLJTPjnVltWD0KANHIRO839Y+oA17hCogzJt4XpcovZ01UP0k/vjaS7LGCbmo1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804425; c=relaxed/simple;
	bh=pQGnD6sPLTsnH3A3ESZ7rW65m+NIWjewekPCPjkqpVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMi4KoAFCM27LawUlS8JkLXTaRqI48RX5uiWPMntRYRFQrOLDwddi4AtzEaDZNh0CakSqw2dcf46EC5KfGekB6SsoUgJfvvEbX9IfQrLq4J2ipElJ0hbtd3V3rQ8wZmqgxSu+vAF+wcYhygGQJ5RehOUHSJPl+ai0WlppZWE2tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ymtWKZn3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YCTmYPO4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ymtWKZn3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YCTmYPO4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26FBE1F445;
	Tue,  2 Sep 2025 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756804422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIAga8ZShmWldE7XrRblo4OOShtrRq/y6rIQOpy+PpU=;
	b=ymtWKZn3kQGkHYbWQwWPGukL4b7CmkL+X124CfrM1unK4I2jqHVKzIhA3kJErr630l2PaJ
	AtNuuKGhZ8V6fi/JWGBwKoE7rvIHl/HGgmTF/9Jv0NRxP1sPYNvPzroxWYG4B6HXMiPeqj
	JNRwrZ37TT+GAaSkNM3RcrYP9Yv4IPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756804422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIAga8ZShmWldE7XrRblo4OOShtrRq/y6rIQOpy+PpU=;
	b=YCTmYPO4J9ky+jTHL/g2L6A5usAlHivpRkS33OuQFM5jfasnk6GXCZHxGFbfHFTeKIJGkT
	E/rPq5HpItptvyDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756804422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIAga8ZShmWldE7XrRblo4OOShtrRq/y6rIQOpy+PpU=;
	b=ymtWKZn3kQGkHYbWQwWPGukL4b7CmkL+X124CfrM1unK4I2jqHVKzIhA3kJErr630l2PaJ
	AtNuuKGhZ8V6fi/JWGBwKoE7rvIHl/HGgmTF/9Jv0NRxP1sPYNvPzroxWYG4B6HXMiPeqj
	JNRwrZ37TT+GAaSkNM3RcrYP9Yv4IPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756804422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIAga8ZShmWldE7XrRblo4OOShtrRq/y6rIQOpy+PpU=;
	b=YCTmYPO4J9ky+jTHL/g2L6A5usAlHivpRkS33OuQFM5jfasnk6GXCZHxGFbfHFTeKIJGkT
	E/rPq5HpItptvyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0966913888;
	Tue,  2 Sep 2025 09:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KFB1AUa1tmimBwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 09:13:42 +0000
Message-ID: <e34b522c-a492-4d86-9fbd-1a667e26d884@suse.de>
Date: Tue, 2 Sep 2025 11:13:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] nvme-fc: wait for initial connect attempt to
 finish
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
 <20250829-nvme-fc-sync-v3-4-d69c87e63aee@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250829-nvme-fc-sync-v3-4-d69c87e63aee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/29/25 17:37, Daniel Wagner wrote:
> The TCP and RDMA transport are doing synchronous connects. Thus the
> write to /dev/nvme-fabrics blocks and will return either success or
> fail. The FC transport offloads the connect attempt to a workqueue and
> thus it's an asynchronous operation. The write will succeeds even though
> the connection attempt is ongoing.
> 
> This async connect feature was introduced to mitigate problems with
> transient connect errors and the task to coordinate retries with
> userspace (nvme-cli).
> 
> Unfortunately, this makes the transports behave differently. Streamline
> nvme-fc to wait for the initial connection attempt.
> 
> In order to support also the async connection attempt introduce a new
> flag for userspace, which is an opt-in feature. This avoids breaking
> existing users which are not ready for the FC transport behavior change.
> 
> Link: https://lore.kernel.org/linux-nvme/0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com/
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fabrics.c | 18 +++++++++++++++++-
>   drivers/nvme/host/fabrics.h |  3 +++
>   drivers/nvme/host/fc.c      | 36 +++++++++++++++++++++++++++++++++++-
>   3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index cb9311c399856de54a2e4d41d41d295dd1aef31e..73e7a1e7925ef2e8ad633e8e2bd36207181dcbb6 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -709,6 +709,7 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_TLS,			"tls"			},
>   	{ NVMF_OPT_CONCAT,		"concat"		},
>   #endif
> +	{ NVMF_OPT_CONNECT_ASYNC,	"connect_async=%d"	},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -738,6 +739,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	opts->tls_key = NULL;
>   	opts->keyring = NULL;
>   	opts->concat = false;
> +	/* keep backward compatibility with older nvme-cli */
> +	opts->connect_async = true;
>   
>   	options = o = kstrdup(buf, GFP_KERNEL);
>   	if (!options)
> @@ -1064,6 +1067,19 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->concat = true;
>   			break;
> +		case NVMF_OPT_CONNECT_ASYNC:
> +			if (match_int(args, &token)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (token < 0 || token > 1) {
> +				pr_err("Invalid connect_async %d value\n",
> +				       token);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			opts->connect_async = token;
> +			break;
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> @@ -1316,7 +1332,7 @@ EXPORT_SYMBOL_GPL(nvmf_ctrl_options_put);
>   				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
>   				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
>   				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
> -				 NVMF_OPT_DHCHAP_CTRL_SECRET)
> +				 NVMF_OPT_DHCHAP_CTRL_SECRET | NVMF_OPT_CONNECT_ASYNC)
>   
>   static struct nvme_ctrl *
>   nvmf_create_ctrl(struct device *dev, const char *buf)
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index bcc1d5f97ee5a03852830bf3ba0a15f82c7c2c03..9015bb3f63e1d0c412cf4af5194a42411fbb516c 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -67,6 +67,7 @@ enum {
>   	NVMF_OPT_KEYRING	= 1 << 26,
>   	NVMF_OPT_TLS_KEY	= 1 << 27,
>   	NVMF_OPT_CONCAT		= 1 << 28,
> +	NVMF_OPT_CONNECT_ASYNC	= 1 << 29,
>   };
>   
>   /**
> @@ -111,6 +112,7 @@ enum {
>    * @nr_poll_queues: number of queues for polling I/O
>    * @tos: type of service
>    * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
> + * @connect_async: Don't wait for the initial connect attempt to succeed or fail
>    */
>   struct nvmf_ctrl_options {
>   	struct kref		ref;
> @@ -142,6 +144,7 @@ struct nvmf_ctrl_options {
>   	unsigned int		nr_poll_queues;
>   	int			tos;
>   	int			fast_io_fail_tmo;
> +	bool			connect_async;
>   };
>   
>   int nvmf_ctrl_options_get(struct nvmf_ctrl_options *opts);
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 5d9e193bd2525ae1a2f08e2a0a16ca41e08a7304..ccd67acb55e216602010933914afca77248b3de0 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -148,6 +148,7 @@ struct nvme_fc_rport {
>   #define ASSOC_ACTIVE		0
>   #define ASSOC_FAILED		1
>   #define FCCTRL_TERMIO		2
> +#define INITIAL_SYNC_CONNECT	3
>   
>   struct nvme_fc_ctrl {
>   	spinlock_t		lock;
> @@ -168,6 +169,7 @@ struct nvme_fc_ctrl {
>   
>   	struct work_struct	ioerr_work;
>   	struct delayed_work	connect_work;
> +	struct completion	connect_completion;
>   
>   	struct kref		ref;
>   	unsigned long		flags;
> @@ -829,6 +831,7 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
>   			dev_warn(ctrl->ctrl.device,
>   				"NVME-FC{%d}: controller connectivity lost.\n",
>   				ctrl->cnum);
> +			complete(&ctrl->connect_completion);
>   			nvme_fc_ctrl_put(ctrl);
>   		} else
>   			nvme_fc_ctrl_connectivity_loss(ctrl);
> @@ -3253,6 +3256,9 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>   	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_CONNECTING)
>   		return;
>   
> +	if (test_bit(INITIAL_SYNC_CONNECT, &ctrl->flags))
> +		goto delete;
> +
>   	if (portptr->port_state == FC_OBJSTATE_ONLINE) {
>   		dev_info(ctrl->ctrl.device,
>   			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
> @@ -3294,6 +3300,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>   					   (ctrl->ctrl.opts->max_reconnects *
>   					    ctrl->ctrl.opts->reconnect_delay)));
>   
> +delete:
> +	complete(&ctrl->connect_completion);
>   	nvme_fc_ctrl_put(ctrl);
>   }
>   
> @@ -3353,10 +3361,14 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
>   	ret = nvme_fc_create_association(ctrl);
>   	if (ret)
>   		nvme_fc_reconnect_or_delete(ctrl, ret);
> -	else
> +	else {
>   		dev_info(ctrl->ctrl.device,
>   			"NVME-FC{%d}: controller connect complete\n",
>   			ctrl->cnum);
> +		pr_info("%s:%d clear initial sync connect bit\n", __func__, __LINE__);
> +		clear_bit(INITIAL_SYNC_CONNECT, &ctrl->flags);
> +		complete(&ctrl->connect_completion);
> +	}
>   }
>   
>   
> @@ -3461,6 +3473,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
>   	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
> +	init_completion(&ctrl->connect_completion);
>   	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
>   	spin_lock_init(&ctrl->lock);
>   
> @@ -3539,6 +3552,12 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
>   	spin_unlock_irqrestore(&rport->lock, flags);
>   
> +	if (!opts->connect_async) {
> +		pr_info("%s:%d set initial connect bit\n", __func__, __LINE__);
> +		set_bit(INITIAL_SYNC_CONNECT, &ctrl->flags);
> +		nvme_fc_ctrl_get(ctrl);
> +	}
> +
>   	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
>   		dev_err(ctrl->ctrl.device,
>   			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
> @@ -3554,6 +3573,20 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   	flush_delayed_work(&ctrl->connect_work);
>   
> +	if (!opts->connect_async) {
> +		enum nvme_ctrl_state state;
> +
> +		wait_for_completion(&ctrl->connect_completion);
> +		state = nvme_ctrl_state(&ctrl->ctrl);
> +		nvme_fc_ctrl_put(ctrl);
> +
> +		if (state != NVME_CTRL_LIVE) {
> +			/* Cleanup is handled by the connect state machine */
> +			pr_info("%s:%d ctrl state %d\n", __func__, __LINE__, state);
> +			return ERR_PTR(-EIO);

We really should return the correct status (and not just -EIO).
Guess we'll need to introduce another variable in struct nvme_fc_ctrl
to hold the connect status...

> +		}
> +	}
> +
>   	dev_info(ctrl->ctrl.device,
>   		"NVME-FC{%d}: new ctrl: NQN \"%s\", hostnqn: %s\n",
>   		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl), opts->host->nqn);
> @@ -3895,6 +3928,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
>   		dev_warn(ctrl->ctrl.device,
>   			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
>   			ctrl->cnum);
> +		complete(&ctrl->connect_completion);
>   		nvme_fc_ctrl_put(ctrl);
>   	}
>   	spin_unlock(&rport->lock);
> 

And I wonder: what about the udev rules?
Do they need to be modified?
(IE: should we call udev with --connect-async or without?)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

