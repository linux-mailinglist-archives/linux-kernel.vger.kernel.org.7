Return-Path: <linux-kernel+bounces-885869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEA0C3415D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C89FB4E5A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859962C15A2;
	Wed,  5 Nov 2025 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVVKeYN5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1516B28695;
	Wed,  5 Nov 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325270; cv=none; b=QwxUdHY0JvIsLpKlcsvxB1ykSr8MGWpI/6cZwY0vmqZeMgXKp/uBlBel/hm2yaMIRTlGwM9mlmww70fB+iYsZzztHXXw7ij8+Jo2kdwGTwnQl8ha82ph0AH+dbjQdlrhrO5pfM9CwXjv1Ju0jPLpoi3Yya2OcKBipC0gri+CwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325270; c=relaxed/simple;
	bh=pqLiBVvUFWaNMUfoweuXJBp9qOYg/9vfvjm9kJqIRlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDcXHz4eP7GztcHsA5eWe/y0wcJSMbeL1K1CNxjeyMc9ZOoHEzQkT3/8A0ydDefOQt/ZgdvytK0O35moH7KPO9ObEbQ+Pp5eqyxHtivG3szFiQ4pYmExYRVB6Y2+hJ7ixmeyHHVKY393xni2E5y3Kr2FD8Pgm7rByipzcVNnpto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVVKeYN5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762325268; x=1793861268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pqLiBVvUFWaNMUfoweuXJBp9qOYg/9vfvjm9kJqIRlg=;
  b=YVVKeYN5oEuGjaiU8wVa/Tb2FALzscrL7GPts5WHz4HCXi1uoGUASU3k
   Too+2l7jJNNr1i3ITRON4jGEyDk+7f9r8j7gui/OtqlykPNjfqYxf6aL7
   Vvr7O5U1fQ2D16VAP169Wz/DUlgvgqa3g7MQREWrdTT/ynfVUadiqpsbh
   SXo3V00MEDBCZJ3awx7cuFz+zIy91T97PsaXUX0VTO2+hlUfWWnGpFWyj
   xaTP2qm68Pp88YaKNj/RKHlbF6BDIsdRzViZ+vSV2l0kOcXOi75jTp1wu
   ZL2RK7TUUXy/oEnCAF8cQTkH+Knmp19Mg29Utsu9Jf2uq0DWCYGvo2RhU
   A==;
X-CSE-ConnectionGUID: 45OFyGrcTv+b8sivCYzd0w==
X-CSE-MsgGUID: QbuMiKmHQxOYeD7fRDaWWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68290621"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="68290621"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 22:47:43 -0800
X-CSE-ConnectionGUID: KSWfjTJ0S02fkPNoH0gAvw==
X-CSE-MsgGUID: VM9PFSLlQ7O/0dYpC1s3KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186618644"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 22:47:36 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGXIm-00000005h4B-1GUr;
	Wed, 05 Nov 2025 08:47:28 +0200
Date: Wed, 5 Nov 2025 08:47:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Matthias Fend <matthias.fend@emfend.at>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jingjing Xiong <jingjing.xiong@intel.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hao Yao <hao.yao@intel.com>,
	"bsp-development.geo@leica-geosystems.com" <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v5 2/2] media: i2c: add Himax HM1246 image sensor driver
Message-ID: <aQry_1Q9-QsSnNa4@smile.fi.intel.com>
References: <20251104-hm1246-v5-0-97c8f25b5419@emfend.at>
 <20251104-hm1246-v5-2-97c8f25b5419@emfend.at>
 <aQn_lguAdP-ZwCzK@smile.fi.intel.com>
 <PN3P287MB182902DE83B03F13D23CE9578BC5A@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3P287MB182902DE83B03F13D23CE9578BC5A@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 05:53:30AM +0000, Tarang Raval wrote:

...

> > > +static inline struct hm1246 *to_hm1246(struct v4l2_subdev *sd)

> > > +     return container_of_const(sd, struct hm1246, sd);
> >
> > It's unclear and confusing that _const() variant is used here.
> > Either const qualifier is missed somewhere, or _const is redundant.
> 
> The use of container_of_const() here is intentional and follows the direction 
> taken across multiple recent sensor drivers suggested by Sakari. 
> (e.g. ov2735, vd56g3, vd55g1, ov64a40, imx283).
> 
> AFAIK, using container_of_const() is a no-op for non-const 
> arguments,

I believe you want to say that it has no additional effect on the result or so.
Because it may not be a no-op, otherwise code won't work as expected.

> but keeps the helper type-safe and future-proof against 
> possible changes in the V4L2 API. This also maintains consistency with 
> other upstream drivers and avoids subtle warnings if any of the subdev 
> Callbacks later become const-qualified.



-- 
With Best Regards,
Andy Shevchenko



