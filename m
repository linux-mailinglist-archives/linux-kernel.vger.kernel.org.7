Return-Path: <linux-kernel+bounces-878764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B3BC216F2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD648461621
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAD325705;
	Thu, 30 Oct 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcwLuiIN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5B3BBF2;
	Thu, 30 Oct 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844470; cv=none; b=KCQKAA56qlu52E0AvKQ8GHqo/75A/5oFhqwD+iW1UHUiZQ9xjmWJnZaqGBD3c8OU1K+UqQ9q3xHdhoZPQVF0aGDR7VdrXUubGuSZwSUOUc3oy+lQONojTR1lOQWtjcIaE5Bu/05FDs2ehByseLgwergMZgQ6fDERu1OBZoQcph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844470; c=relaxed/simple;
	bh=dOQ7RyggXLz+Bco9hcUhv4zdopMrkMyQ9gG2BmgTGIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eGiRzFn7F9WC8H2mGyVGl8IjtS/7Y2WdPVlY1K//MMwvL1yotGz/Htxd3CoSqjHOM/y0SUf6x7uX0tEf/ISxW/MM46Fzl8BLLyvj/eKcae/ZqnG71Y1FbxBor6WUP4PWJAXVXmGYh9VFKJ7UEj2aH8elp+wwFTr1F2uikbw3kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcwLuiIN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761844468; x=1793380468;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=dOQ7RyggXLz+Bco9hcUhv4zdopMrkMyQ9gG2BmgTGIM=;
  b=lcwLuiIN6EJp7mIOmBCZpfU8+aua8ODSEF0IV5uhL0QqH600zWJSy/qi
   hibI5CwWpmEQ65ZRQ9hxZtjocSidbHXdDAPdxt7zuNYSp15YQDEOUdkYJ
   zs5fHb4kmlTmCBmKCp8wzKIrSDysYw+W5HHx0bC7VWDfeW3RVevORgP3b
   XTMeiStAcbZvpj/nSSRhzB6T+I2FT29jBoR/ljOBmmJuLE8Pd2FBPZdX1
   ERTQLe8TDQw9Z8j/yxPyFDo/j/xX1revMPJ2ws46h3qDFmVIlbSZOd3tP
   WL8QmjFyt797qEIcfg5jbleS7WNfOUdxStpzuDtVMQo/+DTa3asDlrhD5
   w==;
X-CSE-ConnectionGUID: ofKBcoWpQnqGQ1gO7R6YYw==
X-CSE-MsgGUID: 3G6QfNruQjWMKemj6zr9TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81622961"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="81622961"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:14:27 -0700
X-CSE-ConnectionGUID: fOxHfABhTwCclH0/t2tOYA==
X-CSE-MsgGUID: oBKnwXkERNe7BDfY5uW58w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="186353670"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.175])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:14:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: jlee@suse.com, basak.sb2006@gmail.com, faiz.faadhillah@gmail.com, 
 rayanmargham4@gmail.com, Armin Wolf <W_Armin@gmx.de>
Cc: kuurtb@gmail.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251016180008.465593-1-W_Armin@gmx.de>
References: <20251016180008.465593-1-W_Armin@gmx.de>
Subject: Re: [PATCH v4 0/4] platform/x86: acer-wmi: Add fan control support
Message-Id: <176184445966.9294.1634498748221184246.b4-ty@linux.intel.com>
Date: Thu, 30 Oct 2025 19:14:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 16 Oct 2025 20:00:04 +0200, Armin Wolf wrote:

> This patch series aims to add fan control support to the acer-wmi
> driver. The patches are compile-tested only and need to be tested
> on real hardware to verify that they actually work.
> 
> I CCed three users who requested support for this feature. I would be
> very happy if one of you could test those patches and report back.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] platform/x86: acer-wmi: Fix setting of fan behavior
      commit: d8e8362b09d31b0a343c0414015d93fbb250d57d
[2/4] platform/x86: acer-wmi: Add fan control support
      commit: 0cc5153f133919bf1e41f3d4c176839aa846d1e0
[3/4] platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
      commit: d727823c134a79f28f16543aec4dced646a1f793
[4/4] platform/x86: acer-wmi: Add support for PHN16-72
      commit: 45cf02f298f33e1c582f77c08bf6d61daf163f27

--
 i.


