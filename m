Return-Path: <linux-kernel+bounces-825758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2EFB8CC27
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74A3464F02
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764DF2264BD;
	Sat, 20 Sep 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.org header.i=@posteo.org header.b="hcPhIG9n"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173D1FBE83
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383387; cv=none; b=rn1FMinXadnIkz14pLRAkAZy9cAUIfd/zGliiG9nQNGtr98Uzhu6GzxJqbh4oCOwFxPWtiIXKtUPdyV1E2qoZVF7RmJMa6bhT6C2fS6BeJ4ouiStqCtQWM70Qtht/f0d0+8ymU3551BjjqFldyzWyO3/c//I5Ve3uI4sJKjuqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383387; c=relaxed/simple;
	bh=VqU9kBIv3GJH5ecLogCb8x8xG+AXIywoz3C9j4KNqQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVRcSvdKSyl4qcbwM4w4tf2QitEl6Ah7X+34Na+MRaMYl9t6aYcns42/gyreWwn9mBToRqty72Ogtiv2hooAtCUHjQvosaVmIe3Uc4Q8jOZHTAB4jtHaXPLKk+Ci4YyrJVB68YARsZemSwRk7ceSbbazZW7SVg5dBn0S4hHGkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.org; spf=pass smtp.mailfrom=posteo.org; dkim=pass (2048-bit key) header.d=posteo.org header.i=@posteo.org header.b=hcPhIG9n; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.org
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E9E9C240027
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.org; s=2017;
	t=1758383382; bh=12cSXouHig6eJCbLkWhzyhxZJT9pxRosLx5CxBWPbmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Description:Content-Disposition:From;
	b=hcPhIG9nUiEB7s7HFGNDAFqBNM++FxOVABbL/UCnOsfltLtAxDmYaOAEswBJwyiWl
	 r/GtmsPjwaOmAquHoCnLh2qsyH6hyMfrHjiuEq0ayw6uJW+VDmSf8f/oHnE/EteLbO
	 DHGzwiL13nTCRoy2uS/wYStK9yMgvqeobVraHgzq/H3L6F3KrW3erOhUwqMsyvPuHP
	 ZFWHKDAJ2OUplEtEt1DSzggOjeAuIaRjFoLkP3i+IAD8qrMhhL5QbQmunOmrgfFRzE
	 bSwKzcyc1c1KroZRs0rJlQwY5gVTg3iSxrdIyadi2ETtuawkUkQPHnUY615UECQgOT
	 WFWMpF/mvdtkQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cTYj162zwz9rxG;
	Sat, 20 Sep 2025 17:49:41 +0200 (CEST)
Date: Sat, 20 Sep 2025 15:49:42 +0000
From: Karsten Tausche <ktao.oss@posteo.org>
To: David Wang <00107082@163.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: IWL Error Log Dump since 6.17.0-rc5
Message-ID: <aM7NFYJJdGR1Hnfg@rakis>
References: <20250909165811.10729-1-00107082@163.com>
 <487c99e0.6ed4.19932979ca5.Coremail.00107082@163.com>
 <285c7cd9935d5c245ad478c5692faa927bcda245.camel@sipsolutions.net>
 <35b1fd7b.aa06.1993e2b7ce5.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: 
Content-Disposition: inline
In-Reply-To: <35b1fd7b.aa06.1993e2b7ce5.Coremail.00107082@163.com>

Hi,

I can confirm the same issue and resolution on a similar card "Intel
Corporation Wireless 7265 (rev 59)". I did not test rc5, but rc4 was
working and rc6 broken for me.

On Fri, Sep 12, 2025 at 09:44:21PM +0800, David Wang wrote:
> 
> At 2025-09-10 16:31:33, "Johannes Berg" <johannes@sipsolutions.net> wrote:
> >On Wed, 2025-09-10 at 15:47 +0800, David Wang wrote:
> >> Hi, 
> >> 
> >> I think those error dump is introduced by commit 586e3cb33ba6890054b95aa0ade0a165890efabd("wifi: iwlwifi: fix byte count table for old devices")
> >> 
> >> My wireless pcie card has device_family 15 which is less than IWL_DEVICE_FAMILY_9000, and the changes in the commit have changed the behavior for my devices.
> >> 
> >> -       if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
> >> +       if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
> >> +           trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
> >>                 len = DIV_ROUND_UP(len, 4);
> >
> >I think I just got confused, and that 9000 should be 7000. Presumably
> >that'd work for you, I'll send a patch.
> >
> >johannes
> 
> 
> Hi, 
> 
> My system has been run for days and no IWL error dumps & reset happened.
> I think I can confirm that my wireless card needs the length adjustment.
> 
> Some information about my cards:
> 
> [    5.067265] iwlwifi 0000:21:00.0: enabling device (0000 -> 0002)
> [    5.068798] iwlwifi 0000:21:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
> [    5.068809] iwlwifi 0000:21:00.0: PCI dev 08b1/c070, rev=0x144, rfid=0xd55555d5
> [    5.068813] iwlwifi 0000:21:00.0: device family: 15  <-- 
> [    5.068816] iwlwifi 0000:21:00.0: Detected Intel(R) Dual Band Wireless AC 7260
> [    5.075593] iwlwifi 0000:21:00.0: loaded firmware version 17.bfb58538.0 7260-17.ucode op_mode iwlmvm
> 
> $ lspci
> ...
> 21:00.0 Network controller: Intel Corporation Wireless 7260 (rev bb)
> ...
> 
> 
> My device match the config in drivers/net/wireless/intel/iwlwifi/pcie/drv.c:
> 
> 263         {IWL_PCI_DEVICE(0x08B1, 0xC070, iwl7000_mac_cfg)},
> 
> iwl7000_mac_cfg is defined as:
> 
>  88 const struct iwl_mac_cfg iwl7000_mac_cfg = { 
>  89         .device_family = IWL_DEVICE_FAMILY_7000, 
>  90         .base = &iwl7000_base,
>  91 };
> 
> And indeed, it is IWL_DEVICE_FAMILY_7000
> 

Early kernel logs for my chip below. 095b/5210 is matching the same
config iwl7000_mac_cfg as above.

iwlwifi 0000:03:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
iwlwifi 0000:03:00.0: PCI dev 095b/5210, rev=0x210, rfid=0xd55555d5
iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band Wireless-AC 7265

Snippet of failure logs on v6.17-rc6:

iwlwifi 0000:03:00.0: Microcode SW error detected.  Restarting 0x2000000.
iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
iwlwifi 0000:03:00.0: Transport status: 0x0000004A, valid: 6
iwlwifi 0000:03:00.0: Loaded firmware version: 29.f2390aa8.0 7265D-29.ucode
iwlwifi 0000:03:00.0: 0x00001030 | ADVANCED_SYSASSERT
iwlwifi 0000:03:00.0: 0x00800233 | trm_hw_status0
iwlwifi 0000:03:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:03:00.0: 0x00043D6C | branchlink2
iwlwifi 0000:03:00.0: 0x0004B002 | interruptlink1
...

$ lscpi
...
03:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
...


Thanks,
Karsten


