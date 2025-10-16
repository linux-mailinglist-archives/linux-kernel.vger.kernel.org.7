Return-Path: <linux-kernel+bounces-856066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62006BE2FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D8842006A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6E25B1DA;
	Thu, 16 Oct 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f4dKm6Lo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gAOjJsXS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YWY9uuhX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vyBtqWrm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56FC328619
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612506; cv=none; b=r1xPbbH/lzMR7QbiVk9xmAt8CYX1Fk3XRMsfxL1fq1SCxrOnJXwH/uEnMBKNTu4Q/KG1SzhsdHShsrEwEu0h+MWLptz7er92XHQAYHEnt8g1wBxoaGlfCH/wp46IOt4ArAs2iXCxl7HKISa4Tdtm9yZYnd0llIIyGlDMqGyDiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612506; c=relaxed/simple;
	bh=/HanGIISO+FAl8/fhjoxI5d4bBuLrT8fvaP6DoxhTOk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlmdC9J5nMwWw9CcZReW60x6rGqcCgU12CtvdTUnhJJBUjDjo7bh677Jme38CgOGIu49+J63yrReaNj202+SddLdBI+n5ryueSiqWTq8UaKxwos8tGqT1Vke2G6w0GKCysK+fPzpl026OLqfFI8+kswCPyaJ0JDLsdYO7F9WzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f4dKm6Lo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gAOjJsXS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YWY9uuhX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vyBtqWrm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B85CC1F7BB;
	Thu, 16 Oct 2025 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760612503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JppALIfxtNy0YCR3k3y+/IM0OqyO2knEp8c0AkQxfNw=;
	b=f4dKm6Lo3rz3831C0m76Zr526V8BUQyUgqNkRiej0qwd5pu+95khAdU4OPoNodqznW68ZG
	44l1FLhjpeJhXS2F1MwIZXdo/MygpljILlxs1k+nNftmqkgPsn132sGFOSQmou2b97vk5q
	k2udjzgEjs2cAMRWmG+XZoopsodvE1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760612503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JppALIfxtNy0YCR3k3y+/IM0OqyO2knEp8c0AkQxfNw=;
	b=gAOjJsXSVx4YwwC+zQP5BuS57E20bD1uPEAZPqqoTdMZ0goyWM9FuYJtsViPKvKb4RIDdE
	xU2rmzdJ+7TFJqCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YWY9uuhX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vyBtqWrm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760612501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JppALIfxtNy0YCR3k3y+/IM0OqyO2knEp8c0AkQxfNw=;
	b=YWY9uuhXmmyE0CS/Fvfa621sioAAYi6vY8d9R3QONSswC29gWNumMOXuoaP12/73XErJfD
	8FzizkxBukjQGQgC2pAT2Ucll4V+T4kcZTqrY2hYxLAxd4C3s//qgys4bP6A/pCjOPl6jO
	txuwesP5RhPCTanX78I5UfKr2FyZtNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760612501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JppALIfxtNy0YCR3k3y+/IM0OqyO2knEp8c0AkQxfNw=;
	b=vyBtqWrm/OBR/p9Y861QotQ8aXXH/YOWD+FzjXA4OJ288NZEcRaX7I8DbFimOSzEnsxw1B
	b7qNEAvC54pwlODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8807B1376E;
	Thu, 16 Oct 2025 11:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TonXH5XQ8GgPMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 Oct 2025 11:01:41 +0000
Date: Thu, 16 Oct 2025 13:01:41 +0200
Message-ID: <871pn3860a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 05/11] ALSA: hda/cs35l56: Create sysfs files for factory calibration
In-Reply-To: <20251016104242.157325-6-rf@opensource.cirrus.com>
References: <20251016104242.157325-1-rf@opensource.cirrus.com>
	<20251016104242.157325-6-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: B85CC1F7BB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cirrus.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Thu, 16 Oct 2025 12:42:36 +0200,
Richard Fitzgerald wrote:
> 
> Create sysfs files that can be used to perform factory calibration.
> 
> During manufacture, the production line must perform a factory calibration
> of the amps. This patch adds this functionality via sysfs files.
> 
> Sysfs is used here to restrict access to the factory calibration.
> It is only intended to be used during manufacture. It is not something
> that a normal user should ever touch. Calibration affects the matching of
> the amp hardware to the external speakers. If not done correctly it can
> cause the speakers to be under-protected.
> 
> As this is only needed during manufacture, there is no need for this to be
> available in a normal system so a Kconfig item has been added to enable
> this. The new Kconfig option is inside a sub-menu because items do not
> group and indent if the parent is invisible or there are multiple parent
> dependencies. Anyway the sub-menu reduces the clutter.
> 
> cs35l56_hda_apply_calibration() has been changed to return an error code
> that can be reported back through the sysfs write. The original call to
> this function doesn't check the return code because in normal use it
> doesn't matter whether this fails - the firmware will default to a safe
> calibration for the platform. But tooling using sysfs might want to know
> if there was an error.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

What kind of data format should be written to calibrate sysfs entry?
Since those are no trivial files, we may need to document the
formats.

Also, the scenario isn't clear -- who should write this sysfs at which
moment?  e.g. is this supposed to be set up at each boot?


thanks,

Takashi

> ---
>  sound/hda/codecs/side-codecs/Kconfig       |  15 +++
>  sound/hda/codecs/side-codecs/cs35l56_hda.c | 139 ++++++++++++++++++++-
>  2 files changed, 149 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/hda/codecs/side-codecs/Kconfig b/sound/hda/codecs/side-codecs/Kconfig
> index cbf1847896bc..0218aa41bba2 100644
> --- a/sound/hda/codecs/side-codecs/Kconfig
> +++ b/sound/hda/codecs/side-codecs/Kconfig
> @@ -88,6 +88,21 @@ config SND_HDA_SCODEC_CS35L56_SPI
>  	  Say Y or M here to include CS35L56 amplifier support with
>  	  SPI control.
>  
> +menu "CS35L56 driver options"
> +	depends on SND_HDA_SCODEC_CS35L56
> +
> +config SND_HDA_SCODEC_CS35L56_CAL_SYSFS
> +	bool "CS35L56 create sysfs for factory calibration"
> +	default N
> +	select SND_SOC_CS35L56_CAL_SYSFS_COMMON
> +	help
> +	  Create sysfs entries used during factory-line manufacture
> +	  for factory calibration.
> +	  This is not needed for normal use.
> +
> +	  If unsure select "N".
> +endmenu
> +
>  config SND_HDA_SCODEC_TAS2781
>  	tristate
>  	select SND_HDA_GENERIC
> diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
> index 5bb1c4ebeaf3..4a1bd934887a 100644
> --- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
> +++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
> @@ -548,20 +548,24 @@ static void cs35l56_hda_release_firmware_files(const struct firmware *wmfw_firmw
>  	kfree(coeff_filename);
>  }
>  
> -static void cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
> +static int cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
>  {
>  	int ret;
>  
>  	if (!cs35l56->base.cal_data_valid || cs35l56->base.secured)
> -		return;
> +		return -EACCES;
>  
>  	ret = cs_amp_write_cal_coeffs(&cs35l56->cs_dsp,
>  				      &cs35l56_calibration_controls,
>  				      &cs35l56->base.cal_data);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_warn(cs35l56->base.dev, "Failed to write calibration: %d\n", ret);
> -	else
> -		dev_info(cs35l56->base.dev, "Calibration applied\n");
> +		return ret;
> +	}
> +
> +	dev_info(cs35l56->base.dev, "Calibration applied\n");
> +
> +	return 0;
>  }
>  
>  static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
> @@ -669,7 +673,9 @@ static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
>  	if (ret)
>  		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
>  
> +	/* Don't need to check return code, it's not fatal if this fails */
>  	cs35l56_hda_apply_calibration(cs35l56);
> +
>  	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
>  	if (ret)
>  		cs_dsp_stop(&cs35l56->cs_dsp);
> @@ -695,6 +701,126 @@ static void cs35l56_hda_dsp_work(struct work_struct *work)
>  	cs35l56_hda_fw_load(cs35l56);
>  }
>  
> +static ssize_t calibrate_store(struct device *dev, struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
> +	ssize_t ret;
> +
> +	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs35l56_calibrate_sysfs_store(&cs35l56->base, buf, count);
> +	pm_runtime_autosuspend(cs35l56->base.dev);
> +
> +	return ret;
> +}
> +
> +static ssize_t cal_temperature_store(struct device *dev, struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
> +	ssize_t ret;
> +
> +	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs35l56_cal_ambient_sysfs_store(&cs35l56->base, buf, count);
> +	pm_runtime_autosuspend(cs35l56->base.dev);
> +
> +	return ret;
> +}
> +
> +static ssize_t cal_data_read(struct file *filp, struct kobject *kobj,
> +			     const struct bin_attribute *battr, char *buf, loff_t pos,
> +			     size_t count)
> +{
> +	struct cs35l56_hda *cs35l56 = dev_get_drvdata(kobj_to_dev(kobj));
> +	ssize_t ret;
> +
> +	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs35l56_cal_data_sysfs_read(&cs35l56->base, buf, pos, count);
> +	pm_runtime_autosuspend(cs35l56->base.dev);
> +
> +	return ret;
> +}
> +
> +static ssize_t cal_data_write(struct file *filp, struct kobject *kobj,
> +			      const struct bin_attribute *battr, char *buf, loff_t pos,
> +			      size_t count)
> +{
> +	struct cs35l56_hda *cs35l56 = dev_get_drvdata(kobj_to_dev(kobj));
> +	ssize_t ret;
> +
> +	ret = cs35l56_cal_data_sysfs_write(&cs35l56->base, buf, pos, count);
> +	if (ret == -ENODATA)
> +		return count;	/* Ignore writes of empty cal blobs */
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs35l56_hda_apply_calibration(cs35l56);
> +	if (ret == 0)
> +		cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
> +	else
> +		count = -EIO;
> +
> +	pm_runtime_autosuspend(cs35l56->base.dev);
> +
> +	return count;
> +}
> +
> +static const DEVICE_ATTR_WO(calibrate);
> +static const DEVICE_ATTR_WO(cal_temperature);
> +static const BIN_ATTR_RW(cal_data, sizeof_field(struct cs35l56_base, cal_data));
> +
> +static const struct attribute *cs35l56_hda_cal_attributes[] = {
> +	&dev_attr_calibrate.attr,
> +	&dev_attr_cal_temperature.attr,
> +	NULL
> +};
> +
> +static void cs35l56_hda_create_calibration_sysfs(struct cs35l56_hda *cs35l56)
> +{
> +	struct device *dev = cs35l56->base.dev;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_SND_HDA_SCODEC_CS35L56_CAL_SYSFS))
> +		return;
> +
> +	ret = sysfs_create_files(&dev->kobj, cs35l56_hda_cal_attributes);
> +	if (ret)
> +		goto err;
> +
> +	ret = sysfs_create_bin_file(&dev->kobj, &bin_attr_cal_data);
> +	if (ret)
> +		goto err;
> +
> +	return;
> +err:
> +	dev_err_probe(dev, ret, "Failed creating calibration sysfs\n");
> +}
> +
> +static void cs35l56_hda_remove_calibration_sysfs(struct cs35l56_hda *cs35l56)
> +{
> +	struct device *dev = cs35l56->base.dev;
> +
> +	if (!IS_ENABLED(CONFIG_SND_HDA_SCODEC_CS35L56_CAL_SYSFS))
> +		return;
> +
> +	sysfs_remove_files(&dev->kobj, cs35l56_hda_cal_attributes);
> +	sysfs_remove_bin_file(&dev->kobj, &bin_attr_cal_data);
> +}
> +
>  static int cs35l56_hda_bind(struct device *dev, struct device *master, void *master_data)
>  {
>  	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
> @@ -722,6 +848,8 @@ static int cs35l56_hda_bind(struct device *dev, struct device *master, void *mas
>  	cs_dsp_init_debugfs(&cs35l56->cs_dsp, cs35l56->debugfs_root);
>  #endif
>  
> +	cs35l56_hda_create_calibration_sysfs(cs35l56);
> +
>  	dev_dbg(cs35l56->base.dev, "Bound\n");
>  
>  	return 0;
> @@ -736,6 +864,7 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
>  	cancel_work_sync(&cs35l56->dsp_work);
>  
>  	cs35l56_hda_remove_controls(cs35l56);
> +	cs35l56_hda_remove_calibration_sysfs(cs35l56);
>  
>  #if IS_ENABLED(CONFIG_SND_DEBUG)
>  	cs_dsp_cleanup_debugfs(&cs35l56->cs_dsp);
> -- 
> 2.47.3
> 

