Return-Path: <linux-kernel+bounces-777022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DAFB2D42E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B7B588431
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC0A2C15A6;
	Wed, 20 Aug 2025 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="db+c5rxB"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268518FC97
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672249; cv=none; b=VgNNRAufk+asPfak6AThUAXsdnsjuO/7JqnciG8EepTxBOJj/SmVqx2pRkaxKz0RBk+nGb0fZYOK6Im0ZuTtec3g+nghIan4TUG6he8dDKNXiD3VEllj0j4Ca9xdrs+jf6ughBfOyGN78vIFIahqDZRdgf26tHRXtEgeveFF6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672249; c=relaxed/simple;
	bh=UjDTQRoZv2JpQyn5jVZSc5/MkQKOuSnET32nSBAvZlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgtZem11oYxcw/jXPv7pWQ7cr3gzO9yUaeUyxJP0bRBrddGjhEnTIB/Kbhfy93dO1CGajOVtG88fEpEFwQBywP3yJVKWamqaMPEGATRGOVipX3tYHSr6XytR9JDizNmUdZ7oKq6bJea9l1xZA2F9zwzAyd/q6WGnu8NzbA523fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=db+c5rxB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9ba300cb9so397717f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755672246; x=1756277046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ca+sHHJfBtLlYCIIifJPFcIpqB60osm+WWWvfSezYso=;
        b=db+c5rxBqNHUPpuBR6k533kXKBLjr1M8enkL2wGo1mW4IquRBG+JFyh1OqFyvjcwzR
         ZZqTJkgcqTdFEkehDZKjfYW5kO8it2Ica4YrD1M2pdgQNMGdyigKvBIIca6qx2adK2To
         DgwEFc3gm1Kp0hGitsX1goBQyCLcnrbMMLPoOFPOr2zXXo/8FB5BqEAs+Cq2N6PswTQ8
         9coPCKLxwf4REvw3yoPRqmT+y8nOw+bMYEkS3sq8qxL8s0OUO/kKU47S8y5PqZLGJe0C
         lEJYTQOnU4fxQPw+NnisCUae/XpsmPZyfDeBJNgLMeTSTpJFIyNGJu33hGQyU2Zi3Azj
         XzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672246; x=1756277046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ca+sHHJfBtLlYCIIifJPFcIpqB60osm+WWWvfSezYso=;
        b=ZHuqY3YU0aMRk8hsThJxkozI3p3ijE29drOdocNPEeA7hAMZBBaVZ0DvF10x4A2RCP
         VDPsb/GKVw/SsmnxC9lEWBqTJDyeOjox/0DUCNAw7UWj5ms32B2qiG/WTH9067Sjp0rc
         gHYmz0o9kkkCR0yogRUkAuVceWfQRp4bewkFLeNmuWocbNi+Uzq25ZHWgyvwUodWGJj1
         JYUnH+oCdxnSsDaGXgP6qjqBaXdpiE4GiZloQv97ox8zk3jITX7AXe5q1+DRVZqnQOZv
         38m+DX4krhGKCi3kBvbQcCZ8uMqUWr5P9XLRtAypa8qCyPeRNO7gazYFjSdYSp4LueTE
         znjw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8nK5tmjxxc+Ig2ZHF6vzcLD4A04X1/WIn7AtZjs7SQmC8wod2FnC2LYqrZIbvHSlAM+8WBf6cj3Nn58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1s4zcaWHjQWZw8voqma3zCBnacIo+TMDu0WT3x/Oa6dp9zTU
	7gKXcu5s0Bt9BGrIeSGdURFF5mTLCDf9sWGCmWyZdB9tEWTH0u2oZAxrrVFG59qRMWc=
X-Gm-Gg: ASbGncv7WHGdmlXu284CBwCFFZglcWyXvlWma1az62ar7rw8gQAlOJg4rS/KzjZLGEl
	Yu3Qp0O7fB/2YdyzPklIG35mvi+QCr8jcHnsQXPOezfTzj1R5XxFV0yGUlQBJUX07f1AsqxdBQS
	j/5Alw2E+CyQy5MLTYnm10WbLQtN0i9MHpGsqpr+g+rIoL14SERqchtbu1KQwjZfQ6gd1W0tPpM
	Mp6seHx8YweTyLjBD98aibJo2dPLisDfryshE2scIgu2XDGZ3I3kiCWBAW9/PI0uoCwa0x7x4Fv
	ZKnXGswdW5sEKH5KsWwdc1efAEipHdH8rX8hqk/+IH13RGT3dnIqVmlalo8fyWKU7BeEKuKh93g
	VNBAa2nAROxphgtPQ6sDEw45+0EBxDSYlMcQjCStTLgw=
X-Google-Smtp-Source: AGHT+IEbdnNwo4oJeDPciQ8EIBQEmtCB3Kmp9sG6xxzro0qvoVfD68XvPSQhTVIjeim78/KydRRKRA==
X-Received: by 2002:a05:6000:40ca:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3c3147b50b6mr1512172f8f.14.1755672246117;
        Tue, 19 Aug 2025 23:44:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0777884e8sm6939837f8f.45.2025.08.19.23.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 23:44:05 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:44:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?B?xaBlcmlm?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkp@intel.com
Subject: Re: [PATCH v2] ALSA: usb-audio: us144mkii: Fix null-deref in
 tascam_midi_in_urb_complete()
Message-ID: <aKVusmJ-sE1sgZVV@stanley.mountain>
References: <20250819185133.10464-1-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819185133.10464-1-ramiserifpersia@gmail.com>

Awesome.  Thanks!

regards,
dan carpenter


