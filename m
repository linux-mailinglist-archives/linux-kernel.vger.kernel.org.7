Return-Path: <linux-kernel+bounces-853374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E7EBDB6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7BA19A0291
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933E92BCF75;
	Tue, 14 Oct 2025 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OZnAGnK2"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E695270553
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477878; cv=none; b=b92Ywdre9PMEOD1gWfZX62Gt1JZ2RMdyCooNpVtuaC+7moUkfc1lA5amYWC4JaxoApkc1hQWJjAZNtCKkv8wZTXdVUiXYvGWuCuNoeu2WrmCMbVr0QAh1/OdddQCsI1Iizh1DoKyJTZGqdspBuO9jvRCY9aLkKsx7cR/wrVQUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477878; c=relaxed/simple;
	bh=piS00zxnBugSwhoxHMcXaIV2hi+ZI/OHRZjQ9grhoGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvY3+5PHEUxZ5bj7T+Ri5dRHUCxBrGKQz5b3enfqEPL7WhbNntIa/mVL696bMHtAeS7eHwQvL3iNzc66FBkwunURCBHXmxpgVwLQonS3bMWw5giBvBYxU0uLoU2ulZHj6DAmnGlWEElwPYFbamUNkKVQCdWk8ZWBqWxhDG4Lg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OZnAGnK2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso4938228a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760477875; x=1761082675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AyTGscSvzzBQZ1dL+z2bZb9/6VIeIzyyVfMBYWiIjnM=;
        b=OZnAGnK2ThDR3TH/y1tfXXtwnpkggJ9iMMfwNjPQ89yYOfWhxWP8QgTcH4IBluN+8S
         Qg1ge/mfd9OtqenwURaUBKKwaolxZXXFP+CnLKzVmwcEYr7it9ajhF5PpY3sWhtqHGd1
         hP3YrNcPrruI1gxLQy736afvnr1rBnOkWRwPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760477875; x=1761082675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyTGscSvzzBQZ1dL+z2bZb9/6VIeIzyyVfMBYWiIjnM=;
        b=aEp50+8g2+gD0ANlyA5bU/XWqLgh3fxCqG5C9JCDdWNa4I90To3u/ZM1CqZ78pbO5+
         tORmo/lhnxCObqPwaAT1CIgrkGQW4nsxhCntLmJPrSj1b5uhhYtuaZAlMyqUkhcvm4Xg
         SgqVlYvfnIZ9g8JkSZf5Z85RY3akUqvwKbLcMMHCeN/4Lj8tpEMoIfx4QYECyqrbR8h5
         l73LO8pdtsdR7sitZVrO6a7sYwLI3BKTTISo2aNOj/tYH7RbvGkGu74w58czHkqjqi1g
         yJAyVEXNRKzyIl+BArJQtxdP92FwSoirFb3OqIZnpAPqglY1/wzEgF+UQJBkDiYpmGK0
         ZXxA==
X-Gm-Message-State: AOJu0YyUR7cK/hIPzMY1FqT3+nqrAGNQh/tviCpV3GPuJwWR0o+GA8xq
	+TyBD8IPsmBEEEp0yoT805QJ9qIGKCIN7LttMTzj4H9CzW27fSFeUeVcPktVhFe4LV0n6og/SZU
	QmXVhMxA=
X-Gm-Gg: ASbGnctkcI9HGUgrhnYuh2rw/6QZt6U6/XvgfS3tQG/LfCaGBmH7DCZcyoFY/9/Skyi
	i2aDDZY28v43VhDflrrOLHrc5bjo/rVphpFWFl6WC8tf/RmWm5h5lolEr5dsM4uaKAjtZ7yva/o
	i9D3PW8lUkUvQpzbIiV/grOT6OvW5BEIVv3vBJvQl4arLPCxW9gP2RTevjg/iMoRDK0Noa2FKCI
	wbQDg8KpTmr/Zz9HK7iTnj/pMe3iJRF6POJ+YF7VssFdQbTKlSro8sORrvRLbzminI4Jeuu0R6Z
	FgOpmHGKcnmphb4ZYryhNwlQcXaEjxd2opNl5zVf/bTt0kDSNNtyd8na0xLmErjDrSJgZBOJqkD
	ZbF54E9ZGDk0pPneadpO7sFCPvdq5vSiu5oOYW4De4FxYzuCvp/5iIwI2Js+jdPp24z1S4ypj67
	Zb1qqQD15tvoE9uclj8K4BGP6aIQ==
X-Google-Smtp-Source: AGHT+IHx9bjt2VKFiNB+0ExLSkxoP2feMPvhlH9tClibsalk6SmC6rARzN+WAi30jbz3xW0+8vcAjw==
X-Received: by 2002:a05:6402:5248:b0:634:64b3:3900 with SMTP id 4fb4d7f45d1cf-639d5b6ae58mr24430208a12.9.1760477874649;
        Tue, 14 Oct 2025 14:37:54 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c3218a8sm12378828a12.40.2025.10.14.14.37.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 14:37:53 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso4938185a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:37:52 -0700 (PDT)
X-Received: by 2002:a05:6402:42d6:b0:639:dd3f:f25d with SMTP id
 4fb4d7f45d1cf-639dd3ff742mr20810290a12.7.1760477872570; Tue, 14 Oct 2025
 14:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014020604.684591-1-tytso@mit.edu>
In-Reply-To: <20251014020604.684591-1-tytso@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Oct 2025 14:37:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi52OZ642dxY=zdW+-nAY_KWtjsFs0mkAzzq74f65Da7w@mail.gmail.com>
X-Gm-Features: AS18NWDEiVmtrDLroNmquClyzUtFZL2Ce5a_STSsiMg-JNCG2CJwJoGEvqpwfDs
Message-ID: <CAHk-=wi52OZ642dxY=zdW+-nAY_KWtjsFs0mkAzzq74f65Da7w@mail.gmail.com>
Subject: Re: [PATCH] Use CONFIG_EXT4_FS instead of CONFIG_EXT3_FS in all of
 the defconfigs
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 19:06, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Commit d6ace46c82fd ("ext4: remove obsolete EXT3 config options")
> removed the obsolete EXT3_CONFIG options, since it had been over a
> decade since fs/ext3 had been removed.

Just checking: did you expect me to apply this directly, or was this
more of a "FYI" and it's in your tree and I should be expecting it as
a pull request?

          Linus

