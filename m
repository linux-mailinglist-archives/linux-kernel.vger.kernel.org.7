Return-Path: <linux-kernel+bounces-895492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808DAC4E185
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFBE3ACD75
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E147333ADAA;
	Tue, 11 Nov 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwrWKfIo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD31208994;
	Tue, 11 Nov 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867408; cv=none; b=UZ3um6bb99nXtLXSO8vKhMPNHb6aRYjH+rt2UnO50ldIedUYHGrunpnFqXGjvRruc55pJlg1NStSC8yDQKqFIuA67kuMDr/vWJbrf/6KVOT1wFDJcyVN5i0y8Iay5165NvaR02oxS8SaC3DMSbtbKqartjcbgufVWZXVrVfzhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867408; c=relaxed/simple;
	bh=DtSUEqPHMcd37gn1UQ9cal9KTI0sqP0crp3DvNbS9qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/DXCBDWT23vdDYFqcuGrubZLu1U8Uw8W+auR6Zv7oUEVk/0SjKqG8+ejd97pZP6/FS7sMUN1AZW9F30yyJO9EGyn5Sy3wm8edCl2UPN5FyYAXj0FR1pokGH2/udl3mWJGeFKWq9Lyq7xfWAflBddRbjdy34laNAAoMTMruV/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwrWKfIo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762867406; x=1794403406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DtSUEqPHMcd37gn1UQ9cal9KTI0sqP0crp3DvNbS9qg=;
  b=iwrWKfIonH0jo98765VtS3wBhrVSd9PN++EtQfpn8DhPjNs6ummDIIVA
   YMN3xoniXHLvtQMRB5pIA0fgnAWxKy/oSIdZOoKRh5tzSyyiKaVmq7zCV
   3JWLC47eM1YwbLJcuuzAOaRduuPR1mCpBiIt+rfPcVCN5YHp3nRDlsPiw
   KgGRNHfq9R/IG3j0raLYcBdUnrVWbvlqCk2lTyziMcgJ6K//Pw/E79zCn
   d03mP0pUqK7SG09ad9/F5RTo6xsF9EV/quqwbI99XgL6upZxibLxlBaZ8
   Cs5u8zReCc2d0q83JQbZOeGTZ7v0+lWVfkHCYPt8O+kFViK4UqNfYilSs
   A==;
X-CSE-ConnectionGUID: fzgA9MaWRT6LYihRrah12A==
X-CSE-MsgGUID: Q/tRxqbxQWCJiM4sM18aNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64628783"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64628783"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 05:23:25 -0800
X-CSE-ConnectionGUID: EmBczYoySjaVYg6v8qgVBg==
X-CSE-MsgGUID: S+0Cr7irSLSB2/SIvvuigA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188218935"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.96])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 05:23:22 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7FA5111F983;
	Tue, 11 Nov 2025 15:23:19 +0200 (EET)
Date: Tue, 11 Nov 2025 15:23:19 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hansg@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
	Tarang Raval <tarang.raval@siliconsignals.io>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] media: i2c: add Sony IMX111 CMOS camera sensor
 driver
Message-ID: <aRM4x7SbdbxMYLCi@kekkonen.localdomain>
References: <20251103145629.21588-1-clamor95@gmail.com>
 <20251103145629.21588-3-clamor95@gmail.com>
 <aRMw_Qre1FY94soi@kekkonen.localdomain>
 <CAPVz0n1MokJq6d4s0cS3UdevRt2n-HaicPpwiBu=3HVSKfnzfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1MokJq6d4s0cS3UdevRt2n-HaicPpwiBu=3HVSKfnzfg@mail.gmail.com>

On Tue, Nov 11, 2025 at 02:53:52PM +0200, Svyatoslav Ryhel wrote:
> вт, 11 лист. 2025 р. о 14:50 Sakari Ailus <sakari.ailus@linux.intel.com> пише:
> > I can make the two changes before applying, too, if that's ok.
> 
> If you don't mind adjusting commit on your own before applying I have
> no objections. Thank you very much!

The diff is:

diff --git a/drivers/media/i2c/imx111.c b/drivers/media/i2c/imx111.c
index c269e9fdcb0b..8eb919788ef7 100644
--- a/drivers/media/i2c/imx111.c
+++ b/drivers/media/i2c/imx111.c
@@ -1136,13 +1136,6 @@ static int imx111_set_format(struct v4l2_subdev *sd,
 
 	fmt = v4l2_subdev_state_get_format(state, format->pad);
 
-	fmt->code = imx111_get_format_code(sensor, mbus_fmt->code, false);
-	fmt->width = mode->width;
-	fmt->height = mode->height;
-	fmt->colorspace = V4L2_COLORSPACE_RAW;
-
-	*mbus_fmt = *fmt;
-
 	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE)	{
 		int ret;
 
@@ -1183,6 +1176,13 @@ static int imx111_set_format(struct v4l2_subdev *sd,
 			return ret;
 	}
 
+	fmt->code = imx111_get_format_code(sensor, mbus_fmt->code, false);
+	fmt->width = mode->width;
+	fmt->height = mode->height;
+	fmt->colorspace = V4L2_COLORSPACE_RAW;
+
+	*mbus_fmt = *fmt;
+
 	return 0;
 }
 
@@ -1542,9 +1542,9 @@ static int imx111_probe(struct i2c_client *client)
 		goto error_pm;
 	}
 
-	pm_runtime_idle(dev);
 	pm_runtime_set_autosuspend_delay(dev, 1000);
 	pm_runtime_use_autosuspend(dev);
+	pm_runtime_idle(dev);
 
 	return 0;
 
Hopefully that works!

-- 
Regards,

Sakari Ailus

