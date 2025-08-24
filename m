Return-Path: <linux-kernel+bounces-783781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F95B3325D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 21:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E204201DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A352264CD;
	Sun, 24 Aug 2025 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="ZBsgJnEB"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4361B5EB5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756063779; cv=none; b=kIXwsDJj+CUu7TVHr0sM2/PQAS6rD10Nib9hKHUqOiZQedSsDfdwJSscyvHoX8GYLpzq28QFGJrPZf5+8cqvAUWJIGQObEShRMdc5qHIcSYE5/x7W54fmq8kbbEUdG+bhbAxVG89dXAeAabUPTlCLOms6AqK+SNLBHKDmWjK/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756063779; c=relaxed/simple;
	bh=ncHuOkYQgqh5qIVnSFX5iKQXl+5ZmyCqgswzpum3n+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7oPEooI9Xk3DBgMYxjwoVDVmHUMbMBm18FRgiYxmTbSYc9qeibw4O+Vjs0d8ichJ+jLGIPr4bN9+Rd3y2Ju3/aG4dXrK56k7V2jHSB2jXHS0+vph3Lxxm9c/tpIQEnaNwadRjvpKW6vGo8ERdWUKmXFfBku4QGSfamvXMPd6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=ZBsgJnEB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso3021486b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756063777; x=1756668577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCoTp0qUfVekYTFrAgjFa6oA2C+d7ZolErRxvyYQLQM=;
        b=ZBsgJnEB18Z5TSTskpMZPaf8q0Lr/myv7TCtLaj3A44KeqJuIb4BfrbKvmQe547O9Q
         DTQY5f24CgcfwiQrzgPggNwJ3Xuf1J3X6YkFCG2PSHuTh9p2+bpRhbZpobO+4XkqqOV8
         Wqm+b2LWt+B3k6KEiNjrGI/87X5Wl3KzD8zKTWcJVlOe+9gcHvfU8UjFvRhNQ0kqdX3w
         42WFsveSpeQGzsoMYxFUccPGwCEhXFp1VYTBhmbJSc3u2yd3eGmNwGisiC3JcKBHGLBD
         FPfMMR4JkRXEg3Sy56k2rh1Qrif+tMzTILP3/4BTPRj/B3VPw7KBXRzI35JsFXcTE4qC
         BucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756063777; x=1756668577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCoTp0qUfVekYTFrAgjFa6oA2C+d7ZolErRxvyYQLQM=;
        b=fAgES0IDzy5+ee75C1RDdC4pOtdhGVQoWGHL6sn0uV3pKAUAN9mRGDCK7JEyohY2KT
         dUM9lTcLdybee8tCtgbwiv4z7CXPdPxPnb5ekFJwXMK0oZlirO+RznCmBN7ghOc8HVKp
         xYeqL1bl5rdBrQSTvUrcvn9b6/VrhITrXHngFXZKL25zT9XDx+msWZ6FqbHSgq4Jwo6X
         b+lHLnnXMSyTfaTAsCE1tmB2rypwwOusgnZww1D4Q9bX8oRfUA/+D59Y+pIoOQjMVOGS
         UCFKSif7mw1dgzkb5pDdXcTySWt/L6DFVifxI7Hk6cIobTNiz2vgFOPTG5CabsYXj3RS
         DukA==
X-Forwarded-Encrypted: i=1; AJvYcCX+IXo9f6CVbf2eDn+e7W5Kc0txJeuHpc8U+X1pa69uk+6qCVx0Ylqf3jdCFo2l/nSwEmGIVchCTeP0S9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdFIOmZ48hwhwRuvIEiJWh0uW7kg4FEz5J/QEqXy2wwUkpD2C4
	q7Zja3apEVIS7MhqCVesCzDQcifxjVPLGlVosMHFE2fNUkhUEQx4R3VyrVUueg+upp8=
X-Gm-Gg: ASbGncvXWefG1GeKkOAS9ZVgeaxTguRKr3+jJELc1cTFGb1c2mRBMEqXRxjP2hsP7qe
	0nQnpaO73EbB3WdpJl3xzX1fMjHsg0jLVRkbW8KcEqhqzIt1ac/22oO/3S15LCfWvsxvr2OilNn
	B8bCSBFoQQH2TzrL5kIby+rgsuCsCywB+58rsBz89WgfWYt6CwIl8ou9LVLbsfCY8j0aOELhwRD
	LSkGTXsPLh+lQe/DkCLwEfm1DIZYuh+w+OjzJ4WMeMtMy6DdKGmOSwyINZ6PsbSHdbALDMEetrk
	btgGJpmudfaUOK9kM8E9Ho5i4grrEuBVhM5P4AwVD3/O1s+lV2xe85FK6J/Cz8ypiTh8qR4GK8k
	k3hPl8/h8czs9NPhiMIBGTUTJUADmo67kBu0=
X-Google-Smtp-Source: AGHT+IGDB0Czf3c/4OIzq7XUwidB/SuwMudab0b/O3A3Wm/7OS0XDSXzGZSg2GBsm/D4X4R+ek3YHA==
X-Received: by 2002:a05:6a00:1ad0:b0:76b:cadf:5dbe with SMTP id d2e1a72fcca58-7702f7181bcmr12599797b3a.0.1756063776739;
        Sun, 24 Aug 2025 12:29:36 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040215169sm5404802b3a.89.2025.08.24.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 12:29:36 -0700 (PDT)
Date: Sun, 24 Aug 2025 12:29:33 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Kyle Sanderson <kyle.leet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: [REGRESSION] - BROKEN NETWORKING Re: Linux 6.16.3
Message-ID: <aKtoHev5AogCje9R@mozart.vkv.me>
References: <2025082354-halogen-retaliate-a8ba@gregkh>
 <cfd4d3bd-cd0e-45dc-af9b-b478a56f8942@gmail.com>
 <20250824185526.GA958@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250824185526.GA958@1wt.eu>

On Sunday 08/24 at 20:55 +0200, Willy Tarreau wrote:
> Hello,
> 
> On Sun, Aug 24, 2025 at 11:31:01AM -0700, Kyle Sanderson wrote:
> > Thanks for maintaining these as always. For the first time in a long time, I
> > booted the latest stable (6.15.x -> 6.16.3) and somehow lost my networking.
> > It looks like there is a patch from Intel (reported by AMD) that did not
> > make it into stable 6.16.
> > 
> > e67a0bc3ed4fd8ee1697cb6d937e2b294ec13b5e - ixgbe
> > https://lore.kernel.org/all/94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org/
> > - i40e
> 
> Your description is very confusing. First you indicate in the subject
> that there is a regression in 6.16.3 (implying from 6.16.2 then), and
> you describe a 6.15.x to 6.16.x upgrade, which then has nothing to do
> with 6.16.x alone but much more likely with 6.15 to 6.16. Or did a
> previous 6.16 work fine ? Also the patch you pointed above is neither
> in 6.15 nor in 6.16, so it's not just "missing from 6.16".
> 
> Based on your links and descriptions above I suspect that instead it's a
> 6.15 to 6.16 regression that was brought by a0285236ab93 and that commit
> e67a0bc3ed4fd above fixed it in 6.17-rc2, is that it ? If so, can you
> apply that patch to confirm that it works and is desired in 6.16.x ?

Yeah. 6.16-stable needs c5ec7f49b480 and e67a0bc3ed4f, I was going to
bring this up next but Kyle beat me to it :)

Kyle, do you want to send them to stable@, or should I do it?

Thanks,
Calvin

> Regards,
> Willy

