Return-Path: <linux-kernel+bounces-865768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC55BFDF47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8DB3A7F42
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DAC2F12DB;
	Wed, 22 Oct 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JelAEa7Z"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607E2F0665
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159619; cv=none; b=DOzwf2+f55PYGoNMR1fiDjBePlpPM4MEz9SMryYe/+cnaW4GXnSvIXEaFtfVOLzznyOBWsNR7LtCZ2xMLuVRmFVs0J34m4fePZahnYOrg794DmzklNTU+1jcPzGi8w3pm43uio5y1uqADijiNCvbvF9jSeCOlxBYGEcd5qwnqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159619; c=relaxed/simple;
	bh=LpUaV8z0D3O4lOyXJTHjgC5xGrpDllWIXYVOgbSku4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVuX+NaNpJge7xL7yPZW/akxjV1q841H9LAazOwZ74L9435PM6i5X0kuKWCguE4IjjKotX+okfiZDexg1nAApIFth3vFEwfr8QnFBK3qOwNduglSKsUBVWORjlhG/qiSyJUyn6k+qiyIVHYMFUB6Pt2MwRcEzAaTl4S22A/uULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JelAEa7Z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290cd62acc3so68977045ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761159617; x=1761764417; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFzdfoqya5Ggmh6WNFeMHz2ogjyeullW1tSjweAvnu0=;
        b=JelAEa7ZJ5bE2zZfPYjMB9z9BDYdy5ONSsuvv2FbRfNAEtHcCenLGZh+o4fCqiYuHL
         vlwYtPjQKlQi99bUb9LuWoYOdTS/d4Nx1WXLtHN4C0+4zUzW1ZrNn4iS4ZDP8PHoGQFH
         BYQmDBV86OFu2GIm6IlruAtMQg1xS4Oa96GtPfKGv+xFj32a+yBtQt3UF7VlcFTiDBPN
         81ua4fr8AyW+zAy++F5BH4VjCYo+AX3naiVuZ3Ny1HvdI+6adF3DtGbtDFNVHTGHotI0
         5NEI40xhd5XE0UXSyEBtwLlv6WllkC+GZHRepNMlCkgzYFE6ZDzROOkbkxhUMhcDvkig
         JhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761159617; x=1761764417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFzdfoqya5Ggmh6WNFeMHz2ogjyeullW1tSjweAvnu0=;
        b=KWs3sZz+DvOXcbhsArkB/0qcCFzDQmqaR+xSXlMpNlZeGhz3AG8WO1wHeQEi3Lk3Il
         fE3ooh/MublNBJ/ofxMiAsSgyr1cf4GApyBmzQyDgWDFEvP5L8+P1k6DqJgd1nHQun31
         f6rk6zXfpCNEfyCdF+M0I5a1awclmnNqE1gRJqJ+J5O5w2RXSjgEnge/tnOhf1vmDO9Z
         P3+7Q8gQLJnz0uhRizi0zuiRjbPGl/xkNdyROQNhjhZo8SGzalsP/o7Sh7j301AElrSS
         wHhoUVLke6XOl78fzJhOxG0wuQpN3I3jzJYH87eE9ks2/FGZI0ce7UuScHo/t/se9QpU
         VUSg==
X-Forwarded-Encrypted: i=1; AJvYcCUAe0qTQ/W3bCReBzSmBSdE7st4sPBNfnRqZpQF8LlFlogTR3UmGlsqobqh8lalSSD/HjcVNF7wb+Fn46k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnXNClPljL6Zg1smiZWPJXIH+zppS2WS7sc9J9VIrEqmGgNu6
	LKOC6avcfdf6KXV3kW/9BPso2JqCS6sNFJogfC+jVkdbTn4AZgWq03Ji
X-Gm-Gg: ASbGncut9HUn7whnAn9wHC04gibdgAA6qlviguBYRhn32MmH2vXHN/40+d4sy3uVMIn
	Hyz6eklSV1M/JYfD7MbAbvAYSQgd1KOuvn7Q+NyuIWUYDUzDusUuVZ9fqTwaCozSJ0zt3DfGxdm
	cmF8JFDnXjGmeuD0oneSHlfzg1QtOwMuy3hBQdEQMu+vJF51h3E4nfLiNFmb/pMJtMChZCQGxHe
	IlEn8uxGKM7/dkFLkTI6tXihy+uCqkVhdKmPIgejZxlycXIaSX7vMi6Ei1UGogMnkxrCYJDy5Dt
	iUzWwxdkb4xKcYoCf7dfxlmA2gqaWKXJbeICOTzF1vCM+NIdQCoSbGCL0DpWmP3e2gO0klTZOqe
	21ggXlhxC/k+zm2fmkz9KaL9VtchOKd6JhC3CS4LrkFk+T883GTyAPgFjBPxGULkMmFuJnkh0gU
	X40NX97VNBsThd
X-Google-Smtp-Source: AGHT+IHcqzpOH5zo5LUcgVV0/Ftev63QOy6p43ZgLKbB4SPMBtDcXqiSUsTvlWWnn+nn/U8BdHObJQ==
X-Received: by 2002:a17:903:1a70:b0:267:9c2f:4655 with SMTP id d9443c01a7336-290cbb49970mr303808925ad.41.1761159616399;
        Wed, 22 Oct 2025 12:00:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm145915295ad.54.2025.10.22.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:00:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 22 Oct 2025 12:00:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: migrate i8k procfs interface to sysfs
Message-ID: <c4605534-e715-4d39-9361-6e95bc03ba30@roeck-us.net>
References: <20251022183746.66481-1-biancaa2210329@ssn.edu.in>
 <20251022184518.53tqi33jgustwvf5@pali>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022184518.53tqi33jgustwvf5@pali>

On Wed, Oct 22, 2025 at 08:45:18PM +0200, Pali Rohár wrote:
> Sorry, but I do not understand this patch. dell-smm-hwmon driver is
> already using the sysfs interface provided by hwmon subsystem.
> 
It is also weirdly incomplete, and it claims to be "confidential and
intended for the named recipient(s) only". Git says it is corrupted,
and it doesn't look like a real patch.

> > --- a/drivers/hwmon/dell-smm-hwmon.c
> > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > @@ -XXX,40 +XXX,80 @@
> > -// Remove procfs interface

I'll take the patch author by their word:

" If you have received this email in error please delete it and
  notify the sender immediately.
"

To the author: Please consider yourself notified, and I will delete the
patch as directed.

Guenter

> On Thursday 23 October 2025 00:07:46 Biancaa Ramesh wrote:
> > The i8k driver currently exposes Dell laptop hardware monitoring
> > information via a deprecated /proc/i8k interface.
> > 
> > This patch removes the procfs file creation and replaces it with
> > standard sysfs attributes under the hwmon subsystem.
> > 
> > - Removes i8k procfs registration and operations.
> > - Creates sysfs attributes for temperature, fan speeds, and power status.
> > - Registers these attributes via devm_hwmon_device_register_with_groups().
> > - Cleans up legacy procfs code for a cleaner, modern, and supported interface.
> > 
> > This migration aligns with Linux kernel best practices to phase out
> > deprecated and legacy procfs files in favor of a structured sysfs approach.
> > 
> > Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
> > ---
> >  drivers/hwmon/dell-smm-hwmon.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 100 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > index oldhash..newhash 100644
> > --- a/drivers/hwmon/dell-smm-hwmon.c
> > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > @@ -XXX,40 +XXX,80 @@
> > -// Remove procfs interface
> > -static int i8k_proc_show(struct seq_file *seq, void *offset)
> > -{
> > -    struct dell_smm_data *data = seq->private;
> > -    // ...
> > -}
> > -
> > -static const struct proc_ops i8k_proc_ops = {
> > -    .proc_open = i8k_open_fs,
> > -    .proc_read = seq_read,
> > -    .proc_lseek = seq_lseek,
> > -    .proc_release = single_release,
> > -    .proc_ioctl = i8k_ioctl,
> > -};
> > -
> > -static void i8k_exit_procfs(void *param)
> > -{
> > -    remove_proc_entry("i8k", NULL);
> > -}
> > -
> > -static void __init i8k_init_procfs(struct device *dev)
> > -{
> > -    struct dell_smm_data *data = dev_get_drvdata(dev);
> > -    // ...
> > -    if (proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data))
> > -        devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
> > -}
> > +// Define sysfs attributes for temps and fans
> > +static ssize_t temp1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +    struct dell_smm_data *data = dev_get_drvdata(dev);
> > +    int temp = i8k_get_temp(data, 0);
> > +    if (temp < 0)
> > +        return temp;
> > +    return sprintf(buf, "%d\n", temp * 1000);
> > +}
> > +
> > +static DEVICE_ATTR_RO(temp1_input);
> > +
> > +static ssize_t fan1_input_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +    struct dell_smm_data *data = dev_get_drvdata(dev);
> > +    int speed = i8k_get_fan_speed(data, 0);
> > +    if (speed < 0)
> > +        return speed;
> > +    return sprintf(buf, "%d\n", speed);
> > +}
> > +
> > +static DEVICE_ATTR_RO(fan1_input);
> > +
> > +static struct attribute *dell_smm_attrs[] = {
> > +    &dev_attr_temp1_input.attr,
> > +    &dev_attr_fan1_input.attr,
> > +    NULL,
> > +};
> > +
> > +static const struct attribute_group dell_smm_group = {
> > +    .attrs = dell_smm_attrs,
> > +};
> > +
> > +static const struct attribute_group *dell_smm_groups[] = {
> > +    &dell_smm_group,
> > +    NULL,
> > +};
> > +
> > +static int dell_smm_init_cdev(struct device *dev)
> > +{
> > +    struct dell_smm_data *data = dev_get_drvdata(dev);
> > +    struct device *hwmon_dev;
> > +
> > +    hwmon_dev = devm_hwmon_device_register_with_groups(dev, "dell_smm", data, dell_smm_groups);
> > +    return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static int __init dell_smm_probe(struct platform_device *pdev)
> > +{
> > +    int ret;
> > +
> > +    ret = dell_smm_init_data(&pdev->dev, &i8k_smm_ops);
> > +    if (ret < 0)
> > +        return ret;
> > +
> > +    ret = dell_smm_init_hwmon(&pdev->dev);
> > +    if (ret)
> > +        return ret;
> > +
> > +    ret = dell_smm_init_cdev(&pdev->dev);
> > +    if (ret)
> > +        return ret;
> > +
> > +    return 0;
> > +}
> > 
> > -- 
> > ::DISCLAIMER::
> > 
> > ---------------------------------------------------------------------
> > The 
> > contents of this e-mail and any attachment(s) are confidential and
> > intended 
> > for the named recipient(s) only. Views or opinions, if any,
> > presented in 
> > this email are solely those of the author and may not
> > necessarily reflect 
> > the views or opinions of SSN Institutions (SSN) or its
> > affiliates. Any form 
> > of reproduction, dissemination, copying, disclosure,
> > modification, 
> > distribution and / or publication of this message without the
> > prior written 
> > consent of authorized representative of SSN is strictly
> > prohibited. If you 
> > have received this email in error please delete it and
> > notify the sender 
> > immediately.
> > ---------------------------------------------------------------------
> > Header of this mail should have a valid DKIM signature for the domain 
> > ssn.edu.in <http://www.ssn.edu.in/>

