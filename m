Return-Path: <linux-kernel+bounces-845311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401C5BC4552
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E323AD81E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9252F5A3F;
	Wed,  8 Oct 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZmyVNyS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF52580F3;
	Wed,  8 Oct 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919682; cv=none; b=XPdQVgd1S2ioQybkptN/Wddnooctnr5Rz9qRELiXZsMpvOUGkzhLRNjLB/qyor0xWM1TeslwQGMLtXAfnM6LnzcLZvSwpbqv3g52yuohWAuHpKmCA1wqsUt30mZ8UGIGG57fCGntIEOEP/Tdl9xe62xYD+/92MCGopokCR++jLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919682; c=relaxed/simple;
	bh=jCkJEXH1E6FROpPanT37fN5bEb616c7JgoVH87DtRlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwU4gpeMjY2/AbwlVPyIO6aoBsfE7iT9kSBNaVfrniWycQF9TjwOii9U4nZOpvNlPW4uusD7LxF2U8CQ2d/lpcUkNoCsvam5F8CMdZ1cGw1TBvME75ilLzw75lDEypFlUaOeBMI07d9dFInJQsWXrUCXua4+MObcjkZIrQ0HJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZmyVNyS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759919681; x=1791455681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jCkJEXH1E6FROpPanT37fN5bEb616c7JgoVH87DtRlc=;
  b=EZmyVNySTFLgbHsIFCqdS4GHl1ooPdT6TsAc3HEKGwxrUy+HDK6YQjTg
   +/z68ZsCyG3AOigHkhWeG68Xg1FO8S4rXt0Y4ONGv1GptLE5tceQjmmwY
   dM6ExafSIlKiFXz+wr/rtc8q5G3gXJZ5QKrMgm/gcRjSvBp5jWMCObbO/
   RQYDbOwl5oVuS59QP4z33K1zFPXCksPopD5lbF5xw7tl7xAJ/oc/S44Ds
   xrIZBl/fjzwe8xa2aVyv8A1zlTXbQ5GFsQCcUPFoNj9YNkTk64+QoPx9b
   +LYXQvTmuLP/wPs3EYMQ4udEAt6bDOso1kqiq0Aifd1g/8jIaAgVD6Y/t
   w==;
X-CSE-ConnectionGUID: HM/FZ69gTfuaauYCJQnlgQ==
X-CSE-MsgGUID: n/5OlbPSRn6UO12vLzj18w==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72368852"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="72368852"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:34:40 -0700
X-CSE-ConnectionGUID: RViAZyswQBO+vJgbANBDVA==
X-CSE-MsgGUID: MJkr+Qt0RsmvOqtuMI7X+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="179999109"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by orviesa009.jf.intel.com with SMTP; 08 Oct 2025 03:34:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 13:34:35 +0300
Date: Wed, 8 Oct 2025 13:34:35 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix workqueue destruction race during
 connector cleanup
Message-ID: <aOY-OyN90DScHr85@kuha.fi.intel.com>
References: <20251002013026.4095030-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002013026.4095030-1-acelan.kao@canonical.com>

On Thu, Oct 02, 2025 at 09:30:26AM +0800, Chia-Lin Kao (AceLan) wrote:
> During UCSI initialization and operation, there is a race condition where
> delayed work items can be scheduled but attempt to queue work after the
> workqueue has been destroyed. This occurs in multiple code paths.
> 
> The race occurs when:
> 1. ucsi_partner_task() or ucsi_poll_worker() schedule delayed work
> 2. Connector cleanup paths call destroy_workqueue()
> 3. Previously scheduled delayed work timers fire after destruction
> 4. This triggers warnings and crashes in __queue_work()

What warnings?

-- 
heikki

