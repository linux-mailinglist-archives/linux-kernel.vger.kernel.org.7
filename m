Return-Path: <linux-kernel+bounces-807980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4337FB4ABA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A2D3ACBE1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E33218B1;
	Tue,  9 Sep 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rwth-aachen.de header.i=@rwth-aachen.de header.b="TIaMCPI7"
Received: from mail-out-3.itc.rwth-aachen.de (mail-out-3.itc.rwth-aachen.de [134.130.5.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE931D72A;
	Tue,  9 Sep 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.130.5.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416772; cv=none; b=ofvk3F01isOXNpybYoU6zgtOXnOKIuzxWedPVhlXsbT4fKUJcp1u32QAcUuiqSAX7+dtzNgqLwO9UCHYTclAL0HtuIt5zT8Nz0LC2FaamlUzP6rOisPMRAL7baCtmhXhjmY8Vfp4sS8nEay3e581joAhdJ+78Rw8aH+/ZqxfzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416772; c=relaxed/simple;
	bh=1P+ZrNe5SqDuDrHn2ZCxT6bCqkhzSrtwuPJKZgG8f7I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=tJJECiVN49pdaKXRN6K6vzXJRdMwoUshA+HzyjKhDZWlrudKAd3OhqZhE92un046WT8g2ryHCeixR8nCk3dYDT/zQ1DY8lfdrH1N7Uxc8K7P+lUX9YgeLjWSmW2InlBQnkz+mnjizOnrIHd87izkPsskB7oDyxsJouP1MrLgGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rwth-aachen.de; spf=pass smtp.mailfrom=rwth-aachen.de; dkim=pass (2048-bit key) header.d=rwth-aachen.de header.i=@rwth-aachen.de header.b=TIaMCPI7; arc=none smtp.client-ip=134.130.5.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rwth-aachen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rwth-aachen.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
  s=20240516-RWTH; t=1757416768; x=1788952768;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=1P+ZrNe5SqDuDrHn2ZCxT6bCqkhzSrtwuPJKZgG8f7I=;
  b=TIaMCPI7gaum302xwDGCXridbmSXA5Cuq4t1Y/s4kqWg2HJS3poPCFvb
   OaxnKSgbRmAts9tVEFYYMJosFrGiU47h2MF8d72z7B3J8H+5IIxLA7ezv
   jutjLA+1TOvjVLNHtTyNXk8jRiR6236v2QreijDHFtqxGPFU0ALfP7nAd
   X4fSaprtEhHMoYPi6HdyVLQKQhSPvG0zNBkz1Wk+n5nhrusQFxTrQ7h1d
   hKBEad+V+jyT2KcUWoNKZvsrlwTujms2MnI73J2y9+DIvuKZZBmM1DiBZ
   bsCp0S/+MGbk0fXrlVTCjKZoH7UrdLofeG+vrhRCIpsUQts1Sk07/XqrT
   g==;
X-CSE-ConnectionGUID: hiJebw+cRoSGOKhdqH9siQ==
X-CSE-MsgGUID: JLCnfXVpQuKVR39IVr0Ijg==
X-IPAS-Result: =?us-ascii?q?A2B0BAAFnnto/5oagoZaHgE8DAILFYFTiX2RcQOUBYcuh?=
 =?us-ascii?q?GQPAQEBAQEBAQEBCAFRBAEBghOCdAKMEig3Bg4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEGAQEBAQEBBgWBIYU1U4ZbAQQBIw8BBUEFCwsaAiYCAlYGAQ0HA?=
 =?us-ascii?q?QGCfoJLJLEYgTKBAYR92TuBSiMJAYERLoVtgmQBgW2DfzuEPDaBVUSBPIMDP?=
 =?us-ascii?q?oQtg3GCaQSCIoEWileGE4d8CUl4eCwBVRMXCwcFgSBDAyo0MSNLBS0dgSd+h?=
 =?us-ascii?q?BiEKCtPgiJ1gRBpQRk/g1MeBm0PBoEYGkoCAgIFAkNFd0ACAQttPTcJCxuXb?=
 =?us-ascii?q?BCCDAE4Cy8DkySCcAGvaTQHgjiBZ4FeBpZZiR4GQpdfkwqZBiKocgIEAgQFA?=
 =?us-ascii?q?hiBflGBLnGDN1EXAg+OLRbFYIEyAgcBCgEBAwmOUoF8AQE?=
IronPort-Data: A9a23:p9rzE68j8lDvQCivQzleDrUDWH6TJUtcMsCJ2f8bNWPcYEJGY0x3y
 WcaC2zUM62DM2vyLYt+Oonl8EpX6MCDmtQ3SlY//n9EQiMRo6IpJzg4wmTYYnnOdJ2TFCqLy
 +1EN7Es+ehtFie0Si+Fa+an9T8lk/nRF9IQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8hVaYDkpOs/je8Ew27ayr0N8llgVWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ais7XBtJFAatko2nhc+RK9
 Tl4ncfYpTEBY/eQwrRNC3G0JAklVUFO0OevzXFSKqV/xWWeG5fn660G4E3boeT0984vaVyi+
 8D0JxgNbzKOjf31y4i8ccZLpcQvNem6J4Im7yQIITHxVZ7KQLjZXLnK6M8dx211j4ZUAureI
 sMVLzZiBPjCS0QUZhFOU8p4xrnu3ySjG9FbgAv9Sa4f+GnWywo31rXwPdzVc8GRSMN9hFmEp
 ifP9m/5DxdcONH3JT+tqCPx3b6Qx3+rMG4UPJ+c3fhksGOL/3EwNidNBHqFu6GYiEHrDrqzL
 GRRoELCt5Ma+EWtT9T5GRS8pXOFshc0UN1UF+Qw7xuEjKHT5m6xAmkCUy4Ea9E8ssIybSIl2
 0XPnN7zAzFr9rqPRhq197iTt3WxPjISMW4EIysFSxYVy9bmqYA3yBnIS75LFeiqj9n+CyD22
 DOLhDM3gq4Oi8FN3KK+lXjbhj22oYPSZhMw5w7XGG+p82tRbYqkbIGy+FjfxflHK4mdQx+Ku
 31ss8HY7OEIAZuKjiOlQ+gXGrytofGfP1X0m0N0A9wv8C7o/3+lYJB4/j5zPgFqP9wCdDuvZ
 1Xc0StV44RIPX2CbqJtZY+1TcMwwsDIGt3/R9jbZ8BfbYV2MgmK4ElGb0mJwmarnkUqnokwP
 J6adYCnCnNyIa1jwSrwSO4M17gx7i87zGLXA5v8ynyP1riTaHe9SrofNlaKKOcj48usrx/Y/
 NVfH8+LzQhPXurjZCXe7Y8UKxYNN3dTLZz/qNZ/deOZJAdiXmY7BJf5y7EmYYo+qKtVvv/S+
 W26XEpRyV65jnrCQS2Oa3Z+ePbyRpxXs302J2ovMEyu1nxlZpyghJrzbLMtYqUn+fwm1qQxR
 r8fZNmAR/1DDDjKk9gAUaTAQEVZXEzDrWqz0+CNOVDTo7YIq9T1x+LZ
IronPort-HdrOrdr: A9a23:OVZ7sq/khJmajasM1Hduk+DvI+orL9Y04lQ7vn2YSXRuA6+lfr
 OV7ZEmPHjP+VAssRAb6Le90ca7LE80maQa3WBVB8bHYOCEggeVxeNZh7cKqgeIc0bDH6xmpM
 VdmsBFeaTN5DNB7PoSjjPZLz9t+ra6GPfCv5ak8547d3ATV51d
X-Talos-CUID: 9a23:xxbi72Pz/mnp/O5DWChF+UQLWcsfdUby61TQL1aYWH1ocejA
X-Talos-MUID: 9a23:wcA7VQqPoQ1z/64acHsezxNGH8Fm05q2MV0ur69d6ui6L3RROTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,324,1744063200"; 
   d="scan'208";a="295397248"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
  by mail-in-3.itc.rwth-aachen.de with ESMTP; 09 Sep 2025 13:19:20 +0200
Received: from [IPV6:2a00:8a60:c000:1:6109:d098:ebb8:aa0]
 (2a00:8a60:c000:1:6109:d098:ebb8:aa0) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Tue, 9 Sep
 2025 13:19:19 +0200
Message-ID: <3aca9e74-b67c-4bfe-a206-9a6eecdf76ab@rwth-aachen.de>
Date: Tue, 9 Sep 2025 13:19:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Simon Neuenhausen <simon.neuenhausen@rwth-aachen.de>
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
To: Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich
	<dakr@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Michal Wilczynski
	<m.wilczynski@samsung.com>, Igor Korotin <igor.korotin.linux@gmail.com>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
 <9657C897-087E-4544-849B-964E99D95A50@collabora.com>
 <DCLTJMIAMCVL.35U236MMS5CCK@kernel.org>
 <85B643A9-1657-43ED-BE98-BE7E502D08DA@collabora.com>
Content-Language: en-US
In-Reply-To: <85B643A9-1657-43ED-BE98-BE7E502D08DA@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)

Hi,

> On 06.09.25 17:46, Daniel Almeida wrote:

> As I said to Greg above, I’m here to help if anyone wants to write a USB driver. Those interested 
are free to reach out to me and we will work together to merge the 
required abstractions with a real user in mind. Hopefully this 
encourages others to join in this work :)
I had planned on writing a USB driver for TI nspire calculators, that 
would make them mountable as USB mass storage devices, since they use a 
proprietary USB protocol, that usually requires paid software from TI. 
At the time I gave up on that, due to the lack of USB support in RFL, 
but I could revive the effort using this.

I'll admit that this is pretty gimmicky, but if it helps to get this 
merged, I would be happy to do it.

Greetings

Simon Neuenhausen

