Return-Path: <linux-kernel+bounces-808305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C69B4FDA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 978197B36F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A12353341;
	Tue,  9 Sep 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WW7uhxoV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2E3431E3;
	Tue,  9 Sep 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425245; cv=none; b=usu+F5lmqCwp0LREkCwMZZRDm7Fv7V/CtYbKvon6hDANBbY0oIOuk/MkYXAOCwGx/s7TkE34uWFuFJUGMqfZ9zc6ZGgusrQEl3hW8M3ctN3OueaL3kM7g6X4GzpyVxWKh8cRsiY8gZTx4I4W4t1OGARGVjUy1K5ejiBX/cuxKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425245; c=relaxed/simple;
	bh=TOKivSYM8AaGjR0sjfOBNZldzL9uNMrmIjNBs/jU5RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnLwaRfUCyPIcnEZQr1cuLxxFc61JvuAmK/8LGkrMr2i3gE9bO8Jsv8r+8r3hGlhQFtawLJ3Zfq8M9SyqLg3kMMLlA4UKOXHvqU5bo1EAfXYjnr3rz3VihSCHq74FlfnIQiFYdvr50c4hmfh7PlvZdR1EgUBCnjTQxshPDK0xUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WW7uhxoV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757425243; x=1788961243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TOKivSYM8AaGjR0sjfOBNZldzL9uNMrmIjNBs/jU5RA=;
  b=WW7uhxoVB7QPgwqIb+11dZUg0iX6qtQ0iWtJrvQMt8RIs4+W5NNnxVAV
   iim+eGH+JPHm3NP8Dghn1kUDSOg+RthFrpvh2wP7pDG80hMi9IZJ7vZce
   hHLdrNkpyTbZX0rMOQFDyxrNEb5mXwlcAjQOL2F7ppTYlQCqNjczb9YtC
   jJ6d//FQk+h7u+pl6uK34uE+ZQUCovAKsz94VkddglZt++zp5ea3H7Iyu
   YvIkfuvYjb2b2Kcn7IH941RifvTznm+6uldur2aMcSFmwsPoE9xjlC2nU
   B87i3VGKcSgqCb556cuBpVwPDNRpCpR/NRw6n7mlbh5X+d6P291vP29QU
   Q==;
X-CSE-ConnectionGUID: E6O9lpPPSUeOCoJzQrf9rQ==
X-CSE-MsgGUID: 7gNU33OKQP6ZfrrQ3yml8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59854826"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="59854826"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 06:40:43 -0700
X-CSE-ConnectionGUID: d5jyn5U6RTqDwtadbZsjtg==
X-CSE-MsgGUID: 3dTjMfjGQGi/s8TDcuomyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="204075081"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 06:40:42 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/xe/hwmon: Use devm_mutex_init()
Date: Tue,  9 Sep 2025 06:40:26 -0700
Message-ID: <175742518952.1517056.6092120545087383831.b4-ty@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <989e96369e9e1f8a44b816962917ec76877c912d.1757252520.git.christophe.jaillet@wanadoo.fr>
References: <989e96369e9e1f8a44b816962917ec76877c912d.1757252520.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 07 Sep 2025 15:42:17 +0200, Christophe JAILLET wrote:
> Use devm_mutex_init() instead of hand-writing it.
> 
> This saves some LoC, improves readability and saves some space in the
> generated .o file.
> 
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   36884	  10296	     64	  47244	   b88c	drivers/gpu/drm/xe/xe_hwmon.o
> 
> [...]

Applied to drm-xe-next, thanks!

[1/1] drm/xe/hwmon: Use devm_mutex_init()
      commit: 7b77941724628e6171a286edbf04d67a1f1c1459

Best regards,
-- 
Lucas De Marchi


