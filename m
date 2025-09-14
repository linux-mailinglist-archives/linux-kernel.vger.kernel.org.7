Return-Path: <linux-kernel+bounces-815607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0522B568EA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2B41789AE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08A3205E25;
	Sun, 14 Sep 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ews+/wa4"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37499226173
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854430; cv=none; b=S73yJNN9w9die0bOWuyvXLIdH0HmVsW/ZzRNoVpNsXmrHA7BJ5QgpCbXrKfBt2zO+VBoBdEm0ONuFMyoOkYgmFdY4XvipbBxs7IT055ObfAQCLid39fCZJWV4hyIaX0FhTVj/QlX+v8A9L6TwkXtnTCKMk/drNG/xhMnImZXAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854430; c=relaxed/simple;
	bh=myj5lr0tBUCWs2+uOlPQBLHV+yNBFI3ANgsW/NGhfKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcZXwdAWOlGHrv7irCEcR7Bc5z3dUyFXPqbUmMc1Oy605eNKsiAb4x5bEp/mp4TirGzBT0boDPMknPlT6juapajGVY/K/lFmJDZcZEeemO9oWOpkgavOGA+Yz/csM/argtnd4sSUUQQbYSM303zYoZvGWO0wJzS9mY72ipsaIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ews+/wa4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f72452a8eso3891917e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757854425; x=1758459225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bqnlp/Od3IeOnWCccNxaZuVEtEKpBHtfx16e05Kdazc=;
        b=ews+/wa4j73ecA2OiausSyvafYPXis+Puv3YjT5UuphNdw3HLFWyB6Vhm8lgRDEVoW
         LjkDSjnuHAIYHCPmDhT7YGsugo61rRXwi4KzTMzsKmtMJ4QOq9BtqeciaaNl6Dho9BAi
         spOz0gXxPGHqCWvOx/+eW4FXdKFdoczSVAyW58nv17oHRzlKGdNGThnk7r8rHmSNrF8x
         AW4ujs1rLFK7+3pSPPsY3UkZTXTOsv2vP7MoPS6Wm4XxcBNzKkA4Vp5toyjP0w9C83qv
         +9FVPVXbRlc8281sPC2Tg0K/RjUengork2nk6cqCiAuy6wmM1rEC/Rp3Ld+5SF1QH0Fn
         4NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757854425; x=1758459225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bqnlp/Od3IeOnWCccNxaZuVEtEKpBHtfx16e05Kdazc=;
        b=ek4bLCWn4Gf0yZ+1C2FISyt2442HWo4VJFrjCOV8A3Wp419WrZa+kpzLCBDnsPCziK
         lK5EHybhJySTTuHizWrZvelCqPmKbz2WK3qnfmlQOcNnnOXCkAocOds+3G1FzvGbIZ52
         tiqlwRYyi0J0dLj25fVfAwnAISN7atUu9y1h7czI7XjK0JYpyysn+W06WdFm0Oqq4nLx
         9HxRWU8Aov2Glv1ICzTANnk6MNw/9BdPI6GcojuoK2obRLP4PcECjKdsQDAmSaRzYptO
         i9vxyff6u9Q7kRLvRIxmxTdlGKr6vIwHcD19k5Oin9a1+09CqjqmSF7l3OBrxy6Jzh6w
         KHCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAo+RudNaAoUJYKC6f672tKHUpu8uLaM1qRhGcuYGRUNgHvA0ooaYCAkgrepsLrsoTg0GIK+HOeTQaOlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuoWcX+9Y1Kk/MfYrMviqkoqw17HPdeVfDGbpDXMFOfGOHkhhZ
	rZE+B3hRES+dtrfzajz4GTthEwMpg11/HSTOPsdH1hpoGFe0Agg+OWSR
X-Gm-Gg: ASbGncvvCMLSszH0N/oXlG/niy5+mrzfjrvsIwWzKkU/B5yGPwIagsHSwJpD0clWh7K
	7z9bvtxZV1Ew5imkaobqIlSKQ4UksftTftDW8UaF7CwhiJmpcecDyPr2J9JrsT/rxghC+4FOSbd
	27k+l3X2je0LJlpu55rgaSsyhDUrU4hXf65PWiLJsM78t8iur234C85fXFup6Rm35c1kV2krx0Q
	fe2jRQ2JNUlE8vaLPZtMkNrSc9WabQapLvNFUHvWV4q8V1mfcJd3N/FYU8LoxoTNmO7MqjLxrlN
	av5JQAnmQ4Wy8VmjhKkAnnpS8seV0qxYkb3LNsePmy0gPFN6wtjR2CBYVwC/Sbse7Wn8A7kBn+x
	MaAcSexl2YlYZn5KQ3izW
X-Google-Smtp-Source: AGHT+IHVgj6Ga9oYxk96Tc9z6J6YavW2IiPws8jlhH5Hkj77utKeSvSHe+pBiGr5+dS0XPqJkb3s1Q==
X-Received: by 2002:a05:6512:3599:b0:55f:6d6e:1e97 with SMTP id 2adb3069b0e04-5704fb8637amr2162703e87.52.1757854424914;
        Sun, 14 Sep 2025 05:53:44 -0700 (PDT)
Received: from mobilestation ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65191e9dsm2844969e87.128.2025.09.14.05.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:53:44 -0700 (PDT)
Date: Sun, 14 Sep 2025 15:53:39 +0300
From: Joseph Steel <recv.jo@gmail.com>
To: Sebastian Basierski <sebastian.basierski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
	Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com
Subject: Re: [PATCH net-next 0/4] net: stmmac: new features
Message-ID: <ofapzlvardeiwwybyqpwxhhd3mc64wlkan2h6a2iaj425xk5tf@vpccbegsrcft>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
 <40c3e341-1203-41cd-be3f-ff5cc9b4b89b@intel.com>
 <y45atwebueigfjsbi5d3d4qsf36m3esspgll4ork7fw2su7lrj@26qcv6yvk6mr>
 <63959a5f-a0fd-4e75-8318-4755fcf6e9a7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63959a5f-a0fd-4e75-8318-4755fcf6e9a7@intel.com>

On Tue, Sep 09, 2025 at 08:26:29PM +0200, Sebastian Basierski wrote:
> On 8/30/2025 4:46 AM, Joseph Steel wrote:
> > On Fri, Aug 29, 2025 at 02:23:24PM -0700, Jacob Keller wrote:
> > > 
> > > On 8/28/2025 7:45 AM, Konrad Leszczynski wrote:
> > > > This series adds four new patches which introduce features such as ARP
> > > > Offload support, VLAN protocol detection and TC flower filter support.
> > > > 
> > > > Patchset has been created as a result of discussion at [1].
> > > > 
> > > > [1] https://lore.kernel.org/netdev/20250826113247.3481273-1-konrad.leszczynski@intel.com/
> > > > 
> > > > 
> > > > v1 -> v2:
> > > > - add missing SoB lines
> > > > - place ifa_list under RCU protection
> > > > 
> > > > Karol Jurczenia (3):
> > > >    net: stmmac: enable ARP Offload on mac_link_up()
> > > >    net: stmmac: set TE/RE bits for ARP Offload when interface down
> > > >    net: stmmac: add TC flower filter support for IP EtherType
> > > > 
> > > > Piotr Warpechowski (1):
> > > >    net: stmmac: enhance VLAN protocol detection for GRO
> > > > 
> > > >   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
> > > >   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35
> > > > ++++++++++++++++---
> > > >   .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 +++++++++-
> > > >   include/linux/stmmac.h                        |  1 +
> > > >   4 files changed, 50 insertions(+), 6 deletions(-)
> > > > 
> > > The series looks good to me.
> > > 
> > > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Not a single comment? Really? Three Rb and three Sb tags from Intel
> > staff and nobody found even a tiny problem? Sigh...
> Hi Joseph,
> Thank you for your time and valuable review
> > 
> > Let's start with an easiest one. What about introducing an unused
> > platform flag for ARP-offload?
> Right, this patch should not be here. Will be removed in next revision.
> > Next is more serious one. What about considering a case that
> > IP-address can be changed or removed while MAC link is being up?
> > 
> > Why does Intel want to have ARP requests being silently handled even
> > when a link is completely set down by the host, when PHY-link is
> > stopped and PHY is disconnected, after net_device::ndo_stop() is
> > called?
> 

> While trying to enable ARP offload,
> we found out that when interface was set down and up,
> MAC_ARP_Address and ARP offload enable bit were reset to default values,
> the address was set to 0xFFFFFFFF and ARP offload was disabled.
> There was two possible solutions out of this:
> a) caching address and ARP offload bit state
> b) enabling ARP while interface is down.
> We choose to go with second solution.
> But given that fact this code depends on unused STMMAC_ARP_OFFLOAD_EN flag,
> i guess whether it is fine or not, should not be placed in patchset.

The reasoning doesn't explain the outcome you provided. Even if the
controller is reset on the device switching on/off/on cycles the
driver will re-initialize it anyway. The same could have happened with
the ARP-engine too should the patch 1 be in in-place. But besides of
that you submitted patch 2, which _enables_ the network interface to
respond on the ARP-requests with some initial IP-address even if the
interface is set down by the user. This makes the host being visible
to the surrounding network devices behind the user back if the PHY,
for instance, is unmanaged or reported as fixed. Is that what Intel
wanted?

> 
> > Finally did anyone test out the functionality of the patches 1 and
> > 2? What does arping show for instance for just three ARP requests?
> > Nothing strange?

> Yes, we have a validation team that verified proposed solution.

So did they notice anything strange? Is the validation team qualified
enough to correctly evaluate the change?

Joseph

