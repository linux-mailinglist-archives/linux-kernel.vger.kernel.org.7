Return-Path: <linux-kernel+bounces-808221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF1BB4FC0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71C51C237EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEFC33EB1A;
	Tue,  9 Sep 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rwth-aachen.de header.i=@rwth-aachen.de header.b="lXYXjcMn"
Received: from mail-out-4.itc.rwth-aachen.de (mail-out-4.itc.rwth-aachen.de [134.130.5.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40B3314C1;
	Tue,  9 Sep 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.130.5.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423193; cv=none; b=e5bRoVrzlXAfmGgtF83f+fnRCfFMf/ddtmUDCWCg/Yo12UR8SB1e/OgZVdCII6CcBZUX5ESgy5OkKMcV/usNZeOfp7zHaWMU7dSjuJWm/bulAa2Wg4GHm5/3ZS7m17dwDVvw8WGaC1d3TPsgkiK1su/UcA6CbQVeMGG23eZdun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423193; c=relaxed/simple;
	bh=O14MT3OexWqSwE6jX8bgZKElE6VAnUMMz4AXWZjD7xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sPSu6BodTlT/Ws/YHkHCNgh4outl0GApRNia3eCQbdnjgIVknlr6T8ZBIMSJK8P9LJms9gd/VESwUPf2yPNzQpPGQLWNnmMeep8A2tix9f2W1Elw2e7+P9V2j9Fo3BCuiVNvfhSV0zxZPwULcNd7T3zZ77GBOBIC5tRFg5bShhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rwth-aachen.de; spf=pass smtp.mailfrom=rwth-aachen.de; dkim=pass (2048-bit key) header.d=rwth-aachen.de header.i=@rwth-aachen.de header.b=lXYXjcMn; arc=none smtp.client-ip=134.130.5.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rwth-aachen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rwth-aachen.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=rwth-aachen.de; i=@rwth-aachen.de; q=dns/txt;
  s=20240516-RWTH; t=1757423190; x=1788959190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O14MT3OexWqSwE6jX8bgZKElE6VAnUMMz4AXWZjD7xk=;
  b=lXYXjcMn+amozPOZf1PeKL3bmuIyZZJx8VuVXnPBDCErjJnppjnGwp0k
   f79xdbYk3re/LJfaNfVtjwsp3lOej0JXz8/AWXTiTDoLVRVFlDf/gNesf
   1zklWR727TdpZ4LVrh61IA9ZWfZiN5UE8Q+qXbIjYrH5PnrQ3p6BlUH0G
   ZeEyQZWOybJBj6rugLv8INvKqOczbO+Fdm99B1wclttayAW+XJoSlvthI
   pMGW6JlVlcjxxmsQPXmB5bz3nZrelcb5ZcrMgEmcbKyPih+bYQitZQq5i
   wOaR0qukQKRFwThDN7VaC1zjlDcdmhQgUvdbHcaOQJGM0509XXJvmZnII
   w==;
X-CSE-ConnectionGUID: BAjXdRxMRHOmUpuF/WAxHw==
X-CSE-MsgGUID: 8nctHbJ+RlC6+eGCBY8/Ag==
X-IPAS-Result: =?us-ascii?q?A2AaEACAnnto/5oagoZaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VMCiXuRcQOUBYcuhGQPAQEBAQEBAQEBCAEUPQQBAYITgnQCjBIoNwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQEBCwEBBgEBAQEBAQYFgSGFNVOGWgEBAQECASMPA?=
 =?us-ascii?q?QVBBQsJAhgCAiYCAlYGDgcBAYJ+gksklEubS3qBMoEB3jiBSiMJAYERLgGFb?=
 =?us-ascii?q?IJkAYFtg3+EdzaBVUSBFSeDAz6ELYNxgmkEgiKBFopXhhOHfAlJeHgsAVUTF?=
 =?us-ascii?q?wsHBYEgQwOBDyNLBS0dgSd+hBiEKCtPgiJ1gRBpQRk/g1MeBm0PBoEYGkoCA?=
 =?us-ascii?q?gIFAkNFd0ACAQttPTcJCxuXWROBaTECAS4KCy8DkySCcAGvaTQHgjiBZ4FeB?=
 =?us-ascii?q?pZZiR4GQpdfkwqZBqkUAgQCBAUCGIF+gX9xgzdRFwIPji0WxWeBMgIHAQoBA?=
 =?us-ascii?q?QMJjlKBfAEB?=
IronPort-Data: A9a23:HAko+K+1YcrWZsWk5/KSDrUDWH6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 TRJXW2POPiMa2Kkcttzb9yz/EwEvJTQm9NlTAtl+ytEQiMRo6IpJzg4wmTYYnnOdJ2TFCqLy
 +1EN7Es+ehtFie0Si+Fa+an9T8lk/nRF9IQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8hVaYDkpOs/je8Ew27ayr0N8llgVWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ais7XBtJFAatko2nhc+RK9
 Tl4ncfYpTEBY/eQwrRNC3G0JAklVUFO0OevzXFSKqV/xWWeG5fn660G4E3boeT0984vaVyi+
 8D0JxgnRxKzi9im5YibbexRntkNa/bCLKMA7yQIITHxVZ7KQLjZXLnK6M8dx211j4ZUAureI
 sMVLzZiBPjCS0QUZhFOU8p4xrnu3ySjG9FbgAv9Sa4f+GnWywo31rXwPdzVc8GRSMN9hFmEp
 ifP9m/5DxdcONH3JT+tqCL027SRxHyqMG4UPO2+/eJKin/Q/Gg4Vl4benCRkKn+o0HrDrqzL
 GRRoELCt5Ma+1amQdr9dxm5pmOUsBkBXdZZD+w97keK0KW8ywKYAHUUCz1MctorsOcoSjEwk
 FyEhdXkAXpoqrL9YXOS8a3SrjSoPjQUKykGZCkZXSMK5tDipMc4iRenZtMlD6+xhc/kHyrzw
 hiRpS0lmrMcy8UM0s2T4VXImTW3vbDUSw8+5kPaUn/Nxgp9ZYWofZ2o7XDU6vFPKIvfRV6E1
 FAN3cif6uwECouCvC+AWuMAGPeu/fntGCfBmkIqEZ47sjCs/WOzVZ5f7Ss4J0pzNMsAPzjzb
 yf7vQRK/55VFHind6l6Z8S2EctC5afpD8XNWfnOf9VTZd53eRPv1CtpfFOWmW7glkcEnqQ2O
 JPdesGpZV4TDal3ijW/VuEay5ckwyk/wSXYQpWT5xOl3LaXTH2YU7EINB2JdO9RxK+Nox/98
 NtFMcaOjRJFX4XWbiDR8IMXa1kOKHU6CZneoMtTcueJJRBvXmomDpf5y7EmYYo+qKtVvv/S+
 W26XEpRyV65jnrCQS2Oa3Z+ePbyRpxXs302J2ovMEyu1nxlZpyghJrzbLMtYqUn+fwm1qQxR
 r8fZNmAR/1DDDjKk9gAUaTAQEVZXEzDrWqz0+CNOVDTo7YIq9T1x+LZ
IronPort-HdrOrdr: A9a23:2BZ1U6H3IWKAxSgZpLqE+ceALOsnbusQ8zAXPo5KJyC9Ffbo8v
 xG/c5rtyMc5wx6ZJhNo7290cq7MBDhHPxOgLX5VI3KNGLbUQCTQ72Kg7GP/9StIU3DytI=
X-Talos-CUID: =?us-ascii?q?9a23=3AivFpomtKtnli3IPuAW8Bxz2/6IsPW3/twE3ABnW?=
 =?us-ascii?q?YLmNUUKC7DmC56IN7xp8=3D?=
X-Talos-MUID: 9a23:Av+LFggw9dJnXc50FOa/5MMpZMFj/4SkKgM3lb5Y+MSrHgZBa3C0g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,324,1744063200"; 
   d="scan'208";a="280536179"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
  by mail-in-4.itc.rwth-aachen.de with ESMTP; 09 Sep 2025 15:05:18 +0200
Received: from [IPV6:2a00:8a60:c000:1:6109:d098:ebb8:aa0]
 (2a00:8a60:c000:1:6109:d098:ebb8:aa0) by rwthex-s2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Tue, 9 Sep
 2025 15:05:17 +0200
Message-ID: <03b0cd37-4b05-4b5e-a395-5e5d405e1b20@rwth-aachen.de>
Date: Tue, 9 Sep 2025 15:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich
	<dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Michal Wilczynski <m.wilczynski@samsung.com>, Igor
 Korotin <igor.korotin.linux@gmail.com>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
 <9657C897-087E-4544-849B-964E99D95A50@collabora.com>
 <DCLTJMIAMCVL.35U236MMS5CCK@kernel.org>
 <85B643A9-1657-43ED-BE98-BE7E502D08DA@collabora.com>
 <3aca9e74-b67c-4bfe-a206-9a6eecdf76ab@rwth-aachen.de>
 <2025090916-dill-elated-3d68@gregkh>
Content-Language: en-US
From: Simon Neuenhausen <simon.neuenhausen@rwth-aachen.de>
In-Reply-To: <2025090916-dill-elated-3d68@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: RWTHEX-S2-B.rwth-ad.de (2a00:8a60:1:e500::26:155) To
 rwthex-s2-a.rwth-ad.de (2a00:8a60:1:e500::26:154)

(Sorry for sending this again. I forgot to hit reply all, since I'm 
pretty new to this.)

On 09.09.25 14:14, Greg Kroah-Hartman wrote:

> On Tue, Sep 09, 2025 at 01:19:12PM +0200, Simon Neuenhausen wrote:
>> Hi,
>>
>>> On 06.09.25 17:46, Daniel Almeida wrote:
>>> As I said to Greg above, I’m here to help if anyone wants to write a 
>>> USB
>>> driver. Those interested
>> are free to reach out to me and we will work together to merge the 
>> required
>> abstractions with a real user in mind. Hopefully this encourages 
>> others to
>> join in this work 🙂
>> I had planned on writing a USB driver for TI nspire calculators, that 
>> would
>> make them mountable as USB mass storage devices, since they use a
>> proprietary USB protocol, that usually requires paid software from 
>> TI. At
>> the time I gave up on that, due to the lack of USB support in RFL, but I
>> could revive the effort using this.
> usb-storage is really just SCSI, so if you want to try to do this, you
> are going to have to write a scsi driver for the calculator.  Not
> something you probably really want to do 🙁
AFAIK it's not actually SCSI, but some custom USB protocol, that doesn't 
work on blocks, but files and directories directly. It also allows 
taking screenshots and performing firmware updates.
> Odd are this would be a much simpler userspace program instead, as you
> can control USB devices directly from userspace, no kernel driver
> needed.

Yes, a userspace program using FUSE would probably be simpler, since 
there's already exists "libnspire" for interacting with nspire 
calculators in userspace.

As I said, it's gimmicky.


Greetings

Simon

