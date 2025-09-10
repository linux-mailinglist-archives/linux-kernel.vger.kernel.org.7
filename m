Return-Path: <linux-kernel+bounces-810993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE6B522C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5C9585875
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED26324B29;
	Wed, 10 Sep 2025 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zdx+ye3B"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC743203B5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537086; cv=none; b=q0NQHbh9AJkNVdoA+YjNy68ymC0hL+VWY2RV4dFZNWS/yE9wqAcZDK6j4n0GBXpZYcqYEjFS16si/OmdP+60ceZvGknz6vsXJ4A44ay+jA3Q4ofl8Zs3JntclfJuVNwHfpCJcj+L2O2wO1zrkK6vrgLGtya+HjLPghVdVITQm8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537086; c=relaxed/simple;
	bh=jKvZ0sP0nxR8T7mOsZSu3Nb1qAMgg+mb7LxigOIxVK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0+RQMcCI2OOt+sVpLiLCNb3WeyiJLh9MHdu7YQVpCTkck0gpVPJwQV5M8yAPup/bwhF5UEUcqWsOHa8dKK90WM0xrUsv84XdnrcUo+PX1mML5ECEVMyFT+SCLRaYWnp8uSkkBWTonZAAGHLZf9Q+av6MsXvJ2PiR0sa3hcqLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zdx+ye3B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24c8ef94e5dso324445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757537084; x=1758141884; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+RmsjXY0G9bTmGgcttoyEOhih/llw4M0qDu2slIcVSs=;
        b=Zdx+ye3BhsZ6F5kUtwHWSpLjBZbzoj4y98zTU0ldfIneZlMNsiwO2nvSHp6BGjeKw2
         UhVi86v0muqzjTr03WOaJJ+iiSgmoT7pf2utqnUlnZ+f9OQwIbMvPnQZ4B+o0Et5XLAT
         r1WvuQL2gq8JfOfd3i9ygQKSdjOV9MObncoqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537084; x=1758141884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RmsjXY0G9bTmGgcttoyEOhih/llw4M0qDu2slIcVSs=;
        b=pO547qrgiyOffl7NX1hryv8MCRGLiRLIQB9tsUCiwLOi0Gifh+oB70tYGaS/x9od6Y
         8T7a4JVTNOly4rIOGYnvAlKkXpOgpudZF3s3aVb0kBLjX6unKImZToKTlNaCHKPJ6hkl
         qFEREncFJuXU4nZikiY1E4Ba0kKoA9OxK9OKxSAGYzuevnB27KDNSMkKVre2s9PGBvag
         +gFBxT9A6U7KX17d0tLcx0c7vWXcQxsbgKQXnABsjoa5pTUwvI6aaG3uKDqp2rRorio9
         YdgbN0unCmllu/qYDMElWKQoOQC+FfRM5+YKZy9ABZKMZbp7k0rKsf8Lr7KVPymDQGio
         iaFw==
X-Forwarded-Encrypted: i=1; AJvYcCXI5c7Ij9VGpyTJPuW6HJBMsq61LOpcgLOqdSuMBMNbNCMbRYunu8l9O/7O+0PHH/0+6E+nf0h4HOg0HPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vIUKCznmCR0358QJ0KAicJFRD+m0cJhnu0RvBv1ub2bKubhU
	SisQ6j2TqDpi3eUZ7buEUa+9AKeJ+rnF+EjIpU0zCP/A3whYPc7QWAk3UE06GrIKgw==
X-Gm-Gg: ASbGncvE35CHY9iSr/Rz+jq/9NNMIxUVhUZao2wazgu1U6i5xpt3sQ2BTGyJ6ydayem
	0adIJQNBZOUYiB1MTeQM0laFD66l/JIp6keJJdTaKaDtNxfwTH+xQfz9W9zlfSqN9LKSJeAFAkf
	qCTyxgv2waYj4p/7gbILhWa342cYZg00q4cQcH4rTenZUMQQ4VNiwc8u5y5nnjhrLbjqEXjg9wo
	yQX9MwAjQWY19rKh+FvUx5Y7v2UsN1d03BDFIIGdzw43Jao4vyhtiy/IprKjOHicAVps8yESege
	EKR/b4jldZGqTWm6R80gdL3yLRNnPAYmAknap6snc7tvC34xiFJPNyOfcaFxvSBmWVpdsxgs+5V
	HuDlYh5mU8Z2NW1EmXpr7XDsoXZkLFueD98HGe9mOY11XumrbNCprqqqN8H9v
X-Google-Smtp-Source: AGHT+IE/EPPXLgqoqfdSwHOGiaDgCJL6UIz4/iAcySpXxLMRer18kYJ/ELk7olAHtNwyhwC/677RZw==
X-Received: by 2002:a17:902:f687:b0:24c:cf58:c5d9 with SMTP id d9443c01a7336-25bab92d0e4mr8515905ad.1.1757537082722;
        Wed, 10 Sep 2025 13:44:42 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:4780:f759:d36a:6480])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25a2a3449f7sm36380115ad.88.2025.09.10.13.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:44:42 -0700 (PDT)
Date: Wed, 10 Sep 2025 13:44:40 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PM: runtime: Add basic kunit tests for API contracts
Message-ID: <aMHjOJGaKi9cwbsn@google.com>
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gGKsR0bVayyTXy1W9FLwVfG1S+gseH7jPKtggzZFNpfA@mail.gmail.com>

Hi Rafael,

On Fri, Sep 05, 2025 at 07:37:38PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 29, 2025 at 2:33 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > In exploring the various return codes and failure modes of runtime PM
> > APIs, I found it helpful to verify and codify many of them in unit
> > tests, especially given that even the kerneldoc can be rather complex to
> > reason through, and it also has had subtle errors of its own.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> This is nice in general, but I have a couple of questions/comments (see below).

Thanks for looking. There's certainly some matter of opinion on how
exactly to test things, and I'm still getting up to speed on some of the
runtime PM API details, so I appreciate the care you've given.

Replies inline.

> > ---
> >
> >  drivers/base/Kconfig              |   6 +
> >  drivers/base/power/Makefile       |   1 +
> >  drivers/base/power/runtime-test.c | 259 ++++++++++++++++++++++++++++++
> >  3 files changed, 266 insertions(+)
> >  create mode 100644 drivers/base/power/runtime-test.c
> >
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 064eb52ff7e2..1786d87b29e2 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -167,6 +167,12 @@ config PM_QOS_KUNIT_TEST
> >         depends on KUNIT=y
> >         default KUNIT_ALL_TESTS
> >
> > +config PM_RUNTIME_KUNIT_TEST
> > +       tristate "KUnit Tests for runtime PM" if !KUNIT_ALL_TESTS
> > +       depends on KUNIT
> > +       depends on PM
> > +       default KUNIT_ALL_TESTS
> > +
> >  config HMEM_REPORTING
> >         bool
> >         default n
> > diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> > index 01f11629d241..2989e42d0161 100644
> > --- a/drivers/base/power/Makefile
> > +++ b/drivers/base/power/Makefile
> > @@ -4,5 +4,6 @@ obj-$(CONFIG_PM_SLEEP)  += main.o wakeup.o wakeup_stats.o
> >  obj-$(CONFIG_PM_TRACE_RTC)     += trace.o
> >  obj-$(CONFIG_HAVE_CLK) += clock_ops.o
> >  obj-$(CONFIG_PM_QOS_KUNIT_TEST) += qos-test.o
> > +obj-$(CONFIG_PM_RUNTIME_KUNIT_TEST) += runtime-test.o
> >
> >  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> > diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
> > new file mode 100644
> > index 000000000000..263c28d5fc50
> > --- /dev/null
> > +++ b/drivers/base/power/runtime-test.c
> > @@ -0,0 +1,259 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2025 Google, Inc.
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/pm_runtime.h>
> > +#include <kunit/device.h>
> > +#include <kunit/test.h>
> > +
> > +#define DEVICE_NAME "pm_runtime_test_device"
> > +
> > +static void pm_runtime_depth_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       pm_runtime_enable(dev);
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_get_sync(dev)); /* "already active" */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +}
> > +
> > +/* Test pm_runtime_put() and friends when already suspended. */
> > +static void pm_runtime_already_suspended_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       pm_runtime_enable(dev);
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       pm_runtime_get_noresume(dev);
> > +
> > +       /* Flush, in case the above (non-sync) triggered any work. */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
> 
> Why do you run pm_runtime_barrier(dev) here?  It is guaranteed that no
> requests are pending at this point.

I suppose my thought is as somewhat of an outsider, that's not really
familiar with exactly how each API is supposed to work. So without
looking into the details of the implementation, it's not clear to me
that a "get_noresume()" will never queue any work. Admittedly, that's a
pretty weak reason.

OTOH, it does serve to test the 0 side of the API contract:

"""
 * 1, if there was a resume request pending and the device had to be woken up,
 * 0, otherwise
"""

So IMO, it's a reasonable thing to run in this test, although I probably
should drop the "Flush" comment.

> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> 
> This has already been tested above.

I'm not really an expert on unit testing and style, but the whole point
of this test (named "already_suspended") is that we're testing each
operation when the device is suspended. So it's many series of:

1. set up some precondition
2. assert that the device is (still) suspended
3. test that an API returns the expected value for "already suspended"

Even if #1/#3 aren't likely to affect #2 for a later sequence, it seems
like a good pattern to actually test that this continues to remain true
each time. If the test changes in the future such that we perform
something different in #1, we might find ourselves not testing "already
suspended" behavior in #3.

Alternatively, I could split each #1/#2/#3 sequence into its own
subtest, but that might get a little excessive.

Anyway, like I said, it's probably some matter of opinion/style. I can
drop some of these checks if you still think they have no place here.

> > +       /*
> > +        * We never actually left RPM_SUSPENDED, but rpm_idle() still treats
> > +        * this as -EAGAIN / "runtime PM status change ongoing".
> 
> No, this means "Conditions are not suitable, but may change".

I'm just quoting the API docs for put():

"""
* * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
"""

If that's the wrong language, then we should update the API doc. At any
rate, I'm not sure what's "unsuitable" about a suspended device when we
call put(). It's not unsuitable -- it's already in the target state!

Notably, I'm also changing this behavior in patch 2, since I think it's
an API bug. And the comment then goes away.

> > +        */
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put(dev));
> > +
> > +       pm_runtime_get_noresume(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> 
> This has been tested already twice and why would it change?

Addressed above. I can drop it if you think it's excessive.

> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_request_autosuspend(dev));
> > +
> > +       pm_runtime_get_noresume(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> 
> There's no way by which it could change above.

Same.

> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync_autosuspend(dev));
> > +
> > +       pm_runtime_get_noresume(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
> > +
> > +       /* Grab 2 refcounts */
> > +       pm_runtime_get_noresume(dev);
> > +       pm_runtime_get_noresume(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       /* The first put() sees usage_count 1 */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
> > +       /* The second put() sees usage_count 0 but tells us "already suspended". */
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> 
> Again, there is no way this can change in the whole test.

Same.

> > +}
> > +
> > +static void pm_runtime_idle_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       pm_runtime_enable(dev);
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       pm_runtime_put_noidle(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
> > +}
> > +
> > +static void pm_runtime_disabled_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       /* Never called pm_runtime_enable() */
> > +       KUNIT_EXPECT_FALSE(test, pm_runtime_enabled(dev));
> > +
> > +       /* "disabled" is treated as "active" */
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +       KUNIT_EXPECT_FALSE(test, pm_runtime_suspended(dev));
> > +
> > +       /*
> > +        * Note: these "fail", but they still acquire/release refcounts, so
> > +        * keep them balanced.
> > +        */
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_sync(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_put_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume_and_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_request_autosuspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_suspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EACCES, pm_runtime_autosuspend(dev));
> > +
> > +       /* Still active */
> 
> Still disabled rather.

Ack, will change.

> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +}
> > +
> > +static void pm_runtime_error_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       pm_runtime_enable(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +
> > +       /* Fake a .runtime_resume() error */
> > +       dev->power.runtime_error = -EIO;
> > +
> > +       /*
> > +        * Note: these "fail", but they still acquire/release refcounts, so
> > +        * keep them balanced.
> > +        */
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_sync(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_put_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume_and_get(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_request_autosuspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_suspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EINVAL, pm_runtime_autosuspend(dev));
> > +
> > +       /* Still suspended */
> 
> Error is still pending.

Your statement is true, but I'm not quite sure what you're suggesting.
Are you suggesting I should

	KUNIT_EXPECT_EQ(test, -EIO, dev->power.runtime_error);

?

Or are you suggesting I change the comment?

I'm thinking I'll do both.

> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +       /* Clear error */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_suspended(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, dev->power.runtime_error);
> > +       /* Still suspended */
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_barrier(dev)); /* resume was pending */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put(dev));
> > +       pm_runtime_suspend(dev); /* flush the put(), to suspend */
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_resume_and_get(dev));
> > +
> > +       /*
> > +        * The following should all "fail" with -EAGAIN (usage is non-zero) or
> > +        * 1 (already resumed).
> 
> The return value of 1 doesn't count as a failure.

Hehe, sure. I suppose that's also a matter of unclear docs, because for
some of these, the kerneldoc specifically says 0 is success, while 1
doesn't really say whether it's success or failure. One has to infer
that "already resumed" is essentially "success" when requesting a
resume.

I'll try to tweak the language.

> > +        */
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_idle(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_request_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_request_autosuspend(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_suspend(dev));
> > +       KUNIT_EXPECT_EQ(test, 1, pm_runtime_resume(dev));
> > +       KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_autosuspend(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_sync(dev));
> > +
> > +       /* Suspended again */
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +}
> > +
> > +/*
> > + * Explore a typical probe() sequence in which a device marks itself powered,
> > + * but doesn't hold any runtime PM reference, so it suspends as soon as it goes
> > + * idle.
> > + */
> > +static void pm_runtime_probe_active_test(struct kunit *test)
> > +{
> > +       struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +       KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_status_suspended(dev));
> > +
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_set_active(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +
> > +       pm_runtime_enable(dev);
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +
> > +       /* Flush, and ensure we stayed active. */
> 
> There's nothing to flush though.

Ack. I'll reword.

Brian

> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
> > +
> > +       /* Ask for idle? Now we suspend. */
> > +       KUNIT_EXPECT_EQ(test, 0, pm_runtime_idle(dev));
> > +       KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
> > +}
> > +
> > +static struct kunit_case pm_runtime_test_cases[] = {
> > +       KUNIT_CASE(pm_runtime_depth_test),
> > +       KUNIT_CASE(pm_runtime_already_suspended_test),
> > +       KUNIT_CASE(pm_runtime_idle_test),
> > +       KUNIT_CASE(pm_runtime_disabled_test),
> > +       KUNIT_CASE(pm_runtime_error_test),
> > +       KUNIT_CASE(pm_runtime_probe_active_test),
> > +       {}
> > +};
> > +
> > +static struct kunit_suite pm_runtime_test_suite = {
> > +       .name = "pm_runtime_test_cases",
> > +       .test_cases = pm_runtime_test_cases,
> > +};
> > +
> > +kunit_test_suite(pm_runtime_test_suite);
> > +MODULE_DESCRIPTION("Runtime power management unit test suite");
> > +MODULE_LICENSE("GPL");
> > --

