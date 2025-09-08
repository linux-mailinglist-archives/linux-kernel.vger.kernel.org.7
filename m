Return-Path: <linux-kernel+bounces-805622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F7DB48B26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC9E188FD6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4642FAC09;
	Mon,  8 Sep 2025 11:09:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806262F90DC;
	Mon,  8 Sep 2025 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329793; cv=none; b=JiTvRfuaEexjWWjg0SeVJisqQzkPWt4tWYEbc8wLzylzJdtsMEY3PNZGgOmJ/88FsUzHzLlyRNkOXVhOjG+Ehopo9NfTx85EMwY6Tq3LtOk04JiI6qclMgrtU1k5+w1FtZoicSQ0eLbrwsf68M0tr7DzummGUG5rjHmd7zYHrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329793; c=relaxed/simple;
	bh=AvMdB2dcYGMV2EyNRqCtb0+TAFiqbu2iLNFeL01Lrxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUuiFs/LyT4ydkvF09pJUD0OKZYbJSeOCwRxDwzY79nXidmEJi682/qQQezD0gUYHtcdTsbMMlU/TJdK9AOrmP7zigs5aozK1k9NscGhvVaZ7i7eYkrcxJy0a7K5+MHLlzRp14SrpQIbhLFAAqw1pPZ9vTCmf4dhkB3oD4xqa2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C02B01692;
	Mon,  8 Sep 2025 04:09:43 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37BA43F63F;
	Mon,  8 Sep 2025 04:09:50 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:09:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, <arm-scmi@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] firmware: arm_scmi: imx: Dump syslog and
 system_info
Message-ID: <20250908-brave-umber-spider-eb68bd@sudeepholla>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>

On Thu, Sep 04, 2025 at 06:40:41PM +0800, Peng Fan wrote:
> System Manager firmware provides API to dump board, silicon, firmware
> information. It also provides API to dump system sleep, wakeup
> information. So add the interface for Linux to retrieve the information:
> 
> patch 1 is to add doc for board information which was missed before.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v4:
> - Patch 1: Typo in commit log, state the attribute is set to 0 by firmware
>            add NOT SUPPORTED return value for syslog
> - Patch 2: rename to scmi_imx_misc_build_info_discover, add -EOPNOTSUPP check
> - Patch 3: rename to scmi_imx_misc_cfg_info_get, correct command order,
>            add -EOPNOTSUPP check.
> - Patch 4: correct command order, add -EOPNOTSUPP check.

I will queue 1-4/6 from this series as it is ready. So repost 5-6/6 when
ready. Also I notices some inconsistency with CONTROL vs CTRL in the code
and document. Please choose either CONTROL or CTRL and use the same
in both document and code for the command names and send a patch to fix
the inconsistency.

-- 
Regards,
Sudeep

