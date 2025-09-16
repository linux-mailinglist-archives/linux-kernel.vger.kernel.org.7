Return-Path: <linux-kernel+bounces-818682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE719B59511
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFAD3246A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE692D7DEC;
	Tue, 16 Sep 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GU84kVvd"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4E2D7809
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021814; cv=none; b=FLE13ZMclSuNvnXfeevILDUtlj8yh/8d2Jp8HnUZNVyVjiaSpuKVVTTwMxQ3xVdjf1MG3KE9bsaqxJw55Wj6M+vZyLZljLfY9ZUEum7PhZ1cqvO5bk5wcxPP1CTuh1bVO/gv6V6d2CWAptttl4+b5bTCE+C1UfvRB+TdnWlfvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021814; c=relaxed/simple;
	bh=Gjb8euWhpxYPXfp/FaJb+FpWV2lF87I07NelregEU0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj3tmI/RT/2PcRmjeGtuzhcueY2Dy6zDLFcKupO4kkQ7Xhb9yc36kEbatR2trt7LfRuVRiHhtMjMH+c6pC4Ph/BubvTF2DGjVF5xNyysQ5dc50hWo1Z3j7L7B9I/bUJxQA6TeT0pAseI8tbeIqkSocaqLQ5jS0qtA5Nbtq+9qsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GU84kVvd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7322da8so286440766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021811; x=1758626611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxtZUSssqP8QQ4xDjcwfBCGzgO78XtwgCRIXLf8n188=;
        b=GU84kVvdmi+t3YvgzOqWiakAstZsra7MM6IDccRx2ap8XaT+vCnYDlUyVTaKv2kq9P
         qR1Np0ODMticDk2YaRADHLhIvy3yz/axKDfRgGvzgML4DrkJYWrE4cs3BJ64+lSNSucT
         Yh6W+L3jFBlRKPibe9erSnKEQ48nJylcr6bRIMLkDXwUlPt9uFpssVatbBxSu6OOfKdf
         bG2M1xUX2SMBfjNESOMsOIYatFlHlH3XQhpe/56XBUVgqpaRQFvcz4HHYLit9zfv263A
         Z9+VAmPNtOJfHvVvdVr6Zn7S/yUU/hrID+sFO8hrkiPqGJ7t7909kJl4Oicri+BdHl25
         Xkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021811; x=1758626611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxtZUSssqP8QQ4xDjcwfBCGzgO78XtwgCRIXLf8n188=;
        b=onpznpqjkXCZaL3+K6GJMDQ19qX8eGDfKn6mLxcj49nXiStLstfHL1zoe1FahqP7oL
         qCIKC+oOLUg+u30Vi8MP0oNOOAJa1SYYKcKiZ2s8eDfUGmPp7/TTFgD3ctbXBw9CK9ju
         2W5sAVyRKv9tad6y/hjEAtJmjARELo5JNbKqN17tboiAc9WEOdn8ivdeFR/0xXz0Zdz1
         0UotYPV0h93TUROMc1y9Qb0iLrVwpg2XaUqjvRMA+bi/Lm7lD/vMPjK9bwFsedewCGH8
         BQ11O24cgAior4CoutxKyxAgXqYEXESbKe2+8StCOpT3j0OY09Yeb/LpMX9HEOgXzvze
         JYag==
X-Forwarded-Encrypted: i=1; AJvYcCX5D+iAa5YkIh8EAF1YW613cQR8bC1G+0nVa8oUx+GmLA5eoVdWxuzjUczpmwnSEtNSUmktNOYlDP1mjK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBmakJhMOIXpI3tFUH1hyVrq8vAJzy5uzstgkUXaci3Td6s+U
	8VAxMoY4BidNoDM7Gj2eA7Gl9y45J8tOmMe7MLXCapi6T6qHIdHgOhX+lLROSK9fM5k=
X-Gm-Gg: ASbGncsWhe56RFxwTq1RAyAEALb/ptz53eGCJ9To1zYLA/H6LT4tLOvDme4gWUY6a6N
	zUt5f9W1WrxZfk3r6PdkcaUKPhLrhx6lFnRRVmoAbXISYgqah+wWfgeHeZ5xTdixfh5NrtHH4wx
	bcZNHL1bAqyKpY/EpytAHm1L8kPRO+DFdl/nIFBOAKQqhMuRgv5yKOYQjJ+Ac03PDNaWvRrVmCS
	8JhAiSws8Y/9TDZMayAeHhFt6xtqqCJGO1o0iNZUcFcywRmJxZKbXHA0CZ0BerP2GtCFEB/8tXX
	Z3XsDEtq87ev2yvuQkCbe/l+t40XjqOTXcl3DMgTlH2deC/85CNsMxmcxSQJAcW8Vi1gYl37ABZ
	fZ5L/gFU7+8xdeX5mJl/OgK9kQ1VxZjEY6gLtpvlO
X-Google-Smtp-Source: AGHT+IHpyTR/3eF3SMuNwTyjqfOeFBdU6maF0JBSLHjxTUYrHkZ3Z43YeF6fl1FdRdLJxJTI3BmjLQ==
X-Received: by 2002:a17:907:7e83:b0:ad5:d597:561e with SMTP id a640c23a62f3a-b07c3a7bd75mr1672253566b.56.1758021811303;
        Tue, 16 Sep 2025 04:23:31 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd5a9sm1125541966b.57.2025.09.16.04.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:23:30 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:23:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Zsolt Kajtar <soci@c64.rulez.org>, Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] panic/printk: replace other_cpu_in_panic() with
 panic_on_other_cpu()
Message-ID: <aMlIsOH1dirXjrE1@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-9-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-9-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:36, Jinchao Wang wrote:
> The helper other_cpu_in_panic() duplicated logic already provided by
> panic_on_other_cpu().
> 
> Remove other_cpu_in_panic() and update all users to call
> panic_on_other_cpu() instead.
> 
> This removes redundant code and makes panic handling consistent.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

