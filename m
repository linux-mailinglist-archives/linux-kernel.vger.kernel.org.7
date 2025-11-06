Return-Path: <linux-kernel+bounces-888221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B3EC3A3EB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF4E3A9760
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9A2DC341;
	Thu,  6 Nov 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGsbXciG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1346C2749D5;
	Thu,  6 Nov 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424215; cv=none; b=SeqwRqRzVOUXDml/XI7Vm3UW+aB4jgIVFHu04BP6jRYRsCCvlBJhzG1Dgiy2EPC7aIYZztiuiI3l0VQj8gf4nXV3Sa3/2EypgNBU028i4yM5VOyRIlqKuE2X08kaQjGiUibvw0mjd8GTlKEwSPJJW7fYY/97dTStCVO+iUYzwvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424215; c=relaxed/simple;
	bh=l1QZfQOyLUEOJY7pbgILma3O0pmKLrIPypinXCbOl/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8kPa5Ayl2iMe4GtOZfgYd7/GlYLRlK57JePXvCYsXz4O6qUv7li2gj4qSDVl0tubyAUx2bdcqtM6oTyWNaoe1GCPIObhVHi0WpEfihoGvgnNvf7hxixo8XiXFLWJ948Yd0SSsz07EOAKMOMwruxtHR0iU4RfdtDbhnB2B5GQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGsbXciG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762424214; x=1793960214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l1QZfQOyLUEOJY7pbgILma3O0pmKLrIPypinXCbOl/I=;
  b=jGsbXciGGHzYB9TFpF9ROQMmHj2a79NpqzDV/BFYWuKAycCuml6HpXV8
   Yzq+5Bag0n50AIPJbrbOD/8xkVyPH6SEKpgqRqUOmfRgReMgn1jFNhAHl
   plvh1Jbrah7BWKdbKFSCo/VJUkNrL0p9uahMPQyiKeTaeAofNK0dvCeaz
   KBA2Nv/y5BRdSrlUe+kF2oZljdLV7uB29zBGzgLa4Yu6mJGv/E9aMaskJ
   cPOgiYJj57oylrW+oLW3fOXjLY+AJV06HDzqEEYxeADNOHcxcwIQU+why
   6xYoqziebEsT1/RWPCsIK+8A2LFS6ZeIzIihaTlx6BvdxDKYf6cx0OrO9
   A==;
X-CSE-ConnectionGUID: gH6wPnMLTAilb/fchpTRPg==
X-CSE-MsgGUID: fLb/7eFSSgmyzYYL8yDH7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64464417"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64464417"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:16:54 -0800
X-CSE-ConnectionGUID: 6rNmkeEMQN2VNx8iKEZUaA==
X-CSE-MsgGUID: gBKE2MzxTBSpm4YrqCFR3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187881669"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.237])
  by orviesa008.jf.intel.com with SMTP; 06 Nov 2025 02:16:50 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 06 Nov 2025 12:16:48 +0200
Date: Thu, 6 Nov 2025 12:16:48 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID
 pin state
Message-ID: <aQx1WVif-vgN0_T-@kuha.fi.intel.com>
References: <20251102164819.2798754-1-krishna.kurapati@oss.qualcomm.com>
 <20251102164819.2798754-3-krishna.kurapati@oss.qualcomm.com>
 <aQxyfjYosVd_kPKC@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQxyfjYosVd_kPKC@kuha.fi.intel.com>

>         struct regulator *vbus;
> 
>         vbus = devm_of_regulator_get_optional(...
>         if (IS_ERR(vbus) && vbus != ERR_PTR(-ENODEV))
>                 return PTR_ERR(vbus);
> 
>         hd3ss3220->vbus = vbus;

Sorry, that has to be:

        hd3ss3220->vbus = vbus == ERR_PTR(-ENODEV) ? NULL : vbus;


-- 
heikki

