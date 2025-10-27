Return-Path: <linux-kernel+bounces-871587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57698C0DB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D14FEEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C022F77B;
	Mon, 27 Oct 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Q1tSslCY"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AEE230BD9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569356; cv=none; b=rA3miqrHl4LVPltpY0erMuPJuhJwQZevjnJW+vY0bkGidae9rGQGfysMcTkjlXjnsDzZFV1G2KcLC4B2g3CGne9FNk8R/iyWCWV8uyaxvKrZckF7oweHK3AbMaQru/XeKt/wBEzPK/kgc8dlxgsI9cjgji7PmKeX3Ihw1wyNaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569356; c=relaxed/simple;
	bh=2c/2TGXe1TvOXnyySJnc/eJoic2DVPnvVTIFzQKKPVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuGiXgeC5EqvNjgPCVjvFJPNn70yZafaqyTezJ0lND3v59tDsoa2mY+kZb9lMf8UZmM7ALPIO6CCoeZRGh1/cMqYbe5TPc6Mkr+8bw5ybdu+k2G5q/SKyU3qkedngmCuCt1ud2la+MKcMK7kKcn75gdEARC6nui3l84kiwlmDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Q1tSslCY; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4F7E5598F5;
	Mon, 27 Oct 2025 13:49:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761569353;
	bh=2c/2TGXe1TvOXnyySJnc/eJoic2DVPnvVTIFzQKKPVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1tSslCYQiIrLVNZDVV9VcYf6zV0LJhi9qCYpcj0H3ZdhSouGi2+QELJrlmjNLCK4
	 /WyUGdhhlZzsJoQ9LKrzU6hkjZh+n3+ybFvYreGGNAr4W3OmipqTqFIYfOXdeWwsCy
	 ECvijRprBOK4F4WC/2gfPv6+nBjqQNQyfpa573u1zbSfvMDyeAXvps/GJXZqsCY0YK
	 NC3B8woZBtlovRXWE0BduYtNKAipwUFNuHa9KcBd7RTucsbpdGGR1sa5OyqrF/gBR2
	 YxsSf2jpEVYGRdjn03FoVze5ffaA9O/4424HrNcUsmcDRMeUWbBaUQN0mdWagjz/QR
	 SZPW3tiyy5Fgw==
Date: Mon, 27 Oct 2025 13:49:12 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com, 
	Santosh.Shukla@amd.com
Subject: Re: [PATCH] iommu/amd: Enhance "Completion-wait Time-out" error
 message
Message-ID: <tgugv7ebuxtnp6ou5jnt7od7jmccsipblqityiinhkgratosu6@bxsr73hpiiny>
References: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>

Hey Dheeraj,

On Thu, Oct 16, 2025 at 08:38:09PM +0530, Dheeraj Kumar Srivastava wrote:
>  static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>  {
> -	int i = 0;
> +	struct iommu_cmd *cmd;
> +	int i = 0, j;
>  
>  	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
>  		udelay(1);
> @@ -1166,7 +1167,33 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>  	}
>  
>  	if (i == LOOP_TIMEOUT) {
> -		pr_alert("Completion-Wait loop timed out\n");
> +		int head, tail;
> +
> +		head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
> +		tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
> +
> +		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
> +			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
> +			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));

Better use dev_err(&amd_iommu->dev->dev, ...) here.

> +		if (!amd_iommu_dump) {
> +			/*
> +			 * On command buffer completion timeout, step back by 2 commands
> +			 * to locate the actual command that is causing the issue.
> +			 */
> +			tail = (MMIO_CMD_BUFFER_TAIL(tail) - 2) & (CMD_BUFFER_ENTRIES - 1);
> +			cmd = (struct iommu_cmd *)(iommu->cmd_buf + tail * sizeof(*cmd));
> +			dump_command(iommu_virt_to_phys(cmd));
> +		} else {
> +			/* Dump entire command buffer along with head and tail indices */
> +			pr_alert("CMD Buffer head=%d tail=%d\n", (int)(MMIO_CMD_BUFFER_HEAD(head)),
> +				 (int)(MMIO_CMD_BUFFER_TAIL(tail)));
> +			for (j = 0; j < CMD_BUFFER_ENTRIES; j++) {
> +				cmd = (struct iommu_cmd *)(iommu->cmd_buf + j * sizeof(*cmd));
> +				pr_err("%3d: %08x %08x %08x %08x\n", j, cmd->data[0], cmd->data[1],
> +				       cmd->data[2], cmd->data[3]);
> +			}
> +		}

I don't think it makes much sense to just print the command before the failed
completion wait. In case of a timeout and amd_iommu_dump == true, just dump the
whole pending command buffer, from head to tail.

Also, please put all the parsing/dumping code into a separate function.

Regards,

	Joerg

