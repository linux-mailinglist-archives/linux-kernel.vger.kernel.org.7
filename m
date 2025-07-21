Return-Path: <linux-kernel+bounces-738689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562FEB0BBF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71339176832
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A9320C494;
	Mon, 21 Jul 2025 05:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvdMZmx6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841E198E9B;
	Mon, 21 Jul 2025 05:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753074454; cv=none; b=je3uNxNJ/utaKVvRVpyUlgnzsn36LyTO35k86Yp4DZnBm3YxUGblxStv13QfQNMLHA5IGno28ZENr2vGipcALbc6LnT3THvGbPByB5EKR/bxPkR1Ijm1iYWbEXT2T7Uj52xeCvcErgyneU6fk0513MSpgCPf7tOUreZLSMa7gK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753074454; c=relaxed/simple;
	bh=T2eVpiWSrx4T85cAFgR218A3J+FU1mKNAmGDIvClLp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9fFP088XjUGvng9iI4kYEvT3Luxark7bKAFXaiLuocOfq85T9RBeP284SUs2K5iJ0M/wX73uxhPEMKWqtw2dKuNv9Kf4UKBgg0pklDIE2oDX4UKzyCVZxmKgFybwumvNudTGo2HuZc12Uta69A5aGQxHqHWqEFTA6c4sI29Mko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvdMZmx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29336C4CEF1;
	Mon, 21 Jul 2025 05:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753074453;
	bh=T2eVpiWSrx4T85cAFgR218A3J+FU1mKNAmGDIvClLp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvdMZmx6m588/OjFLI70XxsqO1W7I6Y440+aWPcLb7kI7LyWSkOj1bqymSD+ds2UA
	 NucaJAwV6BWiDzj50EZIyS09RaZDF+0Gh1fIbL9nh2MFePWEUh6sYd4RLhk8a7ch+B
	 rC2UpwWY9KDFKEczI1kDUe6Y/DdUf1DXbs+DoK3DMSYsJcM500SvUlgL70W1gISDC2
	 kOUQzrDduCBocZZE4qLwOySRYU7uU7sak+iUd9Q7fOeimz5aGtclHXhgHfI2+4dM2I
	 lMwt2Bhq8YBPnvn8utAxYBJn3322ICJSpKAaK3nEjE5ay81xetMGI2KK/UQfeyK4bF
	 Zmp9W2WqFWPSg==
Date: Mon, 21 Jul 2025 10:37:30 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Suresh K C <suresh.k.chandrappa@gmail.com>
Cc: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	sanyog.r.kale@intel.com, shuah@kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: replace scnprintf() with sysfs_emit() for
 sysfs consistency
Message-ID: <aH3LEmB3hafb3T8E@vaman>
References: <20250712044302.6952-1-suresh.k.chandrappa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712044302.6952-1-suresh.k.chandrappa@gmail.com>

On 12-07-25, 10:13, Suresh K C wrote:
> From: Suresh K C <suresh.k.chandrappa@gmail.com>
> 
> Replace scnprintf() with sysfs_emit() or sysfs_emit_at() in SoundWire driver files
> to align with the guidelines outlined in Documentation/filesystems/sysfs.rst.
> 
> This change improves the safety and correctness of sysfs attribute handling,
> ensures consistency across the kernel codebase, and simplifies future maintenance.
> 
> Tested by enabling CONFIG_DEBUG_FS and confirming that /sys/kernel/debug/soundwire is correctly populated

There is trailing whitespace error, pls run checkpatch before
sending patches

> 
> Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
> ---
>  drivers/soundwire/cadence_master.c      | 23 +++++++++++------------
>  drivers/soundwire/debugfs.c             | 22 +++++++++++-----------
>  drivers/soundwire/intel.c               | 17 ++++++++---------
>  drivers/soundwire/intel_ace2x_debugfs.c | 14 +++++++-------
>  4 files changed, 37 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 21bb491d026b..668a111c66c8 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -319,8 +319,7 @@ EXPORT_SYMBOL(sdw_cdns_config_update_set_wait);
>  static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
>  			    char *buf, size_t pos, unsigned int reg)
>  {
> -	return scnprintf(buf + pos, RD_BUF - pos,
> -			 "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
> +	return sysfs_emit_at(buf, pos,"%4x\t%8x\n", reg, cdns_readl(cdns, reg));
>  }
>  
>  static int cdns_reg_show(struct seq_file *s, void *data)
> @@ -334,42 +333,42 @@ static int cdns_reg_show(struct seq_file *s, void *data)
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
> -	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
> +	ret = sysfs_emit(buf, "Register  Value\n");
> +	ret += sysfs_emit_at(buf, ret,"\nMCP Registers\n");
>  	/* 8 MCP registers */
>  	for (i = CDNS_MCP_CONFIG; i <= CDNS_MCP_PHYCTRL; i += sizeof(u32))
>  		ret += cdns_sprintf(cdns, buf, ret, i);
>  
> -	ret += scnprintf(buf + ret, RD_BUF - ret,
> +	ret += sysfs_emit_at(buf, ret,
>  			 "\nStatus & Intr Registers\n");
>  	/* 13 Status & Intr registers (offsets 0x70 and 0x74 not defined) */
>  	for (i = CDNS_MCP_STAT; i <=  CDNS_MCP_FIFOSTAT; i += sizeof(u32))
>  		ret += cdns_sprintf(cdns, buf, ret, i);
>  
> -	ret += scnprintf(buf + ret, RD_BUF - ret,
> +	ret += sysfs_emit_at(buf, ret,
>  			 "\nSSP & Clk ctrl Registers\n");
>  	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL0);
>  	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL1);
>  	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL0);
>  	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL1);
>  
> -	ret += scnprintf(buf + ret, RD_BUF - ret,
> +	ret += sysfs_emit_at(buf, ret,
>  			 "\nDPn B0 Registers\n");
>  
>  	num_ports = cdns->num_ports;
>  
>  	for (i = 0; i < num_ports; i++) {
> -		ret += scnprintf(buf + ret, RD_BUF - ret,
> +		ret += sysfs_emit_at(buf, ret,
>  				 "\nDP-%d\n", i);
>  		for (j = CDNS_DPN_B0_CONFIG(i);
>  		     j < CDNS_DPN_B0_ASYNC_CTRL(i); j += sizeof(u32))
>  			ret += cdns_sprintf(cdns, buf, ret, j);
>  	}
>  
> -	ret += scnprintf(buf + ret, RD_BUF - ret,
> +	ret += sysfs_emit_at(buf, ret,
>  			 "\nDPn B1 Registers\n");
>  	for (i = 0; i < num_ports; i++) {
> -		ret += scnprintf(buf + ret, RD_BUF - ret,
> +		ret += sysfs_emit_at(buf, ret,
>  				 "\nDP-%d\n", i);
>  
>  		for (j = CDNS_DPN_B1_CONFIG(i);
> @@ -377,13 +376,13 @@ static int cdns_reg_show(struct seq_file *s, void *data)
>  			ret += cdns_sprintf(cdns, buf, ret, j);
>  	}
>  
> -	ret += scnprintf(buf + ret, RD_BUF - ret,
> +	ret += sysfs_emit_at(buf, ret,
>  			 "\nDPn Control Registers\n");
>  	for (i = 0; i < num_ports; i++)
>  		ret += cdns_sprintf(cdns, buf, ret,
>  				CDNS_PORTCTRL + i * CDNS_PORT_OFFSET);
>  
> -	ret += scnprintf(buf + ret, RD_BUF - ret,
> +	ret += sysfs_emit_at(buf, ret,
>  			 "\nPDIn Config Registers\n");
>  
>  	/* number of PDI and ports is interchangeable */
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index 3099ea074f10..ccc98f449658 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -42,9 +42,9 @@ static ssize_t sdw_sprintf(struct sdw_slave *slave,
>  	value = sdw_read_no_pm(slave, reg);
>  
>  	if (value < 0)
> -		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
> +		return sysfs_emit_at(buf , pos, "%3x\tXX\n", reg);
>  	else
> -		return scnprintf(buf + pos, RD_BUF - pos,
> +		return sysfs_emit_at(buf , pos,
>  				"%3x\t%2x\n", reg, value);
>  }
>  
> @@ -64,21 +64,21 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  		return ret;
>  	}
>  
> -	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
> +	ret = sysfs_emit(buf, "Register  Value\n");
>  
>  	/* DP0 non-banked registers */
> -	ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
> +	ret += sysfs_emit_at(buf , ret, "\nDP0\n");
>  	for (i = SDW_DP0_INT; i <= SDW_DP0_PREPARECTRL; i++)
>  		ret += sdw_sprintf(slave, buf, ret, i);
>  
>  	/* DP0 Bank 0 registers */
> -	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +	ret += sysfs_emit_at(buf, ret, "Bank0\n");
>  	ret += sdw_sprintf(slave, buf, ret, SDW_DP0_CHANNELEN);
>  	for (i = SDW_DP0_SAMPLECTRL1; i <= SDW_DP0_LANECTRL; i++)
>  		ret += sdw_sprintf(slave, buf, ret, i);
>  
>  	/* DP0 Bank 1 registers */
> -	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +	ret += sysfs_emit_at(buf, ret, "Bank1\n");
>  	ret += sdw_sprintf(slave, buf, ret,
>  			SDW_DP0_CHANNELEN + SDW_BANK1_OFFSET);
>  	for (i = SDW_DP0_SAMPLECTRL1 + SDW_BANK1_OFFSET;
> @@ -86,7 +86,7 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  		ret += sdw_sprintf(slave, buf, ret, i);
>  
>  	/* SCP registers */
> -	ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
> +	ret += sysfs_emit_at(buf, ret, "\nSCP\n");
>  	for (i = SDW_SCP_INT1; i <= SDW_SCP_BUS_CLOCK_BASE; i++)
>  		ret += sdw_sprintf(slave, buf, ret, i);
>  	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
> @@ -110,18 +110,18 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  	for (i = 1; SDW_VALID_PORT_RANGE(i); i++) {
>  
>  		/* DPi registers */
> -		ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
> +		ret += sysfs_emit_at(buf , ret, "\nDP%d\n", i);
>  		for (j = SDW_DPN_INT(i); j <= SDW_DPN_PREPARECTRL(i); j++)
>  			ret += sdw_sprintf(slave, buf, ret, j);
>  
>  		/* DPi Bank0 registers */
> -		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
> +		ret += sysfs_emit_at(buf , ret, "Bank0\n");
>  		for (j = SDW_DPN_CHANNELEN_B0(i);
>  		     j <= SDW_DPN_LANECTRL_B0(i); j++)
>  			ret += sdw_sprintf(slave, buf, ret, j);
>  
>  		/* DPi Bank1 registers */
> -		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
> +		ret += sysfs_emit_at(buf , ret, "Bank1\n");
>  		for (j = SDW_DPN_CHANNELEN_B1(i);
>  		     j <= SDW_DPN_LANECTRL_B1(i); j++)
>  			ret += sdw_sprintf(slave, buf, ret, j);
> @@ -317,7 +317,7 @@ static int read_buffer_show(struct seq_file *s_file, void *data)
>  		return -EINVAL;
>  
>  	for (i = 0; i < num_bytes; i++) {
> -		scnprintf(buf, MAX_LINE_LEN, "address %#x val 0x%02x\n",
> +		sysfs_emit(buf, "address %#x val 0x%02x\n",
>  			  start_addr + i, read_buffer[i]);
>  		seq_printf(s_file, "%s", buf);
>  	}
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 9db78f3d7615..aa7aa7126c47 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -65,8 +65,7 @@ static ssize_t intel_sprintf(void __iomem *mem, bool l,
>  		value = intel_readl(mem, reg);
>  	else
>  		value = intel_readw(mem, reg);
> -
> -	return scnprintf(buf + pos, RD_BUF - pos, "%4x\t%4x\n", reg, value);
> +	return sysfs_emit_at(buf, pos, "%4x\t%4x\n", reg, value);; 

double colon?

-- 
~Vinod

