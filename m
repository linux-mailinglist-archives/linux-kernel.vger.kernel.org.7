Return-Path: <linux-kernel+bounces-766666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3DCB249BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF4E882F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92752E2657;
	Wed, 13 Aug 2025 12:44:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB226CE3C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089080; cv=none; b=nO6bOpMXSSDHWZTbb4E8HTLkhy8FmBg6m9rBgc/lMVeI7Zfv6L0VsDIK0vHRES1eG4C05jF9mjqBlQw5Zb/Gv8aIHgrYf6AuWfx1t+6rEpJTg4ZaDeiJZlQOierX9oNl+IIQwroEUA6yAx/8rnDQVH5eV6Qqf8AW184a4iH3s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089080; c=relaxed/simple;
	bh=jR6dXCBHCycpp6tXXaFEalzyWUvL8750GHQGErf0GcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVm82keiwPyfl4s1A5ST3GRq5K9Rs40bshpdtEvYSeZxxsvDqu01pdHZaoIGu32tezZhxt0AnIWrDnvPfEoOd+GSUC/FZhg9w6M0eqDvoI8G5HVzTlprM+YROubxfJgOe3ykz0RP0NKf31+UFAOF9uWnBbhOJe0s1sMMb4PORts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1umAqC-00066E-Ae; Wed, 13 Aug 2025 14:44:28 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umAqB-0005ki-1i;
	Wed, 13 Aug 2025 14:44:27 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1umAqB-00954v-1L;
	Wed, 13 Aug 2025 14:44:27 +0200
Date: Wed, 13 Aug 2025 14:44:27 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
	Dent Project <dentproject@linuxfoundation.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool v2 3/3] ethtool: pse-pd: Add PSE event monitoring
 support
Message-ID: <aJyIqz4T1MWuI-p9@pengutronix.de>
References: <20250813-b4-feature_poe_pw_budget-v2-0-0bef6bfcc708@bootlin.com>
 <20250813-b4-feature_poe_pw_budget-v2-3-0bef6bfcc708@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250813-b4-feature_poe_pw_budget-v2-3-0bef6bfcc708@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2025 at 10:57:52AM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
.... 
> diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
> index 5bde176..3fb0616 100644
> --- a/netlink/pse-pd.c
> +++ b/netlink/pse-pd.c
> @@ -475,6 +475,64 @@ int nl_gpse(struct cmd_context *ctx)
>  	return ret;
>  }
>  
> +static const char *pse_events_name(u64 val)
> +{
> +	switch (val) {
> +	case ETHTOOL_PSE_EVENT_OVER_CURRENT:
> +		return "over-current";
> +	case ETHTOOL_PSE_EVENT_OVER_TEMP:
> +		return "over-temperature";
> +	case ETHTOOL_C33_PSE_EVENT_DETECTION:
> +		return "detection";
> +	case ETHTOOL_C33_PSE_EVENT_CLASSIFICATION:
> +		return "classification";
> +	case ETHTOOL_C33_PSE_EVENT_DISCONNECTION:
> +		return "disconnection";
> +	case ETHTOOL_PSE_EVENT_OVER_BUDGET:
> +		return "over-budget";
> +	case ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR:
> +		return "software power control error";
> +	default:
> +		return "unknown";
> +	}
> +}
> +
> +int pse_ntf_cb(const struct nlmsghdr *nlhdr, void *data)
> +{
> +	const struct nlattr *tb[ETHTOOL_A_PSE_MAX + 1] = {};

s/ETHTOOL_A_PSE_MAX/ETHTOOL_A_PSE_NTF_MAX ?

> +	struct nl_context *nlctx = data;
> +	DECLARE_ATTR_TB_INFO(tb);
> +	u64 val;
> +	int ret, i;
> +
> +	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
> +	if (ret < 0)
> +		return MNL_CB_OK;
> +
> +	if (!tb[ETHTOOL_A_PSE_NTF_EVENTS])
> +		return MNL_CB_OK;
> +
> +	nlctx->devname = get_dev_name(tb[ETHTOOL_A_PSE_HEADER]);

s/ETHTOOL_A_PSE_HEADER/ETHTOOL_A_PSE_NTF_HEADER ?

> +	if (!dev_ok(nlctx))
> +		return MNL_CB_OK;
> +
> +	open_json_object(NULL);
> +	print_string(PRINT_ANY, "ifname", "PSE event for %s:\n",
> +		     nlctx->devname);
> +	open_json_array("events", "Events:");
> +	val = attr_get_uint(tb[ETHTOOL_A_PSE_NTF_EVENTS]);

we have here uint but val is u64, is it as expected?

> +	for (i = 0; 1 << i <= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR; i++)
> +		if (val & 1 << i)
> +			print_string(PRINT_ANY, NULL, " %s",
> +				     pse_events_name(val & 1 << i));

Hm, may be it is better to not limit to ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR
and report unknow numeric value. It will keep even old ethtool at least
partially usable.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

