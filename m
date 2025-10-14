Return-Path: <linux-kernel+bounces-852035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD35BD7FED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8110A4E78A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1059D30E0E7;
	Tue, 14 Oct 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4BLJ4BT"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363B23817D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428072; cv=none; b=nfVTd6vhhHyOPgdkJuQ8oBPFHZYhlZ6UIO9lt5WaATqCcZi3fqN3thSPIwWUt6IqzXmxCbr/6bgQlMvC7Ic3IHk3qLZ+LuW8rBr8ZECDlf9IWkw53IlIzpoILCTbvfxuMCFtVZpjd1kD7J+JlA6q36uducVoxe54yGJ3iTDL4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428072; c=relaxed/simple;
	bh=r6AqKWJgwKUzwfxb5aq/607KfDQIExWxJAMvO8wzI/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HzL077Lt4u3mKt0Hr5rSP+J/ReQeM3VkGBPJGVwbqE5YB43pbWfixWgws+bvpSduu2mfCC8JCW4yDfZhdYR7VM0PGMK8M97yZxjbGK25NqZ9dUim+X7c+AM/W9Py7YBgyxnBuAk7JXrmYlyPu6NktyoPTe7rV7KN606scGTGofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V4BLJ4BT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-426f1574a14so141662f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760428069; x=1761032869; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1BrabTRml53juPP0xOi+PNWI+Y0GuTwM8Zx3IM+NBw=;
        b=V4BLJ4BTQXG6ZCAZD8yaI68aZsStQYOF0ty4Dhnzpn82uMEb/3pVlD4sZsBJyN55WA
         tj+OvjQPh0KWIakSR9bK9FRNqZv+4JZXWqsXN1eX0y51Z5ET7D9upIv35J29z6cD6D/A
         CsdQf6RlMMatcgeWxHahGL8NVkrFqbYilSUDjb4awCV/0of2XHV9ETJCi+BNRMQ3Nw4H
         kykSmXO4mvRKn6iQEJfb7Bdeio2R373eN2TGBweBs9pHHxE7CKY0dcVp7BxeBpDpRF8B
         a8LfOAhIPIokW1EL90UdltZf1mFAZC7MODvsXaDtijuNJqOkwBdZmNYkse6zfuBaW1ra
         mKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428069; x=1761032869;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1BrabTRml53juPP0xOi+PNWI+Y0GuTwM8Zx3IM+NBw=;
        b=pYNHN+crp5PMK+IMAy+lecb1vexdH86NN2aVa+s+gswMXIxBzehEvcM+kCmTCavKj2
         v7Bhv4+w9ZC03F2f/kkUWu4P7HVJRyydaaqsJ5SxKCGXwBmrPUv64W+rWsIytCXAlC/5
         by+hwHnpmDhzhWLee6Nv177k8WGlZykVmEBkbV0a1jzZhJ+VaZRro1OI0lsU+LTTpiu/
         DwA80dacR2KiVc9qlfW+/shYQEyEZJ8b8uqMEsH2kvppQEiAgZAHduDfrNwkK9jN6/3a
         hocnlmZpj6fA83pqf4J42GNMur29I8OqYk5SB/HcOaIbPnnEW0ZfuY+YQEL673KWU64u
         I9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQamCgAXPft1QlqD11pLRFG8OHxm/4I82fcSkIwAVYvPb4qUiP1NnpDF2cSA9wiki6lu+vaG/hfhYIIQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55H4X9XEkbAONF4sRklUe1wync6N6rC+oUrAfMh4NVlXmtQDz
	TX0E5+8Gm7jF8JXGKv152wKPTjskoGZXb82FNYMtdy2TySuzrmGpVWxdp1Iqh/WjNl/xh0kdBIn
	D/Pnp
X-Gm-Gg: ASbGncsUQqq6uo1uDhC5ZSUGguifJocXhTh+C88Dptf1+L6t74f3DSysr8YSZCi+1Gv
	zvQxo95quJIHfXNKmLiYntYDtqY/26U4L+dpWiJAYAtN2Q2OyimJyTkfetpocYzIQjUJoGdMMxo
	A6Z2kM+IWEAfzFn9MACsNjICBKbjwLCGFwnrt3EmA09BXgSsdckZeh5mAHHWNfvzXSNlYdkLlkw
	chfXJNclTkXdxyynXitTFNmn2WprvhUclLWGDqyjt+NkT/51gCkDCIvTH/2DX6YzFp0WxPz8TAN
	BqospKxiUMk25XBXkUbg2K/CHkiVSMVl7Un7gtXVAqHkU8lP2yjMai5x20VPan6JuOtSP5qinsm
	weSvBZftkiuELUeECYJ6OFA35LIH4mx1VkWh+y06WbmLO+EE9Ix2AD2jkyCsgKg==
X-Google-Smtp-Source: AGHT+IFUVMZEfYJpXScC2Iy5d5OaSQsrDfLBO3OecJ1Qe7T9+o25udt9hW35VLFmJsih7IjcCxqwnQ==
X-Received: by 2002:a05:6000:4024:b0:3f9:6657:cdd with SMTP id ffacd0b85a97d-4266e7df967mr15000391f8f.38.1760428068639;
        Tue, 14 Oct 2025 00:47:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce57cc0esm22389410f8f.6.2025.10.14.00.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:47:48 -0700 (PDT)
Date: Tue, 14 Oct 2025 10:47:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Rex Lu <rex.lu@mediatek.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1651
 mt7996_msdu_page_get_from_cache() warn: can 'p' even be NULL?
Message-ID: <202510100155.MS0IXhzm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ec714e371f22f716a04e6ecb2a24988c92b26911
commit: b1e58e137b61693f12da037d2d50aca9c2140a43 wifi: mt76: mt7996: Introduce RRO MSDU callbacks
date:   3 weeks ago
config: x86_64-randconfig-161-20251009 (https://download.01.org/0day-ci/archive/20251010/202510100155.MS0IXhzm-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510100155.MS0IXhzm-lkp@intel.com/

New smatch warnings:
drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1651 mt7996_msdu_page_get_from_cache() warn: can 'p' even be NULL?

vim +/p +1651 drivers/net/wireless/mediatek/mt76/mt7996/mac.c

b1e58e137b6169 Rex Lu      2025-09-09  1641  static struct mt7996_msdu_page *
b1e58e137b6169 Rex Lu      2025-09-09  1642  mt7996_msdu_page_get_from_cache(struct mt7996_dev *dev)
b1e58e137b6169 Rex Lu      2025-09-09  1643  {
b1e58e137b6169 Rex Lu      2025-09-09  1644  	struct mt7996_msdu_page *p = NULL;
b1e58e137b6169 Rex Lu      2025-09-09  1645  
b1e58e137b6169 Rex Lu      2025-09-09  1646  	spin_lock(&dev->wed_rro.lock);
b1e58e137b6169 Rex Lu      2025-09-09  1647  
b1e58e137b6169 Rex Lu      2025-09-09  1648  	if (!list_empty(&dev->wed_rro.page_cache)) {
b1e58e137b6169 Rex Lu      2025-09-09  1649  		p = list_first_entry(&dev->wed_rro.page_cache,
b1e58e137b6169 Rex Lu      2025-09-09  1650  				     struct mt7996_msdu_page, list);
b1e58e137b6169 Rex Lu      2025-09-09 @1651  		if (p)

This NULL check is pointless.  We already ensured that the list is not
empty.

b1e58e137b6169 Rex Lu      2025-09-09  1652  			list_del(&p->list);
b1e58e137b6169 Rex Lu      2025-09-09  1653  	}
b1e58e137b6169 Rex Lu      2025-09-09  1654  
b1e58e137b6169 Rex Lu      2025-09-09  1655  	spin_unlock(&dev->wed_rro.lock);
b1e58e137b6169 Rex Lu      2025-09-09  1656  
b1e58e137b6169 Rex Lu      2025-09-09  1657  	return p;
b1e58e137b6169 Rex Lu      2025-09-09  1658  }


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


