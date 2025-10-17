Return-Path: <linux-kernel+bounces-858056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7DBBE8B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4BE407F42
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155162DE713;
	Fri, 17 Oct 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIeF3iBh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92664331A48
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706297; cv=none; b=iug45KLdY9g28xVG3M2nvVvBJLcAN7KadoBdOM/FZY+KEEHOZONe6pKo1qLdmCzCFMJO6ZO9/EYKG3NNaPhMoCCrnJxXxjp7kQqreoxpY9wWvw4CL8SaLepYM1moa/ciY1jbEg2WAtxQMo7VpK4/2LnFvUpJLGaJUZXIc8eO5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706297; c=relaxed/simple;
	bh=D6GD96XH6c1uPDjO4m7Me2P068YTsAO1fDghSTnE868=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5OHurL2CZeJ00HOto4QPz57Ota7WKSzUs8jRQ4tOzStZlmc/oxWaNKUAT6c3X7/i+jcm3N2bVdkR/ldv8MLVj/2ZUR01kWVnFFr/HBzOTvbc3nMW4647i+fnXNTr2POcfc0OBfCG9PyLK1sTdNX2e8OigCkx9Mfa5ajMZ+xmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mIeF3iBh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-470ff2f6e56so61835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760706294; x=1761311094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/uOtMpgkdFsT3xs6ZaMKy6KvAAsnI9htzuHhcFlR9Cc=;
        b=mIeF3iBhjvybqa+34UFXUyOSILFztl5sbaR9fbSZgxEL/G0ABXqNloOD4TKtQYMWoN
         LsCAIE1hoP1w3G1AouRIWk89zrqGbevhIFl7OMcQ43jKET+Ukqi3LdYNxDu2wjwQ/aVj
         jo7Vm9CrlaCZNYE1QT1lF5WBRJ862J92GyxBUgZlVAUnc27Rnv33X+PTGeFP0vXvfvBY
         VQcrOKieLq1wlLiZYnJnGdC4H4MZYyUJX6H0tqTho2P48XfTeNdWPNKMwRTA3G/KCFti
         omXUZ8WqVaOy4hV4lGIeOnXKX1EX/UTtnV9GBB1jZOx+Qs/GgwWRr2tVCD8eVb7qjaTj
         i5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706294; x=1761311094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uOtMpgkdFsT3xs6ZaMKy6KvAAsnI9htzuHhcFlR9Cc=;
        b=NI6kPHhbhPKaC2aFx8siI6m4QpqhbEbvu5OA1CKKxcsvFUzUfxF2HQuUg379Q7XdRj
         dydVhT/wPZLCZ5ZxkztlL1cAwg9ntFZ3VygCcNiomxfPgtrUZjjcecnbxVBYhfAitOkx
         RSfyjL7yshI6uPPsN6vu+HgQtwnTteRPBrge/eXB5TRNLv+HBDpouiFEcz9htVIxtEoZ
         9GTsgSoq3zaiUibM1xKJcofYp87IGF35x9NoUWwY+GufpgHeYII4oE8dtwznyznx7roL
         Ccl9KnfTJCJci9eJ1rtzLHFrrEtOq2VOv8qFzu//IZ7LT3JOcmNZOzxdghSvig8vF3qr
         DxoA==
X-Forwarded-Encrypted: i=1; AJvYcCWyCEcFYr1xAiw34y/dSfPjLSQZkYoKUvH3QsfMSjnqRoNFXcffrUyJ+KxejDtu/9OEYvwfPNy2pVYRWLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlpCv2CnIHkzJ8rsKD3aH6kGZjAZeOjp9Z3Yy5vgp3JJ9hSQJ
	Nnu2Lg8WBbvFfOW121L3G/qaNnMjG2fGViNBn0ZMEJRnj95PP5/t659apkTzkuCdRg==
X-Gm-Gg: ASbGncvmSj7jRzKXXiU7nivRllFhLI7gQi6ABTFSaaEOJpapYIcjpblBEaBf6hy/y8H
	mLxKEop9d26uHgv4WIhBWLXKhmOTfqzIc8rpM9UIqZav613vN0t3vWCFBl4hL+JyUVpP9ur96bS
	SY9ih5jBN86BPhGka5vllsnw7Bmz4LfBstOtZP4i+NfyqqfszWxZYGlj3RR+a3zY8NZ+LfudYoj
	7BHWKNph7/BZM6oXEFJwqWZXIV+c2x/waqutnj2Z+CJlcwCjL0N3uKncljlYgMPOP5wXNQOslry
	FwWEwr/tfKunIy6YkcZ0m2RjuKqKJm/LHNeAZAxoIe0JVjOZ//lSZ9aFOrLowTeSlvkyzQ0Mzal
	f4Bu2DjZmHsJG4qW7JZuNBznNid+bhfO9ahQNum8pOM7z6CWebcaqgC/a4WbYGGX1dJoniP+h7R
	2k3W0zzRnhMzEXRLYMkR/44o4sYxpL8tZtjD91nw==
X-Google-Smtp-Source: AGHT+IHHqOInInZkrsgUSaFHEdB/oepCnSzJpUuVqDSMtpMN/dAjmVaOtZHBHO2hfRyQeEAhX4nWOA==
X-Received: by 2002:a05:600c:c117:b0:45d:f51c:193 with SMTP id 5b1f17b1804b1-470ff2e9797mr4996635e9.7.1760706293693;
        Fri, 17 Oct 2025 06:04:53 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5d48sm83222295e9.9.2025.10.17.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:04:53 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:04:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aPI-8YfqC83QlltH@google.com>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com>
 <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
 <20251015151002.GH3938986@ziepe.ca>
 <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>
 <20251016172524.GN3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016172524.GN3938986@ziepe.ca>

On Thu, Oct 16, 2025 at 02:25:24PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 16, 2025 at 06:17:35PM +0100, Robin Murphy wrote:
> 
> > In this case AFAICS kunit_device_register() can only fail due to OOM or
> > something unexpectedly messed up in the kobject/sysfs hierarchy, all of
> > which should already scream (and represent the system being sufficiently
> > hosed that any actual test results probably no longer matter anyway) -
> > otherwise I would have suggested a kunit_err() message too.
> 
> Yes, I think so too. Which is why I think the simple
> KUNIT_ASSERT_FALSE is fine - we don't need to over think something
> that should never happen.
> 
> Basically it is a simple logic for the test writer, any thing in the
> test body that doesn't work as expected triggers a
> KUNIT_ASSERT. Infrastructure included.
> 
> At least that is how I've written all my tests so far, including the
> userspace ones..

Maybe as Robin suggested, something as:
	if (IS_ERR(dev)) {
		kunit_skip(test, "Failed to allocated device!\n");
		return;
	}

Is simple enough and verbose and can distinguished from test failures,
it will look like:
[    2.095812]     ok 1 arm_lpae_do_selftests # SKIP Failed to allocated device!

Thanks,
Mostafa


> 
> Jason

