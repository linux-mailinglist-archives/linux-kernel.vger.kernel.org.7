Return-Path: <linux-kernel+bounces-851092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5A7BD57E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F8614E9782
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA26277C8D;
	Mon, 13 Oct 2025 17:28:19 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D9425392A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376498; cv=none; b=d9X+h4CoRpI1giMoiSPwkFZfmulwApY+Ix+E74e8PqHX4OZrdx+eZ/T3aM4pvyfqDAWV36I2/LQA9/Rer1+PHp7f8DsW+KBSPiQBL75aIpcfRuMONHdcRXJxltL0iYZfqWL+zJCAXAbXpWgt8KguLML34ETlz0ZtXRqq8d7Jikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376498; c=relaxed/simple;
	bh=KQY1hataPeuBtpGwZ6zSDU3DH0WtfgAwetJ9z7XB0Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpia29Lt1PfolGqnpLWpHO4jxJq+nKCdb8qDGURKB8/M/boN57IYwd4hVMf04qHain4kAXnH1d3d8sDEEEU4VE+toXPv4Z4e9ZkOkA9o55RhhJYlkrJyFOjBhrcSjaLr3vDflHl2w4rrfzyl5VpQstTqw2QwxYiiUSGTfyCqcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso8574816a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760376493; x=1760981293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp7iPh/+dWBwTL1akrhieR7+Yb8elv0601JNgSVEhEA=;
        b=f3sPPaDeuUmbekCBnbyrQc5tZkyte2A2wKU6gMv2Q3NRvXWzAzj60GuGp0CoTMmbn9
         h4Ypfv7hnfpqZmK25hRwnU2y5/U4pHAbB1MPWbMHPIJsK1t1W+UwIKbInPdaPiiRlOlu
         FaJIrnslrnSTrmIy8ivlRfB8muQEvJg6ziUh4rNWnZiUfrjvi6MQUS67yz0VHvFEtaby
         0OyZ7tQnPPQnZiZEkt8Sf/Zi5JrgPYPSyvJse+IDLuxUrh9+mAqUAp7trebaUFzilpFv
         JJ2DCGW7CNv2fJ1xYMmgAYuWWtWRFVxO/fviTzXFKxdG2tLDz8jOBkhKKXukKhx7/5em
         yOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV56wUmAlzpj2ctVzQb4vVVIrvgWlT9wOYCTzV9WrRBBPmgxD2iiTB9y4lUEe0kppb8Fc9l43AMFSSjoXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfb+02OQVo3Zu912H0PzJCubDcfvkMITwa5T+3pyzbfqbIzJWK
	hUYcWHzYDvyti9SAhlJrKlodrdYyA6syd6Xb2M0SNbSDwHpOkH3jPIa4
X-Gm-Gg: ASbGncvZxPoQY8mKEVxoi0xbbHio+D8TBoZgF6bhOSA7Vw2jkc2aEMYmy+iajhM+65T
	HBQzY4uwe9bLXdehPo3Q0OAKYMWqpFAJkfbnrL7onh9soho7HozvzMsHPeSgbE3VGpIGUck2n3K
	BLmsADpXLo2gcFfha8c5Gf0iLnivzCCqrjpmMr1pM8uCVwZzLFPu/XmfiO6kdbWPPA04pJYZoqr
	H+ddLTYa1WuNJKUaAwI4E2cMq7Gqef2ojK4d3tbm68pXrZY4LLK/TpH9Ks7lb4cMYcEt46iPIgU
	0xZ9fqIkYbH+9dk4n/KD8jqjaFExy8f7oBbUUL2juht7G2KM6Fw1ykVw4n46OabUGSm0Ex4FnK2
	U9CHLJLIiQJCCBs/N7i1M3gS4XKVNjEULK0c=
X-Google-Smtp-Source: AGHT+IE1dNy8sZMQ1etsuqp+Iq7aHMYbaFTc/gwrBE/njgDpnk152KciCb7i5X233OmPpKSNbCv8bQ==
X-Received: by 2002:a17:907:d48d:b0:b4d:71e9:1662 with SMTP id a640c23a62f3a-b4f43730a39mr3130006766b.30.1760376493324;
        Mon, 13 Oct 2025 10:28:13 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d2ce9sm967025666b.35.2025.10.13.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:28:12 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:28:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v7 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <poknlppzfnzkaxkiz5schua5tuwbssaimihaht3ebvxzwxgztg@jfkdpdri6n4r>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
 <20251003-netconsole_torture-v7-4-aa92fcce62a9@debian.org>
 <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>
 <m2dwihyj3vddvipam555ewxej663brejyv5gdnsw4ks5mis2y7@2mu2gus2o7ys>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2dwihyj3vddvipam555ewxej663brejyv5gdnsw4ks5mis2y7@2mu2gus2o7ys>

On Wed, Oct 08, 2025 at 06:02:56AM -0700, Breno Leitao wrote:

> > Note that with the create_netdevsim() helper from
> > tools/testing/selftests/net/lib.sh you could create the netdevsim device
> > directly in the target namespace and avoid some duplicate code.
> 
> Awesome. I am more than happy to create_netdevsim() in this selftest,
> and move the others to use it as well.
> 
> > It would be probably safer to create both rx and tx devices in child
> > namespaces.
> 
> Sure, that is doable, but, I need to change a few common helpers, to
> start netconsole from inside the "tx namespace" instead of the default
> namespace.
> 
> Given all the other netconsole selftest uses TX from the default net
> namespace, I would like to move them at all the same time.
> 
> Do you think it is Ok to have this test using TX interfaces from the
> main net namespace (as is now), and then I submit a follow patch to
> migrate all the netcons tests (including this one) to use a TX
> namespace? Then I can change the helpers at the same time, simplifying
> the code review.

In fact, I was able to isolate the functions for the isolation in the
self test, and now I have a test that relies on create_netdevsim() and
have two namespaces, one for TX and one for RX.

The problem is that it hits a bug on netdevsim that doesn't allow it to
run properly. Basically create_netdevsim() put the interface up, and
I need to get the interface down in order to enslaved it, losing the
carrier.

I've propsoed a fix in here:

https://lore.kernel.org/all/20251013-netdevsim_fix-v1-1-357b265dd9d0@debian.org/

So, I will send a new version for this patchset soon, but, it will
probably not pass the CI, given it will not have the fix aboveyet. But
I will send it anyway, so, people can further review the patchset.

Thanks
--breno

