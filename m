Return-Path: <linux-kernel+bounces-841098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0652EBB6424
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B969619E7ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432E275864;
	Fri,  3 Oct 2025 08:45:14 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58582273D8A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481114; cv=none; b=cNngc5qJv4A7J/coDvLh9Y6wqtfKm4mpmri1gR71abh1D881X//K34Je10RpPA2YIY5Haik6I5KWAclE11NYZSiyeL7A8mej9OekgPha1cumjImwnYP6EBDFoQ8Ozv0O+S505cV3m/S+yGDcQdy5Nfx7clAI0nKPHwi+ft3N9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481114; c=relaxed/simple;
	bh=YB1ghMEOeQ5JFYWeY2ps8djFxf5/HuRtlXBeq/CH+jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3lTW+J845NINvNvnvmQAXieILLUvFgPjSnh9Iag0ff6eB+Ko835E3F5YHtbLJiFsMdKEyQpOyl0L447rBr9slpKoK3rweRR2r6HdWi9eZrVUf9lQ7/G2kZKYS58RBaf4LKMiGhpQPGThQG/IFPvN8iHeh61HqUvj9IH1cpMl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-637ef0137f7so2430990a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759481110; x=1760085910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNchDiEzIDmBEztmo8oZmioyYgfq18ckj4ZJE8yTj5I=;
        b=l8GZ65QojlMz42+srGE+xIC2s/0VE5UipOKcJfbu/1H3U64AarmeK/F0g0JqhYVGCD
         7X2clMORW4Cp9XYBLxSRzO8O9jc4RjmWWGDYXkFyUwvjLVVP9p14BloHi11HXYN24+Js
         Y8cL6hQ1Zbw2Rcj+AwyJHYW01/aciyNuTGoehHdRSTkImYhbeAOydflinTfY9oz27Dtc
         IcxlOWtuB2Ba2kwippwUiLz58lE2JrKfavRnccZkuKyV5bKDOjrakz2sQaf1OFEXCs5L
         RKWUR3m2QqlxHJovAynY7i2qSd/popcC6qJLJefdDa2PrJn6uUZC76qoHAsUj5SS2pwM
         Z3OQ==
X-Gm-Message-State: AOJu0YxsZl0K68NKXRvbZ7nEl4nDqS8BRcgTjlYWsMBrSCzadLMIso0G
	OeYDNEUaP3q/blmU50VbmF734g5l3ePwtvmtUxgdEvDxWC2xoWM7xict
X-Gm-Gg: ASbGncvHQYj5jAwQqU3ClVaY8WVWob5BNwM8/HoD3U9zPIARngfo6mg84mMtFQAm8/o
	bvHM2cq2aqkjYKCNn3NqepRRUxomdARInmUhsvXzKu2060M8A2GqA3JB2wvaHLigrAKmjfAtzlz
	9YkmrCJmv3CBR2BfJ/mpR/IlPK/YTl2+m8krZPRyz0w7B17P0Qgu141KwAnvgk03aVXAt3J4ZQh
	ItJuoAnMDAgE6lUnKFo0KM4n2kl1IoYbIxNTGmfaGy8mhOqV/vAVgwXe6xgx1wiWFiRkyo9lA7J
	rbLPFsmWf2tZCy1lFH4o+ugufcl+QRIY0PH0dOcKhrOLBzUYJiGVAMUjEmbeAcT2i6ub0YwDCCV
	fnJUIRNYmXJFO4WuGAfquFw1twB66RvRanuUGVw==
X-Google-Smtp-Source: AGHT+IGjw0zmq2CU/sdA/VkxJILpqI/TtLALso31v4P2kiwd0BksUPICZg/6K3fI5iB1htfz3dZPgQ==
X-Received: by 2002:a05:6402:5347:10b0:634:5297:e3b3 with SMTP id 4fb4d7f45d1cf-63939c509b6mr1714584a12.38.1759481110436;
        Fri, 03 Oct 2025 01:45:10 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811f14bsm3554826a12.45.2025.10.03.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:45:09 -0700 (PDT)
Date: Fri, 3 Oct 2025 01:45:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net, stable@vger.kernel.org
Subject: Re: [PATCH net v6 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Message-ID: <s4lrro6msmvu3xtxbrwk3njvmh4vrtk6tmpis4c5q5cbmojuuc@pig4xhrvhoxq>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>

On Thu, Oct 02, 2025 at 08:26:24AM -0700, Breno Leitao wrote:
> Fix a memory leak in netpoll and introduce netconsole selftests that
> expose the issue when running with kmemleak detection enabled.
> 
> This patchset includes a selftest for netpoll with multiple concurrent
> users (netconsole + bonding), which simulates the scenario from test[1]
> that originally demonstrated the issue allegedly fixed by commit
> efa95b01da18 ("netpoll: fix use after free") - a commit that is now
> being reverted.
> 
> Sending this to "net" branch because this is a fix, and the selftest
> might help with the backports validation.

This is conflicting with `net` tree. Rebasing and resending.

