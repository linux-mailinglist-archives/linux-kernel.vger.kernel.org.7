Return-Path: <linux-kernel+bounces-868984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68AC06A81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D2319A4340
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1A320CCE;
	Fri, 24 Oct 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW/UUYEz"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5F31DDA9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315115; cv=none; b=orC6KddGChB5G0tPWvmfM/tYvR79EWayn2o6luwNnHzQJpPrwmYjNK5OxDXm6UPox3o3xV5v6yxtCVFw9BgQvsrUSbD4N/94UvDE1FGWIK1RRdafBW1HM0F5p9vKBgqe9V5w0Rm1EPBbI58exWmr5/WEMviZMgsGMOLLJSHciTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315115; c=relaxed/simple;
	bh=7HRxkH4U0ZGtzJJtvUDG/s9FxSZgrTAC/ETvO0Gla5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNCDVNFkLXyf8RfRB/A6pQuiywQ1XTByNax1HVRj9GD4U743klH7kaQni5DEE7hP7a0SS1FNFphAD+4O2fk/aVZTkpjXvdrfkqQU0s0LeMM2VAK4KwY135uuAHmkXcnxtm8Qgy0pLtAwHTtgvr03/emlbuu5etTV1e+wMbtofOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW/UUYEz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so12648255e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761315111; x=1761919911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzUULjIScXn8UngnM5413vcqxuKmp/bX9dJx0R9FqF8=;
        b=IW/UUYEzCorL4ZG4mCqRK9GSbEPyQc82A156wnJkmdusMBSjz+pdF0s9cIXW1q/wdc
         lNpA8jYHwxRBd2TDbkb2bcB83daTOK021w15cDIAM3yOgrh8Or611+TsKm4Y3fIu4VjM
         8Ke/0gxc0oqEaorueJpccE+Fjm8KKBQU6mJg3SSAWjBfJhvD/rVfKR7jPZZYnzXtr7wZ
         V9WwlRj30zaQJulVS75W88LStnbmHeraHQGMGRrvou7QXGBz+cia+8bZLnrDs6vFn8cF
         IvoJGqeW/aJmKT8D89bTSUKjFqqpn3OWNBA13D3bLIFkyveWVgYNKanOPnpD6B5QjW+s
         atdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315111; x=1761919911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzUULjIScXn8UngnM5413vcqxuKmp/bX9dJx0R9FqF8=;
        b=LoWUCsfQ4IQ/8Zxec8gw5zF8DfUISd6384SkvzbBfYONljaGlj5dxP99C4xICNx2Ed
         aiWbh0fcv5CWE5e04I0WPJOFjIZeGXMBb5nLwkmJR30ANkjk2VttPoPGfiURIMNE7uW2
         ay1QXgS3MYxIN4tv656FDz7VSfzh9kuQVwfKl/DtuJY46sosi3un+B9DXVY1P8/jJRyI
         NPgRBqVfAVgqrJzWnqXXEf42/QSYHgoBGNWcKXoUOAx73tVFzv7UO+kZ5yBz4YHFdtxy
         NEFLMZf/Eh1k2O7qgZKbFBslXJ/TDlny5bJ/6IWOGELOMgNUCAmhiCgKXJC/0OtLdIoZ
         h/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVtJdZW42k/CGlYT2V0bGHZ9H4O3Vjq0C6Y5n/5TSxmiWhQ/gqio986CvGJUndAMZfh4B+LtUJ8wK4IEKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwArSV4ohKg31uFqU3y/mVylG8FHNfhQxnslZkAaHLuHFDWYRmL
	bSpjqe4YoQn94CHyQ4KZmusLY4qgaSLU0V3jULqeK3W7g4vAKSeipTTP
X-Gm-Gg: ASbGncu8W/+1sZYPCcJeXBIQ3am7Y/7PzPzx0bEJ3kruhUvOxKcmdhL6K408qnZRLDv
	2GpwNOab6PJqga8xhsMl5MlPzkrO+YthsI/Y/9eVQxpBE64p/ClKLU0MndZI+t0Hifzmyujdg/S
	7xM4v+DAHztZ2bzNUuEkr7vrV5nyRG92uILvCVMTvnqhuWNENrl+d3BeFBZa7u6yOrTSBn7dxb9
	SJSDwxeUp1nRpv063K1z87VhlnEg8G4mEG+WaOnpg0hCgmaI3SfXZUQ5KdfIhx47MqZ2TsPbczD
	hv+9zCj/ACwDpVDUPJ+w5vv0qvRoJyEA8rJInrnaTsSELSVcs9s1X7o7Ilf8vM/FjLrMGdJMO97
	Q+SmfyhrD5rr/Mws84fCZFJStbS027vC3XXVX+HrLq61Lt/K0Tm7TywbHniw7HOa94XCHnKTbRx
	NOVFrZlEkdUZasw+vFm0PcFtZy3Y4FtDlpOioOyuxShQ==
X-Google-Smtp-Source: AGHT+IHLGsmbsOTTIw6rtKcg3HdSe4CPoSbzI2zMLOUsp6dWNfk3dCU8FuuIbzdm0uGhV0dotgO9vQ==
X-Received: by 2002:a05:600c:470d:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-4711786d5a3mr208030045e9.3.1761315111370;
        Fri, 24 Oct 2025 07:11:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf4642fsm89204665e9.17.2025.10.24.07.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:11:50 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:11:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Greg Kroah-Hartman <gregkh@kernel.org>
Cc: Steffen Jaeckel <sjaeckel@suse.de>, cve@kernel.org,
 linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
 anthony.l.nguyen@intel.com, Vitaly Lifshits <vitaly.lifshits@intel.com>,
 dima.ruinskiy@intel.com, Mikael Wessel <post@mikaelkw.online>, Mor
 Bar-Gabay <morx.bar.gabay@intel.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch
Subject: Re: CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
Message-ID: <20251024151149.67e0f953@pumpkin>
In-Reply-To: <2025102411-hamper-botany-b6d4@gregkh>
References: <2025100116-CVE-2025-39898-d844@gregkh>
	<db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>
	<20251024132734.30522c31@pumpkin>
	<2025102411-hamper-botany-b6d4@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 14:40:01 +0200
Greg Kroah-Hartman <gregkh@kernel.org> wrote:

> On Fri, Oct 24, 2025 at 01:27:34PM +0100, David Laight wrote:
> > On Fri, 24 Oct 2025 12:53:44 +0200
> > Steffen Jaeckel <sjaeckel@suse.de> wrote:
> >   
> > > Hi Greg,
> > > 
> > > On 2025-10-01 09:43, Greg Kroah-Hartman wrote:  
> > > > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > > > 
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > e1000e: fix heap overflow in e1000_set_eeprom
> > > > 
> > > > Fix a possible heap overflow in e1000_set_eeprom function by adding
> > > > input validation for the requested length of the change in the EEPROM.
> > > > In addition, change the variable type from int to size_t for better
> > > > code practices and rearrange declarations to RCT.
> > > > 
> > > > The Linux kernel CVE team has assigned CVE-2025-39898 to this issue.
> > > > 
> > > > 
> > > > Affected and fixed versions
> > > > ===========================
> > > > 
> > > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.4.299 with commit ea832ec0583e2398ea0c5ed8d902c923e16f53c4
> > > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.10.243 with commit ce8829d3d44b8622741bccca9f4408bc3da30b2b
> > > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.15.192 with commit 99a8772611e2d7ec318be7f0f072037914a1f509
> > > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.1.151 with commit b48adcacc34fbbc49046a7ee8a97839bef369c85
> > > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.6.105 with commit 50a84d5c814039ad2abe2748aec3e89324a548a7
> > > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.12.46 with commit b370f7b1f470a8d5485cc1e40e8ff663bb55d712
> > > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.16.6 with commit 0aec3211283482cfcdd606d1345e1f9acbcabd31
> > > > 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.17 with commit 90fb7db49c6dbac961c6b8ebfd741141ffbc8545
> > > > 
> > > > [...]    
> > > 
> > > we believe that this CVE is invalid since the sole caller is 
> > > `net/ethtool/ioctl.c:ethtool_set_eeprom()`, which already does all the 
> > > necessary checks before invoking a driver specific implementation.  
> > 
> > Nothing stops an attacker-written program doing the ioctl.  
> 
> How exactly would that happen given that this all goes through the
> ethtool "wrapper" for the ioctl function?

I'm confused again :-)

> 
> And if that is true, then the other set eeprom callbacks also need to
> have this same "fix" for them, so it's either one or the other :)
> 
> thanks,
> 
> greg k-h
> 


