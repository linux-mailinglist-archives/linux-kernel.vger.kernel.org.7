Return-Path: <linux-kernel+bounces-856698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F808BE4D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86C2542563
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A123EAB3;
	Thu, 16 Oct 2025 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DHZy6byl"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29969334693
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635528; cv=none; b=cc/rhajfTuApulnMnkL3HRckgNrwGXGmZGQgrJ/hljW0pkIiHbuW5RhA+redrj0uf+EwBvRzgCujecEQEQZqX62vfrYqG/4+WQiv+pG/RBY89kFgOMXqE2Hu6M4w/AQ81Al9qa4kuM1dJxpnMMeyBz8fjhfwNWznqEHG6V5OWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635528; c=relaxed/simple;
	bh=/EEkjyX2e9oSevCPubP9u1AVb3Rr9e/hCPzwvqQK/fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZegIdEtcCJ6eiF172FuJEgMz3ijyHmtdOUlZiX4Orig3xSctG2z4MKneX/559eTARvDyZUq9iWMg0ZAoa2XWuJuy+jYELJc7xdt2cCxZSv6SJ/4+C5c4HAE+tk3doVxhDi1yhWHLGYkH7AUs2sZjucbtb1iK4uVXTcXojeqh3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DHZy6byl; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c1f3f4373so9812676d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760635526; x=1761240326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/EEkjyX2e9oSevCPubP9u1AVb3Rr9e/hCPzwvqQK/fY=;
        b=DHZy6bylDIGisAXacBg9yhTArJZ/AJpJeAkVP1yzlJJmUyam8V0D1NW2mvybjDg6X9
         9PJz2tsDrCtCbtEfqEtP+pHwKeLOko/C7ejWX5B30C+biDmF2Tcbdf/v1EeX735tAlOW
         x45vxo8bhyHvkHjbzwSoZHKh0TMg30EUQCpdMil+pqFcThiOFZr+dFkMlXyCZiOV0buV
         7ei4OeX8JT/sLa8IvwX8LgqxKQ2tLRKaJsq05Qif/AT9Fna12mkAXN4UvbW31Z9cLmmP
         qGviEK4oG3g++7vGOW9kHwxUUMk1vDYBv/Cm41c16xrOG7bSOqjRuWz6eB8w2XnKQX6m
         FuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635526; x=1761240326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EEkjyX2e9oSevCPubP9u1AVb3Rr9e/hCPzwvqQK/fY=;
        b=CHVP3qS2JpexG+1uyWFIpDXhqbcMT2iPI5kejoNTyvzHkpCEpWsuIqccbUHK8aEd3b
         wQwhWYcaKejmTUAwFSYldzs1EggJF0FxD7WXAltWsq7WtDhUzxfXgb7APtJeKpRHSSoW
         b4/Z6ija4luodq1WnO2RrLZ1n1PbzhmamoHJZIClQ2Zjoi1GRwka/8o0ckP7/Uj6UEDS
         Q2BIbzSrsfxE9KUx5spSmKKT2C9IBJ8lXLPdllrwddixtRVO/sTwGjwJbX/an9/YF38E
         /4a1litpq5rwFdu0cOPIyoNpG7weUStUsGXrsyVJIbt/n+93g5MaUuClozw4MZrmTZ4+
         L47g==
X-Forwarded-Encrypted: i=1; AJvYcCWBCxzNKxZTmF5ff2eM1SAky+uANp4X3V2ZedOXEDVUCKmc+QuEB4rY+oyrK/9Qda94cZkEP/ad6xmYQ8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVGgmDTgomRW25q7flh6mZq0jPCQIba+DRHXSr7uwk9RZUbRG
	7CnO4vq3D7pzcisAIOuwLucj9yTVzU6fbOdDtTP04zH7FojQjFDr3JcpJShuQTWZgCc=
X-Gm-Gg: ASbGncs4LNuXAs8src0ONMYCoS7cp26jSRSb2pU8XmK3SxINfcQdJ+lIWKzOFXrD2GV
	7IB8LpbG8A2Qa/muXOSElEmHpLn36NqVdrHVrhWedhaO4o+SUhj8UBop55dlZdJMo1EPzs9idE/
	nJye0k2p7i5MfAGfpGb4kX9ZzNoXlbyrPIfmzTFbzd8f3apd98w7Tg2R2ZN+2wJ9EXM6WUaUnL0
	CEaSQaFXmNPMAUT5yrl5wdH7J6SRma57mQHZRJ2MGt0bqx4AVjkCSPfFKBFn9QtZRL4CJJO0f50
	r6AkRZI6r6rBluMX/jdJBtb5en2njwD8xbkQ9rpgPlCYDYitIdr0ThyzoZY/QmOCsbyrvpHIdV5
	zOsebjJFYK6NL04UdJwatqrwBKPzMHmyn+VYC/zFRWidhcDCnSE7WEbWMEgk5
X-Google-Smtp-Source: AGHT+IHksrcKVBUhwjEbvljPYvDE0IZujaCH4Ti9W7M9s4IST+pF0PoGvC9Lpt9Kwo2sVKgzxbWPyQ==
X-Received: by 2002:a05:6214:319a:b0:87c:2206:2e3d with SMTP id 6a1803df08f44-87c22062f05mr5415776d6.25.1760635526001;
        Thu, 16 Oct 2025 10:25:26 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0121f891sm44222226d6.24.2025.10.16.10.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:25:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v9RjA-00000000Wrr-3Ipa;
	Thu, 16 Oct 2025 14:25:24 -0300
Date: Thu, 16 Oct 2025 14:25:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <20251016172524.GN3938986@ziepe.ca>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
 <20251015151002.GH3938986@ziepe.ca>
 <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>

On Thu, Oct 16, 2025 at 06:17:35PM +0100, Robin Murphy wrote:

> In this case AFAICS kunit_device_register() can only fail due to OOM or
> something unexpectedly messed up in the kobject/sysfs hierarchy, all of
> which should already scream (and represent the system being sufficiently
> hosed that any actual test results probably no longer matter anyway) -
> otherwise I would have suggested a kunit_err() message too.

Yes, I think so too. Which is why I think the simple
KUNIT_ASSERT_FALSE is fine - we don't need to over think something
that should never happen.

Basically it is a simple logic for the test writer, any thing in the
test body that doesn't work as expected triggers a
KUNIT_ASSERT. Infrastructure included.

At least that is how I've written all my tests so far, including the
userspace ones..

Jason

