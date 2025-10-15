Return-Path: <linux-kernel+bounces-854469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D512FBDE758
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A7DE503C38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CAC326D79;
	Wed, 15 Oct 2025 12:26:26 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4F324B30
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531185; cv=none; b=UMY8/RGp3Sp43IfdnfTaTYXuqbfpwsd4ufvLfP6MjUN3g8W7D1tObnqrVyTUlYnc3eQDYSmydI7F+Uow6kQYx0hgHxL0GLtK7Ya6qe/c0u1HeU4s0goM4roUuJsTZQVZ+Q4V0dRJ7tKTulyvLy1tpimD3ECne+xVpJXYwBbMHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531185; c=relaxed/simple;
	bh=IMfcknDJB0UOHWZ7tIIMN5Yxi04OQoJ/I4+6wpNumKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7924LWvJzijlBJOF4mO8regHKBtsNIzQV/ebkUbmq+fS1pCJ6bVCpZN+PMC3IdizhYbdmnC1kVg/eo+KYFQ32l9sDtfhDflPignIMr7JAg+DEn1Bo+E4vQI0i8x3vpNhlTosKT7R11VlU+z8Ol74vwwq+bh8boZuoCVitc+UWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso1583178a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531182; x=1761135982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRloKA8na02gpFAHevugN2xsMZ26S2/fWI8LdYKdlfE=;
        b=E1xIpjxBvnIlBko1k67S1jUlFe9w3wYD0MBdraTFt33m6iQ3u8ooKhOt9SBWUC8gIE
         +y0IjllcO73Vy4vZwQNwBjKrbgw9PpG+Kb6wf4xXBtAEuNnKDsY2K/aL5y7RssfNX3/G
         a+Guoldn1zga6fQVohYTJ8CMoXoqXO+6jJMwM4cP/+MnYEXEDoPWj2n8+SlKWHZjuBic
         QglM6hkTGO+yuhaE6V627BfVF53pKIYjL03exydskFAxrFBuMqkr0anl/aaUkXvtsKo4
         o3AvruVA1Zj4mHWdUt+saTMyN2D/akTejpuN1VJCVkqSx6Td3K3xnShQc4Ml/T/IUubK
         s+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVg8xdnL/Jv2/t+b0m6zeR5EEINGjzbFJxJukCyNP2mMBZMhXqRD5Fan24dfU4DJ2AX0xI6x0MrhHu0AiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkc1f8ChzBe6T300hKD/zTyUMxDjy7QNWiCC4CHeMWdtUZewmR
	E0pw1PeYABTKBg5wm/evbO2hRIfKyMuarK/LjnV/X7eXQI8hbArlUc32
X-Gm-Gg: ASbGncuJfXUsvRssFMatea6AboHWQA7tN13kim5vyvsW7SDd7Ll+qgk1m4DOSIBBqis
	BVjIFeAceP2twjW0jl5n0TIJQzXEgFWlnk7fJTUg8nXSzRJSD2joNToumH9lLCTrAg5qTzyRW8t
	PsPuCW2/FlC/11fNGjcZXImVUNC7dVBo8vHek5iDP7hGYKg7b0Naaxtc9jf4U/Pcd8lt5KwnNw/
	WaDNy/uAUuBWBkmv9NJP5kLYxj47xx32rJr0IUW713cdy32r/jAAUrrsfD/2gXHxns7NaDBTyOH
	oxfFmqXsFZCB+fAJmPAqSgxjNM0JMpszKi70DIrUCNUtPhlyBWQqql2jYkgCubxTK+nbacPjl+l
	PqDChcrFMlXRFDppTQ1UxuzPMeo4PMUf0B4AoUynm1jDm4A==
X-Google-Smtp-Source: AGHT+IEKCls9xRmVQxWCii9c//rw4jMsCwS1BlylPp9rfyCq4x4yoDzUiZV0Ig28KMI39hpJ+AZieg==
X-Received: by 2002:a17:906:4fc7:b0:b4a:e7c9:84c1 with SMTP id a640c23a62f3a-b50bcc1ad08mr3305454166b.7.1760531181849;
        Wed, 15 Oct 2025 05:26:21 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5fd784022dsm79184266b.14.2025.10.15.05.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 05:26:21 -0700 (PDT)
Date: Wed, 15 Oct 2025 05:26:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: saeedm@nvidia.com, itayavr@nvidia.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dcostantino@meta.com, kuba@kernel.org
Subject: Re: mlx5: CX7: fw_tracer: crash at mlx5_tracer_print_trace()
Message-ID: <uhlgxrlphs6cufrbm7mkp3nmtkrvhtoxbgd6rt7uojogfrbdoc@4mgzpab3dv3a>
References: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
 <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>

Hello Moshe,

On Wed, Oct 15, 2025 at 12:13:29PM +0300, Moshe Shemesh wrote:
> On 10/9/2025 3:42 PM, Breno Leitao wrote:
> >
> > My understanding that we are printf %s with params[0], which is 557514328 (aka
> > 0x213afe58). So, sprintf is trying to access the content of 0x213afe58, which
> > is invalid, and crash.
> > 
> > Is this a known issue?
> 
> Not a known issue, not expected, thanks for reporting.
> We will send patch to protect from such crash.

Thanks. how do you plan to protect it? I understand that the string is
coming from the firmware and the kernel is just using it in snprintf. Is
it right?

> Please send FW version it was detected on.

`ethtool -i` outputs:
	firmware-version: 28.44.2506 (FB_0000000030)

Thanks for your answer,
--breno

