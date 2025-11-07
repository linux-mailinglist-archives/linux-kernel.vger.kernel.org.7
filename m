Return-Path: <linux-kernel+bounces-891079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60564C41C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2BD3B7C3A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319D30EF9F;
	Fri,  7 Nov 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yzr0+uWX"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BE2D46CE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552244; cv=none; b=e1Hgtb6J9vmcmGe6gJ7Svj+HO4PGQO+te3OI0bzvEOKS9/ECC+nyv0jX8S9FXyHoUUUww0moprkwmFk8xqiyAL00gozG8i85/a1Nz6KPmNMRgKqma/WjZ67eZU1sacORSqo4tunshpSzI5j/hy53dUMWXG4zpmkfeakTMsmvNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552244; c=relaxed/simple;
	bh=pyLdhXK+e9aYqC0P31ccDopOnZF1MrhAcR9qbpwJoj8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=t67bW7XgAth/cbH3LF0lzf28wTZyJF3vkPR4M5k2VZnFsBRdkgb5egMAUNuIjwitR3AwNiUNnrW5dmbTBlvVjelq+qMzP/0dOfFe7zhsQM56nnbtjId/AF5aZI1RQbBhEToyGP9e8LQ5ysDhdRsiMh9oX2ySGF9qBjpbF/hnDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yzr0+uWX; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed9c1924adso6109271cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762552242; x=1763157042; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmoTkq/M8jICHPZ59r+DbNONIA6SHcI9Tq5Z/TFZHS4=;
        b=Yzr0+uWX9y8maaLAoumVIlQ25OBsnB6rkY/07veYawgHwfnBFux7WAkVFXqQennQ8t
         w3sGSjwqvEv7AMdWRYk8VVWWuwzvhBtJejwn21Wp67ceb8pIG4lnU+PYHquk2iD8R+ou
         9gQm4jc2X/r1RURMm9Vp/q/YBD/1T8uZVedTZuG2VL3c5EdGUVoGYaoCpgGoAJVxvm1M
         iIEzKd296L9G/7/I/7Eb+9hHXA+LhrVAYVdgHKEQVxeONpEgnUurxngk2XJbZFXRUilM
         /ZCcHuFNKTIgvZGttUsCMk9zc+L/ZvMkPLRRfirZNxQebFHnTGi0ffmUBhua1E9pkkRN
         6Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762552242; x=1763157042;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmoTkq/M8jICHPZ59r+DbNONIA6SHcI9Tq5Z/TFZHS4=;
        b=PBM+hq7rtcpZD8mx4lwzbNs8NqHdIESlrre+zw7tlcvC64Nqm8oV5fed3tOUKlUSo4
         TnSjSI5IIIRUoHI632B16rFa5v783zBuQOryT1HI0mFp7ZLyCLrFL9KnKd63r7Prle9O
         G3N5NueKXY2okzWLxnJF4m6V3S2FD9tjeN6qCoYVoylQB94CxWLWEPFESwk72UVkLZZl
         VK3OSr4fqrbHcgH6x5ZimuqDh6ZP/QCzHUqqNftZ0oIxTwzIDL/Qx2v9NOfmz1eHF8d+
         bkEYV1DXx6Nil/qR/aguauKc0D52LTGP1oJlWbInCwemoxSG9ChInCWALf4lpj6Dft/P
         rdLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT0RTOwomJlzmDJKgYE95D7oVWCA643YMm+tCHHRuEP7WaWGTPzq+UbXlzcG2QWIso4pcOfM/hNnJx05A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWaD71WaICS7uNOSiRW3I6eqm3nueXLiKXp5F97m+wTsIc3bGT
	xaFPCEZMC+A5V2ZL3cTJJZaTDvJbRmk4XBp0E7VXo7Zxs/11/qP0DYBz39pghnvZUA==
X-Gm-Gg: ASbGncsTsiJGsUfdavNPWVhjU5lc1uio3w0A/1eyl7w9hrfEBgil3Ljl4T9e/cTWec+
	xu0HbpXhYGlAwkKjFwrcMS+GUkBV3rmDO3PlDRjPNgUL29rxuuGeVJN6Jv8mYNApNtcEyXs0o4+
	lgvcnjGc1tBtJE2g85tWzePb38Vnv7hcREu7tK4eoE0G3EP+eFAx6+aHmo622/TIXCctXumb3rC
	CZTZMrg0umKH9OeTZFpFvqw/z0GUrdDFXCcJq/m3vXsx75peKh0wW/dyCPY88EXmkYIhMalnQk5
	LDgfTqAf537vi75gMMSVbJqYtNoSAMJzNdpCSyZBXUJIgbwqb/rl8mxtHeA9xG1oWcnX/HBKjQk
	Xk72bNSjs+G0pXDUolrJ+zr/djTrYR2HjscuZP9JuvwwM8ZL+GaLHtdE8SI60zi2GPHhT/kog0X
	h635qksp8m4MYWNsIUlRz8Gs+5ZFfPPbCCY0cVd8oXpCKelsDzuhkEqOf8
X-Google-Smtp-Source: AGHT+IGBsd98wCcuB1QNhGT9aKSRlEdnLcFa0mRVXHbfEi8hgtEWG9e4T8/HI0hMNHHgXfKIqunFKg==
X-Received: by 2002:ac8:5a0f:0:b0:4ec:eec7:4850 with SMTP id d75a77b69052e-4eda4f7ec78mr7855511cf.44.1762552242055;
        Fri, 07 Nov 2025 13:50:42 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823896818asm3361046d6.14.2025.11.07.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:50:41 -0800 (PST)
Date: Fri, 07 Nov 2025 16:50:40 -0500
Message-ID: <54043277138c6499c0ced9bbdcae7cf5@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251107_1632/pstg-lib:20251106_1733/pstg-pwork:20251107_1632
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v3] audit: merge loops in __audit_inode_child()
References: <20251031123328.1758743-1-rrobaina@redhat.com>
In-Reply-To: <20251031123328.1758743-1-rrobaina@redhat.com>

On Oct 31, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Whenever there's audit context, __audit_inode_child() gets called
> numerous times, which can lead to high latency in scenarios that
> create too many sysfs/debugfs entries at once, for instance, upon
> device_add_disk() invocation.
> 
>    # uname -r
>    6.18.0-rc2+
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m46.676s
>    user 0m0.000s
>    sys 0m46.405s
> 
>    # perf record -a insmod loop max_loop=1000
>    # perf report --stdio |grep __audit_inode_child
>    32.73%  insmod [kernel.kallsyms] [k] __audit_inode_child
> 
> __audit_inode_child() searches for both the parent and the child
> in two different loops that iterate over the same list. This
> process can be optimized by merging these into a single loop,
> without changing the function behavior or affecting the code's
> readability.
> 
> This patch merges the two loops that walk through the list
> context->names_list into a single loop. This optimization resulted
> in around 51% performance enhancement for the benchmark.
> 
>    # uname -r
>    6.18.0-rc2-enhancedv3+
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m22.899s
>    user 0m0.001s
>    sys 0m22.652s
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 43 +++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)

Looks good to me, merged into audit/dev, thanks!

--
paul-moore.com

