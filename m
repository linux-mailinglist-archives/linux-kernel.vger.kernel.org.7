Return-Path: <linux-kernel+bounces-845309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D027ABC4541
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FBB19E1764
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57E2F5A3E;
	Wed,  8 Oct 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aauXeU6z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87F2F49F7;
	Wed,  8 Oct 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919615; cv=none; b=mafhpVMji8UIjPq+4c9KP+x8JN+s+pm+uBFJo9jE0nHzp2Vq9Hpkomdt3eUHsa8FAWahptYBQIHU8ngGH2MjrHrtondRiTnDRnmpoU6CiiBXsPmiii1a3yzTXCimUT//JN6mqPJyFXHoFyIFX/x7M1bkFZO0J4X5qeNXerfhtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919615; c=relaxed/simple;
	bh=RDsqVeT1Mo0nF/u1l6b9TzxhvYxIKfFlBLWOUN3eB9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwK+8RpIHpBwXo+9eAhsCuARFTu1vfsNDryphRoYdIejRO/w9Wo/n+Mf7o0F+wDAdarMlZl0ETKKiezd8GSiLuSqMIBXYT9aiEOBfTv3MFqYoVBwZ+f858DZClkcwxYVFSPDrvkh5kB9NXAaq+pP7AO44Sq+Jog9EFJ1eCMJeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aauXeU6z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759919614; x=1791455614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RDsqVeT1Mo0nF/u1l6b9TzxhvYxIKfFlBLWOUN3eB9E=;
  b=aauXeU6zf0eZSofH/vTnKXvGoQLM8rf+6pPL/pWKnLuEb7tXT7qcSCCB
   UAnd2OHui1pmJRom3HwKCnNx4uT6iO5hBEfjkdeASB4dTdC+yUhpNy+zm
   nd2sj6Zi64TnG32puKLXOudzw7sBJuiGNTsAPWEOfyOwKIOPazMHOWopZ
   IkBSVQEfwfqgXrUDlXRTaiK3VtMm3J3Dnd+7UaXATPmU8fANsfOPS5aqZ
   pMSXYLSV9MuNJwSoV1L3H2/YQsz3MrSGbVQN9sEq2KOsEsUvrPCZVpGee
   m5PdKEvgrTForOl4rPacXB47DFZZHgKYY91eSYqHKi2hD4gO0YYbWrqUP
   w==;
X-CSE-ConnectionGUID: fCxzdm2qRGCCNJUtmPXPFg==
X-CSE-MsgGUID: 8JetlNZtQCynuwd3357BOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="84726938"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="84726938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:33:33 -0700
X-CSE-ConnectionGUID: aKq1M5JvT365RD54QT/tLA==
X-CSE-MsgGUID: HHnAAHbXRmKR5EsDPh7psw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="180825755"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by fmviesa008.fm.intel.com with SMTP; 08 Oct 2025 03:33:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 13:33:29 +0300
Date: Wed, 8 Oct 2025 13:33:28 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: altmodes/displayport: do not enter
 mode if port is the UFP
Message-ID: <aOY9-B1V3SNvcjrF@kuha.fi.intel.com>
References: <20250923181606.1583584-4-rdbabiera@google.com>
 <20250923181606.1583584-6-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923181606.1583584-6-rdbabiera@google.com>

On Tue, Sep 23, 2025 at 06:16:08PM +0000, RD Babiera wrote:
> Nothing currently stops the DisplayPort Alt Mode driver from sending
> Enter Mode if the port is the Data Device. Utilize
> typec_altmode_get_data_role to prevent mode entry.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 1dcb77faf85d..8d111ad3b71b 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -758,7 +758,9 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	struct fwnode_handle *fwnode;
>  	struct dp_altmode *dp;
>  
> -	/* FIXME: Port can only be DFP_U. */
> +	/* Port can only be DFP_U. */
> +	if (typec_altmode_get_data_role(alt) != TYPEC_HOST)
> +		return -EPROTO;
>  
>  	/* Make sure we have compatible pin configurations */
>  	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
> -- 
> 2.51.0.534.gc79095c0ca-goog

-- 
heikki

