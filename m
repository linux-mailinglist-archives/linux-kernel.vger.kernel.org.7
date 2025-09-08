Return-Path: <linux-kernel+bounces-805615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFF6B48B12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB1341B26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A22FB093;
	Mon,  8 Sep 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhF/1Tlk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618292FB08D;
	Mon,  8 Sep 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329436; cv=none; b=ImcheaLuyN1IejwW//nD39OSi2jSBTrpkt0O2JmTkCyQIPzwAngcQzkZF0Za/zIyELGTEOF2/lhFRDVPYsBT+bFGhaCyV+NNxpPDCb7T/BeLMWr7IBwQD0bL+lxOCMSe3WaejA9VdrE6jlA4oKYVLaoGVWoHa9OUxePqBXOZb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329436; c=relaxed/simple;
	bh=3dqcemedClx68uAGeZQS7UWOgcFnTMM2pGWwRIX9XOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFLuiW/jjiWA7RPJ4C8V2w7N46D1y4yvMpYI/ynJGGOTEpNEu5j76/m2colsPmSOnOXODC394EINw0nR1ujsyXHqgMvcq/Rf0ceB81N5+lkGhdr7UXvOSkUfZASjzu1E9+lqfNgPFPWB5hyWuX77BhhvfKSE0/kTAmdEEWpJQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhF/1Tlk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757329435; x=1788865435;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3dqcemedClx68uAGeZQS7UWOgcFnTMM2pGWwRIX9XOY=;
  b=LhF/1TlkKgAjdhHX+dTwzbVv7rpWZIIymrq5ZoHTgdjJHrKuPgXsTlE0
   sMohcIlnVv3g0NSW0pp7CFdcpQ+Dmw/1FipLZ25UlCcchdt8KVl1BR7M7
   C1VUPt4Po7tAzEXWGp9uyKONQXbryhC5bCm2yc3irTLMW/UtjUhNRcG2t
   QdSLzarqVfi0Dhel69XGCQbi19iDtTALe980J/oKFvMrkn/9yORSKsHGN
   J+FzMIj2yz+XKrWLsoiH6F89bvdkvrar7iJKTDiOLipKXumUgSQEFABPc
   SKF43+0QWTrj6jXifQTNaCBETcZABi6u3VmqEoPuu5Noz3sf1e3TdbzZp
   A==;
X-CSE-ConnectionGUID: Sk09mvNETvaZMuYUA4Tlbw==
X-CSE-MsgGUID: zrLyB7tQThuq3r5vk1+TcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="70960712"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="70960712"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:03:54 -0700
X-CSE-ConnectionGUID: t2zGP7lPTUGzuyMfHSqnTQ==
X-CSE-MsgGUID: re4nqNyiQPG37gmTOTCDPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="172349127"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.204])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:03:48 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: syyang <syyang@lontium.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, syyang <syyang@lontium.com>
Subject: Re: [PATCH v1 2/2] This patch adds a new DRM bridge driver for the
 Lontium LT9611C chip.
In-Reply-To: <20250903123825.1721443-3-syyang@lontium.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250903123825.1721443-1-syyang@lontium.com>
 <20250903123825.1721443-3-syyang@lontium.com>
Date: Mon, 08 Sep 2025 14:03:45 +0300
Message-ID: <52330c2afbf6bab7c06fbdd2b5cb9b2a4e24319b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 03 Sep 2025, syyang <syyang@lontium.com> wrote:
> +static int lt9611c_read_edid(struct lt9611c *lt9611c)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret, i, bytes_to_copy, offset = 0;
> +	u8 packets_num;
> +	u8 read_edid_data_cmd[5] = {0x52, 0x48, 0x33, 0x3A, 0x00};
> +	u8 return_edid_data[37];
> +	u8 read_edid_byte_num_cmd[5] = {0x52, 0x48, 0x32, 0x3A, 0x00};
> +	u8 return_edid_byte_num[6];
> +
> +	ret = i2c_read_write_flow(lt9611c, read_edid_byte_num_cmd, 5, return_edid_byte_num, 6);
> +	if (ret) {
> +		dev_err(dev, "Failed to read EDID byte number\n");
> +		lt9611c->edid_valid = false;
> +		return ret;
> +	}
> +
> +	lt9611c->edid_len = (return_edid_byte_num[4] << 8) | return_edid_byte_num[5];
> +
> +	if (!lt9611c->edid_buf || lt9611c->edid_len > (lt9611c->edid_valid ?
> +				lt9611c->edid_len : 0)) {
> +		kfree(lt9611c->edid_buf);
> +		lt9611c->edid_buf = kzalloc(lt9611c->edid_len, GFP_KERNEL);
> +		if (!lt9611c->edid_buf) {
> +			dev_err(dev, "Failed to allocate EDID buffer\n");
> +			lt9611c->edid_len = 0;
> +			lt9611c->edid_valid = false;
> +			return -ENOMEM;
> +		}
> +	}

If you want to do caching, store a struct drm_edid pointer at a higher
level, not dumb buffers at the low level. Might be easier to start off
without any caching.

> +
> +	packets_num = (lt9611c->edid_len % 32) ? (lt9611c->edid_len / 32 + 1) :
> +		(lt9611c->edid_len / 32);
> +	for (i = 0; i < packets_num; i++) {
> +		read_edid_data_cmd[4] = (u8)i;
> +		ret = i2c_read_write_flow(lt9611c, read_edid_data_cmd, 5, return_edid_data, 37);
> +		if (ret) {
> +			dev_err(dev, "Failed to read EDID packet %d\n", i);
> +			lt9611c->edid_valid = false;
> +			return -EIO;
> +		}
> +		offset = i * 32;
> +		bytes_to_copy = min(32, lt9611c->edid_len - offset);
> +		memcpy(lt9611c->edid_buf + offset, &return_edid_data[5], bytes_to_copy);
> +		}

And really, you wouldn't have to implement the custom get edid block at
all, if you added a proper i2c adapter implementation and passed that to
drm_edid_read_ddc().

> +
> +	lt9611c->edid_valid = true;
> +
> +	return ret;
> +}
> +
> +static int lt9611c_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
> +{
> +	struct lt9611c *lt9611c = data;
> +	struct device *dev = lt9611c->dev;
> +	unsigned int total_blocks;
> +	int ret;
> +
> +	if (len > 128)
> +		return -EINVAL;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +	if (block == 0 || !lt9611c->edid_valid) {
> +		ret = lt9611c_read_edid(lt9611c);
> +		if (ret) {
> +			dev_err(dev, "EDID read failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	total_blocks = lt9611c->edid_len / 128;
> +	if (!total_blocks) {
> +		dev_err(dev, "No valid EDID blocks\n");
> +		return -EIO;
> +	}
> +
> +	if (block >= total_blocks) {
> +		dev_err(dev,  "Requested block %u exceeds total blocks %u\n",
> +			block, total_blocks);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(buf, lt9611c->edid_buf + block * 128, len);

The get edid block hook is supposed to read *one* block. Can't you
implement reading one block? This now reads the entire edid for every
block.

Again, better yet, i2c adapter implementation.

> +
> +	return 0;
> +}
> +
> +static const struct drm_edid *lt9611c_bridge_edid_read(struct drm_bridge *bridge,
> +						       struct drm_connector *connector)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +
> +	usleep_range(10000, 20000);
> +	return drm_edid_read_custom(connector, lt9611c_get_edid_block, lt9611c);
> +}

-- 
Jani Nikula, Intel

