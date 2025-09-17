Return-Path: <linux-kernel+bounces-821529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D808AB81878
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEB57A0335
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D03445AF;
	Wed, 17 Sep 2025 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Cdj9EBJB"
Received: from mail-qv1-f103.google.com (mail-qv1-f103.google.com [209.85.219.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABA344584
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136363; cv=none; b=Sx+/hMlru/1xe4keqWPjldmL92KlM7fKe0Q0eIsow6CTvJGKi+rRGax0mPgA6oC9jHMF/7/MEJxP0faWBuZY6U0RgU/NCwi2QuLkOsZ3e/lT77eyDRpCzi2Px5jODOxjg7VQWgrpqZkiZELYl7G7Z7BDtjS8hKMpFZm40xLUQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136363; c=relaxed/simple;
	bh=1vjvrErixwiivd/wzISzOVvkbt76yybwtaJToh3tQxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV3ATk2E0Rv57+2+TTMUxrswDLxpY1+g2hROsEEPvxe88hjTBX15VOioKKum2E+Mw2hV5zqHn+2WVqKvcv9mKa1921lf0YZKvHBS80BNNi/DcqhHucnfWggFpi2p3snkcbrjX3lL8sgYvZ0//0Pm7eVknLTs86owB6+8w1LCHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Cdj9EBJB; arc=none smtp.client-ip=209.85.219.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f103.google.com with SMTP id 6a1803df08f44-78ed682e9d3so1588786d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758136358; x=1758741158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YUffZOSE0pIs8q7STk7EsoZEDkYGtOkYWeXrF7MZ/ro=;
        b=Cdj9EBJB0GAJY4Ig4TwZSZXpXr1SeTdQphNglugm09ntSAr5u2AJbNUpFAIKw7IdWC
         BJ4Hj/4f0JZFWYkWnxZONPomfNwdfQZI5kOfDTAUqdyXZKPP7IaeP9COa9H63N/HZWDO
         GLvIxGG+FnRaI8/xx3dxB6d8AVm8xSLaYrZoIb8b4TWRX0zEXiMuXJQ3zHEVoPlCs3r8
         /iTBm9wv5R4FiV/jN5tT8o2+g+JWmODnlYZOOTAtgpYMlcWpUWJGWZhEuLlvC8h7rYYY
         Rt9O3Z6XJTOLbSIEY0CuvPJWosxtX2fIBpFoMLcD4rTg2OEWmM09Ky1UBDjNL5OQ88Hw
         Kd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136358; x=1758741158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUffZOSE0pIs8q7STk7EsoZEDkYGtOkYWeXrF7MZ/ro=;
        b=Q2eYA0Hpd+SDK7taSULiZEBxh9k6r5U7lwjTgmp1pTBRQv2wzq7KJ4TDnSzjgNZHrN
         A1Pz0gNmOYCoqeBfdShFbXEw0b+MOjKRve3eGwkCbP29VUgqG6mYoo/QQdX34jdyD6s6
         sRAu4k6I8Jq6UqAvmmzq40En8HBahNpUj0HeqMvlDEKE4VQ6/ajMT80GM6KNUFPLkLk0
         lvdGhpdCXllvTFMOAjD4lp43KZqUDOqORHKtVgECl/ZFBx+vvGnqD2UonlE4tWetaDVi
         i6BFWoYE038/6FF8/6g+I8rKikXrq1o7XkBrfYMdnULC++b86BzMrLitpPzK7FhIGGFo
         OsMg==
X-Forwarded-Encrypted: i=1; AJvYcCUL2lXarn+Bm+aWQzv5gnd8uiyaIRiYzvojIyL+E/n3fuWvYdJhKXGOmih3GE8Xzwc7/QUCn5PzTgp6vWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh71w1stgEXraVJJh/35B/EedWMhMUcNcRgAs2E9WwW1vd0TY7
	plCMIH661L4N2QPRZBGGeFg7g1r98mHn98tEVFs3iziOgZNCGi0XyL9Ec+wjZTmzV4BeUI/OlO3
	5FOg1pLjbBCNW9XvlN/9OQv2yzT863oexlpZpjNeiPBeV0AOTzSn4
X-Gm-Gg: ASbGncthXYg+NMBtEb8SZxnuV85w+FAIzhh+KCBzJKqkByjP/f3WvTxseHBqbCylGWs
	8DcWqDt+JYx1moeABkVh2Ul4lyWa3TOgKynIH0Pz6Iyj5Qaj1sgF0a4QyQ5NH5Tq3LJW0yBw6Sd
	LaaubtcAhj3u9UveYjB9GYQxUAl460H3gs6lL5rfxPrRYR6ANkNXOYkZQ6BF30qQ04N0aHuQobH
	LOiIpsfSsOXr8bwRaydnRGu5mNKDatkkwOmuFaB1HlelkP+eLdlIFNHbM3NV/0MQg0kdPZVPWFf
	rxPBDFVZ5+YPbFFBecmsI7VKsZBfkJviEBLgo3jA51UD+xB6B0Dmw6HqEyE=
X-Google-Smtp-Source: AGHT+IF5aUvuj1zf+TNucQKa06iCuoRLrdGNIbKzVNhnsAz2hDf+JpWhBo2wnu2LTf3ORroElcN4PqQUofmw
X-Received: by 2002:a05:6214:d85:b0:766:ab7c:3e89 with SMTP id 6a1803df08f44-78ecf4fe6e5mr32679866d6.64.1758136358312;
        Wed, 17 Sep 2025 12:12:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-793456ffd82sm107916d6.15.2025.09.17.12.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:12:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A6DD234052F;
	Wed, 17 Sep 2025 13:12:37 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4FFC2E40305; Wed, 17 Sep 2025 13:12:37 -0600 (MDT)
Date: Wed, 17 Sep 2025 13:12:37 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: ublk: add test to verify that feat_map is
 complete
Message-ID: <aMsIJXDRhkRWDH1m@dev-ushankar.dev.purestorage.com>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
 <20250916-ublk_features-v1-3-52014be9cde5@purestorage.com>
 <aMowhqjOND9EdiKh@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMowhqjOND9EdiKh@fedora>

On Wed, Sep 17, 2025 at 11:52:38AM +0800, Ming Lei wrote:
> On Tue, Sep 16, 2025 at 04:05:57PM -0600, Uday Shankar wrote:
> > Add a test that verifies that the currently running kernel does not
> > report support for any features that are unrecognized by kublk. This
> > should catch cases where features are added without updating kublk's
> > feat_map accordingly, which has happened multiple times in the past (see
> > [1], [2]).
> > 
> > Note that this new test may fail if the test suite is older than the
> > kernel, and the newer kernel contains a newly introduced feature. I
> > believe this is not a use case we currently care about - we only care
> > about newer test suites passing on older kernels.
> > 
> > [1] https://lore.kernel.org/linux-block/20250606214011.2576398-1-csander@purestorage.com/t/#u
> > [2] https://lore.kernel.org/linux-block/2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com/t/#m1c520a058448d594fd877f07804e69b28908533f
> > 
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile           |  1 +
> >  tools/testing/selftests/ublk/test_generic_13.sh | 16 ++++++++++++++++
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> > index 5d7f4ecfb81612f919a89eb442f948d6bfafe225..770269efe42ab460366485ccc80abfa145a0c57b 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -20,6 +20,7 @@ TEST_PROGS += test_generic_09.sh
> >  TEST_PROGS += test_generic_10.sh
> >  TEST_PROGS += test_generic_11.sh
> >  TEST_PROGS += test_generic_12.sh
> > +TEST_PROGS += test_generic_13.sh
> >  
> >  TEST_PROGS += test_null_01.sh
> >  TEST_PROGS += test_null_02.sh
> > diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/testing/selftests/ublk/test_generic_13.sh
> > new file mode 100755
> > index 0000000000000000000000000000000000000000..ff5f22b078ddd08bc19f82aa66da6a44fa073f6f
> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_generic_13.sh
> > @@ -0,0 +1,16 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > +
> > +TID="generic_13"
> > +ERR_CODE=0
> > +
> > +_prep_test "null" "check that feature list is complete"
> > +
> > +if ${UBLK_PROG} features | grep -q unknown; then
> > +        ERR_CODE=255
> > +fi
> > +
> > +_cleanup_test "null"
> > +_show_result $TID $ERR_CODE
> 
> What if the ublk selftest is run on downstream kernel?
> 
> Maybe the output can changed to "unsupported" to show that ublk selftest
> code doesn't cover or use this feature.

Yes I pointed out this issue in the commit message too. But I am unsure
what you're asking for.

I think we need a failure here if this test is to fulfill its intended
purposes (catching cases where a feature is added without updating the
feat_map in kublk). This does also cause failures in cases where an old
test suite is run against a newer kernel. Since I think this is an
unusual case, perhaps I can add a log line when this test fails saying
that the failure is expected if running an old test suite against a new
kernel?


