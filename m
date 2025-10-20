Return-Path: <linux-kernel+bounces-861939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D727BF4144
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEC8481AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0101A334C2A;
	Mon, 20 Oct 2025 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cf1OZPp5"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96072F7ADC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004448; cv=none; b=MquGkUT7ZOx+utCrTY/M0NQpfDmNLKaBfx7FRxzyLpeuvKGVwVBKJGo3DkSNVTSu3tLJGGlBXVjXGcGoM+xWemQ4GggLNI7XPYpDz322ti9UYrKMvLhaM9bshasKgFZ/baTwevMxZenPPEZlg3SA9ybsTWfkk4uMQ2ksF7U5uD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004448; c=relaxed/simple;
	bh=/JmMLDWSzN3LEuaQD/58uLUaoZNGiTPauMR+rIRRiho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwug5w3vKXybTYtyeH3p1O+HLHy8zyewdaMKGDpsUiEDHhscpeazV8aHh5rLb7+vrNq8FYPZ0matwDJFqTen+xtB3OnYdDU8Mnn8qaT2Xw4Y/5Qv6vZT7N9SMt221dxREyy0oUxvUPbl1JmBWeCIbD7T8jHJBN3n+eOGQsp8B88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cf1OZPp5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290d48e9f1fso59955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761004446; x=1761609246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ltRfV7bQc1S2inHm8x8BD/ir81jFLVkeX9xKAma+AFI=;
        b=cf1OZPp53qeaKCvpHGdkw1SP6YuenpvdsWviNpuobKWEnb/4mTHXWsiMGETCA2dQl5
         PVMMnL40+VxGxYnfVB5JT6aKoVwbq7EBQVBymMdB7QTS8guP/3AGUSl9wA9YmWBqyl/6
         du2AXTSz62ljS0jakVKHReyMualXA3KSSW0btVSITMJv/OQ3/S5/E5vj/WUy22lNjmjv
         ZiCYCbfkmR0PDk86Fd5fgScSQOsXIXW6GhG6l7CG38KQlE9oxor1aYqPmZ42L7NGlG6N
         GPbuds8YAoeW7jGH44f7ul8rWerwHyp8ZqBaEUMvKHa3pITUKXpMiq3RhOeOymLkaPtr
         jpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004446; x=1761609246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltRfV7bQc1S2inHm8x8BD/ir81jFLVkeX9xKAma+AFI=;
        b=M1jS0JFLf9Lvac2fFnfw8Wvib8yiDhhfwsIFfpV2hhlh9BOe/G74iSSqiSTPIb++K/
         pP0c43VvK4AloQpfBXyZtMKY0J6eL5LSD83xPtSYCLc1ZqjLGF3UU72Bb4nYvjusH1Va
         juKHvRwSxCZh2ihnuu2QRRPO6eEDnlNk1/qsvtTTU28MznCFzyZi82CobIYlurXb3jCV
         NlFXN8Kw3ZhgRlocaWYh4QgLv9PPiXKGmIWO/zEBoDn6KDtg/MS/okBnV1zZXzk1B1BW
         Dhs8T4n6UOR46ufcurwJqRYfkbnP4evDPmiqYaNkwjuvcO8UqvrDuDTZ1BHyxAphxot1
         oAog==
X-Forwarded-Encrypted: i=1; AJvYcCVg04n2OT+fr4f2+OVRUq/JaHBXCEv6mIGrUvPsrQLp2jT1Z4ABZTYFR+STPoJjRjvI5eKLB6SLsRBQtTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+0/uttP1Ogu4NhMvtqAu+LcA+Byg7PGjHE3OwBVvxvKSVuEi
	xY67g7SowSyuAP7bx3m0t1lqggTKszQDmX+b/qWg1r6X1lRaEmyS4RNpzTsaS0L/2A==
X-Gm-Gg: ASbGncs1JldhPTzRqaaqi5YIAfV2d+OoFqcAVI8u0k8Mh2UAHYJ4a8t6Fap42I6E+tI
	bGpPDbxslcZHppXr6/JYH+9DBiS1LlpyrxALQpGPktFx5W+i12ixuEOhclRlcWE5acmp4p8N0JU
	QVZmxris4qroCeP8K7/YE/GubQ7jp6foy4HTysko+t1XAl11pVc9auxE9rfiLohoio0BmLwKfxc
	HwCvB+VACa+mWEMTUnnHS0humpNK7QhGR9h3BPQCIit3VouqHmvfbRRFdFup2C93/ewJhEP9wpt
	XK5fsIFTQgPlodxp0ryagHmPggRoylgBhSa1nChlXX54AIZuytXeVtvITCynGHRi/2WH9IcBxU0
	3o1dwxj++v7CdX8HREISAuJmTYAo8qVICsl35QJkN9oZ6fP7hs86+co0M9Jc0w3/mv1cOEelqka
	FxgIfJM+KcDZwV46OMaAi86X6RfnRilJLNeGuRoxNwrwNzA/A=
X-Google-Smtp-Source: AGHT+IHnjQDbmN48yGCW08isewxL3XJLE1EP9F861Dj/n9QeHORn7MbDuQ+5iFq8eYwd04Kfj6g7gg==
X-Received: by 2002:a17:902:e88f:b0:290:dc44:d6fa with SMTP id d9443c01a7336-292d42ad08cmr2317955ad.16.1761004445675;
        Mon, 20 Oct 2025 16:54:05 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247223a3csm91357785ad.112.2025.10.20.16.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:54:04 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:54:00 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251020235400.GC648579.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
 <aPSeF_QiUWnhKIma@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPSeF_QiUWnhKIma@wunner.de>

On 2025-10-19 10:15:19, Lukas Wunner wrote:
> On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:
> > On 2025-10-18 09:17:33, Lukas Wunner wrote:
> > > On Fri, Oct 17, 2025 at 05:07:07PM -0700, Vipin Sharma wrote:
> > > > Move struct pci_saved_state{} and struct pci_cap_saved_data{} to
> > > > linux/pci.h so that they are available to code outside of the PCI core.
> > > > 
> > > > These structs will be used in subsequent commits to serialize and
> > > > deserialize PCI state across Live Update.
> > > 
> > > That's not sufficient as a justification to make these public in my view.
> > > 
> > > There are already pci_store_saved_state() and pci_load_saved_state()
> > > helpers to serialize PCI state.  Why do you need anything more?
> > > (Honest question.)
> > 
> > In LUO ecosystem, currently,  we do not have a solid solution to do
> > proper serialization/deserialization of structs along with versioning
> > between different kernel versions. This work is still being discussed.
> > 
> > Here, I created separate structs (exactly same as the original one) to
> > have little bit control on what gets saved in serialized state and
> > correctly gets deserialized after kexec.
> > 
> > For example, if I am using existing structs and not creating my own
> > structs then I cannot just do a blind memcpy() between whole of the PCI state
> > prior to kexec to PCI state after the kexec. In the new kernel
> > layout might have changed like addition or removal of a field.
> 
> The last time we changed those structs was in 2013 by fd0f7f73ca96.
> So changes are extremely rare.
> 
> What could change in theory is the layout of the individual
> capabilities (the data[] in struct pci_cap_saved_data).
> E.g. maybe we decide that we need to save an additional register.
> But that's also rare.  Normally we add all the mutable registers
> when a new capability is supported and have no need to amend that
> afterwards.
> 
> So I think you're preparing for an eventuality that's very unlikely
> to happen.  Question is whether that justifies the additional
> complexity and duplication.  (Probably not.)
> 
> Note that struct pci_cap_saved_state was made private in 2021 by
> f0ab00174eb7.  We try to prevent other subsystems or drivers fiddling
> with structures internal to the PCI core.  For LUO to find acceptance,
> it needs to respect subsystems' desire to keep private what's private
> and it needs to be as non-intrusive as possible.  If necessary,
> helpers needed by LUO (e.g. to determine the size of saved PCI state)
> should probably live in the PCI core and be #ifdef'ed to LUO being enabled.
> 

Sounds good, I will create helpers in PCI core and ifdef them for the
things we end up agreeing that need to be saved.

But I also think we need some guardrails to detect if they change
otherwise we might end up getting some hard to catch data corruption. I
think this ties up to what Jason also saying we need to define LUO ABI.

