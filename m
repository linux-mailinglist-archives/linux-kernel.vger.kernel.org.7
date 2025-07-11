Return-Path: <linux-kernel+bounces-728344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A072B026FB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6766E4A10ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C57223327;
	Fri, 11 Jul 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PCDlkVPp"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D99221FDD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752273370; cv=none; b=MrepLgzUP9gEZIVAu3XdFXnRYjHX9pRafQlmj+ZfO3+TURIeZCY6jhHFG3TDcuoITsIWmyqhmCfr8ukAK7AtexoyaztjRu9BXNf/zcR4vN+A6eXXufkmTPpvoaaHHD0Zrm7NJV0ohIQFDZpr7MIVnubFVS+WyNbp+L+dwo7loog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752273370; c=relaxed/simple;
	bh=VvTwpYTJ6MeGpD/+57OCgrd7w2qY7aibk0SWMCUOT70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxCIfa9ULLFRV9847MtQVR+aRnXRcqRSgszDsGRgppnXDrwPDUO4+qErjihrzZz7qMJqS3J/fxhTM9fJ+sAzAa7hdAxpDIKuq/n8FEZrpSoTPfc3X3+JHqpu0XlHponauiNt1xxjr8+IxFozWtge4jiBi59oGkwIAFV38WpdCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PCDlkVPp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fac7147cb8so36443926d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752273367; x=1752878167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6jEezWUjvICh7/WW/Ivp+Swoo1QztjCMy3V/+iaOS4=;
        b=PCDlkVPpd/WtdaAq9vJw/9zRSf+kB2eUVHmV+FQcRhkARfqifVtn3CjCtRVHFaDBIT
         kmoummMcGb2T7T0oaH5G6QezXqX2+WR39voR8iRwcryIrM1SvyKiBCq7D98MPA9zFQIT
         XE22WMMBL83SL/X5VGHAobT9hHkmhMJllimOjAZu/UvMsPQJVgkeNQfdQEk5tfdLPaIX
         yNNHMQw0sxOwrjcW0hDNWGx/srBX0DJNRfhfCDl+JrDhlcYM2YrOAX4QZLF9+0RUHSBq
         aua+Yf4E1K6UaB8fEy5cNIaW4omw+b3lwEEcLZe19M2+k3QYEXard8/MczF2lHAnAgmD
         djMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752273367; x=1752878167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6jEezWUjvICh7/WW/Ivp+Swoo1QztjCMy3V/+iaOS4=;
        b=Cd5X4jklV5XdVOukl9Y5v9Ub3TE/XAMReCOtUo/NG3tiBvMq1jTHS6p7QIXMPLxrRo
         lFPQiJfOoOsLAOLZddLS44iYN9rZAoxOl7K0dLF0n+yQvqWIc3gL5qZoDfIxR+9ChSTN
         BxgA3t+IVgXR3TytJHS5hu4SyVsWynRuWsS9+Gs1oolAYWQ+HKxctwdZAB0En72FtcWj
         3ODxJ2K/znsfytDH3GH1tY4Uyg32+S/Zh+4lYFv+IkI0FycrhceIrvSkRSbdE0ICOV3S
         n+V3rQFnK9KVsvGbkuwSLmD2tUA1BLUD65bhDH5kQaoGdB6xHNPrWp79M4Tm5raO5VT0
         lRIA==
X-Forwarded-Encrypted: i=1; AJvYcCWr2fUg1xyY9ekFuOYQIUSZJf0/3FrH4/s19ewdKVqd4wx6Fsq4Tm6RbcWJ7iHbhCUypg51Dg3GY7YSQzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhOjwlUvblfcb12OfGeC1J0UBDEiJ5uNd8g/CsS+6B9fAEfPe
	CfV28lBEoQUmBR2+m0K4tgmPVcicdzS3srcoOVC3+huDqT7+k6g6bixoKHlTXntF35M=
X-Gm-Gg: ASbGncvIDOvjzOkfE8oZGwMA1uTZF96iy6zYjSMWZG0LPrJnIJmk+c0+uV/Nk/Gu5Nx
	JvTuzFBEfc1OAlHtFbGH2QTxD6lVgab0UmfF1GAUX/+cIrlC07Tx4/V99K3ku2xWbe1mM3AGVXk
	wwx234MN+GMzjIlncQ36CAOkslHao8LgiroupKhcHtjOOY/3j3zdz0/7/CSjCnIJoR6aLbJbf6+
	5m97qEQAB24dBNmyHGKvEmWAaDkUnSiQ/+ttNT6KoSlKDS1cDIXX7LfvNMjvhB3dTx8iFygXtRb
	0yrQ/CQiq1kEPFBgb2lVOLwPGtFTFmKqgyKcTxXRjZmY3NezMBTgmeZm/O3OtKsVL1U4IHLFHgN
	KZxIJZ5WmjL3YePWfTtotNcNZTVI5B5+rZoq8U1joMMdlLZfBlaNzxXeJ+25yrVeRJw8yuUvAoA
	==
X-Google-Smtp-Source: AGHT+IHcy1eXPnyRzznoEf2npXkMyCOaTtdOXhPkzHUHvNfiFnAiR4oHyRzA4NVeqBX+We1cjFjHFg==
X-Received: by 2002:a05:6214:2e8a:b0:704:ac9b:f69b with SMTP id 6a1803df08f44-704ac9bf745mr39098586d6.3.1752273367266;
        Fri, 11 Jul 2025 15:36:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39728sm24160086d6.79.2025.07.11.15.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:36:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uaMLd-00000008LmF-3pds;
	Fri, 11 Jul 2025 19:36:05 -0300
Date: Fri, 11 Jul 2025 19:36:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: lizhe.67@bytedance.com, akpm@linux-foundation.org, david@redhat.com,
	peterx@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 2/5] vfio/type1: optimize vfio_pin_pages_remote()
Message-ID: <20250711223605.GE1870174@ziepe.ca>
References: <20250710085355.54208-1-lizhe.67@bytedance.com>
 <20250710085355.54208-3-lizhe.67@bytedance.com>
 <20250711153523.42d68ec0.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711153523.42d68ec0.alex.williamson@redhat.com>

On Fri, Jul 11, 2025 at 03:35:23PM -0600, Alex Williamson wrote:
> Don't resend, I'll fix on commit, but there's still a gratuitous
> difference in leading white space from the original.  Otherwise the
> series looks good to me but I'll give Jason a little more time to
> provide reviews since he's been so active in the thread (though he'd
> rather we just use iommufd ;).  Thanks,

It looks fine, I'm happy not to see any folio magic in vfio for this.

Would be nice to see scatterlist use the new helper too

Jason

